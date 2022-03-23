model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput hydronicSystem_oveMDayZ_u(unit="1", min=0.0, max=1.0) "Signal Day zone valve";
	Modelica.Blocks.Interfaces.BooleanInput hydronicSystem_oveMDayZ_activate "Activation for Signal Day zone valve";
	Modelica.Blocks.Interfaces.RealInput hydronicSystem_oveTHea_u(unit="K", min=273.15, max=318.15) "Heat system supply temperature";
	Modelica.Blocks.Interfaces.BooleanInput hydronicSystem_oveTHea_activate "Activation for Heat system supply temperature";
	Modelica.Blocks.Interfaces.RealInput hydronicSystem_oveMNigZ_u(unit="1", min=0.0, max=1.0) "Signal Night zone valve";
	Modelica.Blocks.Interfaces.BooleanInput hydronicSystem_oveMNigZ_activate "Activation for Signal Night zone valve";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput DayZon_reaPowQint_y(unit="W") = mod.DayZon.reaPowQint.y "Internal heat gains";
	Modelica.Blocks.Interfaces.RealOutput DayZon_MFloHea_y(unit="kg/s") = mod.DayZon.MFloHea.y "Mass flow rate floor heating";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_reaCOPhp_y(unit="1") = mod.hydronicSystem.reaCOPhp.y "air source heat pump COP";
	Modelica.Blocks.Interfaces.RealOutput NigZone_TsupFloHea_y(unit="K") = mod.NigZone.TsupFloHea.y "Zone supply temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_PeleHeaPum_y(unit="W") = mod.hydronicSystem.PeleHeaPum.y "Electric consumption of the heat pump";
	Modelica.Blocks.Interfaces.RealOutput NigZone_reaPLig_y(unit="W") = mod.NigZone.reaPLig.y "Lighting power submeter";
	Modelica.Blocks.Interfaces.RealOutput NigZone_TretFloHea_y(unit="K") = mod.NigZone.TretFloHea.y "Zone return temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput DayZon_reaPLig_y(unit="W") = mod.DayZon.reaPLig.y "Lighting power submeter";
	Modelica.Blocks.Interfaces.RealOutput NigZone_reaPPlu_y(unit="W") = mod.NigZone.reaPPlu.y "Plug load power submeter";
	Modelica.Blocks.Interfaces.RealOutput NigZone_reaPowQint_y(unit="W") = mod.NigZone.reaPowQint.y "Internal heat gains";
	Modelica.Blocks.Interfaces.RealOutput DayZon_TavgFloHea_y(unit="K") = mod.DayZon.TavgFloHea.y "Zone average temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput NigZone_TavgFloHea_y(unit="K") = mod.NigZone.TavgFloHea.y "Zone average temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput DayZon_reaTRooAir_y(unit="K") = mod.DayZon.reaTRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput DayZon_reaCO2RooAir_y(unit="ppm") = mod.DayZon.reaCO2RooAir.y "Zone air CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput NigZone_reaCO2RooAir_y(unit="ppm") = mod.NigZone.reaCO2RooAir.y "Zone air CO2 concentration";
	Modelica.Blocks.Interfaces.RealOutput DayZon_TretFloHea_y(unit="K") = mod.DayZon.TretFloHea.y "Zone return temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput DayZon_reaPPlu_y(unit="W") = mod.DayZon.reaPPlu.y "Plug load power submeter";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_reaMNigZ_y(unit="1") = mod.hydronicSystem.reaMNigZ.y "Signal Night zone valve";
	Modelica.Blocks.Interfaces.RealOutput NigZone_reaTRooAir_y(unit="K") = mod.NigZone.reaTRooAir.y "Zone air temperature";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_TretFloHea_y(unit="K") = mod.hydronicSystem.TretFloHea.y "Zone return temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_reaTHeat_y(unit="K") = mod.hydronicSystem.reaTHeat.y "Heat system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput DayZon_reaPowFlooHea_y(unit="W") = mod.DayZon.reaPowFlooHea.y "Floor heating power";
	Modelica.Blocks.Interfaces.RealOutput NigZone_MFloHea_y(unit="kg/s") = mod.NigZone.MFloHea.y "Mass flow rate floor heating";
	Modelica.Blocks.Interfaces.RealOutput NigZone_reaPowFlooHea_y(unit="W") = mod.NigZone.reaPowFlooHea.y "Floor heating power";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_reaMDayZ_y(unit="1") = mod.hydronicSystem.reaMDayZ.y "Signal Day zone valve";
	Modelica.Blocks.Interfaces.RealOutput DayZon_TsupFloHea_y(unit="K") = mod.DayZon.TsupFloHea.y "Zone supply temperature floor heating";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_oveMDayZ_y(unit="1") = mod.hydronicSystem.oveMDayZ.y "Signal Day zone valve";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_oveTHea_y(unit="K") = mod.hydronicSystem.oveTHea.y "Heat system supply temperature";
	Modelica.Blocks.Interfaces.RealOutput hydronicSystem_oveMNigZ_y(unit="1") = mod.hydronicSystem.oveMNigZ.y "Signal Night zone valve";
	// Original model
	TwoZoneApartmentHydronic.TestCases.ApartmentModelQHTyp mod(
		hydronicSystem.oveMDayZ(uExt(y=hydronicSystem_oveMDayZ_u),activate(y=hydronicSystem_oveMDayZ_activate)),
		hydronicSystem.oveTHea(uExt(y=hydronicSystem_oveTHea_u),activate(y=hydronicSystem_oveTHea_activate)),
		hydronicSystem.oveMNigZ(uExt(y=hydronicSystem_oveMNigZ_u),activate(y=hydronicSystem_oveMNigZ_activate))) "Original model with overwrites";
end wrapped;
