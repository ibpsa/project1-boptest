'''
Created on Apr 16, 2021

@author: Javier Arroyo

'''

from testing.utilities import compare_references

compare_references(vars_timeseries = ['PFan_y',
                                      'PPum_y',
                                      'TRooAir_y',
                                      'CO2RooAir_y',
                                      'senTSetRooCoo_y',
                                      'PCoo_y',
                                      'PHea_y',
                                      'senTSetRooHea_y',
                                      'oveTSetRooCoo_activate',
                                      'oveTSetRooHea_activate',
                                      'oveTSetRooCoo_u',
                                      'oveTSetRooHea_u'],
                   refs_old = 'testcase2_old',
                   refs_new = 'testcase2')
