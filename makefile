
build:
	docker-compose build

remove-image:
	docker-compose rm -sf

run :
	$(MAKE) run-detached
	$(MAKE) provision
	docker-compose logs -f web worker

run-detached:
	docker-compose up -d web worker

provision:
	docker-compose run --no-deps provision python3 -m boptest_submit ./testcases/${TESTCASE}

stop:
	docker-compose down

.PHONY: build run run-detached remove-image stop provision
