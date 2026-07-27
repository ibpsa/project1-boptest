within MultiZoneOfficeSimpleAir.BaseClasses;
model ModeSelector "Finite State Machine for the operational modes"
  Modelica.StateGraph.InitialStepWithSignal initialStepWithSignal(nIn=0, nOut=1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.StateGraph.Transition start "Starts the system"
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  State                                                   unOccOff(
    mode=OperationModes.unoccupiedOff,
    nIn=4,
    nOut=5) "Unoccupied off mode, no coil protection"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));

  State                                                   unOccNigSetBac(
    nOut=2,
    mode=OperationModes.unoccupiedNightSetBack,
    nIn=2) "Unoccupied night set back"
    annotation (Placement(transformation(extent={{80,20},{100,40}})));

  Modelica.StateGraph.TransitionWithSignal
                                 t2(
    enableTimer=true,
    waitTime=60)
    annotation (Placement(transformation(extent={{28,20},{48,40}})));
  parameter Integer numZon = 5 "Number of zones";
  parameter Modelica.Units.SI.TemperatureDifference delTRooOnOff(min=0.1)=1
    "Deadband in room temperature between occupied on and occupied off";
  parameter Modelica.Units.SI.Temperature TRooSetHeaOcc=293.15
    "Set point for room air temperature during heating mode";
  parameter Modelica.Units.SI.Temperature TRooSetCooOcc=299.15
    "Set point for room air temperature during cooling mode";
  Modelica.StateGraph.Transition t1(
    condition=delTRooOnOff/2 < -maxTRooErrHea.y,
    enableTimer=true,
    waitTime=30*60)
    annotation (Placement(transformation(extent={{50,70},{30,90}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{160,160},{180,180}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.ControlBus cb annotation (
      Placement(transformation(extent={{-168,130},{-148,150}}),
        iconTransformation(extent={{-176,124},{-124,176}})));
  State                                                   morWarUp(
    mode=OperationModes.unoccupiedWarmUp,
    nIn=2,
    nOut=1) "Morning warm up"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));

  Modelica.StateGraph.TransitionWithSignal t6(enableTimer=true, waitTime=60)
    annotation (Placement(transformation(extent={{-76,-100},{-56,-80}})));
  Modelica.Blocks.Logical.LessEqualThreshold occThrSho(threshold=1800)
    "Signal to allow transition into morning warmup"
    annotation (Placement(transformation(extent={{-140,-190},{-120,-170}})));
  Modelica.StateGraph.TransitionWithSignal t5
    annotation (Placement(transformation(extent={{118,20},{138,40}})));
  State                                                   occ(
    nOut=3,                                                   mode=OperationModes.occupied,
      nIn=4) "Occupied mode"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Modelica.Blocks.Math.Feedback TRooErrHeaSou "Room control error for heating"
    annotation (Placement(transformation(extent={{-140,190},{-120,210}})));
  Modelica.StateGraph.Transition t3(condition=TRooMin.y + delTRooOnOff/2 >
        TRooSetHeaOcc or occupied.y)
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  Modelica.Blocks.Routing.BooleanPassThrough occupied
    "outputs true if building is occupied"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.StateGraph.Transition           t4(condition=not occupied.y and not1.y
         and not booSetBack.y and not booSetUp.y,
                                              enableTimer=false)
    annotation (Placement(transformation(extent={{118,120},{98,140}})));
  State                                                   morPreCoo(
    nIn=2,
    mode=OperationModes.unoccupiedPreCool,
    nOut=1) "Pre-cooling mode"
    annotation (Placement(transformation(extent={{-40,-140},{-20,-120}})));

  Modelica.StateGraph.Transition t7(condition=TRooMin.y - delTRooOnOff/2 <
        TRooSetCooOcc or occupied.y)
    annotation (Placement(transformation(extent={{10,-140},{30,-120}})));
  Modelica.Blocks.Routing.RealPassThrough TRooAve "Average room temperature"
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(
    y=occThrSho.y and (TRooAve.y < TRooSetHeaOcc))
    "Test that outputs true if room temperature is below occupied heating and system should be switched on soon"
    annotation (Placement(transformation(extent={{-204,-226},{-100,-192}})));
  Buildings.Examples.VAVReheat.BaseClasses.Controls.PreCoolingStarter preCooSta(
      TRooSetCooOcc=TRooSetCooOcc) "Model to start pre-cooling"
    annotation (Placement(transformation(extent={{-140,-160},{-120,-140}})));
  Modelica.StateGraph.TransitionWithSignal t9
    annotation (Placement(transformation(extent={{-90,-140},{-70,-120}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-100,-190},{-80,-170}})));
  Modelica.StateGraph.TransitionWithSignal t8
    "changes to occupied in case precooling is deactivated"
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Modelica.Blocks.MathInteger.Sum sum(nu=7)
    annotation (Placement(transformation(extent={{-192,134},{-180,146}})));
  Modelica.Blocks.Interfaces.BooleanOutput yFan
    "True if the fans are to be switched on"
    annotation (Placement(transformation(extent={{220,80},{260,120}}),
        iconTransformation(extent={{220,80},{260,120}})));
  Modelica.Blocks.MathBoolean.Or or1(nu=5)
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput yEco
    "True if the economizer is enabled" annotation (Placement(transformation(
          extent={{220,-120},{260,-80}}), iconTransformation(extent={{220,-120},
            {260,-80}})));
  Modelica.Blocks.MathBoolean.Or or2(nu=3) "Occupied or pre-cool mode"
    annotation (Placement(transformation(extent={{170,-50},{190,-30}})));
  Buildings.Controls.OBC.CDL.Logical.And and3
    "(Occupied or pre-cool mode) and fan on"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={200,-70})));
  Modelica.Blocks.Math.BooleanToInteger modIni(integerTrue=Integer(OperationModes.unoccupiedOff))
    "Initial operation mode"
    annotation (Placement(transformation(extent={{-160,10},{-180,30}})));
  Modelica.Blocks.Interfaces.RealInput TRooSetHeaNum[numZon](each final unit="K",
      each displayUnit="degC") "Room temperature heating set points"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-240,220}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-220,220})));
  Modelica.Blocks.Interfaces.RealInput TRooSetCooNum[numZon](each final unit="K",
      each displayUnit="degC") "Room temperature cooling set points"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-240,180}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-220,180})));
  Modelica.Blocks.Interfaces.RealInput TRoo[numZon](each final unit="K", each
      displayUnit="degC") "Room temperatures" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-240,140}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-220,140})));
  Modelica.Blocks.Math.Feedback TRooErrHeaEas "Room control error for heating"
    annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
  Modelica.Blocks.Math.Feedback TRooErrHeaNor "Room control error for heating"
    annotation (Placement(transformation(extent={{-60,190},{-40,210}})));
  Modelica.Blocks.Math.Feedback TRooErrHeaWes "Room control error for heating"
    annotation (Placement(transformation(extent={{-20,190},{0,210}})));
  Modelica.Blocks.Math.Feedback TRooErrHeaCor "Room control error for heating"
    annotation (Placement(transformation(extent={{20,190},{40,210}})));
  Modelica.Blocks.Sources.RealExpression maxTRooErrHea(y=max({TRooErrHeaSou.y,
        TRooErrHeaEas.y,TRooErrHeaNor.y,TRooErrHeaWes.y,TRooErrHeaCor.y}))
    annotation (Placement(transformation(extent={{60,190},{80,210}})));
  Modelica.Blocks.Math.Feedback TRooErrCooSou "Room control error for cooling"
    annotation (Placement(transformation(extent={{-140,150},{-120,170}})));
  Modelica.Blocks.Math.Feedback TRooErrCooEas "Room control error for cooling"
    annotation (Placement(transformation(extent={{-100,150},{-80,170}})));
  Modelica.Blocks.Math.Feedback TRooErrCooNor "Room control error for cooling"
    annotation (Placement(transformation(extent={{-60,150},{-40,170}})));
  Modelica.Blocks.Math.Feedback TRooErrCooWes "Room control error for cooling"
    annotation (Placement(transformation(extent={{-20,150},{0,170}})));
  Modelica.Blocks.Math.Feedback TRooErrCooCor "Room control error for cooling"
    annotation (Placement(transformation(extent={{20,150},{40,170}})));
  Modelica.Blocks.Sources.RealExpression maxTRooErrCoo(y=max({TRooErrCooSou.y,
        TRooErrCooEas.y,TRooErrCooNor.y,TRooErrCooWes.y,TRooErrCooCor.y}))
    annotation (Placement(transformation(extent={{60,150},{80,170}})));
  State                                                   unOccNigSetUp(
    nOut=3,
    mode=OperationModes.unoccupiedNightSetUp,
    nIn=2) "Unoccupied night set up"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));

  Modelica.StateGraph.TransitionWithSignal
                                 t10(
    enableTimer=true,
    waitTime=60)
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  Modelica.StateGraph.Transition t11(
    condition=delTRooOnOff/2 < -maxTRooErrCoo.y,
    enableTimer=true,
    waitTime=30*60)
    annotation (Placement(transformation(extent={{90,54},{70,74}})));
  Modelica.StateGraph.TransitionWithSignal t12
    annotation (Placement(transformation(extent={{128,-138},{108,-118}})));
  Modelica.StateGraph.TransitionWithSignal t13
    "changes to occupied in case precooling is deactivated"
    annotation (Placement(transformation(extent={{122,-76},{102,-56}})));
  Modelica.Blocks.Routing.RealPassThrough TRooMin
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.BooleanExpression booSetBack(y=maxTRooErrHea.y >
        delTRooOnOff/2) "Check for night set back"
    annotation (Placement(transformation(extent={{-40,-20},{0,0}})));
  Modelica.Blocks.Sources.BooleanExpression booSetUp(y=maxTRooErrCoo.y >
        delTRooOnOff/2) "Check for night set up"
    annotation (Placement(transformation(extent={{-40,-34},{0,-14}})));
  Modelica.StateGraph.Transition           t14(condition=not occupied.y and
        not1.y and booSetBack.y and not booSetUp.y, enableTimer=false)
    annotation (Placement(transformation(extent={{130,90},{110,110}})));
  Modelica.StateGraph.Transition           t15(condition=not occupied.y and
        not1.y and not booSetBack.y and booSetUp.y, enableTimer=false)
    annotation (Placement(transformation(extent={{140,50},{120,70}})));
equation
  connect(start.outPort, unOccOff.inPort[1]) annotation (Line(
      points={{-38.5,30},{-29.75,30},{-29.75,29.625},{-21,29.625}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(unOccOff.outPort[1], t2.inPort)         annotation (Line(
      points={{0.5,29.8},{8.25,29.8},{8.25,30},{34,30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t2.outPort, unOccNigSetBac.inPort[1])  annotation (Line(
      points={{39.5,30},{60,30},{60,29.75},{79,29.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(unOccNigSetBac.outPort[1], t1.inPort)   annotation (Line(
      points={{100.5,29.875},{112,29.875},{112,80},{44,80}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t1.outPort, unOccOff.inPort[2])          annotation (Line(
      points={{38.5,80},{-30,80},{-30,29.875},{-21,29.875}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(cb.dTNexOcc, occThrSho.u)             annotation (Line(
      points={{-158,140},{-150,140},{-150,-180},{-142,-180}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(t6.outPort, morWarUp.inPort[1]) annotation (Line(
      points={{-64.5,-90},{-41,-90},{-41,-90.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t5.outPort, morWarUp.inPort[2]) annotation (Line(
      points={{129.5,30},{140,30},{140,-60},{-48,-60},{-48,-89.75},{-41,-89.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(unOccNigSetBac.outPort[2], t5.inPort)
                                         annotation (Line(
      points={{100.5,30.125},{113.25,30.125},{113.25,30},{124,30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(unOccOff.outPort[2], t6.inPort) annotation (Line(
      points={{0.5,29.9},{12,29.9},{12,-48},{-80,-48},{-80,-90},{-70,-90}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(morWarUp.outPort[1], t3.inPort) annotation (Line(
      points={{-19.5,-90},{16,-90}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(cb.occupied, occupied.u) annotation (Line(
      points={{-158,140},{-120,140},{-120,90},{-82,90}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(occ.outPort[1], t4.inPort) annotation (Line(
      points={{80.5,-90.1667},{146,-90.1667},{146,130},{112,130}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t4.outPort, unOccOff.inPort[3]) annotation (Line(
      points={{106.5,130},{-30,130},{-30,30.125},{-21,30.125}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(cb.TRooAve, TRooAve.u) annotation (Line(
      points={{-158,140},{-100,140},{-100,120},{-82,120}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(t9.outPort, morPreCoo.inPort[1]) annotation (Line(
      points={{-78.5,-130},{-59.75,-130},{-59.75,-130.25},{-41,-130.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(unOccOff.outPort[3], t9.inPort) annotation (Line(
      points={{0.5,30},{12,30},{12,0},{-100,0},{-100,-130},{-84,-130}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(cb, preCooSta.controlBus) annotation (Line(
      points={{-158,140},{-150,140},{-150,-144},{-136.2,-144}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(morPreCoo.outPort[1], t7.inPort) annotation (Line(
      points={{-19.5,-130},{16,-130}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t7.outPort, occ.inPort[2]) annotation (Line(
      points={{21.5,-130},{30,-130},{30,-128},{46,-128},{46,-90.125},{59,
          -90.125}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t3.outPort, occ.inPort[1]) annotation (Line(
      points={{21.5,-90},{42,-90},{42,-90.375},{59,-90.375}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(occThrSho.y, not1.u) annotation (Line(
      points={{-119,-180},{-102,-180}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(t8.outPort, occ.inPort[3]) annotation (Line(
      points={{41.5,-20},{52,-20},{52,-89.875},{59,-89.875}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(unOccOff.outPort[4], t8.inPort) annotation (Line(
      points={{0.5,30.1},{12,30.1},{12,-20},{36,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(occupied.y, t8.condition) annotation (Line(
      points={{-59,90},{-50,90},{-50,-40},{40,-40},{40,-32}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(morPreCoo.y, sum.u[1]) annotation (Line(
      points={{-19,-136},{-8,-136},{-8,-68},{-212,-68},{-212,142},{-192,142},{
          -192,138.2}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(morWarUp.y, sum.u[2]) annotation (Line(
      points={{-19,-96},{-8,-96},{-8,-68},{-212,-68},{-212,144},{-192,144},{
          -192,138.8}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(occ.y, sum.u[3]) annotation (Line(
      points={{81,-96},{90,-96},{90,-108},{-212,-108},{-212,139.4},{-192,139.4}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(unOccOff.y, sum.u[4]) annotation (Line(
      points={{1,24},{6,24},{6,8},{-212,8},{-212,140},{-192,140}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(unOccNigSetBac.y, sum.u[5]) annotation (Line(
      points={{101,24},{112,24},{112,8},{-212,8},{-212,140.6},{-192,140.6}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(yFan, or1.y)
    annotation (Line(points={{240,100},{200,100},{200,0},{191.5,0}},
                                                 color={255,0,255}));
  connect(unOccNigSetBac.active, or1.u[1]) annotation (Line(points={{90,19},{90,
          -2.8},{170,-2.8}}, color={255,0,255}));
  connect(occ.active, or1.u[2]) annotation (Line(points={{70,-101},{70,-104},{
          156,-104},{156,-2},{170,-2},{170,-1.4}},
                                            color={255,0,255}));
  connect(morWarUp.active, or1.u[3]) annotation (Line(points={{-30,-101},{-30,
          -112},{160,-112},{160,-4},{170,-4},{170,0}},
                                                     color={255,0,255}));
  connect(morPreCoo.active, or1.u[4]) annotation (Line(points={{-30,-141},{-30,
          -146},{158,-146},{158,0},{170,0},{170,1.4}},
                                                     color={255,0,255}));
  connect(yEco, and3.y) annotation (Line(points={{240,-100},{200,-100},{200,-82}},
                      color={255,0,255}));
  connect(or1.y, and3.u1) annotation (Line(points={{191.5,0},{200,0},{200,-58}},
                      color={255,0,255}));
  connect(or2.y, and3.u2) annotation (Line(points={{191.5,-40},{192,-40},{192,
          -58}},           color={255,0,255}));
  connect(occ.active, or2.u[1]) annotation (Line(points={{70,-101},{70,-104},{
          156,-104},{156,-42.3333},{170,-42.3333}},
                                              color={255,0,255}));
  connect(morPreCoo.active, or2.u[2]) annotation (Line(points={{-30,-141},{-30,
          -146},{158,-146},{158,-40},{170,-40}},     color={255,0,255}));
  connect(initialStepWithSignal.active, modIni.u) annotation (Line(points={{-70,
          19},{-70,14},{-100,14},{-100,20},{-158,20}}, color={255,0,255}));
  connect(sum.y, cb.controlMode) annotation (Line(points={{-179.1,140},{-158,
          140}}, color={255,127,0}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modIni.y, sum.u[6]) annotation (Line(points={{-181,20},{-200,20},{
          -200,141.2},{-192,141.2}}, color={255,127,0}));
  connect(t6.condition, booleanExpression.y) annotation (Line(points={{-66,-102},
          {-66,-209},{-94.8,-209}}, color={255,0,255}));
  connect(t5.condition, booleanExpression.y) annotation (Line(points={{128,18},
          {128,-209},{-94.8,-209}}, color={255,0,255}));
  connect(TRooSetHeaNum[1], TRooErrHeaSou.u1) annotation (Line(points={{-240,
          212},{-160,212},{-160,200},{-138,200}},
                                             color={0,0,127}));
  connect(TRooSetHeaNum[2], TRooErrHeaEas.u1) annotation (Line(points={{-240,
          216},{-110,216},{-110,200},{-98,200}},
                                            color={0,0,127}));
  connect(TRooSetHeaNum[3], TRooErrHeaNor.u1) annotation (Line(points={{-240,220},
          {-70,220},{-70,200},{-58,200}}, color={0,0,127}));
  connect(TRooSetHeaNum[4], TRooErrHeaWes.u1) annotation (Line(points={{-240,
          224},{-30,224},{-30,200},{-18,200}},
                                          color={0,0,127}));
  connect(TRooSetHeaNum[5], TRooErrHeaCor.u1) annotation (Line(points={{-240,
          228},{10,228},{10,200},{22,200}},
                                       color={0,0,127}));
  connect(TRoo[1], TRooErrHeaSou.u2) annotation (Line(points={{-240,132},{-214,
          132},{-214,180},{-130,180},{-130,192}},
                                             color={0,0,127}));
  connect(TRoo[2], TRooErrHeaEas.u2) annotation (Line(points={{-240,136},{-214,
          136},{-214,180},{-90,180},{-90,192}},
                                           color={0,0,127}));
  connect(TRoo[3], TRooErrHeaNor.u2) annotation (Line(points={{-240,140},{-214,140},
          {-214,180},{-50,180},{-50,192}}, color={0,0,127}));
  connect(TRoo[4], TRooErrHeaWes.u2) annotation (Line(points={{-240,144},{-214,
          144},{-214,180},{-10,180},{-10,192}},
                                           color={0,0,127}));
  connect(TRoo[5], TRooErrHeaCor.u2) annotation (Line(points={{-240,148},{-214,
          148},{-214,180},{30,180},{30,192}},
                                         color={0,0,127}));
  connect(TRoo[1], TRooErrCooSou.u1) annotation (Line(points={{-240,132},{-214,
          132},{-214,170},{-150,170},{-150,160},{-138,160}},
                                                        color={0,0,127}));
  connect(TRoo[2], TRooErrCooEas.u1) annotation (Line(points={{-240,136},{-214,
          136},{-214,170},{-106,170},{-106,160},{-98,160}},
                                                       color={0,0,127}));
  connect(TRoo[3], TRooErrCooNor.u1) annotation (Line(points={{-240,140},{-214,140},
          {-214,170},{-68,170},{-68,160},{-58,160}}, color={0,0,127}));
  connect(TRoo[4], TRooErrCooWes.u1) annotation (Line(points={{-240,144},{-214,
          144},{-214,170},{-26,170},{-26,160},{-18,160}},
                                                     color={0,0,127}));
  connect(TRoo[5], TRooErrCooCor.u1) annotation (Line(points={{-240,148},{-214,
          148},{-214,170},{12,170},{12,160},{22,160}},
                                                  color={0,0,127}));
  connect(TRooSetCooNum[1], TRooErrCooSou.u2) annotation (Line(points={{-240,
          172},{-218,172},{-218,148},{-130,148},{-130,152}},
                                                        color={0,0,127}));
  connect(TRooSetCooNum[2], TRooErrCooEas.u2) annotation (Line(points={{-240,
          176},{-218,176},{-218,148},{-90,148},{-90,152}},
                                                      color={0,0,127}));
  connect(TRooSetCooNum[3], TRooErrCooNor.u2) annotation (Line(points={{-240,180},
          {-218,180},{-218,148},{-50,148},{-50,152}}, color={0,0,127}));
  connect(TRooSetCooNum[4], TRooErrCooWes.u2) annotation (Line(points={{-240,
          184},{-218,184},{-218,148},{-10,148},{-10,152}},
                                                      color={0,0,127}));
  connect(TRooSetCooNum[5], TRooErrCooCor.u2) annotation (Line(points={{-240,
          188},{-218,188},{-218,148},{30,148},{30,152}},
                                                    color={0,0,127}));
  connect(preCooSta.y, t9.condition) annotation (Line(points={{-119,-150},{-80,-150},
          {-80,-142}}, color={255,0,255}));
  connect(t10.outPort, unOccNigSetUp.inPort[1])
    annotation (Line(points={{81.5,-20},{90,-20},{90,-20.25},{99,-20.25}},
                                                   color={0,0,0}));
  connect(unOccOff.outPort[5], t10.inPort) annotation (Line(points={{0.5,30.2},
          {12,30.2},{12,4},{68,4},{68,-20},{76,-20}},color={0,0,0}));
  connect(unOccNigSetUp.y, sum.u[7]) annotation (Line(points={{121,-26},{124,
          -26},{124,-36},{-210,-36},{-210,141.8},{-192,141.8}},
                                                           color={255,127,0}));
  connect(unOccNigSetUp.active, or1.u[5]) annotation (Line(points={{110,-31},{
          110,-44},{154,-44},{154,2.8},{170,2.8}},
                                                 color={255,0,255}));
  connect(unOccNigSetUp.active, or2.u[3]) annotation (Line(points={{110,-31},{
          110,-37.6667},{170,-37.6667}},
                                     color={255,0,255}));
  connect(t11.outPort, unOccOff.inPort[4]) annotation (Line(points={{78.5,64},{
          -24,64},{-24,30.375},{-21,30.375}},
                                        color={0,0,0}));
  connect(t11.inPort, unOccNigSetUp.outPort[1]) annotation (Line(points={{84,64},
          {122,64},{122,-20.1667},{120.5,-20.1667}}, color={0,0,0}));
  connect(unOccNigSetUp.outPort[2], t12.inPort) annotation (Line(points={{120.5,
          -20},{126,-20},{126,-128},{122,-128}}, color={0,0,0}));
  connect(t12.outPort, morPreCoo.inPort[2]) annotation (Line(points={{116.5,
          -128},{62,-128},{62,-114},{-46,-114},{-46,-129.75},{-41,-129.75}},
                                                                     color={0,0,
          0}));
  connect(preCooSta.y, t12.condition) annotation (Line(points={{-119,-150},{118,
          -150},{118,-140}}, color={255,0,255}));
  connect(occupied.y, t13.condition) annotation (Line(points={{-59,90},{-50,90},
          {-50,-40},{100,-40},{100,-84},{112,-84},{112,-78}}, color={255,0,255}));
  connect(unOccNigSetUp.outPort[3], t13.inPort) annotation (Line(points={{120.5,
          -19.8333},{126,-19.8333},{126,-66},{116,-66}}, color={0,0,0}));
  connect(t13.outPort, occ.inPort[4]) annotation (Line(points={{110.5,-66},{56,
          -66},{56,-89.625},{59,-89.625}},
                                    color={0,0,0}));
  connect(cb.TRooMin, TRooMin.u) annotation (Line(
      points={{-158,140},{-120,140},{-120,60},{-82,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(booSetBack.y, t2.condition) annotation (Line(points={{2,-10},{20,-10},
          {20,14},{38,14},{38,18}}, color={255,0,255}));
  connect(booSetUp.y, t10.condition) annotation (Line(points={{2,-24},{24,-24},
          {24,-44},{80,-44},{80,-32}}, color={255,0,255}));
  connect(t14.outPort, unOccNigSetBac.inPort[2]) annotation (Line(points={{118.5,
          100},{60,100},{60,30.25},{79,30.25}},     color={0,0,0}));
  connect(t14.inPort, occ.outPort[2]) annotation (Line(points={{124,100},{144,
          100},{144,-90},{80.5,-90}}, color={0,0,0}));
  connect(t15.outPort, unOccNigSetUp.inPort[2]) annotation (Line(points={{128.5,
          60},{116,60},{116,-2},{94,-2},{94,-19.75},{99,-19.75}},
                                                                color={0,0,0}));
  connect(t15.inPort, occ.outPort[3]) annotation (Line(points={{134,60},{142,60},
          {142,-89.8333},{80.5,-89.8333}}, color={0,0,0}));
  connect(initialStepWithSignal.outPort[1], start.inPort)
    annotation (Line(points={{-59.5,30},{-44,30}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-220,
            -220},{220,220}})), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-220,-220},{220,220}}), graphics={
          Rectangle(
          extent={{-220,220},{220,-220}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={215,215,215}), Text(
          extent={{-176,80},{192,-84}},
          lineColor={0,0,255},
          textString="%name")}));
end ModeSelector;
