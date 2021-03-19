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
    annotation (Placement(transformation(extent={{500,-120},{520,-100}})));
  BaseClasses.WriteZone oveSou(zone="South") "Overwrite blocks for South zone"
    annotation (Placement(transformation(extent={{680,-120},{700,-100}})));
  BaseClasses.WriteZone oveEas(zone="East") "Overwrite blocks for East zone"
    annotation (Placement(transformation(extent={{860,-120},{880,-100}})));
  BaseClasses.WriteZone oveNor(zone="North") "Overwrite blocks for North zone"
    annotation (Placement(transformation(extent={{1020,-120},{1040,-100}})));
  BaseClasses.WriteZone oveWes(zone="West") "Overwrite blocks for West zone"
    annotation (Placement(transformation(extent={{1220,-120},{1240,-100}})));
  BaseClasses.ReadAhu reaAhu "Read blocks for AHU"
    annotation (Placement(transformation(extent={{240,300},{260,348}})));
  BaseClasses.WriteAhu oveAhu "Overwrite blocks for AHU"
    annotation (Placement(transformation(extent={{240,40},{260,70}})));
  Modelica.Blocks.Sources.RealExpression PHeaCor(y=-cor.terHea.Q1_flow/cop_hea)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{480,70},{500,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaSou(y=-sou.terHea.Q1_flow/cop_hea)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{650,70},{670,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaEas(y=-eas.terHea.Q1_flow/cop_hea)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{840,70},{860,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaNor(y=-nor.terHea.Q1_flow/cop_hea)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{1004,70},{1024,90}})));
  Modelica.Blocks.Sources.RealExpression PHeaWes(y=-wes.terHea.Q1_flow/cop_hea)
    "Electrical power for reheat"
    annotation (Placement(transformation(extent={{1180,70},{1200,90}})));
  Modelica.Blocks.Sources.RealExpression PHea(y=-heaCoi.Q1_flow/cop_hea)
    "Electrical power for heating coil"
    annotation (Placement(transformation(extent={{140,286},{160,306}})));
  Modelica.Blocks.Sources.RealExpression PCoo(y=cooCoi.Q1_flow/cop_coo)
    "Electrical power for cooling coil"
    annotation (Placement(transformation(extent={{140,300},{160,320}})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta
    annotation (Placement(transformation(extent={{240,360},{260,380}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV
                   conVAVCor(ratVFloMin=ratVMinCor_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit corridor"
    annotation (Placement(transformation(extent={{500,-80},{520,-60}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVSou(ratVFloMin=
        ratVMinSou_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit south"
    annotation (Placement(transformation(extent={{680,-80},{700,-60}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVEas(ratVFloMin=
        ratVMinEas_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit east"
    annotation (Placement(transformation(extent={{860,-80},{880,-60}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVNor(ratVFloMin=
        ratVMinNor_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit north"
    annotation (Placement(transformation(extent={{1020,-80},{1040,-60}})));
  Buildings.Examples.VAVReheat.Controls.RoomVAV conVAVWes(ratVFloMin=
        ratVMinWes_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit west"
    annotation (Placement(transformation(extent={{1220,-80},{1240,-60}})));
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
  connect(cor.y_actual, pSetDuc.u[1]) annotation (Line(points={{602,40},{620,40},
          {620,74},{140,74},{140,-7.6},{158,-7.6}}, color={0,0,127}));
  connect(sou.y_actual, pSetDuc.u[2]) annotation (Line(points={{782,40},{800,40},
          {800,74},{140,74},{140,-6.8},{158,-6.8}}, color={0,0,127}));
  connect(eas.y_actual, pSetDuc.u[3]) annotation (Line(points={{962,40},{980,40},
          {980,74},{140,74},{140,-6},{158,-6}}, color={0,0,127}));
  connect(nor.y_actual, pSetDuc.u[4]) annotation (Line(points={{1122,40},{1140,40},
          {1140,74},{140,74},{140,-5.2},{158,-5.2}},     color={0,0,127}));
  connect(wes.y_actual, pSetDuc.u[5]) annotation (Line(points={{1322,40},{1338,40},
          {1338,74},{140,74},{140,-4.4},{158,-4.4}},     color={0,0,127}));
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
          {920,76},{872,76},{872,90},{888,90}}, color={0,0,127}));
  connect(VSupEas_flow.V_flow, reaEas.V_flow_in) annotation (Line(points={{929,128},
          {876,128},{876,87.1429},{888,87.1429}},
                                             color={0,0,127}));
  connect(TSupNor.T, reaNor.TSup_in) annotation (Line(points={{1089,94},{1080,94},
          {1080,76},{1034,76},{1034,90},{1048,90}},     color={0,0,127}));
  connect(VSupNor_flow.V_flow, reaNor.V_flow_in) annotation (Line(points={{1089,
          132},{1036,132},{1036,87.1429},{1048,87.1429}},
                                                color={0,0,127}));
  connect(TSupWes.T, reaWes.TSup_in) annotation (Line(points={{1289,90},{1280,90},
          {1280,76},{1226,76},{1226,90},{1238,90}},     color={0,0,127}));
  connect(VSupWes_flow.V_flow, reaWes.V_flow_in) annotation (Line(points={{1289,
          128},{1230,128},{1230,87.1429},{1238,87.1429}},
                                                color={0,0,127}));
  connect(oveCor.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{498,
          -102},{480,-102},{480,-342},{-240,-342}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveCor.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{498,
          -106},{482,-106},{482,-342},{-240,-342}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveSou.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{678,
          -102},{660,-102},{660,-342},{-240,-342}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveSou.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{678,
          -106},{662,-106},{662,-342},{-240,-342}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveEas.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{858,
          -102},{838,-102},{838,-342},{-240,-342}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveEas.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{858,
          -106},{840,-106},{840,-342},{-240,-342}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveNor.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{1018,
          -102},{1010,-102},{1010,-342},{-240,-342}},      color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveNor.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{1018,
          -106},{1012,-106},{1012,-342},{-240,-342}},      color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveWes.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(points={{1218,
          -102},{1210,-102},{1210,-342},{-240,-342}},      color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveWes.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(points={{1218,
          -106},{1212,-106},{1212,-342},{-240,-342}},      color={0,0,127}),
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
  connect(conFanSup.y,oveAhu.yFan_in)  annotation (Line(points={{261,0},{270,0},
          {270,20},{220,20},{220,67.8571},{238,67.8571}}, color={0,0,127}));
  connect(conTSup.yCoo,oveAhu.yCoo_in)  annotation (Line(points={{52,-226},{148,
          -226},{148,59.2857},{238,59.2857}}, color={0,0,127}));
  connect(oveAhu.yCoo_out, gaiCooCoi.u) annotation (Line(points={{261,59.2857},
          {276,59.2857},{276,30},{150,30},{150,-228},{80,-228},{80,-248},{98,
          -248}},
        color={0,0,127}));
  connect(gaiHeaCoi.u, oveAhu.yHea_out) annotation (Line(points={{98,-210},{80,
          -210},{80,-188},{152,-188},{152,28},{278,28},{278,63.5714},{261,
          63.5714}},
        color={0,0,127}));
  connect(conTSup.yHea,oveAhu.yHea_in)  annotation (Line(points={{52,-214},{58,
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
  connect(conEco.yOA,oveAhu.yOA_in)  annotation (Line(points={{-58.6667,152},{0,
          152},{0,46.4286},{238,46.4286}}, color={0,0,127}));
  connect(oveAhu.yOA_out, eco.yOut) annotation (Line(points={{261,46.4286},{270,
          46.4286},{270,36},{-10,36},{-10,-34}}, color={0,0,127}));
  connect(eco.yExh, eco.yOut) annotation (Line(points={{-3,-34},{-4,-34},{-4,36},
          {-10,36},{-10,-34}}, color={0,0,127}));
  connect(oveAhu.yRet_out, eco.yRet) annotation (Line(points={{261,42.1429},{
          268,42.1429},{268,38},{-18,38},{-18,-34},{-16.8,-34}},
                                                             color={0,0,127}));
  connect(conEco.yRet,oveAhu.yRet_in)  annotation (Line(points={{-58.6667,
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
  connect(oveAhu.yFan_out, fanSup.y) annotation (Line(points={{261,67.8571},{
          284,67.8571},{284,-20},{310,-20},{310,-28}},
                                                   color={0,0,127}));
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
  connect(oveCor.TZoneHeaSet_out, conVAVCor.TRooHeaSet) annotation (Line(points=
         {{521,-102},{524,-102},{524,-94},{496,-94},{496,-63},{498,-63}}, color=
         {0,0,127}));
  connect(oveCor.TZoneCooSet_out, conVAVCor.TRooCooSet) annotation (Line(points=
         {{521,-106},{526,-106},{526,-92},{494,-92},{494,-70},{498,-70}}, color=
         {0,0,127}));
  connect(TRooAir.y5[1], conVAVCor.TRoo) annotation (Line(points={{511,162},{520,
          162},{520,100},{470,100},{470,-77},{499,-77}}, color={0,0,127}));
  connect(conVAVCor.yDam, oveCor.yDam_in) annotation (Line(points={{521,-65.2},{
          526,-65.2},{526,-88},{490,-88},{490,-110},{498,-110}}, color={0,0,127}));
  connect(oveCor.yDam_out, cor.yVAV) annotation (Line(points={{521,-110},{544,-110},
          {544,52},{556,52}}, color={0,0,127}));
  connect(oveCor.yReaHea_out, gaiHeaCoiCor.u) annotation (Line(points={{521,-114},
          {542,-114},{542,20},{480,20},{480,48},{482,48}}, color={0,0,127}));
  connect(TRooAir.y1[1], conVAVSou.TRoo) annotation (Line(points={{511,178},{626,
          178},{626,-77},{679,-77}}, color={0,0,127}));
  connect(TRooAir.y2[1], conVAVEas.TRoo) annotation (Line(points={{511,174},{808,
          174},{808,-77},{859,-77}}, color={0,0,127}));
  connect(TRooAir.y3[1], conVAVNor.TRoo) annotation (Line(points={{511,170},{986,
          170},{986,-77},{1019,-77}}, color={0,0,127}));
  connect(TRooAir.y4[1], conVAVWes.TRoo) annotation (Line(points={{511,166},{1166,
          166},{1166,-77},{1219,-77}}, color={0,0,127}));
  connect(oveSou.TZoneHeaSet_out, conVAVSou.TRooHeaSet) annotation (Line(points=
         {{701,-102},{704,-102},{704,-92},{676,-92},{676,-63},{678,-63}}, color=
         {0,0,127}));
  connect(oveSou.TZoneCooSet_out, conVAVSou.TRooCooSet) annotation (Line(points=
         {{701,-106},{706,-106},{706,-90},{674,-90},{674,-70},{678,-70}}, color=
         {0,0,127}));
  connect(oveEas.TZoneHeaSet_out, conVAVEas.TRooHeaSet) annotation (Line(points=
         {{881,-102},{884,-102},{884,-92},{856,-92},{856,-63},{858,-63}}, color=
         {0,0,127}));
  connect(oveEas.TZoneCooSet_out, conVAVEas.TRooCooSet) annotation (Line(points=
         {{881,-106},{886,-106},{886,-90},{854,-90},{854,-70},{858,-70}}, color=
         {0,0,127}));
  connect(oveNor.TZoneHeaSet_out, conVAVNor.TRooHeaSet) annotation (Line(points=
         {{1041,-102},{1046,-102},{1046,-92},{1016,-92},{1016,-63},{1018,-63}},
        color={0,0,127}));
  connect(oveNor.TZoneCooSet_out, conVAVNor.TRooCooSet) annotation (Line(points=
         {{1041,-106},{1048,-106},{1048,-90},{1014,-90},{1014,-70},{1018,-70}},
        color={0,0,127}));
  connect(oveWes.TZoneHeaSet_out, conVAVWes.TRooHeaSet) annotation (Line(points=
         {{1241,-102},{1246,-102},{1246,-92},{1216,-92},{1216,-63},{1218,-63}},
        color={0,0,127}));
  connect(oveWes.TZoneCooSet_out, conVAVWes.TRooCooSet) annotation (Line(points=
         {{1241,-106},{1248,-106},{1248,-90},{1214,-90},{1214,-70},{1218,-70}},
        color={0,0,127}));
  connect(conVAVSou.yDam, oveSou.yDam_in) annotation (Line(points={{701,-65.2},{
          706,-65.2},{706,-86},{670,-86},{670,-110},{678,-110}}, color={0,0,127}));
  connect(oveSou.yDam_out, sou.yVAV) annotation (Line(points={{701,-110},{730,-110},
          {730,52},{736,52}}, color={0,0,127}));
  connect(oveSou.yReaHea_out, gaiHeaCoiSou.u) annotation (Line(points={{701,-114},
          {728,-114},{728,20},{660,20},{660,48},{666,48}}, color={0,0,127}));
  connect(oveEas.yDam_out, eas.yVAV) annotation (Line(points={{881,-110},{906,-110},
          {906,52},{916,52}}, color={0,0,127}));
  connect(oveEas.yReaHea_out, gaiHeaCoiEas.u) annotation (Line(points={{881,-114},
          {904,-114},{904,20},{840,20},{840,48},{848,48}}, color={0,0,127}));
  connect(oveNor.yDam_out, nor.yVAV) annotation (Line(points={{1041,-110},{1068,
          -110},{1068,52},{1076,52}}, color={0,0,127}));
  connect(oveNor.yReaHea_out, gaiHeaCoiNor.u) annotation (Line(points={{1041,-114},
          {1066,-114},{1066,20},{1004,20},{1004,48},{1006,48}}, color={0,0,127}));
  connect(oveWes.yDam_out, wes.yVAV) annotation (Line(points={{1241,-110},{1260,
          -110},{1260,52},{1276,52}}, color={0,0,127}));
  connect(oveWes.yReaHea_out, gaiHeaCoiWes.u) annotation (Line(points={{1241,-114},
          {1258,-114},{1258,20},{1190,20},{1190,48},{1196,48}}, color={0,0,127}));
  connect(conVAVWes.yDam, oveWes.yDam_in) annotation (Line(points={{1241,-65.2},
          {1248,-65.2},{1248,-86},{1206,-86},{1206,-110},{1218,-110}}, color={0,
          0,127}));
  connect(conVAVWes.yVal, oveWes.yReaHea_in) annotation (Line(points={{1241,-75},
          {1246,-75},{1246,-84},{1204,-84},{1204,-114},{1218,-114}}, color={0,0,
          127}));
  connect(conVAVNor.yDam, oveNor.yDam_in) annotation (Line(points={{1041,-65.2},
          {1048,-65.2},{1048,-86},{1006,-86},{1006,-110},{1018,-110}}, color={0,
          0,127}));
  connect(conVAVNor.yVal, oveNor.yReaHea_in) annotation (Line(points={{1041,-75},
          {1046,-75},{1046,-84},{1004,-84},{1004,-114},{1018,-114}}, color={0,0,
          127}));
  connect(conVAVEas.yDam, oveEas.yDam_in) annotation (Line(points={{881,-65.2},{
          886,-65.2},{886,-86},{850,-86},{850,-110},{858,-110}}, color={0,0,127}));
  connect(conVAVEas.yVal, oveEas.yReaHea_in) annotation (Line(points={{881,-75},
          {884,-75},{884,-84},{848,-84},{848,-114},{858,-114}}, color={0,0,127}));
  connect(conVAVSou.yVal, oveSou.yReaHea_in) annotation (Line(points={{701,-75},
          {704,-75},{704,-84},{668,-84},{668,-114},{678,-114}}, color={0,0,127}));
  connect(conVAVCor.yVal, oveCor.yReaHea_in) annotation (Line(points={{521,-75},
          {524,-75},{524,-86},{488,-86},{488,-114},{498,-114}}, color={0,0,127}));
  connect(reaCor.TZon_in, conVAVCor.TRoo) annotation (Line(points={{538,98.5714},
          {520,98.5714},{520,100},{470,100},{470,-77},{499,-77}}, color={0,0,127}));
  connect(reaSou.TZon_in, conVAVSou.TRoo) annotation (Line(points={{698,98.5714},
          {626,98.5714},{626,-77},{679,-77}}, color={0,0,127}));
  connect(reaEas.TZon_in, conVAVEas.TRoo) annotation (Line(points={{888,98.5714},
          {848,98.5714},{848,98},{808,98},{808,-77},{859,-77}}, color={0,0,127}));
  connect(reaNor.TZon_in, conVAVNor.TRoo) annotation (Line(points={{1048,
          98.5714},{1018,98.5714},{1018,98},{986,98},{986,-77},{1019,-77}},
                                                                   color={0,0,127}));
  connect(reaWes.TZon_in, conVAVWes.TRoo) annotation (Line(points={{1238,
          98.5714},{1202,98.5714},{1202,98},{1166,98},{1166,-77},{1219,-77}},
                                                                     color={0,0,
          127}));
  connect(reaWes.yDamAct_in, wes.yVAV) annotation (Line(points={{1238,95.7143},
          {1234,95.7143},{1234,96},{1224,96},{1224,72},{1260,72},{1260,52},{
          1276,52}},
                color={0,0,127}));
  connect(reaWes.yReaHea_in, gaiHeaCoiWes.u) annotation (Line(points={{1238,
          92.8571},{1228,92.8571},{1228,92},{1222,92},{1222,72},{1190,72},{1190,
          48},{1196,48}},
                color={0,0,127}));
  connect(reaNor.yDamAct_in, nor.yVAV) annotation (Line(points={{1048,95.7143},
          {1032,95.7143},{1032,72},{1068,72},{1068,52},{1076,52}},color={0,0,127}));
  connect(reaNor.yReaHea_in, gaiHeaCoiNor.u) annotation (Line(points={{1048,
          92.8571},{1038,92.8571},{1038,92},{1030,92},{1030,72},{1004,72},{1004,
          48},{1006,48}},
                color={0,0,127}));
  connect(reaEas.yDamAct_in, eas.yVAV) annotation (Line(points={{888,95.7143},{
          882,95.7143},{882,96},{870,96},{870,72},{906,72},{906,52},{916,52}},
        color={0,0,127}));
  connect(reaEas.yReaHea_in, gaiHeaCoiEas.u) annotation (Line(points={{888,
          92.8571},{878,92.8571},{878,92},{868,92},{868,72},{840,72},{840,48},{
          848,48}},
        color={0,0,127}));
  connect(reaSou.yDamAct_in, sou.yVAV) annotation (Line(points={{698,95.7143},{
          690,95.7143},{690,96},{682,96},{682,72},{730,72},{730,52},{736,52}},
        color={0,0,127}));
  connect(reaSou.yReaHea_in, gaiHeaCoiSou.u) annotation (Line(points={{698,
          92.8571},{688,92.8571},{688,92},{680,92},{680,72},{660,72},{660,48},{
          666,48}},
        color={0,0,127}));
  connect(reaCor.yDamAct_in, cor.yVAV) annotation (Line(points={{538,95.7143},{
          532,95.7143},{532,94},{524,94},{524,72},{544,72},{544,52},{556,52}},
        color={0,0,127}));
  connect(reaCor.yReaHea_in, gaiHeaCoiCor.u) annotation (Line(points={{538,
          92.8571},{532,92.8571},{532,92},{522,92},{522,72},{480,72},{480,48},{
          482,48}},
        color={0,0,127}));
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
North and South: 207.58 m^2
</li>
<li>
East and West: 131.416 m^2
</li>
<li>
Core: 984.672 m^2
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
The design occupancy density is 0.05 people/m^2.  The number of occupants
present in each zone at any time coincides with the internal gain schedule
defined in the next section.
The occupied time for the HVAC system is between 6 AM and 7 PM each day.  The
unoccupied time is outside of this period.
</p>
<h4>Internal loads and schedules</h4>
<p>
The design internal gains including lighting, plug loads, and people
are combined 20 W/m^2 with a radiant-convective-latent split of 40%-40%-20%.
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
airflow rates of 0.3e-3 m^3/s-m^2 and 2.5e-3 m^3/s-person.  The limiting
zone air distribution effectiveness is 0.8 and the occupant diversity
ratio is 0.7.  This leads to the minimum outside airflow rates for each zone
and system defined in the table below.
</p>
<p>
<b>Table 1: Zone and System Specifications Summary</b>
<table>
  <tr>
  <th>Name</th>
  <th>Design Airflow [m^3/s]</th>
  <th>Min OA Airflow [m^3/s]</th>
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
and density of CO2 assumed to be 1.8 kg/m^3,
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
March 19, 2021 by David Blum:<br/>
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
