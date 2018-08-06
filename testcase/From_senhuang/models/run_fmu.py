
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from pyfmi import load_fmu

modelName = 'SimpleRC_Input_test.fmu'
model = load_fmu(modelName)

res_opt = model.simulate(start_time=0.,final_time=86400)

plt.figure()
plt.plot(res_opt['time'],res_opt['TZone']-273.15,label='default')
plt.ylabel('Zone temperature [degC]')
plt.legend()
plt.savefig('plots/outt.eps')
plt.close()

plt.clf()
plt.plot(res_opt['time'],res_opt['read_Real.y[2]'],label='default')
plt.ylabel('Input Heat [W]')
plt.legend()
plt.savefig('plots/outq.eps')
plt.close()
