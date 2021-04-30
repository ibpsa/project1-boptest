'''
Created on Apr 16, 2021

@author: Javier Arroyo

'''

from testing.utilities import compare_references

compare_references(vars_timeseries = ['fcu_reaPHea_y',
                                      'fcu_reaPFan_y',
                                      'fcu_reaPCoo_y',
                                      'fcu_reaFloSup_y',
                                      'fcu_reaTSup_y',
                                      'con_reaTSetCoo_y',
                                      'con_reaTSetHea_y',
                                      'zon_reaTRooAir_y',
                                      'TDryBul',
                                      'LowerSetp[1]'],
                   refs_old = 'bestest_air_old',
                   refs_new = 'bestest_air')
