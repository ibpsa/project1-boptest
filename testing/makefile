test_testcase1:
	# Compile testcase model
	cd ../testcase1/models && python compile_fmu.py
	# Build testcase image
	cd .. && TESTCASE=testcase1 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase1 DETACH=true make run && sleep 3
	# Run testcase tests
	cd ../testcase1/testing && python tests.py
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
	cd ../testcase2/testing && python tests.py
	# Stop testcase container
	cd .. && TESTCASE=testcase2 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase2 make remove-image

test_parser:
	# Run parser and export wrapper model and fmu
	cd ../parser/testing && python tests.py

test:
	make test_parser
	make test_testcase1
	make test_testcase2