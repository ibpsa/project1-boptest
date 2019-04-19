model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveAct_u(unit="W") "Heater thermal power";
	Modelica.Blocks.Interfaces.BooleanInput oveAct_activate "Activation for Heater thermal power";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput PHea_y(unit="W") = mod.PHea.y "Heater power";
	Modelica.Blocks.Interfaces.RealOutput TRooAir_y(unit="K") = mod.TRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput ETotHea_y(unit="J") = mod.ETotHea.y "Heater energy";
	// Original model
	SimpleRC mod(
		oveAct(uExt(y=oveAct_u),activate(y=oveAct_activate))) "Original model with overwrites";
end wrapped;