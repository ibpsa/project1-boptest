model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput TSetExt_u(unit="K", min=293.15, max=353.15) "Supply temperature set point of the heater";
	Modelica.Blocks.Interfaces.BooleanInput TSetExt_activate "Activation for Supply temperature set point of the heater";
	Modelica.Blocks.Interfaces.RealInput pumSetExt_u(unit="1", min=0.0, max=1.0) "Integer signal to control the stage of the pump either on or off";
	Modelica.Blocks.Interfaces.BooleanInput pumSetExt_activate "Activation for Integer signal to control the stage of the pump either on or off";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput outputP_y(unit="W") = mod.outputP.y "Pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput outputQ_y(unit="W") = mod.outputQ.y "Thermal power";
	Modelica.Blocks.Interfaces.RealOutput outputT_y(unit="K") = mod.outputT.y "Zone temperature";
	// Original model
	BESTESTHydronic.TestCase mod(
		TSetExt(uExt(y=TSetExt_u),activate(y=TSetExt_activate)),
		pumSetExt(uExt(y=pumSetExt_u),activate(y=pumSetExt_activate))) "Original model with overwrites";
end wrapped;