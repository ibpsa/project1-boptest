model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput oveTSetRooCoo_u(unit="K", min=283.15, max=308.15) "Cooling setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetRooCoo_activate "Activation for Cooling setpoint";
	Modelica.Blocks.Interfaces.RealInput oveTSetRooHea_u(unit="K", min=283.15, max=308.15) "Heating setpoint";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetRooHea_activate "Activation for Heating setpoint";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput PHea_y(unit="W") = mod.PHea.y "Heater power";
	Modelica.Blocks.Interfaces.RealOutput PFan_y(unit="W") = mod.PFan.y "Fan electrical power";
	Modelica.Blocks.Interfaces.RealOutput senTSetRooCoo_y(unit="K") = mod.senTSetRooCoo.y "Room cooling setpoint";
	Modelica.Blocks.Interfaces.RealOutput PCoo_y(unit="W") = mod.PCoo.y "Cooling electrical power";
	Modelica.Blocks.Interfaces.RealOutput TRooAir_y(unit="K") = mod.TRooAir.y "Room air temperature";
	Modelica.Blocks.Interfaces.RealOutput PPum_y(unit="W") = mod.PPum.y "Pump electrical power";
	Modelica.Blocks.Interfaces.RealOutput senTSetRooHea_y(unit="K") = mod.senTSetRooHea.y "Room heating setpoint";
	// Original model
	SingleZoneVAV.TestCaseSupervisory mod(
		oveTSetRooCoo(uExt(y=oveTSetRooCoo_u),activate(y=oveTSetRooCoo_activate)),
		oveTSetRooHea(uExt(y=oveTSetRooHea_u),activate(y=oveTSetRooHea_activate))) "Original model with overwrites";
end wrapped;