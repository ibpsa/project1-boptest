# -*- coding: utf-8 -*-
"""
This module contains a generic controller class that is used to instantiate
concrete controller, found in pid.py, pidTwoZones.py, and sup.py.

"""

import sys
import importlib


class Controller(object):
    def __init__(self, module, use_forecast=False):
        """Controller object that instantiates concrete controller methods.

        Parameters
        ----------
        module : str
            path to concrete implementation of controller
        use_forecast : bool
            True if controller uses forecasts.
            Default is False.

        """

        try:
            # instantiate the concrete controller specified in the configuration
            controller = importlib.import_module(module)
        except ModuleNotFoundError:
            print("Cannot find specified controller: {}".format(module))
            sys.exit()

        if use_forecast:
            self.use_forecast = True
            self.update_forecasts = controller.update_forecasts
            self.get_forecast_parameters = controller.get_forecast_parameters
        else:
            self.use_forecast = False
        self.compute_control = controller.compute_control
        self.initialize = controller.initialize
        self.controller = controller
