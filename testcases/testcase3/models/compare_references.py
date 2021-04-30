'''
Created on Apr 16, 2021

@author: Javier Arroyo

'''

from testing.utilities import compare_references

compare_references(vars_timeseries = ['CO2RooAirSou_y',
                                      'CO2RooAirNor_y',
                                      'TRooAirSou_y',
                                      'PHeaNor_y',
                                      'PHeaSou_y',
                                      'TRooAirNor_y',
                                      'TRooAirNor_y',
                                      'oveActSou_u',
                                      'oveActNor_activate',
                                      'oveActNor_u',
                                      'oveActSou_activate',
                                      'oveActSou_activate',
                                      'Occupancy[North]',
                                      'Occupancy[South]',
                                      'UpperSetp[North]',
                                      'UpperSetp[South]',
                                      'TDryBul'],
                   refs_old = 'testcase3_old',
                   refs_new = 'testcase3')
