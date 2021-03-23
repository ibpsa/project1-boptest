from __future__ import print_function

import glob
import os
import shutil
import sys
import tarfile
import zipfile
from subprocess import call
import json

# Local
from boptest.add_site.add_site_logger import AddSiteLogger
from boptest.lib import make_ids_unique, replace_site_id
from boptest.lib.alfalfa_connections import AlfalfaConnections
from boptest.lib.test_config import get_test_config
from boptest.lib.testcase import TestCase

class AddSite:
    """A wrapper class around adding sites"""

    def __init__(self, fn, up_id):
        """
        Initialize.
        :param fn: name of file to submit
        :param up_id: upload_id as first created by Upload.js when sending file to file s3 bucket (addSiteResolver)
        """
        self.add_site_logger = AddSiteLogger()
        self.add_site_logger.logger.info("AddSite called with args: {} {}".format(fn, up_id))
        self.file_name = fn
        self.upload_id = up_id
        self.bucket_parsed_site_id_dir = os.path.join('/parse', self.upload_id)
        _, self.file_ext = os.path.splitext(self.file_name)
        self.key = "uploads/%s/%s" % (self.upload_id, self.file_name)

        # Define FMU specific attributes
        self.fmu_path = os.path.join(self.bucket_parsed_site_id_dir, 'model.fmu')
        self.fmu_json = os.path.join(self.bucket_parsed_site_id_dir, 'tags.json')

        # Create connections
        self.ac = AlfalfaConnections()

        # Needs to be set after files are uploaded / parsed.
        self.site_ref = None

    def main(self):
        """
        Main entry point after init.  Adds site based on file ext.  Worfklow is generally as follows:
        1. Download file from s3 bucket
        2. Ingest model file and add tags
        3. Send data to mongo and s3 bucket
        4. Remove files generated during this process
        :return:
        """
        if self.file_ext == '.fmu':
            self.add_fmu()
        else:
            self.add_site_logger.logger.error("Unsupported file extension: {}".format(self.file_ext))
            os.exit(1)

    def extract_workflow_tar(self):
        """
        Extract workflow tarball into this directory
        :return:
        """
        tar = tarfile.open("workflow.tar.gz")
        tar.extractall(self.bucket_parsed_site_id_dir)
        tar.close()

    def get_site_ref(self, haystack_json):
        """
        Find the site given the haystack JSON file.  Remove 'r:' from string.
        :param haystack_json: json serialized Haystack document
        :return: site_ref: id of site
        """
        site_ref = ''
        with open(haystack_json) as json_file:
            data = json.load(json_file)
            for entity in data:
                if 'site' in entity:
                    if entity['site'] == 'm:':
                        site_ref = entity['id'].replace('r:', '')
                        break
        return site_ref

    def os_files_final_touches_and_upload(self):
        """
        Make unique ids and replace site_id.  Upload to mongo and filestore.
        :return:
        """

        """ When ids are generated from a user provided file they might not be unique,
        the purpose of this function is to ensure uniqueness
        """
        make_ids_unique(self.upload_id, self.report_haystack_json, self.report_mapping_json)
        replace_site_id(self.upload_id, self.report_haystack_json, self.report_mapping_json)

        # Upload to mongo & filestore, clean local directory
        self.add_to_mongo_and_filestore()

    def add_to_mongo_and_filestore(self):
        """
        Attempt upload to mongo and filestore.  Function exits if not uploaded correctly
        based on expected return values from methods in AlfalfaConnections.
        :return:
        """
        f = self.fmu_json
        self.site_ref = self.get_site_ref(f)

        get_test_config(self.fmu_path)
        tc = TestCase()
        inputs = tc.get_inputs()
        self.ac.add_boptest_inputs_to_mongo(inputs, self.site_ref)
        measurements = tc.get_measurements()
        self.ac.add_boptest_measurements_to_mongo(measurements, self.site_ref)
        step = tc.get_step()
        scenario = tc.get_scenario()
        self.ac.add_boptest_testcase_mongo(self.site_ref, step, scenario)

        # Check mongo upload works correctly
        mongo_response = self.ac.add_site_to_mongo(f, self.site_ref)
        if len(mongo_response.inserted_ids) > 0:
            self.add_site_logger.logger.info('added {} ids to MongoDB under site_ref: {}'.format(len(mongo_response.inserted_ids), self.site_ref))
        else:
            self.add_site_logger.logger.warning('site not added to MongoDB under site_ref: {}'.format(self.site_ref))
            sys.exit(1)

        # Check filestore upload works correctly
        filestore_response, output = self.ac.add_site_to_filestore(self.bucket_parsed_site_id_dir, self.site_ref)

        # Clean local directory
        shutil.rmtree(self.bucket_parsed_site_id_dir)
        if filestore_response:
            self.add_site_logger.logger.info(
                'added to filestore: {}'.format(output))
        else:
            self.add_site_logger.logger.warning('site not added to filestore - exception: {}'.format(output))
            sys.exit(1)

    def add_fmu(self):
        """
        Workflow for fmu.  External call to python2 must be made since currently we are using an
        old version of the Modelica Buildings Library and JModelica.
        :return:
        """
        self.add_site_logger.logger.info("add_fmu for {}".format(self.key))

        if not os.path.exists(self.bucket_parsed_site_id_dir):
            os.makedirs(self.bucket_parsed_site_id_dir)
        self.ac.s3_bucket.download_file(self.key, self.fmu_path)

        # External call to python2 to create FMU tags
        call(['python', '/boptest/lib/fmu_create_tags.py', self.fmu_path, self.file_name, self.fmu_json])

        self.add_to_mongo_and_filestore()


if __name__ == "__main__":
    args = sys.argv
    body = json.loads(sys.argv[1])
    file_name = body.get('osmName')
    upload_id = body.get('uploadID')

    adder = AddSite(file_name, upload_id)
    adder.main()
