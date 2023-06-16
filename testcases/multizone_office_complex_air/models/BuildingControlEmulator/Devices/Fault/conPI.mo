within BuildingControlEmulator.Devices.Fault;
model conPI "\"PI Controller\""

  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Real fauFac = 10 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";

  Modelica.Blocks.Interfaces.BooleanInput On
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-72,50},{-52,70}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Continuous.PI PI(k=k*fauFac, T=Ti/fauFac)
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Mea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Math.Add add(k1=conPID.revAct, k2=-conPID.revAct)
    annotation (Placement(transformation(extent={{-54,-30},{-34,-10}})));
  BaseClasses.PIreverse conPID
    annotation (Placement(transformation(extent={{-48,6},{-28,26}})));
equation
  connect(On, booleanToReal.u) annotation (Line(
      points={{-120,60},{-90,60},{-74,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(PI.y, product.u2) annotation (Line(
      points={{13,-20},{28,-20},{28,-6},{38,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanToReal.y, product.u1) annotation (Line(
      points={{-51,60},{28,60},{28,6},{38,6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(product.y, y) annotation (Line(
      points={{61,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(SetPoi, add.u1) annotation (Line(points={{-120,0},{-70,0},{-70,-14},{-56,
          -14}}, color={0,0,127}));
  connect(add.u2, Mea) annotation (Line(points={{-56,-26},{-70,-26},{-70,-60},{-120,
          -60}}, color={0,0,127}));
  connect(add.y, PI.u)
    annotation (Line(points={{-33,-20},{-10,-20}}, color={0,0,127}));
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
          textString="PI")}),            Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end conPI;
