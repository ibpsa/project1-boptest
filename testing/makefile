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
	docker build --no-cache --rm -q -t ${IMG_NAME} .

build_boptest_image:
	cd .. && docker compose build

remove_jm_image:
	docker rmi ${IMG_NAME}

remove_boptest_image:
	docker rmi project1-boptest-provision project1-boptest-web project1-boptest-worker minio/minio minio/mc redis pafortin/goaws

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
# Build and deploy boptest
	cd .. && docker compose up -d web worker provision
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_$*.py $(ARG)

# Generic test for all testcases except testcase1 and testcase2 to run locally with cleanup
test_%:
# Compile testcase model
	make compile_testcase_model TESTCASE=$*
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
	make compile_testcase_model TESTCASE=testcase1
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
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase2
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
# Compile testcase model
	make compile_testcase_model TESTCASE=bestest_air
# Build and deploy testcase image
	cd .. && docker compose build -q web worker provision
	cd .. && docker compose up -d --quiet-pull web worker provision
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
	make test_multizone_office_simple_hydronic SINGLE=false
	make test_twozone_apartment_hydronic SINGLE=false
# Remove jm
	make remove_jm_image
# Remove boptest base image
	make remove_boptest_image
# Report test results
	python report.py
