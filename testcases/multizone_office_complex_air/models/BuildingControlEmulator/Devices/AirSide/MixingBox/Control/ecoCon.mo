within BuildingControlEmulator.Devices.AirSide.MixingBox.Control;
model ecoCon
  import BuildingControlEmulator;
  parameter Modelica.Units.SI.Temperature TemHig
    "the highest temeprature when the economizer is on";
  parameter Modelica.Units.SI.Temperature TemLow
    "the lowest temeprature when the economizer is on";
   parameter Real DamMin "the minimum damper postion";
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";

  BuildingControlEmulator.Devices.Control.conPI pI(
    k=k,
    Ti=Ti,
    reverseActing=false,
    conPID(y_reset=1))
    annotation (Placement(transformation(extent={{10,2},{30,22}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Mea "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Sources.BooleanExpression integerExpression(y=(Tout <= TemHig)
         and (Tout > TemLow))                                                 annotation (Placement(transformation(extent={{-80,30},
            {-60,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=DamMin) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.Math.Max max annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput Tout
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.LimitSlewRate ramLim(raisingSlewRate=1/
        120) "Ramp limiter for fan control signal"
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Limiter lim(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{68,-60},{88,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch swi
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{-34,-68},{-14,-48}})));
equation
  connect(pI.SetPoi, SetPoi)
    annotation (Line(
      points={{8,12},{8,10},{-60,10},{-60,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pI.Mea, Mea) annotation (Line(
      points={{8,6},{8,4},{-40,4},{-40,-80},{-120,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(integerExpression.y, pI.On) annotation (Line(points={{-59,40},{-59,40},
          {0,40},{0,18},{8,18}},                                                                        color={255,0,255}));
  connect(pI.y, max.u1) annotation (Line(points={{31,12},{40,12},{40,6},{50,6}}, color={0,0,127}));
  connect(max.u2, realExpression.y) annotation (Line(points={{50,-6},{40,-6},{40,-20},{31,-20}}, color={0,0,127}));
  connect(ramLim.y, lim.u)
    annotation (Line(points={{62,-50},{66,-50}}, color={0,0,127}));
  connect(swi.y, ramLim.u)
    annotation (Line(points={{22,-50},{38,-50}}, color={0,0,127}));
  connect(On, swi.u2) annotation (Line(points={{-120,80},{-20,80},{-20,-50},{-2,
          -50}}, color={255,0,255}));
  connect(max.y, swi.u1) annotation (Line(points={{73,0},{88,0},{88,-28},{-12,
          -28},{-12,-42},{-2,-42}}, color={0,0,127}));
  connect(realExpression1.y, swi.u3)
    annotation (Line(points={{-13,-58},{-2,-58}}, color={0,0,127}));
  connect(lim.y, y) annotation (Line(points={{90,-50},{96,-50},{96,0},{110,0}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-34,26},{38,-34}},
          lineColor={0,127,255},
          lineThickness=1,
          textString="Eco")}),                                   Diagram(coordinateSystem(preserveAspectRatio=false)));
end ecoCon;
