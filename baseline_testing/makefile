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
	docker exec -it ${IMG_NAME} /bin/bash -c "sudo chown -R developer: /usr/local/testing && exit"

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
	docker exec -it ${IMG_NAME} /bin/bash -c "cd /usr/local/testing && ${ARGS} && exit"

stop_jm:
	docker stop ${IMG_NAME}


###############################################################################

# baseline testing
###############################################################################

run_baseline_%:
# Build and deploy testcase image
	cd .. && TESTCASE=$* docker-compose up -d
# Run testcase tests
	python sleep10.py
	cd .. && python baseline_testing/testcase_$*_scenario.py
# Stop testcase container
	cd .. && docker-compose down

run_baseline_all:
	make run_baseline_bestest_air
	make run_baseline_bestest_hydronic
	make run_baseline_bestest_hydronic_heat_pump
	make run_baseline_multizone_residential_hydronic
	make run_baseline_singlezone_commercial_hydronic
	make run_baseline_multizone_office_simple_air