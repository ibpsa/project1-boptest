import os
import time
import requests
from requests_toolbelt import MultipartEncoder
from collections import OrderedDict
import asyncio
import websockets
import pytest
import json

host = os.environ.get("BOPTEST_SERVER", "http://web")


def upload_testcase(post_form_response, testcase_path):
    json = post_form_response.json()
    postURL = json["url"]
    formData = OrderedDict(json["fields"])
    formData["file"] = ("filename", open(testcase_path, "rb"))

    encoder = MultipartEncoder(fields=formData)
    return requests.post(postURL, data=encoder, headers={"Content-Type": encoder.content_type})

@pytest.mark.asyncio
async def test_one_boptest_with_websocket():
    async with websockets.connect("ws://web") as websocket:
        auth_token = os.environ.get("BOPTEST_TEST_PRIVILEGED_KEY")
        testcase_id = "testcase1"
        testcase_path = f"/boptest/testcases/{testcase_id}/models/wrapped.fmu"

        # Get post-form should return 200
        # This authorizes a new test case upload
        response = requests.get(f"{host}/testcases/{testcase_id}/post-form", headers={"Authorization": auth_token})
        assert response.status_code == 200

        # New test cases are uploaded directly to storage (e.g. minio/s3)
        # 204 indicates a successful upload
        response = upload_testcase(response, testcase_path)
        assert response.status_code == 204

        # Confirm that the test case has been received
        response = requests.get(f"{host}/testcases")
        assert response.status_code == 200
        assert testcase_id in map(lambda item: item["testcaseid"], response.json())

        # Select the test case
        response = requests.post(f"{host}/testcases/{testcase_id}/select")
        assert response.status_code == 200
        testid = response.json()["testid"]

        requestid = "abc"
        request = {"requestid": requestid, "testid": testid, "method": "advance", "params": { "u": {}}}
        await websocket.send(json.dumps(request))

        response = json.loads(await websocket.recv())

        # responseid should equal the requestid
        assert requestid == response["responseid"]

        # there should be responsedata
        assert response["responsedata"]

        # Stop the test
        response = requests.put(f"{host}/stop/{testid}")
        assert response.status_code == 200
