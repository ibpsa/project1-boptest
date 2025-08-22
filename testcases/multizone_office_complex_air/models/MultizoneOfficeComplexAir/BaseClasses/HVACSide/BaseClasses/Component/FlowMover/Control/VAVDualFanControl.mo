within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Control;
model VAVDualFanControl "Supply fan speed controller"
  import BuildingControlEmulator =
         MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component;
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time waitTime(min=0) = 0
    "Wait time before transition fires";

  BuildingControlEmulator.FlowMover.Control.CyclingOn cyclingOn(waitTime=
        waitTime)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  BuildingControlEmulator.conPI variableSpeed(
    yMin=0.3,
    k=k,
    Ti=Ti,
    conPID(y_reset=1))
    annotation (Placement(transformation(extent={{-60,36},{-40,56}})));
  Modelica.Blocks.Interfaces.BooleanInput onFanOcc
    "Fan On signal during occupied period"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput Mea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealOutput ySup "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput onFanUnocc
    "Fan On signal during unoccupied period"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch swi
    annotation (Placement(transformation(extent={{12,28},{32,48}})));
  Modelica.Blocks.Math.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(variableSpeed.On, onFanOcc) annotation (Line(points={{-62,52},{-80,52},
          {-80,60},{-120,60}}, color={255,0,255}));
  connect(variableSpeed.mea, Mea) annotation (Line(
      points={{-62,40},{-70,40},{-70,-20},{-120,-20}},
      color={0,0,127}));
  connect(cyclingOn.CyclingOn, onFanUnocc) annotation (Line(points={{-62,-30},{
          -80,-30},{-80,-60},{-120,-60}}, color={255,0,255}));
  connect(not1.u, onFanOcc) annotation (Line(points={{-64,10},{-80,10},{-80,60},
          {-120,60}}, color={255,0,255}));
  connect(not1.y, cyclingOn.OnSigIn) annotation (Line(
      points={{-41,10},{-22,10},{-22,-8},{-78,-8},{-78,-26},{-62,-26}},
      color={255,0,255}));
  connect(variableSpeed.y, swi.u1)
    annotation (Line(points={{-39,46},{10,46}}, color={0,0,127}));
  connect(SetPoi, variableSpeed.set) annotation (Line(points={{-120,20},
          {-74,20},{-74,46},{-62,46}}, color={0,0,127}));
  connect(onFanOcc, swi.u2) annotation (Line(points={{-120,60},{-80,60},{-80,28},
          {-20,28},{-20,38},{10,38}}, color={255,0,255}));
  connect(cyclingOn.OnSigOut, booToRea.u)
    annotation (Line(points={{-39,-30},{-22,-30}}, color={255,0,255}));
  connect(booToRea.y, swi.u3) annotation (Line(points={{1,-30},{6,-30},{6,
          30},{10,30}}, color={0,0,127}));
  connect(swi.y, ySup) annotation (Line(points={{34,38},{60,38},{60,0},{110,0}},
        color={0,0,127}));
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
          textString="VAVDualFanControl"),
        Text(
          extent={{-154,102},{146,142}},
          textString="%name",
          textColor={0,0,255})}),            Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(
      StartTime=15638400,
      StopTime=16243200,
      __Dymola_NumberOfIntervals=1440,
      __Dymola_Algorithm="Cvode"),
    Documentation(info="<html>

</html>"));
end VAVDualFanControl;
