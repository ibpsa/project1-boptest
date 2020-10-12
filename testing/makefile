# Utility Functions
###############################################################################

IMG_NAME=jm

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  --rm \
	  -it \
	  ${IMG_NAME}

build_jm_image:
	docker build --no-cache --rm -t ${IMG_NAME} .

remove_jm_image:
	docker rmi ${IMG_NAME}

run_jm:
	$(COMMAND_RUN)
	docker cp . ${IMG_NAME}:/usr/local/testing

copy_to_jm:
	docker cp ../${ARGS} ${IMG_NAME}:/usr/local/testing
	docker exec -it ${IMG_NAME} /bin/bash -c "sudo chown -R developer: /usr/local/testing && exit"

copy_testcase_to_jm:
	make copy_to_jm ARGS=testcases/${TESTCASE}
	docker cp ../testcase.py ${IMG_NAME}:/usr/local/testing/${TESTCASE}
	make exec_jm ARGS="touch ${TESTCASE}/__init__.py"
	
copy_from_jm:
	docker cp ${IMG_NAME}:/usr/local/testing/${ARGS} ../${ARGS}

copy_testcase_from_jm:
	docker cp ${IMG_NAME}:/usr/local/testing/${ARGS} ../testcases/${ARGS}

exec_jm:
	docker exec -it ${IMG_NAME} /bin/bash -c "cd /usr/local/testing && ${ARGS} && exit"

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
	docker cp ${IMG_NAME}:/usr/local/testing/testcases/${TESTCASE}/models/Resources ../testcases/${TESTCASE}/models/
	make stop_jm

###############################################################################

# Tests
###############################################################################
test_testcase1:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase1
# Build testcase image
	cd .. &&  make build TESTCASE=testcase1
# Deploy testcase container
	cd .. && make run-detached TESTCASE=testcase1
	python sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=testcase1 && make run Script=testcase1
# Python and checks
	cd .. && python testing/test_testcase1.py
# Stop testcase container
	cd .. && make stop TESTCASE=testcase1
# Remove testcase image
	cd ../examples/julia && make remove-image Script=testcase1

test_testcase2:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase2 
# Build testcase image
	cd .. && make build TESTCASE=testcase2
# Deploy testcase container
	cd .. && make run-detached TESTCASE=testcase2
	python sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=testcase2 && make run Script=testcase2
# Python and checks
	cd .. && python testing/test_testcase2.py
# Stop testcase container
	cd .. && make stop TESTCASE=testcase2
# Remove testcase image
	cd ../examples/julia && make remove-image Script=testcase2
	
test_bestest_air:
# Compile testcase model
	make compile_testcase_model TESTCASE=bestest_air
# Build testcase image
	cd .. &&  make build TESTCASE=bestest_air
# Deploy testcase container
	cd .. && make run-detached TESTCASE=bestest_air
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_bestest_air.py
# Stop testcase container
	cd .. && make stop TESTCASE=bestest_air

test_testcase3:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase3
# Build testcase image
	cd .. &&  make build TESTCASE=testcase3
# Deploy testcase container
	cd .. && make run-detached TESTCASE=testcase3
	python sleep10.py
# Run testcase tests
# Python and checks
	cd .. && python testing/test_testcase3.py
# Stop testcase container
	cd .. && make stop TESTCASE=testcase3
	
test_bestest_hydronic:
# Compile testcase model
	make compile_testcase_model TESTCASE=bestest_hydronic
# Build testcase image
	cd .. &&  make build TESTCASE=bestest_hydronic
# Deploy testcase container
	cd .. && make run-detached TESTCASE=bestest_hydronic
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_bestest_hydronic.py
# Stop testcase container
	cd .. && make stop TESTCASE=bestest_hydronic

test_bestest_hydronic_heat_pump:
# Compile testcase model
	make compile_testcase_model TESTCASE=bestest_hydronic_heat_pump
# Build testcase image
	cd .. &&  make build TESTCASE=bestest_hydronic_heat_pump
# Deploy testcase container
	cd .. && make run-detached TESTCASE=bestest_hydronic_heat_pump
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_bestest_hydronic_heat_pump.py
# Stop testcase container
	cd .. && make stop TESTCASE=bestest_hydronic_heat_pump

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

###############################################################################

# Run all tests
###############################################################################
test_all:
# Build jm
	make build_jm_image
# Run tests
	make test_parser
	make test_data
	make test_forecast
	make test_kpis
	make test_testcase1
	make test_testcase2
	make test_testcase3
	make test_bestest_air
	make test_bestest_hydronic
	make test_bestest_hydronic_heat_pump
# Remove jm
	make remove_jm_image
# Report test results
	python report.py

