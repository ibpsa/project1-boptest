import sys
import importlib
import pandas as pd


class Control(object):
    def __init__(self, module, forecast_config):
        """Controller object - instantiates concrete implementation of controller configured
        in configuration

        Parameters
        ----------
        module : str, required
            path to concrete implementation of controller
        forecast_config : list of strings, dict
            list of data names obtained by instatiator get/forecast method
        """
        try:
            controller = importlib.import_module(module)
        except ModuleNotFoundError:
            print("Cannot find specified controller: {}".format(module))
            sys.exit()

        if forecast_config is not None:
            self.update_predictions = controller.update_predictions
            self.use_forecast = True
        else:
            self.use_forecast = False
        self.compute_control = controller.compute_control
        self.initialize = controller.initialize
        self.controller = controller

