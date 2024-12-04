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
import redis
from .logger import Logger
from kubernetes import client, config

class Worker:
    """The main Worker class.  Used for processing messages from the Queue"""

    def __init__(self):
        self.logger = Logger().logger
        self.redis = redis.Redis(host=os.environ["BOPTEST_REDIS_HOST"])
        self.logger.info("Worker initialized")

    def process_job(self, job):
        """
        Process a single message from Queue.

        :param message: A single message, as returned from the Queue
        :return:
        """
        message_body = json.loads(job)
        jobtype = message_body.get('jobtype')
        params = message_body.get('params')
        subprocess.call(['python', '-m', jobtype, json.dumps(params)])

    def _update_k8s_pod_cost(self, pod_deletion_cost):
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
        except botocore.exceptions.ClientError as e:
            self.logger.info("Exception while updating k8s pod worker annotation pod-deletion-cost {}".format(e))

    def run(self):
        """
        Listen to queue and process messages upon arrival

        :return:
        """
        self.logger.info("Worker running")

        while True:
            try:
                job = self.redis.blpop('jobs', 20)
                if job:
                    job = job[1]
                    self.logger.info(f'Job Received with payload: {job}')
                    # Check if running environment is in k8s and update pod status if true
                    if "K8S_ENVIRONMENT" in os.environ:
                        self.logger.info("Upating k8s pod cost for active job")
                        self._update_k8s_pod_cost("99")
                        self.process_job(job)
                        self.logger.info("Upating k8s pod cost for inactive job")
                        self._update_k8s_pod_cost("0")
                    else:
                        self.process_job(job)

            except BaseException as e:
                self.logger.info(f'Exception while processing messages in worker: {e}')
