within BuildingControlEmulator.Devices.FlowMover.Control;
model VAVDualFanControl
  import BuildingControlEmulator;
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time waitTime(min=0) = 0
    "Wait time before transition fires";
  parameter Real SpeRat
      "Speed ratio";
  BuildingControlEmulator.Devices.FlowMover.Control.CyclingOn cyclingOn(waitTime=
        waitTime)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  BuildingControlEmulator.Devices.Control.conPI variableSpeed(
    yMin=0.3,                                                 k=k, Ti=Ti,
    conPID(y_reset=1))
    annotation (Placement(transformation(extent={{-60,36},{-40,56}})));
  Modelica.Blocks.Interfaces.BooleanInput On
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput Mea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Math.Gain gain(k=SpeRat)
    annotation (Placement(transformation(extent={{84,-44},{92,-36}})));
  BuildingControlEmulator.Devices.Control.Constant constantSpeed
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Interfaces.RealOutput ySup "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,28},{120,48}})));
  Modelica.Blocks.Interfaces.RealOutput yRet "Output signal connector"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput CyclingOn
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveSpeSup
    annotation (Placement(transformation(extent={{14,72},{30,88}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite ovePreSetPoi
    annotation (Placement(transformation(extent={{-70,-88},{-54,-72}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch swi
    annotation (Placement(transformation(extent={{12,28},{32,48}})));
  Buildings.Controls.OBC.CDL.Continuous.LimitSlewRate ramLim(raisingSlewRate=1/
        120) "Ramp limiter for fan control signal"
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Limiter lim(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{66,70},{86,90}})));
  Modelica.Blocks.Sources.BooleanExpression
                                         booleanExpression(y=On)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
equation
  connect(variableSpeed.On, On) annotation (Line(
      points={{-62,52},{-80,52},{-80,60},{-120,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(variableSpeed.Mea, Mea) annotation (Line(
      points={{-62,40},{-70,40},{-70,-20},{-120,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cyclingOn.OnSigOut, constantSpeed.On) annotation (Line(points={{-39,-30},
          {-22,-30}},             color={255,0,255}));
  connect(gain.y, yRet) annotation (Line(
      points={{92.4,-40},{110,-40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cyclingOn.CyclingOn, CyclingOn) annotation (Line(
      points={{-62,-30},{-80,-30},{-80,-60},{-120,-60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(not1.u, On) annotation (Line(
      points={{-64,10},{-80,10},{-80,60},{-120,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(not1.y, cyclingOn.OnSigIn) annotation (Line(
      points={{-41,10},{-24,10},{-24,-8},{-80,-8},{-80,-26},{-62,-26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(SetPoi, ovePreSetPoi.u) annotation (Line(
      points={{-120,20},{-86,20},{-86,-80},{-71.6,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ovePreSetPoi.y, variableSpeed.SetPoi) annotation (Line(
      points={{-53.2,-80},{-32,-80},{-32,30},{-74,30},{-74,46},{-62,46}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(variableSpeed.y, swi.u1)
    annotation (Line(points={{-39,46},{10,46}}, color={0,0,127}));
  connect(constantSpeed.y, swi.u3) annotation (Line(points={{1,-30},{4,-30},{4,
          30},{10,30}}, color={0,0,127}));
  connect(gain.u, ySup) annotation (Line(points={{83.2,-40},{76,-40},{76,38},{
          110,38}},                 color={0,0,127}));
  connect(ramLim.u, oveSpeSup.y)
    annotation (Line(points={{38,80},{30.8,80}}, color={0,0,127}));
  connect(ramLim.y, lim.u)
    annotation (Line(points={{62,80},{64,80}}, color={0,0,127}));
  connect(booleanExpression.y, swi.u2) annotation (Line(points={{-19,70},{2,70},
          {2,38},{10,38}}, color={255,0,255}));
  connect(lim.y, ySup) annotation (Line(points={{88,80},{94,80},{94,38},{110,38}},
        color={0,0,127}));
  connect(oveSpeSup.u, swi.y) annotation (Line(points={{12.4,80},{8,80},{8,56},
          {40,56},{40,38},{34,38}}, color={0,0,127}));
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
          textString="VAVDualFanControl")}), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(
      StartTime=15638400,
      StopTime=16243200,
      __Dymola_NumberOfIntervals=1440,
      __Dymola_Algorithm="Cvode"));
end VAVDualFanControl;
