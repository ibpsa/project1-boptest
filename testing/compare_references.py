'''
Created on Apr 16, 2021

@author: Javier Arroyo

'''

from testing.utilities import compare_references


def compare(testcase='bestest_air'):
    ''' Compares references for a specific test case.

    Parameters
    ----------
    testcase: string
        Specifies test case for which to compare references.

    '''

    if testcase == 'testcase1':
        compare_references(vars_timeseries = ['PHea_y',
                                              'TRooAir_y',
                                              'CO2RooAir_y',
                                              'oveAct_u',
                                              'oveAct_activate'],
                           refs_old = 'testcase1_old',
                           refs_new = 'testcase1')

    elif testcase == 'testcase2':
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

    elif testcase == 'testcase3':
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

    elif testcase == 'bestest_air':
        compare_references(vars_timeseries = ['fcu_reaPHea_y',
                                              'fcu_reaPFan_y',
                                              'fcu_reaPCoo_y',
                                              'fcu_reaFloSup_y',
                                              'fcu_oveFan_u',
                                              'fcu_oveTSup_u',
                                              'zon_reaTRooAir_y',
                                              'TDryBul',
                                              'LowerSetp[1]'],
                           refs_old = 'bestest_air_old',
                           refs_new = 'bestest_air')

    elif testcase == 'bestest_hydronic':
        compare_references(vars_timeseries = ['reaQHea_y',
                                              'reaPPum_y',
                                              'reaTSetSup_y',
                                              'reaTSetHea_y',
                                              'reaTRoo_y',
                                              'TDryBul',
                                              'LowerSetp[1]'],
                           refs_old = 'bestest_hydronic_old',
                           refs_new = 'bestest_hydronic')

    elif testcase == 'bestest_hydronic_heat_pump':
        compare_references(vars_timeseries = ['reaPHeaPum_y',
                                              'reaPFan_y',
                                              'reaPPumEmi_y',
                                              'reaTSup_y',
                                              'reaTSetHea_y',
                                              'reaTZon_y',
                                              'TDryBul',
                                              'LowerSetp[1]'],
                           refs_old = 'bestest_hydronic_heat_pump_old',
                           refs_new = 'bestest_hydronic_heat_pump')

    elif testcase == 'multizone_residential_hydronic':
        compare_references(vars_timeseries = ['boi_reaGasBoi_y',
                                              'boi_reaPpum_y',
                                              'conHeaBth_reaTZon_y',
                                              'conHeaLiv_reaTZon_y',
                                              'conHeaRo1_reaTZon_y',
                                              'conHeaRo2_reaTZon_y',
                                              'conHeaRo3_reaTZon_y',
                                              'extLiv_reaCO2RooAir_y',
                                              'conCooBth_reaPCoo_y',
                                              'conHeaRo1_oveActHea_u'
                                              'conHeaLiv_oveActHea_u'],
                           refs_old = 'multizone_residential_hydronic_old',
                           refs_new = 'multizone_residential_hydronic')

    elif testcase == 'singlezone_commercial_hydronic':
        compare_references(vars_timeseries = ['oveTZonSet_u','oveTSupSet_u',
                             'reaCO2Zon_y','reaTZon_y',
                             'reaPFan_y','reaPPum_y',
                             'reaQHea_y','ahu_reaTSupAir_y',
                             'ahu_reaTRetAir_y'],
                           refs_old = 'singlezone_commercial_hydronic_old',
                           refs_new = 'singlezone_commercial_hydronic')

if __name__ == '__main__':
    compare(testcase='singlezone_commercial_hydronic')
