model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveTsup_u "Signal for overwrite block oveTsup";
	Modelica.Blocks.Interfaces.BooleanInput oveTsup_activate "Activation for overwrite block oveTsup";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput ETotHea_y = mod.ETotHea.y "Measured signal for ETotHea";
	Modelica.Blocks.Interfaces.RealOutput PHea_y = mod.PHea.y "Measured signal for PHea";
	Modelica.Blocks.Interfaces.RealOutput TRooAir_y = mod.TRooAir.y "Measured signal for TRooAir";
	// Original model
	SingleZoneResidentialHydronic.SingleZoneResidentialHydronicControl mod(
		oveTsup(uExt(y=oveTsup_u),activate(y=oveTsup_activate))) "Original model with overwrites";
end wrapped;