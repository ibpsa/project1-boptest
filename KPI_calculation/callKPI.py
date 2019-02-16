from KPI import KPI
import pandas as pd

config={
	"power_points": {
		"fan": {
			"fan1": "P_sf_bot",
			"fan2": "P_sf_mid",
			"fan3": "P_sf_top"
		},
		"chiller": {
			"chiller1": "P_chiller"
		}
	},
	"zone_temp_points": {
		"zone 1": {
			"name": "Z1",		    
			"zonetemp": "T_Z1t",
			"coolsetp": "c_sp",
			"heatsetp": "h_sp"
		},
		"zone 2": {
			"name": "Z2",	
			"zonetemp": "T_Z2t",
			"coolsetp": "c_sp",
			"heatsetp": "h_sp"
		}
	}
}
tab=pd.read_csv('input.csv')

k1=KPI(tab,config)

k1.Energy_Usage_Metrics()

k1.Thermal_Comfort_Metrics()

k1.System_Equipment_Utilization_Metrics()