within BuildingControlEmulator.Devices.FlowMover.Control;
model CyclingOn
  "\"Controller for constant speed fans or pumps\""
  parameter Modelica.Units.SI.Time waitTime(min=0) = 0
    "Wait time before transition fires";

  Modelica.StateGraph.StepWithSignal On(nOut=2, nIn=1)
                                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={56,-44})));
  Modelica.StateGraph.InitialStepWithSignal Off(nIn=2, nOut=1)
                                                annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={54,42})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-80,72},{-60,92}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer=true, waitTime=
       waitTime)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-40})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={54,0})));
  Modelica.Blocks.Interfaces.BooleanInput CyclingOn
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Interfaces.BooleanOutput OnSigOut
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput OnSigIn
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal2(waitTime=
        waitTime, enableTimer=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-22,48})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-60,38},{-40,58}})));
equation
  connect(transitionWithSignal.inPort, On.outPort[1]) annotation (Line(
      points={{-6.66134e-016,-44},{-6.66134e-016,-80},{55.75,-80},{55.75,-54.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal.outPort, Off.inPort[1]) annotation (Line(
      points={{2.22045e-016,-38.5},{0,-38.5},{0,60},{53.5,60},{53.5,53}},
      color={0,0,0},
      pattern=LinePattern.Dash));

  connect(Off.outPort[1], transitionWithSignal1.inPort) annotation (Line(
      points={{54,31.5},{54,20},{54,4}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal1.outPort, On.inPort[1]) annotation (Line(
      points={{54,-1.5},{54,-12},{54,-33},{56,-33}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(not1.y, transitionWithSignal.condition) annotation (Line(
      points={{-39,-40},{-12,-40}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(not1.u, CyclingOn) annotation (Line(
      points={{-62,-40},{-96,-40},{-96,0},{-120,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(On.active, OnSigOut) annotation (Line(
      points={{67,-44},{67,-44},{80,-44},{80,0},{110,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(and1.u1, OnSigIn) annotation (Line(
      points={{-62,0},{-86,0},{-86,40},{-120,40}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(and1.u2, CyclingOn) annotation (Line(
      points={{-62,-8},{-90,-8},{-90,0},{-120,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(and1.y, transitionWithSignal1.condition) annotation (Line(
      points={{-39,0},{-39,0},{-8,0},{42,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal2.inPort, On.outPort[2]) annotation (Line(
      points={{-22,44},{-22,44},{-22,42},{-22,36},{-22,-96},{56.25,-96},{56.25,
          -54.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal2.outPort, Off.inPort[2]) annotation (Line(
      points={{-22,49.5},{-22,49.5},{-22,74},{54.5,74},{54.5,53}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(OnSigIn, not2.u) annotation (Line(
      points={{-120,40},{-86,40},{-86,48},{-62,48}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(not2.y, transitionWithSignal2.condition) annotation (Line(
      points={{-39,48},{-39,48},{-34,48}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-66,50},{62,-48}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="CyclingControl")}),Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end CyclingOn;
