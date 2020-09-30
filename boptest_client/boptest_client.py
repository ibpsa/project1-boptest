import uuid
import requests
import json
import os
import time
from requests_toolbelt import MultipartEncoder
from multiprocessing import Pool
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

    def status(self, siteref):
        return status(self.url, siteref)

    def wait(self, siteref, desired_status):
        return wait(self.url, siteref, desired_status)

    def submit(self, path):
        args = {"url": self.url, "path": path}
        return submit_one(args)

    def start(self, site_id, **kwargs):
        args = {"url": self.url, "site_id": site_id, "kwargs": kwargs}
        return start_one(args)

    def stop(self, site_id):
        args = {"url": self.url, "site_id": site_id}
        return stop_one(args)

def status(url, siteref):
    status = ''

    query = '{ viewer{ sites(siteRef: "%s") { simStatus } } }' % siteref
    for i in range(3):
        response = requests.post(url + '/graphql', json={'query': query})
        if response.status_code == 200:
            break
    if response.status_code != 200:
        print("Could not get status")

    j = json.loads(response.text)
    sites = j["data"]["viewer"]["sites"]
    if sites:
        status = sites[0]["simStatus"]

    return status


def wait(url, siteref, desired_status):
    sites = []

    attempts = 0
    while attempts < 6000:
        attempts = attempts + 1
        current_status = status(url, siteref)

        if desired_status:
            if attempts % 2 == 0:
                print("Desired status: {}\t\tCurrent status: {}".format(desired_status, current_status))
            if current_status == desired_status:
                break
        elif current_status:
            break
        time.sleep(2)


def submit_one(args):
    url = args["url"]
    path = args["path"]

    filename = os.path.basename(path)
    uid = str(uuid.uuid1())

    key = 'uploads/' + uid + '/' + filename
    payload = {'name': key}

    # Get a template for the file upload form data
    # The server has an api to give this to us
    for i in range(3):
        response = requests.post(url + '/upload-url', json=payload)
        if response.status_code == 200:
            break
    if response.status_code != 200:
        print("Could not get upload-url")

    json = response.json()
    postURL = json['url']
    formData = OrderedDict(json['fields'])
    formData['file'] = ('filename', open(path, 'rb'))

    # Use the form data from the server to actually upload the file
    encoder = MultipartEncoder(fields=formData)
    for _ in range(3):
        response = requests.post(postURL, data=encoder, headers={'Content-Type': encoder.content_type})
        if response.status_code == 204:
            break
    if response.status_code != 204:
        print("Could not post file")

    # After the file has been uploaded, then tell BOPTEST to process the site
    # This is done not via the haystack api, but through a graphql api
    mutation = 'mutation { addSite(osmName: "%s", uploadID: "%s") }' % (filename, uid)
    for _ in range(3):
        response = requests.post(url + '/graphql', json={'query': mutation})
        if response.status_code == 200:
            break
    if response.status_code != 200:
        print("Could not addSite")

    wait(url, uid, "Stopped")

    return uid


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

