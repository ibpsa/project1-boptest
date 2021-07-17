
build:
	docker-compose build

remove-image:
	docker-compose rm -sf

run:
	docker-compose up web worker

run-detached:
	docker-compose up -d web worker

run-provision:
	docker-compose run --no-deps provision python3 -m boptest_submit ./testcases/${TESTCASE}

stop:
	docker-compose down
