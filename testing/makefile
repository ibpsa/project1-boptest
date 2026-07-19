# Makefile for building OpenModelica Docker container with Modelica libraries and run unit tests

# Default values
VERSION=1.26.8
IMG_NAME=openmodelica_fmu_generator

COMMAND_RUN=sudo docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  --rm \
	  -it \
	  -v ${PWD}/../:/home/compiler/boptest \
	  ${IMG_NAME}

# Options for CI testing
SINGLE=true

# If can't just use 'python' command for virtual environment (as in travis and github actions), set 'python' command to use local CI venv
ifeq (, $(shell which python))
	VENV_CI=${HOME}/.venvs/boptest_unit_tests
	PYTHON_CI=${VENV_CI}/bin/python
else
	PYTHON_CI=python
endif

# Help target
help:
	@echo "Usage: make build_compiler_image VERSION=<x.x.x>"
	@echo ""
	@echo "Options:"
	@echo "  VERSION                   - OpenModelica version, default if not specified is 1.26.8"
	@echo ""
	@echo "Examples:"
	@echo "  make build_compiler_image VERSION=1.26.8"
	@echo "==============================================================="
	@echo "Usage: make compile_testcase_model TESTCASE=<testcase>"
	@echo ""
	@echo "Options:"
	@echo "  TESTCASE                  - testcase to compile"
	@echo ""
	@echo "Example:"
	@echo "  make compile_testcase_model TESTCASE=bestest_air"

# Build target

build_compiler_image:
	@echo "Building openmodelica compiler container with name $(IMG_NAME)..."
	sudo docker build -f Dockerfile.openmodelica \
	--build-arg VERSION=$(VERSION) \
	--tag $(IMG_NAME) .


build_boptest_image:
	cd .. && sudo docker compose build

remove_cimg_image:
	sudo docker rmi ${IMG_NAME}

remove_boptest_image:
	sudo docker rmi project1-boptest-provision project1-boptest-web project1-boptest-worker minio/minio minio/mc redis pafortin/goaws

run_cimg:
	$(COMMAND_RUN)

copy_to_cimg:
	sudo docker cp ../${ARGS} ${IMG_NAME}:/home/compiler/testing


copy_testcase_to_cimg:
	make copy_to_cimg ARGS=testcases/${TESTCASE}
	sudo docker cp ../testcase.py ${IMG_NAME}:/home/compiler/testing/${TESTCASE}
	sudo docker cp ../version.txt ${IMG_NAME}:/home/compiler/testing/${TESTCASE}
	make exec_cimg ARGS="touch /home/compiler/testing/testing/${TESTCASE}/__init__.py"

copy_from_cimg:
	sudo docker cp ${IMG_NAME}:/home/compiler/${ARGS} ../${ARGS}

copy_testcase_from_cimg:
	sudo docker cp ${IMG_NAME}:/home/compiler/${ARGS} ../testcases/${ARGS}

exec_cimg:
	sudo docker exec -i --env USER=compiler ${IMG_NAME} /bin/bash -c "${ARGS}"

stop_cimg:
	sudo docker stop ${IMG_NAME}
# Make sure cimg image stops being used
	${PYTHON_CI} sleep10.py

compile_testcase_model:
	make run_cimg
	make exec_cimg ARGS=". miniconda/bin/activate && conda activate pyfmi3 && cd /home/compiler/boptest && python testing/set_library_versions.py testcases/${TESTCASE} && cd /home/compiler/boptest/testcases/${TESTCASE}/models && python compile_fmu.py --tool openmodelica --algorithm cvode && exit"
	make stop_cimg

###############################################################################

# Tests
###############################################################################

# Generic test for all testcases except testcase1 and testcase2 to run locally with cleanup
test_%:
# Compile testcase model
	make compile_testcase_model TESTCASE=$*
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision
	${PYTHON_CI} sleep10.py
# Run testcase tests
	cd .. && ${PYTHON_CI} testing/test_$*.py $(ARG)
# Stop testcase container
	cd .. && sudo docker compose down
	if [ $(SINGLE) = true ]; then\
	     ${PYTHON_CI} report.py;\
	fi\

# Generic test for all testcases that will not test with model compile to run locally with cleanup
test_%_no_compile:
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision
	${PYTHON_CI} sleep10.py
# Run testcase tests
	cd .. && ${PYTHON_CI} testing/test_$*.py $(ARG)
# Stop testcase container
	cd .. && sudo docker compose down
	if [ $(SINGLE) = true ]; then\
	     ${PYTHON_CI} report.py;\
	fi\

# Test podman deployment using a generic testcase test (bestest_air)
test_podman:
# Build and deploy testcase image
	cd .. && podman compose build -q web worker provision
	cd .. && podman compose up -d web worker provision
	${PYTHON_CI} sleep10.py
# Run testcase tests
	cd .. && ${PYTHON_CI} testing/test_bestest_air.py $(ARG)
# Stop testcase container
	cd .. && podman compose down
	if [ $(SINGLE) = true ]; then\
	     ${PYTHON_CI} report.py;\
	fi\

test_testcase1:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase1
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision
	${PYTHON_CI} sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=testcase1 && make run Script=testcase1
# Python and checks
	cd .. && ${PYTHON_CI} testing/test_testcase1.py
# Stop testcase container
	cd .. && sudo docker compose down
# Remove julia image
	cd ../examples/julia && make remove-image Script=testcase1
# Report test results
	if [ $(SINGLE) = true ]; then\
        	${PYTHON_CI} report.py;\
	fi

test_testcase2:
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision
	${PYTHON_CI} sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=testcase2 && make run Script=testcase2
# Python and checks
	cd .. && ${PYTHON_CI} testing/test_testcase2.py
# Stop testcase container
	cd .. && sudo docker compose down
# Remove julia image
	cd ../examples/julia && make remove-image Script=testcase2
# Report test results
	if [ $(SINGLE) = true ]; then\
        	${PYTHON_CI} report.py;\
	fi

test_parser:
# Run cimg docker container
	make run_cimg
# Run test_parser.py
	make exec_cimg ARGS=". miniconda/bin/activate && conda activate pyfmi3 && cd /home/compiler/boptest/testing && python test_parser.py"
# Stop cimg docker container
	make stop_cimg
# Report test results
	if [ $(SINGLE) = true ]; then\
        	${PYTHON_CI} report.py;\
	fi

test_data:
# Run cimg docker container
	make run_cimg
# Run test_data.py
	make exec_cimg ARGS=". miniconda/bin/activate && conda activate pyfmi3 && cd /home/compiler/boptest/testing && python test_data.py"
# Stop cimg docker container
	make stop_cimg
# Report test results
	if [ $(SINGLE) = true ]; then\
        	${PYTHON_CI} report.py;\
	fi

test_forecast:
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision
	${PYTHON_CI} sleep10.py
# Copy the required files and folders for testing
	sudo docker cp ./ project1-boptest-worker-1:/boptest/lib/testing
	sudo docker cp ../version.txt project1-boptest-worker-1:/boptest/lib/version.txt
	sudo docker exec -it project1-boptest-worker-1 /bin/bash -c "mkdir /boptest/lib/testcases"
	sudo docker cp ../testcases/testcase2 project1-boptest-worker-1:/boptest/lib/testcases
	sudo docker cp ../testcases/testcase3 project1-boptest-worker-1:/boptest/lib/testcases
	sudo docker cp ../forecast project1-boptest-worker-1:/boptest/lib/forecast
# Run test_forecast.py
	sudo docker exec -i project1-boptest-worker-1 /bin/bash -c ". miniconda/bin/activate && conda activate pyfmi3 && cd /boptest/lib/testing && python test_forecast.py && exit"
	sudo docker cp project1-boptest-worker-1:/boptest/lib/testing/references/forecast ./references
	sudo docker cp project1-boptest-worker-1:/boptest/lib/testing/test_forecast.log ./test_forecast.log
# Stop docker container
	cd .. && sudo docker compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	${PYTHON_CI} report.py;\
	fi

test_forecast_uncertainty:
# Build and deploy testcase image
	cd .. && TESTCASE=testcase2 sudo docker-compose up -d
	${PYTHON_CI} sleep10.py
# Run test_forecast_uncertainty.py
	cd .. && ${PYTHON_CI} testing/test_forecast_uncertainty.py $(ARG)
# Stop testcase container and report results
	cd .. && sudo docker-compose down
	if [ $(SINGLE) = true ]; then\
	     ${PYTHON_CI} report.py;\
	fi\

test_kpis:
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision
	${PYTHON_CI} sleep10.py
# Copy the required files and folders for testing
	sudo docker cp ./ project1-boptest-worker-1:/boptest/lib/testing
	sudo docker cp ../version.txt project1-boptest-worker-1:/boptest/lib/version.txt
	sudo docker exec -it project1-boptest-worker-1 /bin/bash -c "mkdir /boptest/lib/testcases"
	sudo docker cp ../testcases/testcase2 project1-boptest-worker-1:/boptest/lib/testcases
	sudo docker cp ../testcases/testcase3 project1-boptest-worker-1:/boptest/lib/testcases
	sudo docker cp ../forecast project1-boptest-worker-1:/boptest/lib/forecast
# Run test_kpis.py
	sudo docker exec -i project1-boptest-worker-1 /bin/bash -c ". miniconda/bin/activate && conda activate pyfmi3 && cd /boptest/lib/testing && python test_kpis.py && exit"
	sudo docker cp project1-boptest-worker-1:/boptest/lib/testing/references/kpis ./references
	sudo docker cp project1-boptest-worker-1:/boptest/lib/testing/test_kpis.log ./test_kpis.log
# Stop docker container
	cd .. && sudo docker compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	${PYTHON_CI} report.py;\
	fi

test_bacnet:
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision --scale worker=3
	${PYTHON_CI} sleep10.py
# Run testcase tests
	cd .. && ${PYTHON_CI} testing/test_bacnet.py
# Stop testcase container
	cd .. && sudo docker compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	${PYTHON_CI} report.py;\
	fi

test_testcase:
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision
	${PYTHON_CI} sleep10.py
# Copy the required files and folders for testing
	sudo docker cp ./ project1-boptest-worker-1:/boptest/lib/testing
	sudo docker cp ../version.txt project1-boptest-worker-1:/boptest/lib/version.txt
	sudo docker exec -it project1-boptest-worker-1 /bin/bash -c "mkdir /boptest/lib/testcases"
	sudo docker cp ../testcases/bestest_air project1-boptest-worker-1:/boptest/lib/testcases
# Run test_testcase.py
	sudo docker exec -i project1-boptest-worker-1 /bin/bash -c ". miniconda/bin/activate && conda activate pyfmi3 && cd /boptest/lib/testing && python test_testcase.py && exit"
	sudo docker cp project1-boptest-worker-1:/boptest/lib/testing/references/testcase ./references
	sudo docker cp project1-boptest-worker-1:/boptest/lib/testing/test_testcase.log ./test_testcase.log
# Stop testcase container
	cd .. && sudo docker compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	${PYTHON_CI} report.py;\
	fi

test_autogen_client:
# Test automatic generation of python client from OpenAPI Spec
# Build and deploy testcase image
	cd .. && sudo docker compose build -q web worker provision
	cd .. && sudo docker compose up -d --quiet-pull web worker provision
	${PYTHON_CI} sleep10.py
# Run openapi-python-client to autogenerate api client
	openapi-python-client generate --url http://127.0.0.1:8000/openapi.yaml --output-path ../examples/python/autogenerated_client/output $(ARG)
# Run the autogenerated client using the example usage.py
	${PYTHON_CI} ../examples/python/autogenerated_client/usage.py
# Stop testcase container
	cd .. && sudo docker compose down

###############################################################################

# Run all tests
###############################################################################
test_all:
# Build boptest base image
	make build_boptest_image
# Build cimg
	make build_compiler_image VERSION=$(VERSION)
# Run tests
	make test_parser SINGLE=false
	make test_data SINGLE=false
	make test_forecast SINGLE=false
	make test_kpis SINGLE=false
	make test_bacnet SINGLE=false
	make test_testcase SINGLE=false
	make test_testcase1 SINGLE=false
	make test_testcase2_no_compile SINGLE=false
	make test_testcase3 SINGLE=false
	make test_bestest_air_no_compile SINGLE=false
	make test_bestest_hydronic_no_compile SINGLE=false
	make test_bestest_hydronic_heat_pump_no_compile SINGLE=false
	make test_multizone_residential_hydronic_no_compile SINGLE=false
	make test_singlezone_commercial_hydronic_no_compile SINGLE=false
	make test_multizone_office_complex_air_no_compile SINGLE=false
	make test_multizone_office_simple_air_no_compile SINGLE=false
	make test_multizone_office_simple_hydronic_no_compile SINGLE=false
	make test_twozone_apartment_hydronic_no_compile SINGLE=false
# Remove cimg
	make remove_cimg_image
# Remove boptest base image
	make remove_boptest_image
# Report test results
	python report.py
