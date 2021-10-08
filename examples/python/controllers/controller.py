# -*- coding: utf-8 -*-
"""
This module contains a generic controller class that is used to instantiate
concrete controller methods, found in pid.py, pidTwoZones.py, and sup.py.

"""

import sys
import importlib


class Controller(object):
    def __init__(self, module, forecast_config=None):
        """Controller object that instantiates concrete controller methods.

        Parameters
        ----------
        module : str
            path to concrete implementation of controller
        forecast_config : list, optional
            list of point names contained in a forecast
            [<input_name1>, <input_name2>].
            Default is None.
        """

        try:
            controller = importlib.import_module(module)
        except ModuleNotFoundError:
            print("Cannot find specified controller: {}".format(module))
            sys.exit()

        if forecast_config is not None:
            self.update_forecasts = controller.update_forecasts
            self.use_forecast = True
        else:
            self.use_forecast = False
        self.compute_control = controller.compute_control
        self.initialize = controller.initialize
        self.controller = controller
