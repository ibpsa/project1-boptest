import uuid
import requests
import json
import os
import time
from requests_toolbelt import MultipartEncoder
from collections import OrderedDict


class BoptestClient:

    # The url argument is the address of the Alfalfa server
    # default should be http://localhost/api
    def __init__(self, url='http://localhost'):
        self.url = url
        self.haystack_filter = self.url + '/api/read?filter='
        self.haystack_json_header = {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
        self.readable_site_points = None  # Populated by get_read_site_points
        self.writable_site_points = None  # Populated by get_write_site_points
        self.readable_writable_site_points = None  # Populated by get_read_write_site_points

    def status(self, test_id):
        return status(self.url, test_id)

    def wait(self, siteref, desired_status):
        return wait(self.url, siteref, desired_status)

    def submit(self, path, testcaseid):
        args = {"url": self.url, "path": path, "testcaseid": testcaseid}
        return submit_one(args)

    def start(self, site_id, **kwargs):
        args = {"url": self.url, "site_id": site_id, "kwargs": kwargs}
        return start_one(args)

    def stop(self, site_id):
        args = {"url": self.url, "site_id": site_id}
        return stop_one(args)

    # The methods below are for interacting with the standard BOPTEST interface where the client has
    # configured a testcase
    def name(self):
        """Return the name of the testcase that is loaded in BOPTEST.

        Note that this method only returns a single value and not a
        dictionary. For example, it returns b'60.0\n', which is not JSON, but when calling json() it returns
        the value. It is recommended to update the /name method in BOPTEST to return JSON (e.g., {"name": "tc1"}

        Returns
            String
        """
        return requests.get('{}/name'.format(self.url)).json()

    def inputs(self):
        """Return the list of inputs for the BOPTEST testcase that has been loaded

        Returns:
            Dict of inputs
        """
        return requests.get('{}/inputs'.format(self.url)).json()

    def measurements(self):
        """Return a list of measurements available in the loaded BOPTEST testcase

        Returns:
            Dict of measurements
        """
        return requests.get('{}/measurements'.format(self.url)).json()

    def get_step(self, test_id=None):
        """Return the timestep configuration.

        Note that this method only returns a single value and not a
        dictionary. For example, it returns b'60.0\n', which is not JSON, but when calling json() it returns
        the value. It is recommended to update the /step method in BOPTEST to return JSON (e.g., {"step": 60}

        Parameters:
            test_id (str): if provided, then the test_id to initialize. If None, then it will assume that a testcase
                           was initialized.

        Returns:
            String
        """
        if test_id:
            url = '{}/step/{test_id}'.format(self.url)
        else:
            url = '{}/step'.format(self.url)

        return requests.get(url).json()

    def set_step(self, test_id=None, step=60):
        """Set the step duration the simulation through time at step level defined

        Note that this method only returns a single value and not a
        dictionary. For example, it returns b'60.0\n', which is not JSON, but when calling json() it returns
        the value. It is recommended to update the /step method in BOPTEST to return JSON (e.g., {"step": 60}

        Parameters:
            test_id (str): if provided, then the test_id to initialize. If None, then it will assume that a testcase
                           was initialized.
            step (int): the value of the simulation step.

        Returns:
            step size (str): the value of the step that was set
        """
        if test_id:
            url = '{}/step/{test_id}'.format(self.url)
        else:
            url = '{}/step'.format(self.url)
        res = requests.put(url, data={'step': step})
        return res

    def initialize(self, test_id=None, **kwargs):
        """Initialize a testcase

        Parameters:
            test_id (str): if provided, then the test_id to initialize. If None, then it will assume that a testcase
                           was initialized.
            **kwargs: other options to pass as the data. Valid options are start_time, warmup_period

        Returns:
            initial values (dict): the initialized conditions.

        """
        if not kwargs.has_key('start_time'):
            kwargs['start_time'] = 0
        if not kwargs.has_key('warmup_period'):
            kwargs['warmup_period'] = 0

        if test_id:
            url = '{}/initialize/{}'.format(self.url, test_id)
        else:
            url = '{}/initialize'.format(self.url)
        res = requests.put(url, data=kwargs)
        if res:
            return res.json()
        else:
            result = {"status": "error", "message": "unable to submit simulation"}
            raise Exception(result)

    def advance(self, test_id=None, control_u=None):
        """Advance the simulation through time at step level defined

        TODO: We should set the test_id as a member variable, then make control_u a non-defaulted parameter.

        Parameters:
            test_id (str): if provided, then the test_id to initialize. If None, then it will assume that a testcase
                           was initialized.
            control_u (dict): control values to set

        Returns:
            simulation results (dict): values of the model at the the last step
        """
        if test_id:
            url = '{}/advance/{}'.format(self.url, test_id)
        else:
            url = '{}/advance'.format(self.url)
        return requests.post(url, data=control_u).json()

    def kpis(self, test_id=None):
        """Return the KPIs of the testcase.

        Parameters:
            test_id (str): if provided, then the test_id to initialize. If None, then it will assume that a testcase
                           was initialized.

        Returns:
            kpis (dict): results of the kpis
        """
        if test_id:
            url = '{}/kpi/{}'.format(self.url, test_id)
        else:
            url = '{}/kpi'.format(self.url)
        return requests.get(url).json()

    def results(self, test_id=None):
        """Return the results of the simulation.

        """
        if test_id:
            url = '{}/results/{}'.format(self.url, test_id)
        else:
            url = '{}/results'.format(self.url)
        return requests.get(url).json()


def status(url, test_id):
    url = '{}/status/{}'.format(url, test_id)
    s = requests.get(url)
    return s.text


def wait(url, test_id, desired_status):
    sites = []

    attempts = 0
    while attempts < 6000:
        attempts = attempts + 1
        current_status = status(url, test_id)

        if desired_status:
            if current_status == desired_status:
                break
        elif current_status:
            break
        time.sleep(2)


def submit_one(args):
    server = args["url"]
    path = args["path"]
    testcaseid = args["testcaseid"]

    filename = os.path.basename(path)
    url = server + '/testcases/' + testcaseid + '/post-form'

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
    url = server + '/testcases/' + testcaseid
    response = requests.put(url)
    if response.status_code != 200:
        print("Could not add testcase")
        return

    # The previous step is asynchronous
    # We have to wait for a worker job to be complete before the testcase is fully submitted
    wait(server, testcaseid, "Stopped")

    return testcaseid


def start_one(args):
    url = args["url"]
    site_id = args["site_id"]
    kwargs = args["kwargs"]

    mutation = 'mutation { runSite(siteRef: "%s"' % site_id

    if "timescale" in kwargs:
        mutation = mutation + ', timescale: %s' % kwargs["timescale"]
    if "start_datetime" in kwargs:
        mutation = mutation + ', startDatetime: "%s"' % kwargs["start_datetime"]
    if "end_datetime" in kwargs:
        mutation = mutation + ', endDatetime: "%s"' % kwargs["end_datetime"]
    if "realtime" in kwargs:
        mutation = mutation + ', realtime: %s' % kwargs["realtime"]
    if "external_clock" in kwargs:
        mutation = mutation + ', externalClock: %s' % kwargs["external_clock"]

    mutation = mutation + ') }'

    for _ in range(3):
        response = requests.post(url + '/graphql', json={'query': mutation})
        if response.status_code == 200:
            break
        else:
            print("Start one status code: {}".format(response.status_code))

    wait(url, site_id, "Running")


def stop_one(args):
    url = args["url"]
    site_id = args["site_id"]

    mutation = 'mutation { stopSite(siteRef: "%s") }' % (site_id)
    payload = {'query': mutation}
    response = requests.post(url + '/graphql', json=payload)

    wait(url, site_id, "Stopped")
