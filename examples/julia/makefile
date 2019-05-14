IMG_NAME=juila_controller_${Script}

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --rm \
 	  -it \
	  -v `pwd`:/usr/myapp  \
 	  --network host

build:
	docker build --build-arg testcase=${Script} --no-cache --rm -t ${Script} .

remove-image:
	docker rmi ${Script}

run:
	$(COMMAND_RUN) --detach=false ${Script} /bin/bash -c "julia /usr/myapp/${Script}.jl"

stop:
	docker stop ${Script}

	
