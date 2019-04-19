# -*- coding: utf-8 -*-
"""
This is a python-based module to run set up, simulate 
and compare different BOPTEST test cases with different
controllers that are called from external imports
from the FastSim toolbox. 

"""

# GENERAL PACKAGE IMPORT
# ----------------------
import sys
import os
import pandas as pd
import pickle as pickle
from collections import OrderedDict

from FastSim import Simulation 

from Controllers.controller_BOPTEST_baseline import Controller_BOPTEST_baseline
from Controllers.controller_MPC import Controller_MPC
from Controllers.Predictors.predictor_BOPTEST import Predictor_BOPTEST
from Controllers.Observers.observer_TVKF import Observer_TVKF
from Controllers.Optimizers.optimizer_Pyomo import Optimizer_Pyomo

from Plants.plant_BOPTEST import Plant_BOPTEST

from kpis.kpi_calculator import KPI_Calculator

def generate_data_with_baseline(Ts,
                      bgn_sim_time,
                      end_sim_time,
                      cInpMap,
                      measMap,
                      plot = True):
    """
    This is a general method to get the data out 
    of the simulation of a BOPTEST test case using
    its baseline
    
    """
    
    sim = Simulation(Ts = Ts,
                     bgn_sim_time = bgn_sim_time,
                     end_sim_time = end_sim_time,
                     cInpMap = cInpMap,
                     measMap = measMap)
    
    sim.controller = Controller_BOPTEST_baseline(sim)
    sim.plant   = Plant_BOPTEST(sim)
    sim.simulate()
    
    if plot:
        sim.plot_separated(plot_control_inputs=False)
    
    test_case_data          = pd.DataFrame(sim.plant.case.get_forecast(index=sim.plant.case.y_store['time']))
    simulation_data_inputs  = pd.DataFrame(sim.plant.case.u_store).drop(['time'], axis=1)
    simulation_data_outputs = pd.DataFrame(sim.plant.case.y_store).drop(['time'], axis=1)
    data = pd.concat([test_case_data,simulation_data_inputs],  sort=True, axis=1)
    data = pd.concat([data,          simulation_data_outputs], sort=True, axis=1)
                
    # Create a datetime index
    datetime = []
    t0 = data['time'][0] 
    for t in data['time']:
        datetime.append(sim.time_sim[0] + pd.Timedelta(t-t0,'s'))
    data['datetime'] = datetime
    data.set_index('datetime',inplace=True)
    
    pd.to_pickle(data, 'test_case_data.pickle')
    
    sim.data_BOPTEST = data
    
    return sim
    
    
def identify_gb(data=None):
    
    if data is None:
        data = pd.read_pickle('test_case_data.pickle')
    
    GBT_dir = 'C:\Users\u0110910\Box Sync\work_folder\GBT' 
    GBTpy_dir = os.path.join(GBT_dir, os.path.join('greybox','python'))
    sys.path.append(GBTpy_dir)
    import greybox
    
    mops_path = os.path.join(GBT_dir, os.path.join('greybox','mop') ) 
    gb = greybox.GreyBox(mops=os.path.abspath(mops_path))
    gb.meas_data_orig = data.applymap(float)
    gb.meas_data_sampled = gb.meas_data_orig.copy()
    # Set this attribute to the current case:
    gb.set_case_attr(data_file = 'data_loaded_from_dataframe')
    gb.data_file = 'data_loaded_from_dataframe'
    
    gb.create_slices(period=3)
    gb.resample(900)
    
    gb.set_case_attr(slicekey='A')
    
    gb.plot_dataset(to_show=['TDryBul','TRooAir_y','TSupRead_y'])
    
    gb.set_case_attr(inputmap = {'irr1':'HGloHor', 'TAmb':'TDryBul', 'TSup':'TSupRead_y'},
                     fitmap   = {'z_0.TZon':'TRooAir_y'})
    
    model = 'ZonWalInt_K'
    
    if model == 'ZonWalIntEmb_A':
        gb.set_case_attr(mop=os.path.join(mops_path, 'ZonWalIntEmb_A_TSup-TAmb-1irr-powEleFree.mop'))
    elif model == 'ZonWalInt_A_fraRes':
        gb.set_case_attr(mop=os.path.join(mops_path, 'ZonWalInt_A_fraRes_TSup-TAmb-1irr-powEleFree.mop'))
    elif model == 'ZonWalInt_K':
        gb.set_case_attr(mop=os.path.join(mops_path, 'ZonWalInt_K_TSup-TAmb-1irr-powEleFree.mop'))
        
    gb.initial_guess()
    gb.estimate()
    
    print(gb.cases[0])
    
    gb.compare_sim(slicekey='A',timeseries=False, fitmap=False,
                    fitmap_and_inputs=True,
                    force_save_state_vec = True,  io='o')
    
    gb.compare_sim(slicekey='B',timeseries=False, fitmap=False,
                    fitmap_and_inputs=True,
                    force_save_state_vec = False, io='o')

    pars = gb.cases[0].pars_opt
    f=open('pars_opt_hydronic','wb')
    pickle.dump(pars,f)
    f.close()

    # gb.plot_sigma()    


def simulate_MPC(Ts,
                bgn_sim_time,
                end_sim_time,
                cInpMap,
                measMap,
                plot = True):
    
    sim = Simulation(Ts = Ts,
                     bgn_sim_time = bgn_sim_time,
                     end_sim_time = end_sim_time,
                     cInpMap = cInpMap,
                     measMap = measMap)
    
    statMap = OrderedDict()
    distMap = OrderedDict()
    
    statMap['z_0.cZon'] = 'TRooAir_y'
    statMap['z_0.cWal'] = 'z_0.cWal'
    statMap['z_0.cInt'] = 'z_0.cInt'
    
    distMap['irr1']  = 'HGloHor'
    distMap['T_amb'] = 'TDryBul'
    distMap['Price'] = 'PriceElectricPowerDynamic'
    
    Th = 12*3600

    sim.controller = Controller_MPC(sim, Th, statMap, distMap)
    sim.plant   = Plant_BOPTEST(sim)
    
    sim.controller.predictor = Predictor_BOPTEST(sim.controller)
    sim.controller.observer  = Observer_TVKF(sim.controller)
    sim.controller.optimizer = Optimizer_Pyomo(sim.controller)
    
    sim.controller.optimizer.constraints_sim['T_high'] = 24. + 273.15
    sim.controller.optimizer.constraints_sim['T_low']  = 22. + 273.15
    sim.controller.optimizer.constraints_sim['TSup_high']  = 70. + 273.15
    sim.controller.optimizer.constraints_sim['TSup_low']   = 20. + 273.15 
    
    sim.simulate()
    
    if plot:
        sim.plot_separated(plot_disturbances=False,
                           plot_price = True)
        sim.controller.observer.plot_kalman()
    sim.save_sim()
    
    return sim

if __name__ == "__main__":
    
    sys.path.append(os.path.join(os.path.dirname(os.path.dirname(__file__)),'testcase3'))
    
    measMap = OrderedDict()
    cInpMap = OrderedDict()
    
    cInpMap['TSup'] = 'oveTsup_u'
    
    measMap['z_0.cZon'] = 'TRooAir_y'
    
    
    Ts = 3600      # sample time: time between two optimizations in seconds
    
    bgn_sim_time = "20090301 00:00:00"    # begin time of the simulation   
    end_sim_time = "20090303 00:00:00"    # end time of the simulation
    
    sim_baseline = False
    if sim_baseline:
        bgn_sim_time_TS = pd.Timestamp(bgn_sim_time)
        end_sim_time_TS = pd.Timestamp(end_sim_time)
        total_sim_seconds = (end_sim_time_TS - bgn_sim_time_TS).total_seconds()
        sim = generate_data_with_baseline(Ts = int(total_sim_seconds),
                                          bgn_sim_time = bgn_sim_time,
                                          end_sim_time = end_sim_time,                                  
                                          cInpMap = cInpMap,
                                          measMap = measMap)
    
    id_gb = False
    if id_gb:
        identify_gb()
    
    sim_MPC = True
    if sim_MPC:
        sim = simulate_MPC(Ts = Ts,
                           bgn_sim_time = bgn_sim_time,
                           end_sim_time = end_sim_time,                                  
                           cInpMap = cInpMap,
                           measMap = measMap)
    
    evaluate = True
    if evaluate:
        cal = KPI_Calculator(sim.plant.case)
        kpis = cal.get_core_kpis()
        print('\nKPI RESULTS \n-----------')
        for key in kpis.keys():
            print('{0}: {1}'.format(key, kpis[key]))
        tdis_tot = cal.get_thermal_discomfort(plot=True)    
        ener_tot = cal.get_energy(plot=True, plot_by_source=True)
        emis_tot = cal.get_emissions(plot=True, plot_by_source=True)
        cost_tot = cal.get_cost(plot=True, plot_by_source=True, scenario='Dynamic')
        time_rat = cal.get_computational_time_ratio(plot=True)

