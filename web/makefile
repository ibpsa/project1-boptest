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

run-build-and-test:
	docker run \
		--name ${IMG_NAME} \
		--platform=linux/amd64 \
		--detach=false \
		--network=host \
		--rm \
		-v ${ROOT}:${IMG_HOME}/boptest:rw \
		-w ${IMG_HOME}/boptest/web \
		-it \
		${IMG_NAME} /bin/bash -c "make build_and_test"

build_and_test:
	./build_docs.sh
	bundle exec jekyll serve

build:
	./build_docs.sh
