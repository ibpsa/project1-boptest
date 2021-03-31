model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveWes_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone West";
	Modelica.Blocks.Interfaces.BooleanInput oveWes_yDam_activate "Activation for Damper position setpoint for zone West";
	Modelica.Blocks.Interfaces.RealInput oveWes_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone West";
	Modelica.Blocks.Interfaces.BooleanInput oveWes_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone West";
	Modelica.Blocks.Interfaces.RealInput oveNor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone North";
	Modelica.Blocks.Interfaces.BooleanInput oveNor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone North";
	Modelica.Blocks.Interfaces.RealInput oveEas_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone East";
	Modelica.Blocks.Interfaces.BooleanInput oveEas_yDam_activate "Activation for Damper position setpoint for zone East";
	Modelica.Blocks.Interfaces.RealInput oveAhu_TSupSet_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput oveAhu_TSupSet_activate "Activation for Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput oveSou_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone South";
	Modelica.Blocks.Interfaces.BooleanInput oveSou_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone South";
	Modelica.Blocks.Interfaces.RealInput oveNor_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone North";
	Modelica.Blocks.Interfaces.BooleanInput oveNor_yReaHea_activate "Activation for Reheat control signal for zone North";
	Modelica.Blocks.Interfaces.RealInput oveAhu_yRet_u(unit="1", min=0.0, max=1.0) "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput oveAhu_yRet_activate "Activation for Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput oveWes_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone West";
	Modelica.Blocks.Interfaces.BooleanInput oveWes_yReaHea_activate "Activation for Reheat control signal for zone West";
	Modelica.Blocks.Interfaces.RealInput oveWes_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone West";
	Modelica.Blocks.Interfaces.BooleanInput oveWes_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone West";
	Modelica.Blocks.Interfaces.RealInput oveCor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone Core";
	Modelica.Blocks.Interfaces.BooleanInput oveCor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone Core";
	Modelica.Blocks.Interfaces.RealInput oveCor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone Core";
	Modelica.Blocks.Interfaces.BooleanInput oveCor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone Core";
	Modelica.Blocks.Interfaces.RealInput oveSou_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone South";
	Modelica.Blocks.Interfaces.BooleanInput oveSou_yReaHea_activate "Activation for Reheat control signal for zone South";
	Modelica.Blocks.Interfaces.RealInput oveSou_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone South";
	Modelica.Blocks.Interfaces.BooleanInput oveSou_yDam_activate "Activation for Damper position setpoint for zone South";
	Modelica.Blocks.Interfaces.RealInput oveAhu_yHea_u(unit="1", min=0.0, max=1.0) "Heating coil control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput oveAhu_yHea_activate "Activation for Heating coil control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput oveCor_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone Core";
	Modelica.Blocks.Interfaces.BooleanInput oveCor_yReaHea_activate "Activation for Reheat control signal for zone Core";
	Modelica.Blocks.Interfaces.RealInput oveEas_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone East";
	Modelica.Blocks.Interfaces.BooleanInput oveEas_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone East";
	Modelica.Blocks.Interfaces.RealInput oveAhu_yCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput oveAhu_yCoo_activate "Activation for Cooling coil control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput oveNor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone North";
	Modelica.Blocks.Interfaces.BooleanInput oveNor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone North";
	Modelica.Blocks.Interfaces.RealInput oveEas_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone East";
	Modelica.Blocks.Interfaces.BooleanInput oveEas_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone East";
	Modelica.Blocks.Interfaces.RealInput oveCor_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone Core";
	Modelica.Blocks.Interfaces.BooleanInput oveCor_yDam_activate "Activation for Damper position setpoint for zone Core";
	Modelica.Blocks.Interfaces.RealInput oveSou_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone South";
	Modelica.Blocks.Interfaces.BooleanInput oveSou_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone South";
	Modelica.Blocks.Interfaces.RealInput oveAhu_yFan_u(unit="1", min=0.0, max=1.0) "Supply fan speed setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput oveAhu_yFan_activate "Activation for Supply fan speed setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput oveAhu_yOA_u(unit="1", min=0.0, max=1.0) "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput oveAhu_yOA_activate "Activation for Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput oveAhu_dpSet_u(unit="Pa", min=50.0, max=410.0) "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput oveAhu_dpSet_activate "Activation for Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput oveEas_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone East";
	Modelica.Blocks.Interfaces.BooleanInput oveEas_yReaHea_activate "Activation for Reheat control signal for zone East";
	Modelica.Blocks.Interfaces.RealInput oveNor_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone North";
	Modelica.Blocks.Interfaces.BooleanInput oveNor_yDam_activate "Activation for Damper position setpoint for zone North";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolHouAng_y(unit="rad") = mod.weaSta.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinDir_y(unit="rad") = mod.weaSta.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput reaNor_V_flow_y(unit="m3/s") = mod.reaNor.V_flow.y "Discharge air flowrate to zone measurement for zone North";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCeiHei_y(unit="m") = mod.weaSta.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput reaCor_yDamAct_y(unit="1") = mod.reaCor.yDamAct.y "Damper position set point feedback for zone Core";
	Modelica.Blocks.Interfaces.RealOutput reaCor_yReaHeaAct_y(unit="1") = mod.reaCor.yReaHeaAct.y "Reheat control signal set point feedback for zone Core";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaPAtm_y(unit="Pa") = mod.weaSta.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput reaNor_CO2Zon_y(unit="ppm") = mod.reaNor.CO2Zon.y "Zone air CO2 measurement for zone North";
	Modelica.Blocks.Interfaces.RealOutput reaCor_V_flow_y(unit="m3/s") = mod.reaCor.V_flow.y "Discharge air flowrate to zone measurement for zone Core";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinSpe_y(unit="m/s") = mod.weaSta.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput reaSou_yDamAct_y(unit="1") = mod.reaSou.yDamAct.y "Damper position set point feedback for zone South";
	Modelica.Blocks.Interfaces.RealOutput reaWes_yReaHeaAct_y(unit="1") = mod.reaWes.yReaHeaAct.y "Reheat control signal set point feedback for zone West";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaRelHum_y(unit="1") = mod.weaSta.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput reaEas_yReaHeaAct_y(unit="1") = mod.reaEas.yReaHeaAct.y "Reheat control signal set point feedback for zone East";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_PCoo_y(unit="W") = mod.reaAhu.PCoo.y "Electrical power measurement of cooling for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaEas_TSup_y(unit="K") = mod.reaEas.TSup.y "Discharge air temperature to zone measurement for zone East";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHGloHor_y(unit="W/m2") = mod.weaSta.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDryBul_y(unit="K") = mod.weaSta.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTWetBul_y(unit="K") = mod.weaSta.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaWes_TZon_y(unit="K") = mod.reaWes.TZon.y "Zone air temperature measurement for zone West";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_PHea_y(unit="W") = mod.reaAhu.PHea.y "Electrical power consumption for heating coil for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolAlt_y(unit="rad") = mod.weaSta.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput reaEas_V_flow_y(unit="m3/s") = mod.reaEas.V_flow.y "Discharge air flowrate to zone measurement for zone East";
	Modelica.Blocks.Interfaces.RealOutput reaWes_CO2Zon_y(unit="ppm") = mod.reaWes.CO2Zon.y "Zone air CO2 measurement for zone West";
	Modelica.Blocks.Interfaces.RealOutput reaEas_PHea_y(unit="W") = mod.reaEas.PHea.y "Electrical power consumption for reheat for zone East";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_yRelAct_y(unit="1") = mod.reaAhu.yRelAct.y "Relief air damper position set point feedback for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaSou_CO2Zon_y(unit="ppm") = mod.reaSou.CO2Zon.y "Zone air CO2 measurement for zone South";
	Modelica.Blocks.Interfaces.RealOutput reaSou_TSup_y(unit="K") = mod.reaSou.TSup.y "Discharge air temperature to zone measurement for zone South";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_yFanAct_y(unit="1") = mod.reaAhu.yFanAct.y "Supply fan speed set point feedback for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_yRetAct_y(unit="1") = mod.reaAhu.yRetAct.y "Return air damper position set point feedback for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaEas_TZon_y(unit="K") = mod.reaEas.TZon.y "Zone air temperature measurement for zone East";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDifHor_y(unit="W/m2") = mod.weaSta.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLon_y(unit="rad") = mod.weaSta.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput reaWes_TSup_y(unit="K") = mod.reaWes.TSup.y "Discharge air temperature to zone measurement for zone West";
	Modelica.Blocks.Interfaces.RealOutput reaNor_yDamAct_y(unit="1") = mod.reaNor.yDamAct.y "Damper position set point feedback for zone North";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDirNor_y(unit="W/m2") = mod.weaSta.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput reaCor_TZon_y(unit="K") = mod.reaCor.TZon.y "Zone air temperature measurement for zone Core";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolDec_y(unit="rad") = mod.weaSta.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_yCooAct_y(unit="1") = mod.reaAhu.yCooAct.y "Cooling coil control signal feedback for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_TMix_y(unit="K") = mod.reaAhu.TMix.y "Mixed air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolZen_y(unit="rad") = mod.weaSta.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput reaCor_CO2Zon_y(unit="ppm") = mod.reaCor.CO2Zon.y "Zone air CO2 measurement for zone Core";
	Modelica.Blocks.Interfaces.RealOutput reaCor_PHea_y(unit="W") = mod.reaCor.PHea.y "Electrical power consumption for reheat for zone Core";
	Modelica.Blocks.Interfaces.RealOutput reaNor_PHea_y(unit="W") = mod.reaNor.PHea.y "Electrical power consumption for reheat for zone North";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_V_flow_out_y(unit="m3/s") = mod.reaAhu.V_flow_out.y "Outside air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_TSup_y(unit="K") = mod.reaAhu.TSup.y "Supply air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaEas_yDamAct_y(unit="1") = mod.reaEas.yDamAct.y "Damper position set point feedback for zone East";
	Modelica.Blocks.Interfaces.RealOutput reaNor_yReaHeaAct_y(unit="1") = mod.reaNor.yReaHeaAct.y "Reheat control signal set point feedback for zone North";
	Modelica.Blocks.Interfaces.RealOutput reaWes_PHea_y(unit="W") = mod.reaWes.PHea.y "Electrical power consumption for reheat for zone West";
	Modelica.Blocks.Interfaces.RealOutput reaSou_yReaHeaAct_y(unit="1") = mod.reaSou.yReaHeaAct.y "Reheat control signal set point feedback for zone South";
	Modelica.Blocks.Interfaces.RealOutput reaWes_yDamAct_y(unit="1") = mod.reaWes.yDamAct.y "Damper position set point feedback for zone West";
	Modelica.Blocks.Interfaces.RealOutput reaSou_PHea_y(unit="W") = mod.reaSou.PHea.y "Electrical power consumption for reheat for zone South";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolTim_y(unit="s") = mod.weaSta.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_V_flow_sup_y(unit="m3/s") = mod.reaAhu.V_flow_sup.y "Supply air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaCor_TSup_y(unit="K") = mod.reaCor.TSup.y "Discharge air temperature to zone measurement for zone Core";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTBlaSky_y(unit="K") = mod.weaSta.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaSou_TZon_y(unit="K") = mod.reaSou.TZon.y "Zone air temperature measurement for zone South";
	Modelica.Blocks.Interfaces.RealOutput reaNor_TSup_y(unit="K") = mod.reaNor.TSup.y "Discharge air temperature to zone measurement for zone North";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNTot_y(unit="1") = mod.weaSta.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_yOA_y(unit="1") = mod.reaAhu.yOA.y "Outside air damper position set point feedback for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_V_flow_ret_y(unit="m3/s") = mod.reaAhu.V_flow_ret.y "Return air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLat_y(unit="rad") = mod.weaSta.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput reaEas_CO2Zon_y(unit="ppm") = mod.reaEas.CO2Zon.y "Zone air CO2 measurement for zone East";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDewPoi_y(unit="K") = mod.weaSta.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaWes_V_flow_y(unit="m3/s") = mod.reaWes.V_flow.y "Discharge air flowrate to zone measurement for zone West";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNOpa_y(unit="1") = mod.weaSta.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_PFanSup_y(unit="W") = mod.reaAhu.PFanSup.y "Electrical power measurement of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaNor_TZon_y(unit="K") = mod.reaNor.TZon.y "Zone air temperature measurement for zone North";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_yHeaAct_y(unit="1") = mod.reaAhu.yHeaAct.y "Heating coil control signal feedback for AHU";
	Modelica.Blocks.Interfaces.RealOutput reaSou_V_flow_y(unit="m3/s") = mod.reaSou.V_flow.y "Discharge air flowrate to zone measurement for zone South";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_TRet_y(unit="K") = mod.reaAhu.TRet.y "Return air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHHorIR_y(unit="W/m2") = mod.weaSta.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput reaAhu_dp_sup_y(unit="Pa") = mod.reaAhu.dp_sup.y "Discharge pressure of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCloTim_y(unit="s") = mod.weaSta.reaWeaCloTim.y "Day number with units of seconds";
	// Original model
	MultiZoneOfficeSimpleAir.TestCases.ASHRAE2006 mod(
		oveWes.yDam(uExt(y=oveWes_yDam_u),activate(y=oveWes_yDam_activate)),
		oveWes.TZonCooSet(uExt(y=oveWes_TZonCooSet_u),activate(y=oveWes_TZonCooSet_activate)),
		oveNor.TZonCooSet(uExt(y=oveNor_TZonCooSet_u),activate(y=oveNor_TZonCooSet_activate)),
		oveEas.yDam(uExt(y=oveEas_yDam_u),activate(y=oveEas_yDam_activate)),
		oveAhu.TSupSet(uExt(y=oveAhu_TSupSet_u),activate(y=oveAhu_TSupSet_activate)),
		oveSou.TZonHeaSet(uExt(y=oveSou_TZonHeaSet_u),activate(y=oveSou_TZonHeaSet_activate)),
		oveNor.yReaHea(uExt(y=oveNor_yReaHea_u),activate(y=oveNor_yReaHea_activate)),
		oveAhu.yRet(uExt(y=oveAhu_yRet_u),activate(y=oveAhu_yRet_activate)),
		oveWes.yReaHea(uExt(y=oveWes_yReaHea_u),activate(y=oveWes_yReaHea_activate)),
		oveWes.TZonHeaSet(uExt(y=oveWes_TZonHeaSet_u),activate(y=oveWes_TZonHeaSet_activate)),
		oveCor.TZonHeaSet(uExt(y=oveCor_TZonHeaSet_u),activate(y=oveCor_TZonHeaSet_activate)),
		oveCor.TZonCooSet(uExt(y=oveCor_TZonCooSet_u),activate(y=oveCor_TZonCooSet_activate)),
		oveSou.yReaHea(uExt(y=oveSou_yReaHea_u),activate(y=oveSou_yReaHea_activate)),
		oveSou.yDam(uExt(y=oveSou_yDam_u),activate(y=oveSou_yDam_activate)),
		oveAhu.yHea(uExt(y=oveAhu_yHea_u),activate(y=oveAhu_yHea_activate)),
		oveCor.yReaHea(uExt(y=oveCor_yReaHea_u),activate(y=oveCor_yReaHea_activate)),
		oveEas.TZonCooSet(uExt(y=oveEas_TZonCooSet_u),activate(y=oveEas_TZonCooSet_activate)),
		oveAhu.yCoo(uExt(y=oveAhu_yCoo_u),activate(y=oveAhu_yCoo_activate)),
		oveNor.TZonHeaSet(uExt(y=oveNor_TZonHeaSet_u),activate(y=oveNor_TZonHeaSet_activate)),
		oveEas.TZonHeaSet(uExt(y=oveEas_TZonHeaSet_u),activate(y=oveEas_TZonHeaSet_activate)),
		oveCor.yDam(uExt(y=oveCor_yDam_u),activate(y=oveCor_yDam_activate)),
		oveSou.TZonCooSet(uExt(y=oveSou_TZonCooSet_u),activate(y=oveSou_TZonCooSet_activate)),
		oveAhu.yFan(uExt(y=oveAhu_yFan_u),activate(y=oveAhu_yFan_activate)),
		oveAhu.yOA(uExt(y=oveAhu_yOA_u),activate(y=oveAhu_yOA_activate)),
		oveAhu.dpSet(uExt(y=oveAhu_dpSet_u),activate(y=oveAhu_dpSet_activate)),
		oveEas.yReaHea(uExt(y=oveEas_yReaHea_u),activate(y=oveEas_yReaHea_activate)),
		oveNor.yDam(uExt(y=oveNor_yDam_u),activate(y=oveNor_yDam_activate))) "Original model with overwrites";
end wrapped;
