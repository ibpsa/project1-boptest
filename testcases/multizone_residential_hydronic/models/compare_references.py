'''
Created on Apr 16, 2021

@author: Javier Arroyo

'''

from testing.utilities import compare_references

compare_references(vars_timeseries = ['boi_reaGasBoi_y',
                                      'boi_reaPpum_y',
                                      'conHeaBth_reaTZon_y',
                                      'conHeaLiv_reaTZon_y',
                                      'conHeaRo1_reaTZon_y',
                                      'conHeaRo2_reaTZon_y',
                                      'conHeaRo3_reaTZon_y',
                                      'extLiv_reaCO2RooAir_y',
                                      'conCooBth_reaPCoo_y',
                                      'conHeaLiv_reaActHea_y',
                                      'HGloHor',
                                      'InternalGainsCon[Hal]',
                                      'TDryBul'],
                   refs_old = 'multizone_residential_hydronic_old',
                   refs_new = 'multizone_residential_hydronic')
