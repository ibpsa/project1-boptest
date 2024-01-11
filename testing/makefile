# Utility Functions
###############################################################################

IMG_NAME=jm
# Set SINGLE to true to run tests as single arguments (as is done in travis.)
# Note that the target test_all sets SINGLE=false so as to run the tests in a batch.
SINGLE=true
TRAVIS=false

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  --rm \
	  -it \
	  ${IMG_NAME}

build_jm_image:
	docker build --no-cache --rm -t ${IMG_NAME} .

build_boptest_image:
	cd .. && docker-compose build

remove_jm_image:
	docker rmi ${IMG_NAME}

remove_boptest_image:
	docker rmi boptest_base

run_jm:
	$(COMMAND_RUN)
	docker cp . ${IMG_NAME}:/usr/local/testing

copy_to_jm:
	docker cp ../${ARGS} ${IMG_NAME}:/usr/local/testing
	docker exec -i ${IMG_NAME} /bin/bash -c "sudo chown -R developer: /usr/local/testing && exit"

copy_testcase_to_jm:
	make copy_to_jm ARGS=testcases/${TESTCASE}
	docker cp ../testcase.py ${IMG_NAME}:/usr/local/testing/${TESTCASE}
	docker cp ../version.txt ${IMG_NAME}:/usr/local/testing/${TESTCASE}
	make exec_jm ARGS="touch ${TESTCASE}/__init__.py"

copy_framework_with_testcase_to_jm:
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=kpis
	make copy_to_jm ARGS=forecast
	docker cp ../testcase.py ${IMG_NAME}:/usr/local/testing
	docker cp ../version.txt ${IMG_NAME}:/usr/local/testing
	docker exec -it ${IMG_NAME} /bin/bash -c "mkdir /usr/local/testing/testcases && exit"
	docker cp ../testcases/${TESTCASE} ${IMG_NAME}:/usr/local/testing/testcases/${TESTCASE}

copy_from_jm:
	docker cp ${IMG_NAME}:/usr/local/testing/${ARGS} ../${ARGS}

copy_testcase_from_jm:
	docker cp ${IMG_NAME}:/usr/local/testing/${ARGS} ../testcases/${ARGS}

exec_jm:
	docker exec -i ${IMG_NAME} /bin/bash -c "cd /usr/local/testing && ${ARGS} && exit"

stop_jm:
	docker stop ${IMG_NAME}
# Make sure jm image stops being used
	python sleep10.py

compile_testcase_model:
	make run_jm
	make copy_to_jm ARGS=parsing
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=testcases/${TESTCASE}
	make exec_jm ARGS="python set_library_versions.py ${TESTCASE} && cd ${TESTCASE}/models && python compile_fmu.py"
	make copy_testcase_from_jm ARGS=${TESTCASE}/models/wrapped.fmu
	make copy_testcase_from_jm ARGS=${TESTCASE}/models/wrapped.mo
	make stop_jm

generate_testcase_data:
	make run_jm
	make copy_to_jm ARGS=parsing
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=testcases/${TESTCASE}
	make exec_jm ARGS="cd ${TESTCASE}/models && python generate_data.py"
	docker cp ${IMG_NAME}:/usr/local/testing/${TESTCASE}/models/Resources ../testcases/${TESTCASE}/models/
	make stop_jm

###############################################################################

# Tests
###############################################################################

# Generic test for all testcases except testcase1 and testcase2 to run on travis
test_%_travis:
# Compile testcase model
	make compile_testcase_model TESTCASE=$*
# Build and deploy testcase image
	cd .. && TESTCASE=$* docker-compose up -d
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_$*.py $(ARG)

# Generic test for all testcases except testcase1 and testcase2 to run locally with cleanup
test_%:
# Compile testcase model
	make compile_testcase_model TESTCASE=$*
# Build and deploy testcase image
	cd .. && TESTCASE=$* docker-compose up -d
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_$*.py $(ARG)
# Stop testcase container
	cd .. && docker-compose down
	if [ $(SINGLE) = true ]; then\
	     python report.py;\
	fi\


test_testcase1:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase1
# Build and deploy testcase image
	cd .. && TESTCASE=testcase1 docker-compose up -d
	python sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=testcase1 && make run Script=testcase1
# Javascript
	cd ../examples/javascript && make build Script=testcase1 && make run Script=testcase1
# Python and checks
	cd .. && python testing/test_testcase1.py
# Stop testcase container
	cd .. && TESTCASE=testcase1 docker-compose down
# Remove testcase image and javascript geckodriver
	cd ../examples/julia && make remove-image Script=testcase1
	cd ../examples/javascript && make remove-image Script=testcase1
	cd ../examples/javascript && rm geckodriver
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_testcase2:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase2
# Build and deploy testcase image
	cd .. && TESTCASE=testcase2 docker-compose up -d
	python sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=testcase2 && make run Script=testcase2
# Javascript
	cd ../examples/javascript && make build Script=testcase2 && make run Script=testcase2
# Python and checks
	cd .. && python testing/test_testcase2.py
# Stop testcase container
	cd .. && TESTCASE=testcase2 docker-compose down
# Remove testcase image and javascript geckodriver
	cd ../examples/julia && make remove-image Script=testcase2
	cd ../examples/javascript && make remove-image Script=testcase2
	cd ../examples/javascript && rm geckodriver
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_parser:
	make run_jm
	make copy_to_jm ARGS=parsing
	make copy_to_jm ARGS=data
	make exec_jm ARGS="python test_parser.py"
	docker cp ${IMG_NAME}:/usr/local/testing/references/parser ./references
	docker cp ${IMG_NAME}:/usr/local/testing/test_parser.log ./test_parser.log
	make stop_jm
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_data:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase2
	make compile_testcase_model TESTCASE=testcase3
# Run jm docker container
	make run_jm
# Copy the required files and folders for the test
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=forecast
	make copy_to_jm ARGS=kpis
	make copy_testcase_to_jm TESTCASE=testcase2
	make copy_testcase_to_jm TESTCASE=testcase3
	docker cp ../testing/references/data/testcase2/kpis.json ${IMG_NAME}:/usr/local/testing/testcase2/models
	docker cp ../testing/references/data/testcase3/kpis.json ${IMG_NAME}:/usr/local/testing/testcase3/models
# Run test_data.py
	make exec_jm ARGS="python test_data.py"
	docker cp ${IMG_NAME}:/usr/local/testing/references/data ./references
	docker cp ${IMG_NAME}:/usr/local/testing/test_data.log ./test_data.log
# Stop jm docker container
	make stop_jm
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_forecast:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase2
	make compile_testcase_model TESTCASE=testcase3
# Run jm docker container
	make run_jm
# Copy the required files and folders for the test
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=forecast
	make copy_to_jm ARGS=kpis
	make copy_testcase_to_jm TESTCASE=testcase2
	make copy_testcase_to_jm TESTCASE=testcase3
# Run test_forecast.py
	make exec_jm ARGS="python test_forecast.py"
	docker cp ${IMG_NAME}:/usr/local/testing/references/forecast ./references
	docker cp ${IMG_NAME}:/usr/local/testing/test_forecast.log ./test_forecast.log
# Stop jm docker container
	make stop_jm
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_kpis:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase2
	make compile_testcase_model TESTCASE=testcase3
# Run jm docker container
	make run_jm
# Copy the required files and folders for the test
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=forecast
	make copy_to_jm ARGS=kpis
	make copy_testcase_to_jm TESTCASE=testcase2
	make copy_testcase_to_jm TESTCASE=testcase3
# Run test_kpis.py
	make exec_jm ARGS="python test_kpis.py"
	docker cp ${IMG_NAME}:/usr/local/testing/references/kpis ./references
	docker cp ${IMG_NAME}:/usr/local/testing/test_kpis.log ./test_kpis.log
# Stop jm docker container
	make stop_jm
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_bacnet:
# Compile testcase model
	make compile_testcase_model TESTCASE=bestest_air
# Build and deploy testcase image
	cd .. && TESTCASE=bestest_air docker-compose up -d
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_bacnet.py
# Stop testcase container
	cd .. && docker-compose down
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_testcase:
# Run jm docker container
	make run_jm
# Copy the required files and folders for the test
	make copy_framework_with_testcase_to_jm TESTCASE=bestest_air
# Run test_kpis.py
	make exec_jm ARGS="python test_testcase.py"
	docker cp ${IMG_NAME}:/usr/local/testing/references/testcase ./references
	docker cp ${IMG_NAME}:/usr/local/testing/test_testcase.log ./test_testcase.log
# Stop jm docker container
	make stop_jm
# Report test results
	if [ $(SINGLE) = true ]; then\
        	python report.py;\
	fi

test_readme_commands:
# Test readme commands work right after instantiation of test case container
	cd .. && TESTCASE=testcase2 docker-compose up -d
	python sleep10.py
	curl http://127.0.0.1:5000/measurements
	curl http://127.0.0.1:5000/forecast
	curl http://127.0.0.1:5000/advance -d '{"oveTSetRooHea_u":293.15,"oveTSetRooHea_activate":1, "oveTSetRooCoo_activate":1,"oveTSetRooCoo_u":298.15}' -H "Content-Type: application/json"
	cd .. && TESTCASE=testcase2 docker-compose down

test_python2:
# Test example controllers written in python run with python 2
# Test testcase1
	cd .. && TESTCASE=testcase1 docker-compose up -d
	python sleep10.py
	cd ../examples/python && python testcase1.py
	cd ../examples/python && python testcase1_scenario.py
	cd .. && TESTCASE=testcase1 docker-compose down
# Test testcase2
	cd .. && TESTCASE=testcase2 docker-compose up -d
	python sleep10.py
	cd ../examples/python && python testcase2.py
	cd .. && TESTCASE=testcase2 docker-compose down
# Test testcase3
	cd .. && TESTCASE=testcase3 docker-compose up -d
	python sleep10.py
	cd ../examples/python && python testcase3.py
	cd .. && TESTCASE=testcase32 docker-compose down

###############################################################################

# Run all tests
###############################################################################
test_all:
# Build jm
	make build_jm_image
# Build boptest base image
	make build_boptest_image
# Run tests
	make test_parser SINGLE=false
	make test_data SINGLE=false
	make test_forecast SINGLE=false
	make test_kpis SINGLE=false
	make test_bacnet SINGLE=false
	make test_testcase SINGLE=false
	make test_readme_commands SINGLE=false
	make test_testcase1 SINGLE=false
	make test_testcase2 SINGLE=false
	make test_testcase3 SINGLE=false
	make test_bestest_air SINGLE=false
	make test_bestest_hydronic SINGLE=false
	make test_bestest_hydronic_heat_pump SINGLE=false
	make test_multizone_residential_hydronic SINGLE=false
	make test_singlezone_commercial_hydronic SINGLE=false
	make test_multizone_office_simple_air SINGLE=false
	make test_twozone_apartment_hydronic SINGLE=false
# Remove jm
	make remove_jm_image
# Remove boptest base image
	make remove_boptest_image
# Report test results
	python report.py
