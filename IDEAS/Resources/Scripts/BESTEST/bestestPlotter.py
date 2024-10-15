#!/usr/bin/python3
"""Set up and run BESTEST in Dymola, and then plot the results.
"""
# File must be run from IDEAS/Resources/Scripts/BESTEST
# Simulation results are saved in /tmp
# Figures are save in FIGPATH

__author__ = "Filip Jorissen"
__version__ = "2018-06-08"

import os
import matplotlib.pyplot as plt
import numpy as np
from buildingspy.io.outputfile import Reader
from matplotlib import gridspec



def plot_results(ax, avgRes, minRes, maxRes, epRes, ideasRes, N, offset=0, marker=''):
    ax.spines["top"].set_visible(False)    
    #ax.spines["bottom"].set_visible(False)    
    ax.spines["right"].set_visible(False)    
    #ax.spines["left"].set_visible(False)   
    ax.get_xaxis().tick_bottom()    
    ax.get_yaxis().tick_left() 
    
    norm=avgRes
    if offset > 7:
        norm=avgRes*0+20
        
    ax.errorbar(np.array(range(N)) + offset, (avgRes[0:N]-avgRes)/norm, yerr=[[(avgRes[i]-minRes[i])/norm[i] for i in range(N)], [(maxRes[i]-avgRes[i])/norm[i] for i in range(N)]], fmt='o', color="#4C74AB", label="min, avg, max", capsize=2)
    ax.scatter([i + offset for i in range(N)], (ideasRes-avgRes)/norm, color="#C64E54", marker='$\circ$', label = "IDEAS 2.1", zorder=10)
    ax.scatter([i + offset for i in range(N)], (epRes[0:N]-avgRes)/norm, color="#4CB391", marker='x', label = "EnergyPlus 8.3", zorder=9)
    ax.scatter([(offset-round(offset))*1.25+round(offset)], -0.4, color='k', marker=marker, linewidth=0.01, s=60*(1 if offset>7 else 1.5))


FIGPATH="../../../Resources/Images/BESTEST/"
FORMATS = ['pdf', 'eps']

# os.system('dymola bestest.mos')


# Reference data from http://simulationresearch.lbl.gov/dirpubs/epl_bestest_ash.pdf
EHeacase600_Min = np.array([4.296, 4.355, 4.613, 5.05, 2.751, 0])
EHeacase600_Max = np.array([5.709, 5.786, 5.944, 6.469, 3.803, 0])
EHeacase600_Avg = np.array([5.046, 5.098364, 5.328, 5.686, 3.135, 0])
EHeacase600_E_plus = np.array([4.378, 4.422, 4.550, 4.881, 2.685, 0])
ECoocase600_Min = np.array([6.137, 3.915, 3.417, 2.129, 5.952, 4.816])
ECoocase600_Max = np.array([8.448, 6.139, 5.482, 3.701, 8.097, 7.064])
ECoocase600_Avg = np.array([7.053, 5.144, 4.416, 2.951, 6.79, 5.708])
ECoocase600_E_plus = np.array([6.740, 4.746, 4.168, 2.78, 6.454, 5.304])
PHeacase600_Min = np.array([3.437, 3.437, 3.591, 3.592, 5.232, 0])
PHeacase600_Max = np.array([4.354, 4.354, 4.379, 4.28, 6.954, 0])
PHeacase600_Avg = np.array([3.952, 3.947, 3.998, 3.949, 5.903, 0])
PHeacase600_E_plus = np.array([3.750, 3.740, 3.741, 3.721, 6.277, 0])
PCoocase600_Min = np.array([5.965, 5.669, 3.634, 3.072, 5.884, 5.831])
PCoocase600_Max = np.array([7.188, 6.673, 5.096, 4.116, 7.126, 7.068])
PCoocase600_Avg = np.array([6.535, 6.09, 4.393, 3.688, 6.478, 6.404])
PCoocase600_E_plus = np.array([6.565, 6.164, 3.921, 3.376, 6.501, 6.373])
EHeacase900_Min = np.array([1.17, 1.512, 3.261, 4.143, 0.793, 2.144, 0])
EHeacase900_Max = np.array([2.041, 2.282, 4.3, 5.335, 1.411, 3.373, 0])
EHeacase900_Avg = np.array([1.649, 1.951, 3.828, 4.603, 1.086, 2.709, 0])
EHeacase900_E_plus = np.array([1.224, 1.506, 3.193, 3.906, 0.768, 2.408, 0])
ECoocase900_Min = np.array([2.132, 0.821, 1.84, 1.039, 2.079, 0.4113, 0.387])
ECoocase900_Max = np.array([3.669, 1.883, 3.313, 2.238, 3.546, 0.895, 0.921])
ECoocase900_Avg = np.array([2.826, 1.521, 2.684, 1.715, 2.725, 0.669, 0.635])
ECoocase900_E_plus = np.array([2.508, 1.235, 2.548, 1.638, 2.433, 0.640, 0.530])
PHeacase900_Min = np.array([2.85, 2.858, 3.306, 3.355, 3.98, 2.41, 0])
PHeacase900_Max = np.array([3.797, 3.801, 4.061, 4.064, 6.428, 2.863, 0])
PHeacase900_Avg = np.array([3.452, 3.459, 3.738, 3.733, 5.414, 2.686, 0])
PHeacase900_E_plus = np.array([3.172, 3.172, 3.483, 3.506, 4.815, 2.693, 0])
PCoocase900_Min = np.array([2.888, 1.896, 2.385, 1.873, 2.888, 0.953, 2.033])
PCoocase900_Max = np.array([3.932, 3.277, 3.505, 3.08, 3.932, 1.422, 3.17])
PCoocase900_Avg = np.array([3.46, 2.676, 3.123, 2.526, 3.46, 1.21, 2.724])
PCoocase900_E_plus = np.array([3.250, 2.573, 2.777, 2.275, 3.250, 1.143, 2.388])

# selection of results since we did not simulate case 960
indices = [0,1,2,3,4,6]
EHeacase900_Min = np.array([EHeacase900_Min[i] for i in indices])
EHeacase900_Max = np.array([EHeacase900_Max[i] for i in indices])
EHeacase900_Avg = np.array([EHeacase900_Avg[i] for i in indices])
EHeacase900_E_plus = np.array([EHeacase900_E_plus[i] for i in indices])
ECoocase900_Min = np.array([ECoocase900_Min[i] for i in indices])
ECoocase900_Max = np.array([ECoocase900_Max[i] for i in indices])
ECoocase900_Avg = np.array([ECoocase900_Avg[i] for i in indices])
ECoocase900_E_plus = np.array([ECoocase900_E_plus[i] for i in indices])
PHeacase900_Min = np.array([PHeacase900_Min[i] for i in indices])
PHeacase900_Max = np.array([PHeacase900_Max[i] for i in indices])
PHeacase900_Avg = np.array([PHeacase900_Avg[i] for i in indices])
PHeacase900_E_plus = np.array([PHeacase900_E_plus[i] for i in indices])
PCoocase900_Min = np.array([PCoocase900_Min[i] for i in indices])
PCoocase900_Max = np.array([PCoocase900_Max[i] for i in indices])
PCoocase900_Avg = np.array([PCoocase900_Avg[i] for i in indices])
PCoocase900_E_plus = np.array([PCoocase900_E_plus[i] for i in indices])

TMax_min = np.array([64.9, 41.8, 63.2, 35.5, 48.9])
TMax_max = np.array([75.1, 46.4, 73.5, 38.5, 55.34])
TMax_Avg = np.array([67.7, 43.7, 66.1, 36.6, 50.5])
TMax_E_plus = np.array([65.3, 43.2, 63.5, 36.6, 52.4])
TMin_min = np.array([-18.8, -6.4, -23, -20.2, -2.8])
TMin_max = np.array([-15.6, -1.6, -21, -17.8, 6])
TMin_avg = np.array([-17.6, -3.7, -22.4, -19.3, 2.3])
TMin_E_plus = np.array([-17.4, -2.6, -23.0, -20.3, 2.2])
TAvg_min = np.array([24.2, 24.5, 18, 14, 26.4])
TAvg_max = np.array([27.4, 27.5, 20.8, 15.3, 30.5])
TAvg_avg = np.array([25.3, 25.5, 18.9, 14.5, 28.2])
TAvg_E_plus = np.array([25.8, 26, 18.6, 14.5, 29.1])

# change result order since energyplus result file is not that same as
indices = [0,2,1,3]
TMax_min = np.array([TMax_min[i] for i in indices])
TMax_max = np.array([TMax_max[i] for i in indices])
TMax_avg = np.array([TMax_Avg[i] for i in indices])
TMax_E_plus = np.array([TMax_E_plus[i] for i in indices])
TMin_min = np.array([TMin_min[i] for i in indices])
TMin_max = np.array([TMin_max[i] for i in indices])
TMin_avg = np.array([TMin_avg[i] for i in indices])
TMin_E_plus = np.array([TMin_E_plus[i] for i in indices])
TAvg_min = np.array([TAvg_min[i] for i in indices])
TAvg_max = np.array([TAvg_max[i] for i in indices])
TAvg_avg = np.array([TAvg_avg[i] for i in indices])
TAvg_E_plus = np.array([TAvg_E_plus[i] for i in indices])



reader =Reader("/tmp/BESTEST.mat", "dymola")


fig=plt.figure(figsize=(10,3.5))

legendsize=10
N=6

#gs = gridspec.GridSpec(4,1,height_ratios=[1,1,1,1])

ax0 = plt.subplot(1,1,1)
# print(reader.values("EAnnHea600[1]")[1][-1])
# exit(0)
plot_results(ax0, EHeacase600_Avg, EHeacase600_Min, EHeacase600_Max, EHeacase600_E_plus, np.array([reader.values("EAnnHea600[" + str(i+1) + "]")[1][-1] for i in range(N)]), N, -0.3, marker=r'$\mathrm{E}_H$')
plt.ylabel('Normalized errors $e_i$')
plt.legend(frameon=False,prop={'size':legendsize},loc=2,ncol=3,numpoints=1)

plot_results(ax0, ECoocase600_Avg, ECoocase600_Min, ECoocase600_Max, ECoocase600_E_plus, np.array([reader.values("EAnnCoo600[" + str(i+1) + "]")[1][-1] for i in range(N)]), N, -0.1, marker='$E_C$')
plot_results(ax0, PHeacase600_Avg, PHeacase600_Min, PHeacase600_Max, PHeacase600_E_plus, np.array([reader.values("QPeaHea600[" + str(i+1) + "]")[1][-1] for i in range(N)]), N, 0.1, marker='$P_H$')
plot_results(ax0, PCoocase600_Avg, PCoocase600_Min, PCoocase600_Max, PCoocase600_E_plus, np.array([reader.values("QPeaCoo600[" + str(i+1) + "]")[1][-1] for i in range(N)]), N, 0.3, marker='$P_C$')

plot_results(ax0, EHeacase900_Avg, EHeacase900_Min, EHeacase900_Max, EHeacase900_E_plus, [reader.values("EAnnHea900[" + str(i+1) + "]")[1][-1] for i in range(N)], N, -0.3 + N, marker='$E_H$')
plot_results(ax0, ECoocase900_Avg, ECoocase900_Min, ECoocase900_Max, ECoocase900_E_plus, [reader.values("EAnnCoo900[" + str(i+1) + "]")[1][-1] for i in range(N)], N, -0.1 + N, marker='$E_C$')
plot_results(ax0, PHeacase900_Avg, PHeacase900_Min, PHeacase900_Max, PHeacase900_E_plus, [reader.values("QPeaHea900[" + str(i+1) + "]")[1][-1] for i in range(N)], N, 0.1 + N, marker='$P_H$')
plot_results(ax0, PCoocase900_Avg, PCoocase900_Min, PCoocase900_Max, PCoocase900_E_plus, [reader.values("QPeaCoo900[" + str(i+1) + "]")[1][-1] for i in range(N)], N, 0.3 + N, marker='$P_C$')

N2=4
plot_results(ax0,  TMin_avg, TMin_min, TMin_max, TMin_E_plus, [reader.values("Tmin[" + str(i+1) + "]")[1][-1] for i in range(N2)], N2, -0.2 + 2*N, marker=r'$\downarrow$')
plot_results(ax0, TAvg_avg, TAvg_min, TAvg_max, TAvg_E_plus, [reader.values("TAnnAvg[" + str(i+1) + "]")[1][-1] for i in range(N2)], N2, 2*N, marker=r'$\bar{T}$')
plot_results(ax0, TMax_avg, TMax_min, TMax_max, TMax_E_plus, [reader.values("Tmax[" + str(i+1) + "]")[1][-1] for i in range(N2)], N2, 0.2+2*N, marker=r'$\uparrow$')



plt.xticks(range(N*2+N2), ['case 600', 'case 610', 'case 620', 'case 630', 'case 640', 'case 650','case 900', 'case 910', 'case 920', 'case 930', 'case 940', 'case 950', 'case 600 FF', 'case 650 FF', 'case 900 FF', 'case 950 FF'], rotation=45)
plt.ylim([-0.5,0.5])
plt.xlim([-0.7, 2*N + N2 -0.5])


plt.tight_layout()

plt.savefig(os.path.join(FIGPATH, "bestest.pdf"))
plt.savefig(os.path.join(FIGPATH, "bestest.png"))

plt.show()
