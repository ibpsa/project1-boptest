model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput ovePum_u(unit="1", min=0.0, max=1.0) "Integer signal to control the stage of the pump either on or off";
	Modelica.Blocks.Interfaces.BooleanInput ovePum_activate "Activation for Integer signal to control the stage of the pump either on or off";
	Modelica.Blocks.Interfaces.RealInput oveTSetHea_u(unit="K", min=288.15, max=296.15) "Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetHea_activate "Activation for Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput oveTSetSup_u(unit="K", min=293.15, max=353.15) "Supply temperature setpoint of the heater";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetSup_activate "Activation for Supply temperature setpoint of the heater";
	Modelica.Blocks.Interfaces.RealInput oveTSetCoo_u(unit="K", min=296.15, max=303.15) "Zone operative temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetCoo_activate "Activation for Zone operative temperature setpoint for cooling";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput reaQHea_y(unit="W") = mod.reaQHea.y "Heating thermal power";
	Modelica.Blocks.Interfaces.RealOutput reaTSetCoo_y(unit="K") = mod.reaTSetCoo.y "Zone operative temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealOutput reaCO2RooAir_y(unit="ppm") = mod.reaCO2RooAir.y "CO2 concentration in the zone";
	Modelica.Blocks.Interfaces.RealOutput reaTSetSup_y(unit="K") = mod.reaTSetSup.y "Supply temperature setpoint of heater";
	Modelica.Blocks.Interfaces.RealOutput reaTSetHea_y(unit="K") = mod.reaTSetHea.y "Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealOutput reaPum_y(unit="1") = mod.reaPum.y "Control signal for pump";
	Modelica.Blocks.Interfaces.RealOutput reaPPum_y(unit="W") = mod.reaPPum.y "Pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput reaTRoo_y(unit="K") = mod.reaTRoo.y "Operative zone temperature";
	// Original model
	BESTESTHydronic.TestCase mod(
		ovePum(uExt(y=ovePum_u),activate(y=ovePum_activate)),
		oveTSetHea(uExt(y=oveTSetHea_u),activate(y=oveTSetHea_activate)),
		oveTSetSup(uExt(y=oveTSetSup_u),activate(y=oveTSetSup_activate)),
		oveTSetCoo(uExt(y=oveTSetCoo_u),activate(y=oveTSetCoo_activate))) "Original model with overwrites";
end wrapped;
