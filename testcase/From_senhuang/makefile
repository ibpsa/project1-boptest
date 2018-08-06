IMG_NAME=boptest_testcase

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=false \
	  --rm \
	  -i -t \
	  -e DISPLAY=$DISPLAY \
	  --net=host \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  --rm \
	  -v `pwd`:/home/developer/testcase/models/plots \
	  ${IMG_NAME} /bin/bash -c

build:
	docker build --no-cache --rm -t ${IMG_NAME} .

remove-image:
	docker rmi ${IMG_NAME}

run:
	$(COMMAND_RUN) \
             "cd ~/testcase/models && python compile_fmu.py && python run_fmu.py && exit"
