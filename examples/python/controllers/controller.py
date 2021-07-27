import sys
import importlib
import pandas as pd


class Control(object):
    def __init__(self, module, prediction_config, step):
        """Controller object - instantiates concrete implementation of controller configured
        in configuration

        Parameters
        ----------
        module : str, required
            path to concrete implementation of controller
        prediction_config : list of strings, dict
            list of data names obtained by instatiator get/forecast method
        step: int
            step size in simulation used to store predictions from forecast as simulation progresses
        """
        try:
            module = importlib.import_module(module)
        except ModuleNotFoundError:
            print("Cannot find specified controller: {}".format(module))
            sys.exit()
        print(prediction_config)
        if prediction_config is not None:
            predictions_store = pd.DataFrame(columns=prediction_config)
            self.update_predictions = module.update_predictions
            self.use_forecast = True
        else:
            predictions_store = None
            self.use_forecast = False
        self.compute_control = module.compute_control
        self.initialize = module.initialize
        self.predictions_store = predictions_store
        self.prediction_config = prediction_config
        self.step = step

    def prediction(self, forecast, iteration):
        """Pass prediction value from interface to concrete implementation of the controller

        Parameters
        ----------
        forecast : str, required
            path to concrete implementation of controller.
        iteration: int, required
            Number of timesteps simulation has progressed though.

        Returns
        -----------
        predictions: list
        prediction for data point in simulation returned by call to /forecast
        """
        predictions = self.update_predictions(self.prediction_config, forecast)
        if self.predictions_store is not None:
            self.predictions_store.loc[(iteration + 1) * self.step, self.predictions_store.columns] = predictions
        return predictions

