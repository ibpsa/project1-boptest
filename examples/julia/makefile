IMG_NAME=julia_controller_${Script}

COMMAND_RUN= sudo docker run \
	  --name ${IMG_NAME} \
	  --detach=true \
	  --rm \
 	  -it \
 	  --network host \
 	  ${IMG_NAME} /bin/bash

build:
	sudo docker build --quiet --build-arg testcase=${Script} --no-cache --rm -t ${IMG_NAME} .

remove-image:
	sudo docker rmi ${IMG_NAME}

run:
	$(COMMAND_RUN) && \
	sudo docker cp . ${IMG_NAME}:/usr/myapp && \
	sudo docker exec -it ${IMG_NAME} /bin/bash -c "julia /usr/myapp/${Script}.jl" && \
	make copy_from_container ARGS=. && \
	sudo docker stop ${IMG_NAME}

copy_from_container:
	sudo docker cp ${IMG_NAME}:/usr/myapp/${ARGS} ${ARGS}

stop:
	sudo docker stop ${Script}
