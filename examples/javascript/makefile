IMG_NAME=javascript_controller

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  --rm \
 	  -it \
 	  --network host \
 	  ${IMG_NAME} /bin/bash

build:
	docker build --no-cache --rm -t ${IMG_NAME} .

remove-image:
	docker rmi ${IMG_NAME}

run:
	$(COMMAND_RUN) && \
	docker cp . ${IMG_NAME}:/home && \
	docker exec -it ${IMG_NAME} /bin/bash -c "python3 wrapper.py ${Script}" && \
	make copy_from_container ARGS=. && \
	docker stop ${IMG_NAME}

copy_from_container:
	docker cp ${IMG_NAME}:/home/${ARGS} ${ARGS}

stop:
	docker stop ${IMG_NAME}
