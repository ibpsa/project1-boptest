# Utility Functions
###############################################################################
TESTING_DIR := ${CURDIR}
TMP_GIT_DIR := tmp_git
TMP_MODELICAPATH_DIR := tmp_MODELICAPATH

compile_testcase_model:
	export MODELICAPATH=${TESTING_DIR}/${TMP_MODELICAPATH_DIR} && \
	make link_libraries && \
	cd ../testcases/${TESTCASE}/models && ./set_library_versions.sh
	make remove_link_libraries && make copy_libraries && \
	cd ../testcases/${TESTCASE}/models && python compile_fmu.py
	make remove_libraries

get_libraries:
	mkdir ${TMP_MODELICAPATH_DIR} && mkdir ${TMP_GIT_DIR} && cd ${TMP_GIT_DIR} && \
	git clone https://github.com/ibpsa/modelica-ibpsa.git && \
	git clone https://github.com/open-ideas/IDEAS.git && \
	git clone https://github.com/lbl-srg/modelica-buildings.git

link_libraries:
	ln -s ${TESTING_DIR}/${TMP_GIT_DIR}/IDEAS/IDEAS ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/IDEAS && \
	ln -s ${TESTING_DIR}/${TMP_GIT_DIR}/modelica-buildings/Buildings ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/Buildings && \
	ln -s ${TESTING_DIR}/${TMP_GIT_DIR}/modelica-ibpsa/IBPSA ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/IBPSA

remove_link_libraries:
	rm ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/IDEAS && \
	rm ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/Buildings && \
	rm ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/IBPSA
	
copy_libraries:
	cp -r ${TESTING_DIR}/${TMP_GIT_DIR}/IDEAS/IDEAS ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/IDEAS && \
	cp -r ${TESTING_DIR}/${TMP_GIT_DIR}/modelica-buildings/Buildings ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/Buildings && \
	cp -r ${TESTING_DIR}/${TMP_GIT_DIR}/modelica-ibpsa/IBPSA ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/IBPSA

remove_libraries:
	rm -r ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/IDEAS && \
	rm -r ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/Buildings && \
	rm -r ${TESTING_DIR}/${TMP_MODELICAPATH_DIR}/IBPSA

remove_tmp_directories:
	rm -r ${TMP_MODELICAPATH_DIR} && rm -rf ${TMP_GIT_DIR}

###############################################################################

# Tests
###############################################################################
test_testcase1:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase1
# Build testcase image
	cd .. &&  make build TESTCASE=testcase1
# Deploy testcase container
	cd .. && make run-detached TESTCASE=testcase1
	python sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=twoday_p && make run Script=twoday_p
# Python and checks
	cd .. && python testing/test_testcase1.py
# Stop testcase container
	cd .. && make stop TESTCASE=testcase1
# Remove testcase image
	cd ../examples/julia && make remove-image Script=twoday_p

test_testcase2:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase2 
# Build testcase image
	cd .. && make build TESTCASE=testcase2
# Deploy testcase container
	cd .. && make run-detached TESTCASE=testcase2
	python sleep10.py
# Run testcase tests
# Julia
	cd ../examples/julia && make build Script=szvav_sup && make run Script=szvav_sup
# Python and checks
	cd .. && python testing/test_testcase2.py
# Stop testcase container
	cd .. && make stop TESTCASE=testcase2
# Remove testcase image
	cd ../examples/julia && make remove-image Script=szvav_sup
	
test_testcase3:
# Compile testcase model
	make compile_testcase_model TESTCASE=testcase3
# Build testcase image
	cd .. &&  make build TESTCASE=testcase3
# Deploy testcase container
	cd .. && make run-detached TESTCASE=testcase3
	python sleep10.py
# Run testcase tests
# Python and checks
	cd .. && python testing/test_testcase3.py
# Stop testcase container
	cd .. && make stop TESTCASE=testcase3

test_bestest_air:
# Compile testcase model
	make compile_testcase_model TESTCASE=bestest_air
# Build testcase image
	cd .. &&  make build TESTCASE=bestest_air
# Deploy testcase container
	cd .. && make run-detached TESTCASE=bestest_air
	python sleep10.py
# Run testcase tests
	cd .. && python testing/test_bestest_air.py
# Stop testcase container
	cd .. && make stop TESTCASE=bestest_air

test_parser:
	python test_parser.py

test_data:
	make compile_testcase_model TESTCASE=testcase2
	make compile_testcase_model TESTCASE=testcase3
	python test_data.py
	
test_forecast:
	make compile_testcase_model TESTCASE=testcase2
	make compile_testcase_model TESTCASE=testcase3
	python test_forecast.py
	
test_kpis:
	make compile_testcase_model TESTCASE=testcase2
	make compile_testcase_model TESTCASE=testcase3
	python test_kpis.py

###############################################################################

# Run all tests
###############################################################################
test_all:
# Build boptest
	cd .. && make setup
# Get libraries
	make get_libraries
# Run tests
	make test_parser
	make test_data
	make test_forecast
	make test_kpis
	make test_testcase1
	make test_testcase2
	make test_testcase3
	make test_bestest_air
# Remove libraries
	make remove_tmp_directories
# Remove boptest
	cd ../docker && make remove-image
# Report test results
	python report.py
