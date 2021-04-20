'''
Created on Apr 16, 2021

@author: Javier Arroyo

'''

from testing.utilities import compare_references

compare_references(vars_timeseries = ['reaPHeaPum_y',
                                      'reaPFan_y',
                                      'reaPPumEmi_y',
                                      'reaTSup_y',
                                      'reaTSetHea_y',
                                      'reaTZon_y',
                                      'LowerSetp[1]'],
                   refs_old = 'bestest_hydronic_heat_pump_old',
                   refs_new = 'bestest_hydronic_heat_pump')
