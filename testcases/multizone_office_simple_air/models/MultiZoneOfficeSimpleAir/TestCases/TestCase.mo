within MultiZoneOfficeSimpleAir.TestCases;
model TestCase
  "BOPTEST test case with variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  extends Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop(
    redeclare replaceable Buildings.Examples.VAVReheat.Validation.BaseClasses.Floor flo(
      final lat=lat,
      final sampleModel=sampleModel),
    amb(nPorts=3, C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
                         /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumA.nC)),
    MediumA(extraPropertiesNames={"CO2"}),
    weaDat(computeWetBulbTemperature=true));

  parameter Real ratVMinCor_flow(final unit="1")=
    max(1.5*VCorOA_flow_nominal, 0.15*mCor_flow_nominal/1.2) /
    (mCor_flow_nominal/1.2)
    "Minimum discharge air flow rate ratio";
  parameter Real ratVMinSou_flow(final unit="1")=
    max(1.5*VSouOA_flow_nominal, 0.15*mSou_flow_nominal/1.2) /
    (mSou_flow_nominal/1.2)
    "Minimum discharge air flow rate ratio";
  parameter Real ratVMinEas_flow(final unit="1")=
    max(1.5*VEasOA_flow_nominal, 0.15*mEas_flow_nominal/1.2) /
    (mEas_flow_nominal/1.2)
    "Minimum discharge air flow rate ratio";
  parameter Real ratVMinNor_flow(final unit="1")=
    max(1.5*VNorOA_flow_nominal, 0.15*mNor_flow_nominal/1.2) /
    (mNor_flow_nominal/1.2)
    "Minimum discharge air flow rate ratio";
  parameter Real ratVMinWes_flow(final unit="1")=
    max(1.5*VWesOA_flow_nominal, 0.15*mWes_flow_nominal/1.2) /
    (mWes_flow_nominal/1.2)
    "Minimum discharge air flow rate ratio";

  Buildings.Examples.VAVReheat.Controls.FanVFD conFanSup(xSet_nominal(
        displayUnit="Pa") = 410, r_N_min=yFanMin) "Controller for fan"
    annotation (Placement(transformation(extent={{240,-10},{260,10}})));
  Buildings.Examples.VAVReheat.Controls.ModeSelector modeSelector
    annotation (Placement(transformation(extent={{-200,-320},{-180,-300}})));
  Buildings.Examples.VAVReheat.Controls.ControlBus controlBus
    annotation (Placement(transformation(extent={{-250,-352},{-230,-332}})));

  Buildings.Examples.VAVReheat.Controls.Economizer conEco(
    have_reset=true,
    have_frePro=true,
    VOut_flow_min=Vot_flow_nominal) "Controller for economizer"
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
  Buildings.Examples.VAVReheat.Controls.RoomTemperatureSetpoint TSetRoo(
    final THeaOn=THeaOn,
    final THeaOff=THeaOff,
    final TCooOn=TCooOn,
    final TCooOff=TCooOff)
    annotation (Placement(transformation(extent={{-300,-358},{-280,-338}})));
  Buildings.Examples.VAVReheat.Controls.DuctStaticPressureSetpoint pSetDuc(nin=5,
      pMin=50) "Duct static pressure setpoint"
    annotation (Placement(transformation(extent={{160,-16},{180,4}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVCor(ratVFloMin=
        ratVMinCor_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit corridor"
    annotation (Placement(transformation(extent={{456,-124},{476,-104}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVSou(ratVFloMin=
        ratVMinSou_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit south"
    annotation (Placement(transformation(extent={{638,-124},{658,-104}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVEas(ratVFloMin=
        ratVMinEas_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit east"
    annotation (Placement(transformation(extent={{822,-124},{842,-104}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVNor(ratVFloMin=
        ratVMinNor_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit north"
    annotation (Placement(transformation(extent={{996,-124},{1016,-104}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVWes(ratVFloMin=
        ratVMinWes_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit west"
    annotation (Placement(transformation(extent={{1186,-124},{1206,-104}})));

  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-10,-250},{10,-230}})));
  Buildings.Examples.VAVReheat.Controls.SupplyAirTemperature conTSup
    "Supply air temperature and economizer controller"
    annotation (Placement(transformation(extent={{30,-230},{50,-210}})));
  Buildings.Examples.VAVReheat.Controls.SupplyAirTemperatureSetpoint TSupSet
    "Supply air temperature set point"
    annotation (Placement(transformation(extent={{-200,-230},{-180,-210}})));
  Buildings.Fluid.Actuators.Dampers.Exponential damExh(
    riseTime=15,
    dpFixed_nominal=5,
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    dpDamper_nominal=5)  "Exhaust air damper"
    annotation (Placement(transformation(extent={{-30,-20},{-50,0}})));
  Modelica.Blocks.Sources.RealExpression CO2Cor(y=flo.cor.air.vol.C[1])
    "Measure CO2 concentration in core zone"
    annotation (Placement(transformation(extent={{456,72},{476,92}})));
  BaseClasses.ReadAhu reaAhu "Read blocks for AHU"
    annotation (Placement(transformation(extent={{160,240},{200,360}})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta
    annotation (Placement(transformation(extent={{170,380},{190,400}})));
  Modelica.Blocks.Sources.RealExpression PCoo(y=cooCoi.Q1_flow/3.2)
    "Electrical power for cooling coil"
    annotation (Placement(transformation(extent={{120,230},{140,250}})));
  Modelica.Blocks.Sources.RealExpression PHea(y=-heaCoi.Q1_flow/4.0)
    "Electrical power for heating coil"
    annotation (Placement(transformation(extent={{120,210},{140,230}})));
  BaseClasses.WriteAhu oveAhu "Overwrite blocks for AHU"
    annotation (Placement(transformation(extent={{240,30},{260,60}})));
  BaseClasses.ReadZone reaCor(zone="Core") "Read blocks for Core zone"
    annotation (Placement(transformation(extent={{540,80},{560,108}})));
  BaseClasses.WriteZoneSup oveCorSup(zone="Core")
    "Overwrite supervisory points for Core zone"
    annotation (Placement(transformation(extent={{418,-124},{438,-104}})));
  BaseClasses.WriteZoneLoc oveCorLoc(zone="Core")
    "Overwrite local points for Core zone"
    annotation (Placement(transformation(extent={{492,-124},{512,-104}})));
  Modelica.Blocks.Sources.RealExpression PHeaCor(y=-cor.terHea.Q1_flow/4.0)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{456,86},{476,106}})));
  BaseClasses.WriteZoneSup oveSouSup(zone="South")
    "Overwrite supervisory points for South zone"
    annotation (Placement(transformation(extent={{600,-124},{620,-104}})));
  BaseClasses.WriteZoneLoc oveSouLoc(zone="South")
    "Overwrite local points for South zone"
    annotation (Placement(transformation(extent={{680,-124},{700,-104}})));
  BaseClasses.ReadZone reaSou(zone="South") "Read blocks for South zone"
    annotation (Placement(transformation(extent={{720,80},{740,108}})));
  Modelica.Blocks.Sources.RealExpression CO2Sou(y=flo.sou.air.vol.C[1])
    "Measure CO2 concentration in south zone"
    annotation (Placement(transformation(extent={{644,70},{664,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaSou(y=-sou.terHea.Q1_flow/4.0)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{644,84},{664,104}})));
  BaseClasses.WriteZoneLoc oveEasLoc(zone="East")
    "Overwrite local points for East zone"
    annotation (Placement(transformation(extent={{860,-124},{880,-104}})));
  BaseClasses.WriteZoneSup oveEasSup(zone="East")
    "Overwrite supervisory points for East zone"
    annotation (Placement(transformation(extent={{780,-124},{800,-104}})));
  BaseClasses.ReadZone reaEas(zone="East") "Read blocks for East zone"
    annotation (Placement(transformation(extent={{900,80},{920,108}})));
  Modelica.Blocks.Sources.RealExpression CO2Eas(y=flo.eas.air.vol.C[1])
    "Measure CO2 concentration in East zone"
    annotation (Placement(transformation(extent={{814,72},{834,92}})));
  Modelica.Blocks.Sources.RealExpression PHeaEas(y=-eas.terHea.Q1_flow/4.0)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{814,86},{834,106}})));
  BaseClasses.ReadZone reaNor(zone="North") "Read blocks for North zone"
    annotation (Placement(transformation(extent={{1080,80},{1100,108}})));
  BaseClasses.WriteZoneLoc oveNorLoc(zone="North")
    "Overwrite local points for North zone"
    annotation (Placement(transformation(extent={{1040,-124},{1060,-104}})));
  BaseClasses.WriteZoneSup oveNorSup(zone="North")
    "Overwrite supervisory points for North zone"
    annotation (Placement(transformation(extent={{960,-124},{980,-104}})));
  Modelica.Blocks.Sources.RealExpression PHeaNor(y=-nor.terHea.Q1_flow/4.0)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{986,84},{1006,104}})));
  Modelica.Blocks.Sources.RealExpression CO2Nor(y=flo.nor.air.vol.C[1])
    "Measure CO2 concentration in East zone"
    annotation (Placement(transformation(extent={{986,70},{1006,90}})));
  BaseClasses.WriteZoneLoc oveWesLoc(zone="West")
    "Overwrite local points for West zone"
    annotation (Placement(transformation(extent={{1228,-124},{1248,-104}})));
  BaseClasses.WriteZoneSup oveWesSup(zone="West")
    "Overwrite supervisory points for West zone"
    annotation (Placement(transformation(extent={{1148,-124},{1168,-104}})));
  BaseClasses.ReadZone reaWes(zone="West") "Read blocks for West zone"
    annotation (Placement(transformation(extent={{1260,80},{1280,108}})));
  Modelica.Blocks.Sources.RealExpression PHeaWes(y=-wes.terHea.Q1_flow/4.0)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{1164,84},{1184,104}})));
  Modelica.Blocks.Sources.RealExpression CO2Wes(y=flo.wes.air.vol.C[1])
    "Measure CO2 concentration in West zone"
    annotation (Placement(transformation(extent={{1164,70},{1184,90}})));
equation
  connect(controlBus, modeSelector.cb) annotation (Line(
      points={{-240,-342},{-152,-342},{-152,-303.182},{-196.818,-303.182}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(min.y, controlBus.TRooMin) annotation (Line(
      points={{1221,450},{1400,450},{1400,-342},{-240,-342}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ave.y, controlBus.TRooAve) annotation (Line(
      points={{1221,420},{1400,420},{1400,-342},{-240,-342}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TRet.T, conEco.TRet) annotation (Line(
      points={{100,151},{100,174},{-94,174},{-94,153.333},{-81.3333,153.333}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSetRoo.controlBus, controlBus) annotation (Line(
      points={{-288,-342},{-240,-342}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(dpDisSupFan.p_rel, conFanSup.u_m) annotation (Line(
      points={{311,4.44089e-16},{304,4.44089e-16},{304,-16},{250,-16},{250,-12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(conEco.VOut_flow, VOut1.V_flow) annotation (Line(
      points={{-81.3333,142.667},{-90,142.667},{-90,80},{-80,80},{-80,-29}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(conVAVCor.TRoo, TRooAir.y5[1]) annotation (Line(
      points={{455,-121},{452,-121},{452,-120},{448,-120},{448,275},{480,275}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conVAVSou.TRoo, TRooAir.y1[1]) annotation (Line(
      points={{637,-121},{628,-121},{628,275},{496,275}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y2[1], conVAVEas.TRoo) annotation (Line(
      points={{492,275},{808,275},{808,-121},{821,-121}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y3[1], conVAVNor.TRoo) annotation (Line(
      points={{488,275},{978,275},{978,-121},{995,-121}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y4[1], conVAVWes.TRoo) annotation (Line(
      points={{484,275},{1160,275},{1160,-121},{1185,-121}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveCorSup.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{416,
          -110},{400,-110},{400,-342},{-240,-342}},  color={0,0,127}));
  connect(oveCorSup.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{416,
          -118},{400,-118},{400,-342},{-240,-342}},  color={0,0,127}));
  connect(oveSouSup.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{598,
          -110},{588,-110},{588,-342},{-240,-342}},  color={0,0,127}));
  connect(oveSouSup.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{598,
          -118},{588,-118},{588,-342},{-240,-342}},  color={0,0,127}));
  connect(oveEasSup.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{778,
          -110},{770,-110},{770,-342},{-240,-342}},  color={0,0,127}));
  connect(oveEasSup.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{778,
          -118},{770,-118},{770,-342},{-240,-342}},  color={0,0,127}));
  connect(oveNorSup.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{958,
          -110},{940,-110},{940,-342},{-240,-342}},     color={0,0,127}));
  connect(oveNorSup.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{958,
          -118},{940,-118},{940,-342},{-240,-342}},     color={0,0,127}));
  connect(oveWesSup.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{1146,
          -110},{1128,-110},{1128,-342},{-240,-342}},   color={0,0,127}));
  connect(oveWesSup.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{1146,
          -118},{1128,-118},{1128,-342},{-240,-342}},   color={0,0,127}));

  connect(occSch.tNexOcc, controlBus.dTNexOcc) annotation (Line(
      points={{-297,-204},{-240,-204},{-240,-342}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(occSch.occupied, controlBus.occupied) annotation (Line(
      points={{-297,-216},{-240,-216},{-240,-342}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pSetDuc.TOut, TOut.y) annotation (Line(points={{158,2},{32,2},{32,130},
          {-160,130},{-160,180},{-279,180}}, color={0,0,127}));
  connect(TOut.y, controlBus.TOut) annotation (Line(points={{-279,180},{-240,180},
          {-240,-342}},                            color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(conEco.controlBus, controlBus) annotation (Line(
      points={{-70.6667,141.467},{-70.6667,120},{-240,120},{-240,-342}},
      color={255,204,51},
      thickness=0.5));
  connect(modeSelector.yFan, conFanSup.uFan) annotation (Line(points={{-179.091,
          -305.455},{260,-305.455},{260,-30},{226,-30},{226,6},{238,6}},
                                                                 color={255,0,
          255}));
  connect(or2.u2, modeSelector.yFan) annotation (Line(points={{-12,-248},{-30,
          -248},{-30,-305.455},{-179.091,-305.455}},
                                     color={255,0,255}));
  connect(cor.y_actual, pSetDuc.u[1]) annotation (Line(points={{612,42},{620,42},
          {620,74},{140,74},{140,-7.6},{158,-7.6}}, color={0,0,127}));
  connect(sou.y_actual, pSetDuc.u[2]) annotation (Line(points={{792,40},{800,40},
          {800,74},{140,74},{140,-6.8},{158,-6.8}}, color={0,0,127}));
  connect(eas.y_actual, pSetDuc.u[3]) annotation (Line(points={{972,40},{980,40},
          {980,74},{140,74},{140,-6},{158,-6}}, color={0,0,127}));
  connect(nor.y_actual, pSetDuc.u[4]) annotation (Line(points={{1132,40},{1140,
          40},{1140,74},{140,74},{140,-5.2},{158,-5.2}}, color={0,0,127}));
  connect(wes.y_actual, pSetDuc.u[5]) annotation (Line(points={{1332,40},{1338,
          40},{1338,74},{140,74},{140,-4.4},{158,-4.4}}, color={0,0,127}));
  connect(TSup.T, conTSup.TSup) annotation (Line(
      points={{340,-29},{340,-20},{360,-20},{360,-280},{16,-280},{16,-214},{28,
          -214}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conTSup.yOA, conEco.uOATSup) annotation (Line(
      points={{52,-220},{60,-220},{60,170},{-86,170},{-86,158.667},{-81.3333,
          158.667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(or2.y, conTSup.uEna) annotation (Line(points={{12,-240},{20,-240},{20,
          -226},{28,-226}},    color={255,0,255}));
  connect(modeSelector.yEco, conEco.uEna) annotation (Line(points={{-179.091,
          -314.545},{-160,-314.545},{-160,100},{-73.3333,100},{-73.3333,137.333}},
        color={255,0,255}));
  connect(TMix.T, conEco.TMix) annotation (Line(points={{40,-29},{40,166},{-90,
          166},{-90,148},{-81.3333,148}}, color={0,0,127}));
  connect(controlBus, TSupSet.controlBus) annotation (Line(
      points={{-240,-342},{-240,-228},{-190,-228}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(damExh.port_a, TRet.port_b) annotation (Line(points={{-30,-10},{-26,-10},
          {-26,140},{90,140}}, color={0,127,255}));
  connect(damExh.port_b, amb.ports[3]) annotation (Line(points={{-50,-10},{-100,
          -10},{-100,-45},{-114,-45}}, color={0,127,255}));
  connect(freSta.y, or2.u1) annotation (Line(points={{-38,-90},{-30,-90},{-30,
          -240},{-12,-240}}, color={255,0,255}));
  connect(conFanSup.y, oveAhu.yFan_in) annotation (Line(points={{261,0},{268,0},
          {268,20},{226,20},{226,57.8571},{238,57.8571}}, color={0,0,127}));
  connect(oveAhu.yFan_out, fanSup.y) annotation (Line(points={{261,57.8571},{
          310,57.8571},{310,-28}},
                               color={0,0,127}));
  connect(conTSup.yHea, oveAhu.yHea_in) annotation (Line(points={{52,-214},{62,
          -214},{62,53.5714},{238,53.5714}},
                                       color={0,0,127}));
  connect(oveAhu.yHea_out, gaiHeaCoi.u) annotation (Line(points={{261,53.5714},
          {272,53.5714},{272,54},{286,54},{286,-200},{124,-200},{124,-184}},
        color={0,0,127}));
  connect(conTSup.yCoo, oveAhu.yCoo_in) annotation (Line(points={{52,-226},{64,
          -226},{64,49.2857},{238,49.2857}},
                                       color={0,0,127}));
  connect(oveAhu.yCoo_out, gaiCooCoi.u) annotation (Line(points={{261,49.2857},
          {272,49.2857},{272,50},{284,50},{284,-196},{222,-196},{222,-186}},
        color={0,0,127}));
  connect(TSupSet.TSet, oveAhu.TSupSet_in) annotation (Line(points={{-178,-220},
          {0,-220},{0,-200},{66,-200},{66,45},{238,45}}, color={0,0,127}));
  connect(oveAhu.TSupSet_out, conTSup.TSupSet) annotation (Line(points={{261,45},
          {272,45},{272,46},{282,46},{282,-202},{20,-202},{20,-220},{28,-220}},
        color={0,0,127}));
  connect(pSetDuc.y, oveAhu.dpSet_in) annotation (Line(points={{181,-6},{192,-6},
          {192,40.7143},{238,40.7143}}, color={0,0,127}));
  connect(oveAhu.dpSet_out, conFanSup.u) annotation (Line(points={{261,40.7143},
          {280,40.7143},{280,-20},{228,-20},{228,0},{238,0}}, color={0,0,127}));
  connect(conEco.yOA, oveAhu.yOA_in) annotation (Line(points={{-58.6667,152},{
          74,152},{74,36.4286},{238,36.4286}},
                                            color={0,0,127}));
  connect(oveAhu.yOA_out, damExh.y) annotation (Line(points={{261,36.4286},{278,
          36.4286},{278,22},{-40,22},{-40,2}}, color={0,0,127}));
  connect(damOut.y, damExh.y) annotation (Line(points={{-40,-28},{-40,-20},{-60,
          -20},{-60,22},{-40,22},{-40,2}}, color={0,0,127}));
  connect(conEco.yRet, oveAhu.yRet_in) annotation (Line(points={{-58.6667,
          146.667},{72,146.667},{72,32.1429},{238,32.1429}},
                                                    color={0,0,127}));
  connect(oveAhu.yRet_out, damRet.y) annotation (Line(points={{261,32.1429},{
          274,32.1429},{274,24},{-12,24},{-12,-10}},
                                                 color={0,0,127}));
  connect(reaAhu.PHea_in, PHea.y) annotation (Line(points={{156,247.5},{152,247.5},
          {152,246},{148,246},{148,220},{141,220}}, color={0,0,127}));
  connect(PCoo.y, reaAhu.PCoo_in) annotation (Line(points={{141,240},{146,240},{
          146,255},{156,255}}, color={0,0,127}));
  connect(TSup.T, reaAhu.TSup_in) annotation (Line(points={{340,-29},{340,100},{
          320,100},{320,200},{58,200},{58,360},{156,360}}, color={0,0,127}));
  connect(reaAhu.TMix_in, conEco.TMix) annotation (Line(points={{156,352.5},{98,
          352.5},{98,352},{40,352},{40,166},{-90,166},{-90,148},{-81.3333,148}},
        color={0,0,127}));
  connect(reaAhu.TRet_in, conEco.TRet) annotation (Line(points={{156,345},{140,
          345},{140,346},{100,346},{100,174},{-94,174},{-94,153.333},{-81.3333,
          153.333}},
        color={0,0,127}));
  connect(senSupFlo.V_flow, reaAhu.V_flow_sup_in) annotation (Line(points={{410,
          -29},{408,-29},{408,104},{324,104},{324,202},{62,202},{62,337.5},{156,
          337.5}}, color={0,0,127}));
  connect(senRetFlo.V_flow, reaAhu.V_flow_ret_in) annotation (Line(points={{350,
          151},{350,204},{66,204},{66,330},{156,330}}, color={0,0,127}));
  connect(reaAhu.V_flow_out_in, VOut1.V_flow) annotation (Line(points={{156,322.5},
          {86,322.5},{86,320},{-100,320},{-100,142},{-88,142},{-88,142.667},{-90,
          142.667},{-90,80},{-80,80},{-80,-29}}, color={0,0,127}));
  connect(reaAhu.dp_in, conFanSup.u_m) annotation (Line(points={{156,315},{142,315},
          {142,316},{70,316},{70,206},{304,206},{304,-16},{250,-16},{250,-12}},
        color={0,0,127}));
  connect(reaAhu.yOA_in, damExh.y) annotation (Line(points={{156,307.5},{124,307.5},
          {124,308},{-40,308},{-40,2}}, color={0,0,127}));
  connect(reaAhu.yExh_in, damExh.y) annotation (Line(points={{156,300},{130,300},
          {130,307.5},{124,307.5},{124,308},{-40,308},{-40,2}}, color={0,0,127}));
  connect(reaAhu.yRet_in, damRet.y) annotation (Line(points={{156,292.5},{156,292},
          {-12,292},{-12,-10}}, color={0,0,127}));
  connect(reaAhu.yFan_in, fanSup.y) annotation (Line(points={{156,285},{146,285},
          {146,286},{74,286},{74,208},{310,208},{310,-28}}, color={0,0,127}));
  connect(reaAhu.yHea_in, gaiHeaCoi.u) annotation (Line(points={{156,277.5},{78,
          277.5},{78,210},{286,210},{286,-200},{124,-200},{124,-184}}, color={0,
          0,127}));
  connect(reaAhu.yCoo_in, gaiCooCoi.u) annotation (Line(points={{156,270},{82,270},
          {82,212},{284,212},{284,-196},{222,-196},{222,-186}}, color={0,0,127}));
  connect(fanSup.P, reaAhu.PFanSup_in) annotation (Line(points={{321,-31},{334,-31},
          {334,98},{288,98},{288,214},{86,214},{86,262.5},{156,262.5}}, color={0,
          0,127}));
  connect(weaSta.weaBus, weaBus) annotation (Line(
      points={{170.1,389.9},{-320,389.9},{-320,180}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveCorSup.TZoneHeaSet_out, conVAVCor.TRooHeaSet) annotation (Line(
        points={{439,-110},{448,-110},{448,-107},{454,-107}}, color={0,0,127}));
  connect(oveCorSup.TZoneCooSet_out, conVAVCor.TRooCooSet) annotation (Line(
        points={{439,-118},{446,-118},{446,-114},{454,-114}}, color={0,0,127}));
  connect(conVAVCor.yDam, oveCorLoc.yDam_in) annotation (Line(points={{477,-109.2},
          {482.5,-109.2},{482.5,-110},{490,-110}}, color={0,0,127}));
  connect(conVAVCor.yVal, oveCorLoc.yReaHea_in) annotation (Line(points={{477,-119},
          {482.5,-119},{482.5,-118},{490,-118}}, color={0,0,127}));
  connect(oveCorLoc.yDam_out, cor.yVAV) annotation (Line(points={{513,-110},{556,
          -110},{556,54},{566,54}}, color={0,0,127}));
  connect(oveCorLoc.yReaHea_out, gaiHeaCoiCor.u) annotation (Line(points={{513,-118},
          {520,-118},{520,20},{480,20},{480,46},{492,46}}, color={0,0,127}));
  connect(conVAVCor.TRoo, reaCor.TZon_in) annotation (Line(points={{455,-121},{452,
          -121},{452,-120},{448,-120},{448,106},{538,106}}, color={0,0,127}));
  connect(reaCor.yDamAct_in, cor.yVAV) annotation (Line(points={{538,102},{500,102},
          {500,62},{556,62},{556,54},{566,54}}, color={0,0,127}));
  connect(reaCor.yReaHea_in, gaiHeaCoiCor.u) annotation (Line(points={{538,98},{
          480,98},{480,46},{492,46}}, color={0,0,127}));
  connect(cor.TSup, reaCor.TSup_in) annotation (Line(points={{612,50},{618,50},{
          618,76},{502,76},{502,94},{538,94}}, color={0,0,127}));
  connect(cor.VSup_flow, reaCor.V_flow_in) annotation (Line(points={{612,58},{614,
          58},{614,78},{504,78},{504,90},{538,90}}, color={0,0,127}));
  connect(CO2Cor.y, reaCor.C_In) annotation (Line(points={{477,82},{538,82}},
                         color={0,0,127}));
  connect(PHeaCor.y, reaCor.PHea_in) annotation (Line(points={{477,96},{482,96},
          {482,86},{538,86}}, color={0,0,127}));
  connect(conVAVSou.yDam, oveSouLoc.yDam_in) annotation (Line(points={{659,-109.2},
          {667.5,-109.2},{667.5,-110},{678,-110}}, color={0,0,127}));
  connect(conVAVSou.yVal, oveSouLoc.yReaHea_in) annotation (Line(points={{659,-119},
          {668.5,-119},{668.5,-118},{678,-118}}, color={0,0,127}));
  connect(oveSouLoc.yDam_out, sou.yVAV) annotation (Line(points={{701,-110},{738,
          -110},{738,52},{746,52}}, color={0,0,127}));
  connect(oveSouLoc.yReaHea_out, gaiHeaCoiSou.u) annotation (Line(points={{701,-118},
          {708,-118},{708,-90},{700,-90},{700,20},{670,20},{670,44},{678,44}},
        color={0,0,127}));
  connect(oveSouSup.TZoneHeaSet_out, conVAVSou.TRooHeaSet) annotation (Line(
        points={{621,-110},{624.5,-110},{624.5,-107},{636,-107}}, color={0,0,127}));
  connect(oveSouSup.TZoneCooSet_out, conVAVSou.TRooCooSet) annotation (Line(
        points={{621,-118},{626,-118},{626,-114},{636,-114}}, color={0,0,127}));
  connect(conVAVSou.TRoo, reaSou.TZon_in) annotation (Line(points={{637,-121},{628,
          -121},{628,106},{718,106}}, color={0,0,127}));
  connect(reaSou.yDamAct_in, sou.yVAV) annotation (Line(points={{718,102},{680,102},
          {680,60},{738,60},{738,52},{746,52}}, color={0,0,127}));
  connect(reaSou.yReaHea_in, gaiHeaCoiSou.u) annotation (Line(points={{718,98},{
          670,98},{670,44},{678,44}}, color={0,0,127}));
  connect(reaSou.TSup_in, sou.TSup) annotation (Line(points={{718,94},{682,94},{
          682,68},{798,68},{798,48},{792,48}}, color={0,0,127}));
  connect(reaSou.V_flow_in, sou.VSup_flow) annotation (Line(points={{718,90},{684,
          90},{684,70},{792,70},{792,56}}, color={0,0,127}));
  connect(CO2Sou.y, reaSou.C_In) annotation (Line(points={{665,80},{668,80},{668,
          82},{718,82}}, color={0,0,127}));
  connect(PHeaSou.y, reaSou.PHea_in) annotation (Line(points={{665,94},{668,94},
          {668,86},{718,86}}, color={0,0,127}));
  connect(conVAVEas.yDam, oveEasLoc.yDam_in) annotation (Line(points={{843,-109.2},
          {850.5,-109.2},{850.5,-110},{858,-110}}, color={0,0,127}));
  connect(conVAVEas.yVal, oveEasLoc.yReaHea_in) annotation (Line(points={{843,-119},
          {850.5,-119},{850.5,-118},{858,-118}}, color={0,0,127}));
  connect(oveEasLoc.yDam_out, eas.yVAV) annotation (Line(points={{881,-110},{914,
          -110},{914,52},{926,52}}, color={0,0,127}));
  connect(oveEasLoc.yReaHea_out, gaiHeaCoiEas.u) annotation (Line(points={{881,-118},
          {900,-118},{900,20},{840,20},{840,44},{850,44}}, color={0,0,127}));
  connect(oveEasSup.TZoneHeaSet_out, conVAVEas.TRooHeaSet) annotation (Line(
        points={{801,-110},{810,-110},{810,-107},{820,-107}}, color={0,0,127}));
  connect(oveEasSup.TZoneCooSet_out, conVAVEas.TRooCooSet) annotation (Line(
        points={{801,-118},{812,-118},{812,-114},{820,-114}}, color={0,0,127}));
  connect(reaEas.TZon_in, conVAVEas.TRoo) annotation (Line(points={{898,106},{808,
          106},{808,-121},{821,-121}}, color={0,0,127}));
  connect(reaEas.yDamAct_in, eas.yVAV) annotation (Line(points={{898,102},{860,102},
          {860,60},{914,60},{914,52},{926,52}}, color={0,0,127}));
  connect(reaEas.yReaHea_in, gaiHeaCoiEas.u) annotation (Line(points={{898,98},{
          840,98},{840,44},{850,44}}, color={0,0,127}));
  connect(eas.TSup, reaEas.TSup_in) annotation (Line(points={{972,48},{976,48},{
          976,76},{862,76},{862,94},{898,94}}, color={0,0,127}));
  connect(eas.VSup_flow, reaEas.V_flow_in) annotation (Line(points={{972,56},{972,
          78},{864,78},{864,90},{898,90}}, color={0,0,127}));
  connect(CO2Eas.y, reaEas.C_In)
    annotation (Line(points={{835,82},{898,82}}, color={0,0,127}));
  connect(PHeaEas.y, reaEas.PHea_in) annotation (Line(points={{835,96},{842,96},
          {842,86},{898,86}}, color={0,0,127}));
  connect(conVAVNor.yDam, oveNorLoc.yDam_in) annotation (Line(points={{1017,-109.2},
          {1026.5,-109.2},{1026.5,-110},{1038,-110}}, color={0,0,127}));
  connect(conVAVNor.yVal, oveNorLoc.yReaHea_in) annotation (Line(points={{1017,-119},
          {1027.5,-119},{1027.5,-118},{1038,-118}}, color={0,0,127}));
  connect(oveNorLoc.yDam_out, nor.yVAV) annotation (Line(points={{1061,-110},{1074,
          -110},{1074,52},{1086,52}}, color={0,0,127}));
  connect(oveNorLoc.yReaHea_out, gaiHeaCoiNor.u) annotation (Line(points={{1061,
          -118},{1066,-118},{1066,20},{1010,20},{1010,44},{1016,44}}, color={0,0,
          127}));
  connect(oveNorSup.TZoneHeaSet_out, conVAVNor.TRooHeaSet) annotation (Line(
        points={{981,-110},{988,-110},{988,-107},{994,-107}}, color={0,0,127}));
  connect(oveNorSup.TZoneCooSet_out, conVAVNor.TRooCooSet) annotation (Line(
        points={{981,-118},{987.5,-118},{987.5,-114},{994,-114}}, color={0,0,127}));
  connect(reaNor.TZon_in, conVAVNor.TRoo) annotation (Line(points={{1078,106},{978,
          106},{978,-121},{995,-121}}, color={0,0,127}));
  connect(reaNor.yDamAct_in, nor.yVAV) annotation (Line(points={{1078,102},{1040,
          102},{1040,60},{1074,60},{1074,52},{1086,52}}, color={0,0,127}));
  connect(reaNor.yReaHea_in, gaiHeaCoiNor.u) annotation (Line(points={{1078,98},
          {1010,98},{1010,44},{1016,44}}, color={0,0,127}));
  connect(reaNor.TSup_in, nor.TSup) annotation (Line(points={{1078,94},{1042,94},
          {1042,68},{1138,68},{1138,48},{1132,48}}, color={0,0,127}));
  connect(nor.VSup_flow, reaNor.V_flow_in) annotation (Line(points={{1132,56},{1132,
          70},{1044,70},{1044,90},{1078,90}}, color={0,0,127}));
  connect(PHeaNor.y, reaNor.PHea_in) annotation (Line(points={{1007,94},{1020,94},
          {1020,86},{1078,86}}, color={0,0,127}));
  connect(CO2Nor.y, reaNor.C_In) annotation (Line(points={{1007,80},{1020,80},{1020,
          82},{1078,82}}, color={0,0,127}));
  connect(conVAVWes.yDam, oveWesLoc.yDam_in) annotation (Line(points={{1207,
          -109.2},{1212.5,-109.2},{1212.5,-110},{1226,-110}},
                                                      color={0,0,127}));
  connect(conVAVWes.yVal, oveWesLoc.yReaHea_in) annotation (Line(points={{1207,
          -119},{1214.5,-119},{1214.5,-118},{1226,-118}},
                                                    color={0,0,127}));
  connect(oveWesLoc.yDam_out, wes.yVAV) annotation (Line(points={{1249,-110},{
          1276,-110},{1276,52},{1286,52}},
                                      color={0,0,127}));
  connect(oveWesLoc.yReaHea_out, gaiHeaCoiWes.u) annotation (Line(points={{1249,
          -118},{1260,-118},{1260,20},{1200,20},{1200,44},{1206,44}}, color={0,0,
          127}));
  connect(oveWesSup.TZoneHeaSet_out, conVAVWes.TRooHeaSet) annotation (Line(
        points={{1169,-110},{1172,-110},{1172,-107},{1184,-107}}, color={0,0,
          127}));
  connect(oveWesSup.TZoneCooSet_out, conVAVWes.TRooCooSet) annotation (Line(
        points={{1169,-118},{1174,-118},{1174,-114},{1184,-114}}, color={0,0,
          127}));
  connect(reaWes.TZon_in, conVAVWes.TRoo) annotation (Line(points={{1258,106},{
          1160,106},{1160,-121},{1185,-121}}, color={0,0,127}));
  connect(reaWes.yDamAct_in, wes.yVAV) annotation (Line(points={{1258,102},{
          1220,102},{1220,60},{1276,60},{1276,52},{1286,52}}, color={0,0,127}));
  connect(reaWes.yReaHea_in, gaiHeaCoiWes.u) annotation (Line(points={{1258,98},
          {1200,98},{1200,44},{1206,44}}, color={0,0,127}));
  connect(reaWes.TSup_in, wes.TSup) annotation (Line(points={{1258,94},{1222,94},
          {1222,68},{1336,68},{1336,48},{1332,48}}, color={0,0,127}));
  connect(reaWes.V_flow_in, wes.VSup_flow) annotation (Line(points={{1258,90},{
          1224,90},{1224,70},{1332,70},{1332,56}}, color={0,0,127}));
  connect(PHeaWes.y, reaWes.PHea_in) annotation (Line(points={{1185,94},{1194,
          94},{1194,86},{1258,86}}, color={0,0,127}));
  connect(CO2Wes.y, reaWes.C_In) annotation (Line(points={{1185,80},{1194,80},{
          1194,82},{1258,82}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-400},{1440,
            660}})),
    Documentation(info="<html>
<p>
This is the multi zone office air simple emulator model
of BOPTEST.  It is based on the Modelica model
<a href=\"https://simulationresearch.lbl.gov/modelica/releases/latest/help/Buildings_Examples_VAVReheat.html#Buildings.Examples.VAVReheat.ASHRAE2006\"><code>Buildings.Examples.VAVReheat.ASHRAE2006</code></a>.
with the addition of CO2 concentration tracking and BOPTEST signal exchange blocks.
</p>
<h4>Architecture</h4>
<p>
The test case represents one floor with five zones of the new construction
medium office building for Chicago, IL, as described in the set of DOE
Commercial Building Benchmarks (Deru et al, 2009).
There are four perimeter zones and one core zone, with each perimeter zone
having a window-to-wall ratio of 0.33.  The height of each zone is 2.74 m
and the areas are as follows:
<ul>
<li>
North and South: 207.58 m<sup>2</sup>
</li>
<li>
East and West: 131.416 m<sup>2</sup>
</li>
<li>
Core: 984.672 m<sup>2</sup>
</li>
</ul>
</p>
<p>
Deru M., K. Field, D. Studer, K. Benne, B. Griffith, P. Torcellini,
 M. Halverson, D. Winiarski, B. Liu, M. Rosenberg, J. Huang, M. Yazdanian, and D. Crawley.
<i>DOE commercial building research benchmarks for commercial buildings</i>.
Technical report, U.S. Department of Energy, Energy Efficiency and
Renewable Energy, Office of Building Technologies, Washington, DC, 2009.
</p>
<h4>Constructions</h4>
<p>
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
</p>
<h4>Occupancy schedules</h4>
<p>
The design occupancy density is 0.05 people/m<sup>2</sup>.  The number of occupants
present in each zone at any time coincides with the internal gain schedule
defined in the next section.
The occupied time for the HVAC system is between 6 AM and 7 PM each day.  The
unoccupied time is outside of this period.
</p>
<h4>Internal loads and schedules</h4>
<p>
The design internal gains including lighting, plug loads, and people
are combined 20 W/m<sup>2</sup> with a radiant-convective-latent split of 40%-40%-20%.
The internal gains are activated according to the schedule in the figure below.
</p>
<p align=\"center\">
<img alt=\"Internal gains schedule.\"
src=\"../../../doc/images/InternalGainsSchedule.png\" width=600 />
</p>
<h4>Climate data</h4>
<p>
The weather data is from TMY3 for Chicago O'Hare International Airport.
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
The HVAC system is a multi-zone single-duct Variable Air Volume (VAV) system
with pressure-independent terminal boxes with reheat.
A schematic of the system is shown in the
figure below.  The cooling and heating coils are water-based.
Only the air distribution system is included, while the central plant is
ideally modeled using water sources with prescribed temperatures and constant
plant equipment efficiencies. The available sensor and control points, marked
on the figure below and described in more detail in the Section Model IO's,
are those specified as required by ASHRAE Guideline 36 2018
Section 4 List of Hardwired Points, specifically
Table 4.2 VAV Terminal Unit with Reheat and Table 4.6 Multiplie-Zone VAV Air
Handling Unit, as well as many that are specified as
application specific or optional.
</p>
<p align=\"center\">
<img alt=\"Schematic of HVAC system.\"
src=\"../../../doc/images/Schematic.png\"/>
</p>
<h4>Equipment specifications and performance maps</h4>
<p>
The terminal box dampers have exponential opening characteristics with design
airflow rates defined in the table below.  The design system airflow rate includes
a 0.7 load diversity factor and is defined in the table below.

The minimum outside airflow for each zone is calculated using outside
airflow rates of 0.3e-3 m<sup>3</sup>/s-m<sup>2</sup> and 2.5e-3 m<sup>3</sup>/s-person.  The limiting
zone air distribution effectiveness is 0.8 and the occupant diversity
ratio is 0.7.  This leads to the minimum outside airflow rates for each zone
and system defined in the table below.
</p>
<p>
<b>Table 1: Zone and System Specifications Summary</b>
<table>
  <tr>
  <th>Name</th>
  <th>Design Airflow [m<sup>3</sup>/s]</th>
  <th>Min OA Airflow [m<sup>3</sup>/s]</th>
  </tr>
  <tr>
  <td>North</td>
  <td>0.947948667</td>
  <td>0.1102769</td>
  </tr>
  <tr>
  <td>South</td>
  <td>0.947948667</td>
  <td>0.1102769</td>
  </tr>
  <tr>
  <td>East</td>
  <td>0.9001996</td>
  <td>0.0698148</td>
  </tr>
  <tr>
  <td>west</td>
  <td>0.700155244</td>
  <td>0.0698148</td>
  </tr>
  <tr>
  <td>Core</td>
  <td>4.4966688</td>
  <td>0.5231070</td>
  </tr>
  <tr>
  <td>System</td>
  <td>5.595044684</td>
  <td>0.8590431</td>
  </tr>
</table>
</p>

<p>
The supply fan hydraulic efficiency is constant at 0.7 and the motor
efficiency is constant at 0.7.  The cooling coil is served by a heat pump
with constant COP of 3.2 and the heating coils are served by a heat pump
with constant COP of 4.0.
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
The baseline control emulates a typical scheme seen in practice and is based on
the ASHRAE VAV 2A2-21232 of the Sequences of Operation for Common HVAC Systems 2006
as well as that which is implemented as baseline control in the Modelica Buildings
Library model
<a href=\"https://simulationresearch.lbl.gov/modelica/releases/latest/help/Buildings_Examples_VAVReheat.html#Buildings.Examples.VAVReheat.ASHRAE2006\"><code>Buildings.Examples.VAVReheat.ASHRAE2006</code></a>.
Setpoints and equipment enable/disable are determined by a schedule-based supervisory control
scheme that defines a set of operating modes.  This scheme is summarized in
Table 2 below.
</p>
<p>
<b>Table 2: HVAC Operating Mode Summary</b>
<table>
  <tr>
  <th>Name</th>
  <th>Condition </th>
  <th>TZonHeaSet [degC]</th>
  <th>TZonCooSet [degC]</th>
  <th>Fan [degC]</th>
  <th>TSupSet [degC]</th>
  <th>Economizer</th>
  <th>Min OA Flow</th>
  </tr>
  <tr>
  <td>Occupied</td>
  <td>In occupied period</td>
  <td>20</td>
  <td>24</td>
  <td>Enabled</td>
  <td>12</td>
  <td>Enabled</td>
  <td>Ventilation</td>
  </tr>
  <tr>
  <td>Unoccupied off</td>
  <td>In unoccupied period, all TZon within setback deadband</td>
  <td>12</td>
  <td>30</td>
  <td>Disabled</td>
  <td>12</td>
  <td>Disabled</td>
  <td>Zero</td>
  </tr>
  <tr>
  <td>Unoccupied, night setback</td>
  <td>In unoccupied period, minimum TZon below unoccupied TZonHeaSet</td>
  <td>12</td>
  <td>30</td>
  <td>Enabled</td>
  <td>35</td>
  <td>Disabled</td>
  <td>Zero</td>
  </tr>
  <tr>
  <td>Unoccupied, warm-up</td>
  <td>In unoccupied period, within 30 minutes of occupied period, average TZon below occupied TZonHeaSet</td>
  <td>20</td>
  <td>30</td>
  <td>Enabled</td>
  <td>35</td>
  <td>Disabled</td>
  <td>Zero</td>
  </tr>
  <tr>
  <td>Unoccupied, pre-cool</td>
  <td>In unoccupied period, within 30 minutes of occupied period, outside TDryBul below limit of 13 degC, average TZon above occupied TZonCooSet</td>
  <td>12</td>
  <td>24</td>
  <td>Enabled</td>
  <td>12</td>
  <td>Enabled</td>
  <td>Zero</td>
  </tr>
</table>
</p>
<p>
Once the operating mode is determined, a number of low-level, local-loop
controllers are used to maintain the desired setpoints using the available
actuators.  The primary local-loop controllers are specified on the diagram above
as C1 to C3.
</p>
<p>
C1 is responsible for maintaining the zone temperature setpoints as
determined by the operating mode of the system and implements
dual-maximum logic, as shown in the Figure below.  It takes
as inputs the zone temperature heating and cooling setpoints and zone temperature
measurement, and outputs the desired airflow rate of the damper and position
of the reheat valve.  Seperate PI controllers are used for control of the
damper airflow for cooling and reheat valve position for heating.  If the
zone requires heating, the desired airflow rate of the damper is mapped
to the specified maximum value for heating.
</p>

<p align=\"center\">
<img alt=\"Controller C1.\"
src=\"../../../doc/images/C1.png\"/>
</p>

<p>
C2 is responsible for maintaining the duct static pressure setpoint
and implements a duct static pressure reset strategy.  The first step of
the controller takes as input all of the terminal box damper positions and
outputs a duct static pressure setpoint using a PI controller such that the
maximum damper position is maintained at 0.9.  The second step then maintains
this setpoint using a PI controller and measured duct static pressure as input
to output a fan speed setpoint.
</p>

<p align=\"center\">
<img alt=\"Controller C2.\"
src=\"../../../doc/images/C2.png\"/>
</p>

<p>
C3 is responsible for maintaining the supply air temperature setpoint as well
as the minimum outside air flow rate as determined by the operating mode
of the system.  It takes as inputs the
supply air temperature setpoint, supply air temperature measurement, outside
airflow rate setpoint, outside airflow rate measurement, and outside
drybulb temperature measurement.  The first part
of the controller uses a PI controller for supply air temperature setpoint
tracking to output a signal that is then mapped to position
setpoints for the heating coil valve, cooling coil valve, and outside air
damper position.  The second part of the controller uses a PI controller
for outside airflow setpoint tracking to output a second signal for
outside air damper position.  The maximum of the two outside air damper position
signals is finally output to ensure at least enough enough airflow is delivered
for ventilation when needed.  The economizer is enabled only if the outside
drybulb temperature is lower than the return air temperature.
</p>

<p align=\"center\">
<img alt=\"Controller C3.\"
src=\"../../../doc/images/C3.png\"/>
</p>

<p>
Also present, but not depicted in the diagrams above, is a freeze stat controller.
This controller detects potentially freezing conditions by measuring the
mixed air temperature and determining if it is less than a limit, 3 degC.
If true, the controller will enable C3 to track the supply air temperature setpoint.
In this case, the heating coil will be activated to do so.
</p>

<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>oveAhu_TSupSet_u</code> [K] [min=285.15, max=313.15]: Supply air temperature setpoint for AHU
</li>
<li>
<code>oveAhu_dpSet_u</code> [Pa] [min=50.0, max=410.0]: Supply duct pressure setpoint for AHU
</li>
<li>
<code>oveAhu_yCoo_u</code> [1] [min=0.0, max=1.0]: Cooling coil control signal for AHU
</li>
<li>
<code>oveAhu_yFan_u</code> [1] [min=0.0, max=1.0]: Supply fan speed setpoint for AHU
</li>
<li>
<code>oveAhu_yHea_u</code> [1] [min=0.0, max=1.0]: Heating coil control signal for AHU
</li>
<li>
<code>oveAhu_yOA_u</code> [1] [min=0.0, max=1.0]: Outside air damper position setpoint for AHU
</li>
<li>
<code>oveAhu_yRet_u</code> [1] [min=0.0, max=1.0]: Return air damper position setpoint for AHU
</li>
<li>
<code>oveCor_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone Core
</li>
<li>
<code>oveCor_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone Core
</li>
<li>
<code>oveCor_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone Core
</li>
<li>
<code>oveCor_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone Core
</li>
<li>
<code>oveEas_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone East
</li>
<li>
<code>oveEas_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone East
</li>
<li>
<code>oveEas_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone East
</li>
<li>
<code>oveEas_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone East
</li>
<li>
<code>oveNor_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone North
</li>
<li>
<code>oveNor_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone North
</li>
<li>
<code>oveNor_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone North
</li>
<li>
<code>oveNor_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone North
</li>
<li>
<code>oveSou_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone South
</li>
<li>
<code>oveSou_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone South
</li>
<li>
<code>oveSou_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone South
</li>
<li>
<code>oveSou_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone South
</li>
<li>
<code>oveWes_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone West
</li>
<li>
<code>oveWes_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone West
</li>
<li>
<code>oveWes_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone West
</li>
<li>
<code>oveWes_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone West
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>reaAhu_PCoo_y</code> [W] [min=None, max=None]: Electrical power measurement of cooling for AHU
</li>
<li>
<code>reaAhu_PFanSup_y</code> [W] [min=None, max=None]: Electrical power measurement of supply fan for AHU
</li>
<li>
<code>reaAhu_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for heating coil for AHU
</li>
<li>
<code>reaAhu_TMix_y</code> [K] [min=None, max=None]: Mixed air temperature measurement for AHU
</li>
<li>
<code>reaAhu_TRet_y</code> [K] [min=None, max=None]: Return air temperature measurement for AHU
</li>
<li>
<code>reaAhu_TSup_y</code> [K] [min=None, max=None]: Supply air temperature measurement for AHU
</li>
<li>
<code>reaAhu_V_flow_out_y</code> [m3/s] [min=None, max=None]: Outside air flowrate measurement for AHU
</li>
<li>
<code>reaAhu_V_flow_ret_y</code> [m3/s] [min=None, max=None]: Return air flowrate measurement for AHU
</li>
<li>
<code>reaAhu_V_flow_sup_y</code> [m3/s] [min=None, max=None]: Supply air flowrate measurement for AHU
</li>
<li>
<code>reaAhu_dp_sup_y</code> [Pa] [min=None, max=None]: Discharge pressure of supply fan for AHU
</li>
<li>
<code>reaAhu_yCooAct_y</code> [1] [min=None, max=None]: Cooling coil control signal feedback for AHU
</li>
<li>
<code>reaAhu_yFanAct_y</code> [1] [min=None, max=None]: Supply fan speed set point feedback for AHU
</li>
<li>
<code>reaAhu_yHeaAct_y</code> [1] [min=None, max=None]: Heating coil control signal feedback for AHU
</li>
<li>
<code>reaAhu_yOA_y</code> [1] [min=None, max=None]: Outside air damper position set point feedback for AHU
</li>
<li>
<code>reaAhu_yRelAct_y</code> [1] [min=None, max=None]: Relief air damper position set point feedback for AHU
</li>
<li>
<code>reaAhu_yRetAct_y</code> [1] [min=None, max=None]: Return air damper position set point feedback for AHU
</li>
<li>
<code>reaCor_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone Core
</li>
<li>
<code>reaCor_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone Core
</li>
<li>
<code>reaCor_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone Core
</li>
<li>
<code>reaCor_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone Core
</li>
<li>
<code>reaCor_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone Core
</li>
<li>
<code>reaCor_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone Core
</li>
<li>
<code>reaCor_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone Core
</li>
<li>
<code>reaEas_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone East
</li>
<li>
<code>reaEas_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone East
</li>
<li>
<code>reaEas_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone East
</li>
<li>
<code>reaEas_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone East
</li>
<li>
<code>reaEas_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone East
</li>
<li>
<code>reaEas_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone East
</li>
<li>
<code>reaEas_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone East
</li>
<li>
<code>reaNor_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone North
</li>
<li>
<code>reaNor_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone North
</li>
<li>
<code>reaNor_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone North
</li>
<li>
<code>reaNor_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone North
</li>
<li>
<code>reaNor_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone North
</li>
<li>
<code>reaNor_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone North
</li>
<li>
<code>reaNor_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone North
</li>
<li>
<code>reaSou_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone South
</li>
<li>
<code>reaSou_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone South
</li>
<li>
<code>reaSou_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone South
</li>
<li>
<code>reaSou_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone South
</li>
<li>
<code>reaSou_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone South
</li>
<li>
<code>reaSou_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone South
</li>
<li>
<code>reaSou_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone South
</li>
<li>
<code>reaWes_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone West
</li>
<li>
<code>reaWes_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone West
</li>
<li>
<code>reaWes_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone West
</li>
<li>
<code>reaWes_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone West
</li>
<li>
<code>reaWes_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone West
</li>
<li>
<code>reaWes_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone West
</li>
<li>
<code>reaWes_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone West
</li>
<li>
<code>weaSta_reaWeaCeiHei_y</code> [m] [min=None, max=None]: Cloud cover ceiling height measurement
</li>
<li>
<code>weaSta_reaWeaCloTim_y</code> [s] [min=None, max=None]: Day number with units of seconds
</li>
<li>
<code>weaSta_reaWeaHDifHor_y</code> [W/m2] [min=None, max=None]: Horizontal diffuse solar radiation measurement
</li>
<li>
<code>weaSta_reaWeaHDirNor_y</code> [W/m2] [min=None, max=None]: Direct normal radiation measurement
</li>
<li>
<code>weaSta_reaWeaHGloHor_y</code> [W/m2] [min=None, max=None]: Global horizontal solar irradiation measurement
</li>
<li>
<code>weaSta_reaWeaHHorIR_y</code> [W/m2] [min=None, max=None]: Horizontal infrared irradiation measurement
</li>
<li>
<code>weaSta_reaWeaLat_y</code> [rad] [min=None, max=None]: Latitude of the location
</li>
<li>
<code>weaSta_reaWeaLon_y</code> [rad] [min=None, max=None]: Longitude of the location
</li>
<li>
<code>weaSta_reaWeaNOpa_y</code> [1] [min=None, max=None]: Opaque sky cover measurement
</li>
<li>
<code>weaSta_reaWeaNTot_y</code> [1] [min=None, max=None]: Sky cover measurement
</li>
<li>
<code>weaSta_reaWeaPAtm_y</code> [Pa] [min=None, max=None]: Atmospheric pressure measurement
</li>
<li>
<code>weaSta_reaWeaRelHum_y</code> [1] [min=None, max=None]: Outside relative humidity measurement
</li>
<li>
<code>weaSta_reaWeaSolAlt_y</code> [rad] [min=None, max=None]: Solar altitude angle measurement
</li>
<li>
<code>weaSta_reaWeaSolDec_y</code> [rad] [min=None, max=None]: Solar declination angle measurement
</li>
<li>
<code>weaSta_reaWeaSolHouAng_y</code> [rad] [min=None, max=None]: Solar hour angle measurement
</li>
<li>
<code>weaSta_reaWeaSolTim_y</code> [s] [min=None, max=None]: Solar time
</li>
<li>
<code>weaSta_reaWeaSolZen_y</code> [rad] [min=None, max=None]: Solar zenith angle measurement
</li>
<li>
<code>weaSta_reaWeaTBlaSky_y</code> [K] [min=None, max=None]: Black-body sky temperature measurement
</li>
<li>
<code>weaSta_reaWeaTDewPoi_y</code> [K] [min=None, max=None]: Dew point temperature measurement
</li>
<li>
<code>weaSta_reaWeaTDryBul_y</code> [K] [min=None, max=None]: Outside drybulb temperature measurement
</li>
<li>
<code>weaSta_reaWeaTWetBul_y</code> [K] [min=None, max=None]: Wet bulb temperature measurement
</li>
<li>
<code>weaSta_reaWeaWinDir_y</code> [rad] [min=None, max=None]: Wind direction measurement
</li>
<li>
<code>weaSta_reaWeaWinSpe_y</code> [m/s] [min=None, max=None]: Wind speed measurement
</li>
</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
Lighting heat gain is included in the internal heat gains and is not controllable.
</p>
<h4>Shading</h4>
<p>
There is no shading on this building.
</p>
<h4>Onsite Generation and Storage</h4>
<p>
There is no onsite generation or storage on this building site.
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
A moist air model is used.  Relative humidity is tracked based on latent
heat gain from occupants, outside air relative humidity, and a cooling
coil model that includes condensation.
</p>
<h4>Pressure-flow models</h4>
<p>
The duct airflow is modeled using a pressure-flow network.
</p>
<h4>Infiltration models</h4>
<p>
Airflow due to infiltration is calculated based on time-varying
wind pressure coefficients for each facade using
<a href=\"https://simulationresearch.lbl.gov/modelica/releases/latest/help/Buildings_Fluid_Sources.html#Buildings.Fluid.Sources.Outside_CpLowRise\"><code>Buildings.Fluid.Sources.Outside_CpLowRise</code></a>.
</p>
<h4>CO2 models</h4>
<p>
CO2 generation is 0.0048 L/s per person (Table 5, Persily and De Jonge 2017)
and density of CO2 assumed to be 1.8 kg/m<sup>3</sup>,
making CO2 generation 8.64e-6 kg/s per person.
Outside air CO2 concentration is 400 ppm.
</p>
<p>
Persily, A. and De Jonge, L. (2017).
Carbon dioxide generation rates for building occupants.
Indoor Air, 27, 868–879.  https://doi.org/10.1111/ina.12383.
</p>
<h3>Scenario Information</h3>
<h4>Energy Pricing</h4>
<p>
Constant electricity prices are based on those from ComEd [1], the utility serving
the greater Chicago area.  The price is based on the Basic Electricity Service (BES)
rate provided to the Watt-Hour customer class for applicable charges per kWh.
This calculation is an approximation to obtain a reasonable estimate of price.
The charges included are as follows:
</p>
<ul>
<li>
PJM Services Charge: $0.01211
</li>
<li>
Retail Purchased Electricity Charge: $0.05158
</li>
<li>
Delivery Services Charge:
i) Distribution Facilities Charge: $0.01935
ii) Illinois Electricity Distribution Tax Charge: $0.00121
</li>
<li>
Rider ECR - Environmental Cost Recovery Adjustment: $0.00031
</li>
<li>
Rider EEPP - Energy Efficiency Pricing and Performance: $0.0026
</li>
<li>
Rider REA - Renewable Energy Adjustment: $0.00189
</li>
<li>
Rider TAX - Municipal and State Tax Additions: $0.003
</li>
<li>
Rider ZEA - Zero Emission Adjustment: $0.00195
</li>
</ul>

<p>
The total constant electricity price is $0.094/kWh
</p>
<p>
Dynamic electricity prices are based on those from ComEd [1], the utility serving
the greater Chicago area.  The price is based on the Residential Time of Use Pricing Pilot
(RTOUPP) rate for applicable charges per kWh.
This calculation is an approximation to obtain a reasonable estimate of dynamic
price.  The charges included are the same as the constant scenario (using BES)
except for the following change:

<li>
Retail Purchased Electricity Charge:
<p>
Summer (Jun, Jul, Aug, Sep):
<ul>
<li>
i) Super Peak Period: $0.12727, 2pm-7pm
</li>
<li>
ii) Peak Period: $0.02868, 6am-2pm and 7pm-10pm
</li>
<li>
iii) Off Peak Period: $0.01584, 10pm-6am
</li>
</ul>
Winter:
<ul>
<li>
i) Super Peak Period: $0.11748, 2pm-7pm
</li>
<li>
ii) Peak Period: $0.02664, 6am-2pm and 7pm-10pm
</li>
<li>
iii) Off Peak Period: $0.01629, 10pm-6am
</li>
</ul>
</p>
</li>
</p>
<p>
Highly Dynamic electricity prices are based on those from ComEd [1], the utility serving
the greater Chicago area.  The price is based on the Basic Electric Service Hourly Pricing
(BESH) rate for applicable charges per kWh.
This calculation is an approximation to obtain a reasonable estimate of
highly dynamic price.  The charges included are the same as the constant
scenario (using BES) except for the following change:

<li>
PJM Services Charge: $0.00836
</li>
<li>
Retail Purchased Electricity Charge: Based on Wholesale Day-Ahead Prices
for the year of 2019 based on [2].
</li>
</p>

<p>
References:
<li>
[1] https://www.comed.com/MyAccount/MyBillUsage/Pages/CurrentRatesTariffs.aspx
</li>
<li>
[2] https://secure.comed.com/MyAccount/MyBillUsage/Pages/RatesPricing.aspx
</li>
</p>
<h4>Emission Factors</h4>
<p>
The Electricity Emissions Factor profile is based on the average annual emissions
from 2019 for the state of Illinois, USA per the EIA.
It is 752 lbs/MWh or 0.341 kgCO2/kWh.
For reference, see https://www.eia.gov/electricity/state/illinois/
</p>
<p>
The Gas Emissions Factor profile is based on the kgCO2 emitted per amount of
natural gas burned in terms of energy content.
It is 0.18108 kgCO2/kWh (53.07 kgCO2/milBTU).
For reference, see https://www.eia.gov/environment/emissions/co2_vol_mass.php.
</p>
</html>", revisions="<html>
<ul>
<li>
May 12, 2021 by David Blum:<br/>
Refactor based on updates to Modelica Buildings Library
in <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2485\">issue #2485</a>.
</li>
<li>
March 19, 2021 by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/ASHRAE2006.mos"
        "Simulate and plot"),
    experiment(
      StopTime=31536000,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end TestCase;
