model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput regul_SDB_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_SDB_oveTsetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre2_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre2_oveTsetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput conHeaRo1_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo1_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaRo3_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo3_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput conPumHea_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conPumHea_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput Boiler_oveBoi_u(unit="1", min=0.0, max=1.0) "Boiler control signal";
	Modelica.Blocks.Interfaces.BooleanInput Boiler_oveBoi_activate "Activation for Boiler control signal";
	Modelica.Blocks.Interfaces.RealInput regul_Chaudiere_Securite_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chaudiere_Securite_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Chaudiere_Securite_oveTsetHea_u(unit="K", min=283.15, max=368.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chaudiere_Securite_oveTsetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Salon_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Salon_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput conPumHea_oveTsetHea_u(unit="K", min=283.15, max=368.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conPumHea_oveTsetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre1_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre1_oveTsetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre3_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre3_oveTsetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput conHeaSal_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaSal_oveTsetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre2_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre2_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput regul_Salon_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Salon_oveTsetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput regul_Couloir_oveTsetCoo_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.BooleanInput regul_Couloir_oveTsetCoo_activate "Activation for Zone temperature setpoint for cooling";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre3_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre3_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput regul_SDB_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_SDB_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput conHeaBoiler_oveTsetHea_u(unit="K", min=283.15, max=368.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBoiler_oveTsetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaBoiler_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBoiler_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput regul_Couloir_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Couloir_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput regul_Chambre1_ovePCoo_u(unit="W", min=-10000.0, max=0.0) "Precribed cooling power";
	Modelica.Blocks.Interfaces.BooleanInput regul_Chambre1_ovePCoo_activate "Activation for Precribed cooling power";
	Modelica.Blocks.Interfaces.RealInput conHeaRo2_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo2_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaSal_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaSal_oveActHea_activate "Activation for Actuator signal for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaBth_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBth_oveTsetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaRo1_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo1_oveTsetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaRo3_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo3_oveTsetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaRo2_oveTsetHea_u(unit="K", min=283.15, max=303.15) "Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaRo2_oveTsetHea_activate "Activation for Zone temperature setpoint for heating";
	Modelica.Blocks.Interfaces.RealInput conHeaBth_oveActHea_u(unit="1", min=0.0, max=1.0) "Actuator signal for heating";
	Modelica.Blocks.Interfaces.BooleanInput conHeaBth_oveActHea_activate "Activation for Actuator signal for heating";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo1_y(unit="W") = mod.reaHeaRo1.y "Read heating delivered to room 1";
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo2_y(unit="W") = mod.reaHeaRo2.y "Read heating delivered to room 2";
	Modelica.Blocks.Interfaces.RealOutput reaHeaRo3_y(unit="W") = mod.reaHeaRo3.y "Read heating delivered to room 3";
	Modelica.Blocks.Interfaces.RealOutput reaHeaHal_y(unit="W") = mod.reaHeaHal.y "Read heating delivered to Hall";
	Modelica.Blocks.Interfaces.RealOutput conHeaSal_reaTzon_y(unit="K") = mod.conHeaSal.reaTzon.y "Zone temperature";
	Modelica.Blocks.Interfaces.RealOutput ventil_Salon_rearelHum_y(unit="1") = mod.ventil_Salon.rearelHum.y "Zone relative humidity";
	Modelica.Blocks.Interfaces.RealOutput reaTSetCoo_y(unit="K") = mod.reaTSetCoo.y "Zone setpoint temperature";
	Modelica.Blocks.Interfaces.RealOutput reaHeaBth_y(unit="W") = mod.reaHeaBth.y "Read heating delivered to bathroom";
	Modelica.Blocks.Interfaces.RealOutput reaTAti_y(unit="K") = mod.reaTAti.y "Read attic temperature";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo3_reaTzon_y(unit="K") = mod.conHeaRo3.reaTzon.y "Zone temperature";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo2_reaTzon_y(unit="K") = mod.conHeaRo2.reaTzon.y "Zone temperature";
	Modelica.Blocks.Interfaces.RealOutput q_conv_Nuit_reaConOcc_y(unit="W/m2") = mod.q_conv_Nuit.reaConOcc.y "Convective heat gains";
	Modelica.Blocks.Interfaces.RealOutput conHeaBth_reaTzon_y(unit="K") = mod.conHeaBth.reaTzon.y "Zone temperature";
	Modelica.Blocks.Interfaces.RealOutput reaTSetHea_y(unit="K") = mod.reaTSetHea.y "Zone setpoint temperature";
	Modelica.Blocks.Interfaces.RealOutput conHeaRo1_reaTzon_y(unit="K") = mod.conHeaRo1.reaTzon.y "Zone temperature";
	Modelica.Blocks.Interfaces.RealOutput regul_Couloir_reaPcoo_y(unit="W") = mod.regul_Couloir.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaTHal_y(unit="K") = mod.reaTHal.y "Read hall temperature";
	Modelica.Blocks.Interfaces.RealOutput regul_SDB_reaPcoo_y(unit="W") = mod.regul_SDB.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput regul_Chambre1_reaPcoo_y(unit="W") = mod.regul_Chambre1.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput Boiler_reaHeaBoi_y(unit="W") = mod.Boiler.reaHeaBoi.y "Boiler thermal energy usage";
	Modelica.Blocks.Interfaces.RealOutput reaHeaSal_y(unit="W") = mod.reaHeaSal.y "Read heating delivered to Salon";
	Modelica.Blocks.Interfaces.RealOutput reaTGar_y(unit="K") = mod.reaTGar.y "Read garage temperature";
	Modelica.Blocks.Interfaces.RealOutput regul_Chambre3_reaPcoo_y(unit="W") = mod.regul_Chambre3.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput regul_Chambre2_reaPcoo_y(unit="W") = mod.regul_Chambre2.reaPcoo.y "Cooling electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput Boiler_reaPpum_y(unit="W") = mod.Boiler.reaPpum.y "Boiler pump electrical power consumption";
	Modelica.Blocks.Interfaces.RealOutput q_conv_Jour_reaConOcc_y(unit="W/m2") = mod.q_conv_Jour.reaConOcc.y "Convective heat gains";
	Modelica.Blocks.Interfaces.RealOutput regul_Salon_reaPcoo_y(unit="W") = mod.regul_Salon.reaPcoo.y "Cooling electrical power consumption";
	// Original model
	DetachedHouse_ENGIE_IBPSAP1.DetachedHouse_ENGIE_IBPSAP1_BOPTEST_v3 mod(
		regul_SDB.oveTsetCoo(uExt(y=regul_SDB_oveTsetCoo_u),activate(y=regul_SDB_oveTsetCoo_activate)),
		regul_Chambre2.oveTsetCoo(uExt(y=regul_Chambre2_oveTsetCoo_u),activate(y=regul_Chambre2_oveTsetCoo_activate)),
		conHeaRo1.oveActHea(uExt(y=conHeaRo1_oveActHea_u),activate(y=conHeaRo1_oveActHea_activate)),
		conHeaRo3.oveActHea(uExt(y=conHeaRo3_oveActHea_u),activate(y=conHeaRo3_oveActHea_activate)),
		conPumHea.oveActHea(uExt(y=conPumHea_oveActHea_u),activate(y=conPumHea_oveActHea_activate)),
		Boiler.oveBoi(uExt(y=Boiler_oveBoi_u),activate(y=Boiler_oveBoi_activate)),
		regul_Chaudiere_Securite.oveActHea(uExt(y=regul_Chaudiere_Securite_oveActHea_u),activate(y=regul_Chaudiere_Securite_oveActHea_activate)),
		regul_Chaudiere_Securite.oveTsetHea(uExt(y=regul_Chaudiere_Securite_oveTsetHea_u),activate(y=regul_Chaudiere_Securite_oveTsetHea_activate)),
		regul_Salon.ovePCoo(uExt(y=regul_Salon_ovePCoo_u),activate(y=regul_Salon_ovePCoo_activate)),
		conPumHea.oveTsetHea(uExt(y=conPumHea_oveTsetHea_u),activate(y=conPumHea_oveTsetHea_activate)),
		regul_Chambre1.oveTsetCoo(uExt(y=regul_Chambre1_oveTsetCoo_u),activate(y=regul_Chambre1_oveTsetCoo_activate)),
		regul_Chambre3.oveTsetCoo(uExt(y=regul_Chambre3_oveTsetCoo_u),activate(y=regul_Chambre3_oveTsetCoo_activate)),
		conHeaSal.oveTsetHea(uExt(y=conHeaSal_oveTsetHea_u),activate(y=conHeaSal_oveTsetHea_activate)),
		regul_Chambre2.ovePCoo(uExt(y=regul_Chambre2_ovePCoo_u),activate(y=regul_Chambre2_ovePCoo_activate)),
		regul_Salon.oveTsetCoo(uExt(y=regul_Salon_oveTsetCoo_u),activate(y=regul_Salon_oveTsetCoo_activate)),
		regul_Couloir.oveTsetCoo(uExt(y=regul_Couloir_oveTsetCoo_u),activate(y=regul_Couloir_oveTsetCoo_activate)),
		regul_Chambre3.ovePCoo(uExt(y=regul_Chambre3_ovePCoo_u),activate(y=regul_Chambre3_ovePCoo_activate)),
		regul_SDB.ovePCoo(uExt(y=regul_SDB_ovePCoo_u),activate(y=regul_SDB_ovePCoo_activate)),
		conHeaBoiler.oveTsetHea(uExt(y=conHeaBoiler_oveTsetHea_u),activate(y=conHeaBoiler_oveTsetHea_activate)),
		conHeaBoiler.oveActHea(uExt(y=conHeaBoiler_oveActHea_u),activate(y=conHeaBoiler_oveActHea_activate)),
		regul_Couloir.ovePCoo(uExt(y=regul_Couloir_ovePCoo_u),activate(y=regul_Couloir_ovePCoo_activate)),
		regul_Chambre1.ovePCoo(uExt(y=regul_Chambre1_ovePCoo_u),activate(y=regul_Chambre1_ovePCoo_activate)),
		conHeaRo2.oveActHea(uExt(y=conHeaRo2_oveActHea_u),activate(y=conHeaRo2_oveActHea_activate)),
		conHeaSal.oveActHea(uExt(y=conHeaSal_oveActHea_u),activate(y=conHeaSal_oveActHea_activate)),
		conHeaBth.oveTsetHea(uExt(y=conHeaBth_oveTsetHea_u),activate(y=conHeaBth_oveTsetHea_activate)),
		conHeaRo1.oveTsetHea(uExt(y=conHeaRo1_oveTsetHea_u),activate(y=conHeaRo1_oveTsetHea_activate)),
		conHeaRo3.oveTsetHea(uExt(y=conHeaRo3_oveTsetHea_u),activate(y=conHeaRo3_oveTsetHea_activate)),
		conHeaRo2.oveTsetHea(uExt(y=conHeaRo2_oveTsetHea_u),activate(y=conHeaRo2_oveTsetHea_activate)),
		conHeaBth.oveActHea(uExt(y=conHeaBth_oveActHea_u),activate(y=conHeaBth_oveActHea_activate))) "Original model with overwrites";
end wrapped;