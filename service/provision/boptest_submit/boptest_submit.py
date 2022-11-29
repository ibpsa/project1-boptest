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

    def __init__(self, url=os.environ.get('BOPTEST_SUBMIT_URL', 'http://localhost')):
        self.server = url

    # Glob for fmu files under rootpath, and submit as a testcase
    def submit_all(self, rootpath, auth_token, shared):
        paths = glob.glob(rootpath + '/**/*.fmu', recursive=True)
        for p in paths:
            # A convention of the boptest repo is that the testcase is named
            # according to the directory two parents up
            name = Path(p).parents[1].name
            print('submit %s named %s' % (p, name), flush=True)
            self.submit(p, name, auth_token, shared)

    def submit(self, path, testcaseid, auth_token, shared):
        # This is fault tolerant, with repeated attempts,
        # because this is commonly used during container bootup
        # This is like "wait-for-it" but wait-for-it does not
        # meet the requirements here. We need to actually try upload
        # before we know if the infrastructure is ready.
        attempts = 0
        while attempts < 6000:
            attempts = attempts + 1
            response = self._attempt_submit(path, testcaseid, auth_token, shared)
            if response:
                return response
            time.sleep(2)

        print('Failed to submit %s named %s' % (path, testcaseid))
        return False

    def _attempt_submit(self, path, testcaseid, auth_token, shared):
        try:
            # Get a template for the file upload form data
            # The server has an api to give this to us
            if shared:
                url_prefix = '/testcases/'
            else:
                url_prefix = '/my/testcases/'

            url = self.server + url_prefix + testcaseid + '/post-form'
            response = requests.get(url, headers={'Authorization': auth_token})
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

            # Confirm that the testcase exists
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

    def submit_to_dashboard(self):
        payload = {
          'buildingTypes': [
            {
              'uid': 'bestest_air',
              'name': 'BESTEST Air',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            },
            {
              'uid': 'bestest_hydronic',
              'name': 'BESTEST Hydronic',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            },
            {
              'uid': 'bestest_hydronic_heat_pump',
              'name': 'BESTEST Hydronic Heat Pump',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            },
            {
              'uid': 'multizone_office_simple_air',
              'name': 'Multizone Office Simple Air',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            },
            {
              'uid': 'multizone_residential_hydronic',
              'name': 'Multizone Residential Hydronic',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            },
            {
              'uid': 'singlezone_commercial_hydronic',
              'name': 'Single Zone Commercial Hydronic',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            },
            {
              'uid': 'testcase1',
              'name': 'Testcase 1',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            },
            {
              'uid': 'testcase2',
              'name': 'Testcase 2',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            },
            {
              'uid': 'testcase3',
              'name': 'Testcase 3',
              'markdownURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'pdfURL': 'https://raw.githubusercontent.com/ibpsa/project1-boptest/master/README.md',
              'scenarios': {
                'timePeriod': ['peak_heat_day', 'peak_cool_day', 'typical_heat_day', 'typical_cool_day', 'mix_day'],
                'electricityPrice': ['constant', 'dynamic', 'highly dynamic'],
                'weatherForecastUncertainty': ['deterministic']
              }
            }
          ],
          'apiKey': os.environ.get('BOPTEST_DASHBOARD_API_KEY')
        }

        url = os.environ.get('BOPTEST_DASHBOARD_SERVER', '') + '/api/buildingTypes'
        response = requests.post(url, json=payload)
