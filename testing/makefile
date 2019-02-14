test_testcase1:
	# Compile testcase model
	cd ../testcase1/models && python compile_fmu.py
	# Build testcase image
	cd .. && TESTCASE=testcase1 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase1 DETACH=true make run && sleep 3
	# Run testcase tests
	python test_testcase1.py
	# Stop testcase container
	cd .. && TESTCASE=testcase1 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase1 make remove-image

test_testcase2:
	# Compile testcase model
	cd ../testcase2/models && python compile_fmu.py
	# Build testcase image
	cd .. && TESTCASE=testcase2 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase2 DETACH=true make run && sleep 3
	# Run testcase tests
	python test_testcase2.py
	# Stop testcase container
	cd .. && TESTCASE=testcase2 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase2 make remove-image

test_parser:
	# Run parser and export wrapper model and fmu
	python test_parser.py

test_all:
	make test_parser
	make test_testcase1
	make test_testcase2