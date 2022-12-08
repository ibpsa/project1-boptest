########################################################################################################################
#  Copyright (c) 2008-2018, Alliance for Sustainable Energy, LLC, and other contributors. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
#  following conditions are met:
#
#  (1) Redistributions of source code must retain the above copyright notice, this list of conditions and the following
#  disclaimer.
#
#  (2) Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
#  disclaimer in the documentation and/or other materials provided with the distribution.
#
#  (3) Neither the name of the copyright holder nor the names of any contributors may be used to endorse or promote products
#  derived from this software without specific prior written permission from the respective party.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) AND ANY CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
#  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER(S), ANY CONTRIBUTORS, THE UNITED STATES GOVERNMENT, OR THE UNITED
#  STATES DEPARTMENT OF ENERGY, NOR ANY OF THEIR EMPLOYEES, BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
#  USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
#  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
########################################################################################################################

# -*- coding: utf-8 -*-
from __future__ import print_function

import json
import os
import subprocess
import sys
from datetime import datetime
import boto3
from .logger import Logger
from kubernetes import client, config

class Worker:
    """The main Worker class.  Used for processing messages from the boto3 SQS Queue resource"""

    def __init__(self):
        self.logger = Logger().logger
        self.sqs = boto3.resource('sqs', region_name=os.environ['REGION'], endpoint_url=os.environ['JOB_QUEUE_URL'])
        self.sqs_queue = self.sqs.Queue(url=os.environ['JOB_QUEUE_URL'])
        self.logger.info("Worker initialized")
  

    def process_message(self, message):
        """
        Process a single message from Queue.

        :param message: A single message, as returned from a boto3 Queue resource
        :return:
        """
        message_body = json.loads(message.body)
        message.delete()
        jobtype = message_body.get('jobtype')
        params = message_body.get('params')
        subprocess.call(['python', '-m', jobtype, json.dumps(params)])
    
    def _update_k8s(self, pod_deletion_cost):
        """
        Update k8s pod status when job is running. This is to prevent a pod from being 
        terminated during the downscale that is still processing a job.

        :param pod_deletion_cost:  String that represents the cost of deleting a 
        pod compared to other pods belonging to the same Deployment/Replicaset. e.g. "10". 
        :return:
        """
        try:
            config.load_incluster_config()
            v1 = client.CoreV1Api()
            pod = v1.read_namespaced_pod(name=os.environ['HOSTNAME'], namespace="default")
            pod.metadata.annotations["controller.kubernetes.io/pod-deletion-cost"] = pod_deletion_cost
            v1.patch_namespaced_pod(name=os.environ['HOSTNAME'], namespace="default", body=pod)
        except BaseException as e:
                self.logger.info("Exception while updating k8s pod worker annotation {}".format(e))

    def run(self):
        """
        Listen to queue and process messages upon arrival

        :return:
        """
        self.logger.info("Worker running")
    
        while True:
            try:
               
                # WaitTimeSeconds triggers long polling that will wait for events to enter queue
                messages = self.sqs_queue.receive_messages(MaxNumberOfMessages=1, WaitTimeSeconds=20)
                if len(messages) > 0:
                    message = messages[0]
                    self.logger.info('Message Received with payload: %s' % message.body)
                    # Check if running environment is in k8s and update pod status if true
                    if os.environ['K8S_ENVIRONMENT']:
                        self._update_k8s("99")
                        self.process_message(message)
                        self._update_k8s("0")
                    else: 
                        self.process_message(message)
                       
                        
            except BaseException as e:
                self.logger.info("Exception while processing messages in worker: {}".format(e))
