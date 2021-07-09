from __future__ import print_function

import glob
import os
import shutil
import sys
import tarfile
from subprocess import call
import json

from boptest.lib.testcase import TestCase

from .logger import Logger
from .resources import Resources

class Job:
    """A wrapper class around adding sites"""

    def __init__(self, parameters):
        """
        Initialize with parameters
        """

        self.logger = Logger().logger
        self.file_name = parameters.get('osmName')
        self.upload_id = parameters.get('uploadID')
        self.bucket_parsed_site_id_dir = os.path.join('/parse', self.upload_id)
        self.name, self.file_ext = os.path.splitext(self.file_name)
        self.key = "uploads/%s/%s" % (self.upload_id, self.file_name)

        # Define FMU specific attributes
        self.fmu_path = os.path.join(self.bucket_parsed_site_id_dir, 'model.fmu')

        self.resources = Resources()

    def run(self):
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
            self.logger.error("Unsupported file extension: {}".format(self.file_ext))
            os.exit(1)

    def add_to_mongo_and_filestore(self):
        """
        Attempt upload to mongo and filestore.  Function exits if not uploaded correctly
        based on expected return values from methods in Connections.
        :return:
        """
        tc = TestCase(self.fmu_path)
        inputs = tc.get_inputs()
        measurements = tc.get_measurements()
        step = tc.get_step()
        scenario = tc.get_scenario()

        self.resources.add_boptest_inputs_to_mongo(inputs, self.upload_id)
        self.resources.add_boptest_measurements_to_mongo(measurements, self.upload_id)
        self.resources.add_boptest_testcase_to_mongo(self.upload_id, self.name, step, scenario)
        self.resources.add_boptest_testcase_to_filestore(self.bucket_parsed_site_id_dir, self.upload_id)

        # Clean local directory
        shutil.rmtree(self.bucket_parsed_site_id_dir)

    def add_fmu(self):
        """
        Workflow for fmu.  External call to python2 must be made since currently we are using an
        old version of the Modelica Buildings Library and JModelica.
        :return:
        """
        if not os.path.exists(self.bucket_parsed_site_id_dir):
            os.makedirs(self.bucket_parsed_site_id_dir)
        self.resources.s3_bucket.download_file(self.key, self.fmu_path)

        self.add_to_mongo_and_filestore()
