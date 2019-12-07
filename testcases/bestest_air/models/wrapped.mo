model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput con_oveTSetCoo_u(unit="K", min=296.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput con_oveTSetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput con_oveTSetHea_u(unit="K", min=288.15, max=296.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput con_oveTSetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput fcu_oveHeaVal_u(unit="1", min=0.0, max=1.0) "Heating valve control signal";
	Modelica.Blocks.Interfaces.BooleanInput fcu_oveHeaVal_activate "Activation for Heating valve control signal";
	Modelica.Blocks.Interfaces.RealInput fcu_oveFan_u(unit="1", min=0.0, max=1.0) "Fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput fcu_oveFan_activate "Activation for Fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput fcu_oveCooVal_u(unit="1", min=0.0, max=1.0) "Cooling valve control signal";
	Modelica.Blocks.Interfaces.BooleanInput fcu_oveCooVal_activate "Activation for Cooling valve control signal";
	Modelica.Blocks.Interfaces.RealInput fcu_oveFanSta_u(unit="1", min=0.0, max=1.0) "Fan status control signal";
	Modelica.Blocks.Interfaces.BooleanInput fcu_oveFanSta_activate "Activation for Fan status control signal";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPFan_y(unit="W") = mod.fcu.reaPFan.y "Supply fan electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput zon_reaPLig_y(unit="W") = mod.zon.reaPLig.y "Lighting power submeter";
	Modelica.Blocks.Interfaces.RealOutput zon_reaTRooAir_y(unit="K") = mod.zon.reaTRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPCoo_y(unit="W") = mod.fcu.reaPCoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPHea_y(unit="W") = mod.fcu.reaPHea.y "Heating thermal power consumption";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFloCoo_y(unit="kg/s") = mod.fcu.reaFloCoo.y "Cooling coil water flow rate";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFloHea_y(unit="kg/s") = mod.fcu.reaFloHea.y "Heating coil water flow rate";
	Modelica.Blocks.Interfaces.RealOutput con_reaTSetHea_y(unit="K") = mod.con.reaTSetHea.y "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaTCooLea_y(unit="K") = mod.fcu.reaTCooLea.y "Cooling coil water leaving temperature";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaTSup_y(unit="K") = mod.fcu.reaTSup.y "Supply air temperature";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaTHeaLea_y(unit="K") = mod.fcu.reaTHeaLea.y "Heating coil water leaving temperature";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaCooVal_y(unit="1") = mod.fcu.reaCooVal.y "Cooling valve control signal";
	Modelica.Blocks.Interfaces.RealOutput zon_reaPPlu_y(unit="W") = mod.zon.reaPPlu.y "Plug load power submeter";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFanSpeSet_y(unit="1") = mod.fcu.reaFanSpeSet.y "Supply fan speed setpoint";
	Modelica.Blocks.Interfaces.RealOutput con_reaTSetCoo_y(unit="K") = mod.con.reaTSetCoo.y "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaHeaVal_y(unit="1") = mod.fcu.reaHeaVal.y "Heating valve control signal";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFloSup_y(unit="kg/s") = mod.fcu.reaFloSup.y "Supply air mass flow rate";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaTRet_y(unit="K") = mod.fcu.reaTRet.y "Return air temperature";
	// Original model
	BESTESTAir.TestCases.TestCase mod(
		con.oveTSetCoo(uExt(y=con_oveTSetCoo_u),activate(y=con_oveTSetCoo_activate)),
		con.oveTSetHea(uExt(y=con_oveTSetHea_u),activate(y=con_oveTSetHea_activate)),
		fcu.oveHeaVal(uExt(y=fcu_oveHeaVal_u),activate(y=fcu_oveHeaVal_activate)),
		fcu.oveFan(uExt(y=fcu_oveFan_u),activate(y=fcu_oveFan_activate)),
		fcu.oveCooVal(uExt(y=fcu_oveCooVal_u),activate(y=fcu_oveCooVal_activate)),
		fcu.oveFanSta(uExt(y=fcu_oveFanSta_u),activate(y=fcu_oveFanSta_activate))) "Original model with overwrites";
end wrapped;