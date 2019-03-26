model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveAct_u(unit="W") "Signal for overwrite block oveAct";
	Modelica.Blocks.Interfaces.BooleanInput oveAct_activate "Activation for overwrite block oveAct";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput PHea_y(unit="W") = mod.PHea.y "Measured signal for PHea";
	Modelica.Blocks.Interfaces.RealOutput TRooAir_y(unit="K") = mod.TRooAir.y "Measured signal for TRooAir";
	Modelica.Blocks.Interfaces.RealOutput ETotHea_y(unit="J") = mod.ETotHea.y "Measured signal for ETotHea";
	// Original model
	SimpleRC mod(
		oveAct(uExt(y=oveAct_u),activate(y=oveAct_activate))) "Original model with overwrites";
end wrapped;