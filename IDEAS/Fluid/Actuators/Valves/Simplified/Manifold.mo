within IDEAS.Fluid.Actuators.Valves.Simplified;
model Manifold "Radiant manifold"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (__Dymola_choicesAllMatching=true);
  parameter Boolean[6] open={true,true,true,true,true,true};

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,40},{-90,60}}, rotation=
            0), iconTransformation(extent={{-110,40},{-90,60}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium = Medium)
    if
    open[1] annotation (Placement(transformation(extent={{-48,-50},{-28,-30}},
          rotation=0), iconTransformation(extent={{-80,-50},{-60,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium = Medium)
    if
    open[2] annotation (Placement(transformation(extent={{-30,-50},{-10,-30}},
          rotation=0), iconTransformation(extent={{-40,-50},{-20,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium = Medium)
    if
    open[3] annotation (Placement(transformation(extent={{-10,-50},{10,-30}},
          rotation=0), iconTransformation(extent={{0,-50},{20,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b4(redeclare package Medium = Medium)
    if
    open[4] annotation (Placement(transformation(extent={{10,-50},{30,-30}},
          rotation=0), iconTransformation(extent={{40,-50},{60,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b5(redeclare package Medium = Medium)
    if
    open[5] annotation (Placement(transformation(extent={{30,-50},{50,-30}},
          rotation=0), iconTransformation(extent={{80,-50},{100,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b6(redeclare package Medium = Medium)
    if
    open[6] annotation (Placement(transformation(extent={{50,-50},{70,-30}},
          rotation=0), iconTransformation(extent={{120,-50},{140,-30}})));

equation
  connect(port_a, port_b1) annotation (Line(
      points={{-100,50},{-100,-40},{-38,-40}},
      smooth=Smooth.None));
  connect(port_a, port_b2) annotation (Line(
      points={{-100,50},{-20,50},{-20,-40}},
      smooth=Smooth.None));
  connect(port_a, port_b3) annotation (Line(
      points={{-100,50},{0,50},{0,-40}},
      smooth=Smooth.None));
  connect(port_a, port_b4) annotation (Line(
      points={{-100,50},{20,50},{20,-40}},
      smooth=Smooth.None));
  connect(port_a, port_b5) annotation (Line(
      points={{-100,50},{40,50},{40,-40}},
      smooth=Smooth.None));
  connect(port_a, port_b6) annotation (Line(
      points={{-100,50},{60,50},{60,-40}},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(extent={{-100,-40},{160,60}},
          preserveAspectRatio=true), graphics={
        Line(
          points={{-30,-16},{-30,-40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-40,30},{-20,30},{-40,-10},{-20,-10},{-40,30}},
          color={100,100,100},
          smooth=Smooth.None),
        Line(
          points={{-40,-16},{-20,-16}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-40,36},{-20,36}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-100,50},{160,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-30,36},{-30,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{10,36},{10,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{0,36},{20,36}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{0,30},{20,30},{0,-10},{20,-10},{0,30}},
          color={100,100,100},
          smooth=Smooth.None),
        Line(
          points={{0,-16},{20,-16}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{10,-16},{10,-40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{50,36},{50,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{40,36},{60,36}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{40,30},{60,30},{40,-10},{60,-10},{40,30}},
          color={100,100,100},
          smooth=Smooth.None),
        Line(
          points={{40,-16},{60,-16}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{50,-16},{50,-40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{90,36},{90,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{80,36},{100,36}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{80,30},{100,30},{80,-10},{100,-10},{80,30}},
          color={100,100,100},
          smooth=Smooth.None),
        Line(
          points={{80,-16},{100,-16}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{90,-16},{90,-40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{130,36},{130,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{120,36},{140,36}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{120,30},{140,30},{120,-10},{140,-10},{120,30}},
          color={100,100,100},
          smooth=Smooth.None),
        Line(
          points={{120,-16},{140,-16}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{130,-16},{130,-40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-70,36},{-70,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-80,36},{-60,36}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-80,30},{-60,30},{-80,-10},{-60,-10},{-80,30}},
          color={100,100,100},
          smooth=Smooth.None),
        Line(
          points={{-80,-16},{-60,-16}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-70,-16},{-70,-40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{160,60},{160,40}},
          color={0,0,127},
          smooth=Smooth.None)}), Diagram(coordinateSystem(extent={{-100,-40},{160,
            60}}, preserveAspectRatio=false),
                       graphics),
    Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end Manifold;
