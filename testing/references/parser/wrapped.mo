model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveSet_u(unit="K", min=283.15, max=308.15) "Zone temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveSet_activate "Activation for Zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput oveAct_u(unit="W", min=0.0, max=3000.0) "Heater thermal power";
	Modelica.Blocks.Interfaces.BooleanInput oveAct_activate "Activation for Heater thermal power";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput EHeat_y(unit="J") = mod.EHeat.y "Heater electrical energy";
	Modelica.Blocks.Interfaces.RealOutput PHeat_y(unit="W") = mod.PHeat.y "Heater electrical power";
	Modelica.Blocks.Interfaces.RealOutput setZone_y(unit="K") = mod.setZone.y "Zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput TZone_y(unit="K") = mod.TZone.y "Zone temperature";
	// Original model
	SimpleRC mod(
		oveSet(uExt(y=oveSet_u),activate(y=oveSet_activate)),
		oveAct(uExt(y=oveAct_u),activate(y=oveAct_activate))) "Original model with overwrites";
end wrapped;