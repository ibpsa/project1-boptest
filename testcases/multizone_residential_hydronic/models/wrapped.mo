model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput conHeaRo2_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating valve for zone Ro2";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo2_oveActHea_activate "Activation for Actuator signal for heating valve for zone Ro2";
	Modelica.Blocks.Interfaces.RealInput conHeaLiv_oveTSetHea_u(unit="K", min=283.15, max=368.15) "Air temperature heating setpoint for zone Liv";
	Modelica.Blocks.Interfaces.BooleanInput conHeaLiv_oveTSetHea_activate "Activation for Air temperature heating setpoint for zone Liv";
	Modelica.Blocks.Interfaces.RealInput conHeaRo3_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating valve for zone Ro3";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo3_oveActHea_activate "Activation for Actuator signal for heating valve for zone Ro3";
	Modelica.Blocks.Interfaces.RealInput conCooLiv_oveCoo_u(unit="1", min=0.0, max=1.0) "Cooling control signal as fraction of maximum for zone Liv";
	Modelica.Blocks.Interfaces.BooleanInput conCooLiv_oveCoo_activate "Activation for Cooling control signal as fraction of maximum for zone Liv";
	Modelica.Blocks.Interfaces.RealInput oveTSetPum_u(unit="K", min=283.15, max=368.15) "Heating zone air temperature setpoint used to control circulation pump of the emission system";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetPum_activate "Activation for Heating zone air temperature setpoint used to control circulation pump of the emission system";
	Modelica.Blocks.Interfaces.RealInput conHeaRo1_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating valve for zone Ro1";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo1_oveActHea_activate "Activation for Actuator signal for heating valve for zone Ro1";
	Modelica.Blocks.Interfaces.RealInput conHeaLiv_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating valve for zone Liv";
	Modelica.Blocks.Interfaces.BooleanInput conHeaLiv_oveActHea_activate "Activation for Actuator signal for heating valve for zone Liv";
	Modelica.Blocks.Interfaces.RealInput conHeaRo2_oveTSetHea_u(unit="K", min=283.15, max=368.15) "Air temperature heating setpoint for zone Ro2";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo2_oveTSetHea_activate "Activation for Air temperature heating setpoint for zone Ro2";
	Modelica.Blocks.Interfaces.RealInput oveEmiPum_u(unit="1", min=0.0, max=1.0) "Control signal to the circulation pump of the emission system";
	Modelica.Blocks.Interfaces.BooleanInput oveEmiPum_activate "Activation for Control signal to the circulation pump of the emission system";
	Modelica.Blocks.Interfaces.RealInput conCooRo1_oveTSetCoo_u(unit="K", min=283.15, max=303.15) "Air temperature cooling setpoint for zone Ro1";
	Modelica.Blocks.Interfaces.BooleanInput conCooRo1_oveTSetCoo_activate "Activation for Air temperature cooling setpoint for zone Ro1";
	Modelica.Blocks.Interfaces.RealInput conCooHal_oveTSetCoo_u(unit="K", min=283.15, max=303.15) "Air temperature cooling setpoint for zone Hal";
	Modelica.Blocks.Interfaces.BooleanInput conCooHal_oveTSetCoo_activate "Activation for Air temperature cooling setpoint for zone Hal";
	Modelica.Blocks.Interfaces.RealInput conCooLiv_oveTSetCoo_u(unit="K", min=283.15, max=303.15) "Air temperature cooling setpoint for zone Liv";
	Modelica.Blocks.Interfaces.BooleanInput conCooLiv_oveTSetCoo_activate "Activation for Air temperature cooling setpoint for zone Liv";
	Modelica.Blocks.Interfaces.RealInput conCooBth_oveCoo_u(unit="1", min=0.0, max=1.0) "Cooling control signal as fraction of maximum for zone Bth";
	Modelica.Blocks.Interfaces.BooleanInput conCooBth_oveCoo_activate "Activation for Cooling control signal as fraction of maximum for zone Bth";
	Modelica.Blocks.Interfaces.RealInput oveMixValSup_u(unit="1", min=0.0, max=1.0) "Actuator signal for three-way mixing valve controlling supply water temperature to radiators";
	Modelica.Blocks.Interfaces.BooleanInput oveMixValSup_activate "Activation for Actuator signal for three-way mixing valve controlling supply water temperature to radiators";
	Modelica.Blocks.Interfaces.RealInput conCooRo3_oveTSetCoo_u(unit="K", min=283.15, max=303.15) "Air temperature cooling setpoint for zone Ro3";
	Modelica.Blocks.Interfaces.BooleanInput conCooRo3_oveTSetCoo_activate "Activation for Air temperature cooling setpoint for zone Ro3";
	Modelica.Blocks.Interfaces.RealInput conCooRo1_oveCoo_u(unit="1", min=0.0, max=1.0) "Cooling control signal as fraction of maximum for zone Ro1";
	Modelica.Blocks.Interfaces.BooleanInput conCooRo1_oveCoo_activate "Activation for Cooling control signal as fraction of maximum for zone Ro1";
	Modelica.Blocks.Interfaces.RealInput conHeaBth_oveTSetHea_u(unit="K", min=283.15, max=368.15) "Air temperature heating setpoint for zone Bth";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBth_oveTSetHea_activate "Activation for Air temperature heating setpoint for zone Bth";
	Modelica.Blocks.Interfaces.RealInput conCooBth_oveTSetCoo_u(unit="K", min=283.15, max=303.15) "Air temperature cooling setpoint for zone Bth";
	Modelica.Blocks.Interfaces.BooleanInput conCooBth_oveTSetCoo_activate "Activation for Air temperature cooling setpoint for zone Bth";
	Modelica.Blocks.Interfaces.RealInput conCooRo2_oveTSetCoo_u(unit="K", min=283.15, max=303.15) "Air temperature cooling setpoint for zone Ro2";
	Modelica.Blocks.Interfaces.BooleanInput conCooRo2_oveTSetCoo_activate "Activation for Air temperature cooling setpoint for zone Ro2";
	Modelica.Blocks.Interfaces.RealInput oveTSetSup_u(unit="K", min=283.15, max=368.15) "Supply water temperature setpoint to radiators";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetSup_activate "Activation for Supply water temperature setpoint to radiators";
	Modelica.Blocks.Interfaces.RealInput conHeaRo3_oveTSetHea_u(unit="K", min=283.15, max=368.15) "Air temperature heating setpoint for zone Ro3";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo3_oveTSetHea_activate "Activation for Air temperature heating setpoint for zone Ro3";
	Modelica.Blocks.Interfaces.RealInput conCooRo3_oveCoo_u(unit="1", min=0.0, max=1.0) "Cooling control signal as fraction of maximum for zone Ro3";
	Modelica.Blocks.Interfaces.BooleanInput conCooRo3_oveCoo_activate "Activation for Cooling control signal as fraction of maximum for zone Ro3";
	Modelica.Blocks.Interfaces.RealInput conCooHal_oveCoo_u(unit="1", min=0.0, max=1.0) "Cooling control signal as fraction of maximum for zone Hal";
	Modelica.Blocks.Interfaces.BooleanInput conCooHal_oveCoo_activate "Activation for Cooling control signal as fraction of maximum for zone Hal";
	Modelica.Blocks.Interfaces.RealInput conCooRo2_oveCoo_u(unit="1", min=0.0, max=1.0) "Cooling control signal as fraction of maximum for zone Ro2";
	Modelica.Blocks.Interfaces.BooleanInput conCooRo2_oveCoo_activate "Activation for Cooling control signal as fraction of maximum for zone Ro2";
	Modelica.Blocks.Interfaces.RealInput boi_oveBoi_u(unit="1", min=0.0, max=1.0) "Boiler control signal for part load ratio";
	Modelica.Blocks.Interfaces.BooleanInput boi_oveBoi_activate "Activation for Boiler control signal for part load ratio";
	Modelica.Blocks.Interfaces.RealInput conHeaRo1_oveTSetHea_u(unit="K", min=283.15, max=368.15) "Air temperature heating setpoint for zone Ro1";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo1_oveTSetHea_activate "Activation for Air temperature heating setpoint for zone Ro1";
	Modelica.Blocks.Interfaces.RealInput conHeaBth_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating valve for zone Bth";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBth_oveActHea_activate "Activation for Actuator signal for heating valve for zone Bth";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput boi_reaGasBoi_y(unit="W") = mod.boi.reaGasBoi.y "Boiler gas power use";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTWetBul_y(unit="K") = mod.weatherStation.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput conCooHal_reaPCoo_y(unit="W") = mod.conCooHal.reaPCoo.y "Cooling electrical power use in zone Hal";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaWinDir_y(unit="rad") = mod.weatherStation.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput extBth_reaCO2RooAir_y(unit="ppm") = mod.extBth.reaCO2RooAir.y "Air CO2 concentration of zone Bth";
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo2_y(unit="W") = mod.reaHeaRo2.y "Heating delivered to Ro2";
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo3_y(unit="W") = mod.reaHeaRo3.y "Heating delivered to Ro3";
	Modelica.Blocks.Interfaces.RealOutput conCooRo2_reaPCoo_y(unit="W") = mod.conCooRo2.reaPCoo.y "Cooling electrical power use in zone Ro2";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo2_reaTZon_y(unit="K") = mod.conHeaRo2.reaTZon.y "Air temperature of zone Ro2";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaLon_y(unit="rad") = mod.weatherStation.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaCloTim_y(unit="s") = mod.weatherStation.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput conHeaLiv_reaTZon_y(unit="K") = mod.conHeaLiv.reaTZon.y "Air temperature of zone Liv";
	Modelica.Blocks.Interfaces.RealOutput infAti_reaCO2RooAir_y(unit="ppm") = mod.infAti.reaCO2RooAir.y "Air CO2 concentration of zone Ati";
	Modelica.Blocks.Interfaces.RealOutput infHal_reaCO2RooAir_y(unit="ppm") = mod.infHal.reaCO2RooAir.y "Air CO2 concentration of zone Hal";
	Modelica.Blocks.Interfaces.RealOutput conCooBth_reaPCoo_y(unit="W") = mod.conCooBth.reaPCoo.y "Cooling electrical power use in zone Bth";
	Modelica.Blocks.Interfaces.RealOutput reaHeaBth_y(unit="W") = mod.reaHeaBth.y "Heating delivered to Bth";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTBlaSky_y(unit="K") = mod.weatherStation.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaLat_y(unit="rad") = mod.weatherStation.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput reaTAti_y(unit="K") = mod.reaTAti.y "Air temperature of zone Ati";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo1_reaTZon_y(unit="K") = mod.conHeaRo1.reaTZon.y "Air temperature of zone Ro1";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHDirNor_y(unit="W/m2") = mod.weatherStation.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTSup_y(unit="K") = mod.reaTSup.y "Supply water temperature measurement to radiators";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolTim_y(unit="s") = mod.weatherStation.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTDewPoi_y(unit="K") = mod.weatherStation.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaNOpa_y(unit="1") = mod.weatherStation.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolHouAng_y(unit="rad") = mod.weatherStation.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput infGar_reaCO2RooAir_y(unit="ppm") = mod.infGar.reaCO2RooAir.y "Air CO2 concentration of zone Gar";
	Modelica.Blocks.Interfaces.RealOutput conCooLiv_reaPCoo_y(unit="W") = mod.conCooLiv.reaPCoo.y "Cooling electrical power use in zone Liv";
	Modelica.Blocks.Interfaces.RealOutput reaTSetCoo_y(unit="K") = mod.reaTSetCoo.y "Building cooling air setpoint temperature";
	Modelica.Blocks.Interfaces.RealOutput conCooRo1_reaPCoo_y(unit="W") = mod.conCooRo1.reaPCoo.y "Cooling electrical power use in zone Ro1";
	Modelica.Blocks.Interfaces.RealOutput reaHeaLiv_y(unit="W") = mod.reaHeaLiv.y "Heating delivered to Liv";
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo1_y(unit="W") = mod.reaHeaRo1.y "Heating delivered to Ro1";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo3_reaTZon_y(unit="K") = mod.conHeaRo3.reaTZon.y "Air temperature of zone Ro3";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolZen_y(unit="rad") = mod.weatherStation.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput extLiv_reaCO2RooAir_y(unit="ppm") = mod.extLiv.reaCO2RooAir.y "Air CO2 concentration of zone Liv";
	Modelica.Blocks.Interfaces.RealOutput reaTHal_y(unit="K") = mod.reaTHal.y "Air temperature of zone Hal";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolDec_y(unit="rad") = mod.weatherStation.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput infRo2_reaCO2RooAir_y(unit="ppm") = mod.infRo2.reaCO2RooAir.y "Air CO2 concentration of zone Ro2";
	Modelica.Blocks.Interfaces.RealOutput boi_reaPpum_y(unit="W") = mod.boi.reaPpum.y "Boiler pump electrical power use";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHGloHor_y(unit="W/m2") = mod.weatherStation.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTGar_y(unit="K") = mod.reaTGar.y "Air temperature of zone Gar";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaNTot_y(unit="1") = mod.weatherStation.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput infRo3_reaCO2RooAir_y(unit="ppm") = mod.infRo3.reaCO2RooAir.y "Air CO2 concentration of zone Ro3";
	Modelica.Blocks.Interfaces.RealOutput reaHeaHal_y(unit="W") = mod.reaHeaHal.y "Heating delivered to Hal";
	Modelica.Blocks.Interfaces.RealOutput infRo1_reaCO2RooAir_y(unit="ppm") = mod.infRo1.reaCO2RooAir.y "Air CO2 concentration of zone Ro1";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolAlt_y(unit="rad") = mod.weatherStation.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHDifHor_y(unit="W/m2") = mod.weatherStation.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput conCooRo3_reaPCoo_y(unit="W") = mod.conCooRo3.reaPCoo.y "Cooling electrical power use in zone Ro3";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaCeiHei_y(unit="m") = mod.weatherStation.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput conHeaBth_reaTZon_y(unit="K") = mod.conHeaBth.reaTZon.y "Air temperature of zone Bth";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTDryBul_y(unit="K") = mod.weatherStation.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaTSetHea_y(unit="K") = mod.reaTSetHea.y "Building heating air setpoint temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaPAtm_y(unit="Pa") = mod.weatherStation.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaWinSpe_y(unit="m/s") = mod.weatherStation.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaRelHum_y(unit="1") = mod.weatherStation.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHHorIR_y(unit="W/m2") = mod.weatherStation.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo2_oveActHea_y(unit="1") = mod.conHeaRo2.oveActHea.y "Actuator signal for heating valve for zone Ro2";
	Modelica.Blocks.Interfaces.RealOutput conHeaLiv_oveTSetHea_y(unit="K") = mod.conHeaLiv.oveTSetHea.y "Air temperature heating setpoint for zone Liv";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo3_oveActHea_y(unit="1") = mod.conHeaRo3.oveActHea.y "Actuator signal for heating valve for zone Ro3";
	Modelica.Blocks.Interfaces.RealOutput conCooLiv_oveCoo_y(unit="1") = mod.conCooLiv.oveCoo.y "Cooling control signal as fraction of maximum for zone Liv";
	Modelica.Blocks.Interfaces.RealOutput oveTSetPum_y(unit="K") = mod.oveTSetPum.y "Heating zone air temperature setpoint used to control circulation pump of the emission system";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo1_oveActHea_y(unit="1") = mod.conHeaRo1.oveActHea.y "Actuator signal for heating valve for zone Ro1";
	Modelica.Blocks.Interfaces.RealOutput conHeaLiv_oveActHea_y(unit="1") = mod.conHeaLiv.oveActHea.y "Actuator signal for heating valve for zone Liv";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo2_oveTSetHea_y(unit="K") = mod.conHeaRo2.oveTSetHea.y "Air temperature heating setpoint for zone Ro2";
	Modelica.Blocks.Interfaces.RealOutput oveEmiPum_y(unit="1") = mod.oveEmiPum.y "Control signal to the circulation pump of the emission system";
	Modelica.Blocks.Interfaces.RealOutput conCooRo1_oveTSetCoo_y(unit="K") = mod.conCooRo1.oveTSetCoo.y "Air temperature cooling setpoint for zone Ro1";
	Modelica.Blocks.Interfaces.RealOutput conCooHal_oveTSetCoo_y(unit="K") = mod.conCooHal.oveTSetCoo.y "Air temperature cooling setpoint for zone Hal";
	Modelica.Blocks.Interfaces.RealOutput conCooLiv_oveTSetCoo_y(unit="K") = mod.conCooLiv.oveTSetCoo.y "Air temperature cooling setpoint for zone Liv";
	Modelica.Blocks.Interfaces.RealOutput conCooBth_oveCoo_y(unit="1") = mod.conCooBth.oveCoo.y "Cooling control signal as fraction of maximum for zone Bth";
	Modelica.Blocks.Interfaces.RealOutput oveMixValSup_y(unit="1") = mod.oveMixValSup.y "Actuator signal for three-way mixing valve controlling supply water temperature to radiators";
	Modelica.Blocks.Interfaces.RealOutput conCooRo3_oveTSetCoo_y(unit="K") = mod.conCooRo3.oveTSetCoo.y "Air temperature cooling setpoint for zone Ro3";
	Modelica.Blocks.Interfaces.RealOutput conCooRo1_oveCoo_y(unit="1") = mod.conCooRo1.oveCoo.y "Cooling control signal as fraction of maximum for zone Ro1";
	Modelica.Blocks.Interfaces.RealOutput conHeaBth_oveTSetHea_y(unit="K") = mod.conHeaBth.oveTSetHea.y "Air temperature heating setpoint for zone Bth";
	Modelica.Blocks.Interfaces.RealOutput conCooBth_oveTSetCoo_y(unit="K") = mod.conCooBth.oveTSetCoo.y "Air temperature cooling setpoint for zone Bth";
	Modelica.Blocks.Interfaces.RealOutput conCooRo2_oveTSetCoo_y(unit="K") = mod.conCooRo2.oveTSetCoo.y "Air temperature cooling setpoint for zone Ro2";
	Modelica.Blocks.Interfaces.RealOutput oveTSetSup_y(unit="K") = mod.oveTSetSup.y "Supply water temperature setpoint to radiators";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo3_oveTSetHea_y(unit="K") = mod.conHeaRo3.oveTSetHea.y "Air temperature heating setpoint for zone Ro3";
	Modelica.Blocks.Interfaces.RealOutput conCooRo3_oveCoo_y(unit="1") = mod.conCooRo3.oveCoo.y "Cooling control signal as fraction of maximum for zone Ro3";
	Modelica.Blocks.Interfaces.RealOutput conCooHal_oveCoo_y(unit="1") = mod.conCooHal.oveCoo.y "Cooling control signal as fraction of maximum for zone Hal";
	Modelica.Blocks.Interfaces.RealOutput conCooRo2_oveCoo_y(unit="1") = mod.conCooRo2.oveCoo.y "Cooling control signal as fraction of maximum for zone Ro2";
	Modelica.Blocks.Interfaces.RealOutput boi_oveBoi_y(unit="1") = mod.boi.oveBoi.y "Boiler control signal for part load ratio";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo1_oveTSetHea_y(unit="K") = mod.conHeaRo1.oveTSetHea.y "Air temperature heating setpoint for zone Ro1";
	Modelica.Blocks.Interfaces.RealOutput conHeaBth_oveActHea_y(unit="1") = mod.conHeaBth.oveActHea.y "Actuator signal for heating valve for zone Bth";
	// Original model
	MultiZoneResidentialHydronic.TestCase mod(
		conHeaRo2.oveActHea(uExt(y=conHeaRo2_oveActHea_u),activate(y=conHeaRo2_oveActHea_activate)),
		conHeaLiv.oveTSetHea(uExt(y=conHeaLiv_oveTSetHea_u),activate(y=conHeaLiv_oveTSetHea_activate)),
		conHeaRo3.oveActHea(uExt(y=conHeaRo3_oveActHea_u),activate(y=conHeaRo3_oveActHea_activate)),
		conCooLiv.oveCoo(uExt(y=conCooLiv_oveCoo_u),activate(y=conCooLiv_oveCoo_activate)),
		oveTSetPum(uExt(y=oveTSetPum_u),activate(y=oveTSetPum_activate)),
		conHeaRo1.oveActHea(uExt(y=conHeaRo1_oveActHea_u),activate(y=conHeaRo1_oveActHea_activate)),
		conHeaLiv.oveActHea(uExt(y=conHeaLiv_oveActHea_u),activate(y=conHeaLiv_oveActHea_activate)),
		conHeaRo2.oveTSetHea(uExt(y=conHeaRo2_oveTSetHea_u),activate(y=conHeaRo2_oveTSetHea_activate)),
		oveEmiPum(uExt(y=oveEmiPum_u),activate(y=oveEmiPum_activate)),
		conCooRo1.oveTSetCoo(uExt(y=conCooRo1_oveTSetCoo_u),activate(y=conCooRo1_oveTSetCoo_activate)),
		conCooHal.oveTSetCoo(uExt(y=conCooHal_oveTSetCoo_u),activate(y=conCooHal_oveTSetCoo_activate)),
		conCooLiv.oveTSetCoo(uExt(y=conCooLiv_oveTSetCoo_u),activate(y=conCooLiv_oveTSetCoo_activate)),
		conCooBth.oveCoo(uExt(y=conCooBth_oveCoo_u),activate(y=conCooBth_oveCoo_activate)),
		oveMixValSup(uExt(y=oveMixValSup_u),activate(y=oveMixValSup_activate)),
		conCooRo3.oveTSetCoo(uExt(y=conCooRo3_oveTSetCoo_u),activate(y=conCooRo3_oveTSetCoo_activate)),
		conCooRo1.oveCoo(uExt(y=conCooRo1_oveCoo_u),activate(y=conCooRo1_oveCoo_activate)),
		conHeaBth.oveTSetHea(uExt(y=conHeaBth_oveTSetHea_u),activate(y=conHeaBth_oveTSetHea_activate)),
		conCooBth.oveTSetCoo(uExt(y=conCooBth_oveTSetCoo_u),activate(y=conCooBth_oveTSetCoo_activate)),
		conCooRo2.oveTSetCoo(uExt(y=conCooRo2_oveTSetCoo_u),activate(y=conCooRo2_oveTSetCoo_activate)),
		oveTSetSup(uExt(y=oveTSetSup_u),activate(y=oveTSetSup_activate)),
		conHeaRo3.oveTSetHea(uExt(y=conHeaRo3_oveTSetHea_u),activate(y=conHeaRo3_oveTSetHea_activate)),
		conCooRo3.oveCoo(uExt(y=conCooRo3_oveCoo_u),activate(y=conCooRo3_oveCoo_activate)),
		conCooHal.oveCoo(uExt(y=conCooHal_oveCoo_u),activate(y=conCooHal_oveCoo_activate)),
		conCooRo2.oveCoo(uExt(y=conCooRo2_oveCoo_u),activate(y=conCooRo2_oveCoo_activate)),
		boi.oveBoi(uExt(y=boi_oveBoi_u),activate(y=boi_oveBoi_activate)),
		conHeaRo1.oveTSetHea(uExt(y=conHeaRo1_oveTSetHea_u),activate(y=conHeaRo1_oveTSetHea_activate)),
		conHeaBth.oveActHea(uExt(y=conHeaBth_oveActHea_u),activate(y=conHeaBth_oveActHea_activate))) "Original model with overwrites";
end wrapped;
