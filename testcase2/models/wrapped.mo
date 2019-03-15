model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveTSetRooCoo_u(unit="K") "Signal for overwrite block oveTSetRooCoo";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetRooCoo_activate "Activation for overwrite block oveTSetRooCoo";
	Modelica.Blocks.Interfaces.RealInput oveTSetRooHea_u(unit="K") "Signal for overwrite block oveTSetRooHea";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetRooHea_activate "Activation for overwrite block oveTSetRooHea";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput PHea_y(unit="W") = mod.PHea.y "Measured signal for PHea";
	Modelica.Blocks.Interfaces.RealOutput PFan_y(unit="W") = mod.PFan.y "Measured signal for PFan";
	Modelica.Blocks.Interfaces.RealOutput ETotFan_y(unit="J") = mod.ETotFan.y "Measured signal for ETotFan";
	Modelica.Blocks.Interfaces.RealOutput PCoo_y(unit="W") = mod.PCoo.y "Measured signal for PCoo";
	Modelica.Blocks.Interfaces.RealOutput TRooAir_y(unit="K") = mod.TRooAir.y "Measured signal for TRooAir";
	Modelica.Blocks.Interfaces.RealOutput ETotHea_y(unit="J") = mod.ETotHea.y "Measured signal for ETotHea";
	Modelica.Blocks.Interfaces.RealOutput ETotCoo_y(unit="J") = mod.ETotCoo.y "Measured signal for ETotCoo";
	Modelica.Blocks.Interfaces.RealOutput PPum_y(unit="W") = mod.PPum.y "Measured signal for PPum";
	Modelica.Blocks.Interfaces.RealOutput ETotHVAC_y(unit="J") = mod.ETotHVAC.y "Measured signal for ETotHVAC";
	Modelica.Blocks.Interfaces.RealOutput ETotPum_y(unit="J") = mod.ETotPum.y "Measured signal for ETotPum";
	// Original model
	SingleZoneVAV.TestCaseSupervisory mod(
		oveTSetRooCoo(uExt(y=oveTSetRooCoo_u),activate(y=oveTSetRooCoo_activate)),
		oveTSetRooHea(uExt(y=oveTSetRooHea_u),activate(y=oveTSetRooHea_activate))) "Original model with overwrites";
end wrapped;