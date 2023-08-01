model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_TSupAirSet_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_TSupAirSet_activate "Activation for Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_dpSet_u(unit="Pa", min=50.0, max=410.0) "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_dpSet_activate "Activation for Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_cooCoil_yCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_cooCoil_yCoo_activate "Activation for Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yEA_u(unit="1", min=0.0, max=1.0) "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yEA_activate "Activation for Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yOA_u(unit="1", min=0.0, max=1.0) "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yOA_activate "Activation for Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yRet_u(unit="1", min=0.0, max=1.0) "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yRet_activate "Activation for Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_oveSpeRetFan_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_oveSpeRetFan_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_supFan_oveSpeSupFan_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_supFan_oveSpeSupFan_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonCor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonCor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonCor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonCor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonEas_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonEas_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonEas_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonEas_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonNor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonNor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonNor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonNor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonSou_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonSou_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonSou_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonSou_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonWes_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonWes_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_oveZonWes_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_oveZonWes_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_TSupAirSet_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_TSupAirSet_activate "Activation for Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_dpSet_u(unit="Pa", min=50.0, max=410.0) "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_dpSet_activate "Activation for Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_cooCoil_yCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_cooCoil_yCoo_activate "Activation for Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yEA_u(unit="1", min=0.0, max=1.0) "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yEA_activate "Activation for Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yOA_u(unit="1", min=0.0, max=1.0) "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yOA_activate "Activation for Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yRet_u(unit="1", min=0.0, max=1.0) "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yRet_activate "Activation for Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_oveSpeRetFan_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_oveSpeRetFan_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_supFan_oveSpeSupFan_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_supFan_oveSpeSupFan_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonCor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonCor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonCor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonCor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonEas_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonEas_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonEas_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonEas_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonNor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonNor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonNor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonNor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonSou_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonSou_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonSou_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonSou_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonWes_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonWes_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_oveZonWes_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_oveZonWes_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_TSupAirSet_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_TSupAirSet_activate "Activation for Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_dpSet_u(unit="Pa", min=50.0, max=410.0) "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_dpSet_activate "Activation for Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_cooCoil_yCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_cooCoil_yCoo_activate "Activation for Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yEA_u(unit="1", min=0.0, max=1.0) "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yEA_activate "Activation for Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yOA_u(unit="1", min=0.0, max=1.0) "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yOA_activate "Activation for Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yRet_u(unit="1", min=0.0, max=1.0) "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yRet_activate "Activation for Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_oveSpeRetFan_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_oveSpeRetFan_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_supFan_oveSpeSupFan_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_supFan_oveSpeSupFan_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yDam_activate "Activation for Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonCor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonCor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonCor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonCor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonEas_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonEas_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonEas_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonEas_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonNor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonNor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonNor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonNor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonSou_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonSou_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonSou_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonSou_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonWes_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonWes_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_oveZonWes_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_oveZonWes_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealInput hvac_oveChiWatSys_TW_set_u(unit="K", min=278.15, max=288.15) "Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveChiWatSys_TW_set_activate "Activation for Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_oveChiWatSys_dp_set_u(unit="Pa", min=0.0, max=19130000.0) "Differential pressure setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveChiWatSys_dp_set_activate "Activation for Differential pressure setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_oveHotWatSys_TW_set_u(unit="K", min=291.15, max=353.15) "Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveHotWatSys_TW_set_activate "Activation for Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_oveHotWatSys_dp_set_u(unit="Pa", min=0.0, max=19130000.0) "Differential pressure setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveHotWatSys_dp_set_activate "Activation for Differential pressure setpoint";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_TRoo_Coo_set_y(unit="K") = mod.hvac.floor1.reaZonCor.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonebot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_TRoo_Hea_set_y(unit="K") = mod.hvac.floor1.reaZonCor.TRoo_Hea_set.y "Zone temperature heating setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_TSup_y(unit="K") = mod.hvac.floor1.reaZonCor.TSup.y "Discharge air temperature to zone measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_TZon_y(unit="K") = mod.hvac.floor1.reaZonCor.TZon.y "Zone air temperature measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_V_flow_y(unit="m3/s") = mod.hvac.floor1.reaZonCor.V_flow.y "Discharge air flowrate to zone measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_V_flow_set_y(unit="m3/s") = mod.hvac.floor1.reaZonCor.V_flow_set.y "Airflow setpointbot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_yCoo_y(unit="1") = mod.hvac.floor1.reaZonCor.yCoo.y "Cooling PID signal measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_yDam_y(unit="1") = mod.hvac.floor1.reaZonCor.yDam.y "Damper position measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_yHea_y(unit="1") = mod.hvac.floor1.reaZonCor.yHea.y "Heating PID signal measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonCor_yReheaVal_y(unit="1") = mod.hvac.floor1.reaZonCor.yReheaVal.y "Reheat valve position measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_TRoo_Coo_set_y(unit="K") = mod.hvac.floor1.reaZonEas.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonebot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_TRoo_Hea_set_y(unit="K") = mod.hvac.floor1.reaZonEas.TRoo_Hea_set.y "Zone temperature heating setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_TSup_y(unit="K") = mod.hvac.floor1.reaZonEas.TSup.y "Discharge air temperature to zone measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_TZon_y(unit="K") = mod.hvac.floor1.reaZonEas.TZon.y "Zone air temperature measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_V_flow_y(unit="m3/s") = mod.hvac.floor1.reaZonEas.V_flow.y "Discharge air flowrate to zone measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_V_flow_set_y(unit="m3/s") = mod.hvac.floor1.reaZonEas.V_flow_set.y "Airflow setpointbot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_yCoo_y(unit="1") = mod.hvac.floor1.reaZonEas.yCoo.y "Cooling PID signal measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_yDam_y(unit="1") = mod.hvac.floor1.reaZonEas.yDam.y "Damper position measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_yHea_y(unit="1") = mod.hvac.floor1.reaZonEas.yHea.y "Heating PID signal measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonEas_yReheaVal_y(unit="1") = mod.hvac.floor1.reaZonEas.yReheaVal.y "Reheat valve position measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_TRoo_Coo_set_y(unit="K") = mod.hvac.floor1.reaZonNor.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonebot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_TRoo_Hea_set_y(unit="K") = mod.hvac.floor1.reaZonNor.TRoo_Hea_set.y "Zone temperature heating setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_TSup_y(unit="K") = mod.hvac.floor1.reaZonNor.TSup.y "Discharge air temperature to zone measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_TZon_y(unit="K") = mod.hvac.floor1.reaZonNor.TZon.y "Zone air temperature measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_V_flow_y(unit="m3/s") = mod.hvac.floor1.reaZonNor.V_flow.y "Discharge air flowrate to zone measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_V_flow_set_y(unit="m3/s") = mod.hvac.floor1.reaZonNor.V_flow_set.y "Airflow setpointbot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_yCoo_y(unit="1") = mod.hvac.floor1.reaZonNor.yCoo.y "Cooling PID signal measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_yDam_y(unit="1") = mod.hvac.floor1.reaZonNor.yDam.y "Damper position measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_yHea_y(unit="1") = mod.hvac.floor1.reaZonNor.yHea.y "Heating PID signal measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonNor_yReheaVal_y(unit="1") = mod.hvac.floor1.reaZonNor.yReheaVal.y "Reheat valve position measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_TRoo_Coo_set_y(unit="K") = mod.hvac.floor1.reaZonSou.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonebot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_TRoo_Hea_set_y(unit="K") = mod.hvac.floor1.reaZonSou.TRoo_Hea_set.y "Zone temperature heating setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_TSup_y(unit="K") = mod.hvac.floor1.reaZonSou.TSup.y "Discharge air temperature to zone measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_TZon_y(unit="K") = mod.hvac.floor1.reaZonSou.TZon.y "Zone air temperature measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_V_flow_y(unit="m3/s") = mod.hvac.floor1.reaZonSou.V_flow.y "Discharge air flowrate to zone measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_V_flow_set_y(unit="m3/s") = mod.hvac.floor1.reaZonSou.V_flow_set.y "Airflow setpointbot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_yCoo_y(unit="1") = mod.hvac.floor1.reaZonSou.yCoo.y "Cooling PID signal measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_yDam_y(unit="1") = mod.hvac.floor1.reaZonSou.yDam.y "Damper position measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_yHea_y(unit="1") = mod.hvac.floor1.reaZonSou.yHea.y "Heating PID signal measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonSou_yReheaVal_y(unit="1") = mod.hvac.floor1.reaZonSou.yReheaVal.y "Reheat valve position measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_TRoo_Coo_set_y(unit="K") = mod.hvac.floor1.reaZonWes.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonebot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_TRoo_Hea_set_y(unit="K") = mod.hvac.floor1.reaZonWes.TRoo_Hea_set.y "Zone temperature heating setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_TSup_y(unit="K") = mod.hvac.floor1.reaZonWes.TSup.y "Discharge air temperature to zone measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_TZon_y(unit="K") = mod.hvac.floor1.reaZonWes.TZon.y "Zone air temperature measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_V_flow_y(unit="m3/s") = mod.hvac.floor1.reaZonWes.V_flow.y "Discharge air flowrate to zone measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_V_flow_set_y(unit="m3/s") = mod.hvac.floor1.reaZonWes.V_flow_set.y "Airflow setpointbot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_yCoo_y(unit="1") = mod.hvac.floor1.reaZonWes.yCoo.y "Cooling PID signal measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_yDam_y(unit="1") = mod.hvac.floor1.reaZonWes.yDam.y "Damper position measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_yHea_y(unit="1") = mod.hvac.floor1.reaZonWes.yHea.y "Heating PID signal measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_reaZonWes_yReheaVal_y(unit="1") = mod.hvac.floor1.reaZonWes.yReheaVal.y "Reheat valve position measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_PFanTot_y(unit="W") = mod.hvac.floor1.readAhu.PFanTot.y "Total electrical power measurement of supply and return fans for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_TCooCoiRet_y(unit="K") = mod.hvac.floor1.readAhu.TCooCoiRet.y "Cooling coil return water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_TCooCoiSup_y(unit="K") = mod.hvac.floor1.readAhu.TCooCoiSup.y "Cooling coil supply water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_TMix_y(unit="K") = mod.hvac.floor1.readAhu.TMix.y "Mixed air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_TRet_y(unit="K") = mod.hvac.floor1.readAhu.TRet.y "Return air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_TSup_y(unit="K") = mod.hvac.floor1.readAhu.TSup.y "Supply air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_TSup_set_y(unit="K") = mod.hvac.floor1.readAhu.TSup_set.y "Supply air temperature setpoint measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_V_flow_OA_y(unit="m3/s") = mod.hvac.floor1.readAhu.V_flow_OA.y "Supply outdoor airflow rate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_V_flow_ret_y(unit="m3/s") = mod.hvac.floor1.readAhu.V_flow_ret.y "Return air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_V_flow_sup_y(unit="m3/s") = mod.hvac.floor1.readAhu.V_flow_sup.y "Supply air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_dp_sup_y(unit="Pa") = mod.hvac.floor1.readAhu.dp_sup.y "Discharge pressure of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_occ_y(unit="1") = mod.hvac.floor1.readAhu.occ.y "Occupancy status (1 occupied, 0 unoccupied)";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_yCooVal_y(unit="1") = mod.hvac.floor1.readAhu.yCooVal.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_readAhu_yOA_y(unit="1") = mod.hvac.floor1.readAhu.yOA.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_TRoo_Coo_set_y(unit="K") = mod.hvac.floor2.reaZonCor.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonemid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_TRoo_Hea_set_y(unit="K") = mod.hvac.floor2.reaZonCor.TRoo_Hea_set.y "Zone temperature heating setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_TSup_y(unit="K") = mod.hvac.floor2.reaZonCor.TSup.y "Discharge air temperature to zone measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_TZon_y(unit="K") = mod.hvac.floor2.reaZonCor.TZon.y "Zone air temperature measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_V_flow_y(unit="m3/s") = mod.hvac.floor2.reaZonCor.V_flow.y "Discharge air flowrate to zone measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_V_flow_set_y(unit="m3/s") = mod.hvac.floor2.reaZonCor.V_flow_set.y "Airflow setpointmid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_yCoo_y(unit="1") = mod.hvac.floor2.reaZonCor.yCoo.y "Cooling PID signal measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_yDam_y(unit="1") = mod.hvac.floor2.reaZonCor.yDam.y "Damper position measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_yHea_y(unit="1") = mod.hvac.floor2.reaZonCor.yHea.y "Heating PID signal measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonCor_yReheaVal_y(unit="1") = mod.hvac.floor2.reaZonCor.yReheaVal.y "Reheat valve position measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_TRoo_Coo_set_y(unit="K") = mod.hvac.floor2.reaZonEas.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonemid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_TRoo_Hea_set_y(unit="K") = mod.hvac.floor2.reaZonEas.TRoo_Hea_set.y "Zone temperature heating setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_TSup_y(unit="K") = mod.hvac.floor2.reaZonEas.TSup.y "Discharge air temperature to zone measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_TZon_y(unit="K") = mod.hvac.floor2.reaZonEas.TZon.y "Zone air temperature measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_V_flow_y(unit="m3/s") = mod.hvac.floor2.reaZonEas.V_flow.y "Discharge air flowrate to zone measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_V_flow_set_y(unit="m3/s") = mod.hvac.floor2.reaZonEas.V_flow_set.y "Airflow setpointmid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_yCoo_y(unit="1") = mod.hvac.floor2.reaZonEas.yCoo.y "Cooling PID signal measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_yDam_y(unit="1") = mod.hvac.floor2.reaZonEas.yDam.y "Damper position measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_yHea_y(unit="1") = mod.hvac.floor2.reaZonEas.yHea.y "Heating PID signal measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonEas_yReheaVal_y(unit="1") = mod.hvac.floor2.reaZonEas.yReheaVal.y "Reheat valve position measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_TRoo_Coo_set_y(unit="K") = mod.hvac.floor2.reaZonNor.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonemid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_TRoo_Hea_set_y(unit="K") = mod.hvac.floor2.reaZonNor.TRoo_Hea_set.y "Zone temperature heating setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_TSup_y(unit="K") = mod.hvac.floor2.reaZonNor.TSup.y "Discharge air temperature to zone measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_TZon_y(unit="K") = mod.hvac.floor2.reaZonNor.TZon.y "Zone air temperature measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_V_flow_y(unit="m3/s") = mod.hvac.floor2.reaZonNor.V_flow.y "Discharge air flowrate to zone measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_V_flow_set_y(unit="m3/s") = mod.hvac.floor2.reaZonNor.V_flow_set.y "Airflow setpointmid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_yCoo_y(unit="1") = mod.hvac.floor2.reaZonNor.yCoo.y "Cooling PID signal measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_yDam_y(unit="1") = mod.hvac.floor2.reaZonNor.yDam.y "Damper position measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_yHea_y(unit="1") = mod.hvac.floor2.reaZonNor.yHea.y "Heating PID signal measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonNor_yReheaVal_y(unit="1") = mod.hvac.floor2.reaZonNor.yReheaVal.y "Reheat valve position measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_TRoo_Coo_set_y(unit="K") = mod.hvac.floor2.reaZonSou.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonemid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_TRoo_Hea_set_y(unit="K") = mod.hvac.floor2.reaZonSou.TRoo_Hea_set.y "Zone temperature heating setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_TSup_y(unit="K") = mod.hvac.floor2.reaZonSou.TSup.y "Discharge air temperature to zone measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_TZon_y(unit="K") = mod.hvac.floor2.reaZonSou.TZon.y "Zone air temperature measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_V_flow_y(unit="m3/s") = mod.hvac.floor2.reaZonSou.V_flow.y "Discharge air flowrate to zone measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_V_flow_set_y(unit="m3/s") = mod.hvac.floor2.reaZonSou.V_flow_set.y "Airflow setpointmid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_yCoo_y(unit="1") = mod.hvac.floor2.reaZonSou.yCoo.y "Cooling PID signal measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_yDam_y(unit="1") = mod.hvac.floor2.reaZonSou.yDam.y "Damper position measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_yHea_y(unit="1") = mod.hvac.floor2.reaZonSou.yHea.y "Heating PID signal measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonSou_yReheaVal_y(unit="1") = mod.hvac.floor2.reaZonSou.yReheaVal.y "Reheat valve position measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_TRoo_Coo_set_y(unit="K") = mod.hvac.floor2.reaZonWes.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonemid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_TRoo_Hea_set_y(unit="K") = mod.hvac.floor2.reaZonWes.TRoo_Hea_set.y "Zone temperature heating setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_TSup_y(unit="K") = mod.hvac.floor2.reaZonWes.TSup.y "Discharge air temperature to zone measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_TZon_y(unit="K") = mod.hvac.floor2.reaZonWes.TZon.y "Zone air temperature measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_V_flow_y(unit="m3/s") = mod.hvac.floor2.reaZonWes.V_flow.y "Discharge air flowrate to zone measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_V_flow_set_y(unit="m3/s") = mod.hvac.floor2.reaZonWes.V_flow_set.y "Airflow setpointmid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_yCoo_y(unit="1") = mod.hvac.floor2.reaZonWes.yCoo.y "Cooling PID signal measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_yDam_y(unit="1") = mod.hvac.floor2.reaZonWes.yDam.y "Damper position measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_yHea_y(unit="1") = mod.hvac.floor2.reaZonWes.yHea.y "Heating PID signal measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_reaZonWes_yReheaVal_y(unit="1") = mod.hvac.floor2.reaZonWes.yReheaVal.y "Reheat valve position measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_PFanTot_y(unit="W") = mod.hvac.floor2.readAhu.PFanTot.y "Total electrical power measurement of supply and return fans for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_TCooCoiRet_y(unit="K") = mod.hvac.floor2.readAhu.TCooCoiRet.y "Cooling coil return water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_TCooCoiSup_y(unit="K") = mod.hvac.floor2.readAhu.TCooCoiSup.y "Cooling coil supply water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_TMix_y(unit="K") = mod.hvac.floor2.readAhu.TMix.y "Mixed air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_TRet_y(unit="K") = mod.hvac.floor2.readAhu.TRet.y "Return air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_TSup_y(unit="K") = mod.hvac.floor2.readAhu.TSup.y "Supply air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_TSup_set_y(unit="K") = mod.hvac.floor2.readAhu.TSup_set.y "Supply air temperature setpoint measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_V_flow_OA_y(unit="m3/s") = mod.hvac.floor2.readAhu.V_flow_OA.y "Supply outdoor airflow rate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_V_flow_ret_y(unit="m3/s") = mod.hvac.floor2.readAhu.V_flow_ret.y "Return air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_V_flow_sup_y(unit="m3/s") = mod.hvac.floor2.readAhu.V_flow_sup.y "Supply air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_dp_sup_y(unit="Pa") = mod.hvac.floor2.readAhu.dp_sup.y "Discharge pressure of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_occ_y(unit="1") = mod.hvac.floor2.readAhu.occ.y "Occupancy status (1 occupied, 0 unoccupied)";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_yCooVal_y(unit="1") = mod.hvac.floor2.readAhu.yCooVal.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_readAhu_yOA_y(unit="1") = mod.hvac.floor2.readAhu.yOA.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_TRoo_Coo_set_y(unit="K") = mod.hvac.floor3.reaZonCor.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonetop_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_TRoo_Hea_set_y(unit="K") = mod.hvac.floor3.reaZonCor.TRoo_Hea_set.y "Zone temperature heating setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_TSup_y(unit="K") = mod.hvac.floor3.reaZonCor.TSup.y "Discharge air temperature to zone measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_TZon_y(unit="K") = mod.hvac.floor3.reaZonCor.TZon.y "Zone air temperature measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_V_flow_y(unit="m3/s") = mod.hvac.floor3.reaZonCor.V_flow.y "Discharge air flowrate to zone measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_V_flow_set_y(unit="m3/s") = mod.hvac.floor3.reaZonCor.V_flow_set.y "Airflow setpointtop_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_yCoo_y(unit="1") = mod.hvac.floor3.reaZonCor.yCoo.y "Cooling PID signal measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_yDam_y(unit="1") = mod.hvac.floor3.reaZonCor.yDam.y "Damper position measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_yHea_y(unit="1") = mod.hvac.floor3.reaZonCor.yHea.y "Heating PID signal measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonCor_yReheaVal_y(unit="1") = mod.hvac.floor3.reaZonCor.yReheaVal.y "Reheat valve position measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_TRoo_Coo_set_y(unit="K") = mod.hvac.floor3.reaZonEas.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonetop_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_TRoo_Hea_set_y(unit="K") = mod.hvac.floor3.reaZonEas.TRoo_Hea_set.y "Zone temperature heating setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_TSup_y(unit="K") = mod.hvac.floor3.reaZonEas.TSup.y "Discharge air temperature to zone measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_TZon_y(unit="K") = mod.hvac.floor3.reaZonEas.TZon.y "Zone air temperature measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_V_flow_y(unit="m3/s") = mod.hvac.floor3.reaZonEas.V_flow.y "Discharge air flowrate to zone measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_V_flow_set_y(unit="m3/s") = mod.hvac.floor3.reaZonEas.V_flow_set.y "Airflow setpointtop_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_yCoo_y(unit="1") = mod.hvac.floor3.reaZonEas.yCoo.y "Cooling PID signal measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_yDam_y(unit="1") = mod.hvac.floor3.reaZonEas.yDam.y "Damper position measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_yHea_y(unit="1") = mod.hvac.floor3.reaZonEas.yHea.y "Heating PID signal measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonEas_yReheaVal_y(unit="1") = mod.hvac.floor3.reaZonEas.yReheaVal.y "Reheat valve position measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_TRoo_Coo_set_y(unit="K") = mod.hvac.floor3.reaZonNor.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonetop_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_TRoo_Hea_set_y(unit="K") = mod.hvac.floor3.reaZonNor.TRoo_Hea_set.y "Zone temperature heating setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_TSup_y(unit="K") = mod.hvac.floor3.reaZonNor.TSup.y "Discharge air temperature to zone measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_TZon_y(unit="K") = mod.hvac.floor3.reaZonNor.TZon.y "Zone air temperature measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_V_flow_y(unit="m3/s") = mod.hvac.floor3.reaZonNor.V_flow.y "Discharge air flowrate to zone measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_V_flow_set_y(unit="m3/s") = mod.hvac.floor3.reaZonNor.V_flow_set.y "Airflow setpointtop_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_yCoo_y(unit="1") = mod.hvac.floor3.reaZonNor.yCoo.y "Cooling PID signal measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_yDam_y(unit="1") = mod.hvac.floor3.reaZonNor.yDam.y "Damper position measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_yHea_y(unit="1") = mod.hvac.floor3.reaZonNor.yHea.y "Heating PID signal measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonNor_yReheaVal_y(unit="1") = mod.hvac.floor3.reaZonNor.yReheaVal.y "Reheat valve position measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_TRoo_Coo_set_y(unit="K") = mod.hvac.floor3.reaZonSou.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonetop_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_TRoo_Hea_set_y(unit="K") = mod.hvac.floor3.reaZonSou.TRoo_Hea_set.y "Zone temperature heating setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_TSup_y(unit="K") = mod.hvac.floor3.reaZonSou.TSup.y "Discharge air temperature to zone measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_TZon_y(unit="K") = mod.hvac.floor3.reaZonSou.TZon.y "Zone air temperature measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_V_flow_y(unit="m3/s") = mod.hvac.floor3.reaZonSou.V_flow.y "Discharge air flowrate to zone measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_V_flow_set_y(unit="m3/s") = mod.hvac.floor3.reaZonSou.V_flow_set.y "Airflow setpointtop_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_yCoo_y(unit="1") = mod.hvac.floor3.reaZonSou.yCoo.y "Cooling PID signal measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_yDam_y(unit="1") = mod.hvac.floor3.reaZonSou.yDam.y "Damper position measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_yHea_y(unit="1") = mod.hvac.floor3.reaZonSou.yHea.y "Heating PID signal measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonSou_yReheaVal_y(unit="1") = mod.hvac.floor3.reaZonSou.yReheaVal.y "Reheat valve position measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_TRoo_Coo_set_y(unit="K") = mod.hvac.floor3.reaZonWes.TRoo_Coo_set.y "Zone temperature cooling setpoint for zonetop_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_TRoo_Hea_set_y(unit="K") = mod.hvac.floor3.reaZonWes.TRoo_Hea_set.y "Zone temperature heating setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_TSup_y(unit="K") = mod.hvac.floor3.reaZonWes.TSup.y "Discharge air temperature to zone measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_TZon_y(unit="K") = mod.hvac.floor3.reaZonWes.TZon.y "Zone air temperature measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_V_flow_y(unit="m3/s") = mod.hvac.floor3.reaZonWes.V_flow.y "Discharge air flowrate to zone measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_V_flow_set_y(unit="m3/s") = mod.hvac.floor3.reaZonWes.V_flow_set.y "Airflow setpointtop_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_yCoo_y(unit="1") = mod.hvac.floor3.reaZonWes.yCoo.y "Cooling PID signal measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_yDam_y(unit="1") = mod.hvac.floor3.reaZonWes.yDam.y "Damper position measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_yHea_y(unit="1") = mod.hvac.floor3.reaZonWes.yHea.y "Heating PID signal measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_reaZonWes_yReheaVal_y(unit="1") = mod.hvac.floor3.reaZonWes.yReheaVal.y "Reheat valve position measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_PFanTot_y(unit="W") = mod.hvac.floor3.readAhu.PFanTot.y "Total electrical power measurement of supply and return fans for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_TCooCoiRet_y(unit="K") = mod.hvac.floor3.readAhu.TCooCoiRet.y "Cooling coil return water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_TCooCoiSup_y(unit="K") = mod.hvac.floor3.readAhu.TCooCoiSup.y "Cooling coil supply water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_TMix_y(unit="K") = mod.hvac.floor3.readAhu.TMix.y "Mixed air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_TRet_y(unit="K") = mod.hvac.floor3.readAhu.TRet.y "Return air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_TSup_y(unit="K") = mod.hvac.floor3.readAhu.TSup.y "Supply air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_TSup_set_y(unit="K") = mod.hvac.floor3.readAhu.TSup_set.y "Supply air temperature setpoint measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_V_flow_OA_y(unit="m3/s") = mod.hvac.floor3.readAhu.V_flow_OA.y "Supply outdoor airflow rate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_V_flow_ret_y(unit="m3/s") = mod.hvac.floor3.readAhu.V_flow_ret.y "Return air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_V_flow_sup_y(unit="m3/s") = mod.hvac.floor3.readAhu.V_flow_sup.y "Supply air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_dp_sup_y(unit="Pa") = mod.hvac.floor3.readAhu.dp_sup.y "Discharge pressure of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_occ_y(unit="1") = mod.hvac.floor3.readAhu.occ.y "Occupancy status (1 occupied, 0 unoccupied)";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_yCooVal_y(unit="1") = mod.hvac.floor3.readAhu.yCooVal.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_readAhu_yOA_y(unit="1") = mod.hvac.floor3.readAhu.yOA.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaChiWatSys_TW_y(unit="K") = mod.hvac.reaChiWatSys.TW.y "Chilled water temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaChiWatSys_dp_y(unit="K") = mod.hvac.reaChiWatSys.dp.y "Differential pressure of chilled/hot water measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaChiWatSys_reaPChi_y(unit="W") = mod.hvac.reaChiWatSys.reaPChi.y "Multiple chiller power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaChiWatSys_reaPCooTow_y(unit="W") = mod.hvac.reaChiWatSys.reaPCooTow.y "Multiple cooling tower power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaChiWatSys_reaPPum_y(unit="W") = mod.hvac.reaChiWatSys.reaPPum.y "Chilled water plant pump power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaHotWatSys_TW_y(unit="K") = mod.hvac.reaHotWatSys.TW.y "Chilled water temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaHotWatSys_dp_y(unit="K") = mod.hvac.reaHotWatSys.dp.y "Differential pressure of chilled/hot water measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaHotWatSys_reaPBoi_y(unit="W") = mod.hvac.reaHotWatSys.reaPBoi.y "Multiple gas power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaHotWatSys_reaPPum_y(unit="W") = mod.hvac.reaHotWatSys.reaPPum.y "Chilled water plant pump power consumption";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaCeiHei_y(unit="m") = mod.loaEPlus.weatherStation.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaCloTim_y(unit="s") = mod.loaEPlus.weatherStation.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaHDifHor_y(unit="W/m2") = mod.loaEPlus.weatherStation.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaHDirNor_y(unit="W/m2") = mod.loaEPlus.weatherStation.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaHGloHor_y(unit="W/m2") = mod.loaEPlus.weatherStation.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaHHorIR_y(unit="W/m2") = mod.loaEPlus.weatherStation.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaLat_y(unit="rad") = mod.loaEPlus.weatherStation.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaLon_y(unit="rad") = mod.loaEPlus.weatherStation.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaNOpa_y(unit="1") = mod.loaEPlus.weatherStation.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaNTot_y(unit="1") = mod.loaEPlus.weatherStation.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaPAtm_y(unit="Pa") = mod.loaEPlus.weatherStation.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaRelHum_y(unit="1") = mod.loaEPlus.weatherStation.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaSolAlt_y(unit="rad") = mod.loaEPlus.weatherStation.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaSolDec_y(unit="rad") = mod.loaEPlus.weatherStation.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaSolHouAng_y(unit="rad") = mod.loaEPlus.weatherStation.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaSolTim_y(unit="s") = mod.loaEPlus.weatherStation.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaSolZen_y(unit="rad") = mod.loaEPlus.weatherStation.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaTBlaSky_y(unit="K") = mod.loaEPlus.weatherStation.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaTDewPoi_y(unit="K") = mod.loaEPlus.weatherStation.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaTDryBul_y(unit="K") = mod.loaEPlus.weatherStation.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaTWetBul_y(unit="K") = mod.loaEPlus.weatherStation.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaWinDir_y(unit="rad") = mod.loaEPlus.weatherStation.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput loaEPlus_weatherStation_reaWeaWinSpe_y(unit="m/s") = mod.loaEPlus.weatherStation.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_TSupAirSet_y(unit="K") = mod.hvac.floor1.TSupAirSet.y "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_dpSet_y(unit="Pa") = mod.hvac.floor1.dpSet.y "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_cooCoil_yCoo_y(unit="1") = mod.hvac.floor1.duaFanAirHanUnit.cooCoil.yCoo.y "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yEA_y(unit="1") = mod.hvac.floor1.duaFanAirHanUnit.mixingBox.mixBox.yEA.y "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yOA_y(unit="1") = mod.hvac.floor1.duaFanAirHanUnit.mixingBox.mixBox.yOA.y "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yRet_y(unit="1") = mod.hvac.floor1.duaFanAirHanUnit.mixingBox.mixBox.yRet.y "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_oveSpeRetFan_y(unit="1") = mod.hvac.floor1.duaFanAirHanUnit.oveSpeRetFan.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_supFan_oveSpeSupFan_y(unit="1") = mod.hvac.floor1.duaFanAirHanUnit.supFan.oveSpeSupFan.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV1.oveZonLoc.yDam.y "Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV1.oveZonLoc.yReaHea.y "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV2.oveZonLoc.yDam.y "Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV2.oveZonLoc.yReaHea.y "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV3.oveZonLoc.yDam.y "Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV3.oveZonLoc.yReaHea.y "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV4.oveZonLoc.yDam.y "Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV4.oveZonLoc.yReaHea.y "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV5.oveZonLoc.yDam.y "Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor1.fivZonVAV.vAV5.oveZonLoc.yReaHea.y "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonCor_TZonCooSet_y(unit="K") = mod.hvac.floor1.oveZonCor.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonCor_TZonHeaSet_y(unit="K") = mod.hvac.floor1.oveZonCor.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonEas_TZonCooSet_y(unit="K") = mod.hvac.floor1.oveZonEas.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonEas_TZonHeaSet_y(unit="K") = mod.hvac.floor1.oveZonEas.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonNor_TZonCooSet_y(unit="K") = mod.hvac.floor1.oveZonNor.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonNor_TZonHeaSet_y(unit="K") = mod.hvac.floor1.oveZonNor.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonSou_TZonCooSet_y(unit="K") = mod.hvac.floor1.oveZonSou.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonSou_TZonHeaSet_y(unit="K") = mod.hvac.floor1.oveZonSou.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonWes_TZonCooSet_y(unit="K") = mod.hvac.floor1.oveZonWes.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_oveZonWes_TZonHeaSet_y(unit="K") = mod.hvac.floor1.oveZonWes.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_TSupAirSet_y(unit="K") = mod.hvac.floor2.TSupAirSet.y "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_dpSet_y(unit="Pa") = mod.hvac.floor2.dpSet.y "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_cooCoil_yCoo_y(unit="1") = mod.hvac.floor2.duaFanAirHanUnit.cooCoil.yCoo.y "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yEA_y(unit="1") = mod.hvac.floor2.duaFanAirHanUnit.mixingBox.mixBox.yEA.y "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yOA_y(unit="1") = mod.hvac.floor2.duaFanAirHanUnit.mixingBox.mixBox.yOA.y "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yRet_y(unit="1") = mod.hvac.floor2.duaFanAirHanUnit.mixingBox.mixBox.yRet.y "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_oveSpeRetFan_y(unit="1") = mod.hvac.floor2.duaFanAirHanUnit.oveSpeRetFan.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_supFan_oveSpeSupFan_y(unit="1") = mod.hvac.floor2.duaFanAirHanUnit.supFan.oveSpeSupFan.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV1.oveZonLoc.yDam.y "Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV1.oveZonLoc.yReaHea.y "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV2.oveZonLoc.yDam.y "Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV2.oveZonLoc.yReaHea.y "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV3.oveZonLoc.yDam.y "Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV3.oveZonLoc.yReaHea.y "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV4.oveZonLoc.yDam.y "Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV4.oveZonLoc.yReaHea.y "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV5.oveZonLoc.yDam.y "Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor2.fivZonVAV.vAV5.oveZonLoc.yReaHea.y "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonCor_TZonCooSet_y(unit="K") = mod.hvac.floor2.oveZonCor.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonCor_TZonHeaSet_y(unit="K") = mod.hvac.floor2.oveZonCor.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonEas_TZonCooSet_y(unit="K") = mod.hvac.floor2.oveZonEas.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonEas_TZonHeaSet_y(unit="K") = mod.hvac.floor2.oveZonEas.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonNor_TZonCooSet_y(unit="K") = mod.hvac.floor2.oveZonNor.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonNor_TZonHeaSet_y(unit="K") = mod.hvac.floor2.oveZonNor.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonSou_TZonCooSet_y(unit="K") = mod.hvac.floor2.oveZonSou.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonSou_TZonHeaSet_y(unit="K") = mod.hvac.floor2.oveZonSou.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonWes_TZonCooSet_y(unit="K") = mod.hvac.floor2.oveZonWes.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_oveZonWes_TZonHeaSet_y(unit="K") = mod.hvac.floor2.oveZonWes.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_TSupAirSet_y(unit="K") = mod.hvac.floor3.TSupAirSet.y "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_dpSet_y(unit="Pa") = mod.hvac.floor3.dpSet.y "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_cooCoil_yCoo_y(unit="1") = mod.hvac.floor3.duaFanAirHanUnit.cooCoil.yCoo.y "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yEA_y(unit="1") = mod.hvac.floor3.duaFanAirHanUnit.mixingBox.mixBox.yEA.y "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yOA_y(unit="1") = mod.hvac.floor3.duaFanAirHanUnit.mixingBox.mixBox.yOA.y "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yRet_y(unit="1") = mod.hvac.floor3.duaFanAirHanUnit.mixingBox.mixBox.yRet.y "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_oveSpeRetFan_y(unit="1") = mod.hvac.floor3.duaFanAirHanUnit.oveSpeRetFan.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_supFan_oveSpeSupFan_y(unit="1") = mod.hvac.floor3.duaFanAirHanUnit.supFan.oveSpeSupFan.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV1.oveZonLoc.yDam.y "Damper position setpoint for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV1.oveZonLoc.yReaHea.y "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV2.oveZonLoc.yDam.y "Damper position setpoint for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV2.oveZonLoc.yReaHea.y "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV3.oveZonLoc.yDam.y "Damper position setpoint for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV3.oveZonLoc.yReaHea.y "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV4.oveZonLoc.yDam.y "Damper position setpoint for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV4.oveZonLoc.yReaHea.y "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yDam_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV5.oveZonLoc.yDam.y "Damper position setpoint for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_y(unit="1") = mod.hvac.floor3.fivZonVAV.vAV5.oveZonLoc.yReaHea.y "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonCor_TZonCooSet_y(unit="K") = mod.hvac.floor3.oveZonCor.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonCor_TZonHeaSet_y(unit="K") = mod.hvac.floor3.oveZonCor.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonEas_TZonCooSet_y(unit="K") = mod.hvac.floor3.oveZonEas.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonEas_TZonHeaSet_y(unit="K") = mod.hvac.floor3.oveZonEas.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonNor_TZonCooSet_y(unit="K") = mod.hvac.floor3.oveZonNor.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonNor_TZonHeaSet_y(unit="K") = mod.hvac.floor3.oveZonNor.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonSou_TZonCooSet_y(unit="K") = mod.hvac.floor3.oveZonSou.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonSou_TZonHeaSet_y(unit="K") = mod.hvac.floor3.oveZonSou.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonWes_TZonCooSet_y(unit="K") = mod.hvac.floor3.oveZonWes.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_oveZonWes_TZonHeaSet_y(unit="K") = mod.hvac.floor3.oveZonWes.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveChiWatSys_TW_set_y(unit="K") = mod.hvac.oveChiWatSys.TW_set.y "Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveChiWatSys_dp_set_y(unit="Pa") = mod.hvac.oveChiWatSys.dp_set.y "Differential pressure setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveHotWatSys_TW_set_y(unit="K") = mod.hvac.oveHotWatSys.TW_set.y "Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveHotWatSys_dp_set_y(unit="Pa") = mod.hvac.oveHotWatSys.dp_set.y "Differential pressure setpoint";
	// Original model
	MultizoneOfficeComplexAir.TestCases.TestCase mod(
		hvac.floor1.TSupAirSet(uExt(y=hvac_floor1_TSupAirSet_u),activate(y=hvac_floor1_TSupAirSet_activate)),
		hvac.floor1.dpSet(uExt(y=hvac_floor1_dpSet_u),activate(y=hvac_floor1_dpSet_activate)),
		hvac.floor1.duaFanAirHanUnit.cooCoil.yCoo(uExt(y=hvac_floor1_duaFanAirHanUnit_cooCoil_yCoo_u),activate(y=hvac_floor1_duaFanAirHanUnit_cooCoil_yCoo_activate)),
		hvac.floor1.duaFanAirHanUnit.mixingBox.mixBox.yEA(uExt(y=hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yEA_u),activate(y=hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yEA_activate)),
		hvac.floor1.duaFanAirHanUnit.mixingBox.mixBox.yOA(uExt(y=hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yOA_u),activate(y=hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yOA_activate)),
		hvac.floor1.duaFanAirHanUnit.mixingBox.mixBox.yRet(uExt(y=hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yRet_u),activate(y=hvac_floor1_duaFanAirHanUnit_mixingBox_mixBox_yRet_activate)),
		hvac.floor1.duaFanAirHanUnit.oveSpeRetFan(uExt(y=hvac_floor1_duaFanAirHanUnit_oveSpeRetFan_u),activate(y=hvac_floor1_duaFanAirHanUnit_oveSpeRetFan_activate)),
		hvac.floor1.duaFanAirHanUnit.supFan.oveSpeSupFan(uExt(y=hvac_floor1_duaFanAirHanUnit_supFan_oveSpeSupFan_u),activate(y=hvac_floor1_duaFanAirHanUnit_supFan_oveSpeSupFan_activate)),
		hvac.floor1.fivZonVAV.vAV1.oveZonLoc.yDam(uExt(y=hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_u),activate(y=hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_activate)),
		hvac.floor1.fivZonVAV.vAV1.oveZonLoc.yReaHea(uExt(y=hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_u),activate(y=hvac_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate)),
		hvac.floor1.fivZonVAV.vAV2.oveZonLoc.yDam(uExt(y=hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yDam_u),activate(y=hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yDam_activate)),
		hvac.floor1.fivZonVAV.vAV2.oveZonLoc.yReaHea(uExt(y=hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_u),activate(y=hvac_floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate)),
		hvac.floor1.fivZonVAV.vAV3.oveZonLoc.yDam(uExt(y=hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yDam_u),activate(y=hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yDam_activate)),
		hvac.floor1.fivZonVAV.vAV3.oveZonLoc.yReaHea(uExt(y=hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_u),activate(y=hvac_floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate)),
		hvac.floor1.fivZonVAV.vAV4.oveZonLoc.yDam(uExt(y=hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yDam_u),activate(y=hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yDam_activate)),
		hvac.floor1.fivZonVAV.vAV4.oveZonLoc.yReaHea(uExt(y=hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_u),activate(y=hvac_floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate)),
		hvac.floor1.fivZonVAV.vAV5.oveZonLoc.yDam(uExt(y=hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yDam_u),activate(y=hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yDam_activate)),
		hvac.floor1.fivZonVAV.vAV5.oveZonLoc.yReaHea(uExt(y=hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_u),activate(y=hvac_floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate)),
		hvac.floor1.oveZonCor.TZonCooSet(uExt(y=hvac_floor1_oveZonCor_TZonCooSet_u),activate(y=hvac_floor1_oveZonCor_TZonCooSet_activate)),
		hvac.floor1.oveZonCor.TZonHeaSet(uExt(y=hvac_floor1_oveZonCor_TZonHeaSet_u),activate(y=hvac_floor1_oveZonCor_TZonHeaSet_activate)),
		hvac.floor1.oveZonEas.TZonCooSet(uExt(y=hvac_floor1_oveZonEas_TZonCooSet_u),activate(y=hvac_floor1_oveZonEas_TZonCooSet_activate)),
		hvac.floor1.oveZonEas.TZonHeaSet(uExt(y=hvac_floor1_oveZonEas_TZonHeaSet_u),activate(y=hvac_floor1_oveZonEas_TZonHeaSet_activate)),
		hvac.floor1.oveZonNor.TZonCooSet(uExt(y=hvac_floor1_oveZonNor_TZonCooSet_u),activate(y=hvac_floor1_oveZonNor_TZonCooSet_activate)),
		hvac.floor1.oveZonNor.TZonHeaSet(uExt(y=hvac_floor1_oveZonNor_TZonHeaSet_u),activate(y=hvac_floor1_oveZonNor_TZonHeaSet_activate)),
		hvac.floor1.oveZonSou.TZonCooSet(uExt(y=hvac_floor1_oveZonSou_TZonCooSet_u),activate(y=hvac_floor1_oveZonSou_TZonCooSet_activate)),
		hvac.floor1.oveZonSou.TZonHeaSet(uExt(y=hvac_floor1_oveZonSou_TZonHeaSet_u),activate(y=hvac_floor1_oveZonSou_TZonHeaSet_activate)),
		hvac.floor1.oveZonWes.TZonCooSet(uExt(y=hvac_floor1_oveZonWes_TZonCooSet_u),activate(y=hvac_floor1_oveZonWes_TZonCooSet_activate)),
		hvac.floor1.oveZonWes.TZonHeaSet(uExt(y=hvac_floor1_oveZonWes_TZonHeaSet_u),activate(y=hvac_floor1_oveZonWes_TZonHeaSet_activate)),
		hvac.floor2.TSupAirSet(uExt(y=hvac_floor2_TSupAirSet_u),activate(y=hvac_floor2_TSupAirSet_activate)),
		hvac.floor2.dpSet(uExt(y=hvac_floor2_dpSet_u),activate(y=hvac_floor2_dpSet_activate)),
		hvac.floor2.duaFanAirHanUnit.cooCoil.yCoo(uExt(y=hvac_floor2_duaFanAirHanUnit_cooCoil_yCoo_u),activate(y=hvac_floor2_duaFanAirHanUnit_cooCoil_yCoo_activate)),
		hvac.floor2.duaFanAirHanUnit.mixingBox.mixBox.yEA(uExt(y=hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yEA_u),activate(y=hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yEA_activate)),
		hvac.floor2.duaFanAirHanUnit.mixingBox.mixBox.yOA(uExt(y=hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yOA_u),activate(y=hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yOA_activate)),
		hvac.floor2.duaFanAirHanUnit.mixingBox.mixBox.yRet(uExt(y=hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yRet_u),activate(y=hvac_floor2_duaFanAirHanUnit_mixingBox_mixBox_yRet_activate)),
		hvac.floor2.duaFanAirHanUnit.oveSpeRetFan(uExt(y=hvac_floor2_duaFanAirHanUnit_oveSpeRetFan_u),activate(y=hvac_floor2_duaFanAirHanUnit_oveSpeRetFan_activate)),
		hvac.floor2.duaFanAirHanUnit.supFan.oveSpeSupFan(uExt(y=hvac_floor2_duaFanAirHanUnit_supFan_oveSpeSupFan_u),activate(y=hvac_floor2_duaFanAirHanUnit_supFan_oveSpeSupFan_activate)),
		hvac.floor2.fivZonVAV.vAV1.oveZonLoc.yDam(uExt(y=hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yDam_u),activate(y=hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yDam_activate)),
		hvac.floor2.fivZonVAV.vAV1.oveZonLoc.yReaHea(uExt(y=hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_u),activate(y=hvac_floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate)),
		hvac.floor2.fivZonVAV.vAV2.oveZonLoc.yDam(uExt(y=hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yDam_u),activate(y=hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yDam_activate)),
		hvac.floor2.fivZonVAV.vAV2.oveZonLoc.yReaHea(uExt(y=hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_u),activate(y=hvac_floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate)),
		hvac.floor2.fivZonVAV.vAV3.oveZonLoc.yDam(uExt(y=hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yDam_u),activate(y=hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yDam_activate)),
		hvac.floor2.fivZonVAV.vAV3.oveZonLoc.yReaHea(uExt(y=hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_u),activate(y=hvac_floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate)),
		hvac.floor2.fivZonVAV.vAV4.oveZonLoc.yDam(uExt(y=hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yDam_u),activate(y=hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yDam_activate)),
		hvac.floor2.fivZonVAV.vAV4.oveZonLoc.yReaHea(uExt(y=hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_u),activate(y=hvac_floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate)),
		hvac.floor2.fivZonVAV.vAV5.oveZonLoc.yDam(uExt(y=hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yDam_u),activate(y=hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yDam_activate)),
		hvac.floor2.fivZonVAV.vAV5.oveZonLoc.yReaHea(uExt(y=hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_u),activate(y=hvac_floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate)),
		hvac.floor2.oveZonCor.TZonCooSet(uExt(y=hvac_floor2_oveZonCor_TZonCooSet_u),activate(y=hvac_floor2_oveZonCor_TZonCooSet_activate)),
		hvac.floor2.oveZonCor.TZonHeaSet(uExt(y=hvac_floor2_oveZonCor_TZonHeaSet_u),activate(y=hvac_floor2_oveZonCor_TZonHeaSet_activate)),
		hvac.floor2.oveZonEas.TZonCooSet(uExt(y=hvac_floor2_oveZonEas_TZonCooSet_u),activate(y=hvac_floor2_oveZonEas_TZonCooSet_activate)),
		hvac.floor2.oveZonEas.TZonHeaSet(uExt(y=hvac_floor2_oveZonEas_TZonHeaSet_u),activate(y=hvac_floor2_oveZonEas_TZonHeaSet_activate)),
		hvac.floor2.oveZonNor.TZonCooSet(uExt(y=hvac_floor2_oveZonNor_TZonCooSet_u),activate(y=hvac_floor2_oveZonNor_TZonCooSet_activate)),
		hvac.floor2.oveZonNor.TZonHeaSet(uExt(y=hvac_floor2_oveZonNor_TZonHeaSet_u),activate(y=hvac_floor2_oveZonNor_TZonHeaSet_activate)),
		hvac.floor2.oveZonSou.TZonCooSet(uExt(y=hvac_floor2_oveZonSou_TZonCooSet_u),activate(y=hvac_floor2_oveZonSou_TZonCooSet_activate)),
		hvac.floor2.oveZonSou.TZonHeaSet(uExt(y=hvac_floor2_oveZonSou_TZonHeaSet_u),activate(y=hvac_floor2_oveZonSou_TZonHeaSet_activate)),
		hvac.floor2.oveZonWes.TZonCooSet(uExt(y=hvac_floor2_oveZonWes_TZonCooSet_u),activate(y=hvac_floor2_oveZonWes_TZonCooSet_activate)),
		hvac.floor2.oveZonWes.TZonHeaSet(uExt(y=hvac_floor2_oveZonWes_TZonHeaSet_u),activate(y=hvac_floor2_oveZonWes_TZonHeaSet_activate)),
		hvac.floor3.TSupAirSet(uExt(y=hvac_floor3_TSupAirSet_u),activate(y=hvac_floor3_TSupAirSet_activate)),
		hvac.floor3.dpSet(uExt(y=hvac_floor3_dpSet_u),activate(y=hvac_floor3_dpSet_activate)),
		hvac.floor3.duaFanAirHanUnit.cooCoil.yCoo(uExt(y=hvac_floor3_duaFanAirHanUnit_cooCoil_yCoo_u),activate(y=hvac_floor3_duaFanAirHanUnit_cooCoil_yCoo_activate)),
		hvac.floor3.duaFanAirHanUnit.mixingBox.mixBox.yEA(uExt(y=hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yEA_u),activate(y=hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yEA_activate)),
		hvac.floor3.duaFanAirHanUnit.mixingBox.mixBox.yOA(uExt(y=hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yOA_u),activate(y=hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yOA_activate)),
		hvac.floor3.duaFanAirHanUnit.mixingBox.mixBox.yRet(uExt(y=hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yRet_u),activate(y=hvac_floor3_duaFanAirHanUnit_mixingBox_mixBox_yRet_activate)),
		hvac.floor3.duaFanAirHanUnit.oveSpeRetFan(uExt(y=hvac_floor3_duaFanAirHanUnit_oveSpeRetFan_u),activate(y=hvac_floor3_duaFanAirHanUnit_oveSpeRetFan_activate)),
		hvac.floor3.duaFanAirHanUnit.supFan.oveSpeSupFan(uExt(y=hvac_floor3_duaFanAirHanUnit_supFan_oveSpeSupFan_u),activate(y=hvac_floor3_duaFanAirHanUnit_supFan_oveSpeSupFan_activate)),
		hvac.floor3.fivZonVAV.vAV1.oveZonLoc.yDam(uExt(y=hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yDam_u),activate(y=hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yDam_activate)),
		hvac.floor3.fivZonVAV.vAV1.oveZonLoc.yReaHea(uExt(y=hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_u),activate(y=hvac_floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate)),
		hvac.floor3.fivZonVAV.vAV2.oveZonLoc.yDam(uExt(y=hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yDam_u),activate(y=hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yDam_activate)),
		hvac.floor3.fivZonVAV.vAV2.oveZonLoc.yReaHea(uExt(y=hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_u),activate(y=hvac_floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate)),
		hvac.floor3.fivZonVAV.vAV3.oveZonLoc.yDam(uExt(y=hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yDam_u),activate(y=hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yDam_activate)),
		hvac.floor3.fivZonVAV.vAV3.oveZonLoc.yReaHea(uExt(y=hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_u),activate(y=hvac_floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate)),
		hvac.floor3.fivZonVAV.vAV4.oveZonLoc.yDam(uExt(y=hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yDam_u),activate(y=hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yDam_activate)),
		hvac.floor3.fivZonVAV.vAV4.oveZonLoc.yReaHea(uExt(y=hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_u),activate(y=hvac_floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate)),
		hvac.floor3.fivZonVAV.vAV5.oveZonLoc.yDam(uExt(y=hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yDam_u),activate(y=hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yDam_activate)),
		hvac.floor3.fivZonVAV.vAV5.oveZonLoc.yReaHea(uExt(y=hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_u),activate(y=hvac_floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate)),
		hvac.floor3.oveZonCor.TZonCooSet(uExt(y=hvac_floor3_oveZonCor_TZonCooSet_u),activate(y=hvac_floor3_oveZonCor_TZonCooSet_activate)),
		hvac.floor3.oveZonCor.TZonHeaSet(uExt(y=hvac_floor3_oveZonCor_TZonHeaSet_u),activate(y=hvac_floor3_oveZonCor_TZonHeaSet_activate)),
		hvac.floor3.oveZonEas.TZonCooSet(uExt(y=hvac_floor3_oveZonEas_TZonCooSet_u),activate(y=hvac_floor3_oveZonEas_TZonCooSet_activate)),
		hvac.floor3.oveZonEas.TZonHeaSet(uExt(y=hvac_floor3_oveZonEas_TZonHeaSet_u),activate(y=hvac_floor3_oveZonEas_TZonHeaSet_activate)),
		hvac.floor3.oveZonNor.TZonCooSet(uExt(y=hvac_floor3_oveZonNor_TZonCooSet_u),activate(y=hvac_floor3_oveZonNor_TZonCooSet_activate)),
		hvac.floor3.oveZonNor.TZonHeaSet(uExt(y=hvac_floor3_oveZonNor_TZonHeaSet_u),activate(y=hvac_floor3_oveZonNor_TZonHeaSet_activate)),
		hvac.floor3.oveZonSou.TZonCooSet(uExt(y=hvac_floor3_oveZonSou_TZonCooSet_u),activate(y=hvac_floor3_oveZonSou_TZonCooSet_activate)),
		hvac.floor3.oveZonSou.TZonHeaSet(uExt(y=hvac_floor3_oveZonSou_TZonHeaSet_u),activate(y=hvac_floor3_oveZonSou_TZonHeaSet_activate)),
		hvac.floor3.oveZonWes.TZonCooSet(uExt(y=hvac_floor3_oveZonWes_TZonCooSet_u),activate(y=hvac_floor3_oveZonWes_TZonCooSet_activate)),
		hvac.floor3.oveZonWes.TZonHeaSet(uExt(y=hvac_floor3_oveZonWes_TZonHeaSet_u),activate(y=hvac_floor3_oveZonWes_TZonHeaSet_activate)),
		hvac.oveChiWatSys.TW_set(uExt(y=hvac_oveChiWatSys_TW_set_u),activate(y=hvac_oveChiWatSys_TW_set_activate)),
		hvac.oveChiWatSys.dp_set(uExt(y=hvac_oveChiWatSys_dp_set_u),activate(y=hvac_oveChiWatSys_dp_set_activate)),
		hvac.oveHotWatSys.TW_set(uExt(y=hvac_oveHotWatSys_TW_set_u),activate(y=hvac_oveHotWatSys_TW_set_activate)),
		hvac.oveHotWatSys.dp_set(uExt(y=hvac_oveHotWatSys_dp_set_u),activate(y=hvac_oveHotWatSys_dp_set_activate))) "Original model with overwrites";
end wrapped;
