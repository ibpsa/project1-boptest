model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput thermostatNigZon_oveTsetZon_u(unit="K", min=273.15, max=318.15) "Setpoint temperature for thermal zone";
	Modelica.Blocks.Interfaces.BooleanInput thermostatNigZon_oveTsetZon_activate "Activation for Setpoint temperature for thermal zone";
	Modelica.Blocks.Interfaces.RealInput hydronicSystem_oveMNigZ_u(unit="1", min=0.0, max=1.0) "Signal Night zone valve";
	Modelica.Blocks.Interfaces.BooleanInput hydronicSystem_oveMNigZ_activate "Activation for Signal Night zone valve";
	Modelica.Blocks.Interfaces.RealInput thermostatDayZon_oveTsetZon_u(unit="K", min=273.15, max=318.15) "Setpoint temperature for thermal zone";
	Modelica.Blocks.Interfaces.BooleanInput thermostatDayZon_oveTsetZon_activate "Activation for Setpoint temperature for thermal zone";
	Modelica.Blocks.Interfaces.RealInput hydronicSystem_oveMDayZ_u(unit="1", min=0.0, max=1.0) "Signal Day zone valve";
	Modelica.Blocks.Interfaces.BooleanInput hydronicSystem_oveMDayZ_activate "Activation for Signal Day zone valve";
	Modelica.Blocks.Interfaces.RealInput hydronicSystem_oveTHea_u(unit="K", min=273.15, max=318.15) "Heat system supply temperature";
	Modelica.Blocks.Interfaces.BooleanInput hydronicSystem_oveTHea_activate "Activation for Heat system supply temperature";
	Modelica.Blocks.Interfaces.RealInput hydronicSystem_oveMpumCon_u(unit="kg/s", min=0.0, max=5.0) "Mass flow rate control input to circulation pump for water through floor heating system";
	Modelica.Blocks.Interfaces.BooleanInput hydronicSystem_oveMpumCon_activate "Activation for Mass flow rate control input to circulation pump for water through floor heating system";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaCloTim_y(unit="s") = mod.weatherStation.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaMFloHea_y(unit="kg/s") = mod.dayZon.reaMFloHea.y "Zone water mass flow rate floor heating";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolHouAng_y(unit="rad") = mod.weatherStation.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaPowFlooHea_y(unit="W") = mod.dayZon.reaPowFlooHea.y "Floor heating power";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_reaCOPhp_y(unit="1") = mod.hydronicSystem.reaCOPhp.y "air source heat pump COP";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaWinDir_y(unit="rad") = mod.weatherStation.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolDec_y(unit="rad") = mod.weatherStation.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTDryBul_y(unit="K") = mod.weatherStation.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaLon_y(unit="rad") = mod.weatherStation.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaMFloHea_y(unit="kg/s") = mod.nigZon.reaMFloHea.y "Zone water mass flow rate floor heating";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaTavgFloHea_y(unit="K") = mod.dayZon.reaTavgFloHea.y "Zone average floor temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTWetBul_y(unit="K") = mod.weatherStation.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaCO2RooAir_y(unit="ppm") = mod.dayZon.reaCO2RooAir.y "Zone air CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTBlaSky_y(unit="K") = mod.weatherStation.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaLat_y(unit="rad") = mod.weatherStation.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaPowQint_y(unit="W") = mod.nigZon.reaPowQint.y "Internal heat gains";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHDirNor_y(unit="W/m2") = mod.weatherStation.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaPowFlooHea_y(unit="W") = mod.nigZon.reaPowFlooHea.y "Floor heating power";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolTim_y(unit="s") = mod.weatherStation.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTDewPoi_y(unit="K") = mod.weatherStation.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaTRooAir_y(unit="K") = mod.nigZon.reaTRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaTsupFloHea_y(unit="K") = mod.dayZon.reaTsupFloHea.y "Zone supply water temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaTretFloHea_y(unit="K") = mod.nigZon.reaTretFloHea.y "Zone return water temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaTavgFloHea_y(unit="K") = mod.nigZon.reaTavgFloHea.y "Zone average floor temperature";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaTRooAir_y(unit="K") = mod.dayZon.reaTRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolZen_y(unit="rad") = mod.weatherStation.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaCO2RooAir_y(unit="ppm") = mod.nigZon.reaCO2RooAir.y "Zone air CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHGloHor_y(unit="W/m2") = mod.weatherStation.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaPPlu_y(unit="W") = mod.nigZon.reaPPlu.y "Plug load power submeter";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaNTot_y(unit="1") = mod.weatherStation.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaPowQint_y(unit="W") = mod.dayZon.reaPowQint.y "Internal heat gains";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_reaPPum_y(unit="W") = mod.hydronicSystem.reaPPum.y "Pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolAlt_y(unit="rad") = mod.weatherStation.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHDifHor_y(unit="W/m2") = mod.weatherStation.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaCeiHei_y(unit="m") = mod.weatherStation.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaPLig_y(unit="W") = mod.nigZon.reaPLig.y "Lighting power submeter";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_reaPeleHeaPum_y(unit="W") = mod.hydronicSystem.reaPeleHeaPum.y "Electric consumption of the heat pump";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaPPlu_y(unit="W") = mod.dayZon.reaPPlu.y "Plug load power submeter";
	Modelica.Blocks.Interfaces.RealOutput nigZon_reaTsupFloHea_y(unit="K") = mod.nigZon.reaTsupFloHea.y "Zone supply water temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaTretFloHea_y(unit="K") = mod.dayZon.reaTretFloHea.y "Zone return water temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaNOpa_y(unit="1") = mod.weatherStation.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaPAtm_y(unit="Pa") = mod.weatherStation.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_reaTretFloHea_y(unit="K") = mod.hydronicSystem.reaTretFloHea.y "Heat pump return water temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput dayZon_reaPLig_y(unit="W") = mod.dayZon.reaPLig.y "Lighting power submeter";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaWinSpe_y(unit="m/s") = mod.weatherStation.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaRelHum_y(unit="1") = mod.weatherStation.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHHorIR_y(unit="W/m2") = mod.weatherStation.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput thermostatNigZon_oveTsetZon_y(unit="K") = mod.thermostatNigZon.oveTsetZon.y "Setpoint temperature for thermal zone";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_oveMNigZ_y(unit="1") = mod.hydronicSystem.oveMNigZ.y "Signal Night zone valve";
	Modelica.Blocks.Interfaces.RealOutput thermostatDayZon_oveTsetZon_y(unit="K") = mod.thermostatDayZon.oveTsetZon.y "Setpoint temperature for thermal zone";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_oveMDayZ_y(unit="1") = mod.hydronicSystem.oveMDayZ.y "Signal Day zone valve";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_oveTHea_y(unit="K") = mod.hydronicSystem.oveTHea.y "Heat system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_oveMpumCon_y(unit="kg/s") = mod.hydronicSystem.oveMpumCon.y "Mass flow rate control input to circulation pump for water through floor heating system";
	// Original model
	TwoZoneApartmentHydronic.TestCases.ApartmentModelQHTyp mod(
		thermostatNigZon.oveTsetZon(uExt(y=thermostatNigZon_oveTsetZon_u),activate(y=thermostatNigZon_oveTsetZon_activate)),
		hydronicSystem.oveMNigZ(uExt(y=hydronicSystem_oveMNigZ_u),activate(y=hydronicSystem_oveMNigZ_activate)),
		thermostatDayZon.oveTsetZon(uExt(y=thermostatDayZon_oveTsetZon_u),activate(y=thermostatDayZon_oveTsetZon_activate)),
		hydronicSystem.oveMDayZ(uExt(y=hydronicSystem_oveMDayZ_u),activate(y=hydronicSystem_oveMDayZ_activate)),
		hydronicSystem.oveTHea(uExt(y=hydronicSystem_oveTHea_u),activate(y=hydronicSystem_oveTHea_activate)),
		hydronicSystem.oveMpumCon(uExt(y=hydronicSystem_oveMpumCon_u),activate(y=hydronicSystem_oveMpumCon_activate))) "Original model with overwrites";
end wrapped;
