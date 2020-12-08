model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput regul_SDB_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_SDB_oveTsetCoo_activate "Activation for Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre2_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre2_oveTsetCoo_activate "Activation for Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput conHeaRo1_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo1_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaRo3_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo3_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput conPumHea_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conPumHea_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Chaudiere_Securite_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chaudiere_Securite_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Chaudiere_Securite_oveTsetHea_u(unit="K", min=283.15, max=368.15) "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chaudiere_Securite_oveTsetHea_activate "Activation for Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Salon_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Salon_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput conPumHea_oveTsetHea_u(unit="K", min=283.15, max=368.15) "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conPumHea_oveTsetHea_activate "Activation for Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre1_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre1_oveTsetCoo_activate "Activation for Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre3_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre3_oveTsetCoo_activate "Activation for Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput conHeaSal_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaSal_oveTsetHea_activate "Activation for Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre2_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre2_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput regul_Salon_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Salon_oveTsetCoo_activate "Activation for Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput regul_Couloir_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Couloir_oveTsetCoo_activate "Activation for Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre3_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre3_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput regul_SDB_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_SDB_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput conHeaBoiler_oveTsetHea_u(unit="K", min=283.15, max=368.15) "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBoiler_oveTsetHea_activate "Activation for Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaBoiler_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBoiler_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Couloir_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Couloir_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre1_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre1_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput conHeaRo2_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo2_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput boi_oveBoi_u(unit="1", min=0.0, max=1.0) "Boiler control signal";
	Modelica.Blocks.Interfaces.BooleanInput boi_oveBoi_activate "Activation for Boiler control signal";
	Modelica.Blocks.Interfaces.RealInput conHeaSal_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaSal_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaBth_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBth_oveTsetHea_activate "Activation for Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaRo1_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo1_oveTsetHea_activate "Activation for Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaRo3_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo3_oveTsetHea_activate "Activation for Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaRo2_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo2_oveTsetHea_activate "Activation for Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaBth_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBth_oveActHea_activate "Activation for Actuator signal for heating";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput boi_reaHeaBoi_y(unit="W") = mod.boi.reaHeaBoi.y "Boiler thermal energy usage";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaWinDir_y(unit="rad") = mod.weatherStation.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo1_y(unit="W") = mod.reaHeaRo1.y "Read heating delivered to room 1";
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo2_y(unit="W") = mod.reaHeaRo2.y "Read heating delivered to room 2";
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo3_y(unit="W") = mod.reaHeaRo3.y "Read heating delivered to room 3";
	Modelica.Blocks.Interfaces.RealOutput reaHeaHal_y(unit="W") = mod.reaHeaHal.y "Read heating delivered to Hall";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaLon_y(unit="rad") = mod.weatherStation.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput conHeaSal_reaTzon_y(unit="K") = mod.conHeaSal.reaTzon.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaCloTim_y(unit="s") = mod.weatherStation.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput ventil_Salon_rearelHum_y(unit="1") = mod.ventil_Salon.rearelHum.y "Zone relative humidity";
	Modelica.Blocks.Interfaces.RealOutput reaTSetCoo_y(unit="K") = mod.reaTSetCoo.y "Zone air setpoint temperature";
	Modelica.Blocks.Interfaces.RealOutput reaHeaBth_y(unit="W") = mod.reaHeaBth.y "Read heating delivered to bathroom";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTBlaSky_y(unit="K") = mod.weatherStation.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaLat_y(unit="rad") = mod.weatherStation.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput reaTAti_y(unit="K") = mod.reaTAti.y "Read attic air temperature";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo3_reaTzon_y(unit="K") = mod.conHeaRo3.reaTzon.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo2_reaTzon_y(unit="K") = mod.conHeaRo2.reaTzon.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHDirNor_y(unit="W/m2") = mod.weatherStation.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolTim_y(unit="s") = mod.weatherStation.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTDewPoi_y(unit="K") = mod.weatherStation.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaNOpa_y(unit="1") = mod.weatherStation.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput q_conv_Nuit_reaConOcc_y(unit="W/m2") = mod.q_conv_Nuit.reaConOcc.y "Convective heat gains";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolHouAng_y(unit="rad") = mod.weatherStation.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput conHeaBth_reaTzon_y(unit="K") = mod.conHeaBth.reaTzon.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput reaTSetHea_y(unit="K") = mod.reaTSetHea.y "Zone air setpoint temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolZen_y(unit="rad") = mod.weatherStation.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo1_reaTzon_y(unit="K") = mod.conHeaRo1.reaTzon.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput regul_Couloir_reaPcoo_y(unit="W") = mod.regul_Couloir.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaTHal_y(unit="K") = mod.reaTHal.y "Read hall temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolDec_y(unit="rad") = mod.weatherStation.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput regul_SDB_reaPcoo_y(unit="W") = mod.regul_SDB.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput regul_Chambre1_reaPcoo_y(unit="W") = mod.regul_Chambre1.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput boi_reaPpum_y(unit="W") = mod.boi.reaPpum.y "Boiler pump electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHGloHor_y(unit="W/m2") = mod.weatherStation.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput reaHeaSal_y(unit="W") = mod.reaHeaSal.y "Read heating delivered to Salon";
	Modelica.Blocks.Interfaces.RealOutput reaTGar_y(unit="K") = mod.reaTGar.y "Read garage temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaNTot_y(unit="1") = mod.weatherStation.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTWetBul_y(unit="K") = mod.weatherStation.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput regul_Chambre3_reaPcoo_y(unit="W") = mod.regul_Chambre3.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput regul_Chambre2_reaPcoo_y(unit="W") = mod.regul_Chambre2.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHDifHor_y(unit="W/m2") = mod.weatherStation.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaCeiHei_y(unit="m") = mod.weatherStation.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTDryBul_y(unit="K") = mod.weatherStation.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaPAtm_y(unit="Pa") = mod.weatherStation.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput q_conv_Jour_reaConOcc_y(unit="W/m2") = mod.q_conv_Jour.reaConOcc.y "Convective heat gains";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolAlt_y(unit="rad") = mod.weatherStation.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput regul_Salon_reaPcoo_y(unit="W") = mod.regul_Salon.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaWinSpe_y(unit="m/s") = mod.weatherStation.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaRelHum_y(unit="1") = mod.weatherStation.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHHorIR_y(unit="W/m2") = mod.weatherStation.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	// Original model
	MultiZoneResidentialHydronic.TestCase mod(
		regul_SDB.oveTsetCoo(uExt(y=regul_SDB_oveTsetCoo_u),activate(y=regul_SDB_oveTsetCoo_activate)),
		regul_Chambre2.oveTsetCoo(uExt(y=regul_Chambre2_oveTsetCoo_u),activate(y=regul_Chambre2_oveTsetCoo_activate)),
		conHeaRo1.oveActHea(uExt(y=conHeaRo1_oveActHea_u),activate(y=conHeaRo1_oveActHea_activate)),
		conHeaRo3.oveActHea(uExt(y=conHeaRo3_oveActHea_u),activate(y=conHeaRo3_oveActHea_activate)),
		conPumHea.oveActHea(uExt(y=conPumHea_oveActHea_u),activate(y=conPumHea_oveActHea_activate)),
		regul_Chaudiere_Securite.oveActHea(uExt(y=regul_Chaudiere_Securite_oveActHea_u),activate(y=regul_Chaudiere_Securite_oveActHea_activate)),
		regul_Chaudiere_Securite.oveTsetHea(uExt(y=regul_Chaudiere_Securite_oveTsetHea_u),activate(y=regul_Chaudiere_Securite_oveTsetHea_activate)),
		regul_Salon.ovePCoo(uExt(y=regul_Salon_ovePCoo_u),activate(y=regul_Salon_ovePCoo_activate)),
		conPumHea.oveTsetHea(uExt(y=conPumHea_oveTsetHea_u),activate(y=conPumHea_oveTsetHea_activate)),
		regul_Chambre1.oveTsetCoo(uExt(y=regul_Chambre1_oveTsetCoo_u),activate(y=regul_Chambre1_oveTsetCoo_activate)),
		regul_Chambre3.oveTsetCoo(uExt(y=regul_Chambre3_oveTsetCoo_u),activate(y=regul_Chambre3_oveTsetCoo_activate)),
		conHeaSal.oveTsetHea(uExt(y=conHeaSal_oveTsetHea_u),activate(y=conHeaSal_oveTsetHea_activate)),
		regul_Chambre2.ovePCoo(uExt(y=regul_Chambre2_ovePCoo_u),activate(y=regul_Chambre2_ovePCoo_activate)),
		regul_Salon.oveTsetCoo(uExt(y=regul_Salon_oveTsetCoo_u),activate(y=regul_Salon_oveTsetCoo_activate)),
		regul_Couloir.oveTsetCoo(uExt(y=regul_Couloir_oveTsetCoo_u),activate(y=regul_Couloir_oveTsetCoo_activate)),
		regul_Chambre3.ovePCoo(uExt(y=regul_Chambre3_ovePCoo_u),activate(y=regul_Chambre3_ovePCoo_activate)),
		regul_SDB.ovePCoo(uExt(y=regul_SDB_ovePCoo_u),activate(y=regul_SDB_ovePCoo_activate)),
		conHeaBoiler.oveTsetHea(uExt(y=conHeaBoiler_oveTsetHea_u),activate(y=conHeaBoiler_oveTsetHea_activate)),
		conHeaBoiler.oveActHea(uExt(y=conHeaBoiler_oveActHea_u),activate(y=conHeaBoiler_oveActHea_activate)),
		regul_Couloir.ovePCoo(uExt(y=regul_Couloir_ovePCoo_u),activate(y=regul_Couloir_ovePCoo_activate)),
		regul_Chambre1.ovePCoo(uExt(y=regul_Chambre1_ovePCoo_u),activate(y=regul_Chambre1_ovePCoo_activate)),
		conHeaRo2.oveActHea(uExt(y=conHeaRo2_oveActHea_u),activate(y=conHeaRo2_oveActHea_activate)),
		boi.oveBoi(uExt(y=boi_oveBoi_u),activate(y=boi_oveBoi_activate)),
		conHeaSal.oveActHea(uExt(y=conHeaSal_oveActHea_u),activate(y=conHeaSal_oveActHea_activate)),
		conHeaBth.oveTsetHea(uExt(y=conHeaBth_oveTsetHea_u),activate(y=conHeaBth_oveTsetHea_activate)),
		conHeaRo1.oveTsetHea(uExt(y=conHeaRo1_oveTsetHea_u),activate(y=conHeaRo1_oveTsetHea_activate)),
		conHeaRo3.oveTsetHea(uExt(y=conHeaRo3_oveTsetHea_u),activate(y=conHeaRo3_oveTsetHea_activate)),
		conHeaRo2.oveTsetHea(uExt(y=conHeaRo2_oveTsetHea_u),activate(y=conHeaRo2_oveTsetHea_activate)),
		conHeaBth.oveActHea(uExt(y=conHeaBth_oveActHea_u),activate(y=conHeaBth_oveActHea_activate))) "Original model with overwrites";
end wrapped;