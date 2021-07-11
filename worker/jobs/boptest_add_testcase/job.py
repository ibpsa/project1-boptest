from __future__ import print_function

import glob
import os
import shutil
import sys
import tarfile
import boto3
import json
from pymongo import MongoClient
from subprocess import call
from boptest.lib.testcase import TestCase
from .logger import Logger

class Job:
    """A wrapper class around adding sites"""

    def __init__(self, parameters):
        """
        Initialize with parameters
        """

        self.logger = Logger().logger
        self.key = parameters.get('key')
        self.testcaseid = parameters.get('testcaseid')

        self.fmu_dir = "/parse/%s" % self.testcaseid
        self.fmu_path = os.path.join(self.fmu_dir, "%s.fmu" % self.testcaseid)

    def download_file(self):
        if not os.path.exists(self.fmu_dir):
            os.makedirs(self.fmu_dir)

        s3 = boto3.resource('s3', region_name=os.environ['REGION'], endpoint_url=os.environ['S3_URL'])
        s3_bucket = s3.Bucket(os.environ['S3_BUCKET'])
        s3_bucket.download_file(self.key, self.fmu_path)

    def add_to_db(self):
        tc = TestCase(self.fmu_path)
        inputs = tc.get_inputs()
        measurements = tc.get_measurements()
        step = tc.get_step()
        scenario = tc.get_scenario()

        mongo_client = MongoClient(os.environ['MONGO_URL'])
        mongo_db = mongo_client[os.environ['MONGO_DB_NAME']]

        dbfilter = {
            'testcaseid': self.testcaseid
        }
        data = {
            'testcaseid': self.testcaseid, 
            'step': step,
            'scenario': scenario,
            'inputs': inputs,
            'measurements': measurements
        }
        mongo_db.testcases.replace_one(dbfilter, data, upsert=True)

        # Clean local directory
        shutil.rmtree(self.fmu_dir)

    def run(self):
        self.download_file()
        self.add_to_db()
