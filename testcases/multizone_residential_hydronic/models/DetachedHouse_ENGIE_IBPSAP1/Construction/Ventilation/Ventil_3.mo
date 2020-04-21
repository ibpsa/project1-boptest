within DetachedHouse_ENGIE_IBPSAP1.Construction.Ventilation;
model Ventil_3

  package MediumA = Buildings.Media.Air "Medium model";

  parameter Real d_air = 1.225 "Densité de l'air (en kg.m^3)";

  parameter Real Qventil_occupation = 7261
    "Débit de ventilation en période d'occupation (en m^3/h)";
  parameter Real Qventil_innoccupation = 315
    "Débit de ventilation en période d'innoccupation (en m^3/h)";
  parameter Real Qventil_permeabilite = 1.7
    "Débit du à la perméabilité des parois (en m3/h/m2)";

  parameter Real eff_ech = 0.5
    "Efficacité de l'échangeur de la ventilation double flux";

  parameter Real S = 100 "Surface au sol de la zone considérée (en m2)";
  parameter Real S_tot = 7000 "Surface au sol totale du bâtiment (en m2)";
  parameter Real Se = 400
    "Surface des parois donnant sur l'extérieur (en m2)";

  Modelica.Blocks.Sources.Constant Ventil_occupation(k=Qventil_occupation*d_air/
        3600) "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-42,92},{-38,96}})));
  Modelica.Blocks.Sources.Constant Ventil_innocupation(k=Qventil_innoccupation*
        d_air/3600) "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-42,82},{-38,86}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-30,86},{-24,92}})));
  Modelica.Blocks.Sources.Constant Ventil_permeabilite(k=Qventil_permeabilite*
        d_air/3600) "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-24,56},{-20,60}})));
  Buildings.Fluid.Sources.MassFlowSource_T sinInf_ventilation(
    m_flow=1,
    use_m_flow_in=true,
    use_X_in=false,
    use_C_in=false,
    nPorts=1,
    use_T_in=true,
    redeclare package Medium = MediumA,
    T=293.15) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{8,64},{22,78}})));
  Modelica.Blocks.Math.Gain gain_ventilation_debit(k=S/S_tot)
    annotation (Placement(transformation(extent={{-14,90},{-10,94}})));
  Modelica.Blocks.Math.Gain gain_permeabilite_debit(k=Se)
    annotation (Placement(transformation(extent={{-14,56},{-10,60}})));
  Buildings.Fluid.Sources.MassFlowSource_T sinInf_permeabilite(
    m_flow=1,
    use_m_flow_in=true,
    use_X_in=false,
    use_C_in=false,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = MediumA,
    T=293.15) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{8,42},{22,56}})));
public
  Modelica.Blocks.Math.Gain gain_ventilation_efficacite(k=eff_ech)
    annotation (Placement(transformation(extent={{-18,74},{-14,78}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-30,74},{-26,78}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-8,66},{-2,72}})));
  Modelica.Blocks.Interfaces.RealInput T "Température de la pièce"
    annotation (Placement(transformation(extent={{-76,58},{-60,74}})));
  Buildings.Fluid.Sources.Outside     bou(
    nPorts=1,
    redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{10,24},{22,36}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports1[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,18},{46,44}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports2[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,78},{46,104}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports3[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,48},{46,74}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-72,28},{-52,48}}), iconTransformation(extent={
            {-80,24},{-60,44}})));
  Modelica.Blocks.Interfaces.BooleanInput Occupation
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-76,80},{-60,96}})));
equation
  connect(Ventil_occupation.y, switch1.u1) annotation (Line(
      points={{-37.8,94},{-34.85,94},{-34.85,91.4},{-30.6,91.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch1.u3, Ventil_innocupation.y) annotation (Line(
      points={{-30.6,86.6},{-34.6,86.6},{-34.6,84},{-37.8,84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain_ventilation_debit.u, switch1.y) annotation (Line(
      points={{-14.4,92},{-22,92},{-22,89},{-23.7,89}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain_permeabilite_debit.u, Ventil_permeabilite.y) annotation (Line(
      points={{-14.4,58},{-19.8,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinInf_permeabilite.m_flow_in, gain_permeabilite_debit.y) annotation (
     Line(
      points={{8,54.6},{0,54.6},{0,58},{-9.8,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinInf_ventilation.m_flow_in, gain_ventilation_debit.y) annotation (
      Line(
      points={{8,76.6},{0,76.6},{0,92},{-9.8,92}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.y, sinInf_ventilation.T_in) annotation (Line(
      points={{-1.7,69},{2.15,69},{2.15,73.8},{6.6,73.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain_ventilation_efficacite.y, add1.u1) annotation (Line(
      points={{-13.8,76},{-12,76},{-12,70.8},{-8.6,70.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, gain_ventilation_efficacite.u) annotation (Line(
      points={{-25.8,76},{-18.4,76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u1, T) annotation (Line(
      points={{-30.4,77.2},{-42,77.2},{-42,78},{-52,78},{-52,66},{-68,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinInf_ventilation.ports[1:1], ports2) annotation (Line(
      points={{22,71},{32,71},{32,91},{42,91}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sinInf_permeabilite.ports[1:1], ports3) annotation (Line(
      points={{22,49},{32,49},{32,61},{42,61}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1:1], ports1) annotation (Line(
      points={{22,30},{32,30},{32,31},{42,31}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(weaBus.TDryBul, add.u2) annotation (Line(
      points={{-62,38},{-46,38},{-46,74.8},{-30.4,74.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, add1.u2) annotation (Line(
      points={{-62,38},{-36,38},{-36,67.2},{-8.6,67.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, sinInf_permeabilite.T_in) annotation (Line(
      points={{-62,38},{-28,38},{-28,51.8},{6.6,51.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(switch1.u2, Occupation) annotation (Line(points={{-30.6,89},{-68,
          89},{-68,88}}, color={255,0,255}));
  connect(weaBus, bou.weaBus) annotation (Line(
      points={{-62,38},{-28,38},{-28,30.12},{10,30.12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,20},{40,
            100}})),
    Icon(coordinateSystem(extent={{-60,20},{40,100}}, preserveAspectRatio=false),
        graphics),
    Documentation(info="<html>
<h4>Ventilation</h4>
<p>G&eacute;n&eacute;ration de la ventilation dans une pi&egrave;ce.</p>
<p>Une ventilation g&eacute;n&eacute;r&eacute;e par un &eacute;changeur double-flux est prise en compte, d&eacute;finie par un flux d&apos;air avec : </p>
<ul>
<li>un d&eacute;bit d&eacute;pendant d&apos;un d&eacute;bit bas&eacute; sur l&apos;occupation (Q_ventil_occupation ou Q_ventil_innoccupation), de la surface de la pi&egrave;ce et du nombre d&apos;occupants dans la pi&egrave;ce :</li>
<p><img src=\"modelica://Construction/Resources/Images/equations/equation-QCc6wR1M.png\" alt=\"Q=Q_ventil*S*N_occupants
\"/></p>
<li>une temp&eacute;rature respectant une efficacit&eacute; d&apos;&eacute;changeur selon l&apos;&eacute;quation suivante :</li>
</ul>
<p><img src=\"modelica://Construction/Resources/Images/equations/equation-1qdAiL2W.png\" alt=\"eta =(T-T_ext)/(T_piece-T_ext)\"/></p>
<p><br><br>La perm&eacute;abilit&eacute; de la pi&egrave;ce est &eacute;galement cacul&eacute;e, d&eacute;finie par un flux d&apos;air avec : </p>
<ul>
<li>un d&eacute;bit d&eacute;pendant de la surface des parois susceptibles de subir une permabilit&eacute; par rapport &agrave; l&apos;ext&eacute;rieur :</li>
</ul>
<p><img src=\"modelica://Construction/Resources/Images/equations/equation-VdBBEvo4.png\" alt=\"Q=Qventil_permeabilite*S_e\"/></p>
<ul>
<li>une temp&eacute;rature correspondant &agrave; la temp&eacute;rature ext&eacute;rieure</li>
</ul>
</html>"));
end Ventil_3;
