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

copy_from_jm:
	docker cp ${IMG_NAME}:/usr/local/testing/${ARGS} ../${ARGS}

exec_jm:
	docker exec -it ${IMG_NAME} /bin/bash -c "cd /usr/local/testing && ${ARGS} && exit"

stop_jm:
	docker stop ${IMG_NAME}

compile_testcase_model:
	make run_jm
	make ARGS=parsing copy_to_jm
	make ARGS=${TESTCASE} copy_to_jm
	make ARGS="cd ${TESTCASE}/models && python compile_fmu.py" exec_jm
	make ARGS=${TESTCASE}/models/wrapped.fmu copy_from_jm
	make ARGS=${TESTCASE}/models/wrapped.mo copy_from_jm
	make ARGS=${TESTCASE}/models/kpis.json copy_from_jm
	make stop_jm

###############################################################################

# Tests
###############################################################################
test_testcase1:
     # Compile testcase model
	TESTCASE=testcase1 make compile_testcase_model
	# Build testcase image
	cd .. && TESTCASE=testcase1 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase1 make run-detached && sleep 3
	# Run testcase tests
	# Julia
	cd ../examples/julia && Script=twoday_p make build && Script=twoday_p make run
	# Python and checks
	cd .. && python testing/test_testcase1.py
	# Stop testcase container
	cd .. && TESTCASE=testcase1 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase1 make remove-image
	cd ../examples/julia && Script=twoday_p make remove-image

test_testcase2:
     # Compile testcase model
	TESTCASE=testcase2 make compile_testcase_model
	# Build testcase image
	cd .. && TESTCASE=testcase2 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase2 make run-detached && sleep 3
	# Run testcase tests
	# Julia
	cd ../examples/julia && Script=szvav_sup make build && Script=szvav_sup make run
	# Python and checks
	cd .. && python testing/test_testcase2.py
	# Stop testcase container
	cd .. && TESTCASE=testcase2 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase2 make remove-image
	cd ../examples/julia && Script=szvav_sup make remove-image

test_parser:
	make run_jm
	make ARGS=parsing copy_to_jm
	make ARGS="python test_parser.py" exec_jm
	docker cp ${IMG_NAME}:/usr/local/testing/test_parser.log ./test_parser.log
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
	# Remove jm
	make remove_jm_image
	# Report test results
	python report.py

