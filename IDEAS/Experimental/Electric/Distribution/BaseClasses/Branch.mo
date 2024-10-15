within IDEAS.Experimental.Electric.Distribution.BaseClasses;
model Branch

  extends Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort(i(
        re(start=0), im(start=0)));
  Modelica.SIunits.ActivePower Plos;

  parameter Boolean heatLosses=false "Set to true to calculate heatlosses";
  parameter Modelica.SIunits.Resistance R=0.0057;
  parameter Modelica.SIunits.Reactance X=0.0039;
  final parameter Modelica.SIunits.ComplexImpedance Z=Complex(R, X);

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a if heatLosses annotation (
      Placement(transformation(extent={{10,10},{30,30}}), iconTransformation(
          extent={{10,10},{30,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow if heatLosses
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-10})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Plos) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-50})));
equation
  v = Z*i;
  Plos = R*Modelica.ComplexMath.'abs'(i)^2;

  connect(port_a, prescribedHeatFlow.port) annotation (Line(
      points={{20,20},{20,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(realExpression.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{20,-39},{20,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Rectangle(
          extent={{-34,14},{46,-16}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,20},{40,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{40,0},{100,0}}, color={0,0,0}),
        Line(points={{-100,0},{-40,0}}, color={0,0,0})}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end Branch;
