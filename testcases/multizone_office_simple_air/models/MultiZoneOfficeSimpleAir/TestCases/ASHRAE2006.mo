within MultiZoneOfficeSimpleAir.TestCases;
model ASHRAE2006
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  extends Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop(
    heaCoi(show_T=true),
    cooCoi(show_T=true));

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
    VOut_flow_min=Vot_flow_nominal,
    Ti=120,
    k=0.1) "Controller for economizer"
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
        ratVMinCor_flow, ratVFloHea=0.3)
    "Controller for terminal unit corridor"
    annotation (Placement(transformation(extent={{530,32},{550,52}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVSou(ratVFloMin=
        ratVMinSou_flow, ratVFloHea=0.3) "Controller for terminal unit south"
    annotation (Placement(transformation(extent={{700,30},{720,50}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVEas(ratVFloMin=
        ratVMinEas_flow, ratVFloHea=0.3) "Controller for terminal unit east"
    annotation (Placement(transformation(extent={{880,30},{900,50}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVNor(ratVFloMin=
        ratVMinNor_flow, ratVFloHea=0.3) "Controller for terminal unit north"
    annotation (Placement(transformation(extent={{1040,30},{1060,50}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVWes(ratVFloMin=
        ratVMinWes_flow, ratVFloHea=0.3) "Controller for terminal unit west"
    annotation (Placement(transformation(extent={{1240,28},{1260,48}})));

  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-60,-250},{-40,-230}})));
  Buildings.Examples.VAVReheat.Controls.SupplyAirTemperature conTSup
    "Supply air temperature controller"
    annotation (Placement(transformation(extent={{30,-230},{50,-210}})));
  Buildings.Examples.VAVReheat.Controls.SupplyAirTemperatureSetpoint TSupSet
    "Supply air temperature set point"
    annotation (Placement(transformation(extent={{-200,-230},{-180,-210}})));
  BaseClasses.ReadZone reaCor(zone="Core") "Read blocks for Core zone"
    annotation (Placement(transformation(extent={{540,80},{560,100}})));
  BaseClasses.ReadZone reaSou(zone="South") "Read blocks for South zone"
    annotation (Placement(transformation(extent={{700,80},{720,100}})));
  BaseClasses.ReadZone reaEas(zone="East") "Read blocks for East zone"
    annotation (Placement(transformation(extent={{890,80},{910,100}})));
  BaseClasses.ReadZone reaNor(zone="North") "Read blocks for North zone"
    annotation (Placement(transformation(extent={{1050,80},{1070,100}})));
  BaseClasses.ReadZone reaWes(zone="West") "Read blocks for West zone"
    annotation (Placement(transformation(extent={{1240,80},{1260,100}})));
  BaseClasses.WriteZone oveCor(zone="Core") "Overwrite blocks for Core zone"
    annotation (Placement(transformation(extent={{530,-30},{550,-10}})));
  BaseClasses.WriteZone oveSou(zone="South") "Overwrite blocks for South zone"
    annotation (Placement(transformation(extent={{700,-30},{720,-10}})));
  BaseClasses.WriteZone oveEas(zone="East") "Overwrite blocks for East zone"
    annotation (Placement(transformation(extent={{880,-30},{900,-10}})));
  BaseClasses.WriteZone oveNor(zone="North") "Overwrite blocks for North zone"
    annotation (Placement(transformation(extent={{1040,-30},{1060,-10}})));
  BaseClasses.WriteZone oveWes(zone="West") "Overwrite blocks for West zone"
    annotation (Placement(transformation(extent={{1240,-30},{1260,-10}})));
  BaseClasses.ReadAhu reaAhu "Read blocks for AHU"
    annotation (Placement(transformation(extent={{240,302},{260,342}})));
  Modelica.Blocks.Sources.RealExpression yOut_actual(y=eco.damOut.y_actual)
    "Source for actual outside air damper position feedback"
    annotation (Placement(transformation(extent={{140,306},{160,326}})));
  Modelica.Blocks.Sources.RealExpression yExh_actual(y=eco.damExh.y_actual)
    "Source for actual exhaust air damper position feedback"
    annotation (Placement(transformation(extent={{140,290},{160,310}})));
  Modelica.Blocks.Sources.RealExpression yRet_actual(y=eco.damRet.y_actual)
    "Source for actual recirculation air damper position feedback"
    annotation (Placement(transformation(extent={{140,274},{160,294}})));
  BaseClasses.WriteAhu writeAhu
    annotation (Placement(transformation(extent={{240,40},{260,70}})));
equation
  connect(fanSup.port_b, dpDisSupFan.port_a) annotation (Line(
      points={{320,-40},{320,0},{320,-10},{320,-10}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dot));
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
      points={{100,151},{100,172},{-94,172},{-94,153.333},{-81.3333,153.333}},
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
      points={{-81.3333,142.667},{-90,142.667},{-90,80},{-61,80},{-61,-20.9}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(conVAVCor.TRoo, TRooAir.y5[1]) annotation (Line(
      points={{529,35},{520,35},{520,162},{511,162}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conVAVSou.TRoo, TRooAir.y1[1]) annotation (Line(
      points={{699,33},{690,33},{690,36},{680,36},{680,178},{511,178}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y2[1], conVAVEas.TRoo) annotation (Line(
      points={{511,174},{868,174},{868,33},{879,33}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y3[1], conVAVNor.TRoo) annotation (Line(
      points={{511,170},{1028,170},{1028,33},{1039,33}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y4[1], conVAVWes.TRoo) annotation (Line(
      points={{511,166},{1220,166},{1220,31},{1239,31}},
      color={0,0,127},
      pattern=LinePattern.Dash));

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
  connect(freSta.y, or2.u1) annotation (Line(points={{22,-90},{40,-90},{40,-160},
          {-80,-160},{-80,-240},{-62,-240}},                 color={255,0,255}));
  connect(or2.u2, modeSelector.yFan) annotation (Line(points={{-62,-248},{-80,
          -248},{-80,-305.455},{-179.091,-305.455}},
                                     color={255,0,255}));
  connect(cor.y_actual, pSetDuc.u[1]) annotation (Line(points={{612,58},{620,58},
          {620,74},{140,74},{140,-7.6},{158,-7.6}}, color={0,0,127}));
  connect(sou.y_actual, pSetDuc.u[2]) annotation (Line(points={{792,56},{800,56},
          {800,74},{140,74},{140,-6.8},{158,-6.8}}, color={0,0,127}));
  connect(eas.y_actual, pSetDuc.u[3]) annotation (Line(points={{972,56},{980,56},
          {980,74},{140,74},{140,-6},{158,-6}}, color={0,0,127}));
  connect(nor.y_actual, pSetDuc.u[4]) annotation (Line(points={{1132,56},{1140,
          56},{1140,74},{140,74},{140,-5.2},{158,-5.2}}, color={0,0,127}));
  connect(wes.y_actual, pSetDuc.u[5]) annotation (Line(points={{1332,56},{1338,
          56},{1338,74},{140,74},{140,-4.4},{158,-4.4}}, color={0,0,127}));
  connect(TSup.T, conTSup.TSup) annotation (Line(
      points={{340,-29},{340,-20},{360,-20},{360,-280},{0,-280},{0,-214},{28,
          -214}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conTSup.yOA, conEco.uOATSup) annotation (Line(
      points={{52,-220},{60,-220},{60,180},{-86,180},{-86,158.667},{-81.3333,
          158.667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(or2.y, conTSup.uEna) annotation (Line(points={{-38,-240},{20,-240},{
          20,-226},{28,-226}}, color={255,0,255}));
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
  connect(conVAVCor.TRoo, reaCor.TZon_in) annotation (Line(points={{529,35},{
          520,35},{520,98},{538,98}}, color={0,0,127}));
  connect(cor.y_actual, reaCor.yDamAct_in) annotation (Line(points={{612,58},{
          620,58},{620,72},{522,72},{522,94},{538,94}}, color={0,0,127}));
  connect(cor.yVal, reaCor.yReaHea_in) annotation (Line(points={{566,34},{560,
          34},{560,70},{524,70},{524,90},{538,90}}, color={0,0,127}));
  connect(conVAVSou.TRoo, reaSou.TZon_in) annotation (Line(points={{699,33},{
          680,33},{680,98},{698,98}}, color={0,0,127}));
  connect(sou.y_actual, reaSou.yDamAct_in) annotation (Line(points={{792,56},{
          800,56},{800,72},{682,72},{682,94},{698,94}}, color={0,0,127}));
  connect(sou.yVal, reaSou.yReaHea_in) annotation (Line(points={{746,32},{738,
          32},{738,70},{686,70},{686,90},{698,90}}, color={0,0,127}));
  connect(reaEas.TZon_in, conVAVEas.TRoo) annotation (Line(points={{888,98},{
          868,98},{868,33},{879,33}}, color={0,0,127}));
  connect(TSupCor.T, reaCor.TSup_in) annotation (Line(points={{569,92},{564,92},
          {564,76},{526,76},{526,86},{538,86}}, color={0,0,127}));
  connect(VSupCor_flow.V_flow, reaCor.V_flow_in) annotation (Line(points={{569,
          130},{530,130},{530,82},{538,82}}, color={0,0,127}));
  connect(TSupSou.T, reaSou.TSup_in) annotation (Line(points={{749,92},{740,92},
          {740,76},{686,76},{686,86},{698,86}}, color={0,0,127}));
  connect(VSupSou_flow.V_flow, reaSou.V_flow_in) annotation (Line(points={{749,
          130},{688,130},{688,82},{698,82}}, color={0,0,127}));
  connect(TSupEas.T, reaEas.TSup_in) annotation (Line(points={{929,90},{920,90},
          {920,76},{874,76},{874,86},{888,86}}, color={0,0,127}));
  connect(eas.y_actual, reaEas.yDamAct_in) annotation (Line(points={{972,56},{
          980,56},{980,72},{870,72},{870,94},{888,94}}, color={0,0,127}));
  connect(eas.yVal, reaEas.yReaHea_in) annotation (Line(points={{926,32},{916,
          32},{916,70},{872,70},{872,90},{888,90}}, color={0,0,127}));
  connect(VSupEas_flow.V_flow, reaEas.V_flow_in) annotation (Line(points={{929,
          128},{876,128},{876,82},{888,82}}, color={0,0,127}));
  connect(reaNor.TZon_in, conVAVNor.TRoo) annotation (Line(points={{1048,98},{
          1028,98},{1028,33},{1039,33}}, color={0,0,127}));
  connect(nor.y_actual, reaNor.yDamAct_in) annotation (Line(points={{1132,56},{
          1140,56},{1140,72},{1030,72},{1030,94},{1048,94}}, color={0,0,127}));
  connect(nor.yVal, reaNor.yReaHea_in) annotation (Line(points={{1086,32},{1076,
          32},{1076,70},{1032,70},{1032,90},{1048,90}}, color={0,0,127}));
  connect(TSupNor.T, reaNor.TSup_in) annotation (Line(points={{1089,94},{1080,
          94},{1080,76},{1034,76},{1034,86},{1048,86}}, color={0,0,127}));
  connect(VSupNor_flow.V_flow, reaNor.V_flow_in) annotation (Line(points={{1089,
          132},{1036,132},{1036,82},{1048,82}}, color={0,0,127}));
  connect(reaWes.TZon_in, conVAVWes.TRoo) annotation (Line(points={{1238,98},{
          1220,98},{1220,31},{1239,31}}, color={0,0,127}));
  connect(wes.y_actual, reaWes.yDamAct_in) annotation (Line(points={{1332,56},{
          1338,56},{1338,74},{1222,74},{1222,94},{1238,94}}, color={0,0,127}));
  connect(wes.yVal, reaWes.yReaHea_in) annotation (Line(points={{1286,32},{1276,
          32},{1276,72},{1224,72},{1224,90},{1238,90}}, color={0,0,127}));
  connect(TSupWes.T, reaWes.TSup_in) annotation (Line(points={{1289,90},{1280,
          90},{1280,76},{1226,76},{1226,86},{1238,86}}, color={0,0,127}));
  connect(VSupWes_flow.V_flow, reaWes.V_flow_in) annotation (Line(points={{1289,
          128},{1228,128},{1228,82},{1238,82}}, color={0,0,127}));
  connect(conVAVCor.yDam, oveCor.uDam_in) annotation (Line(points={{551,46.8},{
          556,46.8},{556,28},{520,28},{520,-20},{528,-20}}, color={0,0,127}));
  connect(conVAVCor.yVal, oveCor.uReaHea_in) annotation (Line(points={{551,37},
          {554,37},{554,30},{518,30},{518,-24},{528,-24}}, color={0,0,127}));
  connect(oveCor.yDam, cor.yVAV) annotation (Line(points={{551,-20},{558,-20},{
          558,50},{566,50}}, color={0,0,127}));
  connect(oveCor.yReaHea, cor.yVal) annotation (Line(points={{551,-24},{560,-24},
          {560,34},{566,34}}, color={0,0,127}));
  connect(oveCor.TZoneHeaSet_out, conVAVCor.TRooHeaSet) annotation (Line(points=
         {{551,-12},{554,-12},{554,26},{522,26},{522,49},{528,49}}, color={0,0,
          127}));
  connect(oveCor.TZoneCooSet_out, conVAVCor.TRooCooSet) annotation (Line(points=
         {{551,-16},{556,-16},{556,24},{524,24},{524,42},{528,42}}, color={0,0,
          127}));
  connect(oveCor.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points=
          {{528,-12},{500,-12},{500,-342},{-240,-342}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveCor.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points=
          {{528,-16},{500,-16},{500,-342},{-240,-342}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conVAVSou.yDam, oveSou.uDam_in) annotation (Line(points={{721,44.8},{
          730,44.8},{730,24},{688,24},{688,-20},{698,-20}}, color={0,0,127}));
  connect(oveSou.yDam, sou.yVAV) annotation (Line(points={{721,-20},{734,-20},{
          734,48},{746,48}}, color={0,0,127}));
  connect(sou.yVal, oveSou.yReaHea) annotation (Line(points={{746,32},{738,32},
          {738,-24},{721,-24}}, color={0,0,127}));
  connect(conVAVSou.yVal, oveSou.uReaHea_in) annotation (Line(points={{721,35},
          {728,35},{728,26},{686,26},{686,-24},{698,-24}}, color={0,0,127}));
  connect(oveSou.TZoneHeaSet_out, conVAVSou.TRooHeaSet) annotation (Line(points=
         {{721,-12},{728,-12},{728,20},{692,20},{692,46},{696,46},{696,47},{698,
          47}}, color={0,0,127}));
  connect(oveSou.TZoneCooSet_out, conVAVSou.TRooCooSet) annotation (Line(points=
         {{721,-16},{730,-16},{730,22},{694,22},{694,40},{698,40}}, color={0,0,
          127}));
  connect(oveSou.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points=
          {{698,-12},{680,-12},{680,-342},{-240,-342}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveSou.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points=
          {{698,-16},{682,-16},{682,-342},{-240,-342}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conVAVEas.yDam, oveEas.uDam_in) annotation (Line(points={{901,44.8},{
          908,44.8},{908,26},{868,26},{868,-20},{878,-20}}, color={0,0,127}));
  connect(oveEas.yDam, eas.yVAV) annotation (Line(points={{901,-20},{914,-20},{
          914,48},{926,48}}, color={0,0,127}));
  connect(conVAVEas.yVal, oveEas.uReaHea_in) annotation (Line(points={{901,35},
          {906,35},{906,28},{866,28},{866,-24},{878,-24}}, color={0,0,127}));
  connect(oveEas.yReaHea, eas.yVal) annotation (Line(points={{901,-24},{916,-24},
          {916,32},{926,32}}, color={0,0,127}));
  connect(oveEas.TZoneHeaSet_out, conVAVEas.TRooHeaSet) annotation (Line(points=
         {{901,-12},{906,-12},{906,24},{870,24},{870,47},{878,47}}, color={0,0,
          127}));
  connect(oveEas.TZoneCooSet_out, conVAVEas.TRooCooSet) annotation (Line(points=
         {{901,-16},{908,-16},{908,22},{872,22},{872,40},{878,40}}, color={0,0,
          127}));
  connect(oveEas.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points=
          {{878,-12},{858,-12},{858,-342},{-240,-342}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveEas.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points=
          {{878,-16},{860,-16},{860,-342},{-240,-342}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conVAVNor.yDam, oveNor.uDam_in) annotation (Line(points={{1061,44.8},
          {1068,44.8},{1068,26},{1030,26},{1030,-20},{1038,-20}}, color={0,0,
          127}));
  connect(oveNor.yDam, nor.yVAV) annotation (Line(points={{1061,-20},{1074,-20},
          {1074,48},{1086,48}}, color={0,0,127}));
  connect(nor.yVal, oveNor.yReaHea) annotation (Line(points={{1086,32},{1076,32},
          {1076,-24},{1061,-24}}, color={0,0,127}));
  connect(conVAVNor.yVal, oveNor.uReaHea_in) annotation (Line(points={{1061,35},
          {1066,35},{1066,28},{1028,28},{1028,-24},{1038,-24}}, color={0,0,127}));
  connect(oveNor.TZoneHeaSet_out, conVAVNor.TRooHeaSet) annotation (Line(points=
         {{1061,-12},{1068,-12},{1068,22},{1032,22},{1032,47},{1038,47}}, color=
         {0,0,127}));
  connect(oveNor.TZoneCooSet_out, conVAVNor.TRooCooSet) annotation (Line(points=
         {{1061,-16},{1070,-16},{1070,24},{1034,24},{1034,40},{1038,40}}, color=
         {0,0,127}));
  connect(oveNor.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points=
          {{1038,-12},{1020,-12},{1020,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveNor.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points=
          {{1038,-16},{1022,-16},{1022,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conVAVWes.yDam, oveWes.uDam_in) annotation (Line(points={{1261,42.8},
          {1268,42.8},{1268,24},{1228,24},{1228,-20},{1238,-20}}, color={0,0,
          127}));
  connect(oveWes.yDam, wes.yVAV) annotation (Line(points={{1261,-20},{1274,-20},
          {1274,48},{1286,48}}, color={0,0,127}));
  connect(oveWes.yReaHea, wes.yVal) annotation (Line(points={{1261,-24},{1276,
          -24},{1276,32},{1286,32}}, color={0,0,127}));
  connect(conVAVWes.yVal, oveWes.uReaHea_in) annotation (Line(points={{1261,33},
          {1266,33},{1266,26},{1226,26},{1226,-24},{1238,-24}}, color={0,0,127}));
  connect(oveWes.TZoneHeaSet_out, conVAVWes.TRooHeaSet) annotation (Line(points=
         {{1261,-12},{1266,-12},{1266,22},{1230,22},{1230,45},{1238,45}}, color=
         {0,0,127}));
  connect(oveWes.TZoneCooSet_out, conVAVWes.TRooCooSet) annotation (Line(points=
         {{1261,-16},{1268,-16},{1268,20},{1232,20},{1232,38},{1238,38}}, color=
         {0,0,127}));
  connect(oveWes.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points=
          {{1238,-12},{1220,-12},{1220,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveWes.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points=
          {{1238,-16},{1222,-16},{1222,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TSup.T, reaAhu.TSup_in) annotation (Line(points={{340,-29},{340,100},
          {180,100},{180,340},{238,340}}, color={0,0,127}));
  connect(TMix.T, reaAhu.TMix_in)
    annotation (Line(points={{40,-29},{40,337},{238,337}}, color={0,0,127}));
  connect(TRet.T, reaAhu.TRet_in)
    annotation (Line(points={{100,151},{100,334},{238,334}}, color={0,0,127}));
  connect(senSupFlo.V_flow, reaAhu.V_flow_sup_in) annotation (Line(points={{410,-29},
          {410,104},{184,104},{184,331},{238,331}},      color={0,0,127}));
  connect(senRetFlo.V_flow, reaAhu.V_flow_ret_in) annotation (Line(points={{350,151},
          {350,160},{188,160},{188,328},{238,328}},      color={0,0,127}));
  connect(VOut1.V_flow, reaAhu.V_flow_out_in) annotation (Line(points={{-61,
          -20.9},{-61,96},{192,96},{192,325},{238,325}}, color={0,0,127}));
  connect(dpDisSupFan.p_rel, reaAhu.dp_in) annotation (Line(points={{311,0},{
          304,0},{304,164},{196,164},{196,322},{238,322}}, color={0,0,127}));
  connect(yOut_actual.y, reaAhu.yOA_in) annotation (Line(points={{161,316},{200,
          316},{200,319},{238,319}}, color={0,0,127}));
  connect(yExh_actual.y, reaAhu.yExh_in) annotation (Line(points={{161,300},{
          204,300},{204,316},{238,316}}, color={0,0,127}));
  connect(yRet_actual.y, reaAhu.yRet_in) annotation (Line(points={{161,284},{
          208,284},{208,313},{238,313}}, color={0,0,127}));
  connect(fanSup.y_actual, reaAhu.yFan_in) annotation (Line(points={{321,-33},{
          336,-33},{336,108},{212,108},{212,310},{238,310}}, color={0,0,127}));
  connect(gaiHeaCoi.u, reaAhu.yHea_in) annotation (Line(points={{98,-210},{80,
          -210},{80,-188},{62,-188},{62,94},{214,94},{214,312},{238,312},{238,
          307}}, color={0,0,127}));
  connect(gaiCooCoi.u, reaAhu.yCoo_in) annotation (Line(points={{98,-248},{80,
          -248},{80,-228},{64,-228},{64,92},{216,92},{216,304},{238,304}},
        color={0,0,127}));
  connect(conFanSup.y, writeAhu.uFan_in) annotation (Line(points={{261,0},{270,
          0},{270,20},{220,20},{220,67.8571},{238,67.8571}}, color={0,0,127}));
  connect(writeAhu.yFan, fanSup.y) annotation (Line(points={{261,67.8571},{280,
          67.8571},{280,-20},{310,-20},{310,-28}}, color={0,0,127}));
  connect(conTSup.yCoo, writeAhu.uCoo_in) annotation (Line(points={{52,-226},{
          148,-226},{148,59.2857},{238,59.2857}}, color={0,0,127}));
  connect(writeAhu.yCoo, gaiCooCoi.u) annotation (Line(points={{261,59.2857},{
          276,59.2857},{276,30},{150,30},{150,-228},{80,-228},{80,-248},{98,
          -248}}, color={0,0,127}));
  connect(gaiHeaCoi.u, writeAhu.yHea) annotation (Line(points={{98,-210},{80,
          -210},{80,-188},{152,-188},{152,28},{278,28},{278,63.5714},{261,
          63.5714}}, color={0,0,127}));
  connect(conTSup.yHea, writeAhu.uHea_in) annotation (Line(points={{52,-214},{
          58,-214},{58,-186},{146,-186},{146,63.5714},{238,63.5714}}, color={0,
          0,127}));
  connect(pSetDuc.y, writeAhu.dpSet_in) annotation (Line(points={{181,-6},{200,
          -6},{200,50.7143},{238,50.7143}}, color={0,0,127}));
  connect(writeAhu.dpSet_out, conFanSup.u) annotation (Line(points={{261,
          50.7143},{266,50.7143},{266,50},{272,50},{272,34},{232,34},{232,0},{
          238,0}}, color={0,0,127}));
  connect(TSupSet.TSet, writeAhu.TSupSet_in) annotation (Line(points={{-178,
          -220},{-172,-220},{-172,55},{238,55}}, color={0,0,127}));
  connect(writeAhu.TSupSet_out, conTSup.TSupSet) annotation (Line(points={{261,
          55},{268,55},{268,56},{274,56},{274,32},{-168,32},{-168,-220},{28,
          -220}}, color={0,0,127}));
  connect(conEco.yOA, writeAhu.uOA_in) annotation (Line(points={{-58.6667,152},
          {0,152},{0,46.4286},{238,46.4286}}, color={0,0,127}));
  connect(writeAhu.yOA, eco.yOut) annotation (Line(points={{261,46.4286},{270,
          46.4286},{270,36},{-10,36},{-10,-34}}, color={0,0,127}));
  connect(eco.yExh, eco.yOut) annotation (Line(points={{-3,-34},{-4,-34},{-4,36},
          {-10,36},{-10,-34}}, color={0,0,127}));
  connect(writeAhu.yRet, eco.yRet) annotation (Line(points={{261,42.1429},{268,
          42.1429},{268,38},{-18,38},{-18,-34},{-16.8,-34}}, color={0,0,127}));
  connect(conEco.yRet, writeAhu.uRet_in) annotation (Line(points={{-58.6667,
          146.667},{-4,146.667},{-4,42.1429},{238,42.1429}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-400},{1440,
            660}})),
    Documentation(info="<html>
<p>
This model consist of an HVAC system, a building envelope model and a model
for air flow through building leakage and through open doors.
</p>
<p>
The HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
The figure below shows the schematic diagram of the HVAC system
</p>
<p>
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavSchematics.png\" border=\"1\"/>
</p>
<p>
See the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop\">
Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop</a>
for a description of the HVAC system and the building envelope.
</p>
<p>
The control is an implementation of the control sequence
<i>VAV 2A2-21232</i> of the Sequences of Operation for
Common HVAC Systems (ASHRAE, 2006). In this control sequence, the
supply fan speed is modulated based on the duct static pressure.
The return fan controller tracks the supply fan air flow rate.
The duct static pressure set point is adjusted so that at least one
VAV damper is 90% open.
The heating coil valve, outside air damper, and cooling coil valve are
modulated in sequence to maintain the supply air temperature set point.
The economizer control provides the following functions:
freeze protection, minimum outside air requirement, and supply air cooling,
see
<a href=\"modelica://Buildings.Examples.VAVReheat.Controls.Economizer\">
Buildings.Examples.VAVReheat.Controls.Economizer</a>.
The controller of the terminal units tracks the room air temperature set point
based on a \"dual maximum with constant volume heating\" logic, see
<a href=\"modelica://Buildings.Examples.VAVReheat.Controls.RoomVAV\">
Buildings.Examples.VAVReheat.Controls.RoomVAV</a>.
</p>
<p>
There is also a finite state machine that transitions the mode of operation
of the HVAC system between the modes
<i>occupied</i>, <i>unoccupied off</i>, <i>unoccupied night set back</i>,
<i>unoccupied warm-up</i> and <i>unoccupied pre-cool</i>.
In the VAV model, all air flows are computed based on the
duct static pressure distribution and the performance curves of the fans.
Local loop control is implemented using proportional and proportional-integral
controllers, while the supervisory control is implemented
using a finite state machine.
</p>
<p>
A similar model but with a different control sequence can be found in
<a href=\"modelica://Buildings.Examples.VAVReheat.Guideline36\">
Buildings.Examples.VAVReheat.Guideline36</a>.
</p>
<h4>References</h4>
<p>
ASHRAE.
<i>Sequences of Operation for Common HVAC Systems</i>.
ASHRAE, Atlanta, GA, 2006.
</p>
</html>", revisions="<html>
<ul>
<li>
October 27, 2020, by Antoine Gautier:<br/>
Refactored the supply air temperature control sequence.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2024\">#2024</a>.
</li>
<li>
July 10, 2020, by Antoine Gautier:<br/>
Changed design and control parameters for outdoor air flow.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2019\">#2019</a>.
</li>
<li>
April 20, 2020, by Jianjun Hu:<br/>
Exported actual VAV damper position as the measured input data for
defining duct static pressure setpoint.<br/>
This is
for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1873\">#1873</a>.
</li>
<li>
May 19, 2016, by Michael Wetter:<br/>
Changed chilled water supply temperature to <i>6&deg;C</i>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/509\">#509</a>.
</li>
<li>
April 26, 2016, by Michael Wetter:<br/>
Changed controller for freeze protection as the old implementation closed
the outdoor air damper during summer.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/511\">#511</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Set default temperature for medium to avoid conflicting
start values for alias variables of the temperature
of the building and the ambient air.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/ASHRAE2006.mos"
        "Simulate and plot"),
    experiment(
      StopTime=172800,
      Tolerance=1e-06),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end ASHRAE2006;
