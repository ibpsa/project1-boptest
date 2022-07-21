# Utility Functions
###############################################################################

IMG_NAME=jm

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
		-i \
	  --rm \
	  ${IMG_NAME}

build_jm_image:
	docker build --no-cache --rm -t ${IMG_NAME} .

build_boptest_image:
	cd .. && docker-compose build

remove_jm_image:
	docker rmi ${IMG_NAME}

remove_boptest_image:
	cd .. && docker-compose down

run_jm:
	$(COMMAND_RUN)
	docker cp . ${IMG_NAME}:/usr/local/testing

copy_to_jm:
	docker cp ../${ARGS} ${IMG_NAME}:/usr/local/testing
	docker exec ${IMG_NAME} /bin/bash -c "sudo chown -R developer: /usr/local/testing && exit"

copy_testcase_to_jm:
	make copy_to_jm ARGS=testcases/${TESTCASE}
	docker cp ../testcase.py ${IMG_NAME}:/usr/local/testing/${TESTCASE}
	docker cp ../version.txt ${IMG_NAME}:/usr/local/testing/${TESTCASE}
	make exec_jm ARGS="touch ${TESTCASE}/__init__.py"

copy_from_jm:
	docker cp ${IMG_NAME}:/usr/local/testing/${ARGS} ../${ARGS}

copy_testcase_from_jm:
	docker cp ${IMG_NAME}:/usr/local/testing/${ARGS} ../testcases/${ARGS}

exec_jm:
	docker exec ${IMG_NAME} /bin/bash -c "cd /usr/local/testing && ${ARGS} && exit"

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
status = $$(curl -s -o /dev/null -I -w "%{http_code}" http://127.0.0.1/version | xargs echo)

# Generic test for all testcases. e.g. test_testcase1
test_%:
# Build and start the service if it is not running
	if [ ${status} -ne 200 ]; then \
		make -C ../ build; make -C ../ run-detached; python sleep10.py; \
	fi
# Compile testcase model
	make compile_testcase_model TESTCASE=$*
# Upload the testcase fmu to the service
	make -C ../ provision TESTCASE=$*
# Python and checks
	cd .. && python testing/test_$*.py

test_parser:
	make run_jm
	make copy_to_jm ARGS=parsing
	make copy_to_jm ARGS=data
	make exec_jm ARGS="python test_parser.py"
	docker cp ${IMG_NAME}:/usr/local/testing/references/parser ./references
	docker cp ${IMG_NAME}:/usr/local/testing/test_parser.log ./test_parser.log
	make stop_jm

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

test_readme_commands:
# Test readme commands work right after instantiation of test case container
	curl http://127.0.0.1/measurements
	curl http://127.0.0.1/forecast
	curl http://127.0.0.1/advance -d '{"oveTSetRooHea_u":293.15,"oveTSetRooHea_activate":1, "oveTSetRooCoo_activate":1,"oveTSetRooCoo_u":298.15}' -H "Content-Type: application/json"
	cd .. && TESTCASE=testcase2 docker-compose down

###############################################################################

# Run all tests
###############################################################################
test_all:
# Build jm
	make build_jm_image
	make test_parser
	make test_data
	make test_forecast
	make test_kpis
	# make test_readme_commands
	make test_testcase1
	make test_testcase2
	make test_testcase3
	make test_bestest_air
	make test_bestest_hydronic
	make test_bestest_hydronic_heat_pump
	make test_multizone_residential_hydronic
	make test_singlezone_commercial_hydronic
	make test_multizone_office_simple_air
# Remove jm
	make remove_jm_image
# Remove boptest base image
	make remove_boptest_image
# Report test results
	python report.py
