'''
Created on Apr 16, 2021

@author: Javier Arroyo

'''

from testing.utilities import compare_references

compare_references(vars_timeseries = ['PHea_y',
                                      'TRooAir_y',
                                      'CO2RooAir_y',
                                      'oveAct_u',
                                      'oveAct_activate'],
                   refs_old = 'testcase1_old',
                   refs_new = 'testcase1')
