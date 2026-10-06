"""Baseline scripts must select the requested emulator without shifting timing arguments.

Run from BOPTEST root: python -m unittest discover -s testing -p test_baselines.py -v
No running BOPTEST service is required.
"""
import importlib.util
import json
import os
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

import pandas as pd

ROOT = Path(os.environ.get('BOPTEST_SOURCE', Path(__file__).resolve().parents[1]))
sys.path.insert(0, str(ROOT))
from baselines import run_baselines
from examples.python.interface import control_test


class BaselineScriptsTest(unittest.TestCase):
    def setUp(self):
        self.case = 'bestest_hydronic_heat_pump'
        self.scenario = {'electricity_price': 'highly_dynamic', 'time_period': 'peak_heat_day'}
        self.kpi = {'ener_tot': 1.0}
        self.results = pd.DataFrame({'time': [0, 86400], 'power': [1, 1]})
        self.mock = patch.object(run_baselines, 'control_test', autospec=True)
        self.control = self.mock.start()
        self.addCleanup(self.mock.stop)
        self.control.return_value = (self.kpi, self.results, {}, None)

    def assert_forwarded(self, case, scenario, start=0, warmup=0, length=86400):
        args, kwargs = self.control.call_args
        import inspect
        bound = inspect.signature(control_test).bind(*args, **kwargs)
        self.assertEqual(bound.arguments['testcase_name'], case)
        self.assertEqual(bound.arguments['control_module'], 'examples.python.controllers.baseline')
        self.assertEqual(bound.arguments['start_time'], start)
        self.assertEqual(bound.arguments['warmup_period'], warmup)
        self.assertEqual(bound.arguments['length'], length)
        self.assertEqual(bound.arguments['scenario'], scenario)
        self.assertEqual(bound.arguments['step'], length)

    def test_single_case_preserves_test_case_and_custom_timing(self):
        kpi, results = run_baselines.run_single_case(
            self.case, self.scenario, start_time=1296000, warmup_period=604800, length=1209600)
        self.assertIs(kpi, self.kpi)
        self.assertIs(results, self.results)
        self.assert_forwarded(self.case, self.scenario, 1296000, 604800, 1209600)

    def run_main(self, config):
        with tempfile.TemporaryDirectory() as tmp:
            previous = Path.cwd()
            os.chdir(tmp)
            try:
                Path('config.json').write_text(json.dumps(config))
                run_baselines.main(self.case)
            finally:
                os.chdir(previous)

    def test_predefined_main_forwards_test_case(self):
        config = {'save_kpi_results': False, 'save_measurements': False,
                  'run_user_defined_test': False,
                  self.case: {'electricity_price': ['highly_dynamic'], 'time_period': ['peak_heat_day']}}
        self.run_main(config)
        self.control.assert_called_once()
        self.assert_forwarded(self.case, self.scenario)

    def test_user_defined_main_forwards_test_case_and_timing(self):
        config = {'save_kpi_results': False, 'save_measurements': False,
                  'run_user_defined_test': True, self.case: {},
                  'user_defined_test_options': {'electricity_price': 'dynamic', 'start_time': 42,
                                               'warmup_period': 17, 'length': 3600}}
        self.run_main(config)
        self.assert_forwarded(self.case, {'electricity_price': 'dynamic'}, 42, 17, 3600)

    def test_csv_driver_forwards_test_case_and_window(self):
        spec = importlib.util.spec_from_file_location('csv_baselines', ROOT/'baselines/csv/run_all_scenarios.py')
        module = importlib.util.module_from_spec(spec)
        # The CSV driver imports run_baselines by its short name.
        with patch.dict(sys.modules, {'run_baselines': run_baselines}):
            spec.loader.exec_module(module)
        frame = pd.DataFrame({'Scenario': ['constant+Day23'], 'test_day': ['peak_heat_day']})
        with patch.object(module.pd, 'read_csv', return_value=frame), patch.object(pd.DataFrame, 'to_csv'):
            result = module.main(self.case)
        self.assertEqual(result.loc[0, 'ener_tot'], 1.0)
        self.assert_forwarded(self.case, {'electricity_price': 'constant'}, 16*86400, 7*86400, 14*86400)


if __name__ == '__main__':
    unittest.main()
