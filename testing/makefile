test_testcase1:
# Compile testcase model
ifeq ($(strip $(TEST_ENV)),"travis")
	cd ../testcase1/models && jm_ipython compile_fmu.py
else
	cd ../testcase1/models && python compile_fmu.py	     
endif
	# Build testcase image
	cd .. && TESTCASE=testcase1 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase1 make run-detached && sleep 3
	# Run testcase tests
	python test_testcase1.py
	# Stop testcase container
	cd .. && TESTCASE=testcase1 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase1 make remove-image

test_testcase2:
# Compile testcase model
ifeq ($(strip $(TEST_ENV)),"travis")
	cd ../testcase2/models && jm_ipython compile_fmu.py
else
	cd ../testcase2/models && python compile_fmu.py	     
endif
	# Build testcase image
	cd .. && TESTCASE=testcase2 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase2 make run-detached && sleep 3
	# Run testcase tests
	python test_testcase2.py
	# Stop testcase container
	cd .. && TESTCASE=testcase2 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase2 make remove-image

test_parser:
# Run parser and export wrapper model and fmu
ifeq ($(strip $(TEST_ENV)),"travis")
	jm_ipython.sh test_parser.py
else
	python test_parser.py	     
endif

test_all:
	# Run tests
	make test_parser
	make test_testcase1
	make test_testcase2
	python report.py
