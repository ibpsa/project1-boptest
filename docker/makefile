IMG_NAME=boptest

build:
	docker build --no-cache --rm -t ${IMG_NAME} .

remove-image:
	docker rmi ${IMG_NAME}

run:
	docker run --name ${IMG_NAME} -it --rm --detach=false ${IMG_NAME} /bin/bash

stop:
	docker stop ${IMG_NAME}

	
