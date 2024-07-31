IMG_NAME=julia_controller_${Script}

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  --rm \
 	  -it \
 	  --network host \
 	  ${IMG_NAME} /bin/bash

build:
	docker build --quiet --build-arg testcase=${Script} --no-cache --rm -t ${IMG_NAME} .

remove-image:
	docker rmi ${IMG_NAME}

run:
	$(COMMAND_RUN) && \
	docker cp . ${IMG_NAME}:/usr/myapp && \
	docker exec -it ${IMG_NAME} /bin/bash -c "julia /usr/myapp/${Script}.jl" && \
	make copy_from_container ARGS=. && \
	docker stop ${IMG_NAME}

copy_from_container:
	docker cp ${IMG_NAME}:/usr/myapp/${ARGS} ${ARGS}

stop:
	docker stop ${Script}
