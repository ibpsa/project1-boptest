model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveTsup_u(unit="K") "Signal for overwrite block oveTsup";
	Modelica.Blocks.Interfaces.BooleanInput oveTsup_activate "Activation for overwrite block oveTsup";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput heaRead_y(unit="W") = mod.heaRead.y "Measured signal for heaRead";
	Modelica.Blocks.Interfaces.RealOutput TRooAir_y(unit="K") = mod.TRooAir.y "Measured signal for TRooAir";
	Modelica.Blocks.Interfaces.RealOutput TSupRead_y(unit="K") = mod.TSupRead.y "Measured signal for TSupRead";
	Modelica.Blocks.Interfaces.RealOutput pumpRead_y(unit="W") = mod.pumpRead.y "Measured signal for pumpRead";
	// Original model
	SingleZoneResidentialHydronic.SingleZoneResidentialHydronicBOPTEST_withBaseline mod(
		oveTsup(uExt(y=oveTsup_u),activate(y=oveTsup_activate))) "Original model with overwrites";
end wrapped;