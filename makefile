IMG_NAME=boptest_${TESTCASE}

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=${DETACH} \
	  --rm \
 	  -it \
	  -p 127.0.0.1:5000:5000 \
	  ${IMG_NAME} /bin/bash -c

build:
	docker build --build-arg testcase=${TESTCASE} --no-cache --rm -t ${IMG_NAME} .

remove-image:
	docker rmi ${IMG_NAME}

run:
	$(COMMAND_RUN) "python restapi.py && bash" \
	&& sleep 3

stop:
	docker stop ${IMG_NAME}

	
