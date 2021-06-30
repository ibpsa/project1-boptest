
build:
	docker-compose build

remove-image:
	docker-compose rm -sf

run:
	docker-compose up web worker

run-detached:
	docker-compose up -d web worker

stop:
	docker-compose down
