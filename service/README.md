# BOPTEST-Service

This software extends [BOPTEST](https://github.com/ibpsa/project1-boptest) to a web service architecture, which enables support for multiple clients and multiple simultaneous tests at a large scale. This is a containerized design that can be deployed on a personal computer, however the software is targeted at commercial cloud computing environments such as AWS. For details about BOPTEST, refer to the project [homepage](https://boptest.net).

This service uses the canonical BOPTEST source code located at the root of this repository under the terms of the license located at `<project-root>/boptest/license.md.

BOPTEST-Service is a sibling of [Alfalfa](https://github.com/NREL/alfalfa), which follows the same architecture, but adopts a more general purpose API to support interactive building simulation, whereas the BOPTEST API is designed around predetermined test scenarios.

```mermaid
flowchart LR
    A[API Client] <--> B[Web Frontend]
    subgraph cloud [Cloud Deployment]
            B <--> C[(Message Broker)]
            C <--> D[Worker 1]
            C <--> E[Worker 2]
            C <--> F[Worker N]
        subgraph workers [Worker Pool]
            D
            E
            F
        end
    end
```

# Getting Started

A simple demonstration of using the BOPTEST API is available in this [interactive tutorial](https://colab.research.google.com/github/NREL/boptest-service/blob/develop/docs/Introduction_to_BOPTEST_Service_APIs.ipynb). This tutorial leverages a publicly available deployment of BOPTEST-Service, which can be reached at https://api.boptest.net.

# BOPTEST-Service APIs

The core BOPTEST APIs are [documented](https://github.com/ibpsa/project1-boptest#test-case-restful-api) as part of the upstream BOPTEST project. The BOPTEST-Service defines a number of APIs on top of BOPTEST for the purpose of managing test cases and running tests.

| Description                                                                                                                 | Request                                                    |
| --------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------
| List official BOPTEST test cases.                                                                                           | GET `testcases`                                            |
| List unofficial test cases in a namespace.                                                                                  | GET `testcases/{namespace}`                                |
| List private user test cases. (Auth required)                                                                               | GET `users/{username}/testcases/`                          |
| Check if specific test case exists.                                                                                         | GET `testcases/{testcase_name}`                            |
| Check if specific test case exists in the namespace.                                                                        | GET `testcases/{namespace}/{testcase_name}`                |
| Check if specific private user test case exists.                                                                            | GET `users/{username}/testcases/{testcase_name}`           |
| Select a test case and begin a new test. (Auth optional)                                                                    | POST ``testcases/{testcase_name}/select``                  |
| Select a test case from the namespace and begin a new test. (Auth optional)                                                 | POST ``testcases/{namespace}/{testcase_name}/select``      |
| Select a private user test case and begin a new test. (Auth required)                                                       | POST ``users/{username}/testcases/{testcase_name}/select`` |
| Get test status as `Running` or `Queued`                                                                                    | GET ``status/{testid}``                                    |
| Stop a queued or running test.                                                                                              | PUT ``stop/{testid}``                                      |
| List tests for a user. (Auth required)                                                                                      | GET ``users/{username}/tests``                             |

The family of the `select` APIs are used to choose a test case and begin a running test. Select returns a `testid` which is required by all APIs that interact with the test or provide test information.

# OpenAI Gym Interface

An [OpenAI-Gym](https://github.com/openai/gym) environment for BOPTEST is [available](https://github.com/ibpsa/project1-boptest-gym).

# Building and Running on a Personal Computer
1) Clone this repository.

``git clone https://github.com/NREL/boptest-service.git``

2) Install [Docker](https://docs.docker.com/get-docker/).

3) Use Docker to build and run BOPTEST-Service.

``docker compose up web worker provision``

4) In a separate process, use the core [BOPTEST APIs](https://github.com/ibpsa/project1-boptest/tree/boptest-service#test-case-restful-api) as well as [BOPTEST-service APIs](https://github.com/NREL/boptest-service/blob/develop/README.md#boptest-service-apis) to interact with the test case using your test controller.

5) Shutdown the test case by the command ``docker compose down`` executed in the root directory of this repository.

# Kubernetes Based Deployment

NREL maintains a helm chart for Kubernetes based deployments of BOPTEST-Service.

# Running the developer Test Suite

Testing is based on the BOPTEST [test suite](https://github.com/NREL/boptest-service/tree/develop/boptest/testing) with small adaptations to conform to the BOPTEST-Service API. Follow the [README](https://github.com/NREL/boptest-service/blob/develop/boptest/testing/README.md) for more information.
