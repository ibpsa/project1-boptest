===============
Getting Started
===============


Using BOPTEST
=============

There are two ways you can access BOPTEST, depending on your preference:

**I. Deploy on Local Computing Resource**: Deploy BOPTEST
on your local computing resource and localhost, deploy a test case, and interact with it
via the BOPTEST API.

**II. Utilize Public Web-Service**: Utilize a publicly available web-hosted BOPTEST
environment (BOPTEST-Service) to deploy a test case in the cloud and
interact with it at a URL specific to you via the BOPTEST API.


I. Deploy on Local Computing Resource
=====================================

1. Installation
---------------
- Install Docker (https://docs.docker.com/get-docker/) on your system.
- Download the latest version of BOPTEST as a .zip and extract it to a location.

2. Deploy a Test Case
---------------------
Use Docker to build and deploy BOPTEST.  In the root of the repository, run the command below.

- ``docker compose up web worker provision``
- If you want to be able to deploy multiple test cases at the same time, append the argument ``--scale worker=n`` where ``n`` equals the number of test cases you want to be able to have running at the same time.
- If no request is made to a running test case for some time, the test case will be automatically stopped and the associated worker will be freed up. By default this timeout is 15 minutes. If you would like to change this timeout period, you can edit the environment variable ``BOPTEST_TIMEOUT`` in the ``.env`` file before starting BOPTEST with the command above.

Then, send the following API request to url ``http://127.0.0.1:80``.

- ``POST <url>/testcases/<testcase_name>/select``, where ``<testcase_name>`` is replaced with the name of the test case you wish to deploy.
- The return will be a json with ``{'testid': <testid>}``.
- The returned ``<testid>`` will be needed for all future API requests associated with your chosen test case.

3. Use the API
--------------
Send API requests to ``<url>/<request>/<testid>``, where ``<testid>`` is returned from the previous step.
See the section on API Summary for more information on available requests.

4. Stop the Test Case
---------------------
To stop the test case and free up the associated worker, send the following API request:

- ``PUT <url>/stop/<testid>``
-  The test case will be stopped automatically in case of a period of inactivity.  If this happens, a new test case should be deployed using the actions described previously.

5. Shutdown BOPTEST
-------------------
Shutdown BOPTEST by the following command executed in the root directory of the repository:

- ``docker compose down``
- IMPORTANT: This is the best and most complete way to shutdown BOPTEST to prevent issues upon redeployment.


II. Utilize Public Web-Service
==============================

1. Installation
---------------
There are no installation requirements.

2. Deploy a Test Case
---------------------
Send the following API request to url ``https://api.boptest.net``.

- ``POST <url>/testcases/<testcase_name>/select``, where ``<testcase_name>`` is replaced with the name of the test case you wish to deploy.
- The return will be a json with ``{'testid': <testid>}``.
- The returned ``<testid>`` will be needed for all future API requests associated with your chosen test case.

3. Use the API
--------------
Send API requests to ``<url>/<request>/<testid>``, where ``<testid>`` is returned from the previous step.
See the section on API Summary for more information on available requests.

4. Stop the Test Case
---------------------
To stop the test case, send the following API request:

- ``PUT <url>/stop/<testid>``
-  The test case will be stopped automatically in case of a period of inactivity.  If this happens, a new test case should be deployed using the actions described previously.
