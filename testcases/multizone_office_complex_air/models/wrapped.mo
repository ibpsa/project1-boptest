model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_u(unit="1", min=0.0, max=1.0) "AHU economizer damper position";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_activate "Activation for AHU economizer damper position";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u(unit="Pa", min=80.0, max=600.0) "AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate "Activation for AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_u(unit="1", min=0.0, max=1.0) "AHU economizer damper position";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_activate "Activation for AHU economizer damper position";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u(unit="Pa", min=80.0, max=600.0) "AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate "Activation for AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_u(unit="1", min=0.0, max=1.0) "AHU economizer damper position";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_activate "Activation for AHU economizer damper position";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u(unit="Pa", min=80.0, max=600.0) "AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate "Activation for AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput hvac_oveFloor1TDisAir_u(unit="K", min=281.15, max=293.15) "Floor 1 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveFloor1TDisAir_activate "Activation for Floor 1 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_oveFloor2TDisAir_u(unit="K", min=281.15, max=293.15) "Floor 2 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveFloor2TDisAir_activate "Activation for Floor 2 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_oveFloor3TDisAir_u(unit="K", min=281.15, max=293.15) "Floor 3 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveFloor3TDisAir_activate "Activation for Floor 3 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_oveTCHWSet_u(unit="K", min=277.15, max=286.15) "Chilled water supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveTCHWSet_activate "Activation for Chilled water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput hvac_oveTHWSet_u(unit="K", min=313.15, max=363.15) "Hot water supply temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput hvac_oveTHWSet_activate "Activation for Hot water supply temperature setpoint";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput hvac_reaPBoi_y(unit="W") = mod.hvac.reaPBoi.y "Boiler gas consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaPCHWPum_y(unit="W") = mod.hvac.reaPCHWPum.y "Chilled water plant pump power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaPChi_y(unit="W") = mod.hvac.reaPChi.y "Multiple chiller power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaPCooTow_y(unit="W") = mod.hvac.reaPCooTow.y "Multiple cooling tower power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaPFan_y(unit="W") = mod.hvac.reaPFan.y "AHU fan power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_reaPHWPum_y(unit="W") = mod.hvac.reaPHWPum.y "Hot water pump power consumption";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_y(unit="1") = mod.hvac.floor1.duaFanAirHanUnit.mixingBox.oveEcoDam.y "AHU economizer damper position";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_y(unit="Pa") = mod.hvac.floor1.duaFanAirHanUnit.supFan.variableSpeed.ovePreSetPoi.y "AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_y(unit="1") = mod.hvac.floor1.duaFanAirHanUnit.supFan.variableSpeed.oveSpeSup.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_y(unit="1") = mod.hvac.floor2.duaFanAirHanUnit.mixingBox.oveEcoDam.y "AHU economizer damper position";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_y(unit="Pa") = mod.hvac.floor2.duaFanAirHanUnit.supFan.variableSpeed.ovePreSetPoi.y "AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_y(unit="1") = mod.hvac.floor2.duaFanAirHanUnit.supFan.variableSpeed.oveSpeSup.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_y(unit="1") = mod.hvac.floor3.duaFanAirHanUnit.mixingBox.oveEcoDam.y "AHU economizer damper position";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_y(unit="Pa") = mod.hvac.floor3.duaFanAirHanUnit.supFan.variableSpeed.ovePreSetPoi.y "AHU supply fan static pressure setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_y(unit="1") = mod.hvac.floor3.duaFanAirHanUnit.supFan.variableSpeed.oveSpeSup.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveFloor1TDisAir_y(unit="K") = mod.hvac.oveFloor1TDisAir.y "Floor 1 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveFloor2TDisAir_y(unit="K") = mod.hvac.oveFloor2TDisAir.y "Floor 2 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveFloor3TDisAir_y(unit="K") = mod.hvac.oveFloor3TDisAir.y "Floor 3 AHU supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveTCHWSet_y(unit="K") = mod.hvac.oveTCHWSet.y "Chilled water supply temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput hvac_oveTHWSet_y(unit="K") = mod.hvac.oveTHWSet.y "Hot water supply temperature setpoint";
	// Original model
	MultizoneOfficeComplexAir.TestCases.TestCase mod(
		hvac.floor1.duaFanAirHanUnit.mixingBox.oveEcoDam(uExt(y=hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_u),activate(y=hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_activate)),
		hvac.floor1.duaFanAirHanUnit.supFan.variableSpeed.ovePreSetPoi(uExt(y=hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u),activate(y=hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate)),
		hvac.floor1.duaFanAirHanUnit.supFan.variableSpeed.oveSpeSup(uExt(y=hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u),activate(y=hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate)),
		hvac.floor2.duaFanAirHanUnit.mixingBox.oveEcoDam(uExt(y=hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_u),activate(y=hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_activate)),
		hvac.floor2.duaFanAirHanUnit.supFan.variableSpeed.ovePreSetPoi(uExt(y=hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u),activate(y=hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate)),
		hvac.floor2.duaFanAirHanUnit.supFan.variableSpeed.oveSpeSup(uExt(y=hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u),activate(y=hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate)),
		hvac.floor3.duaFanAirHanUnit.mixingBox.oveEcoDam(uExt(y=hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_u),activate(y=hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_activate)),
		hvac.floor3.duaFanAirHanUnit.supFan.variableSpeed.ovePreSetPoi(uExt(y=hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u),activate(y=hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate)),
		hvac.floor3.duaFanAirHanUnit.supFan.variableSpeed.oveSpeSup(uExt(y=hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u),activate(y=hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate)),
		hvac.oveFloor1TDisAir(uExt(y=hvac_oveFloor1TDisAir_u),activate(y=hvac_oveFloor1TDisAir_activate)),
		hvac.oveFloor2TDisAir(uExt(y=hvac_oveFloor2TDisAir_u),activate(y=hvac_oveFloor2TDisAir_activate)),
		hvac.oveFloor3TDisAir(uExt(y=hvac_oveFloor3TDisAir_u),activate(y=hvac_oveFloor3TDisAir_activate)),
		hvac.oveTCHWSet(uExt(y=hvac_oveTCHWSet_u),activate(y=hvac_oveTCHWSet_activate)),
		hvac.oveTHWSet(uExt(y=hvac_oveTHWSet_u),activate(y=hvac_oveTHWSet_activate))) "Original model with overwrites";
end wrapped;
