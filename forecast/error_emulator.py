'''
Created on Sept 5, 2022

@author: Laura Zabala

'''

import numpy as np

def predict_error_AR(hp, F0, K0, F, K, mu):
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
    
    error = np.zeros(hp)
    error[0,] = np.random.normal(F0, K0)
    for i_c in range(hp-1):
        error[i_c+1] = np.random.normal(
            error[i_c]*F+mu, K
        )
    return error