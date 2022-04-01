within MultiZoneOfficeSimpleAir.BaseClasses;
model ASHRAE2006
  "Variable air volume flow system with terminal reheat and ASHRAE 2006 control sequence serving five thermal zones"
  extends MultiZoneOfficeSimpleAir.BaseClasses.PartialHVAC(amb(nPorts=3),
    splHeaRet(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splHeaSup(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splCooRet(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splCooSup(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splRetNor(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splSupNor(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splRetEas(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splSupEas(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splRetSou(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splSupSou(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splRetRoo1(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial),
    splSupRoo1(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial));

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

  Buildings.Examples.VAVReheat.BaseClasses.Controls.FanVFD conFanSup(
      xSet_nominal(displayUnit="Pa") = 410, r_N_min=yFanMin)
    "Controller for fan"
    annotation (Placement(transformation(extent={{240,-10},{260,10}})));
  ModeSelector                                                   modeSelector
    annotation (Placement(transformation(extent={{-200,-320},{-180,-300}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.ControlBus controlBus
    annotation (Placement(transformation(extent={{-250,-352},{-230,-332}}),
        iconTransformation(extent={{-162,-100},{-142,-80}})));

  Economizer                                                   conEco(
    have_reset=true,
    have_frePro=true) "Controller for economizer"
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.RoomTemperatureSetpoint TSetRoo(
    final THeaOn=THeaOn,
    final THeaOff=THeaOff,
    final TCooOn=TCooOn,
    final TCooOff=TCooOff)
    annotation (Placement(transformation(extent={{-300,-358},{-280,-338}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.DuctStaticPressureSetpoint pSetDuc(nin=5,
      pMin=50) "Duct static pressure setpoint"
    annotation (Placement(transformation(extent={{160,-16},{180,4}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.RoomVAV conVAVCor(
      ratVFloMin=ratVMinCor_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit corridor"
    annotation (Placement(transformation(extent={{456,-124},{476,-104}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.RoomVAV conVAVSou(
      ratVFloMin=ratVMinSou_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit south"
    annotation (Placement(transformation(extent={{638,-124},{658,-104}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.RoomVAV conVAVEas(
      ratVFloMin=ratVMinEas_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit east"
    annotation (Placement(transformation(extent={{822,-124},{842,-104}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.RoomVAV conVAVNor(
      ratVFloMin=ratVMinNor_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit north"
    annotation (Placement(transformation(extent={{996,-124},{1016,-104}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.RoomVAV conVAVWes(
      ratVFloMin=ratVMinWes_flow, ratVFloHea=ratVFloHea)
    "Controller for terminal unit west"
    annotation (Placement(transformation(extent={{1186,-124},{1206,-104}})));

  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-100,-250},{-80,-230}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.SupplyAirTemperature conTSup
    "Supply air temperature and economizer controller"
    annotation (Placement(transformation(extent={{-60,-230},{-40,-210}})));
  SupplyAirTemperatureSetpoint
    TSupSet "Supply air temperature set point"
    annotation (Placement(transformation(extent={{-200,-230},{-180,-210}})));
  Buildings.Fluid.Actuators.Dampers.Exponential damExh(
    from_dp=false,
    riseTime=15,
    dpFixed_nominal=5,
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    dpDamper_nominal=5)  "Exhaust air damper"
    annotation (Placement(transformation(extent={{-30,-20},{-50,0}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.SystemHysteresis sysHysHea
    "Hysteresis and delay to switch heating on and off"
    annotation (Placement(transformation(extent={{-10,-150},{10,-130}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.SystemHysteresis sysHysCoo
    "Hysteresis and delay to switch cooling on and off"
    annotation (Placement(transformation(extent={{40,-250},{60,-230}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch swiFreStaPum
    "Switch for freeze stat of pump"
    annotation (Placement(transformation(extent={{40,-130},{60,-110}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch swiFreStaVal
    "Switch for freeze stat of valve"
    annotation (Placement(transformation(extent={{40,-170},{60,-150}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yFreHeaCoi(final k=1)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{-140,-130},{-120,-110}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMin TRooMin(
    final nin=numZon,
    u(each final unit="K",
      each displayUnit="degC"),
    y(final unit="K",
      displayUnit="degC"))
    "Minimum room temperature"
    annotation (Placement(transformation(extent={{-340,260},{-320,280}})));
  Buildings.Utilities.Math.Average TRooAve(
    final nin=numZon,
    u(each final unit="K", each displayUnit="degC"),
    y(final unit="K", displayUnit="degC")) "Average room temperature"
    annotation (Placement(transformation(extent={{-340,230},{-320,250}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.FreezeStat freSta
    "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  WriteAhu oveAhu "Overwrite signals for AHU"
    annotation (Placement(transformation(extent={{200,212},{220,240}})));
  ReadAhu reaAhu
    annotation (Placement(transformation(extent={{200,360},{220,392}})));
  ReadZone reaZonCor(zone="cor") "Read zone measurements"
    annotation (Placement(transformation(extent={{650,82},{670,100}})));
  Modelica.Blocks.Interfaces.RealInput CO2Roo[numZon] "Mass fraction of CO2"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-400,460}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-220,220})));
  Modelica.Blocks.Routing.DeMultiplex5 CO2RooAir(u(each unit="ppm", each
        displayUnit="ppm")) "Demultiplex for room air CO2 concentration"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={490,460})));
  ReadZone reaZonSou(zone="sou") "Read zone measurements"
    annotation (Placement(transformation(extent={{830,82},{850,100}})));
  ReadZone reaZonEas(zone="eas") "Read zone measurements"
    annotation (Placement(transformation(extent={{1010,82},{1030,100}})));
  ReadZone reaZonNor(zone="nor") "Read zone measurements"
    annotation (Placement(transformation(extent={{1180,82},{1200,100}})));
  ReadZone reaZonWes(zone="wes") "Read zone measurements"
    annotation (Placement(transformation(extent={{1380,82},{1400,100}})));
  WriteZoneLoc oveZonActCor(zone="cor") "Overwrite zone actuator signals"
    annotation (Placement(transformation(extent={{490,-124},{510,-104}})));
  WriteZoneLoc oveZonActSou(zone="sou") "Overwrite zone actuator signals"
    annotation (Placement(transformation(extent={{672,-124},{692,-104}})));
  WriteZoneLoc oveZonActEas(zone="eas") "Overwrite zone actuator signals"
    annotation (Placement(transformation(extent={{856,-124},{876,-104}})));
  WriteZoneLoc oveZonActNor(zone="nor") "Overwrite zone actuator signals"
    annotation (Placement(transformation(extent={{1028,-124},{1048,-104}})));
  WriteZoneLoc oveZonActWes(zone="wes") "Overwrite zone actuator signals"
    annotation (Placement(transformation(extent={{1220,-124},{1240,-104}})));
  WriteZoneSup oveZonSupCor(zone="cor") "Overwrite zone supervisory signals"
    annotation (Placement(transformation(extent={{408,-122},{428,-102}})));
  WriteZoneSup oveZonSupSou(zone="sou") "Overwrite zone supervisory signals"
    annotation (Placement(transformation(extent={{598,-122},{618,-102}})));
  WriteZoneSup oveZonSupEas(zone="eas") "Overwrite zone supervisory signals"
    annotation (Placement(transformation(extent={{780,-120},{800,-100}})));
  WriteZoneSup oveZonSupNor(zone="nor") "Overwrite zone supervisory signals"
    annotation (Placement(transformation(extent={{946,-120},{966,-100}})));
  WriteZoneSup oveZonSupWes(zone="wes") "Overwrite zone supervisory signals"
    annotation (Placement(transformation(extent={{1130,-120},{1150,-100}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{40,-280},{60,-260}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{-10,-180},{10,-160}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis proFanOn(uLow=0.01, uHigh=0.05)
    annotation (Placement(transformation(extent={{-10,-270},{10,-250}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gai(k=1.2/m_flow_nominal)
    annotation (Placement(transformation(extent={{318,-330},{298,-310}})));
  Modelica.Blocks.Routing.Multiplex5 TSetHeaNum
    annotation (Placement(transformation(extent={{320,-370},{300,-350}})));
  Modelica.Blocks.Routing.Multiplex5 TSetCooNum
    annotation (Placement(transformation(extent={{320,-400},{300,-380}})));
equation
  connect(controlBus, modeSelector.cb) annotation (Line(
      points={{-240,-342},{-152,-342},{-152,-303.182},{-196.818,-303.182}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(TRooAve.y, controlBus.TRooAve) annotation (Line(
      points={{-319,240},{-240,240},{-240,-342}},
      color={0,0,127}),          Text(
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

  connect(conVAVCor.TRoo, TRooAir.y5[1]) annotation (Line(
      points={{455,-121},{452,-121},{452,-120},{440,-120},{440,240},{520,240},{520,
          282},{501,282}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conVAVSou.TRoo, TRooAir.y1[1]) annotation (Line(
      points={{637,-121},{628,-121},{628,298},{501,298}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y2[1], conVAVEas.TRoo) annotation (Line(
      points={{501,294},{808,294},{808,-121},{821,-121}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y3[1], conVAVNor.TRoo) annotation (Line(
      points={{501,290},{978,290},{978,-121},{995,-121}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y4[1], conVAVWes.TRoo) annotation (Line(
      points={{501,286},{1160,286},{1160,-121},{1185,-121}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(occSch.tNexOcc, controlBus.dTNexOcc) annotation (Line(
      points={{-299,-204},{-240,-204},{-240,-342}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(occSch.occupied, controlBus.occupied) annotation (Line(
      points={{-299,-216},{-240,-216},{-240,-342}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
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
  connect(or2.u2, modeSelector.yFan) annotation (Line(points={{-102,-248},{-120,
          -248},{-120,-305.455},{-179.091,-305.455}},
                                     color={255,0,255}));
  connect(cor.y_actual, pSetDuc.u[1]) annotation (Line(points={{612,42},{620,42},
          {620,74},{140,74},{140,-7.6},{158,-7.6}}, color={0,0,127}));
  connect(sou.y_actual, pSetDuc.u[2]) annotation (Line(points={{792,40},{800,40},
          {800,74},{140,74},{140,-6.8},{158,-6.8}}, color={0,0,127}));
  connect(eas.y_actual, pSetDuc.u[3]) annotation (Line(points={{972,40},{980,40},
          {980,74},{140,74},{140,-6},{158,-6}}, color={0,0,127}));
  connect(nor.y_actual, pSetDuc.u[4]) annotation (Line(points={{1132,40},{1140,40},
          {1140,74},{140,74},{140,-5.2},{158,-5.2}},     color={0,0,127}));
  connect(wes.y_actual, pSetDuc.u[5]) annotation (Line(points={{1332,40},{1338,40},
          {1338,74},{140,74},{140,-4.4},{158,-4.4}},     color={0,0,127}));
  connect(TSup.T, conTSup.TSup) annotation (Line(
      points={{340,-29},{352,-29},{352,-188},{-80,-188},{-80,-214},{-62,-214}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conTSup.yOA, conEco.uOATSup) annotation (Line(
      points={{-38,-220},{-28,-220},{-28,-180},{-152,-180},{-152,158.667},{
          -81.3333,158.667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(or2.y, conTSup.uEna) annotation (Line(points={{-78,-240},{-70,-240},{
          -70,-226},{-62,-226}},
                               color={255,0,255}));
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
  connect(freSta.y, or2.u1) annotation (Line(points={{-38,-80},{-20,-80},{-20,-100},
          {-108,-100},{-108,-240},{-102,-240}},
                                   color={255,0,255}));
  connect(yFreHeaCoi.y, swiFreStaPum.u1) annotation (Line(points={{-118,-120},{
          -80,-120},{-80,-112},{38,-112}}, color={0,0,127}));
  connect(yFreHeaCoi.y, swiFreStaVal.u1) annotation (Line(points={{-118,-120},{
          28,-120},{28,-152},{38,-152}}, color={0,0,127}));
  connect(freSta.y, swiFreStaPum.u2) annotation (Line(points={{-38,-80},{34,-80},
          {34,-120},{38,-120}},      color={255,0,255}));
  connect(freSta.y, swiFreStaVal.u2) annotation (Line(points={{-38,-80},{34,-80},
          {34,-160},{38,-160}},      color={255,0,255}));
  connect(sysHysHea.y, swiFreStaVal.u3) annotation (Line(points={{12,-140},{26,-140},
          {26,-168},{38,-168}},       color={0,0,127}));
  connect(TRooMin.y, controlBus.TRooMin) annotation (Line(points={{-318,270},{-240,
          270},{-240,-342}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TRooMin.u, TRoo) annotation (Line(points={{-342,270},{-360,270},{-360,
          320},{-400,320}}, color={0,0,127}));
  connect(TRooAve.u, TRoo) annotation (Line(points={{-342,240},{-360,240},{-360,
          320},{-400,320}}, color={0,0,127}));
  connect(freSta.u, TMix.T) annotation (Line(points={{-62,-80},{-72,-80},{-72,-60},
          {26,-60},{26,-20},{40,-20},{40,-29}}, color={0,0,127}));
  connect(damExh.port_b, amb.ports[3]) annotation (Line(points={{-50,-10},{-100,
          -10},{-100,-45},{-114,-45}}, color={0,127,255}));
  connect(conFanSup.y, oveAhu.yFan_in) annotation (Line(points={{261,0},{270,0},
          {270,20},{170,20},{170,238.444},{198,238.444}}, color={0,0,127}));
  connect(oveAhu.yFan_out, fanSup.y) annotation (Line(points={{221,238.444},{
          310,238.444},{310,-28}}, color={0,0,127}));
  connect(TSupSet.TSet, oveAhu.TSupSet_in) annotation (Line(points={{-178,-220},
          {-174,-220},{-174,222.889},{198,222.889}}, color={0,0,127}));
  connect(oveAhu.TSupSet_out, conTSup.TSupSet) annotation (Line(points={{221,
          222.889},{304,222.889},{304,180},{-172,180},{-172,-220},{-62,-220}},
        color={0,0,127}));
  connect(conEco.yOA, oveAhu.yOA_in) annotation (Line(points={{-58.6667,152},{
          -52,152},{-52,216.667},{198,216.667}}, color={0,0,127}));
  connect(oveAhu.yOA_out, damExh.y) annotation (Line(points={{221,216.667},{300,
          216.667},{300,184},{-40,184},{-40,2}}, color={0,0,127}));
  connect(damOut.y, damExh.y) annotation (Line(points={{-40,-28},{-42,-28},{-42,
          -20},{-20,-20},{-20,10},{-40,10},{-40,2}}, color={0,0,127}));
  connect(conEco.yRet, oveAhu.yRet_in) annotation (Line(points={{-58.6667,
          146.667},{-50,146.667},{-50,213.556},{198,213.556}}, color={0,0,127}));
  connect(oveAhu.yRet_out, damRet.y) annotation (Line(points={{221,213.556},{
          298,213.556},{298,186},{-12,186},{-12,-10}}, color={0,0,127}));
  connect(pSetDuc.y, oveAhu.dpSet_in) annotation (Line(points={{181,-6},{186,-6},
          {186,219.778},{198,219.778}}, color={0,0,127}));
  connect(oveAhu.dpSet_out, conFanSup.u) annotation (Line(points={{221,219.778},
          {302,219.778},{302,182},{188,182},{188,0},{238,0}}, color={0,0,127}));
  connect(TRet.T, reaAhu.TRet_in) annotation (Line(points={{100,151},{100,388},{
          198,388},{198,387.2}},  color={0,0,127}));
  connect(senSupFlo.V_flow, reaAhu.V_flow_sup_in) annotation (Line(points={{410,
          -29},{410,296},{104,296},{104,384.8},{198,384.8}}, color={0,0,127}));
  connect(senRetFlo.V_flow, reaAhu.V_flow_ret_in) annotation (Line(points={{350,
          151},{350,302},{106,302},{106,382.4},{198,382.4}}, color={0,0,127}));
  connect(reaAhu.dp_in, dpDisSupFan.p_rel) annotation (Line(points={{198,377.6},
          {178,377.6},{178,378},{108,378},{108,306},{280,306},{280,4.44089e-16},
          {311,4.44089e-16}}, color={0,0,127}));
  connect(TSup.T, reaAhu.TSup_in) annotation (Line(points={{340,-29},{340,98},{
          332,98},{332,310},{98,310},{98,392},{198,392}}, color={0,0,127}));
  connect(TMix.T, reaAhu.TMix_in) annotation (Line(points={{40,-29},{40,389.6},
          {198,389.6}}, color={0,0,127}));
  connect(fanSup.P, reaAhu.PFanSup_in) annotation (Line(points={{321,-31},{330,
          -31},{330,358},{180,358},{180,375.2},{198,375.2}}, color={0,0,127}));
  connect(conVAVCor.TRoo, reaZonCor.TZon_in) annotation (Line(points={{455,-121},
          {452,-121},{452,-120},{440,-120},{440,98},{648,98}}, color={0,0,127}));
  connect(cor.VSup_flow, reaZonCor.V_flow_in) annotation (Line(points={{612,58},
          {616,58},{616,90},{648,90}}, color={0,0,127}));
  connect(cor.TSup, reaZonCor.TSup_in) annotation (Line(points={{612,50},{618,
          50},{618,94},{648,94}}, color={0,0,127}));
  connect(CO2Roo, CO2RooAir.u)
    annotation (Line(points={{-400,460},{478,460}}, color={0,0,127}));
  connect(CO2RooAir.y5[1], reaZonCor.C_In) annotation (Line(points={{501,452},{
          524,452},{524,86},{648,86}}, color={0,0,127}));
  connect(conVAVSou.TRoo, reaZonSou.TZon_in) annotation (Line(points={{637,-121},
          {628,-121},{628,116},{700,116},{700,98},{828,98}}, color={0,0,127}));
  connect(reaZonSou.V_flow_in, sou.VSup_flow) annotation (Line(points={{828,90},
          {798,90},{798,56},{792,56}}, color={0,0,127}));
  connect(sou.TSup, reaZonSou.TSup_in) annotation (Line(points={{792,48},{796,
          48},{796,94},{828,94}}, color={0,0,127}));
  connect(CO2RooAir.y1[1], reaZonSou.C_In) annotation (Line(points={{501,468},{
          760,468},{760,86},{828,86}}, color={0,0,127}));
  connect(reaZonEas.TZon_in, conVAVEas.TRoo) annotation (Line(points={{1008,98},
          {900,98},{900,112},{808,112},{808,-121},{821,-121}}, color={0,0,127}));
  connect(reaZonEas.TSup_in, eas.TSup) annotation (Line(points={{1008,94},{976,
          94},{976,48},{972,48}}, color={0,0,127}));
  connect(eas.VSup_flow, reaZonEas.V_flow_in)
    annotation (Line(points={{972,56},{972,90},{1008,90}}, color={0,0,127}));
  connect(CO2RooAir.y2[1], reaZonEas.C_In) annotation (Line(points={{501,464},{
          940,464},{940,86},{1008,86}}, color={0,0,127}));
  connect(reaZonNor.TZon_in, conVAVNor.TRoo) annotation (Line(points={{1178,98},
          {1080,98},{1080,112},{978,112},{978,-121},{995,-121}}, color={0,0,127}));
  connect(nor.TSup, reaZonNor.TSup_in) annotation (Line(points={{1132,48},{1138,
          48},{1138,94},{1178,94}}, color={0,0,127}));
  connect(nor.VSup_flow, reaZonNor.V_flow_in)
    annotation (Line(points={{1132,56},{1132,90},{1178,90}}, color={0,0,127}));
  connect(CO2RooAir.y3[1], reaZonNor.C_In) annotation (Line(points={{501,460},{
          1100,460},{1100,86},{1178,86}}, color={0,0,127}));
  connect(reaZonWes.TZon_in, conVAVWes.TRoo) annotation (Line(points={{1378,98},
          {1240,98},{1240,112},{1160,112},{1160,-121},{1185,-121}}, color={0,0,
          127}));
  connect(wes.VSup_flow, reaZonWes.V_flow_in)
    annotation (Line(points={{1332,56},{1332,90},{1378,90}}, color={0,0,127}));
  connect(wes.TSup, reaZonWes.TSup_in) annotation (Line(points={{1332,48},{1336,
          48},{1336,94},{1378,94}}, color={0,0,127}));
  connect(reaZonWes.C_In, CO2RooAir.y4[1]) annotation (Line(points={{1378,86},{
          1280,86},{1280,456},{501,456}}, color={0,0,127}));
  connect(conVAVCor.yDam, oveZonActCor.yDam_in) annotation (Line(points={{477,
          -109.2},{481.5,-109.2},{481.5,-110},{488,-110}}, color={0,0,127}));
  connect(conVAVCor.yVal, oveZonActCor.yReaHea_in) annotation (Line(points={{
          477,-119},{482.5,-119},{482.5,-118},{488,-118}}, color={0,0,127}));
  connect(oveZonActCor.yDam_out, cor.yVAV) annotation (Line(points={{511,-110},
          {540,-110},{540,58},{566,58}}, color={0,0,127}));
  connect(oveZonActCor.yReaHea_out, cor.yHea) annotation (Line(points={{511,
          -118},{546,-118},{546,48},{566,48}}, color={0,0,127}));
  connect(conVAVSou.yDam, oveZonActSou.yDam_in) annotation (Line(points={{659,
          -109.2},{664.5,-109.2},{664.5,-110},{670,-110}}, color={0,0,127}));
  connect(conVAVSou.yVal, oveZonActSou.yReaHea_in) annotation (Line(points={{
          659,-119},{666.5,-119},{666.5,-118},{670,-118}}, color={0,0,127}));
  connect(oveZonActSou.yDam_out, sou.yVAV) annotation (Line(points={{693,-110},
          {700,-110},{700,-108},{706,-108},{706,56},{746,56}}, color={0,0,127}));
  connect(sou.yHea, oveZonActSou.yReaHea_out) annotation (Line(points={{746,46},
          {712,46},{712,-118},{693,-118}}, color={0,0,127}));
  connect(conVAVEas.yDam, oveZonActEas.yDam_in) annotation (Line(points={{843,
          -109.2},{848.5,-109.2},{848.5,-110},{854,-110}}, color={0,0,127}));
  connect(conVAVEas.yVal, oveZonActEas.yReaHea_in) annotation (Line(points={{
          843,-119},{850.5,-119},{850.5,-118},{854,-118}}, color={0,0,127}));
  connect(oveZonActEas.yDam_out, eas.yVAV) annotation (Line(points={{877,-110},
          {882,-110},{882,56},{926,56}}, color={0,0,127}));
  connect(oveZonActEas.yReaHea_out, eas.yHea) annotation (Line(points={{877,
          -118},{888,-118},{888,46},{926,46}}, color={0,0,127}));
  connect(conVAVNor.yDam, oveZonActNor.yDam_in) annotation (Line(points={{1017,
          -109.2},{1021.5,-109.2},{1021.5,-110},{1026,-110}}, color={0,0,127}));
  connect(conVAVNor.yVal, oveZonActNor.yReaHea_in) annotation (Line(points={{
          1017,-119},{1021.5,-119},{1021.5,-118},{1026,-118}}, color={0,0,127}));
  connect(oveZonActNor.yDam_out, nor.yVAV) annotation (Line(points={{1049,-110},
          {1054,-110},{1054,56},{1086,56}}, color={0,0,127}));
  connect(oveZonActNor.yReaHea_out, nor.yHea) annotation (Line(points={{1049,
          -118},{1056,-118},{1056,46},{1086,46}}, color={0,0,127}));
  connect(conVAVWes.yVal, oveZonActWes.yReaHea_in) annotation (Line(points={{
          1207,-119},{1213.5,-119},{1213.5,-118},{1218,-118}}, color={0,0,127}));
  connect(conVAVWes.yDam, oveZonActWes.yDam_in) annotation (Line(points={{1207,
          -109.2},{1212.5,-109.2},{1212.5,-110},{1218,-110}}, color={0,0,127}));
  connect(oveZonActWes.yDam_out, wes.yVAV) annotation (Line(points={{1241,-110},
          {1248,-110},{1248,56},{1286,56}}, color={0,0,127}));
  connect(wes.yHea, oveZonActWes.yReaHea_out) annotation (Line(points={{1286,46},
          {1252,46},{1252,-118},{1241,-118}}, color={0,0,127}));
  connect(oveZonSupCor.TZonHeaSet_out, conVAVCor.TRooHeaSet) annotation (Line(
        points={{429,-108},{442,-108},{442,-107},{454,-107}}, color={0,0,127}));
  connect(oveZonSupCor.TZonCooSet_out, conVAVCor.TRooCooSet) annotation (Line(
        points={{429,-116},{442,-116},{442,-114},{454,-114}}, color={0,0,127}));
  connect(oveZonSupSou.TZonHeaSet_out, conVAVSou.TRooHeaSet) annotation (Line(
        points={{619,-108},{628,-108},{628,-107},{636,-107}}, color={0,0,127}));
  connect(oveZonSupSou.TZonCooSet_out, conVAVSou.TRooCooSet) annotation (Line(
        points={{619,-116},{628,-116},{628,-114},{636,-114}}, color={0,0,127}));
  connect(oveZonSupEas.TZonHeaSet_out, conVAVEas.TRooHeaSet) annotation (Line(
        points={{801,-106},{810,-106},{810,-107},{820,-107}}, color={0,0,127}));
  connect(oveZonSupEas.TZonCooSet_out, conVAVEas.TRooCooSet)
    annotation (Line(points={{801,-114},{820,-114}}, color={0,0,127}));
  connect(oveZonSupNor.TZonHeaSet_out, conVAVNor.TRooHeaSet) annotation (Line(
        points={{967,-106},{980,-106},{980,-107},{994,-107}}, color={0,0,127}));
  connect(oveZonSupNor.TZonCooSet_out, conVAVNor.TRooCooSet)
    annotation (Line(points={{967,-114},{994,-114}}, color={0,0,127}));
  connect(oveZonSupWes.TZonHeaSet_out, conVAVWes.TRooHeaSet) annotation (Line(
        points={{1151,-106},{1168,-106},{1168,-107},{1184,-107}}, color={0,0,
          127}));
  connect(oveZonSupWes.TZonCooSet_out, conVAVWes.TRooCooSet) annotation (Line(
        points={{1151,-114},{1168.5,-114},{1168.5,-114},{1184,-114}}, color={0,
          0,127}));
  connect(oveZonSupCor.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(
        points={{406,-108},{400,-108},{400,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveZonSupCor.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(
        points={{406,-116},{400,-116},{400,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveZonSupSou.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(
        points={{596,-108},{588,-108},{588,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveZonSupSou.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(
        points={{596,-116},{588,-116},{588,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveZonSupNor.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(
        points={{944,-106},{930,-106},{930,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveZonSupNor.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(
        points={{944,-114},{930,-114},{930,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveZonSupEas.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(
        points={{778,-106},{766,-106},{766,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveZonSupEas.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(
        points={{778,-114},{766,-114},{766,-342},{-240,-342}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(oveZonSupWes.TZonHeaSet_in, controlBus.TRooSetHea) annotation (Line(
        points={{1128,-106},{1112,-106},{1112,-342},{-240,-342}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pumHeaCoi.P, reaAhu.PPumHea_in) annotation (Line(points={{137,-109},{
          137,370.4},{198,370.4}}, color={0,0,127}));
  connect(pumCooCoi.P, reaAhu.PPumCoo_in) annotation (Line(points={{189,-131},{
          189,-134},{164,-134},{164,372.8},{198,372.8}}, color={0,0,127}));
  connect(or1.u2, conFanSup.uFan) annotation (Line(points={{38,-278},{-8,-278},{
          -8,-305.455},{260,-305.455},{260,-30},{226,-30},{226,6},{238,6}},
        color={255,0,255}));
  connect(or1.y, sysHysCoo.sysOn) annotation (Line(points={{61,-270},{70,-270},{
          70,-254},{30,-254},{30,-234},{38,-234}}, color={255,0,255}));
  connect(or3.u2, modeSelector.yFan) annotation (Line(points={{-12,-178},{-18,
          -178},{-18,-306},{-98,-306},{-98,-305.455},{-179.091,-305.455}},
                                                                     color={255,
          0,255}));
  connect(or3.y, sysHysHea.sysOn) annotation (Line(points={{11,-170},{16,-170},{
          16,-154},{-20,-154},{-20,-134},{-12,-134}}, color={255,0,255}));
  connect(proFanOn.y, or1.u1) annotation (Line(points={{12,-260},{30,-260},{30,-270},
          {38,-270}}, color={255,0,255}));
  connect(senSupFlo.V_flow, gai.u) annotation (Line(points={{410,-29},{410,-20},
          {364,-20},{364,-320},{320,-320}}, color={0,0,127}));
  connect(gai.y, proFanOn.u) annotation (Line(points={{296,-320},{-24,-320},{-24,
          -260},{-12,-260}}, color={0,0,127}));
  connect(proFanOn.y, or3.u1) annotation (Line(points={{12,-260},{20,-260},{20,-184},
          {-20,-184},{-20,-170},{-12,-170}}, color={255,0,255}));
  connect(swiFreStaVal.y, valHeaCoi.y) annotation (Line(points={{62,-160},{106,-160},
          {106,-210},{116,-210}},     color={0,0,127}));
  connect(sysHysCoo.y, valCooCoi.y) annotation (Line(points={{62,-240},{80,-240},
          {80,-230},{168,-230},{168,-210},{208,-210}},
                                        color={0,0,127}));
  connect(swiFreStaPum.y, pumHeaCoi.y) annotation (Line(points={{62,-120},{100,-120},
          {100,-140},{150,-140},{150,-120},{140,-120}}, color={0,0,127}));
  connect(conTSup.yHea, oveAhu.yHea_in) annotation (Line(points={{-38,-214},{
          -26,-214},{-26,-104},{44,-104},{44,235.333},{198,235.333}},
                                                          color={0,0,127}));
  connect(conTSup.yCoo, oveAhu.yCoo_in) annotation (Line(points={{-38,-226},{
          -24,-226},{-24,-106},{46,-106},{46,232.222},{198,232.222}},
                                                          color={0,0,127}));
  connect(oveAhu.yHea_out, sysHysHea.u) annotation (Line(points={{221,235.333},
          {308,235.333},{308,76},{48,76},{48,-108},{-22,-108},{-22,-140},{-12,
          -140}},
        color={0,0,127}));
  connect(oveAhu.yCoo_out, sysHysCoo.u) annotation (Line(points={{221,232.222},
          {306,232.222},{306,80},{50,80},{50,-110},{24,-110},{24,-240},{38,-240}},
                                                                          color=
         {0,0,127}));
  connect(senTemHeaCoiRet.T, reaAhu.THeaCoiRet_in) annotation (Line(points={{77,
          -90},{70,-90},{70,360.8},{198,360.8}}, color={0,0,127}));
  connect(senTemHeaCoiSup.T, reaAhu.THeaCoiSup_in) annotation (Line(points={{
          117,-90},{112,-90},{112,-70},{72,-70},{72,363.2},{198,363.2}}, color=
          {0,0,127}));
  connect(senTemCooCoiRet.T, reaAhu.TCooCoiRet_in) annotation (Line(points={{
          169,-90},{170,-90},{170,366},{198,366},{198,365.6}}, color={0,0,127}));
  connect(senTemCooCoiSup.T, reaAhu.TCooCoiSup_in) annotation (Line(points={{
          209,-90},{200,-90},{200,-70},{172,-70},{172,368},{198,368}}, color={0,
          0,127}));
  connect(sysHysHea.yPum, oveAhu.yPumHea_in) annotation (Line(points={{12,-147},
          {16,-147},{16,-148},{20,-148},{20,229.111},{198,229.111}}, color={0,0,
          127}));
  connect(oveAhu.yPumHea_out, swiFreStaPum.u3) annotation (Line(points={{221,
          229.111},{296,229.111},{296,178},{22,178},{22,-128},{38,-128}}, color=
         {0,0,127}));
  connect(sysHysCoo.yPum, oveAhu.yPumCoo_in) annotation (Line(points={{62,-247},
          {66,-247},{66,226},{198,226}}, color={0,0,127}));
  connect(oveAhu.yPumCoo_out, pumCooCoi.y) annotation (Line(points={{221,226},{
          298,226},{298,176},{68,176},{68,-228},{166,-228},{166,-208},{204,-208},
          {204,-120},{192,-120}}, color={0,0,127}));
  connect(conEco.yFan, fanSup.y) annotation (Line(points={{-81.3333,142.667},{
          -90,142.667},{-90,132},{310,132},{310,-28}},
                                                   color={0,0,127}));
  connect(TRoo, modeSelector.TRoo) annotation (Line(points={{-400,320},{-370,
          320},{-370,-303.636},{-200,-303.636}}, color={0,0,127}));
  connect(oveZonSupCor.TZonCooSet_out, TSetCooNum.u5[1]) annotation (Line(
        points={{429,-116},{434,-116},{434,-400},{322,-400}}, color={0,0,127}));
  connect(oveZonSupCor.TZonHeaSet_out, TSetHeaNum.u5[1]) annotation (Line(
        points={{429,-108},{432,-108},{432,-370},{322,-370}}, color={0,0,127}));
  connect(oveZonSupSou.TZonCooSet_out, TSetCooNum.u1[1]) annotation (Line(
        points={{619,-116},{624,-116},{624,-380},{322,-380}}, color={0,0,127}));
  connect(oveZonSupSou.TZonHeaSet_out, TSetHeaNum.u1[1]) annotation (Line(
        points={{619,-108},{622,-108},{622,-350},{322,-350}}, color={0,0,127}));
  connect(oveZonSupEas.TZonCooSet_out, TSetCooNum.u2[1]) annotation (Line(
        points={{801,-114},{806,-114},{806,-385},{322,-385}}, color={0,0,127}));
  connect(oveZonSupEas.TZonHeaSet_out, TSetHeaNum.u2[1]) annotation (Line(
        points={{801,-106},{804,-106},{804,-355},{322,-355}}, color={0,0,127}));
  connect(oveZonSupNor.TZonCooSet_out, TSetCooNum.u3[1]) annotation (Line(
        points={{967,-114},{976,-114},{976,-390},{322,-390}}, color={0,0,127}));
  connect(oveZonSupNor.TZonHeaSet_out, TSetHeaNum.u3[1]) annotation (Line(
        points={{967,-106},{974,-106},{974,-360},{322,-360}}, color={0,0,127}));
  connect(oveZonSupWes.TZonCooSet_out, TSetCooNum.u4[1]) annotation (Line(
        points={{1151,-114},{1156,-114},{1156,-395},{322,-395}}, color={0,0,127}));
  connect(oveZonSupWes.TZonHeaSet_out, TSetHeaNum.u4[1]) annotation (Line(
        points={{1151,-106},{1154,-106},{1154,-364},{322,-364},{322,-365}},
        color={0,0,127}));
  connect(TSetHeaNum.y, modeSelector.TRooSetHeaNum) annotation (Line(points={{
          299,-360},{-220,-360},{-220,-300},{-200,-300}}, color={0,0,127}));
  connect(TSetCooNum.y, modeSelector.TRooSetCooNum) annotation (Line(points={{299,
          -390},{-218,-390},{-218,-301.818},{-200,-301.818}},     color={0,0,
          127}));
  connect(oveZonSupWes.TZonCooSet_in, controlBus.TRooSetCoo) annotation (Line(
        points={{1128,-114},{1116,-114},{1116,-342},{-240,-342}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
  defaultComponentName="hvac",
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-400},{1420,
            660}})),
    Documentation(info="<html>
<p>
This model consist of an HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
The figure below shows the schematic diagram of the HVAC system
</p>
<p>
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavSchematics.png\" border=\"1\"/>
</p>
<p>
See the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC\">
Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC</a>
for a description of the HVAC system,
and see the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.Floor\">
Buildings.Examples.VAVReheat.BaseClasses.Floor</a>
for a description of the building envelope.
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
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.Controls.Economizer\">
Buildings.Examples.VAVReheat.BaseClasses.Controls.Economizer</a>.
The controller of the terminal units tracks the room air temperature set point
based on a \"dual maximum with constant volume heating\" logic, see
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.Controls.RoomVAV\">
Buildings.Examples.VAVReheat.BaseClasses.Controls.RoomVAV</a>.
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
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.Guideline36\">
Buildings.Examples.VAVReheat.BaseClasses.Guideline36</a>.
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
October 4, 2021, by Michael Wetter:<br/>
Refactored <a href=\"modelica://Buildings.Examples.VAVReheat\">Buildings.Examples.VAVReheat</a>
and its base classes to separate building from HVAC model.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2652\">issue #2652</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed assignment of parameter <code>lat</code> as this is now obtained from the weather data reader.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
September 3, 2021, by Michael Wetter:<br/>
Updated documentation.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2600\">issue #2600</a>.
</li>
<li>
August 24, 2021, by Michael Wetter:<br/>
Changed model to include the hydraulic configurations of the cooling coil,
heating coil and VAV terminal box.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2594\">issue #2594</a>.
</li>
<li>
May 6, 2021, by David Blum:<br/>
Change to <code>from_dp=false</code> for exhaust air damper.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2485\">issue #2485</a>.
</li>
<li>
April 30, 2021, by Michael Wetter:<br/>
Reformulated replaceable class and introduced floor areas in base class
to avoid access of components that are not in the constraining type.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2471\">issue #2471</a>.
</li>
<li>
April 16, 2021, by Michael Wetter:<br/>
Refactored model to implement the economizer dampers directly in
<code>Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC</code> rather than through the
model of a mixing box. Since the version of the Guideline 36 model has no exhaust air damper,
this leads to simpler equations.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2454\">issue #2454</a>.
</li>
<li>
March 15, 2021, by David Blum:<br/>
Update documentation graphic to include relief damper.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2399\">#2399</a>.
</li>
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
    Icon(graphics={
        Rectangle(
          extent={{240,172},{220,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{240,172},{220,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{400,100},{-158,60}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,96},{-2,82}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{400,-12},{-158,-52}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-78,60},{-118,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,96},{-12,62}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,86},{-22,72}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{42,100},{56,60}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{104,100},{118,60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-138,100},{-124,60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-138,-12},{-124,-52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-7,20},{7,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={-98,23},
          rotation=90),
        Line(points={{106,60},{106,-6}}, color={0,0,255}),
        Line(points={{116,60},{116,-6}}, color={0,0,255}),
        Line(points={{106,34},{116,34}},   color={0,0,255}),
        Polygon(
          points={{-5,-4},{3,-4},{-1,4},{-5,-4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={107,16}),
        Ellipse(
          extent={{100,54},{112,42}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{106,54},{100,48},{112,48},{106,54}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-5,4},{3,4},{-1,-4},{-5,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={107,24}),
        Line(points={{44,60},{44,-6}},   color={0,0,255}),
        Line(points={{54,60},{54,-6}},   color={0,0,255}),
        Line(points={{44,34},{54,34}},     color={0,0,255}),
        Polygon(
          points={{-5,-4},{3,-4},{-1,4},{-5,-4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={45,16}),
        Ellipse(
          extent={{38,54},{50,42}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{44,54},{38,48},{50,48},{44,54}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-5,4},{3,4},{-1,-4},{-5,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={45,24}),
        Rectangle(
          extent={{320,172},{300,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{280,172},{260,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{400,172},{380,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{360,172},{340,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{240,20},{220,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{280,20},{260,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{320,20},{300,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{360,20},{340,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{400,20},{380,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{380,136},{400,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={390,153},
          rotation=90),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={350,153},
          rotation=90),
        Rectangle(
          extent={{340,136},{360,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{300,136},{320,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={310,153},
          rotation=90),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={270,153},
          rotation=90),
        Rectangle(
          extent={{260,136},{280,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{220,136},{240,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={230,153},
          rotation=90)}));
end ASHRAE2006;
