# Object Storage

BOPTEST-Service depends on object-based storage for retaining test cases and test output files. In a production environment this is intended to be Amazon S3, however [Minio](https://min.io) provides a S3 compaitable API, so in local development and even some production environments Minio is used. The purpose of this document is to define the organization of object keys used by BOPTEST-Service. S3 (and Minio's implementation of the S3 API) is not intrinsically hierarchical, however `/` characters used in key names are treated as delimiters by many of the S3 APIs, and BOPTEST-Service uses this delimiter for organizational purposes.

## Test case files

Test cases are added to BOPTEST-Service by uploading fmu files to object storage using the following naming convention as the key for each test case.

For the canonical BOPTEST testcases:
```
testcases/<testcase_id>/<testcase_id>.fmu
```
For unofficial test cases can be stored within an arbitrary namespace:
```
testcases/<namespace>/<testcase_id>/<testcase_id>.fmu
```
For user specific test cases:
```
users/<usersub>/testcases/<testcase_id>/<testcase_id>.fmu
```
where `usersub` is the OAuth user "sub".

## Test results

When a test is completed, the entire working directory of the test is archived and stored in object storage using the following key naming conventions.
```
tests/<test_id>.tar.gz
```
