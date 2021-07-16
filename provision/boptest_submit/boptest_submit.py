import requests
import time
import glob
import os
from pathlib import Path
from requests_toolbelt import MultipartEncoder
from collections import OrderedDict


# This class is used for provisioning a Boptest server
# with test cases.
class BoptestSubmit:
    # The url argument is the address of the Boptest server

    def __init__(self, url=os.environ.get('BOPTEST_SUBMIT_URL','http://localhost')):
        self.server = url

    # Glob for fmu files under rootpath, and submit as a testcase
    def submit_all(self, rootpath):
        paths = glob.glob(rootpath + '/**/*.fmu', recursive=True)
        for p in paths:
            # A convention of the boptest repo is that the testcase is named
            # according to the directory two parents up
            name = Path(p).parents[1].name
            print('submit %s named %s' % (p, name))
            self.submit(p, name)

    def submit(self, path, testcaseid):
        # This is fault tolerant, with repeated attempts,
        # because this is commonly used during container bootup
        # This is like "wait-for-it" but wait-for-it does not
        # meet the requirements here. We need to actually try upload
        # before we know if the infrastructure is ready.
        attempts = 0
        while attempts < 6000:
            attempts = attempts + 1
            response = self._attempt_submit(path, testcaseid)
            if response:
                return response
            time.sleep(2)

        print('Failed to submit %s named %s' % (path, testcaseid))
        return False

    def _attempt_submit(self, path, testcaseid):
        try:
            # Get a template for the file upload form data
            # The server has an api to give this to us
            url = self.server + '/testcases/' + testcaseid + '/post-form'
            response = requests.get(url)
            if response.status_code != 200:
                return False

            json = response.json()
            postURL = json['url']
            formData = OrderedDict(json['fields'])
            formData['file'] = ('filename', open(path, 'rb'))

            # Use the form data from the server to actually upload the file
            encoder = MultipartEncoder(fields=formData)
            response = requests.post(postURL, data=encoder, headers={'Content-Type': encoder.content_type})
            if response.status_code != 204:
                return False

            # After the file has been uploaded, then tell BOPTEST to process the site
            # This is done not via the haystack api, but through a graphql api
            url = self.server + '/testcases/' + testcaseid
            response = requests.put(url)
            if response.status_code != 200:
                return False

            # The previous step is asynchronous
            # We have to wait for a worker job to be complete before the testcase is fully submitted
            self._wait_for_testcase(testcaseid)

            return testcaseid
        except:
            return False

    def _exists(self, testcaseid):
        url = '{}/testcases/{}'.format(self.server, testcaseid)
        response = requests.get(url)
        return response.ok

    def _wait_for_testcase(self, testcaseid):
        attempts = 0
        while attempts < 6000:
            attempts = attempts + 1
            if self._exists(testcaseid):
                break
            time.sleep(2)
