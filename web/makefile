# Set $ROOT to top-level directory of the repository
ROOT ?= $(shell dirname \
  $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST)))))

IMG_NAME=boptestweb
IMG_HOME=/home

build-env:
	docker build -f ${ROOT}/web/Dockerfile \
	--platform=linux/amd64 \
	--progress=plain --rm -t ${IMG_NAME} ../

build-env-no-cache:
	docker build -f ${ROOT}/web/Dockerfile \
	--platform=linux/amd64 \
	--no-cache \
	--progress=plain --rm -t ${IMG_NAME} ../

COMMAND_RUN=docker run \
		--name ${IMG_NAME} \
		--platform=linux/amd64 \
		--detach=false \
		--network=host \
		--rm \
		-v ${ROOT}:${IMG_HOME}/boptest:rw \
		-w ${IMG_HOME}/boptest/web \
		${IMG_NAME} 

# Use these commands if you're outside the boptestweb container
run-build-docs:
	$(COMMAND_RUN) /bin/bash -c "make build_docs"

run-build-docs-and-build-web:
	$(COMMAND_RUN) /bin/bash -c "make build_docs_and_build_web"

run-build-docs-and-serve-web:
	$(COMMAND_RUN) /bin/bash -c "make build_docs_and_serve_web"

# Use these commands if you're inside the boptestweb container
build_docs:
	./build_docs.sh

build_docs_and_build_web:
	./build_docs.sh
	bundle exec jekyll build

build_docs_and_serve_web:
	./build_docs.sh
	bundle exec jekyll serve

