import requests
import time
from requests_toolbelt import MultipartEncoder
from collections import OrderedDict


class BoptestSubmit:

    # The url argument is the address of the Alfalfa server
    # default should be http://localhost/api
    def __init__(self, url='http://localhost'):
        self.server = url

    def submit(self, path, testcaseid):
        url = self.server + '/testcases/' + testcaseid + '/post-form'

        # Get a template for the file upload form data
        # The server has an api to give this to us
        response = requests.get(url)
        if response.status_code != 200:
            print("Could not get testcase upload url")
            return

        json = response.json()
        postURL = json['url']
        formData = OrderedDict(json['fields'])
        formData['file'] = ('filename', open(path, 'rb'))

        # Use the form data from the server to actually upload the file
        encoder = MultipartEncoder(fields=formData)
        response = requests.post(postURL, data=encoder, headers={'Content-Type': encoder.content_type})
        if response.status_code != 204:
            print("Could not upload testcase")
            return

        # After the file has been uploaded, then tell BOPTEST to process the site
        # This is done not via the haystack api, but through a graphql api
        url = self.server + '/testcases/' + testcaseid
        response = requests.put(url)
        if response.status_code != 200:
            print("Could not add testcase")
            return

        # The previous step is asynchronous
        # We have to wait for a worker job to be complete before the testcase is fully submitted
        self._wait(testcaseid)

        return testcaseid

    def _exists(self, testcaseid):
        url = '{}/testcases/{}'.format(self.server, testcaseid)
        response = requests.get(url)
        return response.ok

    def _wait(self, testcaseid):
        attempts = 0
        while attempts < 6000:
            attempts = attempts + 1
            if self._exists(testcaseid):
                break
            time.sleep(2)
