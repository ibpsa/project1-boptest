within DetachedHouse_ENGIE_IBPSAP1.Construction.Apports;
model Q_rad_5

  parameter Real Q_occupant = 70
    "Apport thermique par occupant en été (en W/occupant)";
  parameter Real N_occupants = 1/20
    "Nombre d'occupants au m2 (en Occupant/m2)";

  parameter Real Q_autres = 5.7 "Autre apport thermique interne (en W/m2)";
  parameter Real Q_ecl = 1.12 "Apport dû à l'éclairage (en W/m2)";

  Modelica.Blocks.Math.Gain gain2(k=Q_autres)
    annotation (Placement(transformation(extent={{0,12},{12,24}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{74,44},{94,64}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad "Flux de transfert radiatif"
    annotation (Placement(transformation(extent={{100,52},{156,108}})));

  Modelica.Blocks.Math.Gain gain1(k=0.5*N_occupants)
    annotation (Placement(transformation(extent={{0,88},{12,100}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{42,92},{52,102}})));
  Modelica.Blocks.Math.Gain gain(k=Q_ecl)
    annotation (Placement(transformation(extent={{0,48},{12,60}})));
  Modelica.Blocks.Interfaces.RealInput Occupation "Occupation"
    annotation (Placement(transformation(extent={{-140,74},{-100,114}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Q_occupant)
    annotation (Placement(transformation(extent={{0,100},{20,120}})));
  Modelica.Blocks.Interfaces.RealInput Eclairage "Eclairage"
    annotation (Placement(transformation(extent={{-140,34},{-100,74}})));
  Modelica.Blocks.Interfaces.RealInput Autres "Autres"
    annotation (Placement(transformation(extent={{-140,-2},{-100,38}})));
equation
  connect(add3_1.y, Q_rad) annotation (Line(
      points={{95,54},{96,54},{96,80},{128,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.u2, gain1.y)
    annotation (Line(points={{41,94},{26,94},{12.6,94}},   color={0,0,127}));
  connect(product.y, add3_1.u1) annotation (Line(points={{52.5,97},{62,97},
          {62,84},{62,62},{72,62}}, color={0,0,127}));
  connect(gain.y, add3_1.u2) annotation (Line(points={{12.6,54},{12.6,54},{72,54}},
                        color={0,0,127}));
  connect(gain2.y, add3_1.u3) annotation (Line(points={{12.6,18},{12.6,18},
          {32,18},{40,18},{40,46},{72,46}}, color={0,0,127}));
  connect(gain1.u, Occupation)
    annotation (Line(points={{-1.2,94},{-120,94}}, color={0,0,127}));
  connect(realExpression.y, product.u1) annotation (Line(points={{21,110},{26,110},
          {26,100},{41,100}}, color={0,0,127}));
  connect(Eclairage, gain.u)
    annotation (Line(points={{-120,54},{-1.2,54}}, color={0,0,127}));
  connect(gain2.u, Autres)
    annotation (Line(points={{-1.2,18},{-12,18},{-120,18}}, color={0,0,127}));
  annotation (                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,0},{100,160}})),
    Icon(coordinateSystem(extent={{-100,0},{100,160}})),
    Documentation(info="<html>
<h4>Calcul d&apos;un flux de transfert radiatif</h4>
<p>Ce flux d&eacute;pend : </p>
<ul>
<li>des autres &eacute;quipements (typiquement des ordinateurs) en utilisant un cerain profil de fonctionnement de ces &eacute;quipements</li>
<li>de l&apos;&eacute;clairage en utilisant un certain profil d&apos;&eacute;clairage</li>
<li>des occupants (&agrave; 50&percnt;) en tenant compte d&apos;un certain foisonnement pour prendre en compte les vacances et en utilisant un certain profil d&apos;occupation</li>
<li>de l&apos;occupation g&eacute;n&eacute;rale du b&acirc;timent<br></li>
</ul>
<p><u>Formule de calcul</u></p>
<p><img src=\"modelica://Construction/Resources/Images/equations/equation-3OVTAhtz.png\" alt=\"Q_rad = Q_autres*Autres + Q_ecl*Eclairage + 0.5*N_occupants*Q_occupant*Occupation\"/></p>
</html>"));
end Q_rad_5;
