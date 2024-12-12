# -*- coding: utf-8 -*-
"""
This module runs tests for testcase2. To run these tests, testcase2 must already be deployed.Ensure 'testcase2'
is deployed by running `TESTCASE=testcase2 docker-compose up` in the terminal at the root directory of the software.
It includes tests to check forecast intervals, horizon, and uncertainty levels.

"""

import os
import unittest
import numpy as np
import pandas as pd
import json
import requests
import utilities
from forecast.forecaster import Forecaster
import statsmodels.api as sm
from scipy.stats import laplace

testing_root_dir = os.path.join(utilities.get_root_path(), 'testing')



class ForecasterSingleZoneTest(unittest.TestCase):


    def setUp(self):
        '''Setup for each test.

        Changes the directory to testcase2 and initializes test case attributes.

        '''

        # Load deterministic forecasts
        self.determinstic_temperature_forecasts=pd.read_csv(os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase2', 'determinstic_temperature_forecasts.csv'),index_col=0)
        self.determinstic_solar_forecasts=pd.read_csv(os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase2', 'determinstic_solar_forecasts.csv'),index_col=0)

        # Load uncertainty parameters
        with open(os.path.join(utilities.get_root_path(), 'forecast', 'forecast_uncertainty_params.json'), 'r') as f:
            uncertainty_params = json.load(f)
        self.ref_temperature_uncertainty_params=uncertainty_params['temperature']
        self.ref_solar_uncertainty_params = uncertainty_params['solar']

        # Set URL for testcase
        self.url = 'http://127.0.0.1:5000'

    def test_interval_horizon(self):
        """Test whether forecast intervals and horizon are correct."""
        uncertain_level = 'low'
        requests.put('{0}/scenario'.format(self.url), json={
            'electricity_price': 'constant',
            'solar_uncertainty': uncertain_level,
            'temperature_uncertainty': uncertain_level,
            'seed':5
        })
        forecasts = requests.put('{0}/forecast'.format(self.url),
                                 json={'point_names': ['TDryBul', 'HGloHor'],
                                       'interval': 3600,
                                       'horizon': 48 * 3600},
                                 ).json()['payload']
        self.assertEqual(len(forecasts['TDryBul']), 49)

        # Verify interval is consistent and equals 3600 seconds
        time_data=forecasts['time']
        for  i in range(1,len(time_data)):
            interval = time_data[i] - time_data[i - 1]
            self.assertEqual(interval, 3600)

    def test_forecast_solar_radiation_are_positive(self):
        requests.put('{0}/scenario'.format(self.url), json={
            'electricity_price': 'constant',
            'solar_uncertainty': 'high',
            'seed': 5
        })
        for _ in range(1000):
            forecasts=requests.put('{0}/forecast'.format(self.url),
                         json={'point_names': ['HGloHor'],
                               'interval': 3600,
                               'horizon': 48 * 3600},
                         ).json()['payload']['HGloHor']
            for forecast in forecasts:
                self.assertGreaterEqual(forecast, 0, f"Forecast value {forecast} is not greater than 0")
            requests.post('{0}/advance'.format(self.url), json={}).json()

    def test_forecast_temperature_are_within_range(self):
        requests.put('{0}/scenario'.format(self.url), json={
            'electricity_price': 'constant',
            'temperature_uncertainty': 'high',
            'seed': 5
        })
        for _ in range(1000):
            forecasts=requests.put('{0}/forecast'.format(self.url),
                         json={'point_names': ['TDryBul'],
                               'interval': 3600,
                               'horizon': 48 * 3600},
                         ).json()['payload']['TDryBul']
            for forecast in forecasts:
                self.assertGreaterEqual(forecast, 173.15, f"Forecast temperature {forecast} is below -100°C")
                self.assertLessEqual(forecast, 373.15, f"Forecast temperature {forecast} is above 100°C")
            requests.post('{0}/advance'.format(self.url), json={}).json()

    def test_low_uncertainty(self):
        """Test forecasts under low uncertainty."""
        self.check_uncertainty(uncertain_level='low')

    def test_medium_uncertainty(self):
        """Test forecasts under medium uncertainty."""
        self.check_uncertainty(uncertain_level='medium')

    def test_high_uncertainty(self):
        """Test forecasts under high uncertainty."""
        self.check_uncertainty(uncertain_level='high')

    def check_uncertainty(self,uncertain_level):
        """Check the forecast uncertainty parameters against references.

        Parameters
        ----------
        uncertain_level : str
        The level of uncertainty to test ('low', 'medium', 'high').

        This method compares the forecast uncertainty parameters with the reference values for a given uncertainty level.

        """
        # Extract reference uncertainty parameters
        ref_F0, ref_K0, ref_F, ref_K, ref_mu=self.ref_temperature_uncertainty_params[uncertain_level].values()
        ref_ag0, ref_bg0, ref_phi, ref_ag, ref_bg=self.ref_solar_uncertainty_params[uncertain_level].values()

        # Initialize, set step, and set scenario
        requests.put('{0}/initialize'.format(self.url),
                     json={'start_time': int(0),
                           'warmup_period': int(0)})
        requests.put('{0}/step'.format(self.url), json={'step': int(3600)})
        requests.put('{0}/scenario'.format(self.url), json={
            'electricity_price': 'constant',
            'solar_uncertainty': uncertain_level,
            'temperature_uncertainty': uncertain_level,
            'seed':5
        })

        # Collect forecasts and calculate errors
        all_temperature_forecasts = []
        all_solar_forecasts = []
        for _ in range(1000):
            forecasts=requests.put('{0}/forecast'.format(self.url),
                         json={'point_names': ['TDryBul', 'HGloHor'],
                               'interval': 3600,
                               'horizon': 48 * 3600},
                         ).json()['payload']
            current_temperature_forecast=forecasts['TDryBul']
            current_solar_forecast=forecasts['HGloHor']
            all_temperature_forecasts.append(current_temperature_forecast)
            all_solar_forecasts.append(current_solar_forecast)

            requests.post('{0}/advance'.format(self.url), json={}).json()

        # Calculate error between deterministic and forecasted data
        temperature_error=self.determinstic_temperature_forecasts.values-np.array(all_temperature_forecasts)
        solar_error=self.determinstic_solar_forecasts.values-np.array(all_solar_forecasts)

        # Check parameters
        F0, K0, F, K, mu=self.check_params_gaussain(temperature_error)
        ag0, bg0, phi, ag, bg=self.check_params_laplace(solar_error)

        # Assert the forecast uncertainty parameters are within acceptable ranges
        self.assertAlmostEqual(F0, ref_F0, delta=0.2)
        self.assertAlmostEqual(K0, ref_K0, delta=0.2)
        self.assertAlmostEqual(F, ref_F, delta=0.01)
        self.assertAlmostEqual(K, ref_K, delta=0.01)
        self.assertAlmostEqual(mu, ref_mu, delta=0.01)

    def check_params_gaussain(self, errors):
        F0 = errors[:, 0].mean()
        K0 = errors[:, 0].std()
        X = errors[:, :-1].reshape((-1, 1))
        y = errors[:, 1:].reshape((-1, 1))
        model = sm.OLS(y, X, missing='drop').fit()
        F = model.params.item()
        K = model.resid.std()
        mu = model.resid.mean()
        return (F0,K0,F,K,mu)

    def check_params_laplace(self, errors):
        ag0,bg0=laplace.fit(errors[:, 0])
        X = errors[:, :-1].reshape((-1, 1))
        y = errors[:, 1:].reshape((-1, 1))
        model = sm.OLS(y, X, missing='drop').fit()
        phi = model.params.item()
        h=model.resid
        ag, bg = laplace.fit(h)
        return (ag0, bg0, phi, ag, bg)

if __name__ == '__main__':

    utilities.run_tests(os.path.basename(__file__))
