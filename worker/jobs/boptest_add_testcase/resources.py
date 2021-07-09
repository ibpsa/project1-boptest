########################################################################################################################

# -*- coding: utf-8 -*-
from __future__ import print_function

import json
import os
import tarfile

import boto3
from pymongo import MongoClient
from redis import Redis


class Resources:
    """Create connections to data resources"""

    def __init__(self):
        """
        boto3 is the AWS SDK for Python for different types of services (S3, EC2, etc.)
        """
        # boto3
        self.s3 = boto3.resource('s3', region_name=os.environ['REGION'], endpoint_url=os.environ['S3_URL'])
        self.s3_bucket = self.s3.Bucket(os.environ['S3_BUCKET'])

        # Redis
        self.redis = Redis(host=os.environ['REDIS_HOST'])
        self.redis_pubsub = self.redis.pubsub()

        # Mongo
        self.mongo_client = MongoClient(os.environ['MONGO_URL'])
        self.mongo_db = self.mongo_client[os.environ['MONGO_DB_NAME']]
        self.mongo_db_recs = self.mongo_db.recs
        self.mongo_db_write_arrays = self.mongo_db.writearrays
        self.mongo_db_sims = self.mongo_db.sims

        # BOPTEST specific
        self.mongo_db_inputs = self.mongo_db.inputs
        self.mongo_db_measurements = self.mongo_db.measurements
        self.mongo_db_testcases = self.mongo_db.testcases

    def add_boptest_inputs_to_mongo(self, boptest_inputs, site_ref):
        data = {'site_ref': site_ref, 'inputs': boptest_inputs}
        self.mongo_db_inputs.insert_one(data)

    def add_boptest_measurements_to_mongo(self, boptest_measurements, site_ref):
        data = {'site_ref': site_ref, 'measurements': boptest_measurements}
        self.mongo_db_measurements.insert_one(data)

    def add_boptest_testcase_to_mongo(self, site_ref, name, step, scenario):
        data = {'site_ref': site_ref, 'name': name, 'step': step, 'scenario': scenario}
        self.mongo_db_testcases.insert_one(data)

    def add_boptest_testcase_to_filestore(self, bucket_parsed_site_id_dir, site_ref):
        """
        Attempt to add to filestore.  Two exceptions are caught and returned back:
        1. S3 upload error
        2. File not found error
        :param bucket_parsed_site_id_dir: directory to upload to on s3 bucket after parsing: parsed/{site_id}/.
        :param site_ref: id of site
        :return: one of two options:
            1. True, parsed tarball upload location
            2. False, error thrown
        """
        # get the id of site tag(remove the 'r:')
        if site_ref:
            def reset(tarinfo):
                tarinfo.uid = tarinfo.gid = 0
                tarinfo.uname = tarinfo.gname = "root"

                return tarinfo

            tarname = "{}.tar.gz".format(site_ref)
            tar = tarfile.open(tarname, "w:gz")
            tar.add(bucket_parsed_site_id_dir, filter=reset, arcname=site_ref)
            tar.close()

            upload_location = "parsed/{}".format(tarname)
            try:
                self.s3_bucket.upload_file(tarname, upload_location)
                return True, upload_location
            except boto3.exceptions.S3UploadFailedError as e:
                return False, e
            except FileNotFoundError as e:
                return False, e
