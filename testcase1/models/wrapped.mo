model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveAct_u "Signal for overwrite block oveAct";
	Modelica.Blocks.Interfaces.BooleanInput oveAct_activate "Activation for overwrite block oveAct";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput ETotHea_y = mod.ETotHea.y "Measured signal for ETotHea";
	Modelica.Blocks.Interfaces.RealOutput PHea_y = mod.PHea.y "Measured signal for PHea";
	Modelica.Blocks.Interfaces.RealOutput TRooAir_y = mod.TRooAir.y "Measured signal for TRooAir";
	// Original model
	SimpleRC mod(
		oveAct(uExt(y=oveAct_u),activate(y=oveAct_activate))) "Original model with overwrites";
end wrapped;