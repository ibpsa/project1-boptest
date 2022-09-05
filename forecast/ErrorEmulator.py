import numpy as np

def predict_error(hp, F0, K0, F, K, mu):
    """
    Generates an error with an AR model in the hp points of the predictions horizon.
    :parameter hp: int, number of points in the prediction horizon
    :parameter F0: float, mean of the initial error model
    :parameter K0: float, standard deviation of the initial error model
    :parameter F: float from 0 to 1, autocorrelation factor of the AR error model
    :parameter K: float, standard deviation of the AR error model
    :parameter mu: float, mean value of the distribution function integrated in the AR error model
    :return: 1D array with the error values in the hp points
    """
    
    error = np.zeros(hp)
    error[0,] = np.random.normal(F0, K0)
    for i_c in range(hp-1):
        error[i_c+1] = np.random.normal(
            error[i_c]*F+mu, K
        )
    return error