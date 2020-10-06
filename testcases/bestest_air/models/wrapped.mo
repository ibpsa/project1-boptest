model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput con_oveTSetCoo_u(unit="K", min=296.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput con_oveTSetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput con_oveTSetHea_u(unit="K", min=288.15, max=296.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput con_oveTSetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput fcu_oveTSup_u(unit="K", min=285.15, max=313.15) "Supply air temperature setpoint";
	Modelica.Blocks.Interfaces.BooleanInput fcu_oveTSup_activate "Activation for Supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealInput fcu_oveFan_u(unit="1", min=0.0, max=1.0) "Fan control signal as air mass flow rate normalized to the design air mass flow rate";
	Modelica.Blocks.Interfaces.BooleanInput fcu_oveFan_activate "Activation for Fan control signal as air mass flow rate normalized to the design air mass flow rate";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPFan_y(unit="W") = mod.fcu.reaPFan.y "Supply fan electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput zon_reaPLig_y(unit="W") = mod.zon.reaPLig.y "Lighting power submeter";
	Modelica.Blocks.Interfaces.RealOutput zon_reaTRooAir_y(unit="K") = mod.zon.reaTRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput zon_reaPPlu_y(unit="W") = mod.zon.reaPPlu.y "Plug load power submeter";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFanSet_y(unit="1") = mod.fcu.reaFanSet.y "Fan control signal setpoint as air mass flow rate normalized to the design air mass flow rate";
	Modelica.Blocks.Interfaces.RealOutput con_reaTSetHea_y(unit="K") = mod.con.reaTSetHea.y "Zone air temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaTSup_y(unit="K") = mod.fcu.reaTSup.y "Supply air temperature setpoint";
	Modelica.Blocks.Interfaces.RealOutput zon_reaCO2RooAir_y(unit="ppm") = mod.zon.reaCO2RooAir.y "Zone air CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPHea_y(unit="W") = mod.fcu.reaPHea.y "Heating thermal power consumption";
	Modelica.Blocks.Interfaces.RealOutput con_reaTSetCoo_y(unit="K") = mod.con.reaTSetCoo.y "Zone air temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaPCoo_y(unit="W") = mod.fcu.reaPCoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput fcu_reaFloSup_y(unit="kg/s") = mod.fcu.reaFloSup.y "Supply air mass flow rate";
	// Original model
	BESTESTAir.TestCases.TestCase_Ideal mod(
		con.oveTSetCoo(uExt(y=con_oveTSetCoo_u),activate(y=con_oveTSetCoo_activate)),
		con.oveTSetHea(uExt(y=con_oveTSetHea_u),activate(y=con_oveTSetHea_activate)),
		fcu.oveTSup(uExt(y=fcu_oveTSup_u),activate(y=fcu_oveTSup_activate)),
		fcu.oveFan(uExt(y=fcu_oveFan_u),activate(y=fcu_oveFan_activate))) "Original model with overwrites";
end wrapped;