within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
model ExteriorHeatRadiation
  "longwave radiative heat exchange of an exterior surface with the environment"
  parameter Modelica.SIunits.Area A "Surface area of heat exchange surface";
  parameter Modelica.SIunits.Temperature Tenv_nom = 280
    "Nominal temperature of environment"
    annotation(Dialog(group="Linearisation", enable=linearise));
  parameter Boolean linearise=true "If true, linearise radiative heat transfer";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput Tenv
    "Radiative temperature of the environment"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature block"
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Interfaces.RealInput epsLw
    "Longwave emissivity of the surface"
    annotation (Placement(transformation(extent={{-120,14},{-80,54}})));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.HeatRadiation
    heaRad(
    final R=R,
    final Tzone_nom=Tenv_nom,
    dT_nom=5,
    final linearise=linearise) "Component for computing radiative heat "
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

protected
  parameter Real R(fixed=false);

initial equation
  R=1/(Modelica.Constants.sigma*A*epsLw);

equation
  connect(preTem.port, heaRad.port_b)
    annotation (Line(points={{10,60},{10,0}}, color={191,0,0}));
  connect(heaRad.port_a, port_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={191,0,0}));
  connect(preTem.T, Tenv)
    annotation (Line(points={{-12,60},{-56,60},{-100,60}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(points={{-40,10},{40,10}}, color={191,0,0}),
        Line(points={{-40,10},{-30,16}}, color={191,0,0}),
        Line(points={{-40,10},{-30,4}}, color={191,0,0}),
        Line(points={{-40,-10},{40,-10}}, color={191,0,0}),
        Line(points={{30,-16},{40,-10}}, color={191,0,0}),
        Line(points={{30,-4},{40,-10}}, color={191,0,0}),
        Line(points={{-40,-30},{40,-30}}, color={191,0,0}),
        Line(points={{-40,-30},{-30,-24}}, color={191,0,0}),
        Line(points={{-40,-30},{-30,-36}}, color={191,0,0}),
        Line(points={{-40,30},{40,30}}, color={191,0,0}),
        Line(points={{30,24},{40,30}}, color={191,0,0}),
        Line(points={{30,36},{40,30}}, color={191,0,0}),
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{90,80},{60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{60,80},{60,-80}},
          color={0,0,0},
          thickness=0.5)}), Documentation(info="<html>
<p>
Longwave radiation between the surface and environment 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-AMjoTx5S.png\"/> is determined as
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-nt0agyic.png\"/>as derived from the Stefan-Boltzmann law wherefore 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-C6ZFvd5P.png\"/> the Stefan-Boltzmann constant 
<a href=\"IDEAS.Buildings.UsersGuide.References\">[Mohr 2008]</a>, 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-sLNH0zgx.png\"/> the longwave emissivity of the exterior surface, 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-Q5X4Yht9.png\"/> the radiant-interchange configuration factor between the surface and sky 
<a href=\"IDEAS.Buildings.UsersGuide.References\">[Hamilton 1952]</a>, and the surface and the environment respectively and 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-k2V39u5g.png\"/> and 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-GuSnzLxW.png\"/> are the exterior surface and sky temperature respectively. 
Shortwave solar irradiation absorbed by the exterior surface is determined as 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-cISf3Itz.png\"/>where 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-IKuIUMef.png\"/> is the shortwave absorption of the surface and 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-Vuo4fgcb.png\"/> the total irradiation on the depicted surface.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end ExteriorHeatRadiation;
