import os
import time
import requests
from requests_toolbelt import MultipartEncoder
from collections import OrderedDict
import asyncio
import websockets
import pytest
import json
import uuid
from pytest_check import check

host = os.environ.get("BOPTEST_SERVER", "http://web")


def upload_testcase(post_form_response, testcase_path):
    json = post_form_response.json()
    postURL = json["url"]
    formData = OrderedDict(json["fields"])
    formData["file"] = ("filename", open(testcase_path, "rb"))

    encoder = MultipartEncoder(fields=formData)
    return requests.post(postURL, data=encoder, headers={"Content-Type": encoder.content_type})

@pytest.mark.asyncio
async def test_boptest_websocket_one_test():
    async with websockets.connect("ws://web") as websocket:
        auth_token = os.environ.get("BOPTEST_TEST_PRIVILEGED_KEY")
        testcase_id = "testcase1"
        testcase_path = f"/boptest/testcases/{testcase_id}/models/wrapped.fmu"

        # Get post-form should return 200
        # This authorizes a new test case upload
        response = requests.get(f"{host}/testcases/{testcase_id}/post-form", headers={"Authorization": auth_token})
        check.is_true(response.status_code == 200)

        # New test cases are uploaded directly to storage (e.g. minio/s3)
        # 204 indicates a successful upload
        response = upload_testcase(response, testcase_path)
        check.is_true(response.status_code == 204)

        # Confirm that the test case has been received
        response = requests.get(f"{host}/testcases")
        check.is_true(response.status_code == 200)
        check.is_true(testcase_id in map(lambda item: item.get("testcaseid"), response.json()))

        # Select the test case
        response = requests.post(f"{host}/testcases/{testcase_id}/select")
        check.is_true(response.status_code == 200)
        testid = response.json()["testid"]

        # Send a message to advance
        requestid = str(uuid.uuid4())
        request = {"requestid": requestid, "testid": testid, "method": "advance", "params": {}}
        await websocket.send(json.dumps(request))

        response = json.loads(await websocket.recv())
        check.is_true(requestid == response.get("responseid"))
        # There should be responsedata
        check.is_true(response.get("responsedata"))

        # Send a bogus method name
        requestid = str(uuid.uuid4())
        request = {"requestid": requestid, "testid": testid, "method": "rubbish", "params": {}}
        await websocket.send(json.dumps(request))

        response = json.loads(await websocket.recv())
        check.is_true(requestid == response.get("responseid"))
        # There should be responsedata
        responsedata = response.get("responsedata")
        check.is_true(responsedata)
        # Status 400 should be returned
        check.is_true(responsedata.get("status") == 400)

        # Send invalid json syntax
        await websocket.send("not json")

        response = json.loads(await websocket.recv())
        # There is no responseid because no requestid was received
        check.is_true(not response.get("responseid"))
        # There should be responsedata
        responsedata = response.get("responsedata")
        check.is_true(responsedata)
        # Status 400 should be returned
        check.is_true(responsedata.get("status") == 400)

        # Stop the test
        response = requests.put(f"{host}/stop/{testid}")
        check.is_true(response.status_code == 200)

@pytest.mark.asyncio
async def test_boptest_websocket_n_tests():
    async with websockets.connect("ws://web") as websocket:
        auth_token = os.environ.get("BOPTEST_TEST_PRIVILEGED_KEY")
        testcase_id = "testcase1"
        testcase_path = f"/boptest/testcases/{testcase_id}/models/wrapped.fmu"

        # Get post-form should return 200
        # This authorizes a new test case upload
        response = requests.get(f"{host}/testcases/{testcase_id}/post-form", headers={"Authorization": auth_token})
        check.is_true(response.status_code == 200)

        # New test cases are uploaded directly to storage (e.g. minio/s3)
        # 204 indicates a successful upload
        response = upload_testcase(response, testcase_path)
        check.is_true(response.status_code == 204)

        # Confirm that the test case has been received
        response = requests.get(f"{host}/testcases")
        check.is_true(response.status_code == 200)
        check.is_true(testcase_id in map(lambda item: item.get("testcaseid"), response.json()))

        # Select the test cases
        number_of_tests = 1 # number of tests can be any number, as long as there are available workers
        testids = []
        for i in range(number_of_tests):
            response = requests.post(f"{host}/testcases/{testcase_id}/select")
            check.is_true(response.status_code == 200)
            testids.append(response.json()["testid"])

        # Send one advance request to each test
        worker_requests = dict()
        for testid in testids:
            requestid = str(uuid.uuid4())
            worker_requests[requestid] = {"requestid": requestid, "testid": testid, "method": "advance", "params": {}}

        # Sending a list of requests in one message is allowed
        await websocket.send(json.dumps(list(worker_requests.values())))

        worker_responses = dict()
        # One response message should come back for each request
        async for message in websocket:
            response = json.loads(message)
            responseid = response.get("responseid")
            check.is_true(responseid)
            check.is_true(response.get("responsedata"))
            worker_responses[responseid] = response
            if len(worker_responses.keys()) == len(worker_requests.keys()):
                break

        check.is_true(len(worker_responses.keys()) == len(worker_requests.keys()))

        # Stop the tests
        for testid in testids:
            response = requests.put(f"{host}/stop/{testid}")
            check.is_true(response.status_code == 200)
