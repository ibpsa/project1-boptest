model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput ovePum_u(unit="1", min=0.0, max=1.0) "Integer signal to control the stage of the pump either on or off";
	Modelica.Blocks.Interfaces.BooleanInput ovePum_activate "Activation for Integer signal to control the stage of the pump either on or off";
	Modelica.Blocks.Interfaces.RealInput oveTSetHea_u(unit="K", min=288.15, max=296.15) "Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetHea_activate "Activation for Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput oveTSetSup_u(unit="K", min=293.15, max=353.15) "Supply temperature setpoint of the heater";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetSup_activate "Activation for Supply temperature setpoint of the heater";
	Modelica.Blocks.Interfaces.RealInput oveTSetCoo_u(unit="K", min=296.15, max=303.15) "Zone operative temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetCoo_activate "Activation for Zone operative temperature setpoint for cooling";
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
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDryBul_y(unit="K") = mod.weaSta.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolAlt_y(unit="rad") = mod.weaSta.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHHorIR_y(unit="W/m2") = mod.weaSta.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolZen_y(unit="rad") = mod.weaSta.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDifHor_y(unit="W/m2") = mod.weaSta.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDewPoi_y(unit="K") = mod.weaSta.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaPAtm_y(unit="Pa") = mod.weaSta.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDirNor_y(unit="W/m2") = mod.weaSta.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolDec_y(unit="rad") = mod.weaSta.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput reaQHea_y(unit="W") = mod.reaQHea.y "Heating thermal power";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolTim_y(unit="s") = mod.weaSta.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLon_y(unit="rad") = mod.weaSta.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTBlaSky_y(unit="K") = mod.weaSta.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLat_y(unit="rad") = mod.weaSta.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput reaCO2RooAir_y(unit="ppm") = mod.reaCO2RooAir.y "CO2 concentration in the zone";
	Modelica.Blocks.Interfaces.RealOutput reaPPum_y(unit="W") = mod.reaPPum.y "Pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTWetBul_y(unit="K") = mod.weaSta.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTRoo_y(unit="K") = mod.reaTRoo.y "Operative zone temperature";
	Modelica.Blocks.Interfaces.RealOutput ovePum_y(unit="1") = mod.ovePum.y "Integer signal to control the stage of the pump either on or off";
	Modelica.Blocks.Interfaces.RealOutput oveTSetHea_y(unit="K") = mod.oveTSetHea.y "Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealOutput oveTSetSup_y(unit="K") = mod.oveTSetSup.y "Supply temperature setpoint of the heater";
	Modelica.Blocks.Interfaces.RealOutput oveTSetCoo_y(unit="K") = mod.oveTSetCoo.y "Zone operative temperature setpoint for cooling";
	// Original model
	BESTESTHydronic.TestCase mod(
		ovePum(uExt(y=ovePum_u),activate(y=ovePum_activate)),
		oveTSetHea(uExt(y=oveTSetHea_u),activate(y=oveTSetHea_activate)),
		oveTSetSup(uExt(y=oveTSetSup_u),activate(y=oveTSetSup_activate)),
		oveTSetCoo(uExt(y=oveTSetCoo_u),activate(y=oveTSetCoo_activate))) "Original model with overwrites";
end wrapped;
