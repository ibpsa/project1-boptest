within DetachedHouse_ENGIE_IBPSAP1.Construction.Apports;
model Q_conv_3

  parameter Real Q_occupant = 70
    "Apport thermique par occupant en été (en W/occupant)";
  parameter Real N_occupants = 1/20
    "Nombre d'occupants au m2 (en Occupant/m2)";

  Modelica.Blocks.Math.Gain gain(k=0.5*N_occupants)
    annotation (Placement(transformation(extent={{8,64},{20,76}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv "Output signal connector"
    annotation (Placement(transformation(extent={{100,54},{132,86}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{64,60},{84,80}})));
  Modelica.Blocks.Interfaces.RealInput Occupation "Input signal connector"
    annotation (Placement(transformation(extent={{-52,54},{-20,86}}),
        iconTransformation(extent={{-44,62},{-20,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Q_occupant)
    annotation (Placement(transformation(extent={{18,78},{38,98}})));
equation
  connect(product.y, Q_conv)
    annotation (Line(points={{85,70},{116,70}},          color={0,0,127}));
  connect(product.u2, gain.y)
    annotation (Line(points={{62,64},{42,64},{42,70},{20.6,70}},
                                                           color={0,0,127}));
  connect(gain.u, Occupation) annotation (Line(points={{6.8,70},{-10,70},{-36,70}},
                         color={0,0,127}));
  connect(realExpression.y, product.u1) annotation (Line(points={{39,88},{46,88},
          {46,76},{62,76}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-20,20},{
            100,120}})),
    Icon(coordinateSystem(extent={{-20,20},{100,120}})),
    Documentation(info="<html>
<h4>Calcul d&apos;un flux de transfert convectif</h4>
<p>Ce flux d&eacute;pend : </p>
<ul>
<li>des occupants (&agrave; 50&percnt;) en tenant compte d&apos;un certain foisonnement pour prendre en compte les vacances</li>
<li>de l&apos;occupation g&eacute;n&eacute;rale du b&acirc;timent</li>
</ul>
<p><u>Formule de calcul</u></p>
<p><img src=\"modelica://Construction/Resources/Images/equations/equation-ZyHKZXuR.png\" alt=\"Q_rad = 0.5*N_occupants*Foisonnement*Q_occupant*Occupation\"/></p>
<p><br>Q_occupant est calcul&eacute; en fonction de la p&eacute;riode de chauffe. En fonction de la saison, la valeur sera respectivement Q_occupant_ete ou Q_occupant_hiver.</p>
</html>"));
end Q_conv_3;
