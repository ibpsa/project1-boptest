IMG_NAME=jm

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  -e DISPLAY=${DISPLAY} \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  --rm \
	  -it \
	  -v `pwd`:/mnt/shared/testing \
	  ${IMG_NAME}

build_jm_image:
	docker build --no-cache --rm -t ${IMG_NAME} .

remove_jm_image:
	docker rmi ${IMG_NAME}

run_jm:
	$(COMMAND_RUN)
	cp -r ../parsing ./parsing
	docker exec -it ${IMG_NAME} /bin/bash -c "cd /mnt/shared/testing && ${ARGS} && exit"
	docker stop ${IMG_NAME}
	rm -r parsing

test_testcase1:
     # Compile testcase model
	cp -r ../testcase1/models ./models && make run_jm ARGS="cd models && python compile_fmu.py"
	cp models/wrapped.fmu ../testcase1/models
	cp models/kpis.json ../testcase1/models
	rm -r models
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
	cp -r ../testcase2/models ./models && make run_jm ARGS="cd models && python compile_fmu.py"
	cp models/wrapped.fmu ../testcase2/models
	cp models/kpis.json ../testcase2/models
	rm -r models
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
	make run_jm ARGS="python test_parser.py"

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

