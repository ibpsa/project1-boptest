model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput floor1_duaFanAirHanUni_supFan_oveSpeSupFan_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput floor1_duaFanAirHanUni_supFan_oveSpeSupFan_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput floor1_duaFanAirHanUni_cooCoi_yCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor1_duaFanAirHanUni_cooCoi_yCoo_activate "Activation for Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput floor1_duaFanAirHanUni_mixingBox_mixBox_yOA_u(unit="1", min=0.0, max=1.0) "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor1_duaFanAirHanUni_mixingBox_mixBox_yOA_activate "Activation for Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor1_duaFanAirHanUni_mixingBox_mixBox_yRet_u(unit="1", min=0.0, max=1.0) "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor1_duaFanAirHanUni_mixingBox_mixBox_yRet_activate "Activation for Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor1_duaFanAirHanUni_mixingBox_mixBox_yEA_u(unit="1", min=0.0, max=1.0) "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor1_duaFanAirHanUni_mixingBox_mixBox_yEA_activate "Activation for Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor1_duaFanAirHanUni_oveSpeRetFan_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput floor1_duaFanAirHanUni_oveSpeRetFan_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput floor1_duaFanAirHanUni_frePro_oveFrePro_u(unit="1", min=0.0, max=1.0) "Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.BooleanInput floor1_duaFanAirHanUni_frePro_oveFrePro_activate "Activation for Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV1_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV1_oveZonLoc_yDam_activate "Activation for Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV2_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV2_oveZonLoc_yDam_activate "Activation for Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV3_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV3_oveZonLoc_yDam_activate "Activation for Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV4_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV4_oveZonLoc_yDam_activate "Activation for Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV5_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV5_oveZonLoc_yDam_activate "Activation for Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput floor1_TSupAirSet_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor1_TSupAirSet_activate "Activation for Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor1_dpSet_u(unit="Pa", min=50.0, max=410.0) "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor1_dpSet_activate "Activation for Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonCor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonCor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonCor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonCor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonSou_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonSou_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonSou_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonSou_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonEas_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonEas_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonEas_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonEas_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonNor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonNor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonNor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonNor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonWes_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonWes_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealInput floor1_oveZonWes_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput floor1_oveZonWes_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealInput floor2_duaFanAirHanUni_supFan_oveSpeSupFan_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput floor2_duaFanAirHanUni_supFan_oveSpeSupFan_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput floor2_duaFanAirHanUni_cooCoi_yCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor2_duaFanAirHanUni_cooCoi_yCoo_activate "Activation for Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput floor2_duaFanAirHanUni_mixingBox_mixBox_yOA_u(unit="1", min=0.0, max=1.0) "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor2_duaFanAirHanUni_mixingBox_mixBox_yOA_activate "Activation for Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor2_duaFanAirHanUni_mixingBox_mixBox_yRet_u(unit="1", min=0.0, max=1.0) "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor2_duaFanAirHanUni_mixingBox_mixBox_yRet_activate "Activation for Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor2_duaFanAirHanUni_mixingBox_mixBox_yEA_u(unit="1", min=0.0, max=1.0) "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor2_duaFanAirHanUni_mixingBox_mixBox_yEA_activate "Activation for Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor2_duaFanAirHanUni_oveSpeRetFan_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput floor2_duaFanAirHanUni_oveSpeRetFan_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput floor2_duaFanAirHanUni_frePro_oveFrePro_u(unit="1", min=0.0, max=1.0) "Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.BooleanInput floor2_duaFanAirHanUni_frePro_oveFrePro_activate "Activation for Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV1_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV1_oveZonLoc_yDam_activate "Activation for Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV2_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV2_oveZonLoc_yDam_activate "Activation for Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV3_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV3_oveZonLoc_yDam_activate "Activation for Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV4_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV4_oveZonLoc_yDam_activate "Activation for Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV5_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV5_oveZonLoc_yDam_activate "Activation for Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput floor2_TSupAirSet_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor2_TSupAirSet_activate "Activation for Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor2_dpSet_u(unit="Pa", min=50.0, max=410.0) "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor2_dpSet_activate "Activation for Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonCor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonCor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonCor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonCor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonSou_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonSou_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonSou_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonSou_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonEas_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonEas_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonEas_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonEas_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonNor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonNor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonNor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonNor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonWes_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonWes_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealInput floor2_oveZonWes_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput floor2_oveZonWes_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealInput floor3_duaFanAirHanUni_supFan_oveSpeSupFan_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput floor3_duaFanAirHanUni_supFan_oveSpeSupFan_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput floor3_duaFanAirHanUni_cooCoi_yCoo_u(unit="1", min=0.0, max=1.0) "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor3_duaFanAirHanUni_cooCoi_yCoo_activate "Activation for Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealInput floor3_duaFanAirHanUni_mixingBox_mixBox_yOA_u(unit="1", min=0.0, max=1.0) "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor3_duaFanAirHanUni_mixingBox_mixBox_yOA_activate "Activation for Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor3_duaFanAirHanUni_mixingBox_mixBox_yRet_u(unit="1", min=0.0, max=1.0) "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor3_duaFanAirHanUni_mixingBox_mixBox_yRet_activate "Activation for Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor3_duaFanAirHanUni_mixingBox_mixBox_yEA_u(unit="1", min=0.0, max=1.0) "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor3_duaFanAirHanUni_mixingBox_mixBox_yEA_activate "Activation for Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor3_duaFanAirHanUni_oveSpeRetFan_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput floor3_duaFanAirHanUni_oveSpeRetFan_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput floor3_duaFanAirHanUni_frePro_oveFrePro_u(unit="1", min=0.0, max=1.0) "Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.BooleanInput floor3_duaFanAirHanUni_frePro_oveFrePro_activate "Activation for Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV1_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV1_oveZonLoc_yDam_activate "Activation for Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV2_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV2_oveZonLoc_yDam_activate "Activation for Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV3_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV3_oveZonLoc_yDam_activate "Activation for Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV4_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV4_oveZonLoc_yDam_activate "Activation for Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV5_oveZonLoc_yDam_u(unit="1", min=0.0, max=1.0) "Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV5_oveZonLoc_yDam_activate "Activation for Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_u(unit="1", min=0.0, max=1.0) "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.BooleanInput floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate "Activation for Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealInput floor3_TSupAirSet_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor3_TSupAirSet_activate "Activation for Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor3_dpSet_u(unit="Pa", min=50.0, max=410.0) "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.BooleanInput floor3_dpSet_activate "Activation for Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonCor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonCor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonCor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonCor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonSou_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonSou_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonSou_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonSou_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonEas_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonEas_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonEas_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonEas_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonNor_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonNor_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonNor_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonNor_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonWes_TZonHeaSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature heating setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonWes_TZonHeaSet_activate "Activation for Zone air temperature heating setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealInput floor3_oveZonWes_TZonCooSet_u(unit="K", min=285.15, max=313.15) "Zone air temperature cooling setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.BooleanInput floor3_oveZonWes_TZonCooSet_activate "Activation for Zone air temperature cooling setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealInput oveChiWatSys_TWSet_u(unit="K", min=278.15, max=288.15) "Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveChiWatSys_TWSet_activate "Activation for Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.RealInput oveChiWatSys_dpSet_u(unit="Pa", min=0.0, max=19130000.0) "Differential pressure setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveChiWatSys_dpSet_activate "Activation for Differential pressure setpoint";
	Modelica.Blocks.Interfaces.RealInput oveHotWatSys_TWSet_u(unit="K", min=291.15, max=353.15) "Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveHotWatSys_TWSet_activate "Activation for Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.RealInput oveHotWatSys_dpSet_u(unit="Pa", min=0.0, max=19130000.0) "Differential pressure setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveHotWatSys_dpSet_activate "Activation for Differential pressure setpoint";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_TSup_y(unit="K") = mod.floor1.reaAHU.TSup.y "Supply air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_TMix_y(unit="K") = mod.floor1.reaAHU.TMix.y "Mixed air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_TRet_y(unit="K") = mod.floor1.reaAHU.TRet.y "Return air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_V_flowSup_y(unit="m3/s") = mod.floor1.reaAHU.V_flowSup.y "Supply air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_V_flowRet_y(unit="m3/s") = mod.floor1.reaAHU.V_flowRet.y "Return air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_dp_y(unit="Pa") = mod.floor1.reaAHU.dp.y "Static pressure of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_PFanRet_y(unit="W") = mod.floor1.reaAHU.PFanRet.y "Electrical power measurement of return fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_TCooCoiSup_y(unit="K") = mod.floor1.reaAHU.TCooCoiSup.y "Cooling coil supply water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_TCooCoiRet_y(unit="K") = mod.floor1.reaAHU.TCooCoiRet.y "Cooling coil return water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_yCooVal_y(unit="1") = mod.floor1.reaAHU.yCooVal.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_occ_y(unit="1") = mod.floor1.reaAHU.occ.y "Occupancy status (1 occupied, 0 unoccupied)";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_yOA_y(unit="1") = mod.floor1.reaAHU.yOA.y "AHU OA damper position measurement";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_V_flowOA_y(unit="m3/s") = mod.floor1.reaAHU.V_flowOA.y "Supply outdoor airflow rate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_CO2_AHUSup_y(unit="ppm") = mod.floor1.reaAHU.CO2_AHUSup.y "Supply air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_CO2_AHUFre_y(unit="ppm") = mod.floor1.reaAHU.CO2_AHUFre.y "Fresh air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_CO2_AHURet_y(unit="ppm") = mod.floor1.reaAHU.CO2_AHURet.y "Return air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_phiAHUSup_y(unit="1") = mod.floor1.reaAHU.phiAHUSup.y "Supply air relative humidity for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_phiAHURet_y(unit="1") = mod.floor1.reaAHU.phiAHURet.y "Return air relative humidity for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_PFanSup_y(unit="W") = mod.floor1.reaAHU.PFanSup.y "Electrical power measurement of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_PFreCoi_y(unit="W") = mod.floor1.reaAHU.PFreCoi.y "Electrical power measurement of freeze protection coil for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaAHU_TFreCoiLea_y(unit="K") = mod.floor1.reaAHU.TFreCoiLea.y "Temperature of air leaving freeze protection coil";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonCor_TZon_y(unit="K") = mod.floor1.reaZonCor.TZon.y "Zone air temperature measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonCor_TSup_y(unit="K") = mod.floor1.reaZonCor.TSup.y "Discharge air temperature measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonCor_V_flow_y(unit="m3/s") = mod.floor1.reaZonCor.V_flow.y "Air flowrate measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonCor_yReheaVal_y(unit="1") = mod.floor1.reaZonCor.yReheaVal.y "Reheat valve position measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonCor_yDam_y(unit="1") = mod.floor1.reaZonCor.yDam.y "Damper position measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonCor_V_flowSet_y(unit="m3/s") = mod.floor1.reaZonCor.V_flowSet.y "Zone airflow setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonCor_CO2Zon_y(unit="ppm") = mod.floor1.reaZonCor.CO2Zon.y "Zone air CO2 measurement for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonSou_TZon_y(unit="K") = mod.floor1.reaZonSou.TZon.y "Zone air temperature measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonSou_TSup_y(unit="K") = mod.floor1.reaZonSou.TSup.y "Discharge air temperature measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonSou_V_flow_y(unit="m3/s") = mod.floor1.reaZonSou.V_flow.y "Air flowrate measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonSou_yReheaVal_y(unit="1") = mod.floor1.reaZonSou.yReheaVal.y "Reheat valve position measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonSou_yDam_y(unit="1") = mod.floor1.reaZonSou.yDam.y "Damper position measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonSou_V_flowSet_y(unit="m3/s") = mod.floor1.reaZonSou.V_flowSet.y "Zone airflow setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonSou_CO2Zon_y(unit="ppm") = mod.floor1.reaZonSou.CO2Zon.y "Zone air CO2 measurement for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonEas_TZon_y(unit="K") = mod.floor1.reaZonEas.TZon.y "Zone air temperature measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonEas_TSup_y(unit="K") = mod.floor1.reaZonEas.TSup.y "Discharge air temperature measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonEas_V_flow_y(unit="m3/s") = mod.floor1.reaZonEas.V_flow.y "Air flowrate measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonEas_yReheaVal_y(unit="1") = mod.floor1.reaZonEas.yReheaVal.y "Reheat valve position measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonEas_yDam_y(unit="1") = mod.floor1.reaZonEas.yDam.y "Damper position measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonEas_V_flowSet_y(unit="m3/s") = mod.floor1.reaZonEas.V_flowSet.y "Zone airflow setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonEas_CO2Zon_y(unit="ppm") = mod.floor1.reaZonEas.CO2Zon.y "Zone air CO2 measurement for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonNor_TZon_y(unit="K") = mod.floor1.reaZonNor.TZon.y "Zone air temperature measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonNor_TSup_y(unit="K") = mod.floor1.reaZonNor.TSup.y "Discharge air temperature measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonNor_V_flow_y(unit="m3/s") = mod.floor1.reaZonNor.V_flow.y "Air flowrate measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonNor_yReheaVal_y(unit="1") = mod.floor1.reaZonNor.yReheaVal.y "Reheat valve position measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonNor_yDam_y(unit="1") = mod.floor1.reaZonNor.yDam.y "Damper position measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonNor_V_flowSet_y(unit="m3/s") = mod.floor1.reaZonNor.V_flowSet.y "Zone airflow setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonNor_CO2Zon_y(unit="ppm") = mod.floor1.reaZonNor.CO2Zon.y "Zone air CO2 measurement for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonWes_TZon_y(unit="K") = mod.floor1.reaZonWes.TZon.y "Zone air temperature measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonWes_TSup_y(unit="K") = mod.floor1.reaZonWes.TSup.y "Discharge air temperature measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonWes_V_flow_y(unit="m3/s") = mod.floor1.reaZonWes.V_flow.y "Air flowrate measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonWes_yReheaVal_y(unit="1") = mod.floor1.reaZonWes.yReheaVal.y "Reheat valve position measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonWes_yDam_y(unit="1") = mod.floor1.reaZonWes.yDam.y "Damper position measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonWes_V_flowSet_y(unit="m3/s") = mod.floor1.reaZonWes.V_flowSet.y "Zone airflow setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_reaZonWes_CO2Zon_y(unit="ppm") = mod.floor1.reaZonWes.CO2Zon.y "Zone air CO2 measurement for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_TSup_y(unit="K") = mod.floor2.reaAHU.TSup.y "Supply air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_TMix_y(unit="K") = mod.floor2.reaAHU.TMix.y "Mixed air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_TRet_y(unit="K") = mod.floor2.reaAHU.TRet.y "Return air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_V_flowSup_y(unit="m3/s") = mod.floor2.reaAHU.V_flowSup.y "Supply air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_V_flowRet_y(unit="m3/s") = mod.floor2.reaAHU.V_flowRet.y "Return air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_dp_y(unit="Pa") = mod.floor2.reaAHU.dp.y "Static pressure of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_PFanRet_y(unit="W") = mod.floor2.reaAHU.PFanRet.y "Electrical power measurement of return fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_TCooCoiSup_y(unit="K") = mod.floor2.reaAHU.TCooCoiSup.y "Cooling coil supply water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_TCooCoiRet_y(unit="K") = mod.floor2.reaAHU.TCooCoiRet.y "Cooling coil return water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_yCooVal_y(unit="1") = mod.floor2.reaAHU.yCooVal.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_occ_y(unit="1") = mod.floor2.reaAHU.occ.y "Occupancy status (1 occupied, 0 unoccupied)";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_yOA_y(unit="1") = mod.floor2.reaAHU.yOA.y "AHU OA damper position measurement";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_V_flowOA_y(unit="m3/s") = mod.floor2.reaAHU.V_flowOA.y "Supply outdoor airflow rate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_CO2_AHUSup_y(unit="ppm") = mod.floor2.reaAHU.CO2_AHUSup.y "Supply air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_CO2_AHUFre_y(unit="ppm") = mod.floor2.reaAHU.CO2_AHUFre.y "Fresh air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_CO2_AHURet_y(unit="ppm") = mod.floor2.reaAHU.CO2_AHURet.y "Return air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_phiAHUSup_y(unit="1") = mod.floor2.reaAHU.phiAHUSup.y "Supply air relative humidity for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_phiAHURet_y(unit="1") = mod.floor2.reaAHU.phiAHURet.y "Return air relative humidity for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_PFanSup_y(unit="W") = mod.floor2.reaAHU.PFanSup.y "Electrical power measurement of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_PFreCoi_y(unit="W") = mod.floor2.reaAHU.PFreCoi.y "Electrical power measurement of freeze protection coil for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaAHU_TFreCoiLea_y(unit="K") = mod.floor2.reaAHU.TFreCoiLea.y "Temperature of air leaving freeze protection coil";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonCor_TZon_y(unit="K") = mod.floor2.reaZonCor.TZon.y "Zone air temperature measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonCor_TSup_y(unit="K") = mod.floor2.reaZonCor.TSup.y "Discharge air temperature measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonCor_V_flow_y(unit="m3/s") = mod.floor2.reaZonCor.V_flow.y "Air flowrate measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonCor_yReheaVal_y(unit="1") = mod.floor2.reaZonCor.yReheaVal.y "Reheat valve position measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonCor_yDam_y(unit="1") = mod.floor2.reaZonCor.yDam.y "Damper position measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonCor_V_flowSet_y(unit="m3/s") = mod.floor2.reaZonCor.V_flowSet.y "Zone airflow setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonCor_CO2Zon_y(unit="ppm") = mod.floor2.reaZonCor.CO2Zon.y "Zone air CO2 measurement for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonSou_TZon_y(unit="K") = mod.floor2.reaZonSou.TZon.y "Zone air temperature measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonSou_TSup_y(unit="K") = mod.floor2.reaZonSou.TSup.y "Discharge air temperature measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonSou_V_flow_y(unit="m3/s") = mod.floor2.reaZonSou.V_flow.y "Air flowrate measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonSou_yReheaVal_y(unit="1") = mod.floor2.reaZonSou.yReheaVal.y "Reheat valve position measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonSou_yDam_y(unit="1") = mod.floor2.reaZonSou.yDam.y "Damper position measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonSou_V_flowSet_y(unit="m3/s") = mod.floor2.reaZonSou.V_flowSet.y "Zone airflow setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonSou_CO2Zon_y(unit="ppm") = mod.floor2.reaZonSou.CO2Zon.y "Zone air CO2 measurement for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonEas_TZon_y(unit="K") = mod.floor2.reaZonEas.TZon.y "Zone air temperature measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonEas_TSup_y(unit="K") = mod.floor2.reaZonEas.TSup.y "Discharge air temperature measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonEas_V_flow_y(unit="m3/s") = mod.floor2.reaZonEas.V_flow.y "Air flowrate measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonEas_yReheaVal_y(unit="1") = mod.floor2.reaZonEas.yReheaVal.y "Reheat valve position measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonEas_yDam_y(unit="1") = mod.floor2.reaZonEas.yDam.y "Damper position measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonEas_V_flowSet_y(unit="m3/s") = mod.floor2.reaZonEas.V_flowSet.y "Zone airflow setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonEas_CO2Zon_y(unit="ppm") = mod.floor2.reaZonEas.CO2Zon.y "Zone air CO2 measurement for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonNor_TZon_y(unit="K") = mod.floor2.reaZonNor.TZon.y "Zone air temperature measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonNor_TSup_y(unit="K") = mod.floor2.reaZonNor.TSup.y "Discharge air temperature measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonNor_V_flow_y(unit="m3/s") = mod.floor2.reaZonNor.V_flow.y "Air flowrate measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonNor_yReheaVal_y(unit="1") = mod.floor2.reaZonNor.yReheaVal.y "Reheat valve position measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonNor_yDam_y(unit="1") = mod.floor2.reaZonNor.yDam.y "Damper position measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonNor_V_flowSet_y(unit="m3/s") = mod.floor2.reaZonNor.V_flowSet.y "Zone airflow setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonNor_CO2Zon_y(unit="ppm") = mod.floor2.reaZonNor.CO2Zon.y "Zone air CO2 measurement for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonWes_TZon_y(unit="K") = mod.floor2.reaZonWes.TZon.y "Zone air temperature measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonWes_TSup_y(unit="K") = mod.floor2.reaZonWes.TSup.y "Discharge air temperature measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonWes_V_flow_y(unit="m3/s") = mod.floor2.reaZonWes.V_flow.y "Air flowrate measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonWes_yReheaVal_y(unit="1") = mod.floor2.reaZonWes.yReheaVal.y "Reheat valve position measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonWes_yDam_y(unit="1") = mod.floor2.reaZonWes.yDam.y "Damper position measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonWes_V_flowSet_y(unit="m3/s") = mod.floor2.reaZonWes.V_flowSet.y "Zone airflow setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_reaZonWes_CO2Zon_y(unit="ppm") = mod.floor2.reaZonWes.CO2Zon.y "Zone air CO2 measurement for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_TSup_y(unit="K") = mod.floor3.reaAHU.TSup.y "Supply air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_TMix_y(unit="K") = mod.floor3.reaAHU.TMix.y "Mixed air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_TRet_y(unit="K") = mod.floor3.reaAHU.TRet.y "Return air temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_V_flowSup_y(unit="m3/s") = mod.floor3.reaAHU.V_flowSup.y "Supply air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_V_flowRet_y(unit="m3/s") = mod.floor3.reaAHU.V_flowRet.y "Return air flowrate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_dp_y(unit="Pa") = mod.floor3.reaAHU.dp.y "Static pressure of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_PFanRet_y(unit="W") = mod.floor3.reaAHU.PFanRet.y "Electrical power measurement of return fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_TCooCoiSup_y(unit="K") = mod.floor3.reaAHU.TCooCoiSup.y "Cooling coil supply water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_TCooCoiRet_y(unit="K") = mod.floor3.reaAHU.TCooCoiRet.y "Cooling coil return water temperature measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_yCooVal_y(unit="1") = mod.floor3.reaAHU.yCooVal.y "AHU cooling coil valve position measurement";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_occ_y(unit="1") = mod.floor3.reaAHU.occ.y "Occupancy status (1 occupied, 0 unoccupied)";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_yOA_y(unit="1") = mod.floor3.reaAHU.yOA.y "AHU OA damper position measurement";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_V_flowOA_y(unit="m3/s") = mod.floor3.reaAHU.V_flowOA.y "Supply outdoor airflow rate measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_CO2_AHUSup_y(unit="ppm") = mod.floor3.reaAHU.CO2_AHUSup.y "Supply air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_CO2_AHUFre_y(unit="ppm") = mod.floor3.reaAHU.CO2_AHUFre.y "Fresh air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_CO2_AHURet_y(unit="ppm") = mod.floor3.reaAHU.CO2_AHURet.y "Return air CO2 measurement for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_phiAHUSup_y(unit="1") = mod.floor3.reaAHU.phiAHUSup.y "Supply air relative humidity for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_phiAHURet_y(unit="1") = mod.floor3.reaAHU.phiAHURet.y "Return air relative humidity for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_PFanSup_y(unit="W") = mod.floor3.reaAHU.PFanSup.y "Electrical power measurement of supply fan for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_PFreCoi_y(unit="W") = mod.floor3.reaAHU.PFreCoi.y "Electrical power measurement of freeze protection coil for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaAHU_TFreCoiLea_y(unit="K") = mod.floor3.reaAHU.TFreCoiLea.y "Temperature of air leaving freeze protection coil";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonCor_TZon_y(unit="K") = mod.floor3.reaZonCor.TZon.y "Zone air temperature measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonCor_TSup_y(unit="K") = mod.floor3.reaZonCor.TSup.y "Discharge air temperature measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonCor_V_flow_y(unit="m3/s") = mod.floor3.reaZonCor.V_flow.y "Air flowrate measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonCor_yReheaVal_y(unit="1") = mod.floor3.reaZonCor.yReheaVal.y "Reheat valve position measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonCor_yDam_y(unit="1") = mod.floor3.reaZonCor.yDam.y "Damper position measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonCor_V_flowSet_y(unit="m3/s") = mod.floor3.reaZonCor.V_flowSet.y "Zone airflow setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonCor_CO2Zon_y(unit="ppm") = mod.floor3.reaZonCor.CO2Zon.y "Zone air CO2 measurement for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonSou_TZon_y(unit="K") = mod.floor3.reaZonSou.TZon.y "Zone air temperature measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonSou_TSup_y(unit="K") = mod.floor3.reaZonSou.TSup.y "Discharge air temperature measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonSou_V_flow_y(unit="m3/s") = mod.floor3.reaZonSou.V_flow.y "Air flowrate measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonSou_yReheaVal_y(unit="1") = mod.floor3.reaZonSou.yReheaVal.y "Reheat valve position measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonSou_yDam_y(unit="1") = mod.floor3.reaZonSou.yDam.y "Damper position measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonSou_V_flowSet_y(unit="m3/s") = mod.floor3.reaZonSou.V_flowSet.y "Zone airflow setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonSou_CO2Zon_y(unit="ppm") = mod.floor3.reaZonSou.CO2Zon.y "Zone air CO2 measurement for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonEas_TZon_y(unit="K") = mod.floor3.reaZonEas.TZon.y "Zone air temperature measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonEas_TSup_y(unit="K") = mod.floor3.reaZonEas.TSup.y "Discharge air temperature measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonEas_V_flow_y(unit="m3/s") = mod.floor3.reaZonEas.V_flow.y "Air flowrate measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonEas_yReheaVal_y(unit="1") = mod.floor3.reaZonEas.yReheaVal.y "Reheat valve position measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonEas_yDam_y(unit="1") = mod.floor3.reaZonEas.yDam.y "Damper position measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonEas_V_flowSet_y(unit="m3/s") = mod.floor3.reaZonEas.V_flowSet.y "Zone airflow setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonEas_CO2Zon_y(unit="ppm") = mod.floor3.reaZonEas.CO2Zon.y "Zone air CO2 measurement for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonNor_TZon_y(unit="K") = mod.floor3.reaZonNor.TZon.y "Zone air temperature measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonNor_TSup_y(unit="K") = mod.floor3.reaZonNor.TSup.y "Discharge air temperature measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonNor_V_flow_y(unit="m3/s") = mod.floor3.reaZonNor.V_flow.y "Air flowrate measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonNor_yReheaVal_y(unit="1") = mod.floor3.reaZonNor.yReheaVal.y "Reheat valve position measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonNor_yDam_y(unit="1") = mod.floor3.reaZonNor.yDam.y "Damper position measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonNor_V_flowSet_y(unit="m3/s") = mod.floor3.reaZonNor.V_flowSet.y "Zone airflow setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonNor_CO2Zon_y(unit="ppm") = mod.floor3.reaZonNor.CO2Zon.y "Zone air CO2 measurement for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonWes_TZon_y(unit="K") = mod.floor3.reaZonWes.TZon.y "Zone air temperature measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonWes_TSup_y(unit="K") = mod.floor3.reaZonWes.TSup.y "Discharge air temperature measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonWes_V_flow_y(unit="m3/s") = mod.floor3.reaZonWes.V_flow.y "Air flowrate measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonWes_yReheaVal_y(unit="1") = mod.floor3.reaZonWes.yReheaVal.y "Reheat valve position measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonWes_yDam_y(unit="1") = mod.floor3.reaZonWes.yDam.y "Damper position measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonWes_V_flowSet_y(unit="m3/s") = mod.floor3.reaZonWes.V_flowSet.y "Zone airflow setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_reaZonWes_CO2Zon_y(unit="ppm") = mod.floor3.reaZonWes.CO2Zon.y "Zone air CO2 measurement for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDryBul_y(unit="K") = mod.weaSta.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaRelHum_y(unit="1") = mod.weaSta.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinSpe_y(unit="m/s") = mod.weaSta.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaWinDir_y(unit="rad") = mod.weaSta.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHGloHor_y(unit="W/m2") = mod.weaSta.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNTot_y(unit="1") = mod.weaSta.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaPAtm_y(unit="Pa") = mod.weaSta.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDifHor_y(unit="W/m2") = mod.weaSta.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCeiHei_y(unit="m") = mod.weaSta.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTWetBul_y(unit="K") = mod.weaSta.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTDewPoi_y(unit="K") = mod.weaSta.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaTBlaSky_y(unit="K") = mod.weaSta.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHHorIR_y(unit="W/m2") = mod.weaSta.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaHDirNor_y(unit="W/m2") = mod.weaSta.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaCloTim_y(unit="s") = mod.weaSta.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolAlt_y(unit="rad") = mod.weaSta.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaNOpa_y(unit="1") = mod.weaSta.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLat_y(unit="rad") = mod.weaSta.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaLon_y(unit="rad") = mod.weaSta.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolDec_y(unit="rad") = mod.weaSta.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolHouAng_y(unit="rad") = mod.weaSta.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolTim_y(unit="s") = mod.weaSta.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput weaSta_reaWeaSolZen_y(unit="rad") = mod.weaSta.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput reaChiWatSys_dp_y(unit="Pa") = mod.reaChiWatSys.dp.y "Differential pressure of chilled water plant measurement";
	Modelica.Blocks.Interfaces.RealOutput reaChiWatSys_TCHWSup_y(unit="K") = mod.reaChiWatSys.TCHWSup.y "Chilled water supply temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaChiWatSys_reaPPum_y(unit="W") = mod.reaChiWatSys.reaPPum.y "Chilled water plant pump power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaChiWatSys_reaPChi_y(unit="W") = mod.reaChiWatSys.reaPChi.y "Multiple chiller power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaChiWatSys_reaPCooTow_y(unit="W") = mod.reaChiWatSys.reaPCooTow.y "Multiple cooling tower power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaChiWatSys_TCHWRet_y(unit="K") = mod.reaChiWatSys.TCHWRet.y "Chilled water return temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaChiWatSys_mCHWTot_y(unit="kg/s") = mod.reaChiWatSys.mCHWTot.y "Total chilled water mass flow rate ";
	Modelica.Blocks.Interfaces.RealOutput reaHotWatSys_dp_y(unit="Pa") = mod.reaHotWatSys.dp.y "Differential pressure of hot water plant measurement";
	Modelica.Blocks.Interfaces.RealOutput reaHotWatSys_THWSup_y(unit="K") = mod.reaHotWatSys.THWSup.y "Hot water supply temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaHotWatSys_reaPPum_y(unit="W") = mod.reaHotWatSys.reaPPum.y "Hot water plant pump power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaHotWatSys_reaPBoi_y(unit="W") = mod.reaHotWatSys.reaPBoi.y "Multiple gas boiler power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaHotWatSys_THWRet_y(unit="K") = mod.reaHotWatSys.THWRet.y "Hot water return temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaHotWatSys_mHWTot_y(unit="kg/s") = mod.reaHotWatSys.mHWTot.y "Total hot water mass flow rate ";
	Modelica.Blocks.Interfaces.RealOutput floor1_duaFanAirHanUni_supFan_oveSpeSupFan_y(unit="1") = mod.floor1.duaFanAirHanUni.supFan.oveSpeSupFan.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput floor1_duaFanAirHanUni_cooCoi_yCoo_y(unit="1") = mod.floor1.duaFanAirHanUni.cooCoi.yCoo.y "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_duaFanAirHanUni_mixingBox_mixBox_yOA_y(unit="1") = mod.floor1.duaFanAirHanUni.mixingBox.mixBox.yOA.y "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_duaFanAirHanUni_mixingBox_mixBox_yRet_y(unit="1") = mod.floor1.duaFanAirHanUni.mixingBox.mixBox.yRet.y "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_duaFanAirHanUni_mixingBox_mixBox_yEA_y(unit="1") = mod.floor1.duaFanAirHanUni.mixingBox.mixBox.yEA.y "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_duaFanAirHanUni_oveSpeRetFan_y(unit="1") = mod.floor1.duaFanAirHanUni.oveSpeRetFan.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput floor1_duaFanAirHanUni_frePro_oveFrePro_y(unit="1") = mod.floor1.duaFanAirHanUni.frePro.oveFrePro.y "Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV1_oveZonLoc_yDam_y(unit="1") = mod.floor1.fivZonVAV.vAV1.oveZonLoc.yDam.y "Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_y(unit="1") = mod.floor1.fivZonVAV.vAV1.oveZonLoc.yReaHea.y "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV2_oveZonLoc_yDam_y(unit="1") = mod.floor1.fivZonVAV.vAV2.oveZonLoc.yDam.y "Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_y(unit="1") = mod.floor1.fivZonVAV.vAV2.oveZonLoc.yReaHea.y "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV3_oveZonLoc_yDam_y(unit="1") = mod.floor1.fivZonVAV.vAV3.oveZonLoc.yDam.y "Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_y(unit="1") = mod.floor1.fivZonVAV.vAV3.oveZonLoc.yReaHea.y "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV4_oveZonLoc_yDam_y(unit="1") = mod.floor1.fivZonVAV.vAV4.oveZonLoc.yDam.y "Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_y(unit="1") = mod.floor1.fivZonVAV.vAV4.oveZonLoc.yReaHea.y "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV5_oveZonLoc_yDam_y(unit="1") = mod.floor1.fivZonVAV.vAV5.oveZonLoc.yDam.y "Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_y(unit="1") = mod.floor1.fivZonVAV.vAV5.oveZonLoc.yReaHea.y "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_TSupAirSet_y(unit="K") = mod.floor1.TSupAirSet.y "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_dpSet_y(unit="Pa") = mod.floor1.dpSet.y "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonCor_TZonHeaSet_y(unit="K") = mod.floor1.oveZonCor.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonCor_TZonCooSet_y(unit="K") = mod.floor1.oveZonCor.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonSou_TZonHeaSet_y(unit="K") = mod.floor1.oveZonSou.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonSou_TZonCooSet_y(unit="K") = mod.floor1.oveZonSou.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonEas_TZonHeaSet_y(unit="K") = mod.floor1.oveZonEas.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonEas_TZonCooSet_y(unit="K") = mod.floor1.oveZonEas.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonNor_TZonHeaSet_y(unit="K") = mod.floor1.oveZonNor.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonNor_TZonCooSet_y(unit="K") = mod.floor1.oveZonNor.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonWes_TZonHeaSet_y(unit="K") = mod.floor1.oveZonWes.TZonHeaSet.y "Zone air temperature heating setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor1_oveZonWes_TZonCooSet_y(unit="K") = mod.floor1.oveZonWes.TZonCooSet.y "Zone air temperature cooling setpoint for zone bot_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_duaFanAirHanUni_supFan_oveSpeSupFan_y(unit="1") = mod.floor2.duaFanAirHanUni.supFan.oveSpeSupFan.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput floor2_duaFanAirHanUni_cooCoi_yCoo_y(unit="1") = mod.floor2.duaFanAirHanUni.cooCoi.yCoo.y "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_duaFanAirHanUni_mixingBox_mixBox_yOA_y(unit="1") = mod.floor2.duaFanAirHanUni.mixingBox.mixBox.yOA.y "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_duaFanAirHanUni_mixingBox_mixBox_yRet_y(unit="1") = mod.floor2.duaFanAirHanUni.mixingBox.mixBox.yRet.y "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_duaFanAirHanUni_mixingBox_mixBox_yEA_y(unit="1") = mod.floor2.duaFanAirHanUni.mixingBox.mixBox.yEA.y "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_duaFanAirHanUni_oveSpeRetFan_y(unit="1") = mod.floor2.duaFanAirHanUni.oveSpeRetFan.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput floor2_duaFanAirHanUni_frePro_oveFrePro_y(unit="1") = mod.floor2.duaFanAirHanUni.frePro.oveFrePro.y "Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV1_oveZonLoc_yDam_y(unit="1") = mod.floor2.fivZonVAV.vAV1.oveZonLoc.yDam.y "Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_y(unit="1") = mod.floor2.fivZonVAV.vAV1.oveZonLoc.yReaHea.y "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV2_oveZonLoc_yDam_y(unit="1") = mod.floor2.fivZonVAV.vAV2.oveZonLoc.yDam.y "Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_y(unit="1") = mod.floor2.fivZonVAV.vAV2.oveZonLoc.yReaHea.y "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV3_oveZonLoc_yDam_y(unit="1") = mod.floor2.fivZonVAV.vAV3.oveZonLoc.yDam.y "Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_y(unit="1") = mod.floor2.fivZonVAV.vAV3.oveZonLoc.yReaHea.y "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV4_oveZonLoc_yDam_y(unit="1") = mod.floor2.fivZonVAV.vAV4.oveZonLoc.yDam.y "Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_y(unit="1") = mod.floor2.fivZonVAV.vAV4.oveZonLoc.yReaHea.y "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV5_oveZonLoc_yDam_y(unit="1") = mod.floor2.fivZonVAV.vAV5.oveZonLoc.yDam.y "Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_y(unit="1") = mod.floor2.fivZonVAV.vAV5.oveZonLoc.yReaHea.y "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_TSupAirSet_y(unit="K") = mod.floor2.TSupAirSet.y "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_dpSet_y(unit="Pa") = mod.floor2.dpSet.y "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonCor_TZonHeaSet_y(unit="K") = mod.floor2.oveZonCor.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonCor_TZonCooSet_y(unit="K") = mod.floor2.oveZonCor.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonSou_TZonHeaSet_y(unit="K") = mod.floor2.oveZonSou.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonSou_TZonCooSet_y(unit="K") = mod.floor2.oveZonSou.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonEas_TZonHeaSet_y(unit="K") = mod.floor2.oveZonEas.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonEas_TZonCooSet_y(unit="K") = mod.floor2.oveZonEas.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonNor_TZonHeaSet_y(unit="K") = mod.floor2.oveZonNor.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonNor_TZonCooSet_y(unit="K") = mod.floor2.oveZonNor.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonWes_TZonHeaSet_y(unit="K") = mod.floor2.oveZonWes.TZonHeaSet.y "Zone air temperature heating setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor2_oveZonWes_TZonCooSet_y(unit="K") = mod.floor2.oveZonWes.TZonCooSet.y "Zone air temperature cooling setpoint for zone mid_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_duaFanAirHanUni_supFan_oveSpeSupFan_y(unit="1") = mod.floor3.duaFanAirHanUni.supFan.oveSpeSupFan.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput floor3_duaFanAirHanUni_cooCoi_yCoo_y(unit="1") = mod.floor3.duaFanAirHanUni.cooCoi.yCoo.y "Cooling coil valve control signal for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_duaFanAirHanUni_mixingBox_mixBox_yOA_y(unit="1") = mod.floor3.duaFanAirHanUni.mixingBox.mixBox.yOA.y "Outside air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_duaFanAirHanUni_mixingBox_mixBox_yRet_y(unit="1") = mod.floor3.duaFanAirHanUni.mixingBox.mixBox.yRet.y "Return air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_duaFanAirHanUni_mixingBox_mixBox_yEA_y(unit="1") = mod.floor3.duaFanAirHanUni.mixingBox.mixBox.yEA.y "Exhaust air damper position setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_duaFanAirHanUni_oveSpeRetFan_y(unit="1") = mod.floor3.duaFanAirHanUni.oveSpeRetFan.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput floor3_duaFanAirHanUni_frePro_oveFrePro_y(unit="1") = mod.floor3.duaFanAirHanUni.frePro.oveFrePro.y "Control signal for freeze protection coil";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV1_oveZonLoc_yDam_y(unit="1") = mod.floor3.fivZonVAV.vAV1.oveZonLoc.yDam.y "Damper position signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_y(unit="1") = mod.floor3.fivZonVAV.vAV1.oveZonLoc.yReaHea.y "Reheat control signal for zone cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV2_oveZonLoc_yDam_y(unit="1") = mod.floor3.fivZonVAV.vAV2.oveZonLoc.yDam.y "Damper position signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_y(unit="1") = mod.floor3.fivZonVAV.vAV2.oveZonLoc.yReaHea.y "Reheat control signal for zone sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV3_oveZonLoc_yDam_y(unit="1") = mod.floor3.fivZonVAV.vAV3.oveZonLoc.yDam.y "Damper position signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_y(unit="1") = mod.floor3.fivZonVAV.vAV3.oveZonLoc.yReaHea.y "Reheat control signal for zone eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV4_oveZonLoc_yDam_y(unit="1") = mod.floor3.fivZonVAV.vAV4.oveZonLoc.yDam.y "Damper position signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_y(unit="1") = mod.floor3.fivZonVAV.vAV4.oveZonLoc.yReaHea.y "Reheat control signal for zone nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV5_oveZonLoc_yDam_y(unit="1") = mod.floor3.fivZonVAV.vAV5.oveZonLoc.yDam.y "Damper position signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_y(unit="1") = mod.floor3.fivZonVAV.vAV5.oveZonLoc.yReaHea.y "Reheat control signal for zone wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_TSupAirSet_y(unit="K") = mod.floor3.TSupAirSet.y "Supply air temperature setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_dpSet_y(unit="Pa") = mod.floor3.dpSet.y "Supply duct pressure setpoint for AHU";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonCor_TZonHeaSet_y(unit="K") = mod.floor3.oveZonCor.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonCor_TZonCooSet_y(unit="K") = mod.floor3.oveZonCor.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_cor";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonSou_TZonHeaSet_y(unit="K") = mod.floor3.oveZonSou.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonSou_TZonCooSet_y(unit="K") = mod.floor3.oveZonSou.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_sou";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonEas_TZonHeaSet_y(unit="K") = mod.floor3.oveZonEas.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonEas_TZonCooSet_y(unit="K") = mod.floor3.oveZonEas.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_eas";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonNor_TZonHeaSet_y(unit="K") = mod.floor3.oveZonNor.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonNor_TZonCooSet_y(unit="K") = mod.floor3.oveZonNor.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_nor";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonWes_TZonHeaSet_y(unit="K") = mod.floor3.oveZonWes.TZonHeaSet.y "Zone air temperature heating setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput floor3_oveZonWes_TZonCooSet_y(unit="K") = mod.floor3.oveZonWes.TZonCooSet.y "Zone air temperature cooling setpoint for zone top_floor_wes";
	Modelica.Blocks.Interfaces.RealOutput oveChiWatSys_TWSet_y(unit="K") = mod.oveChiWatSys.TWSet.y "Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.RealOutput oveChiWatSys_dpSet_y(unit="Pa") = mod.oveChiWatSys.dpSet.y "Differential pressure setpoint";
	Modelica.Blocks.Interfaces.RealOutput oveHotWatSys_TWSet_y(unit="K") = mod.oveHotWatSys.TWSet.y "Chilled/hot water supply setpoint";
	Modelica.Blocks.Interfaces.RealOutput oveHotWatSys_dpSet_y(unit="Pa") = mod.oveHotWatSys.dpSet.y "Differential pressure setpoint";
	// Original model
	MultizoneOfficeComplexAir.TestCases.TestCase mod(
		floor1.duaFanAirHanUni.supFan.oveSpeSupFan(uExt(y=floor1_duaFanAirHanUni_supFan_oveSpeSupFan_u),activate(y=floor1_duaFanAirHanUni_supFan_oveSpeSupFan_activate)),
		floor1.duaFanAirHanUni.cooCoi.yCoo(uExt(y=floor1_duaFanAirHanUni_cooCoi_yCoo_u),activate(y=floor1_duaFanAirHanUni_cooCoi_yCoo_activate)),
		floor1.duaFanAirHanUni.mixingBox.mixBox.yOA(uExt(y=floor1_duaFanAirHanUni_mixingBox_mixBox_yOA_u),activate(y=floor1_duaFanAirHanUni_mixingBox_mixBox_yOA_activate)),
		floor1.duaFanAirHanUni.mixingBox.mixBox.yRet(uExt(y=floor1_duaFanAirHanUni_mixingBox_mixBox_yRet_u),activate(y=floor1_duaFanAirHanUni_mixingBox_mixBox_yRet_activate)),
		floor1.duaFanAirHanUni.mixingBox.mixBox.yEA(uExt(y=floor1_duaFanAirHanUni_mixingBox_mixBox_yEA_u),activate(y=floor1_duaFanAirHanUni_mixingBox_mixBox_yEA_activate)),
		floor1.duaFanAirHanUni.oveSpeRetFan(uExt(y=floor1_duaFanAirHanUni_oveSpeRetFan_u),activate(y=floor1_duaFanAirHanUni_oveSpeRetFan_activate)),
		floor1.duaFanAirHanUni.frePro.oveFrePro(uExt(y=floor1_duaFanAirHanUni_frePro_oveFrePro_u),activate(y=floor1_duaFanAirHanUni_frePro_oveFrePro_activate)),
		floor1.fivZonVAV.vAV1.oveZonLoc.yDam(uExt(y=floor1_fivZonVAV_vAV1_oveZonLoc_yDam_u),activate(y=floor1_fivZonVAV_vAV1_oveZonLoc_yDam_activate)),
		floor1.fivZonVAV.vAV1.oveZonLoc.yReaHea(uExt(y=floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_u),activate(y=floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate)),
		floor1.fivZonVAV.vAV2.oveZonLoc.yDam(uExt(y=floor1_fivZonVAV_vAV2_oveZonLoc_yDam_u),activate(y=floor1_fivZonVAV_vAV2_oveZonLoc_yDam_activate)),
		floor1.fivZonVAV.vAV2.oveZonLoc.yReaHea(uExt(y=floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_u),activate(y=floor1_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate)),
		floor1.fivZonVAV.vAV3.oveZonLoc.yDam(uExt(y=floor1_fivZonVAV_vAV3_oveZonLoc_yDam_u),activate(y=floor1_fivZonVAV_vAV3_oveZonLoc_yDam_activate)),
		floor1.fivZonVAV.vAV3.oveZonLoc.yReaHea(uExt(y=floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_u),activate(y=floor1_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate)),
		floor1.fivZonVAV.vAV4.oveZonLoc.yDam(uExt(y=floor1_fivZonVAV_vAV4_oveZonLoc_yDam_u),activate(y=floor1_fivZonVAV_vAV4_oveZonLoc_yDam_activate)),
		floor1.fivZonVAV.vAV4.oveZonLoc.yReaHea(uExt(y=floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_u),activate(y=floor1_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate)),
		floor1.fivZonVAV.vAV5.oveZonLoc.yDam(uExt(y=floor1_fivZonVAV_vAV5_oveZonLoc_yDam_u),activate(y=floor1_fivZonVAV_vAV5_oveZonLoc_yDam_activate)),
		floor1.fivZonVAV.vAV5.oveZonLoc.yReaHea(uExt(y=floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_u),activate(y=floor1_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate)),
		floor1.TSupAirSet(uExt(y=floor1_TSupAirSet_u),activate(y=floor1_TSupAirSet_activate)),
		floor1.dpSet(uExt(y=floor1_dpSet_u),activate(y=floor1_dpSet_activate)),
		floor1.oveZonCor.TZonHeaSet(uExt(y=floor1_oveZonCor_TZonHeaSet_u),activate(y=floor1_oveZonCor_TZonHeaSet_activate)),
		floor1.oveZonCor.TZonCooSet(uExt(y=floor1_oveZonCor_TZonCooSet_u),activate(y=floor1_oveZonCor_TZonCooSet_activate)),
		floor1.oveZonSou.TZonHeaSet(uExt(y=floor1_oveZonSou_TZonHeaSet_u),activate(y=floor1_oveZonSou_TZonHeaSet_activate)),
		floor1.oveZonSou.TZonCooSet(uExt(y=floor1_oveZonSou_TZonCooSet_u),activate(y=floor1_oveZonSou_TZonCooSet_activate)),
		floor1.oveZonEas.TZonHeaSet(uExt(y=floor1_oveZonEas_TZonHeaSet_u),activate(y=floor1_oveZonEas_TZonHeaSet_activate)),
		floor1.oveZonEas.TZonCooSet(uExt(y=floor1_oveZonEas_TZonCooSet_u),activate(y=floor1_oveZonEas_TZonCooSet_activate)),
		floor1.oveZonNor.TZonHeaSet(uExt(y=floor1_oveZonNor_TZonHeaSet_u),activate(y=floor1_oveZonNor_TZonHeaSet_activate)),
		floor1.oveZonNor.TZonCooSet(uExt(y=floor1_oveZonNor_TZonCooSet_u),activate(y=floor1_oveZonNor_TZonCooSet_activate)),
		floor1.oveZonWes.TZonHeaSet(uExt(y=floor1_oveZonWes_TZonHeaSet_u),activate(y=floor1_oveZonWes_TZonHeaSet_activate)),
		floor1.oveZonWes.TZonCooSet(uExt(y=floor1_oveZonWes_TZonCooSet_u),activate(y=floor1_oveZonWes_TZonCooSet_activate)),
		floor2.duaFanAirHanUni.supFan.oveSpeSupFan(uExt(y=floor2_duaFanAirHanUni_supFan_oveSpeSupFan_u),activate(y=floor2_duaFanAirHanUni_supFan_oveSpeSupFan_activate)),
		floor2.duaFanAirHanUni.cooCoi.yCoo(uExt(y=floor2_duaFanAirHanUni_cooCoi_yCoo_u),activate(y=floor2_duaFanAirHanUni_cooCoi_yCoo_activate)),
		floor2.duaFanAirHanUni.mixingBox.mixBox.yOA(uExt(y=floor2_duaFanAirHanUni_mixingBox_mixBox_yOA_u),activate(y=floor2_duaFanAirHanUni_mixingBox_mixBox_yOA_activate)),
		floor2.duaFanAirHanUni.mixingBox.mixBox.yRet(uExt(y=floor2_duaFanAirHanUni_mixingBox_mixBox_yRet_u),activate(y=floor2_duaFanAirHanUni_mixingBox_mixBox_yRet_activate)),
		floor2.duaFanAirHanUni.mixingBox.mixBox.yEA(uExt(y=floor2_duaFanAirHanUni_mixingBox_mixBox_yEA_u),activate(y=floor2_duaFanAirHanUni_mixingBox_mixBox_yEA_activate)),
		floor2.duaFanAirHanUni.oveSpeRetFan(uExt(y=floor2_duaFanAirHanUni_oveSpeRetFan_u),activate(y=floor2_duaFanAirHanUni_oveSpeRetFan_activate)),
		floor2.duaFanAirHanUni.frePro.oveFrePro(uExt(y=floor2_duaFanAirHanUni_frePro_oveFrePro_u),activate(y=floor2_duaFanAirHanUni_frePro_oveFrePro_activate)),
		floor2.fivZonVAV.vAV1.oveZonLoc.yDam(uExt(y=floor2_fivZonVAV_vAV1_oveZonLoc_yDam_u),activate(y=floor2_fivZonVAV_vAV1_oveZonLoc_yDam_activate)),
		floor2.fivZonVAV.vAV1.oveZonLoc.yReaHea(uExt(y=floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_u),activate(y=floor2_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate)),
		floor2.fivZonVAV.vAV2.oveZonLoc.yDam(uExt(y=floor2_fivZonVAV_vAV2_oveZonLoc_yDam_u),activate(y=floor2_fivZonVAV_vAV2_oveZonLoc_yDam_activate)),
		floor2.fivZonVAV.vAV2.oveZonLoc.yReaHea(uExt(y=floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_u),activate(y=floor2_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate)),
		floor2.fivZonVAV.vAV3.oveZonLoc.yDam(uExt(y=floor2_fivZonVAV_vAV3_oveZonLoc_yDam_u),activate(y=floor2_fivZonVAV_vAV3_oveZonLoc_yDam_activate)),
		floor2.fivZonVAV.vAV3.oveZonLoc.yReaHea(uExt(y=floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_u),activate(y=floor2_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate)),
		floor2.fivZonVAV.vAV4.oveZonLoc.yDam(uExt(y=floor2_fivZonVAV_vAV4_oveZonLoc_yDam_u),activate(y=floor2_fivZonVAV_vAV4_oveZonLoc_yDam_activate)),
		floor2.fivZonVAV.vAV4.oveZonLoc.yReaHea(uExt(y=floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_u),activate(y=floor2_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate)),
		floor2.fivZonVAV.vAV5.oveZonLoc.yDam(uExt(y=floor2_fivZonVAV_vAV5_oveZonLoc_yDam_u),activate(y=floor2_fivZonVAV_vAV5_oveZonLoc_yDam_activate)),
		floor2.fivZonVAV.vAV5.oveZonLoc.yReaHea(uExt(y=floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_u),activate(y=floor2_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate)),
		floor2.TSupAirSet(uExt(y=floor2_TSupAirSet_u),activate(y=floor2_TSupAirSet_activate)),
		floor2.dpSet(uExt(y=floor2_dpSet_u),activate(y=floor2_dpSet_activate)),
		floor2.oveZonCor.TZonHeaSet(uExt(y=floor2_oveZonCor_TZonHeaSet_u),activate(y=floor2_oveZonCor_TZonHeaSet_activate)),
		floor2.oveZonCor.TZonCooSet(uExt(y=floor2_oveZonCor_TZonCooSet_u),activate(y=floor2_oveZonCor_TZonCooSet_activate)),
		floor2.oveZonSou.TZonHeaSet(uExt(y=floor2_oveZonSou_TZonHeaSet_u),activate(y=floor2_oveZonSou_TZonHeaSet_activate)),
		floor2.oveZonSou.TZonCooSet(uExt(y=floor2_oveZonSou_TZonCooSet_u),activate(y=floor2_oveZonSou_TZonCooSet_activate)),
		floor2.oveZonEas.TZonHeaSet(uExt(y=floor2_oveZonEas_TZonHeaSet_u),activate(y=floor2_oveZonEas_TZonHeaSet_activate)),
		floor2.oveZonEas.TZonCooSet(uExt(y=floor2_oveZonEas_TZonCooSet_u),activate(y=floor2_oveZonEas_TZonCooSet_activate)),
		floor2.oveZonNor.TZonHeaSet(uExt(y=floor2_oveZonNor_TZonHeaSet_u),activate(y=floor2_oveZonNor_TZonHeaSet_activate)),
		floor2.oveZonNor.TZonCooSet(uExt(y=floor2_oveZonNor_TZonCooSet_u),activate(y=floor2_oveZonNor_TZonCooSet_activate)),
		floor2.oveZonWes.TZonHeaSet(uExt(y=floor2_oveZonWes_TZonHeaSet_u),activate(y=floor2_oveZonWes_TZonHeaSet_activate)),
		floor2.oveZonWes.TZonCooSet(uExt(y=floor2_oveZonWes_TZonCooSet_u),activate(y=floor2_oveZonWes_TZonCooSet_activate)),
		floor3.duaFanAirHanUni.supFan.oveSpeSupFan(uExt(y=floor3_duaFanAirHanUni_supFan_oveSpeSupFan_u),activate(y=floor3_duaFanAirHanUni_supFan_oveSpeSupFan_activate)),
		floor3.duaFanAirHanUni.cooCoi.yCoo(uExt(y=floor3_duaFanAirHanUni_cooCoi_yCoo_u),activate(y=floor3_duaFanAirHanUni_cooCoi_yCoo_activate)),
		floor3.duaFanAirHanUni.mixingBox.mixBox.yOA(uExt(y=floor3_duaFanAirHanUni_mixingBox_mixBox_yOA_u),activate(y=floor3_duaFanAirHanUni_mixingBox_mixBox_yOA_activate)),
		floor3.duaFanAirHanUni.mixingBox.mixBox.yRet(uExt(y=floor3_duaFanAirHanUni_mixingBox_mixBox_yRet_u),activate(y=floor3_duaFanAirHanUni_mixingBox_mixBox_yRet_activate)),
		floor3.duaFanAirHanUni.mixingBox.mixBox.yEA(uExt(y=floor3_duaFanAirHanUni_mixingBox_mixBox_yEA_u),activate(y=floor3_duaFanAirHanUni_mixingBox_mixBox_yEA_activate)),
		floor3.duaFanAirHanUni.oveSpeRetFan(uExt(y=floor3_duaFanAirHanUni_oveSpeRetFan_u),activate(y=floor3_duaFanAirHanUni_oveSpeRetFan_activate)),
		floor3.duaFanAirHanUni.frePro.oveFrePro(uExt(y=floor3_duaFanAirHanUni_frePro_oveFrePro_u),activate(y=floor3_duaFanAirHanUni_frePro_oveFrePro_activate)),
		floor3.fivZonVAV.vAV1.oveZonLoc.yDam(uExt(y=floor3_fivZonVAV_vAV1_oveZonLoc_yDam_u),activate(y=floor3_fivZonVAV_vAV1_oveZonLoc_yDam_activate)),
		floor3.fivZonVAV.vAV1.oveZonLoc.yReaHea(uExt(y=floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_u),activate(y=floor3_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate)),
		floor3.fivZonVAV.vAV2.oveZonLoc.yDam(uExt(y=floor3_fivZonVAV_vAV2_oveZonLoc_yDam_u),activate(y=floor3_fivZonVAV_vAV2_oveZonLoc_yDam_activate)),
		floor3.fivZonVAV.vAV2.oveZonLoc.yReaHea(uExt(y=floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_u),activate(y=floor3_fivZonVAV_vAV2_oveZonLoc_yReaHea_activate)),
		floor3.fivZonVAV.vAV3.oveZonLoc.yDam(uExt(y=floor3_fivZonVAV_vAV3_oveZonLoc_yDam_u),activate(y=floor3_fivZonVAV_vAV3_oveZonLoc_yDam_activate)),
		floor3.fivZonVAV.vAV3.oveZonLoc.yReaHea(uExt(y=floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_u),activate(y=floor3_fivZonVAV_vAV3_oveZonLoc_yReaHea_activate)),
		floor3.fivZonVAV.vAV4.oveZonLoc.yDam(uExt(y=floor3_fivZonVAV_vAV4_oveZonLoc_yDam_u),activate(y=floor3_fivZonVAV_vAV4_oveZonLoc_yDam_activate)),
		floor3.fivZonVAV.vAV4.oveZonLoc.yReaHea(uExt(y=floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_u),activate(y=floor3_fivZonVAV_vAV4_oveZonLoc_yReaHea_activate)),
		floor3.fivZonVAV.vAV5.oveZonLoc.yDam(uExt(y=floor3_fivZonVAV_vAV5_oveZonLoc_yDam_u),activate(y=floor3_fivZonVAV_vAV5_oveZonLoc_yDam_activate)),
		floor3.fivZonVAV.vAV5.oveZonLoc.yReaHea(uExt(y=floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_u),activate(y=floor3_fivZonVAV_vAV5_oveZonLoc_yReaHea_activate)),
		floor3.TSupAirSet(uExt(y=floor3_TSupAirSet_u),activate(y=floor3_TSupAirSet_activate)),
		floor3.dpSet(uExt(y=floor3_dpSet_u),activate(y=floor3_dpSet_activate)),
		floor3.oveZonCor.TZonHeaSet(uExt(y=floor3_oveZonCor_TZonHeaSet_u),activate(y=floor3_oveZonCor_TZonHeaSet_activate)),
		floor3.oveZonCor.TZonCooSet(uExt(y=floor3_oveZonCor_TZonCooSet_u),activate(y=floor3_oveZonCor_TZonCooSet_activate)),
		floor3.oveZonSou.TZonHeaSet(uExt(y=floor3_oveZonSou_TZonHeaSet_u),activate(y=floor3_oveZonSou_TZonHeaSet_activate)),
		floor3.oveZonSou.TZonCooSet(uExt(y=floor3_oveZonSou_TZonCooSet_u),activate(y=floor3_oveZonSou_TZonCooSet_activate)),
		floor3.oveZonEas.TZonHeaSet(uExt(y=floor3_oveZonEas_TZonHeaSet_u),activate(y=floor3_oveZonEas_TZonHeaSet_activate)),
		floor3.oveZonEas.TZonCooSet(uExt(y=floor3_oveZonEas_TZonCooSet_u),activate(y=floor3_oveZonEas_TZonCooSet_activate)),
		floor3.oveZonNor.TZonHeaSet(uExt(y=floor3_oveZonNor_TZonHeaSet_u),activate(y=floor3_oveZonNor_TZonHeaSet_activate)),
		floor3.oveZonNor.TZonCooSet(uExt(y=floor3_oveZonNor_TZonCooSet_u),activate(y=floor3_oveZonNor_TZonCooSet_activate)),
		floor3.oveZonWes.TZonHeaSet(uExt(y=floor3_oveZonWes_TZonHeaSet_u),activate(y=floor3_oveZonWes_TZonHeaSet_activate)),
		floor3.oveZonWes.TZonCooSet(uExt(y=floor3_oveZonWes_TZonCooSet_u),activate(y=floor3_oveZonWes_TZonCooSet_activate)),
		oveChiWatSys.TWSet(uExt(y=oveChiWatSys_TWSet_u),activate(y=oveChiWatSys_TWSet_activate)),
		oveChiWatSys.dpSet(uExt(y=oveChiWatSys_dpSet_u),activate(y=oveChiWatSys_dpSet_activate)),
		oveHotWatSys.TWSet(uExt(y=oveHotWatSys_TWSet_u),activate(y=oveHotWatSys_TWSet_activate)),
		oveHotWatSys.dpSet(uExt(y=oveHotWatSys_dpSet_u),activate(y=oveHotWatSys_dpSet_activate))) "Original model with overwrites";
end wrapped;
