model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput con_oveTSupSetHea_u(unit="K", min=303.15, max=313.15) "Supply air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput con_oveTSupSetHea_activate "Activation for Supply air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput con_oveTSupSetCoo_u(unit="K", min=285.15, max=291.15) "Supply air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput con_oveTSupSetCoo_activate "Activation for Supply air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput oveTSetCoo_u(unit="K", min=296.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput oveTSetHea_u(unit="K", min=288.15, max=296.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput con_oveFan_u(unit="1", min=0.0, max=1.0) "Fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput con_oveFan_activate "Activation for Fan speed control signal";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput zon_reaPLig_y(unit="W") = mod.zon.reaPLig.y "Lighting power submeter";
	Modelica.Blocks.Interfaces.RealOutput zon_reaPPlu_y(unit="W") = mod.zon.reaPPlu.y "Plug load power submeter";
	Modelica.Blocks.Interfaces.RealOutput reaPCoo_y(unit="W") = mod.reaPCoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaTSupSet_y(unit="K") = mod.fcu.reaTSupSet.y "Supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput reaPFan_y(unit="W") = mod.reaPFan.y "Supply fan electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaPHea_y(unit="W") = mod.reaPHea.y "Heating thermal power consumption";
	Modelica.Blocks.Interfaces.RealOutput con_reaTSetHea_y(unit="K") = mod.con.reaTSetHea.y "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFanSpeSet_y(unit="1") = mod.fcu.reaFanSpeSet.y "Supply fan speed setpoint";
	Modelica.Blocks.Interfaces.RealOutput reaTRooAir_y(unit="K") = mod.reaTRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaTSup_y(unit="K") = mod.fcu.reaTSup.y "Supply air temperature";
	Modelica.Blocks.Interfaces.RealOutput con_reaTSetCoo_y(unit="K") = mod.con.reaTSetCoo.y "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFloSup_y(unit="kg/s") = mod.fcu.reaFloSup.y "Supply air mass flow rate";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaTRet_y(unit="K") = mod.fcu.reaTRet.y "Return air temperature";
	// Original model
	BESTESTAir.TestCases.TestCase mod(
		con.oveTSupSetHea(uExt(y=con_oveTSupSetHea_u),activate(y=con_oveTSupSetHea_activate)),
		con.oveTSupSetCoo(uExt(y=con_oveTSupSetCoo_u),activate(y=con_oveTSupSetCoo_activate)),
		oveTSetCoo(uExt(y=oveTSetCoo_u),activate(y=oveTSetCoo_activate)),
		oveTSetHea(uExt(y=oveTSetHea_u),activate(y=oveTSetHea_activate)),
		con.oveFan(uExt(y=con_oveFan_u),activate(y=con_oveFan_activate))) "Original model with overwrites";
end wrapped;