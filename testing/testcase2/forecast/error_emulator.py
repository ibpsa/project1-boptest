'''
Created on Sept 5, 2022

@author: Laura Zabala

'''

import numpy as np



def mean_filter(data, window_size=3):
    """
    Apply mean filter to a 1D list of data.

    Parameters:
    - data: List of numbers to be filtered.
    - window_size: Size of the filtering window. Must be an odd number.

    Returns:
    - Filtered data.
    """
    if window_size % 2 == 0:
        raise ValueError("Window size must be an odd number.")

    half_window = window_size // 2
    filtered_data = data.copy()

    for i in range(half_window, len(data) - half_window):
        if data[i] == 0:
            continue

        window_data = data[i - half_window : i + half_window + 1]
        filtered_data[i] = sum(window_data) / len(window_data)

    return filtered_data
def predict_temperature_error_AR1(hp, F0, K0, F, K, mu):
    '''Generates an error with an AR model in the hp points of the predictions horizon.

    Parameters
    ----------
    hp : int, number of points in the prediction horizon
    F0 : float, mean of the initial error model
    K0 : float, standard deviation of the initial error model
    F : float from 0 to 1, autocorrelation factor of the AR error model
    K : float, standard deviation of the AR error model
    mu : float, mean value of the distribution function integrated in the AR error model

    Returns
    -------
    error : 1D array with the error values in the hp points

    '''
    hp=int(hp)
    error = np.zeros(hp)
    error[0,] = np.random.normal(F0, K0)
    for i_c in range(hp - 1):
        error[i_c + 1] = np.random.normal(
            error[i_c] * F + mu, K
        )
    return error



def predict_solar_error_AR1(hp, ag0, bg0, phi, ag, bg):
    '''Generates an error based on the specified parameters using an AR model in the hp points of the predictions horizon.

        Parameters
        ----------
        hp : int
            Number of points in the prediction horizon.
        ag0, bg0, phi, ag, bg : float
            Parameters for the AR1 model.

        Returns
        -------
        error : 1D numpy array
            Contains the error values in the hp points.
    '''
    hp = int(hp)
    error = np.zeros(hp)
    error[0] = np.random.laplace(ag0, bg0)
    for i_c in range(1, hp):
        error[i_c] = np.random.laplace(error[i_c - 1] * phi + ag, bg)

    return error
