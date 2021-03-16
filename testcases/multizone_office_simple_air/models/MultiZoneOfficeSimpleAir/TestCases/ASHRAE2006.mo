within MultiZoneOfficeSimpleAir.TestCases;
model ASHRAE2006
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.DimensionlessRatio cop_coo=3.2 "Cooling coefficient of performance";
  parameter Modelica.SIunits.DimensionlessRatio cop_hea=4.0 "Heating coefficient of performance";
  extends MultiZoneOfficeSimpleAir.BaseClasses.PartialOpenLoop(
    heaCoi(show_T=true),
    cooCoi(show_T=true),
    CO2Cor(C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
          /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM),
    CO2Sou(C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
          /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM),
    CO2Eas(C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
          /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM),
    CO2Nor(C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
          /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM),
    CO2Wes(C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
          /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM));

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
    annotation (Placement(transformation(extent={{240,300},{260,348}})));
  BaseClasses.WriteAhu oveAhu "Overwrite blocks for AHU"
    annotation (Placement(transformation(extent={{240,40},{260,70}})));
  Modelica.Blocks.Sources.RealExpression PHeaCor(y=cor.terHea.Q1_flow/eff_gas)
    "Gas power for reheat"
    annotation (Placement(transformation(extent={{480,70},{500,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaSou(y=sou.terHea.Q1_flow/eff_gas)
    "Gas power for reheat"
    annotation (Placement(transformation(extent={{650,70},{670,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaEas(y=eas.terHea.Q1_flow/eff_gas)
    "Gas power for reheat"
    annotation (Placement(transformation(extent={{840,70},{860,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaNor(y=nor.terHea.Q1_flow/eff_gas)
    "Gas power for reheat"
    annotation (Placement(transformation(extent={{1004,70},{1024,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaWes(y=wes.terHea.Q1_flow/eff_gas)
    "Gas power for reheat"
    annotation (Placement(transformation(extent={{1180,70},{1200,90}})));
  Modelica.Blocks.Sources.RealExpression PHea(y=-heaCoi.Q1_flow/cop_hea)
    "Gas power for heating coil"
    annotation (Placement(transformation(extent={{140,286},{160,306}})));
  Modelica.Blocks.Sources.RealExpression PCoo(y=cooCoi.Q1_flow/cop_coo)
    "Electrical power for cooling coil"
    annotation (Placement(transformation(extent={{140,300},{160,320}})));
  IBPSA.Utilities.IO.SignalExchange.WeatherStation weaSta
    annotation (Placement(transformation(extent={{240,360},{260,380}})));
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
          520,35},{520,98.5714},{538,98.5714}},
                                      color={0,0,127}));
  connect(cor.yVal, reaCor.yReaHea_in) annotation (Line(points={{566,34},{560,
          34},{560,70},{524,70},{524,92.8571},{538,92.8571}},
                                                    color={0,0,127}));
  connect(conVAVSou.TRoo, reaSou.TZon_in) annotation (Line(points={{699,33},{
          680,33},{680,98.5714},{698,98.5714}},
                                      color={0,0,127}));
  connect(sou.yVal, reaSou.yReaHea_in) annotation (Line(points={{746,32},{738,
          32},{738,70},{686,70},{686,92.8571},{698,92.8571}},
                                                    color={0,0,127}));
  connect(reaEas.TZon_in, conVAVEas.TRoo) annotation (Line(points={{888,98.5714},
          {868,98.5714},{868,33},{879,33}},
                                      color={0,0,127}));
  connect(TSupCor.T, reaCor.TSup_in) annotation (Line(points={{569,92},{564,92},
          {564,76},{526,76},{526,90},{538,90}}, color={0,0,127}));
  connect(VSupCor_flow.V_flow, reaCor.V_flow_in) annotation (Line(points={{569,130},
          {530,130},{530,87.1429},{538,87.1429}},
                                             color={0,0,127}));
  connect(TSupSou.T, reaSou.TSup_in) annotation (Line(points={{749,92},{740,92},
          {740,76},{686,76},{686,90},{698,90}}, color={0,0,127}));
  connect(VSupSou_flow.V_flow, reaSou.V_flow_in) annotation (Line(points={{749,130},
          {688,130},{688,87.1429},{698,87.1429}},
                                             color={0,0,127}));
  connect(TSupEas.T, reaEas.TSup_in) annotation (Line(points={{929,90},{920,90},
          {920,76},{874,76},{874,90},{888,90}}, color={0,0,127}));
  connect(eas.yVal, reaEas.yReaHea_in) annotation (Line(points={{926,32},{916,
          32},{916,70},{872,70},{872,92.8571},{888,92.8571}},
                                                    color={0,0,127}));
  connect(VSupEas_flow.V_flow, reaEas.V_flow_in) annotation (Line(points={{929,128},
          {876,128},{876,87.1429},{888,87.1429}},
                                             color={0,0,127}));
  connect(reaNor.TZon_in, conVAVNor.TRoo) annotation (Line(points={{1048,
          98.5714},{1028,98.5714},{1028,33},{1039,33}},
                                         color={0,0,127}));
  connect(nor.yVal, reaNor.yReaHea_in) annotation (Line(points={{1086,32},{1076,
          32},{1076,70},{1032,70},{1032,92.8571},{1048,92.8571}},
                                                        color={0,0,127}));
  connect(TSupNor.T, reaNor.TSup_in) annotation (Line(points={{1089,94},{1080,94},
          {1080,76},{1034,76},{1034,90},{1048,90}},     color={0,0,127}));
  connect(VSupNor_flow.V_flow, reaNor.V_flow_in) annotation (Line(points={{1089,
          132},{1036,132},{1036,87.1429},{1048,87.1429}},
                                                color={0,0,127}));
  connect(reaWes.TZon_in, conVAVWes.TRoo) annotation (Line(points={{1238,
          98.5714},{1220,98.5714},{1220,31},{1239,31}},
                                         color={0,0,127}));
  connect(wes.yVal, reaWes.yReaHea_in) annotation (Line(points={{1286,32},{1276,
          32},{1276,72},{1224,72},{1224,92.8571},{1238,92.8571}},
                                                        color={0,0,127}));
  connect(TSupWes.T, reaWes.TSup_in) annotation (Line(points={{1289,90},{1280,90},
          {1280,76},{1226,76},{1226,90},{1238,90}},     color={0,0,127}));
  connect(VSupWes_flow.V_flow, reaWes.V_flow_in) annotation (Line(points={{1289,
          128},{1228,128},{1228,87.1429},{1238,87.1429}},
                                                color={0,0,127}));
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
  connect(TSup.T, reaAhu.TSup_in) annotation (Line(points={{340,-29},{340,100},{
          180,100},{180,348},{238,348}},  color={0,0,127}));
  connect(TMix.T, reaAhu.TMix_in)
    annotation (Line(points={{40,-29},{40,345},{238,345}}, color={0,0,127}));
  connect(TRet.T, reaAhu.TRet_in)
    annotation (Line(points={{100,151},{100,342},{238,342}}, color={0,0,127}));
  connect(senSupFlo.V_flow, reaAhu.V_flow_sup_in) annotation (Line(points={{410,-29},
          {410,104},{184,104},{184,339},{238,339}},      color={0,0,127}));
  connect(senRetFlo.V_flow, reaAhu.V_flow_ret_in) annotation (Line(points={{350,151},
          {350,160},{188,160},{188,336},{238,336}},      color={0,0,127}));
  connect(VOut1.V_flow, reaAhu.V_flow_out_in) annotation (Line(points={{-61,-20.9},
          {-61,96},{192,96},{192,333},{238,333}},        color={0,0,127}));
  connect(dpDisSupFan.p_rel, reaAhu.dp_in) annotation (Line(points={{311,0},{304,
          0},{304,164},{196,164},{196,330},{238,330}},     color={0,0,127}));
  connect(gaiHeaCoi.u, reaAhu.yHea_in) annotation (Line(points={{98,-210},{80,-210},
          {80,-188},{62,-188},{62,94},{214,94},{214,316},{238,316},{238,315}},
                 color={0,0,127}));
  connect(gaiCooCoi.u, reaAhu.yCoo_in) annotation (Line(points={{98,-248},{80,-248},
          {80,-228},{64,-228},{64,92},{216,92},{216,312},{238,312}},
        color={0,0,127}));
  connect(conFanSup.y, oveAhu.uFan_in) annotation (Line(points={{261,0},{270,0},
          {270,20},{220,20},{220,67.8571},{238,67.8571}}, color={0,0,127}));
  connect(conTSup.yCoo, oveAhu.uCoo_in) annotation (Line(points={{52,-226},{148,
          -226},{148,59.2857},{238,59.2857}}, color={0,0,127}));
  connect(oveAhu.yCoo, gaiCooCoi.u) annotation (Line(points={{261,59.2857},{276,
          59.2857},{276,30},{150,30},{150,-228},{80,-228},{80,-248},{98,-248}},
        color={0,0,127}));
  connect(gaiHeaCoi.u, oveAhu.yHea) annotation (Line(points={{98,-210},{80,-210},
          {80,-188},{152,-188},{152,28},{278,28},{278,63.5714},{261,63.5714}},
        color={0,0,127}));
  connect(conTSup.yHea, oveAhu.uHea_in) annotation (Line(points={{52,-214},{58,
          -214},{58,-186},{146,-186},{146,63.5714},{238,63.5714}},
                                                             color={0,0,127}));
  connect(pSetDuc.y, oveAhu.dpSet_in) annotation (Line(points={{181,-6},{200,-6},
          {200,50.7143},{238,50.7143}}, color={0,0,127}));
  connect(oveAhu.dpSet_out, conFanSup.u) annotation (Line(points={{261,50.7143},
          {266,50.7143},{266,50},{272,50},{272,34},{232,34},{232,0},{238,0}},
        color={0,0,127}));
  connect(TSupSet.TSet, oveAhu.TSupSet_in) annotation (Line(points={{-178,-220},
          {-172,-220},{-172,55},{238,55}}, color={0,0,127}));
  connect(oveAhu.TSupSet_out, conTSup.TSupSet) annotation (Line(points={{261,55},
          {268,55},{268,56},{274,56},{274,32},{-168,32},{-168,-220},{28,-220}},
        color={0,0,127}));
  connect(conEco.yOA, oveAhu.uOA_in) annotation (Line(points={{-58.6667,152},{0,
          152},{0,46.4286},{238,46.4286}}, color={0,0,127}));
  connect(oveAhu.yOA, eco.yOut) annotation (Line(points={{261,46.4286},{270,
          46.4286},{270,36},{-10,36},{-10,-34}},
                                        color={0,0,127}));
  connect(eco.yExh, eco.yOut) annotation (Line(points={{-3,-34},{-4,-34},{-4,36},
          {-10,36},{-10,-34}}, color={0,0,127}));
  connect(oveAhu.yRet, eco.yRet) annotation (Line(points={{261,42.1429},{268,
          42.1429},{268,38},{-18,38},{-18,-34},{-16.8,-34}},
                                                    color={0,0,127}));
  connect(conEco.yRet, oveAhu.uRet_in) annotation (Line(points={{-58.6667,
          146.667},{-4,146.667},{-4,42.1429},{238,42.1429}},
                                                    color={0,0,127}));
  connect(fanSup.y, reaAhu.yFan_in) annotation (Line(points={{310,-28},{280,-28},
          {280,168},{212,168},{212,318},{238,318}}, color={0,0,127}));
  connect(eco.yRet, reaAhu.yRet_in) annotation (Line(points={{-16.8,-34},{-16.8,
          321},{238,321}}, color={0,0,127}));
  connect(eco.yOut, reaAhu.yOA_in)
    annotation (Line(points={{-10,-34},{-10,327},{238,327}}, color={0,0,127}));
  connect(eco.yExh, reaAhu.yExh_in)
    annotation (Line(points={{-3,-34},{-3,324},{238,324}}, color={0,0,127}));
  connect(reaCor.yDamAct_in, cor.yVAV) annotation (Line(points={{538,95.7143},{
          522,95.7143},{522,72},{558,72},{558,50},{566,50}},
                                                    color={0,0,127}));
  connect(reaSou.yDamAct_in, sou.yVAV) annotation (Line(points={{698,95.7143},{
          684,95.7143},{684,72},{734,72},{734,48},{746,48}},
                                                    color={0,0,127}));
  connect(reaEas.yDamAct_in, eas.yVAV) annotation (Line(points={{888,95.7143},{
          870,95.7143},{870,72},{914,72},{914,48},{926,48}},
                                                    color={0,0,127}));
  connect(reaNor.yDamAct_in, nor.yVAV) annotation (Line(points={{1048,95.7143},
          {1030,95.7143},{1030,72},{1074,72},{1074,48},{1086,48}},
                                                        color={0,0,127}));
  connect(reaWes.yDamAct_in, wes.yVAV) annotation (Line(points={{1238,95.7143},
          {1222,95.7143},{1222,78},{1274,78},{1274,48},{1286,48}},
                                                        color={0,0,127}));
  connect(PHeaCor.y, reaCor.PHea_in)
    annotation (Line(points={{501,80},{520,80},{520,84.2857},{538,84.2857}},
                                                 color={0,0,127}));
  connect(PHeaSou.y, reaSou.PHea_in)
    annotation (Line(points={{671,80},{684,80},{684,84.2857},{698,84.2857}},
                                                 color={0,0,127}));
  connect(PHeaEas.y, reaEas.PHea_in)
    annotation (Line(points={{861,80},{874,80},{874,84.2857},{888,84.2857}},
                                                 color={0,0,127}));
  connect(PHeaNor.y, reaNor.PHea_in)
    annotation (Line(points={{1025,80},{1036,80},{1036,84.2857},{1048,84.2857}},
                                                   color={0,0,127}));
  connect(PHeaWes.y, reaWes.PHea_in)
    annotation (Line(points={{1201,80},{1220,80},{1220,84.2857},{1238,84.2857}},
                                                   color={0,0,127}));
  connect(PHea.y, reaAhu.PHea_in) annotation (Line(points={{161,296},{200,296},{
          200,303},{238,303}}, color={0,0,127}));
  connect(PCoo.y, reaAhu.PCoo_in) annotation (Line(points={{161,310},{200,310},{
          200,306},{238,306}}, color={0,0,127}));
  connect(fanSup.P, reaAhu.PFanSup_in) annotation (Line(points={{321,-31},{338,
          -31},{338,98},{220,98},{220,309},{238,309}}, color={0,0,127}));
  connect(weaSta.weaBus, flo.weaBus) annotation (Line(
      points={{240.1,369.9},{-20,369.9},{-266,369.9},{-320,369.9},{-320,632.923},
          {978.783,632.923}},
      color={255,204,51},
      thickness=0.5));
  connect(oveAhu.yFan, fanSup.y) annotation (Line(points={{261,67.8571},{284,
          67.8571},{284,-20},{310,-20},{310,-28}}, color={0,0,127}));
  connect(CO2Cor.C, reaCor.C_In) annotation (Line(points={{649,130},{600,130},{
          600,78},{530,78},{530,81.4286},{538,81.4286}}, color={0,0,127}));
  connect(CO2Sou.C, reaSou.C_In) annotation (Line(points={{829,130},{780,130},{
          780,78},{692,78},{692,81.4286},{698,81.4286}}, color={0,0,127}));
  connect(CO2Eas.C, reaEas.C_In) annotation (Line(points={{1009,130},{960,130},
          {960,78},{880,78},{880,81.4286},{888,81.4286}}, color={0,0,127}));
  connect(CO2Nor.C, reaNor.C_In) annotation (Line(points={{1169,130},{1120,130},
          {1120,78},{1040,78},{1040,81.4286},{1048,81.4286}}, color={0,0,127}));
  connect(CO2Wes.C, reaWes.C_In) annotation (Line(points={{1349,130},{1320,130},
          {1320,80},{1230,80},{1230,81.4286},{1238,81.4286}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-400},{1440,
            660}})),
    Documentation(info="<html>
<p>
This is the multi zone office air simple emulator model
of BOPTEST.
<p>
…
</p>
<h4>Constructions</h4>
<p>
…
</p>
<h4>Occupancy schedules</h4>
<p>
…
</p>
<h4>Internal loads and schedules</h4>
<p>
…

</p>
<h4>Climate data</h4>
<p>
…
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
…
</p>
<h4>Equipment specifications and performance maps</h4>
<p>
…
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
…
</p>
<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>Input1</code> [UNIT1]: Description
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>Output1</code> [UNIT1]: Description
</li>
<li>
<code>Output2</code> [UNIT2]: Description
</li>
</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
…
</p>
<h4>Shading</h4>
<p>
…
</p>
<h4>Onsite Generation and Storage</h4>
<p>
…
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
…
</p>
<h4>Pressure-flow models</h4>
<p>
…
</p>
<h4>Infiltration models</h4>
<p>
…
</p>
<h4>CO2 models</h4>
<p>
…
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
March 2, 2021 by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StopTime=31536000,
      Interval=600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end ASHRAE2006;
