model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveAct_u "Signal for overwrite block oveAct";
	Modelica.Blocks.Interfaces.BooleanInput oveAct_activate "Activation for overwrite block oveAct";
	Modelica.Blocks.Interfaces.RealInput oveSet_u "Signal for overwrite block oveSet";
	Modelica.Blocks.Interfaces.BooleanInput oveSet_activate "Activation for overwrite block oveSet";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput EHeat_y = mod.EHeat.y "Measured signal for EHeat";
	Modelica.Blocks.Interfaces.RealOutput PHeat_y = mod.PHeat.y "Measured signal for PHeat";
	Modelica.Blocks.Interfaces.RealOutput TZone_y = mod.TZone.y "Measured signal for TZone";
	Modelica.Blocks.Interfaces.RealOutput setZone_y = mod.setZone.y "Measured signal for setZone";
	// Original model
	SimpleRC mod(
		oveAct(uExt(y=oveAct_u),activate(y=oveAct_activate)),
		oveSet(uExt(y=oveSet_u),activate(y=oveSet_activate))) "Original model with overwrites";
end wrapped;