model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput TSetExt_u(unit="K", min=293.15, max=353.15) "Supply temperature set point of the heater";
	Modelica.Blocks.Interfaces.BooleanInput TSetExt_activate "Activation for Supply temperature set point of the heater";
	Modelica.Blocks.Interfaces.RealInput oveTSetHea_u(unit="K", min=288.15, max=296.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput pumSetExt_u(unit="1", min=0.0, max=1.0) "Integer signal to control the stage of the pump either on or off";
	Modelica.Blocks.Interfaces.BooleanInput pumSetExt_activate "Activation for Integer signal to control the stage of the pump either on or off";
	Modelica.Blocks.Interfaces.RealInput oveTSetCoo_u(unit="K", min=296.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetCoo_activate "Activation for Zone temperature setpoint for cooling";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput reaTSetCoo_y(unit="K") = mod.reaTSetCoo.y "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealOutput outputCO2_y(unit="ppm") = mod.outputCO2.y "CO2 concentration in the zone";
	Modelica.Blocks.Interfaces.RealOutput outputP_y(unit="W") = mod.outputP.y "Pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput outputQ_y(unit="W") = mod.outputQ.y "Thermal power";
	Modelica.Blocks.Interfaces.RealOutput outputT_y(unit="K") = mod.outputT.y "Zone temperature";
	Modelica.Blocks.Interfaces.RealOutput reaTSetHea_y(unit="K") = mod.reaTSetHea.y "Zone air temperature setpoint for heating";
	// Original model
	BESTESTHydronic.TestCase mod(
		TSetExt(uExt(y=TSetExt_u),activate(y=TSetExt_activate)),
		oveTSetHea(uExt(y=oveTSetHea_u),activate(y=oveTSetHea_activate)),
		pumSetExt(uExt(y=pumSetExt_u),activate(y=pumSetExt_activate)),
		oveTSetCoo(uExt(y=oveTSetCoo_u),activate(y=oveTSetCoo_activate))) "Original model with overwrites";
end wrapped;