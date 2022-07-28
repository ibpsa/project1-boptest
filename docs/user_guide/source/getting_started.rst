===============
Getting Started
===============


Using BOPTEST
=============

There are two ways you can access BOPTEST, depending on your preference:

1. **Single Test Case on Local Computing Resource**: Deploy a single test
case on your local computing resource and interact with it at localhost
via the BOPTEST API.

2. **Public Web-Service (Coming Soon)**: Utilize a web-hosted BOPTEST
environment available to the public to deploy a test case in the cloud and
interact with it at a URL specific to you via the BOPTEST API.


Single Test Case on Local Computing Resource
============================================

Installation
------------
1. Install Docker and docker-compose on your system.
2. Download the latest version of BOPTEST as a .zip and extract it to a location.

Deploy a Test Case
------------------
Within the root directory of the extracted software, use the following commands:

- Linux or macOS: ``$ TESTCASE=<testcase_name> docker-compose up``
- Windows PowerShell: ``> ($env:TESTCASE="<testcase_name>") -and (docker-compose up)``

A couple notes:

- Replace ``<testcase_name>`` with the name of the test case you wish to deploy.
- The first time this command is run, the image ``boptest_base`` will be built.  This takes about a minute.  Subsequent usage will use the already-built image and deploy much faster.
- If you update your BOPTEST repository, use the command ``docker rmi boptest_base`` to remove the image so it can be re-built with the updated repository upon next deployment.
- ``TESTCASE`` is simply an environment variable.  Consistent with use of docker-compose, you may also edit the value of this variable in the ``.env`` file and then use ``docker-compose up``.


Use the API
-----------
Send API requests to localhost port 5000 as ``http://127.0.0.1:5000/<request>``.  See the section API Summary for more information on available requests.

Stop the Test Case
------------------
Within the root directory of the extracted software, use the command ``docker-compose down``.


Public Web-Service (Coming Soon)
================================

Installation
------------
There are no installation requirements.

Deploy a Test Case
------------------
Send the following API request to ``<url>``.
The returned ``<testid>`` will be needed for all future API requests associated
with your chosen test case.

Use the API
-----------
Send API requests to ``<url>/<request>/<testid>``, where ``<testid>`` is returned from the previous step.
See the section API Summary for more information on available requests.

Stop the Test Case
------------------
Send the following API request: ``<url>/<request>/<testid>``.
Note that the test case will be stopped automatically in case of a period of
inactivity lasting X minutes.  If this happens, a new test case should be deployed
using the actions described previously.
