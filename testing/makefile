test_testcase1:
	# Build testcase image
	cd .. && TESTCASE=testcase1 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase1 DETACH=true make run && sleep 3
	# Run testcase container
	cd .. && python examples/twoday-p.py
	# Stop testcase container
	cd .. && TESTCASE=testcase1 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase1 make remove-image

test_compile_model_testcase1:
	# Compile testcase model
	cd ../testcase1/models && python compile_fmu.py

test_testcase2:
	# Build testcase image
	cd .. && TESTCASE=testcase2 make build
	# Deploy testcase container
	cd .. && TESTCASE=testcase2 DETACH=true make run && sleep 3
	# Run testcase container
	cd .. && python examples/szvav-sup.py
	# Stop testcase container
	cd .. && TESTCASE=testcase2 make stop
	# Remove testcase image
	cd .. && TESTCASE=testcase2 make remove-image

test_compile_model_testcase2:
	# Compile testcase model
	cd ../testcase2/models && python compile_fmu.py

test_parser:
	# Run parser and export wrapper model and fmu
	cd ../parser && python parser.py
	# test wrapper fmu with simulaton
	cd ../parser && python simulate.py

test:
	make test_parser
	make test_compile_model_testcase1
	sudo make test_testcase1
	make test_compile_model_testcase2
	sudo make test_testcase2