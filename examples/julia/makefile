IMG_NAME=julia_controller_${Script}

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --rm \
 	  -it \
	  -v `pwd`:/usr/myapp  \
 	  --network host

build:
	docker build --build-arg testcase=${Script} --no-cache --rm -t ${IMG_NAME} .

remove-image:
	docker rmi ${IMG_NAME}

run:
	$(COMMAND_RUN) --detach=false ${IMG_NAME} /bin/bash -c "julia /usr/myapp/${Script}.jl"

stop:
	docker stop ${Script}

	
