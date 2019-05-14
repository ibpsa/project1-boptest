test_testcase1:
	# Compile testcase model
	cd ../testcase1/models && python compile_fmu.py
	# Build testcase image
	cd .. && TESTCASE=testcase1 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase1 make run-detached && sleep 3
	# Run testcase tests
	# Julia
	cd ../examples/julia && Script=twoday_p make build && Script=twoday_p make run
	# Python and checks
	cd ../.. python testing/test_testcase1.py
	# Stop testcase container
	cd .. && TESTCASE=testcase1 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase1 make remove-image
	cd ../examples/julia && Script=twoday_p make remove-image


test_testcase2:
	# Compile testcase model
	cd ../testcase2/models && python compile_fmu.py
	# Build testcase image
	cd .. && TESTCASE=testcase2 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase2 make run-detached && sleep 3
	# Run testcase tests
	# Julia
	cd ../examples/julia && Script=szvav_sup make build && Script=szvav_sup make run
	# Python and checks
	cd ../.. python testing/test_testcase2.py
	# Stop testcase container
	cd .. && TESTCASE=testcase2 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase2 make remove-image
	cd ../examples/julia && Script=szvav_sup make remove-image


test_parser:
	# Run parser and export wrapper model and fmu
	python test_parser.py

test_all:
	make test_parser
	make test_testcase1
	make test_testcase2
	python report.py
