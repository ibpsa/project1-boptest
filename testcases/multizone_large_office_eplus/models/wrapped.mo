model wrapped "Wrapped model"
 // Input overwrite
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonBotCor_u(unit="K", min=263.15, max=323.15) "Bottom floor air temperature of core zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonBotCor_activate "Activation for Bottom floor air temperature of core zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonBotEas_u(unit="K", min=263.15, max=323.15) "Bottom floor air temperature of east zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonBotEas_activate "Activation for Bottom floor air temperature of east zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonBotNor_u(unit="K", min=263.15, max=323.15) "Bottom floor air temperature of north zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonBotNor_activate "Activation for Bottom floor air temperature of north zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonBotSou_u(unit="K", min=263.15, max=323.15) "Bottom floor air temperature of south zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonBotSou_activate "Activation for Bottom floor air temperature of south zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonBotWes_u(unit="K", min=263.15, max=323.15) "Bottom floor air temperature of west zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonBotWes_activate "Activation for Bottom floor air temperature of west zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonMidCor_u(unit="K", min=263.15, max=323.15) "Middle floor air temperature of core zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonMidCor_activate "Activation for Middle floor air temperature of core zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonMidEas_u(unit="K", min=263.15, max=323.15) "Middle floor air temperature of east zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonMidEas_activate "Activation for Middle floor air temperature of east zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonMidNor_u(unit="K", min=263.15, max=323.15) "Middle floor air temperature of north zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonMidNor_activate "Activation for Middle floor air temperature of north zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonMidSou_u(unit="K", min=263.15, max=323.15) "Middle floor air temperature of south zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonMidSou_activate "Activation for Middle floor air temperature of south zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonMidWes_u(unit="K", min=263.15, max=323.15) "Middle floor air temperature of west zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonMidWes_activate "Activation for Middle floor air temperature of west zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonTopCor_u(unit="K", min=263.15, max=323.15) "Top floor air temperature of core zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonTopCor_activate "Activation for Top floor air temperature of core zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonTopEas_u(unit="K", min=263.15, max=323.15) "Top floor air temperature of east zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonTopEas_activate "Activation for Top floor air temperature of east zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonTopNor_u(unit="K", min=263.15, max=323.15) "Top floor air temperature of north zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonTopNor_activate "Activation for Top floor air temperature of north zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonTopSou_u(unit="K", min=263.15, max=323.15) "Top floor air temperature of south zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonTopSou_activate "Activation for Top floor air temperature of south zone";
 Modelica.Blocks.Interfaces.RealInput EPlus96_oveTZonTopWes_u(unit="K", min=263.15, max=323.15) "Top floor air temperature of west zone";
 Modelica.Blocks.Interfaces.BooleanInput EPlus96_oveTZonTopWes_activate "Activation for Top floor air temperature of west zone";
 // Out read
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaBotCor_y(unit="W") = mod.EPlus96.reaHeaLoaBotCor.y "Heating load in core zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaBotEas_y(unit="W") = mod.EPlus96.reaHeaLoaBotEas.y "Heating load in east zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaBotNor_y(unit="W") = mod.EPlus96.reaHeaLoaBotNor.y "Heating load in north zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaBotSou_y(unit="W") = mod.EPlus96.reaHeaLoaBotSou.y "Heating load in south zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaBotWes_y(unit="W") = mod.EPlus96.reaHeaLoaBotWes.y "Heating load in west zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaMidCor_y(unit="W") = mod.EPlus96.reaHeaLoaMidCor.y "Heating load in core zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaMidEas_y(unit="W") = mod.EPlus96.reaHeaLoaMidEas.y "Heating load in east zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaMidNor_y(unit="W") = mod.EPlus96.reaHeaLoaMidNor.y "Heating load in north zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaMidSou_y(unit="W") = mod.EPlus96.reaHeaLoaMidSou.y "Heating load in south zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaMidWes_y(unit="W") = mod.EPlus96.reaHeaLoaMidWes.y "Heating load in west zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaTopCor_y(unit="W") = mod.EPlus96.reaHeaLoaTopCor.y "Heating load in core zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaTopEas_y(unit="W") = mod.EPlus96.reaHeaLoaTopEas.y "Heating load in east zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaTopNor_y(unit="W") = mod.EPlus96.reaHeaLoaTopNor.y "Heating load in north zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaTopSou_y(unit="W") = mod.EPlus96.reaHeaLoaTopSou.y "Heating load in south zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaHeaLoaTopWes_y(unit="W") = mod.EPlus96.reaHeaLoaTopWes.y "Heating load in west zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaBotCor_y(unit="W") = mod.EPlus96.reaLatCooLoaBotCor.y "Latent cooling load in core zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaBotEas_y(unit="W") = mod.EPlus96.reaLatCooLoaBotEas.y "Latent cooling load in east zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaBotNor_y(unit="W") = mod.EPlus96.reaLatCooLoaBotNor.y "Latent cooling load in north zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaBotSou_y(unit="W") = mod.EPlus96.reaLatCooLoaBotSou.y "Latent cooling load in south zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaBotWes_y(unit="W") = mod.EPlus96.reaLatCooLoaBotWes.y "Latent cooling load in west zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaMidCor_y(unit="W") = mod.EPlus96.reaLatCooLoaMidCor.y "Latent cooling load in core zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaMidEas_y(unit="W") = mod.EPlus96.reaLatCooLoaMidEas.y "Latent cooling load in east zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaMidNor_y(unit="W") = mod.EPlus96.reaLatCooLoaMidNor.y "Latent cooling load in north zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaMidSou_y(unit="W") = mod.EPlus96.reaLatCooLoaMidSou.y "Latent cooling load in south zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaMidWes_y(unit="W") = mod.EPlus96.reaLatCooLoaMidWes.y "Latent cooling load in west zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaTopCor_y(unit="W") = mod.EPlus96.reaLatCooLoaTopCor.y "Latent cooling load in core zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaTopEas_y(unit="W") = mod.EPlus96.reaLatCooLoaTopEas.y "Latent cooling load in east zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaTopNor_y(unit="W") = mod.EPlus96.reaLatCooLoaTopNor.y "Latent cooling load in north zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaTopSou_y(unit="W") = mod.EPlus96.reaLatCooLoaTopSou.y "Latent cooling load in south zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaLatCooLoaTopWes_y(unit="W") = mod.EPlus96.reaLatCooLoaTopWes.y "Latent cooling load in west zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaOccSch_y(unit="1") = mod.EPlus96.reaOccSch.y "Occupancy schedule";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouBotCor_y(unit="1") = mod.EPlus96.reaPeoCouBotCor.y "Number of people in core zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouBotEas_y(unit="1") = mod.EPlus96.reaPeoCouBotEas.y "Number of people in east zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouBotNor_y(unit="1") = mod.EPlus96.reaPeoCouBotNor.y "Number of people in north zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouBotSou_y(unit="1") = mod.EPlus96.reaPeoCouBotSou.y "Number of people in south zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouBotWes_y(unit="1") = mod.EPlus96.reaPeoCouBotWes.y "Number of people in west zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouMidCor_y(unit="1") = mod.EPlus96.reaPeoCouMidCor.y "Number of people in core zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouMidEas_y(unit="1") = mod.EPlus96.reaPeoCouMidEas.y "Number of people in east zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouMidNor_y(unit="1") = mod.EPlus96.reaPeoCouMidNor.y "Number of people in north zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouMidSou_y(unit="1") = mod.EPlus96.reaPeoCouMidSou.y "Number of people in south zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouMidWes_y(unit="1") = mod.EPlus96.reaPeoCouMidWes.y "Number of people in west zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouTopCor_y(unit="1") = mod.EPlus96.reaPeoCouTopCor.y "Number of people in core zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouTopEas_y(unit="1") = mod.EPlus96.reaPeoCouTopEas.y "Number of people in east zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouTopNor_y(unit="1") = mod.EPlus96.reaPeoCouTopNor.y "Number of people in north zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouTopSou_y(unit="1") = mod.EPlus96.reaPeoCouTopSou.y "Number of people in south zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaPeoCouTopWes_y(unit="1") = mod.EPlus96.reaPeoCouTopWes.y "Number of people in west zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaRelHum_y(unit="1") = mod.EPlus96.reaRelHum.y "Relative humidity";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaBotCor_y(unit="W") = mod.EPlus96.reaSenCooLoaBotCor.y "Sensible cooling load in core zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaBotEas_y(unit="W") = mod.EPlus96.reaSenCooLoaBotEas.y "Sensible cooling load in east zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaBotNor_y(unit="W") = mod.EPlus96.reaSenCooLoaBotNor.y "Sensible cooling load in north zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaBotSou_y(unit="W") = mod.EPlus96.reaSenCooLoaBotSou.y "Sensible cooling load in south zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaBotWes_y(unit="W") = mod.EPlus96.reaSenCooLoaBotWes.y "Sensible cooling load in west zone on bot floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaMidCor_y(unit="W") = mod.EPlus96.reaSenCooLoaMidCor.y "Sensible cooling load in core zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaMidEas_y(unit="W") = mod.EPlus96.reaSenCooLoaMidEas.y "Sensible cooling load in east zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaMidNor_y(unit="W") = mod.EPlus96.reaSenCooLoaMidNor.y "Sensible cooling load in north zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaMidSou_y(unit="W") = mod.EPlus96.reaSenCooLoaMidSou.y "Sensible cooling load in south zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaMidWes_y(unit="W") = mod.EPlus96.reaSenCooLoaMidWes.y "Sensible cooling load in west zone on mid floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaTopCor_y(unit="W") = mod.EPlus96.reaSenCooLoaTopCor.y "Sensible cooling load in core zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaTopEas_y(unit="W") = mod.EPlus96.reaSenCooLoaTopEas.y "Sensible cooling load in east zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaTopNor_y(unit="W") = mod.EPlus96.reaSenCooLoaTopNor.y "Sensible cooling load in north zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaTopSou_y(unit="W") = mod.EPlus96.reaSenCooLoaTopSou.y "Sensible cooling load in south zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaSenCooLoaTopWes_y(unit="W") = mod.EPlus96.reaSenCooLoaTopWes.y "Sensible cooling load in west zone on top floor";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaTDryBul_y(unit="K") = mod.EPlus96.reaTDryBul.y "Drybulb temperature";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_reaTWetBul_y(unit="K") = mod.EPlus96.reaTWetBul.y "Wetbulb temperature";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonBotCor_y(unit="K") = mod.EPlus96.oveTZonBotCor.y "Bottom floor air temperature of core zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonBotEas_y(unit="K") = mod.EPlus96.oveTZonBotEas.y "Bottom floor air temperature of east zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonBotNor_y(unit="K") = mod.EPlus96.oveTZonBotNor.y "Bottom floor air temperature of north zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonBotSou_y(unit="K") = mod.EPlus96.oveTZonBotSou.y "Bottom floor air temperature of south zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonBotWes_y(unit="K") = mod.EPlus96.oveTZonBotWes.y "Bottom floor air temperature of west zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonMidCor_y(unit="K") = mod.EPlus96.oveTZonMidCor.y "Middle floor air temperature of core zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonMidEas_y(unit="K") = mod.EPlus96.oveTZonMidEas.y "Middle floor air temperature of east zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonMidNor_y(unit="K") = mod.EPlus96.oveTZonMidNor.y "Middle floor air temperature of north zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonMidSou_y(unit="K") = mod.EPlus96.oveTZonMidSou.y "Middle floor air temperature of south zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonMidWes_y(unit="K") = mod.EPlus96.oveTZonMidWes.y "Middle floor air temperature of west zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonTopCor_y(unit="K") = mod.EPlus96.oveTZonTopCor.y "Top floor air temperature of core zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonTopEas_y(unit="K") = mod.EPlus96.oveTZonTopEas.y "Top floor air temperature of east zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonTopNor_y(unit="K") = mod.EPlus96.oveTZonTopNor.y "Top floor air temperature of north zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonTopSou_y(unit="K") = mod.EPlus96.oveTZonTopSou.y "Top floor air temperature of south zone";
 Modelica.Blocks.Interfaces.RealOutput EPlus96_oveTZonTopWes_y(unit="K") = mod.EPlus96.oveTZonTopWes.y "Top floor air temperature of west zone";
 // Original model
 EPlusLargeOffice.Testcases.LargeOffice mod(EPlus96(
  oveTZonBotCor(        uExt(y=EPlus96_oveTZonBotCor_u),activate(y=EPlus96_oveTZonBotCor_activate)),
  oveTZonBotEas(        uExt(y=EPlus96_oveTZonBotEas_u),activate(y=EPlus96_oveTZonBotEas_activate)),
  oveTZonBotNor(        uExt(y=EPlus96_oveTZonBotNor_u),activate(y=EPlus96_oveTZonBotNor_activate)),
  oveTZonBotSou(        uExt(y=EPlus96_oveTZonBotSou_u),activate(y=EPlus96_oveTZonBotSou_activate)),
  oveTZonBotWes(        uExt(y=EPlus96_oveTZonBotWes_u),activate(y=EPlus96_oveTZonBotWes_activate)),
  oveTZonMidCor(        uExt(y=EPlus96_oveTZonMidCor_u),activate(y=EPlus96_oveTZonMidCor_activate)),
  oveTZonMidEas(        uExt(y=EPlus96_oveTZonMidEas_u),activate(y=EPlus96_oveTZonMidEas_activate)),
  oveTZonMidNor(        uExt(y=EPlus96_oveTZonMidNor_u),activate(y=EPlus96_oveTZonMidNor_activate)),
  oveTZonMidSou(        uExt(y=EPlus96_oveTZonMidSou_u),activate(y=EPlus96_oveTZonMidSou_activate)),
  oveTZonMidWes(        uExt(y=EPlus96_oveTZonMidWes_u),activate(y=EPlus96_oveTZonMidWes_activate)),
  oveTZonTopCor(        uExt(y=EPlus96_oveTZonTopCor_u),activate(y=EPlus96_oveTZonTopCor_activate)),
  oveTZonTopEas(        uExt(y=EPlus96_oveTZonTopEas_u),activate(y=EPlus96_oveTZonTopEas_activate)),
  oveTZonTopNor(        uExt(y=EPlus96_oveTZonTopNor_u),activate(y=EPlus96_oveTZonTopNor_activate)),
  oveTZonTopSou(        uExt(y=EPlus96_oveTZonTopSou_u),activate(y=EPlus96_oveTZonTopSou_activate)),
  oveTZonTopWes(        uExt(y=EPlus96_oveTZonTopWes_u),activate(y=EPlus96_oveTZonTopWes_activate))))
                                                                                                     "Original model with overwrites";
end wrapped;
