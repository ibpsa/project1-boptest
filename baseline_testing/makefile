# baseline testing
###############################################################################

run_baseline_%:
# Build and deploy testcase image
	cd .. && TESTCASE=$* docker-compose up -d
# Run testcase tests
	python sleep10.py
	python run_baselines.py $*
# Stop testcase container
	cd .. && docker-compose down

run_baseline_all:
	make run_baseline_bestest_air
	make run_baseline_bestest_hydronic
	make run_baseline_bestest_hydronic_heat_pump
	make run_baseline_multizone_residential_hydronic
	make run_baseline_singlezone_commercial_hydronic
	make run_baseline_multizone_office_simple_air
	make run_baseline_twozone_apartment_hydronic