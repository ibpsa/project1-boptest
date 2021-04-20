'''
Created on Apr 16, 2021

@author: Javier Arroyo

'''

from testing.utilities import compare_references

compare_references(vars_timeseries = ['reaQHea_y',
                                      'reaPPum_y',
                                      'reaTSetSup_y',
                                      'reaTSetHea_y',
                                      'reaTRoo_y',
                                      'LowerSetp[1]'],
                   refs_old = 'bestest_hydronic_old',
                   refs_new = 'bestest_hydronic')
