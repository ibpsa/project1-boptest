within DetachedHouse_ENGIE_IBPSAP1.Construction.Ventilation;
model Ventil_2

  package MediumA = Buildings.Media.Air "Medium model";

  parameter Real d_air = 1.225 "Densité de l'air (en kg.m^3)";

  parameter Real Qventil_permeabilite = 6.92
    "Débit du à la perméabilité des parois (en m3/h/m2)";

  parameter Real Se = 400
    "Surface des parois donnant sur l'extérieur (en m2)";

  Modelica.Blocks.Sources.Constant Ventil_permeabilite(k=Qventil_permeabilite*
        d_air/3600) "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-24,56},{-20,60}})));
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
  Buildings.Fluid.Sources.Outside     bou(
    nPorts=1,
    redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{10,24},{22,36}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports1[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,18},{46,44}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports3[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,48},{46,74}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-72,28},{-52,48}}), iconTransformation(extent={
            {-80,24},{-60,44}})));
equation
  connect(gain_permeabilite_debit.u, Ventil_permeabilite.y) annotation (Line(
      points={{-14.4,58},{-19.8,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinInf_permeabilite.m_flow_in, gain_permeabilite_debit.y) annotation (
     Line(
      points={{8,54.6},{0,54.6},{0,58},{-9.8,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinInf_permeabilite.ports[1:1], ports3) annotation (Line(
      points={{22,49},{32,49},{32,61},{42,61}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1:1], ports1) annotation (Line(
      points={{22,30},{32,30},{32,31},{42,31}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(weaBus.TDryBul, sinInf_permeabilite.T_in) annotation (Line(
      points={{-62,38},{-28,38},{-28,51.8},{6.6,51.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
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
<p>La perm&eacute;abilit&eacute; de la pi&egrave;ce est &eacute;galement cacul&eacute;e, d&eacute;finie par un flux d&apos;air avec : </p>
<ul>
<li>un d&eacute;bit d&eacute;pendant de la surface des parois susceptibles de subir une permabilit&eacute; par rapport &agrave; l&apos;ext&eacute;rieur :</li>
<p><img src=\"modelica://Construction/Resources/Images/equations/equation-jrpJI5Yq.png\" alt=\"Q=Qventil_permeabilite*S_e\"/></p>
<li>une temp&eacute;rature correspondant &agrave; la temp&eacute;rature ext&eacute;rieure</li>
</ul>
</html>"));
end Ventil_2;
