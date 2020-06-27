########################################################################################################################

# -*- coding: utf-8 -*-
from __future__ import print_function

import json
import os
import tarfile

import boto3
from pymongo import MongoClient
from redis import Redis


class AlfalfaConnections:
    """Create connections to data resources for Alfalfa"""

    def __init__(self):
        """
        boto3 is the AWS SDK for Python for different types of services (S3, EC2, etc.)
        """
        # boto3
        self.sqs = boto3.resource('sqs', region_name=os.environ['REGION'], endpoint_url=os.environ['JOB_QUEUE_URL'])
        self.sqs_queue = self.sqs.Queue(url=os.environ['JOB_QUEUE_URL'])
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

    def add_site_to_mongo(self, haystack_json, site_ref):
        """
        Upload JSON documents to mongo.  The documents look as follows:
        {
            '_id': '...', # this maps to the 'id' below, the unique id of the entity record.
            'site_ref': '...', # for easy finding of entities by site
            'rec': {
                'id': '...',
                'siteRef': '...'
                ...other Haystack tags for rec
            }
        }
        :param haystack_json: json serialized Haystack document
        :param site_ref: id of site
        :return: pymongo.results.InsertManyResult
        """
        with open(haystack_json) as json_file:
            data = json.load(json_file)

        if site_ref:
            array_to_insert = []
            for entity in data:
                array_to_insert.append({
                    '_id': entity['id'].replace('r:', ''),
                    'site_ref': site_ref,
                    'rec': entity
                })
            response = self.mongo_db_recs.insert_many(array_to_insert)
            return response

    def add_site_to_filestore(self, bucket_parsed_site_id_dir, site_ref):
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
