IMG_NAME=julia_controller_${Script}

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  --rm \
 	  -it \
 	  --network host \
 	  ${IMG_NAME} /bin/bash

build:
	docker build --build-arg testcase=${Script} --no-cache --rm -t ${IMG_NAME} .

remove-image:
	docker rmi ${IMG_NAME}

run:
	$(COMMAND_RUN) && \
	docker cp . ${IMG_NAME}:/usr/myapp && \
	docker exec -it ${IMG_NAME} /bin/bash -c "julia /usr/myapp/${Script}.jl" && \
	docker cp ${IMG_NAME}:/usr/myapp/. . && \
	docker stop ${IMG_NAME}

stop:
	docker stop ${Script}

	
