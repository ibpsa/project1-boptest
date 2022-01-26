model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveSet_u(unit="K", min=283.15, max=308.15) "Zone temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveSet_activate "Activation for Zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput oveAct_u(unit="W", min=0.0, max=3000.0) "Control signal for heater thermal power";
	Modelica.Blocks.Interfaces.BooleanInput oveAct_activate "Activation for Control signal for heater thermal power";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput TZone_y(unit="K") = mod.TZone.y "Zone temperature";
	Modelica.Blocks.Interfaces.RealOutput PHeat_y(unit="W") = mod.PHeat.y "Heater electrical power";
	Modelica.Blocks.Interfaces.RealOutput oveSet_y(unit="K") = mod.oveSet.y "Zone temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput oveAct_y(unit="W") = mod.oveAct.y "Control signal for heater thermal power";
	// Original model
	SimpleRC mod(
		oveSet(uExt(y=oveSet_u),activate(y=oveSet_activate)),
		oveAct(uExt(y=oveAct_u),activate(y=oveAct_activate))) "Original model with overwrites";
end wrapped;
