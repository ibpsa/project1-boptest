'''
Created on Sept 5, 2022

@author: Laura Zabala, Wanfu Zheng

'''

import numpy as np


def mean_filter(data, window_size=3):
    """
    Apply mean filter to a 1D list of data.

    Parameters
    ----------
    data: list of numbers
        List of numbers to be filtered.
    window_size: int
        Size of the filtering window. Must be an odd number.

    Returns
    -------
    filtered_data : list of numbers
        List of filtered data.

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
    '''
    Generates an error for the temperature forecast with an AR model with normal distribution in the hp points of the predictions horizon.

    Parameters
    ----------
    hp : int
        Number of points in the prediction horizon.
    F0 : float
        Mean of the initial error model.
    K0 : float
        Standard deviation of the initial error model.
    F : float
        Autocorrelation factor of the AR error model, value should be between 0 and 1.
    K : float
        Standard deviation of the AR error model.
    mu : float
        Mean value of the distribution function integrated in the AR error model.

    Returns
    -------
    error : 1D array
        Array containing the error values in the hp points.

    '''

    error = np.zeros(hp)
    error[0] = np.random.normal(F0, K0)
    for i_c in range(hp - 1):
        error[i_c + 1] = np.random.normal(
            error[i_c] * F + mu, K
        )

    return error

def predict_solar_error_AR1(hp, ag0, bg0, phi, ag, bg):
    '''
    Generates an error for the solar forecast based on the specified parameters using an AR model with Laplace distribution in the hp points of the predictions horizon.

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

    error = np.zeros(hp)
    error[0] = np.random.laplace(ag0, bg0)
    for i_c in range(1, hp):
        error[i_c] = np.random.laplace(error[i_c - 1] * phi + ag, bg)

    return error
