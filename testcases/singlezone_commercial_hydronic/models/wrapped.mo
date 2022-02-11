model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput ahu_oveFanRet_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput ahu_oveFanRet_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput oveValRad_u(unit="1", min=0.0, max=1.0) "Radiator valve control signal";
	Modelica.Blocks.Interfaces.BooleanInput oveValRad_activate "Activation for Radiator valve control signal";
	Modelica.Blocks.Interfaces.RealInput oveCO2ZonSet_u(unit="ppm", min=400.0, max=1000.0) "Zone CO2 concentration setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveCO2ZonSet_activate "Activation for Zone CO2 concentration setpoint";
	Modelica.Blocks.Interfaces.RealInput ahu_oveFanSup_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput ahu_oveFanSup_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput ovePum_u(unit="1", min=0.0, max=1.0) "Pump speed control signal for heating distribution system";
	Modelica.Blocks.Interfaces.BooleanInput ovePum_activate "Activation for Pump speed control signal for heating distribution system";
	Modelica.Blocks.Interfaces.RealInput oveValCoi_u(unit="1", min=0.0, max=1.0) "AHU heating coil valve control signal";
	Modelica.Blocks.Interfaces.BooleanInput oveValCoi_activate "Activation for AHU heating coil valve control signal";
	Modelica.Blocks.Interfaces.RealInput oveTZonSet_u(unit="K", min=283.15, max=303.15) "Zone temperature set point for heating";
	Modelica.Blocks.Interfaces.BooleanInput oveTZonSet_activate "Activation for Zone temperature set point for heating";
	Modelica.Blocks.Interfaces.RealInput oveTSupSet_u(unit="K", min=288.15, max=313.15) "AHU supply air temperature set point for heating";
	Modelica.Blocks.Interfaces.BooleanInput oveTSupSet_activate "Activation for AHU supply air temperature set point for heating";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolHouAng_y(unit="rad") = mod.weaSta.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinDir_y(unit="rad") = mod.weaSta.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCeiHei_y(unit="m") = mod.weaSta.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNTot_y(unit="1") = mod.weaSta.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinSpe_y(unit="m/s") = mod.weaSta.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNOpa_y(unit="1") = mod.weaSta.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaRelHum_y(unit="1") = mod.weaSta.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCloTim_y(unit="s") = mod.weaSta.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHGloHor_y(unit="W/m2") = mod.weaSta.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput ahu_reaTSupAir_y(unit="K") = mod.ahu.reaTSupAir.y "AHU supply air temperature";
	Modelica.Blocks.Interfaces.RealOutput ahu_reaPFanSup_y(unit="W") = mod.ahu.reaPFanSup.y "AHU supply fan electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaPEle_y(unit="W") = mod.reaPEle.y "Electrical power consumption for AHU fans and heating system pump";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolAlt_y(unit="rad") = mod.weaSta.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTZon_y(unit="K") = mod.reaTZon.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput reaOcc_y(unit="people") = mod.reaOcc.y "Building occupancy count";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHHorIR_y(unit="W/m2") = mod.weaSta.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolZen_y(unit="rad") = mod.weaSta.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDifHor_y(unit="W/m2") = mod.weaSta.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDewPoi_y(unit="K") = mod.weaSta.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaPPum_y(unit="W") = mod.reaPPum.y "Electrical power consumption of pump";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDirNor_y(unit="W/m2") = mod.weaSta.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput ahu_reaFloSupAir_y(unit="kg/s") = mod.ahu.reaFloSupAir.y "AHU supply air mass flowrate";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolDec_y(unit="rad") = mod.weaSta.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput reaQHea_y(unit="W") = mod.reaQHea.y "District heating thermal power consumption";
	Modelica.Blocks.Interfaces.RealOutput ahu_reaPFanRet_y(unit="W") = mod.ahu.reaPFanRet.y "AHU return fan electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolTim_y(unit="s") = mod.weaSta.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput ahu_reaTHeaRec_y(unit="K") = mod.ahu.reaTHeaRec.y "AHU air temperature exiting heat recovery in supply air stream";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDryBul_y(unit="K") = mod.weaSta.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLon_y(unit="rad") = mod.weaSta.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTBlaSky_y(unit="K") = mod.weaSta.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput ahu_reaTCoiSup_y(unit="K") = mod.ahu.reaTCoiSup.y "AHU heating coil supply water temperature";
	Modelica.Blocks.Interfaces.RealOutput ahu_reaTRetAir_y(unit="K") = mod.ahu.reaTRetAir.y "AHU return air temperature";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLat_y(unit="rad") = mod.weaSta.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput reaPFan_y(unit="W") = mod.reaPFan.y "Electrical power consumption of AHU supply and return fans";
	Modelica.Blocks.Interfaces.RealOutput reaCO2Zon_y(unit="ppm") = mod.reaCO2Zon.y "Zone CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaPAtm_y(unit="Pa") = mod.weaSta.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTCoiRet_y(unit="K") = mod.reaTCoiRet.y "AHU heating coil return water temperature";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTWetBul_y(unit="K") = mod.weaSta.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput ahu_oveFanRet_y(unit="1") = mod.ahu.oveFanRet.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput oveValRad_y(unit="1") = mod.oveValRad.y "Radiator valve control signal";
	Modelica.Blocks.Interfaces.RealOutput oveCO2ZonSet_y(unit="ppm") = mod.oveCO2ZonSet.y "Zone CO2 concentration setpoint";
	Modelica.Blocks.Interfaces.RealOutput ahu_oveFanSup_y(unit="1") = mod.ahu.oveFanSup.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput ovePum_y(unit="1") = mod.ovePum.y "Pump speed control signal for heating distribution system";
	Modelica.Blocks.Interfaces.RealOutput oveValCoi_y(unit="1") = mod.oveValCoi.y "AHU heating coil valve control signal";
	Modelica.Blocks.Interfaces.RealOutput oveTZonSet_y(unit="K") = mod.oveTZonSet.y "Zone temperature set point for heating";
	Modelica.Blocks.Interfaces.RealOutput oveTSupSet_y(unit="K") = mod.oveTSupSet.y "AHU supply air temperature set point for heating";
	// Original model
	OU44Emulator.Models.Validation.RealOccupancy mod(
		ahu.oveFanRet(uExt(y=ahu_oveFanRet_u),activate(y=ahu_oveFanRet_activate)),
		oveValRad(uExt(y=oveValRad_u),activate(y=oveValRad_activate)),
		oveCO2ZonSet(uExt(y=oveCO2ZonSet_u),activate(y=oveCO2ZonSet_activate)),
		ahu.oveFanSup(uExt(y=ahu_oveFanSup_u),activate(y=ahu_oveFanSup_activate)),
		ovePum(uExt(y=ovePum_u),activate(y=ovePum_activate)),
		oveValCoi(uExt(y=oveValCoi_u),activate(y=oveValCoi_activate)),
		oveTZonSet(uExt(y=oveTZonSet_u),activate(y=oveTZonSet_activate)),
		oveTSupSet(uExt(y=oveTSupSet_u),activate(y=oveTSupSet_activate))) "Original model with overwrites";
end wrapped;
