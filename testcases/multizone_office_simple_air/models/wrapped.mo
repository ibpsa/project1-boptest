model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActSou_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActSou_yDam_activate "Activation for Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupEas_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupEas_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupWes_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupWes_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_yRet_u(unit="1", min=0.0, max=1.0) "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_yRet_activate "Activation for Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupSou_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupSou_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActCor_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActCor_yReaHea_activate "Activation for Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActEas_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActEas_yDam_activate "Activation for Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_yPumCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil pump control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_yPumCoo_activate "Activation for Cooling coil pump control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupSou_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupSou_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupWes_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupWes_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_yFan_u(unit="1", min=0.0, max=1.0) "Supply fan speed setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_yFan_activate "Activation for Supply fan speed setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupNor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupNor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_TSupSet_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_TSupSet_activate "Activation for Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActCor_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActCor_yDam_activate "Activation for Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupNor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupNor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_yCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_yCoo_activate "Activation for Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActSou_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActSou_yReaHea_activate "Activation for Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupCor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupCor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_yPumHea_u(unit="1", min=0.0, max=1.0) "Heating coil pump control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_yPumHea_activate "Activation for Heating coil pump control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActWes_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActWes_yReaHea_activate "Activation for Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActNor_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActNor_yDam_activate "Activation for Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupEas_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupEas_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_dpSet_u(unit="Pa", min=50.0, max=410.0) "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_dpSet_activate "Activation for Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_yOA_u(unit="1", min=0.0, max=1.0) "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_yOA_activate "Activation for Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActNor_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActNor_yReaHea_activate "Activation for Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActWes_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActWes_yDam_activate "Activation for Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_oveAhu_yHea_u(unit="1", min=0.0, max=1.0) "Heating coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveAhu_yHea_activate "Activation for Heating coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonSupCor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonSupCor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_oveZonActEas_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveZonActEas_yReaHea_activate "Activation for Reheat control signal for zone eas";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolHouAng_y(unit="rad") = mod.weaSta.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonWes_TZon_y(unit="K") = mod.hvac.reaZonWes.TZon.y "Zone air temperature measurement for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_THeaCoiRet_y(unit="K") = mod.hvac.reaAhu.THeaCoiRet.y "Heating coil return water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonWes_TSup_y(unit="K") = mod.hvac.reaZonWes.TSup.y "Discharge air temperature to zone measurement for zone wes";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTBlaSky_y(unit="K") = mod.weaSta.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput chi_reaFloSup_y(unit="m3/s") = mod.chi.reaFloSup.y "Supply water flow rate of chiller";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_V_flow_sup_y(unit="m3/s") = mod.hvac.reaAhu.V_flow_sup.y "Supply air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_PPumHea_y(unit="W") = mod.hvac.reaAhu.PPumHea.y "Electrical power measurement of heating coil pump for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonEas_TSup_y(unit="K") = mod.hvac.reaZonEas.TSup.y "Discharge air temperature to zone measurement for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_TSup_y(unit="K") = mod.hvac.reaAhu.TSup.y "Supply air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinSpe_y(unit="m/s") = mod.weaSta.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonNor_V_flow_y(unit="m3/s") = mod.hvac.reaZonNor.V_flow.y "Discharge air flowrate to zone measurement for zone nor";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNOpa_y(unit="1") = mod.weaSta.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaRelHum_y(unit="1") = mod.weaSta.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonCor_CO2Zon_y(unit="ppm") = mod.hvac.reaZonCor.CO2Zon.y "Zone air CO2 measurement for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_TCooCoiSup_y(unit="K") = mod.hvac.reaAhu.TCooCoiSup.y "Cooling coil supply water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCloTim_y(unit="s") = mod.weaSta.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput heaPum_reaTRet_y(unit="K") = mod.heaPum.reaTRet.y "Return water temperature of heat pump";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHGloHor_y(unit="W/m2") = mod.weaSta.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDryBul_y(unit="K") = mod.weaSta.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonNor_TSup_y(unit="K") = mod.hvac.reaZonNor.TSup.y "Discharge air temperature to zone measurement for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonSou_V_flow_y(unit="m3/s") = mod.hvac.reaZonSou.V_flow.y "Discharge air flowrate to zone measurement for zone sou";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolAlt_y(unit="rad") = mod.weaSta.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_PFanSup_y(unit="W") = mod.hvac.reaAhu.PFanSup.y "Electrical power measurement of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCeiHei_y(unit="m") = mod.weaSta.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonCor_V_flow_y(unit="m3/s") = mod.hvac.reaZonCor.V_flow.y "Discharge air flowrate to zone measurement for zone cor";
	Modelica.Blocks.Interfaces.RealOutput chi_reaPPumDis_y(unit="W") = mod.chi.reaPPumDis.y "Electric power consumed by chilled water distribution pump";
	Modelica.Blocks.Interfaces.RealOutput heaPum_reaPPumDis_y(unit="W") = mod.heaPum.reaPPumDis.y "Electric power consumed by hot water distribution pump";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonWes_CO2Zon_y(unit="ppm") = mod.hvac.reaZonWes.CO2Zon.y "Zone air CO2 measurement for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonEas_TZon_y(unit="K") = mod.hvac.reaZonEas.TZon.y "Zone air temperature measurement for zone eas";
	Modelica.Blocks.Interfaces.RealOutput heaPum_reaFloSup_y(unit="m3/s") = mod.heaPum.reaFloSup.y "Supply water flow rate of heat pump";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonEas_CO2Zon_y(unit="ppm") = mod.hvac.reaZonEas.CO2Zon.y "Zone air CO2 measurement for zone eas";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolZen_y(unit="rad") = mod.weaSta.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_dp_sup_y(unit="Pa") = mod.hvac.reaAhu.dp_sup.y "Discharge pressure of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDifHor_y(unit="W/m2") = mod.weaSta.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput heaPum_reaPHeaPum_y(unit="W") = mod.heaPum.reaPHeaPum.y "Electric power consumed by heat pump";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonCor_TZon_y(unit="K") = mod.hvac.reaZonCor.TZon.y "Zone air temperature measurement for zone cor";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaPAtm_y(unit="Pa") = mod.weaSta.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDirNor_y(unit="W/m2") = mod.weaSta.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_TMix_y(unit="K") = mod.hvac.reaAhu.TMix.y "Mixed air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolDec_y(unit="rad") = mod.weaSta.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_THeaCoiSup_y(unit="K") = mod.hvac.reaAhu.THeaCoiSup.y "Heating coil supply water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonNor_TZon_y(unit="K") = mod.hvac.reaZonNor.TZon.y "Zone air temperature measurement for zone nor";
	Modelica.Blocks.Interfaces.RealOutput chi_reaPChi_y(unit="W") = mod.chi.reaPChi.y "Electric power consumed by chiller";
	Modelica.Blocks.Interfaces.RealOutput chi_reaTSup_y(unit="K") = mod.chi.reaTSup.y "Supply water temperature of chiller";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonWes_V_flow_y(unit="m3/s") = mod.hvac.reaZonWes.V_flow.y "Discharge air flowrate to zone measurement for zone wes";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLon_y(unit="rad") = mod.weaSta.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNTot_y(unit="1") = mod.weaSta.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolTim_y(unit="s") = mod.weaSta.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonEas_V_flow_y(unit="m3/s") = mod.hvac.reaZonEas.V_flow.y "Discharge air flowrate to zone measurement for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_V_flow_ret_y(unit="m3/s") = mod.hvac.reaAhu.V_flow_ret.y "Return air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_TRet_y(unit="K") = mod.hvac.reaAhu.TRet.y "Return air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonSou_TZon_y(unit="K") = mod.hvac.reaZonSou.TZon.y "Zone air temperature measurement for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonSou_TSup_y(unit="K") = mod.hvac.reaZonSou.TSup.y "Discharge air temperature to zone measurement for zone sou";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLat_y(unit="rad") = mod.weaSta.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonNor_CO2Zon_y(unit="ppm") = mod.hvac.reaZonNor.CO2Zon.y "Zone air CO2 measurement for zone nor";
	Modelica.Blocks.Interfaces.RealOutput chi_reaTRet_y(unit="K") = mod.chi.reaTRet.y "Return water temperature of chiller";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDewPoi_y(unit="K") = mod.weaSta.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTWetBul_y(unit="K") = mod.weaSta.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput heaPum_reaTSup_y(unit="K") = mod.heaPum.reaTSup.y "Supply water temperature of heat pump";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonSou_CO2Zon_y(unit="ppm") = mod.hvac.reaZonSou.CO2Zon.y "Zone air CO2 measurement for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaZonCor_TSup_y(unit="K") = mod.hvac.reaZonCor.TSup.y "Discharge air temperature to zone measurement for zone cor";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinDir_y(unit="rad") = mod.weaSta.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHHorIR_y(unit="W/m2") = mod.weaSta.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_PPumCoo_y(unit="W") = mod.hvac.reaAhu.PPumCoo.y "Electrical power measurement of cooling coil pump for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaAhu_TCooCoiRet_y(unit="K") = mod.hvac.reaAhu.TCooCoiRet.y "Cooling coil return water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActSou_yDam_y(unit="1") = mod.hvac.oveZonActSou.yDam.y "Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupEas_TZonHeaSet_y(unit="K") = mod.hvac.oveZonSupEas.TZonHeaSet.y "Zone air temperature heating setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupWes_TZonHeaSet_y(unit="K") = mod.hvac.oveZonSupWes.TZonHeaSet.y "Zone air temperature heating setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_yRet_y(unit="1") = mod.hvac.oveAhu.yRet.y "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupSou_TZonHeaSet_y(unit="K") = mod.hvac.oveZonSupSou.TZonHeaSet.y "Zone air temperature heating setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActCor_yReaHea_y(unit="1") = mod.hvac.oveZonActCor.yReaHea.y "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActEas_yDam_y(unit="1") = mod.hvac.oveZonActEas.yDam.y "Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_yPumCoo_y(unit="1") = mod.hvac.oveAhu.yPumCoo.y "Cooling coil pump control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupSou_TZonCooSet_y(unit="K") = mod.hvac.oveZonSupSou.TZonCooSet.y "Zone air temperature cooling setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupWes_TZonCooSet_y(unit="K") = mod.hvac.oveZonSupWes.TZonCooSet.y "Zone air temperature cooling setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_yFan_y(unit="1") = mod.hvac.oveAhu.yFan.y "Supply fan speed setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupNor_TZonHeaSet_y(unit="K") = mod.hvac.oveZonSupNor.TZonHeaSet.y "Zone air temperature heating setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_TSupSet_y(unit="K") = mod.hvac.oveAhu.TSupSet.y "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActCor_yDam_y(unit="1") = mod.hvac.oveZonActCor.yDam.y "Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupNor_TZonCooSet_y(unit="K") = mod.hvac.oveZonSupNor.TZonCooSet.y "Zone air temperature cooling setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_yCoo_y(unit="1") = mod.hvac.oveAhu.yCoo.y "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActSou_yReaHea_y(unit="1") = mod.hvac.oveZonActSou.yReaHea.y "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupCor_TZonCooSet_y(unit="K") = mod.hvac.oveZonSupCor.TZonCooSet.y "Zone air temperature cooling setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_yPumHea_y(unit="1") = mod.hvac.oveAhu.yPumHea.y "Heating coil pump control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActWes_yReaHea_y(unit="1") = mod.hvac.oveZonActWes.yReaHea.y "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActNor_yDam_y(unit="1") = mod.hvac.oveZonActNor.yDam.y "Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupEas_TZonCooSet_y(unit="K") = mod.hvac.oveZonSupEas.TZonCooSet.y "Zone air temperature cooling setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_dpSet_y(unit="Pa") = mod.hvac.oveAhu.dpSet.y "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_yOA_y(unit="1") = mod.hvac.oveAhu.yOA.y "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActNor_yReaHea_y(unit="1") = mod.hvac.oveZonActNor.yReaHea.y "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActWes_yDam_y(unit="1") = mod.hvac.oveZonActWes.yDam.y "Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveAhu_yHea_y(unit="1") = mod.hvac.oveAhu.yHea.y "Heating coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonSupCor_TZonHeaSet_y(unit="K") = mod.hvac.oveZonSupCor.TZonHeaSet.y "Zone air temperature heating setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveZonActEas_yReaHea_y(unit="1") = mod.hvac.oveZonActEas.yReaHea.y "Reheat control signal for zone eas";
	// Original model
	MultiZoneOfficeSimpleAir.TestCases.TestCase mod(
		hvac.oveZonActSou.yDam(uExt(y=hvac_oveZonActSou_yDam_u),activate(y=hvac_oveZonActSou_yDam_activate)),
		hvac.oveZonSupEas.TZonHeaSet(uExt(y=hvac_oveZonSupEas_TZonHeaSet_u),activate(y=hvac_oveZonSupEas_TZonHeaSet_activate)),
		hvac.oveZonSupWes.TZonHeaSet(uExt(y=hvac_oveZonSupWes_TZonHeaSet_u),activate(y=hvac_oveZonSupWes_TZonHeaSet_activate)),
		hvac.oveAhu.yRet(uExt(y=hvac_oveAhu_yRet_u),activate(y=hvac_oveAhu_yRet_activate)),
		hvac.oveZonSupSou.TZonHeaSet(uExt(y=hvac_oveZonSupSou_TZonHeaSet_u),activate(y=hvac_oveZonSupSou_TZonHeaSet_activate)),
		hvac.oveZonActCor.yReaHea(uExt(y=hvac_oveZonActCor_yReaHea_u),activate(y=hvac_oveZonActCor_yReaHea_activate)),
		hvac.oveZonActEas.yDam(uExt(y=hvac_oveZonActEas_yDam_u),activate(y=hvac_oveZonActEas_yDam_activate)),
		hvac.oveAhu.yPumCoo(uExt(y=hvac_oveAhu_yPumCoo_u),activate(y=hvac_oveAhu_yPumCoo_activate)),
		hvac.oveZonSupSou.TZonCooSet(uExt(y=hvac_oveZonSupSou_TZonCooSet_u),activate(y=hvac_oveZonSupSou_TZonCooSet_activate)),
		hvac.oveZonSupWes.TZonCooSet(uExt(y=hvac_oveZonSupWes_TZonCooSet_u),activate(y=hvac_oveZonSupWes_TZonCooSet_activate)),
		hvac.oveAhu.yFan(uExt(y=hvac_oveAhu_yFan_u),activate(y=hvac_oveAhu_yFan_activate)),
		hvac.oveZonSupNor.TZonHeaSet(uExt(y=hvac_oveZonSupNor_TZonHeaSet_u),activate(y=hvac_oveZonSupNor_TZonHeaSet_activate)),
		hvac.oveAhu.TSupSet(uExt(y=hvac_oveAhu_TSupSet_u),activate(y=hvac_oveAhu_TSupSet_activate)),
		hvac.oveZonActCor.yDam(uExt(y=hvac_oveZonActCor_yDam_u),activate(y=hvac_oveZonActCor_yDam_activate)),
		hvac.oveZonSupNor.TZonCooSet(uExt(y=hvac_oveZonSupNor_TZonCooSet_u),activate(y=hvac_oveZonSupNor_TZonCooSet_activate)),
		hvac.oveAhu.yCoo(uExt(y=hvac_oveAhu_yCoo_u),activate(y=hvac_oveAhu_yCoo_activate)),
		hvac.oveZonActSou.yReaHea(uExt(y=hvac_oveZonActSou_yReaHea_u),activate(y=hvac_oveZonActSou_yReaHea_activate)),
		hvac.oveZonSupCor.TZonCooSet(uExt(y=hvac_oveZonSupCor_TZonCooSet_u),activate(y=hvac_oveZonSupCor_TZonCooSet_activate)),
		hvac.oveAhu.yPumHea(uExt(y=hvac_oveAhu_yPumHea_u),activate(y=hvac_oveAhu_yPumHea_activate)),
		hvac.oveZonActWes.yReaHea(uExt(y=hvac_oveZonActWes_yReaHea_u),activate(y=hvac_oveZonActWes_yReaHea_activate)),
		hvac.oveZonActNor.yDam(uExt(y=hvac_oveZonActNor_yDam_u),activate(y=hvac_oveZonActNor_yDam_activate)),
		hvac.oveZonSupEas.TZonCooSet(uExt(y=hvac_oveZonSupEas_TZonCooSet_u),activate(y=hvac_oveZonSupEas_TZonCooSet_activate)),
		hvac.oveAhu.dpSet(uExt(y=hvac_oveAhu_dpSet_u),activate(y=hvac_oveAhu_dpSet_activate)),
		hvac.oveAhu.yOA(uExt(y=hvac_oveAhu_yOA_u),activate(y=hvac_oveAhu_yOA_activate)),
		hvac.oveZonActNor.yReaHea(uExt(y=hvac_oveZonActNor_yReaHea_u),activate(y=hvac_oveZonActNor_yReaHea_activate)),
		hvac.oveZonActWes.yDam(uExt(y=hvac_oveZonActWes_yDam_u),activate(y=hvac_oveZonActWes_yDam_activate)),
		hvac.oveAhu.yHea(uExt(y=hvac_oveAhu_yHea_u),activate(y=hvac_oveAhu_yHea_activate)),
		hvac.oveZonSupCor.TZonHeaSet(uExt(y=hvac_oveZonSupCor_TZonHeaSet_u),activate(y=hvac_oveZonSupCor_TZonHeaSet_activate)),
		hvac.oveZonActEas.yReaHea(uExt(y=hvac_oveZonActEas_yReaHea_u),activate(y=hvac_oveZonActEas_yReaHea_activate))) "Original model with overwrites";
end wrapped;
