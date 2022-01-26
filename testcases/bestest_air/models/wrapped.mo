model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput con_oveTSetCoo_u(unit="K", min=296.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput con_oveTSetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput con_oveTSetHea_u(unit="K", min=288.15, max=296.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput con_oveTSetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput fcu_oveTSup_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput fcu_oveTSup_activate "Activation for Supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput fcu_oveFan_u(unit="1", min=0.0, max=1.0) "Fan control signal as air mass flow rate normalized to the design air mass flow rate";
	Modelica.Blocks.Interfaces.BooleanInput fcu_oveFan_activate "Activation for Fan control signal as air mass flow rate normalized to the design air mass flow rate";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput zon_reaPPlu_y(unit="W") = mod.zon.reaPPlu.y "Plug load power submeter";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaRelHum_y(unit="1") = mod.zon.weaSta.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaTDewPoi_y(unit="K") = mod.zon.weaSta.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaPAtm_y(unit="Pa") = mod.zon.weaSta.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaLon_y(unit="rad") = mod.zon.weaSta.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaWinDir_y(unit="rad") = mod.zon.weaSta.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaTDryBul_y(unit="K") = mod.zon.weaSta.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPFan_y(unit="W") = mod.fcu.reaPFan.y "Supply fan electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaNOpa_y(unit="1") = mod.zon.weaSta.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaHDirNor_y(unit="W/m2") = mod.zon.weaSta.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFloSup_y(unit="kg/s") = mod.fcu.reaFloSup.y "Supply air mass flow rate";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaHGloHor_y(unit="W/m2") = mod.zon.weaSta.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaHDifHor_y(unit="W/m2") = mod.zon.weaSta.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaSolDec_y(unit="rad") = mod.zon.weaSta.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaTBlaSky_y(unit="K") = mod.zon.weaSta.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaCeiHei_y(unit="m") = mod.zon.weaSta.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaLat_y(unit="rad") = mod.zon.weaSta.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaNTot_y(unit="1") = mod.zon.weaSta.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaSolTim_y(unit="s") = mod.zon.weaSta.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaWinSpe_y(unit="m/s") = mod.zon.weaSta.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaHHorIR_y(unit="W/m2") = mod.zon.weaSta.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_reaTRooAir_y(unit="K") = mod.zon.reaTRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaCloTim_y(unit="s") = mod.zon.weaSta.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaTWetBul_y(unit="K") = mod.zon.weaSta.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPHea_y(unit="W") = mod.fcu.reaPHea.y "Heating thermal power consumption";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPCoo_y(unit="W") = mod.fcu.reaPCoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput zon_reaPLig_y(unit="W") = mod.zon.reaPLig.y "Lighting power submeter";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaSolZen_y(unit="rad") = mod.zon.weaSta.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_reaCO2RooAir_y(unit="ppm") = mod.zon.reaCO2RooAir.y "Zone air CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaSolHouAng_y(unit="rad") = mod.zon.weaSta.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput zon_weaSta_reaWeaSolAlt_y(unit="rad") = mod.zon.weaSta.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput con_oveTSetCoo_y(unit="K") = mod.con.oveTSetCoo.y "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealOutput con_oveTSetHea_y(unit="K") = mod.con.oveTSetHea.y "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealOutput fcu_oveTSup_y(unit="K") = mod.fcu.oveTSup.y "Supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput fcu_oveFan_y(unit="1") = mod.fcu.oveFan.y "Fan control signal as air mass flow rate normalized to the design air mass flow rate";
	// Original model
	BESTESTAir.TestCases.TestCase_Ideal mod(
		con.oveTSetCoo(uExt(y=con_oveTSetCoo_u),activate(y=con_oveTSetCoo_activate)),
		con.oveTSetHea(uExt(y=con_oveTSetHea_u),activate(y=con_oveTSetHea_activate)),
		fcu.oveTSup(uExt(y=fcu_oveTSup_u),activate(y=fcu_oveTSup_activate)),
		fcu.oveFan(uExt(y=fcu_oveFan_u),activate(y=fcu_oveFan_activate))) "Original model with overwrites";
end wrapped;
