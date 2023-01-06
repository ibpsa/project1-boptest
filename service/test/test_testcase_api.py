import os
import requests
from requests_toolbelt import MultipartEncoder
from collections import OrderedDict

host = os.environ.get("BOPTEST_SERVER", "http://web")


def upload_testcase(post_form_response, testcase_path):
    json = post_form_response.json()
    postURL = json["url"]
    formData = OrderedDict(json["fields"])
    formData["file"] = ("filename", open(testcase_path, "rb"))

    encoder = MultipartEncoder(fields=formData)
    return requests.post(postURL, data=encoder, headers={"Content-Type": encoder.content_type})


def test_ibpsa_boptest_testcase():
    auth_token = os.environ.get("BOPTEST_TEST_PRIVILEGED_KEY")
    testcase_id = "testcase1"
    testcase_path = f"/testcases/{testcase_id}/models/wrapped.fmu"

    # Delete for an invalid test case should return 404
    response = requests.delete(f'{host}/testcases/{testcase_id + "xyz"}', headers={"Authorization": auth_token})
    assert response.status_code == 404

    # Invalid auth_token to get post-form should return 401
    response = requests.get(f"{host}/testcases/{testcase_id}/post-form", headers={"Authorization": auth_token + "xyz"})
    assert response.status_code == 401

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

    # Get the test's name (testcaseID) to demonstrate that it is running
    # Other test APIs are exercised by the core BOPTEST test suite
    response = requests.get(f"{host}/name/{testid}")
    assert response.status_code == 200

    # Stop the test
    response = requests.put(f"{host}/stop/{testid}")
    assert response.status_code == 200

    # Invalid auth_token to delete test case should return 401
    response = requests.delete(f"{host}/testcases/{testcase_id}", headers={"Authorization": auth_token + "xyz"})
    assert response.status_code == 401

    # Successful delete should return 200
    response = requests.delete(f"{host}/testcases/{testcase_id}", headers={"Authorization": auth_token})
    assert response.status_code == 200


def test_shared_namespace_testcase():
    auth_token = os.environ.get("BOPTEST_TEST_PRIVILEGED_KEY")
    testcase_namespace = "resstock"
    testcase_id = "testcase1"
    testcase_path = f"/testcases/{testcase_id}/models/wrapped.fmu"

    # Delete for an invalid test case should return 404
    response = requests.delete(
        f'{host}/testcases/{testcase_namespace}/{testcase_id + "xyz"}', headers={"Authorization": auth_token}
    )
    assert response.status_code == 404

    # Invalid auth_token to get post-form should return 401
    response = requests.get(
        f"{host}/testcases/{testcase_namespace}/{testcase_id}/post-form", headers={"Authorization": auth_token + "xyz"}
    )
    assert response.status_code == 401

    # Get post-form should return 200
    # This authorizes a new test case upload
    response = requests.get(
        f"{host}/testcases/{testcase_namespace}/{testcase_id}/post-form", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200

    # New test cases are uploaded directly to storage (e.g. minio/s3)
    # 204 indicates a successful upload
    response = upload_testcase(response, testcase_path)
    assert response.status_code == 204

    # Confirm that the test case has been received
    response = requests.get(f"{host}/testcases/{testcase_namespace}")
    assert response.status_code == 200
    assert testcase_id in map(lambda item: item["testcaseid"], response.json())

    # Select the test case
    response = requests.post(f"{host}/testcases/{testcase_namespace}/{testcase_id}/select")
    assert response.status_code == 200
    testid = response.json()["testid"]

    # Get the test's name (testcaseID) to demonstrate that it is running
    # Other test APIs are exercised by the core BOPTEST test suite
    response = requests.get(f"{host}/name/{testid}")
    assert response.status_code == 200

    # Stop the test
    response = requests.put(f"{host}/stop/{testid}")
    assert response.status_code == 200

    # Invalid auth_token to delete test case should return 401
    response = requests.delete(
        f"{host}/testcases/{testcase_namespace}/{testcase_id}", headers={"Authorization": auth_token + "xyz"}
    )
    assert response.status_code == 401

    # Successful delete should return 200
    response = requests.delete(
        f"{host}/testcases/{testcase_namespace}/{testcase_id}", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200


def test_private_user_testcase():
    auth_token = os.environ.get("BOPTEST_TEST_KEY")
    username = os.environ.get("BOPTEST_TEST_USERNAME")
    testcase_id = "testcase1"
    testcase_path = f"/testcases/{testcase_id}/models/wrapped.fmu"

    # Delete for an invalid test case should return 404
    response = requests.delete(
        f'{host}/users/{username}/testcases/{testcase_id + "xyz"}', headers={"Authorization": auth_token}
    )
    assert response.status_code == 404

    # Invalid auth_token to get post-form should return 401
    response = requests.get(
        f"{host}/users/{username}/testcases/{testcase_id}/post-form", headers={"Authorization": auth_token + "xyz"}
    )
    assert response.status_code == 401

    # Get post-form should return 200
    # This authorizes a new test case upload
    response = requests.get(
        f"{host}/users/{username}/testcases/{testcase_id}/post-form", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200

    # New test cases are uploaded directly to storage (e.g. minio/s3)
    # 204 indicates a successful upload
    response = upload_testcase(response, testcase_path)
    assert response.status_code == 204

    # Confirm that the test case has been received
    response = requests.get(f"{host}/users/{username}/testcases", headers={"Authorization": auth_token})
    assert response.status_code == 200
    assert testcase_id in map(lambda item: item["testcaseid"], response.json())

    # Select the test case
    response = requests.post(
        f"{host}/users/{username}/testcases/{testcase_id}/select", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200
    testid = response.json()["testid"]

    # Get the test's name (testcaseID) to demonstrate that it is running
    # Other test APIs are exercised by the core BOPTEST test suite
    response = requests.get(f"{host}/name/{testid}")
    assert response.status_code == 200

    # Stop the test
    response = requests.put(f"{host}/stop/{testid}")
    assert response.status_code == 200

    # Invalid auth_token to delete test case should return 401
    response = requests.delete(
        f"{host}/users/{username}/testcases/{testcase_id}", headers={"Authorization": auth_token + "xyz"}
    )
    assert response.status_code == 401

    # Successful delete should return 200
    response = requests.delete(
        f"{host}/users/{username}/testcases/{testcase_id}", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200


def test_tests_api():
    auth_token = os.environ.get("BOPTEST_TEST_PRIVILEGED_KEY")
    username = os.environ.get("BOPTEST_TEST_PRIVILEGED_USERNAME")
    testcase_id = "testcase1"
    testcase_path = f"/testcases/{testcase_id}/models/wrapped.fmu"

    # Get post-form should return 200
    # This authorizes a new test case upload
    response = requests.get(
        f"{host}/users/{username}/testcases/{testcase_id}/post-form", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200

    # New test cases are uploaded directly to storage (e.g. minio/s3)
    # 204 indicates a successful upload
    response = upload_testcase(response, testcase_path)
    assert response.status_code == 204

    # Select the test case
    response = requests.post(
        f"{host}/users/{username}/testcases/{testcase_id}/select", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200
    testid = response.json()["testid"]

    # Get all tests for user
    response = requests.get(
        f"{host}/users/{username}/tests", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200
    print('tests response.json', response.json(), flush=True)
    assert testid in response.json()

    # Without the Authorization header, should return 401
    response = requests.get(
        f"{host}/users/{username}/tests"
    )
    assert response.status_code == 401

    # With incorrect auth_token, should also receive 401
    response = requests.get(
        f"{host}/users/{username}/tests", headers={"Authorization": auth_token + "xyz"}
    )
    assert response.status_code == 401

    # Stop the test
    response = requests.put(f"{host}/stop/{testid}")
    assert response.status_code == 200


def test_async_select_api():
    auth_token = os.environ.get("BOPTEST_TEST_PRIVILEGED_KEY")
    username = os.environ.get("BOPTEST_TEST_PRIVILEGED_USERNAME")
    testcase_id = "testcase1"
    testcase_path = f"/testcases/{testcase_id}/models/wrapped.fmu"

    # Get post-form should return 200
    # This authorizes a new test case upload
    response = requests.get(
        f"{host}/users/{username}/testcases/{testcase_id}/post-form", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200

    # New test cases are uploaded directly to storage (e.g. minio/s3)
    # 204 indicates a successful upload
    response = upload_testcase(response, testcase_path)
    assert response.status_code == 204

    # Select the test case asynchronously a large number of times
    # More than we likely have worker resources for. Tests should queue
    test_count = 10
    test_ids = []
    for i in range(test_count):
        response = requests.post(
            f"{host}/users/{username}/testcases/{testcase_id}/select-async", headers={"Authorization": auth_token}
        )
        assert response.status_code == 200
        test_ids.append(response.json()['testid'])

    # Get all tests for user
    # Most will be in Queued status, unless `test_count` workers are available
    response = requests.get(
        f"{host}/users/{username}/tests", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200
    # All of the queued/running tests should be returned bythe /tests API
    assert len(response.json()) == test_count
    for test in test_ids:
        assert test in response.json()

    # Stop all of the tests
    # Queued tests should be aborted.
    # Running tests should be stopped.
    for test in response.json():
        # Stop the test
        response = requests.put(f"{host}/stop/{test}")
        assert response.status_code == 200

    # Get all tests again
    # The response should be an empty list at this point
    response = requests.get(
        f"{host}/users/{username}/tests", headers={"Authorization": auth_token}
    )
    assert response.status_code == 200
    assert len(response.json()) == 0
