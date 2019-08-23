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

copy_from_jm:
	docker cp ${IMG_NAME}:/usr/local/testing/${ARGS} ../${ARGS}

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
	make copy_to_jm ARGS=${TESTCASE}
	make exec_jm ARGS="cd ${TESTCASE}/models && python compile_fmu.py"
	make copy_from_jm ARGS=${TESTCASE}/models/wrapped.fmu
	make copy_from_jm ARGS=${TESTCASE}/models/wrapped.mo
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
	cd ../examples/julia && make build Script=twoday_p && make run Script=twoday_p
# Python and checks
	cd .. && python testing/test_testcase1.py
# Stop testcase container
	cd .. && make stop TESTCASE=testcase1
# Remove testcase image
	cd ../examples/julia && make remove-image Script=twoday_p

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
	cd ../examples/julia && make build Script=szvav_sup && make run Script=szvav_sup
# Python and checks
	cd .. && python testing/test_testcase2.py
# Stop testcase container
	cd .. && make stop TESTCASE=testcase2
# Remove testcase image
	cd ../examples/julia && make remove-image Script=szvav_sup

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
# Run jm docker container
	make run_jm
# Copy the required files and folders for the test
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=forecast
	make copy_to_jm ARGS=kpis
	make copy_to_jm ARGS=testcase2/models
	make copy_to_jm ARGS=testcase2/config.py
	make copy_to_jm ARGS=testcase.py
	docker cp ../testing/references/data/kpis.json ${IMG_NAME}:/usr/local/testing/models
# Run test_data.py
	make exec_jm ARGS="python test_data.py"
	docker cp ${IMG_NAME}:/usr/local/testing/references/data ./references
	docker cp ${IMG_NAME}:/usr/local/testing/test_data.log ./test_data.log
# Stop jm docker container
	make stop_jm
	
test_forecast:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase2
# Run jm docker container
	make run_jm
# Copy the required files and folders for the test
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=forecast
	make copy_to_jm ARGS=kpis
	make copy_to_jm ARGS=testcase2/models
	make copy_to_jm ARGS=testcase2/config.py
	make copy_to_jm ARGS=testcase.py
# Run test_data.py
	make exec_jm ARGS="python test_forecast.py"
	docker cp ${IMG_NAME}:/usr/local/testing/references/forecast ./references
	docker cp ${IMG_NAME}:/usr/local/testing/test_forecast.log ./test_forecast.log
# Stop jm docker container
	make stop_jm
	
test_kpis:
# Run jm docker container
	make run_jm
# Copy the required files and folders for the test
	make copy_to_jm ARGS=data
	make copy_to_jm ARGS=forecast
	make copy_to_jm ARGS=kpis
	make copy_to_jm ARGS=testcase2/models
	make copy_to_jm ARGS=testcase2/config.py
	make copy_to_jm ARGS=testcase.py
# Run test_data.py
	make exec_jm ARGS="python test_kpis.py"
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
	make test_testcase1
	make test_testcase2
	make test_data
	make test_forecast
# Remove jm
	make remove_jm_image
# Report test results
	python report.py

