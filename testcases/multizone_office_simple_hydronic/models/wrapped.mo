model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput bms_oveByPassNz_u(unit="1", min=0.0, max=1.0) "North zone AHU setpoint to override the recovery bypass (for night free cooling purposes)";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveByPassNz_activate "Activation for North zone AHU setpoint to override the recovery bypass (for night free cooling purposes)";
	Modelica.Blocks.Interfaces.RealInput bms_oveByPassSz_u(unit="1", min=0.0, max=1.0) "South zone AHU setpoint to override the recovery bypass (for night free cooling purposes)";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveByPassSz_activate "Activation for South zone AHU setpoint to override the recovery bypass (for night free cooling purposes)";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfAhuCooNz_u(unit="1", min=0.0, max=1.0) "North zone AHU cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfAhuCooNz_activate "Activation for North zone AHU cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfAhuCooSz_u(unit="1", min=0.0, max=1.0) "South zone AHU cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfAhuCooSz_activate "Activation for South zone AHU cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfAhuHeaNz_u(unit="1", min=0.0, max=1.0) "North zone AHU heating pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfAhuHeaNz_activate "Activation for North zone AHU heating pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfAhuHeaSz_u(unit="1", min=0.0, max=1.0) "South zone AHU heating pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfAhuHeaSz_activate "Activation for South zone AHU heating pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfAhuRetNz_u(unit="1", min=0.0, max=1.0) "North zone AHU return fan speed setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfAhuRetNz_activate "Activation for North zone AHU return fan speed setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfAhuRetSz_u(unit="1", min=0.0, max=1.0) "South zone AHU return fan speed setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfAhuRetSz_activate "Activation for South zone AHU return fan speed setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfAhuSupNz_u(unit="1", min=0.0, max=1.0) "North zone AHU supply fan speed setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfAhuSupNz_activate "Activation for North zone AHU supply fan speed setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfAhuSupSz_u(unit="1", min=0.0, max=1.0) "South zone AHU supply fan speed setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfAhuSupSz_activate "Activation for South zone AHU supply fan speed setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfEmiCooNz_u(unit="1", min=0.0, max=1.0) "North zone emission cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfEmiCooNz_activate "Activation for North zone emission cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfEmiCooSz_u(unit="1", min=0.0, max=1.0) "South zone emission cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfEmiCooSz_activate "Activation for South zone emission cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfEmiHeaNz_u(unit="1", min=0.0, max=1.0) "North zone emission heating pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfEmiHeaNz_activate "Activation for North zone emission heating pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfEmiHeaSz_u(unit="1", min=0.0, max=1.0) "South zone emission heating pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfEmiHeaSz_activate "Activation for South zone emission heating pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfProCoo_u(unit="1", min=0.0, max=1.0) "Cooling production system pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfProCoo_activate "Activation for Cooling production system pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_ovePrfProHea_u(unit="1", min=0.0, max=1.0) "Heating production system pump activation setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_ovePrfProHea_activate "Activation for Heating production system pump activation setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTProCoo_u(unit="K", min=273.15, max=293.15) "Cooling production system supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTProCoo_activate "Activation for Cooling production system supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTProHea_u(unit="K", min=293.15, max=353.15) "Heating production system supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTProHea_activate "Activation for Heating production system supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupAhuCooNz_u(unit="K", min=273.15, max=293.15) "North zone AHU cooling water supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupAhuCooNz_activate "Activation for North zone AHU cooling water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupAhuCooSz_u(unit="K", min=273.15, max=293.15) "South zone AHU cooling water supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupAhuCooSz_activate "Activation for South zone AHU cooling water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupAhuHeaNz_u(unit="K", min=293.15, max=323.15) "North zone AHU heating water supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupAhuHeaNz_activate "Activation for North zone AHU heating water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupAhuHeaSz_u(unit="K", min=293.15, max=323.15) "South zone AHU heating water supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupAhuHeaSz_activate "Activation for South zone AHU heating water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupAhuNz_u(unit="K", min=289.15, max=298.15) "North zone AHU air supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupAhuNz_activate "Activation for North zone AHU air supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupAhuSz_u(unit="K", min=289.15, max=298.15) "South zone AHU air supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupAhuSz_activate "Activation for South zone AHU air supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupEmiCooNz_u(unit="K", min=273.15, max=293.15) "North zone cooling emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupEmiCooNz_activate "Activation for North zone cooling emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupEmiCooSz_u(unit="K", min=273.15, max=293.15) "Southh zone cooling emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupEmiCooSz_activate "Activation for Southh zone cooling emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupEmiHeaNz_u(unit="K", min=293.15, max=323.15) "North zone heating emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupEmiHeaNz_activate "Activation for North zone heating emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTSupEmiHeaSz_u(unit="K", min=293.15, max=323.15) "South zone heating emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTSupEmiHeaSz_activate "Activation for South zone heating emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTZonSetMaxNz_u(unit="K", min=288.15, max=303.15) "North zone maximum (cooling) zone temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTZonSetMaxNz_activate "Activation for North zone maximum (cooling) zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTZonSetMaxSz_u(unit="K", min=288.15, max=303.15) "South zone maximum (cooling) zone temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTZonSetMaxSz_activate "Activation for South zone maximum (cooling) zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTZonSetMinNz_u(unit="K", min=288.15, max=303.15) "North zone minimum (heating) zone temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTZonSetMinNz_activate "Activation for North zone minimum (heating) zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveTZonSetMinSz_u(unit="K", min=283.15, max=303.15) "South zone minimum (heating) zone temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveTZonSetMinSz_activate "Activation for South zone minimum (heating) zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveValPosAhuCooNz_u(unit="1", min=0.0, max=1.0) "North zone AHU cooling circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveValPosAhuCooNz_activate "Activation for North zone AHU cooling circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveValPosAhuCooSz_u(unit="1", min=0.0, max=1.0) "South zone AHU cooling circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveValPosAhuCooSz_activate "Activation for South zone AHU cooling circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveValPosAhuHeaNz_u(unit="1", min=0.0, max=1.0) "North zone AHU heating circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveValPosAhuHeaNz_activate "Activation for North zone AHU heating circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveValPosAhuHeaSz_u(unit="1", min=0.0, max=1.0) "South zone AHU heating circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveValPosAhuHeaSz_activate "Activation for South zone AHU heating circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveValPosEmiCooNz_u(unit="1", min=0.0, max=1.0) "North zone cooling emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveValPosEmiCooNz_activate "Activation for North zone cooling emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveValPosEmiCooSz_u(unit="1", min=0.0, max=1.0) "South zone cooling emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveValPosEmiCooSz_activate "Activation for South zone cooling emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveValPosEmiHeaNz_u(unit="1", min=0.0, max=1.0) "North zone heating emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveValPosEmiHeaNz_activate "Activation for North zone heating emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealInput bms_oveValPosEmiHeaSz_u(unit="1", min=0.0, max=1.0) "South zone heating emission circuit supply mixing valve position setpoint";
	Modelica.Blocks.Interfaces.BooleanInput bms_oveValPosEmiHeaSz_activate "Activation for South zone heating emission circuit supply mixing valve position setpoint";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPFcuNz_y(unit="W") = mod.heating_cooling.reaPFcuNz.y "Electric power used by the north zone fan coil units";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPFcuSz_y(unit="W") = mod.heating_cooling.reaPFcuSz.y "Electric power used by the south zone fan coil units";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPProCoo_y(unit="W") = mod.heating_cooling.reaPProCoo.y "Electric power used by the cooling production system";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPProHea_y(unit="W") = mod.heating_cooling.reaPProHea.y "Gas power used by the heating production system";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumAhuCooNz_y(unit="W") = mod.heating_cooling.reaPPumAhuCooNz.y "Electric power used by the north zone cooling AHU water system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumAhuCooSz_y(unit="W") = mod.heating_cooling.reaPPumAhuCooSz.y "Electric power used by the south zone cooling AHU water system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumAhuHeaNz_y(unit="W") = mod.heating_cooling.reaPPumAhuHeaNz.y "Electric power used by the north zone heating AHU water system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumAhuHeaSz_y(unit="W") = mod.heating_cooling.reaPPumAhuHeaSz.y "Electric power used by the south zone heating AHU water system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumEmiCooNz_y(unit="W") = mod.heating_cooling.reaPPumEmiCooNz.y "Electric power used by the north zone cooling emission system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumEmiCooSz_y(unit="W") = mod.heating_cooling.reaPPumEmiCooSz.y "Electric power used by the south zone cooling emission system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumEmiHeaNz_y(unit="W") = mod.heating_cooling.reaPPumEmiHeaNz.y "Electric power used by the north zone heating emission system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumEmiHeaSz_y(unit="W") = mod.heating_cooling.reaPPumEmiHeaSz.y "Electric power used by the south zone heating emission system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumProCoo_y(unit="W") = mod.heating_cooling.reaPPumProCoo.y "Electric power used by the cooling production system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaPPumProHea_y(unit="W") = mod.heating_cooling.reaPPumProHea.y "Electric power used by the heating production system pump";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetAhuCooNz_y(unit="K") = mod.heating_cooling.reaTRetAhuCooNz.y "North zone cooling AHU water system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetAhuCooSz_y(unit="K") = mod.heating_cooling.reaTRetAhuCooSz.y "South zone cooling AHU water system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetAhuHeaNz_y(unit="K") = mod.heating_cooling.reaTRetAhuHeaNz.y "North zone heating AHU water system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetAhuHeaSz_y(unit="K") = mod.heating_cooling.reaTRetAhuHeaSz.y "South zone heating AHU water system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetEmiCooNz_y(unit="K") = mod.heating_cooling.reaTRetEmiCooNz.y "North zone cooling emission system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetEmiCooSz_y(unit="K") = mod.heating_cooling.reaTRetEmiCooSz.y "South zone cooling emission system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetEmiHeaNz_y(unit="K") = mod.heating_cooling.reaTRetEmiHeaNz.y "North zone heating emission system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetEmiHeaSz_y(unit="K") = mod.heating_cooling.reaTRetEmiHeaSz.y "South zone heating emission system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetProCoo_y(unit="K") = mod.heating_cooling.reaTRetProCoo.y "Cooling production system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTRetProHea_y(unit="K") = mod.heating_cooling.reaTRetProHea.y "Heating production system return temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupAhuCooNz_y(unit="K") = mod.heating_cooling.reaTSupAhuCooNz.y "North zone cooling AHU water system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupAhuCooSz_y(unit="K") = mod.heating_cooling.reaTSupAhuCooSz.y "South zone cooling AHU water system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupAhuHeaNz_y(unit="K") = mod.heating_cooling.reaTSupAhuHeaNz.y "North zone heating AHU water system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupAhuHeaSz_y(unit="K") = mod.heating_cooling.reaTSupAhuHeaSz.y "South zone heating AHU water system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupEmiCooNz_y(unit="K") = mod.heating_cooling.reaTSupEmiCooNz.y "North zone cooling emission system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupEmiCooSz_y(unit="K") = mod.heating_cooling.reaTSupEmiCooSz.y "South zone cooling emission system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupEmiHeaNz_y(unit="K") = mod.heating_cooling.reaTSupEmiHeaNz.y "North zone heating emission system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupEmiHeaSz_y(unit="K") = mod.heating_cooling.reaTSupEmiHeaSz.y "South zone heating emission system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupProCoo_y(unit="K") = mod.heating_cooling.reaTSupProCoo.y "Cooling production system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput heating_cooling_reaTSupProHea_y(unit="K") = mod.heating_cooling.reaTSupProHea.y "Heating production system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput structure_reaCO2ZonNz_y(unit="ppm") = mod.structure.reaCO2ZonNz.y "North zone CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput structure_reaCO2ZonSz_y(unit="ppm") = mod.structure.reaCO2ZonSz.y "South zone CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput structure_reaTZonNz_y(unit="K") = mod.structure.reaTZonNz.y "North zone operative temperature";
	Modelica.Blocks.Interfaces.RealOutput structure_reaTZonPercHighNz_y(unit="K") = mod.structure.reaTZonPercHighNz.y "North zone upper percentile temperature";
	Modelica.Blocks.Interfaces.RealOutput structure_reaTZonPercHighSz_y(unit="K") = mod.structure.reaTZonPercHighSz.y "South zone upper percentile temperature";
	Modelica.Blocks.Interfaces.RealOutput structure_reaTZonPercLowNz_y(unit="K") = mod.structure.reaTZonPercLowNz.y "North zone lower percentile temperature";
	Modelica.Blocks.Interfaces.RealOutput structure_reaTZonPercLowSz_y(unit="K") = mod.structure.reaTZonPercLowSz.y "South zone lower percentile temperature";
	Modelica.Blocks.Interfaces.RealOutput structure_reaTZonSz_y(unit="K") = mod.structure.reaTZonSz.y "South zone operative temperature";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaPAhuRetNz_y(unit="W") = mod.ventilation.reaPAhuRetNz.y "North zone AHU return fan electric power";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaPAhuRetSz_y(unit="W") = mod.ventilation.reaPAhuRetSz.y "South zone AHU return fan electric power";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaPAhuSupNz_y(unit="W") = mod.ventilation.reaPAhuSupNz.y "North zone AHU supply fan electric power";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaPAhuSupSz_y(unit="W") = mod.ventilation.reaPAhuSupSz.y "South zone AHU supply fan electric power";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTExhAhuNz_y(unit="K") = mod.ventilation.reaTExhAhuNz.y "North zone AHU air exhaust temperature";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTExhAhuSz_y(unit="K") = mod.ventilation.reaTExhAhuSz.y "South zone AHU air exhaust temperature";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTInAhuNz_y(unit="K") = mod.ventilation.reaTInAhuNz.y "North zone AHU air inlet temperature";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTInAhuSz_y(unit="K") = mod.ventilation.reaTInAhuSz.y "South zone AHU air inlet temperature";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTRecAhuNz_y(unit="K") = mod.ventilation.reaTRecAhuNz.y "North zone AHU air temperature after recovery";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTRecAhuSz_y(unit="K") = mod.ventilation.reaTRecAhuSz.y "South zone AHU air temperature after recovery";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTRetAhuNz_y(unit="K") = mod.ventilation.reaTRetAhuNz.y "North zone AHU air return temperature";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTRetAhuSz_y(unit="K") = mod.ventilation.reaTRetAhuSz.y "South zone AHU air return temperature";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTSupAhuNz_y(unit="K") = mod.ventilation.reaTSupAhuNz.y "North zone AHU air supply temperature";
	Modelica.Blocks.Interfaces.RealOutput ventilation_reaTSupAhuSz_y(unit="K") = mod.ventilation.reaTSupAhuSz.y "South zone AHU air supply temperature";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCeiHei_y(unit="m") = mod.weaSta.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCloTim_y(unit="s") = mod.weaSta.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDifHor_y(unit="W/m2") = mod.weaSta.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDirNor_y(unit="W/m2") = mod.weaSta.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHGloHor_y(unit="W/m2") = mod.weaSta.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHHorIR_y(unit="W/m2") = mod.weaSta.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLat_y(unit="rad") = mod.weaSta.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLon_y(unit="rad") = mod.weaSta.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNOpa_y(unit="1") = mod.weaSta.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNTot_y(unit="1") = mod.weaSta.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaPAtm_y(unit="Pa") = mod.weaSta.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaRelHum_y(unit="1") = mod.weaSta.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolAlt_y(unit="rad") = mod.weaSta.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolDec_y(unit="rad") = mod.weaSta.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolHouAng_y(unit="rad") = mod.weaSta.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolTim_y(unit="s") = mod.weaSta.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolZen_y(unit="rad") = mod.weaSta.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTBlaSky_y(unit="K") = mod.weaSta.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDewPoi_y(unit="K") = mod.weaSta.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDryBul_y(unit="K") = mod.weaSta.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTWetBul_y(unit="K") = mod.weaSta.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinDir_y(unit="rad") = mod.weaSta.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinSpe_y(unit="m/s") = mod.weaSta.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput bms_oveByPassNz_y(unit="1") = mod.bms.oveByPassNz.y "North zone AHU setpoint to override the recovery bypass (for night free cooling purposes)";
	Modelica.Blocks.Interfaces.RealOutput bms_oveByPassSz_y(unit="1") = mod.bms.oveByPassSz.y "South zone AHU setpoint to override the recovery bypass (for night free cooling purposes)";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfAhuCooNz_y(unit="1") = mod.bms.ovePrfAhuCooNz.y "North zone AHU cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfAhuCooSz_y(unit="1") = mod.bms.ovePrfAhuCooSz.y "South zone AHU cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfAhuHeaNz_y(unit="1") = mod.bms.ovePrfAhuHeaNz.y "North zone AHU heating pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfAhuHeaSz_y(unit="1") = mod.bms.ovePrfAhuHeaSz.y "South zone AHU heating pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfAhuRetNz_y(unit="1") = mod.bms.ovePrfAhuRetNz.y "North zone AHU return fan speed setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfAhuRetSz_y(unit="1") = mod.bms.ovePrfAhuRetSz.y "South zone AHU return fan speed setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfAhuSupNz_y(unit="1") = mod.bms.ovePrfAhuSupNz.y "North zone AHU supply fan speed setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfAhuSupSz_y(unit="1") = mod.bms.ovePrfAhuSupSz.y "South zone AHU supply fan speed setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfEmiCooNz_y(unit="1") = mod.bms.ovePrfEmiCooNz.y "North zone emission cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfEmiCooSz_y(unit="1") = mod.bms.ovePrfEmiCooSz.y "South zone emission cooling pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfEmiHeaNz_y(unit="1") = mod.bms.ovePrfEmiHeaNz.y "North zone emission heating pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfEmiHeaSz_y(unit="1") = mod.bms.ovePrfEmiHeaSz.y "South zone emission heating pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfProCoo_y(unit="1") = mod.bms.ovePrfProCoo.y "Cooling production system pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_ovePrfProHea_y(unit="1") = mod.bms.ovePrfProHea.y "Heating production system pump activation setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTProCoo_y(unit="K") = mod.bms.oveTProCoo.y "Cooling production system supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTProHea_y(unit="K") = mod.bms.oveTProHea.y "Heating production system supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupAhuCooNz_y(unit="K") = mod.bms.oveTSupAhuCooNz.y "North zone AHU cooling water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupAhuCooSz_y(unit="K") = mod.bms.oveTSupAhuCooSz.y "South zone AHU cooling water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupAhuHeaNz_y(unit="K") = mod.bms.oveTSupAhuHeaNz.y "North zone AHU heating water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupAhuHeaSz_y(unit="K") = mod.bms.oveTSupAhuHeaSz.y "South zone AHU heating water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupAhuNz_y(unit="K") = mod.bms.oveTSupAhuNz.y "North zone AHU air supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupAhuSz_y(unit="K") = mod.bms.oveTSupAhuSz.y "South zone AHU air supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupEmiCooNz_y(unit="K") = mod.bms.oveTSupEmiCooNz.y "North zone cooling emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupEmiCooSz_y(unit="K") = mod.bms.oveTSupEmiCooSz.y "Southh zone cooling emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupEmiHeaNz_y(unit="K") = mod.bms.oveTSupEmiHeaNz.y "North zone heating emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTSupEmiHeaSz_y(unit="K") = mod.bms.oveTSupEmiHeaSz.y "South zone heating emission circuit supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTZonSetMaxNz_y(unit="K") = mod.bms.oveTZonSetMaxNz.y "North zone maximum (cooling) zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTZonSetMaxSz_y(unit="K") = mod.bms.oveTZonSetMaxSz.y "South zone maximum (cooling) zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTZonSetMinNz_y(unit="K") = mod.bms.oveTZonSetMinNz.y "North zone minimum (heating) zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveTZonSetMinSz_y(unit="K") = mod.bms.oveTZonSetMinSz.y "South zone minimum (heating) zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveValPosAhuCooNz_y(unit="1") = mod.bms.oveValPosAhuCooNz.y "North zone AHU cooling circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveValPosAhuCooSz_y(unit="1") = mod.bms.oveValPosAhuCooSz.y "South zone AHU cooling circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveValPosAhuHeaNz_y(unit="1") = mod.bms.oveValPosAhuHeaNz.y "North zone AHU heating circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveValPosAhuHeaSz_y(unit="1") = mod.bms.oveValPosAhuHeaSz.y "South zone AHU heating circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveValPosEmiCooNz_y(unit="1") = mod.bms.oveValPosEmiCooNz.y "North zone cooling emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveValPosEmiCooSz_y(unit="1") = mod.bms.oveValPosEmiCooSz.y "South zone cooling emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveValPosEmiHeaNz_y(unit="1") = mod.bms.oveValPosEmiHeaNz.y "North zone heating emission circuit mixing valve position setpoint";
	Modelica.Blocks.Interfaces.RealOutput bms_oveValPosEmiHeaSz_y(unit="1") = mod.bms.oveValPosEmiHeaSz.y "South zone heating emission circuit supply mixing valve position setpoint";
	// Original model
	BuildingEmulators.BuildingSystem mod(
		bms.oveByPassNz(uExt(y=bms_oveByPassNz_u),activate(y=bms_oveByPassNz_activate)),
		bms.oveByPassSz(uExt(y=bms_oveByPassSz_u),activate(y=bms_oveByPassSz_activate)),
		bms.ovePrfAhuCooNz(uExt(y=bms_ovePrfAhuCooNz_u),activate(y=bms_ovePrfAhuCooNz_activate)),
		bms.ovePrfAhuCooSz(uExt(y=bms_ovePrfAhuCooSz_u),activate(y=bms_ovePrfAhuCooSz_activate)),
		bms.ovePrfAhuHeaNz(uExt(y=bms_ovePrfAhuHeaNz_u),activate(y=bms_ovePrfAhuHeaNz_activate)),
		bms.ovePrfAhuHeaSz(uExt(y=bms_ovePrfAhuHeaSz_u),activate(y=bms_ovePrfAhuHeaSz_activate)),
		bms.ovePrfAhuRetNz(uExt(y=bms_ovePrfAhuRetNz_u),activate(y=bms_ovePrfAhuRetNz_activate)),
		bms.ovePrfAhuRetSz(uExt(y=bms_ovePrfAhuRetSz_u),activate(y=bms_ovePrfAhuRetSz_activate)),
		bms.ovePrfAhuSupNz(uExt(y=bms_ovePrfAhuSupNz_u),activate(y=bms_ovePrfAhuSupNz_activate)),
		bms.ovePrfAhuSupSz(uExt(y=bms_ovePrfAhuSupSz_u),activate(y=bms_ovePrfAhuSupSz_activate)),
		bms.ovePrfEmiCooNz(uExt(y=bms_ovePrfEmiCooNz_u),activate(y=bms_ovePrfEmiCooNz_activate)),
		bms.ovePrfEmiCooSz(uExt(y=bms_ovePrfEmiCooSz_u),activate(y=bms_ovePrfEmiCooSz_activate)),
		bms.ovePrfEmiHeaNz(uExt(y=bms_ovePrfEmiHeaNz_u),activate(y=bms_ovePrfEmiHeaNz_activate)),
		bms.ovePrfEmiHeaSz(uExt(y=bms_ovePrfEmiHeaSz_u),activate(y=bms_ovePrfEmiHeaSz_activate)),
		bms.ovePrfProCoo(uExt(y=bms_ovePrfProCoo_u),activate(y=bms_ovePrfProCoo_activate)),
		bms.ovePrfProHea(uExt(y=bms_ovePrfProHea_u),activate(y=bms_ovePrfProHea_activate)),
		bms.oveTProCoo(uExt(y=bms_oveTProCoo_u),activate(y=bms_oveTProCoo_activate)),
		bms.oveTProHea(uExt(y=bms_oveTProHea_u),activate(y=bms_oveTProHea_activate)),
		bms.oveTSupAhuCooNz(uExt(y=bms_oveTSupAhuCooNz_u),activate(y=bms_oveTSupAhuCooNz_activate)),
		bms.oveTSupAhuCooSz(uExt(y=bms_oveTSupAhuCooSz_u),activate(y=bms_oveTSupAhuCooSz_activate)),
		bms.oveTSupAhuHeaNz(uExt(y=bms_oveTSupAhuHeaNz_u),activate(y=bms_oveTSupAhuHeaNz_activate)),
		bms.oveTSupAhuHeaSz(uExt(y=bms_oveTSupAhuHeaSz_u),activate(y=bms_oveTSupAhuHeaSz_activate)),
		bms.oveTSupAhuNz(uExt(y=bms_oveTSupAhuNz_u),activate(y=bms_oveTSupAhuNz_activate)),
		bms.oveTSupAhuSz(uExt(y=bms_oveTSupAhuSz_u),activate(y=bms_oveTSupAhuSz_activate)),
		bms.oveTSupEmiCooNz(uExt(y=bms_oveTSupEmiCooNz_u),activate(y=bms_oveTSupEmiCooNz_activate)),
		bms.oveTSupEmiCooSz(uExt(y=bms_oveTSupEmiCooSz_u),activate(y=bms_oveTSupEmiCooSz_activate)),
		bms.oveTSupEmiHeaNz(uExt(y=bms_oveTSupEmiHeaNz_u),activate(y=bms_oveTSupEmiHeaNz_activate)),
		bms.oveTSupEmiHeaSz(uExt(y=bms_oveTSupEmiHeaSz_u),activate(y=bms_oveTSupEmiHeaSz_activate)),
		bms.oveTZonSetMaxNz(uExt(y=bms_oveTZonSetMaxNz_u),activate(y=bms_oveTZonSetMaxNz_activate)),
		bms.oveTZonSetMaxSz(uExt(y=bms_oveTZonSetMaxSz_u),activate(y=bms_oveTZonSetMaxSz_activate)),
		bms.oveTZonSetMinNz(uExt(y=bms_oveTZonSetMinNz_u),activate(y=bms_oveTZonSetMinNz_activate)),
		bms.oveTZonSetMinSz(uExt(y=bms_oveTZonSetMinSz_u),activate(y=bms_oveTZonSetMinSz_activate)),
		bms.oveValPosAhuCooNz(uExt(y=bms_oveValPosAhuCooNz_u),activate(y=bms_oveValPosAhuCooNz_activate)),
		bms.oveValPosAhuCooSz(uExt(y=bms_oveValPosAhuCooSz_u),activate(y=bms_oveValPosAhuCooSz_activate)),
		bms.oveValPosAhuHeaNz(uExt(y=bms_oveValPosAhuHeaNz_u),activate(y=bms_oveValPosAhuHeaNz_activate)),
		bms.oveValPosAhuHeaSz(uExt(y=bms_oveValPosAhuHeaSz_u),activate(y=bms_oveValPosAhuHeaSz_activate)),
		bms.oveValPosEmiCooNz(uExt(y=bms_oveValPosEmiCooNz_u),activate(y=bms_oveValPosEmiCooNz_activate)),
		bms.oveValPosEmiCooSz(uExt(y=bms_oveValPosEmiCooSz_u),activate(y=bms_oveValPosEmiCooSz_activate)),
		bms.oveValPosEmiHeaNz(uExt(y=bms_oveValPosEmiHeaNz_u),activate(y=bms_oveValPosEmiHeaNz_activate)),
		bms.oveValPosEmiHeaSz(uExt(y=bms_oveValPosEmiHeaSz_u),activate(y=bms_oveValPosEmiHeaSz_activate))) "Original model with overwrites";
end wrapped;
