===============
Getting Started
===============


Using BOPTEST
=============

There are two ways you can access BOPTEST, depending on your preference:

1. **Single Test Case on a Local Computing Resource**: A single test
case at a time can be deployed on your local computing resource and made
accessible to you at ``localhost:5000`` via the BOPTEST API.

2. **Any Test Case via Public Web-Service**: Utilize a web-hosted BOPTEST
environment available to the public to deploy any test case in the cloud,
which is made accessible to you through at a URL specific to you via the BOPTEST API.

Single Use on Local Computing Resource
======================================

Installation
------------
1. Install Docker and docker-compose on your system.
2. Download the latest version of BOPTEST as a .zip and extract it to a location.

Deploy a Test Case
------------------
Within the root directory of the extracted software, use the following commands:

- Linux or macOS: ``$ TESTCASE=<testcase_name> docker-compose up``
- Windows PowerShell: ``> (setx TESTCASE "<testcase_name>") -and (docker-compose up)``

Use the API
-----------

Any Test Case via Public Web-Service
======================================

Installation
------------
There are no installation requirements.

Deploy a Test Case
------------------
Send the following request to <url>:

Use the API
-----------
