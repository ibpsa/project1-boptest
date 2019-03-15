model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveSet_u(unit="K") "Signal for overwrite block oveSet";
	Modelica.Blocks.Interfaces.BooleanInput oveSet_activate "Activation for overwrite block oveSet";
	Modelica.Blocks.Interfaces.RealInput oveAct_u(unit="W") "Signal for overwrite block oveAct";
	Modelica.Blocks.Interfaces.BooleanInput oveAct_activate "Activation for overwrite block oveAct";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput EHeat_y(unit="J") = mod.EHeat.y "Measured signal for EHeat";
	Modelica.Blocks.Interfaces.RealOutput PHeat_y(unit="W") = mod.PHeat.y "Measured signal for PHeat";
	Modelica.Blocks.Interfaces.RealOutput setZone_y(unit="K") = mod.setZone.y "Measured signal for setZone";
	Modelica.Blocks.Interfaces.RealOutput TZone_y(unit="K") = mod.TZone.y "Measured signal for TZone";
	// Original model
	SimpleRC mod(
		oveSet(uExt(y=oveSet_u),activate(y=oveSet_activate)),
		oveAct(uExt(y=oveAct_u),activate(y=oveAct_activate))) "Original model with overwrites";
end wrapped;