model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput ovePum_u(unit="1", min=0.0, max=1.0) "Integer signal to control the emission circuit pump either on or off";
	Modelica.Blocks.Interfaces.BooleanInput ovePum_activate "Activation for Integer signal to control the emission circuit pump either on or off";
	Modelica.Blocks.Interfaces.RealInput oveHeaPumY_u(unit="1", min=0.0, max=1.0) "Heat pump modulating signal for compressor speed between 0 (not working) and 1 (working at maximum capacity)";
	Modelica.Blocks.Interfaces.BooleanInput oveHeaPumY_activate "Activation for Heat pump modulating signal for compressor speed between 0 (not working) and 1 (working at maximum capacity)";
	Modelica.Blocks.Interfaces.RealInput oveFan_u(unit="1", min=0.0, max=1.0) "Integer signal to control the heat pump evaporator fan either on or off";
	Modelica.Blocks.Interfaces.BooleanInput oveFan_activate "Activation for Integer signal to control the heat pump evaporator fan either on or off";
	Modelica.Blocks.Interfaces.RealInput oveTSet_u(unit="K", min=278.15, max=308.15) "Zone operative temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveTSet_activate "Activation for Zone operative temperature setpoint";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolHouAng_y(unit="rad") = mod.weaSta.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinDir_y(unit="rad") = mod.weaSta.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput reaQFloHea_y(unit="W") = mod.reaQFloHea.y "Floor heating thermal power released to the zone";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTBlaSky_y(unit="K") = mod.weaSta.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTZon_y(unit="K") = mod.reaTZon.y "Zone operative temperature";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNTot_y(unit="1") = mod.weaSta.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinSpe_y(unit="m/s") = mod.weaSta.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNOpa_y(unit="1") = mod.weaSta.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaRelHum_y(unit="1") = mod.weaSta.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCloTim_y(unit="s") = mod.weaSta.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHGloHor_y(unit="W/m2") = mod.weaSta.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDryBul_y(unit="K") = mod.weaSta.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTSetCoo_y(unit="K") = mod.reaTSetCoo.y "Zone operative temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolAlt_y(unit="rad") = mod.weaSta.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCeiHei_y(unit="m") = mod.weaSta.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput reaPPumEmi_y(unit="W") = mod.reaPPumEmi.y "Emission circuit pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHHorIR_y(unit="W/m2") = mod.weaSta.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput reaQHeaPumCon_y(unit="W") = mod.reaQHeaPumCon.y "Heat pump thermal power exchanged in the condenser";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolZen_y(unit="rad") = mod.weaSta.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTSup_y(unit="K") = mod.reaTSup.y "Supply water temperature to radiant floor";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDifHor_y(unit="W/m2") = mod.weaSta.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput reaCOP_y(unit="1") = mod.reaCOP.y "Heat pump COP";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaPAtm_y(unit="Pa") = mod.weaSta.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDirNor_y(unit="W/m2") = mod.weaSta.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolDec_y(unit="rad") = mod.weaSta.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolTim_y(unit="s") = mod.weaSta.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput reaTSetHea_y(unit="K") = mod.reaTSetHea.y "Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLon_y(unit="rad") = mod.weaSta.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput reaPHeaPum_y(unit="W") = mod.reaPHeaPum.y "Heat pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput reaQHeaPumEva_y(unit="W") = mod.reaQHeaPumEva.y "Heat pump thermal power exchanged in the evaporator";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLat_y(unit="rad") = mod.weaSta.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput reaPFan_y(unit="W") = mod.reaPFan.y "Electrical power of the heat pump evaporator fan";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDewPoi_y(unit="K") = mod.weaSta.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaCO2RooAir_y(unit="ppm") = mod.reaCO2RooAir.y "CO2 concentration in the zone";
	Modelica.Blocks.Interfaces.RealOutput reaTRet_y(unit="K") = mod.reaTRet.y "Return water temperature from radiant floor";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTWetBul_y(unit="K") = mod.weaSta.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput ovePum_y(unit="1") = mod.ovePum.y "Integer signal to control the emission circuit pump either on or off";
	Modelica.Blocks.Interfaces.RealOutput oveHeaPumY_y(unit="1") = mod.oveHeaPumY.y "Heat pump modulating signal for compressor speed between 0 (not working) and 1 (working at maximum capacity)";
	Modelica.Blocks.Interfaces.RealOutput oveFan_y(unit="1") = mod.oveFan.y "Integer signal to control the heat pump evaporator fan either on or off";
	Modelica.Blocks.Interfaces.RealOutput oveTSet_y(unit="K") = mod.oveTSet.y "Zone operative temperature setpoint";
	// Original model
	BESTESTHydronicHeatPump.TestCase mod(
		ovePum(uExt(y=ovePum_u),activate(y=ovePum_activate)),
		oveHeaPumY(uExt(y=oveHeaPumY_u),activate(y=oveHeaPumY_activate)),
		oveFan(uExt(y=oveFan_u),activate(y=oveFan_activate)),
		oveTSet(uExt(y=oveTSet_u),activate(y=oveTSet_activate))) "Original model with overwrites";
end wrapped;
