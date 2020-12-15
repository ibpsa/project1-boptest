model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput ovePum_u(unit="1", min=0.0, max=1.0) "Integer signal to control the emission circuit pump either on or off";
	Modelica.Blocks.Interfaces.BooleanInput ovePum_activate "Activation for Integer signal to control the emission circuit pump either on or off";
	Modelica.Blocks.Interfaces.RealInput oveHeaPumY_u(unit="1", min=0.0, max=1.0) "Heat pump modulating signal for compressor speed between 0 (not working) and 1 (working at maximum capacity)";
	Modelica.Blocks.Interfaces.BooleanInput oveHeaPumY_activate "Activation for Heat pump modulating signal for compressor speed between 0 (not working) and 1 (working at maximum capacity)";
	Modelica.Blocks.Interfaces.RealInput oveTSetHea_u(unit="K", min=288.15, max=296.15) "Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetHea_activate "Activation for Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput oveFan_u(unit="1", min=0.0, max=1.0) "Integer signal to control the heat pump evaporator fan either on or off";
	Modelica.Blocks.Interfaces.BooleanInput oveFan_activate "Activation for Integer signal to control the heat pump evaporator fan either on or off";
	Modelica.Blocks.Interfaces.RealInput oveTSetCoo_u(unit="K", min=296.15, max=303.15) "Zone operative temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetCoo_activate "Activation for Zone operative temperature setpoint for cooling";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput reaQFloHea_y(unit="W") = mod.reaQFloHea.y "Floor heating thermal power released to the zone";
	Modelica.Blocks.Interfaces.RealOutput reaTSetCoo_y(unit="K") = mod.reaTSetCoo.y "Zone operative temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealOutput reaQHeaPumEva_y(unit="W") = mod.reaQHeaPumEva.y "Heat pump thermal power exchanged in the evaporator";
	Modelica.Blocks.Interfaces.RealOutput reaTRet_y(unit="K") = mod.reaTRet.y "Return water temperature from radiant floor";
	Modelica.Blocks.Interfaces.RealOutput reaTZon_y(unit="K") = mod.reaTZon.y "Operative zone temperature";
	Modelica.Blocks.Interfaces.RealOutput reaHeaPumY_y(unit="1") = mod.reaHeaPumY.y "Block for reading the heat pump modulating signal";
	Modelica.Blocks.Interfaces.RealOutput reaPFan_y(unit="W") = mod.reaPFan.y "Electrical power of the heat pump evaporator fan";
	Modelica.Blocks.Interfaces.RealOutput reaFan_y(unit="1") = mod.reaFan.y "Control signal for fan";
	Modelica.Blocks.Interfaces.RealOutput reaPPumEmi_y(unit="W") = mod.reaPPumEmi.y "Emission circuit pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput reaCO2RooAir_y(unit="ppm") = mod.reaCO2RooAir.y "CO2 concentration in the zone";
	Modelica.Blocks.Interfaces.RealOutput reaTSetHea_y(unit="K") = mod.reaTSetHea.y "Zone operative temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealOutput reaQHeaPumCon_y(unit="W") = mod.reaQHeaPumCon.y "Heat pump thermal power exchanged in the condenser";
	Modelica.Blocks.Interfaces.RealOutput reaPum_y(unit="1") = mod.reaPum.y "Control signal for emission cirquit pump";
	Modelica.Blocks.Interfaces.RealOutput reaPHeaPum_y(unit="W") = mod.reaPHeaPum.y "Heat pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput reaTSup_y(unit="K") = mod.reaTSup.y "Supply water temperature to radiant floor";
	Modelica.Blocks.Interfaces.RealOutput reaCOP_y(unit="1") = mod.reaCOP.y "Heat pump COP";
	// Original model
	BESTESTHydronicHeatPump.TestCase mod(
		ovePum(uExt(y=ovePum_u),activate(y=ovePum_activate)),
		oveHeaPumY(uExt(y=oveHeaPumY_u),activate(y=oveHeaPumY_activate)),
		oveTSetHea(uExt(y=oveTSetHea_u),activate(y=oveTSetHea_activate)),
		oveFan(uExt(y=oveFan_u),activate(y=oveFan_activate)),
		oveTSetCoo(uExt(y=oveTSetCoo_u),activate(y=oveTSetCoo_activate))) "Original model with overwrites";
end wrapped;
