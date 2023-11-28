model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveActNor_u(unit="W", min=-10000.0, max=10000.0) "Heater thermal power of north zone";
	Modelica.Blocks.Interfaces.BooleanInput oveActNor_activate "Activation for Heater thermal power of north zone";
	Modelica.Blocks.Interfaces.RealInput oveActSou_u(unit="W", min=-10000.0, max=10000.0) "Heater thermal power of south zone";
	Modelica.Blocks.Interfaces.BooleanInput oveActSou_activate "Activation for Heater thermal power of south zone";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput TRooAirSou_y(unit="K") = mod.TRooAirSou.y "Operative zone temperature of south zone";
	Modelica.Blocks.Interfaces.RealOutput CO2RooAirSou_y(unit="ppm") = mod.CO2RooAirSou.y "Zone air CO2 concentration of south zone";
	Modelica.Blocks.Interfaces.RealOutput PHeaNor_y(unit="W") = mod.PHeaNor.y "Heater power of north zone";
	Modelica.Blocks.Interfaces.RealOutput CO2RooAirNor_y(unit="ppm") = mod.CO2RooAirNor.y "Zone air CO2 concentration of north zone";
	Modelica.Blocks.Interfaces.RealOutput TRooAirNor_y(unit="K") = mod.TRooAirNor.y "Zone air temperature of north zone";
	Modelica.Blocks.Interfaces.RealOutput PHeaSou_y(unit="W") = mod.PHeaSou.y "Heater power of south zone";
	Modelica.Blocks.Interfaces.RealOutput oveActNor_y(unit="W") = mod.oveActNor.y "Heater thermal power of north zone";
	Modelica.Blocks.Interfaces.RealOutput oveActSou_y(unit="W") = mod.oveActSou.y "Heater thermal power of south zone";
	// Original model
	TwoZones mod(
		oveActNor(uExt(y=oveActNor_u),activate(y=oveActNor_activate)),
		oveActSou(uExt(y=oveActSou_u),activate(y=oveActSou_activate))) "Original model with overwrites";
end wrapped;
