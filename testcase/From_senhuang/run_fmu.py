# -*- coding: utf-8 -*-
"""
This script runs the FMU for the boptest test case and generates the plots based on the simulation

"""

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from pyfmi import load_fmu

modelName = 'IBPSA_SimpleRC_Input.fmu'
model = load_fmu(modelName)

res_opt = model.simulate(start_time=0.,final_time=86400)

plt.figure()
splt.plot(res_opt['time'],res_opt['souTOut.y']-273.15,label='default')
plt.plot(res_opt['time'],res_opt['read_Real.y[1]'],label='actual')
plt.ylabel('Outdoor air temperature [degC]')
plt.legend()
plt.savefig('result.eps')
plt.close()
