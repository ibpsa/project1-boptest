within MultiZoneResidentialHydronic.Building.Gains;
model Q_conv_3

  parameter Real Q_occupant = 70
    "Summer heat gain per occupant (W/occupant)";
  parameter Real N_occupants = 1/20
    "Number of occupants per m2 (occupant/m2)";

  Modelica.Blocks.Math.Gain gain(k=0.5*N_occupants)
    annotation (Placement(transformation(extent={{8,64},{20,76}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv "Output signal connector"
    annotation (Placement(transformation(extent={{100,54},{132,86}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{56,60},{76,80}})));
  Modelica.Blocks.Interfaces.RealInput Occupation "Input signal connector"
    annotation (Placement(transformation(extent={{-52,54},{-20,86}}),
        iconTransformation(extent={{-44,62},{-20,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Q_occupant)
    annotation (Placement(transformation(extent={{18,78},{38,98}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaConOcc(
    description="Convective heat gains",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="W/m2"))
    annotation (Placement(transformation(extent={{88,92},{98,102}})));
equation
  connect(product.y, Q_conv)
    annotation (Line(points={{77,70},{116,70}},          color={0,0,127}));
  connect(product.u2, gain.y)
    annotation (Line(points={{54,64},{42,64},{42,70},{20.6,70}},
                                                           color={0,0,127}));
  connect(gain.u, Occupation) annotation (Line(points={{6.8,70},{-10,70},{-36,70}},
                         color={0,0,127}));
  connect(realExpression.y, product.u1) annotation (Line(points={{39,88},{46,88},
          {46,76},{54,76}}, color={0,0,127}));
  connect(product.y, reaConOcc.u) annotation (Line(points={{77,70},{80,70},{80,
          97},{87,97}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-20,20},{
            100,120}})),
    Icon(coordinateSystem(extent={{-20,20},{100,120}})),
    Documentation(info="<html>
<h4>Convective heat transfert </h4>
<p>It depends of : </p>
<ul>
<li>a simultaneity factor (50&percnt;)</li>
<li>the general occupation of the building</li>
<li></li>
</ul>
</html>"));
end Q_conv_3;
