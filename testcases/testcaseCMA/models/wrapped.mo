model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput conVAVSou_oveTRooHeaSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room heating temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVSou_oveTRooHeaSet_activate "Activation for Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealInput conVAVEas_oveTRooCooSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVEas_oveTRooCooSet_activate "Activation for Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealInput oveTSetHea_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating set point";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetHea_activate "Activation for Heating set point";
	Modelica.Blocks.Interfaces.RealInput conVAVWes_oveVal_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating valve set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVWes_oveVal_activate "Activation for Heating valve set point";
	Modelica.Blocks.Interfaces.RealInput modeSelector_oveFanMod_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Overwrite the fan mode";
	Modelica.Blocks.Interfaces.BooleanInput modeSelector_oveFanMod_activate "Activation for Overwrite the fan mode";
	Modelica.Blocks.Interfaces.RealInput sou_subConHea_u(unit="W", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating input to the zone";
	Modelica.Blocks.Interfaces.BooleanInput sou_subConHea_activate "Activation for Heating input to the zone";
	Modelica.Blocks.Interfaces.RealInput conVAVEas_oveTRooHeaSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room heating temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVEas_oveTRooHeaSet_activate "Activation for Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealInput conVAVEas_oveDam_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Damper set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVEas_oveDam_activate "Activation for Damper set point";
	Modelica.Blocks.Interfaces.RealInput conVAVEas_oveVal_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating valve set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVEas_oveVal_activate "Activation for Heating valve set point";
	Modelica.Blocks.Interfaces.RealInput conVAVWes_oveTRooCooSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVWes_oveTRooCooSet_activate "Activation for Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealInput conVAVCor_oveDam_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Damper set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVCor_oveDam_activate "Activation for Damper set point";
	Modelica.Blocks.Interfaces.RealInput conVAVSou_oveVal_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating valve set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVSou_oveVal_activate "Activation for Heating valve set point";
	Modelica.Blocks.Interfaces.RealInput conVAVNor_oveDam_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Damper set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVNor_oveDam_activate "Activation for Damper set point";
	Modelica.Blocks.Interfaces.RealInput nor_subConHea_u(unit="W", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating input to the zone";
	Modelica.Blocks.Interfaces.BooleanInput nor_subConHea_activate "Activation for Heating input to the zone";
	Modelica.Blocks.Interfaces.RealInput conVAVNor_oveVal_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating valve set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVNor_oveVal_activate "Activation for Heating valve set point";
	Modelica.Blocks.Interfaces.RealInput conVAVWes_oveTRooHeaSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room heating temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVWes_oveTRooHeaSet_activate "Activation for Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealInput conVAVCor_oveVal_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating valve set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVCor_oveVal_activate "Activation for Heating valve set point";
	Modelica.Blocks.Interfaces.RealInput oveTSetCoo_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Cooling set point";
	Modelica.Blocks.Interfaces.BooleanInput oveTSetCoo_activate "Activation for Cooling set point";
	Modelica.Blocks.Interfaces.RealInput conVAVCor_oveTRooHeaSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room heating temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVCor_oveTRooHeaSet_activate "Activation for Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealInput cor_subConHea_u(unit="W", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating input to the zone";
	Modelica.Blocks.Interfaces.BooleanInput cor_subConHea_activate "Activation for Heating input to the zone";
	Modelica.Blocks.Interfaces.RealInput wes_subConHea_u(unit="W", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating input to the zone";
	Modelica.Blocks.Interfaces.BooleanInput wes_subConHea_activate "Activation for Heating input to the zone";
	Modelica.Blocks.Interfaces.RealInput conVAVSou_oveDam_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Damper set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVSou_oveDam_activate "Activation for Damper set point";
	Modelica.Blocks.Interfaces.RealInput conVAVNor_oveTRooCooSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVNor_oveTRooCooSet_activate "Activation for Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealInput conVAVWes_oveDam_u(unit="None", min=-1.79769313486e+308, max=1.79769313486e+308) "Damper set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVWes_oveDam_activate "Activation for Damper set point";
	Modelica.Blocks.Interfaces.RealInput conVAVCor_oveTRooCooSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVCor_oveTRooCooSet_activate "Activation for Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealInput conVAVSou_oveTRooCooSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVSou_oveTRooCooSet_activate "Activation for Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealInput eas_subConHea_u(unit="W", min=-1.79769313486e+308, max=1.79769313486e+308) "Heating input to the zone";
	Modelica.Blocks.Interfaces.BooleanInput eas_subConHea_activate "Activation for Heating input to the zone";
	Modelica.Blocks.Interfaces.RealInput conVAVNor_oveTRooHeaSet_u(unit="K", min=-1.79769313486e+308, max=1.79769313486e+308) "Room heating temperature set point";
	Modelica.Blocks.Interfaces.BooleanInput conVAVNor_oveTRooHeaSet_activate "Activation for Room heating temperature set point";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput senGasHea_y(unit="W") = mod.senGasHea.y "Thermal power exchanged";
	Modelica.Blocks.Interfaces.RealOutput conVAVNor_senTSup_y(unit="K") = mod.conVAVNor.senTSup.y "Air supply temperature";
	Modelica.Blocks.Interfaces.RealOutput conVAVWes_senTRooHeaSet_y(unit="K") = mod.conVAVWes.senTRooHeaSet.y "Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVNor_senDamSet_y(unit="None") = mod.conVAVNor.senDamSet.y "Damper set point";
	Modelica.Blocks.Interfaces.RealOutput cor_senACH_y(unit="None") = mod.cor.senACH.y "Air change per hour";
	Modelica.Blocks.Interfaces.RealOutput conVAVEas_senTRooAir_y(unit="K") = mod.conVAVEas.senTRooAir.y "Air room temperature";
	Modelica.Blocks.Interfaces.RealOutput wes_senACH_y(unit="None") = mod.wes.senACH.y "Air change per hour";
	Modelica.Blocks.Interfaces.RealOutput eas_senACH_y(unit="None") = mod.eas.senACH.y "Air change per hour";
	Modelica.Blocks.Interfaces.RealOutput conVAVNor_senTRooCooSet_y(unit="K") = mod.conVAVNor.senTRooCooSet.y "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealOutput sou_senPowVAV_y(unit="W") = mod.sou.senPowVAV.y "Thermal power exchanged";
	Modelica.Blocks.Interfaces.RealOutput conVAVSou_senTRooCooSet_y(unit="K") = mod.conVAVSou.senTRooCooSet.y "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVCor_senTRooAir_y(unit="K") = mod.conVAVCor.senTRooAir.y "Air room temperature";
	Modelica.Blocks.Interfaces.RealOutput conVAVEas_senDamSet_y(unit="None") = mod.conVAVEas.senDamSet.y "Damper set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVNor_senTRooAir_y(unit="K") = mod.conVAVNor.senTRooAir.y "Air room temperature";
	Modelica.Blocks.Interfaces.RealOutput conVAVEas_senTSup_y(unit="K") = mod.conVAVEas.senTSup.y "Air supply temperature";
	Modelica.Blocks.Interfaces.RealOutput conVAVWes_senTRooAir_y(unit="K") = mod.conVAVWes.senTRooAir.y "Air room temperature";
	Modelica.Blocks.Interfaces.RealOutput conVAVWes_senValSet_y(unit="None") = mod.conVAVWes.senValSet.y "Heating valve set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVSou_senValSet_y(unit="None") = mod.conVAVSou.senValSet.y "Heating valve set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVCor_senTSup_y(unit="K") = mod.conVAVCor.senTSup.y "Air supply temperature";
	Modelica.Blocks.Interfaces.RealOutput conVAVCor_senValSet_y(unit="None") = mod.conVAVCor.senValSet.y "Heating valve set point";
	Modelica.Blocks.Interfaces.RealOutput senPowCoo_y(unit="W") = mod.senPowCoo.y "Thermal power exchanged by cooCoi";
	Modelica.Blocks.Interfaces.RealOutput nor_senPowVAV_y(unit="W") = mod.nor.senPowVAV.y "Thermal power exchanged";
	Modelica.Blocks.Interfaces.RealOutput conVAVWes_senTSup_y(unit="K") = mod.conVAVWes.senTSup.y "Air supply temperature";
	Modelica.Blocks.Interfaces.RealOutput nor_senACH_y(unit="None") = mod.nor.senACH.y "Air change per hour";
	Modelica.Blocks.Interfaces.RealOutput conVAVSou_senDamSet_y(unit="None") = mod.conVAVSou.senDamSet.y "Damper set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVNor_senTRooHeaSet_y(unit="K") = mod.conVAVNor.senTRooHeaSet.y "Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVSou_senTSup_y(unit="K") = mod.conVAVSou.senTSup.y "Air supply temperature";
	Modelica.Blocks.Interfaces.RealOutput conVAVWes_senDamSet_y(unit="None") = mod.conVAVWes.senDamSet.y "Damper set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVEas_senTRooCooSet_y(unit="K") = mod.conVAVEas.senTRooCooSet.y "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVCor_senTRooHeaSet_y(unit="K") = mod.conVAVCor.senTRooHeaSet.y "Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealOutput eas_senPowVAV_y(unit="W") = mod.eas.senPowVAV.y "Thermal power exchanged";
	Modelica.Blocks.Interfaces.RealOutput conVAVSou_senTRooAir_y(unit="K") = mod.conVAVSou.senTRooAir.y "Air room temperature";
	Modelica.Blocks.Interfaces.RealOutput sou_senACH_y(unit="None") = mod.sou.senACH.y "Air change per hour";
	Modelica.Blocks.Interfaces.RealOutput conVAVNor_senValSet_y(unit="None") = mod.conVAVNor.senValSet.y "Heating valve set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVWes_senTRooCooSet_y(unit="K") = mod.conVAVWes.senTRooCooSet.y "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealOutput wes_senPowVAV_y(unit="W") = mod.wes.senPowVAV.y "Thermal power exchanged";
	Modelica.Blocks.Interfaces.RealOutput cor_senPowVAV_y(unit="W") = mod.cor.senPowVAV.y "Thermal power exchanged";
	Modelica.Blocks.Interfaces.RealOutput conVAVCor_senTRooCooSet_y(unit="K") = mod.conVAVCor.senTRooCooSet.y "Room cooling temperature set point";
	Modelica.Blocks.Interfaces.RealOutput senPowFan_y(unit="W") = mod.senPowFan.y "Fan power";
	Modelica.Blocks.Interfaces.RealOutput conVAVEas_senTRooHeaSet_y(unit="K") = mod.conVAVEas.senTRooHeaSet.y "Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVCor_senDamSet_y(unit="None") = mod.conVAVCor.senDamSet.y "Damper set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVSou_senTRooHeaSet_y(unit="K") = mod.conVAVSou.senTRooHeaSet.y "Room heating temperature set point";
	Modelica.Blocks.Interfaces.RealOutput conVAVEas_senValSet_y(unit="None") = mod.conVAVEas.senValSet.y "Heating valve set point";
	// Original model
	TestcaseCMA.TestcaseCMA mod(
		conVAVSou.oveTRooHeaSet(uExt(y=conVAVSou_oveTRooHeaSet_u),activate(y=conVAVSou_oveTRooHeaSet_activate)),
		conVAVEas.oveTRooCooSet(uExt(y=conVAVEas_oveTRooCooSet_u),activate(y=conVAVEas_oveTRooCooSet_activate)),
		oveTSetHea(uExt(y=oveTSetHea_u),activate(y=oveTSetHea_activate)),
		conVAVWes.oveVal(uExt(y=conVAVWes_oveVal_u),activate(y=conVAVWes_oveVal_activate)),
		modeSelector.oveFanMod(uExt(y=modeSelector_oveFanMod_u),activate(y=modeSelector_oveFanMod_activate)),
		sou.subConHea(uExt(y=sou_subConHea_u),activate(y=sou_subConHea_activate)),
		conVAVEas.oveTRooHeaSet(uExt(y=conVAVEas_oveTRooHeaSet_u),activate(y=conVAVEas_oveTRooHeaSet_activate)),
		conVAVEas.oveDam(uExt(y=conVAVEas_oveDam_u),activate(y=conVAVEas_oveDam_activate)),
		conVAVEas.oveVal(uExt(y=conVAVEas_oveVal_u),activate(y=conVAVEas_oveVal_activate)),
		conVAVWes.oveTRooCooSet(uExt(y=conVAVWes_oveTRooCooSet_u),activate(y=conVAVWes_oveTRooCooSet_activate)),
		conVAVCor.oveDam(uExt(y=conVAVCor_oveDam_u),activate(y=conVAVCor_oveDam_activate)),
		conVAVSou.oveVal(uExt(y=conVAVSou_oveVal_u),activate(y=conVAVSou_oveVal_activate)),
		conVAVNor.oveDam(uExt(y=conVAVNor_oveDam_u),activate(y=conVAVNor_oveDam_activate)),
		nor.subConHea(uExt(y=nor_subConHea_u),activate(y=nor_subConHea_activate)),
		conVAVNor.oveVal(uExt(y=conVAVNor_oveVal_u),activate(y=conVAVNor_oveVal_activate)),
		conVAVWes.oveTRooHeaSet(uExt(y=conVAVWes_oveTRooHeaSet_u),activate(y=conVAVWes_oveTRooHeaSet_activate)),
		conVAVCor.oveVal(uExt(y=conVAVCor_oveVal_u),activate(y=conVAVCor_oveVal_activate)),
		oveTSetCoo(uExt(y=oveTSetCoo_u),activate(y=oveTSetCoo_activate)),
		conVAVCor.oveTRooHeaSet(uExt(y=conVAVCor_oveTRooHeaSet_u),activate(y=conVAVCor_oveTRooHeaSet_activate)),
		cor.subConHea(uExt(y=cor_subConHea_u),activate(y=cor_subConHea_activate)),
		wes.subConHea(uExt(y=wes_subConHea_u),activate(y=wes_subConHea_activate)),
		conVAVSou.oveDam(uExt(y=conVAVSou_oveDam_u),activate(y=conVAVSou_oveDam_activate)),
		conVAVNor.oveTRooCooSet(uExt(y=conVAVNor_oveTRooCooSet_u),activate(y=conVAVNor_oveTRooCooSet_activate)),
		conVAVWes.oveDam(uExt(y=conVAVWes_oveDam_u),activate(y=conVAVWes_oveDam_activate)),
		conVAVCor.oveTRooCooSet(uExt(y=conVAVCor_oveTRooCooSet_u),activate(y=conVAVCor_oveTRooCooSet_activate)),
		conVAVSou.oveTRooCooSet(uExt(y=conVAVSou_oveTRooCooSet_u),activate(y=conVAVSou_oveTRooCooSet_activate)),
		eas.subConHea(uExt(y=eas_subConHea_u),activate(y=eas_subConHea_activate)),
		conVAVNor.oveTRooHeaSet(uExt(y=conVAVNor_oveTRooHeaSet_u),activate(y=conVAVNor_oveTRooHeaSet_activate))) "Original model with overwrites";
end wrapped;