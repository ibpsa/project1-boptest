IMG_NAME=boptest_${TESTCASE}
APP_PATH=/home/developer

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --rm \
 	  -it \
	  -p 127.0.0.1:5000:5000

COMMAND_COPY=docker cp ./testcases/${TESTCASE}/models/wrapped.fmu ${IMG_NAME}:${APP_PATH}/models/wrapped.fmu && \
      docker cp ./testcases/${TESTCASE}/doc/ ${IMG_NAME}:${APP_PATH}/doc/ && \
      docker cp restapi.py ${IMG_NAME}:${APP_PATH}/restapi.py && \
      docker cp testcase.py ${IMG_NAME}:${APP_PATH}/testcase.py && \
      docker cp version.txt ${IMG_NAME}:${APP_PATH}/version.txt && \
      docker cp  ./data ${IMG_NAME}:${APP_PATH}/data/ && \
      docker cp ./forecast ${IMG_NAME}:${APP_PATH}/forecast/ && \
      docker cp ./kpis ${IMG_NAME}:${APP_PATH}/kpis/

build:
	docker build --no-cache --rm -t ${IMG_NAME} -f Dockerfile . && \
	echo WARNING: Use of make for building and running BOPTEST test cases is deprecated.  Please use docker-compose as outlined in the README.md.

remove-image:
	docker rmi ${IMG_NAME}

run:
	$(COMMAND_RUN) --detach=true ${IMG_NAME} /bin/bash -c "bash" && \
	$(COMMAND_COPY) && \
	docker exec -it ${IMG_NAME} python restapi.py && \
	docker stop ${IMG_NAME} && \
	echo WARNING: Use of make for building and running BOPTEST test cases is deprecated.  Please use docker-compose as outlined in the README.md.


run-detached:
	$(COMMAND_RUN) --detach=true ${IMG_NAME} /bin/bash -c "bash" && \
	$(COMMAND_COPY) && \
	docker exec -itd ${IMG_NAME} python restapi.py && \
	echo WARNING: Use of make for building and running BOPTEST test cases is deprecated.  Please use docker-compose as outlined in the README.md.

stop:
	docker stop ${IMG_NAME}
