# Makefile for building Modelica Docker containers with libraries and run unit tests

# Default values
COMPILER_TOOL=openmodelica
VERSION=1.25.5
IMG_NAME=$(COMPILER_TOOL)_fmu_generator

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  --rm \
	  -it \
	  ${IMG_NAME}
# Help target
help:
	@echo "Usage: make build_compiler_image COMPILER_TOOL=<tool> [OPTIONS]"
	@echo ""
	@echo "Tools:"
	@echo "  openmodelica  - Build OpenModelica container (default)"
	@echo ""
	@echo "Options:"
	@echo "  VERSION=<1.21.1>                   - TOOL version (Open Modelica)"
	@echo "  TOOL_SOURCE_PATH=<source_path>     - TOOL source files path "
	@echo "  TOOL_LICENSE_PATH=<license_path>   - TOOL license path "
	@echo ""
	@echo "Examples:"
	@echo "  make build_compiler_image COMPILER_TOOL=OpenModelica VERSION=1.21.0"
	@echo "=============================================================================================================="	
	@echo "Usage: make compile_testcase_model COMPILER_TOOL=<tool> [OPTIONS]"
	@echo ""
	@echo "Tools:"
	@echo "  OpenModelica  - Build OpenModelica container (default)"
	@echo ""
	@echo "Options:"
	@echo "  TESTCASE=bestest_air                  - testcase to compile"
	@echo ""
	@echo "Example:"
	@echo "  make compile_testcase_model COMPILER_TOOL=OpenModelica TESTCASE=bestest_air"

# Build target

build_compiler_image:
	@echo "Building $(COMPILER_TOOL) compiler container with name $(IMG_NAME)..."
	docker build -f Dockerfile.$(COMPILER_TOOL) \
	--build-arg VERSION=$(VERSION) \
	--tag $(IMG_NAME) .


build_boptest_image:
	cd .. && docker compose build

remove_cimg_image:
	docker rmi ${IMG_NAME}

remove_boptest_image:
	docker rmi project1-boptest-provision project1-boptest-web project1-boptest-worker minio/minio minio/mc redis pafortin/goaws

run_cimg:
	$(COMMAND_RUN)

copy_to_cimg:
	docker cp ../${ARGS} ${IMG_NAME}:/home/boptest/boptest/lib \
	&& docker exec -i --user root ${IMG_NAME} /bin/bash -c "chown -R boptest:boptest /home/boptest/boptest/lib && exit"
	

copy_testcase_to_cimg:
	make copy_to_cimg ARGS=testcases/${TESTCASE}
	docker cp ../testcase.py ${IMG_NAME}:/home/boptest/boptest/lib/${TESTCASE}
	docker cp ../version.txt ${IMG_NAME}:/home/boptest/boptest/lib/${TESTCASE}
	make exec_cimg ARGS="touch /home/boptest/boptest/lib/${TESTCASE}/__init__.py"

copy_from_cimg:
	docker cp ${IMG_NAME}:/home/boptest/boptest/lib/${ARGS} ../${ARGS}

copy_testcase_from_cimg:
	docker cp ${IMG_NAME}:/home/boptest/boptest/lib/${ARGS} ../testcases/${ARGS}

exec_cimg:
	docker exec -i --env USER=boptest ${IMG_NAME} /bin/bash -c "${ARGS}"

stop_cimg:
	docker stop ${IMG_NAME}
# Make sure cimg image stops being used
	python sleep10.py

compile_testcase_model:
	make run_cimg
	make copy_to_cimg ARGS=parsing
	make copy_to_cimg ARGS=testing/set_library_versions.py
	make copy_to_cimg ARGS=testcases/${TESTCASE}
	make exec_cimg ARGS=". miniconda/bin/activate && conda activate pyfmi3 && cd home/boptest/boptest/lib && python set_library_versions.py ${TESTCASE} && cd ${TESTCASE}/models && python compile_fmu.py $(COMPILER_TOOL) && exit"
	make copy_testcase_from_cimg ARGS=${TESTCASE}/models/kpis.json
	make copy_testcase_from_cimg ARGS=${TESTCASE}/models/wrapped.fmu
	make copy_testcase_from_cimg ARGS=${TESTCASE}/models/wrapped.mo
	make stop_cimg

###############################################################################

# Tests
###############################################################################

# Generic test for all testcases except testcase1 and testcase2 to run on travis
test_%_travis:
# Compile testcase model
	make compile_testcase_model TESTCASE=$*
# Build and deploy boptest
	cd .. && docker compose up -d web worker provision
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_$*.py $(ARG)

# Generic test for all testcases except testcase1 and testcase2 to run locally with cleanup
test_%:
# Compile testcase model
	make compile_testcase_model TESTCASE=$* COMPILER_TOOL=openmodelica
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_$*.py $(ARG)
# Stop testcase container
	cd .. && docker compose down
	if [ $(SINGLE) = true ]; then\
	     python report.py;\
	fi\

# Generic test for all testcases that will not test with model compile to run locally with cleanup
test_%_no_compile:
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_$*.py $(ARG)
# Stop testcase container
	cd .. && docker compose down
	if [ $(SINGLE) = true ]; then\
	     python report.py;\
	fi\

test_testcase1:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase1 COMPILER_TOOL=openmodelica
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
	python sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=testcase1 && make run Script=testcase1
# Python and checks
	cd .. && python testing/test_testcase1.py
# Stop testcase container
	cd .. && docker compose down
# Remove julia image
	cd ../examples/julia && make remove-image Script=testcase1
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_testcase2:
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
	python sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=testcase2 && make run Script=testcase2
# Python and checks
	cd .. && python testing/test_testcase2.py
# Stop testcase container
	cd .. && docker compose down
# Remove julia image
	cd ../examples/julia && make remove-image Script=testcase2
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_parser:
	make run_cimg
	make copy_to_cimg ARGS=parsing
	make copy_to_cimg ARGS=data
	make copy_to_cimg ARGS=testing
	make exec_cimg ARGS=". miniconda/bin/activate && conda activate pyfmi3 && cd home/boptest/boptest/lib && python testing/test_parser.py"
	docker cp ${IMG_NAME}:/home/boptest/boptest/lib/testing/references/parser ./references
	docker cp ${IMG_NAME}:/home/boptest/boptest/lib/testing/test_parser.log ./test_parser.log
	make stop_cimg
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_data:
# Run cimg docker container
	make run_cimg
# Copy the required files and folders for the test
	make copy_to_cimg ARGS=data
	make copy_to_cimg ARGS=forecast
	make copy_to_cimg ARGS=kpis
	make copy_to_cimg ARGS=testing
	make copy_testcase_to_cimg TESTCASE=testcase2
	make copy_testcase_to_cimg TESTCASE=testcase3
	docker cp ../testing/references/data/testcase2/kpis.json ${IMG_NAME}:/home/boptest/boptest/lib/testcase2/models
	docker cp ../testing/references/data/testcase3/kpis.json ${IMG_NAME}:/home/boptest/boptest/lib/testcase3/models
# Run test_data.py
	make exec_cimg ARGS=". miniconda/bin/activate && conda activate pyfmi3 && cd home/boptest/boptest/lib && python testing/test_data.py"
	docker cp ${IMG_NAME}:/home/boptest/boptest/lib/testing/references/data ./references
	docker cp ${IMG_NAME}:/home/boptest/boptest/lib/testing/test_data.log ./test_data.log
# Stop cimg docker container
	make stop_cimg
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_forecast:
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
	python sleep10.py
# Copy the required files and folders for testing
	docker cp ./ project1-boptest-worker-1:/boptest/lib/testing
	docker cp ../version.txt project1-boptest-worker-1:/boptest/lib/version.txt
	docker exec -it project1-boptest-worker-1 /bin/bash -c "mkdir /boptest/lib/testcases"
	docker cp ../testcases/testcase2 project1-boptest-worker-1:/boptest/lib/testcases
	docker cp ../testcases/testcase3 project1-boptest-worker-1:/boptest/lib/testcases
	docker cp ../forecast project1-boptest-worker-1:/boptest/lib/forecast
# Run test_forecast.py
	docker exec -i project1-boptest-worker-1 /bin/bash -c ". miniconda/bin/activate && conda activate pyfmi3 && cd /boptest/lib/testing && python test_forecast.py && exit"
	docker cp project1-boptest-worker-1:/boptest/lib/testing/references/forecast ./references
	docker cp project1-boptest-worker-1:/boptest/lib/testing/test_forecast.log ./test_forecast.log
# Stop docker container
	cd .. && docker compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_forecast_uncertainty:
# Build and deploy testcase image
	cd .. && TESTCASE=testcase2 docker-compose up -d
	python sleep10.py
# Run test_forecast_uncertainty.py
	cd .. && python testing/test_forecast_uncertainty.py $(ARG)
# Stop testcase container and report results
	cd .. && docker-compose down
	if [ $(SINGLE) = true ]; then\
	     python report.py;\
	fi\

test_kpis:
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
	python sleep10.py
# Copy the required files and folders for testing
	docker cp ./ project1-boptest-worker-1:/boptest/lib/testing
	docker cp ../version.txt project1-boptest-worker-1:/boptest/lib/version.txt
	docker exec -it project1-boptest-worker-1 /bin/bash -c "mkdir /boptest/lib/testcases"
	docker cp ../testcases/testcase2 project1-boptest-worker-1:/boptest/lib/testcases
	docker cp ../testcases/testcase3 project1-boptest-worker-1:/boptest/lib/testcases
	docker cp ../forecast project1-boptest-worker-1:/boptest/lib/forecast
# Run test_kpis.py
	docker exec -i project1-boptest-worker-1 /bin/bash -c ". miniconda/bin/activate && conda activate pyfmi3 && cd /boptest/lib/testing && python test_kpis.py && exit"
	docker cp project1-boptest-worker-1:/boptest/lib/testing/references/kpis ./references
	docker cp project1-boptest-worker-1:/boptest/lib/testing/test_kpis.log ./test_kpis.log
# Stop docker container
	cd .. && docker compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_bacnet:
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision --scale worker=3
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_bacnet.py
# Stop testcase container
	cd .. && docker compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_testcase:
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
	python sleep10.py
# Copy the required files and folders for testing
	docker cp ./ project1-boptest-worker-1:/boptest/lib/testing
	docker cp ../version.txt project1-boptest-worker-1:/boptest/lib/version.txt
	docker exec -it project1-boptest-worker-1 /bin/bash -c "mkdir /boptest/lib/testcases"
	docker cp ../testcases/bestest_air project1-boptest-worker-1:/boptest/lib/testcases
# Run test_testcase.py
	docker exec -i project1-boptest-worker-1 /bin/bash -c ". miniconda/bin/activate && conda activate pyfmi3 && cd /boptest/lib/testing && python test_testcase.py && exit"
	docker cp project1-boptest-worker-1:/boptest/lib/testing/references/testcase ./references
	docker cp project1-boptest-worker-1:/boptest/lib/testing/test_testcase.log ./test_testcase.log
# Stop testcase container
	cd .. && docker compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_readme_commands:
# Test readme commands work right after instantiation of test case container
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
	python sleep10.py
	curl http://127.0.0.1:80/measurements
	curl http://127.0.0.1:80/forecast
	curl http://127.0.0.1:80/advance -d '{"oveTSetRooHea_u":293.15,"oveTSetRooHea_activate":1, "oveTSetRooCoo_activate":1,"oveTSetRooCoo_u":298.15}' -H "Content-Type: application/json"
	cd .. && docker compose down

###############################################################################

# Run all tests
###############################################################################
test_all:
# Build boptest base image
	make build_boptest_image
# Build cimg
	make build_compiler_image COMPILER_TOOL=openmodelica VERSION=1.25.5
# Run tests
	make test_parser SINGLE=false
	make test_data SINGLE=false
	make test_forecast SINGLE=false
	make test_kpis SINGLE=false
	make test_bacnet SINGLE=false
	make test_testcase SINGLE=false
	make test_readme_commands SINGLE=false
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
