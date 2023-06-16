within BuildingControlEmulator.Devices.AirSide.Coil.Control;
model OnOffSta
  parameter Modelica.Units.SI.Time minOffTim(min=0) = 0 "Minimum off time";
  parameter Modelica.Units.SI.Time minOnTim(min=0) = 0 "Minimum on time";
  parameter Real dT
      "Temperature control deadband";
  Modelica.Units.SI.Time OffTim(start=0);
  Modelica.Units.SI.Time OnTim(start=0);


  Modelica.StateGraph.StepWithSignal On(nOut=2, nIn=1)
                                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={34,-44})));
  Modelica.StateGraph.InitialStepWithSignal Off(nIn=2, nOut=1)
                                                annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={34,42})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-40})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={34,0})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal2(enableTimer=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-40,60})));
  Modelica.Blocks.Interfaces.BooleanOutput OnSigOut
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput OnSigIn
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Interfaces.RealInput Mea "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=(Mea > SetPoi
         + dT) and (time - OffTim) > minOffTim and OnSigIn)
    annotation (Placement(transformation(extent={{-78,10},{-58,30}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=(Mea < SetPoi -
        dT) and (time - OnTim) > minOnTim)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));


equation
    when OnSigOut==false then
        OffTim = time;
    end when;
    when OnSigOut==true then
        OnTim = time;
    end when;
  connect(transitionWithSignal.inPort,On. outPort[1]) annotation (Line(
      points={{-6.66134e-016,-44},{-6.66134e-016,-80},{33.75,-80},{33.75,-54.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal.outPort,Off. inPort[1]) annotation (Line(
      points={{4.44089e-016,-38.5},{0,-38.5},{0,60},{33.5,60},{33.5,53}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(Off.outPort[1],transitionWithSignal1. inPort) annotation (Line(
      points={{34,31.5},{34,20},{34,4}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal1.outPort,On. inPort[1]) annotation (Line(
      points={{34,-1.5},{34,-12},{34,-33}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(On.active,OnSigOut)  annotation (Line(
      points={{45,-44},{45,-44},{60,-44},{60,0},{110,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal2.inPort,On. outPort[2]) annotation (Line(
      points={{-40,56},{-40,56},{-40,42},{-40,36},{-40,-94},{34.25,-94},{34.25,-54.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal2.outPort,Off. inPort[2]) annotation (Line(
      points={{-40,61.5},{-40,61.5},{-40,80},{34,80},{34,66},{34.5,66},{34.5,53}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(transitionWithSignal2.condition, not1.y) annotation (Line(
      points={{-52,60},{-56,60},{-59,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(not1.u, OnSigIn) annotation (Line(
      points={{-82,60},{-88,60},{-94,60},{-120,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpression.y, transitionWithSignal1.condition) annotation (
      Line(points={{-57,20},{-20,20},{-20,0},{22,0}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpression1.y, transitionWithSignal.condition) annotation (
      Line(points={{-59,-60},{-26,-60},{-26,-40},{-12,-40}}, color={255,0,255},
      pattern=LinePattern.Dash));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-52,22},{52,-30}},
          lineColor={0,127,255},
          lineThickness=1,
          textString="ON")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end OnOffSta;
