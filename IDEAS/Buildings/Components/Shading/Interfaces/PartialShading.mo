within IDEAS.Buildings.Components.Shading.Interfaces;
partial model PartialShading "Window shading partial"
  parameter Boolean controlled=true
    "if true, shading has a control input"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Angle azi
    "Window azimuth angle"
    annotation(Dialog(group="Window properties"));

  Modelica.Blocks.Interfaces.RealInput HDirTil
    "Direct solar illuminance on surface" annotation (Placement(
        transformation(extent={{-80,30},{-40,70}}), iconTransformation(extent={
            {-60,50},{-40,70}})));
  Modelica.Blocks.Interfaces.RealInput HSkyDifTil
    "Diffuse sky solar illuminance on tilted surface" annotation (Placement(
        transformation(extent={{-80,10},{-40,50}}),  iconTransformation(extent={{-60,30},
            {-40,50}})));
  Modelica.Blocks.Interfaces.RealInput HGroDifTil
    "Diffuse ground solar illuminance on tilted surface" annotation (Placement(
        transformation(extent={{-80,-10},{-40,30}}), iconTransformation(extent={{-60,10},
            {-40,30}})));
  Modelica.Blocks.Interfaces.RealInput angZen
    "Angle of incidence" annotation (
      Placement(transformation(extent={{-80,-90},{-40,-50}}),
        iconTransformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Interfaces.RealOutput HShaDirTil
    "Shaded direct solar illuminance on surface" annotation (Placement(
        transformation(extent={{20,30},{60,70}}), iconTransformation(extent={{
            40,50},{60,70}})));
  Modelica.Blocks.Interfaces.RealOutput HShaSkyDifTil
    "Shaded diffuse sky solar illuminance on tilted surface" annotation (Placement(
        transformation(extent={{20,10},{60,50}}),  iconTransformation(extent={{40,30},
            {60,50}})));
  Modelica.Blocks.Interfaces.RealOutput HShaGroDifTil
    "Shaded diffuse ground solar illuminance on tilted surface" annotation (Placement(
        transformation(extent={{20,-10},{60,30}}), iconTransformation(extent={{40,10},
            {60,30}})));
  Modelica.Blocks.Interfaces.RealOutput iAngInc
    "Angle of incidence after transmittance through (possible) shading"
    annotation (Placement(transformation(extent={{20,-70},{60,-30}}),
        iconTransformation(extent={{40,-50},{60,-30}})));

  Modelica.Blocks.Interfaces.RealInput angInc "Inclination angle" annotation (
      Placement(transformation(extent={{-80,-70},{-40,-30}}),
        iconTransformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Interfaces.RealInput angAzi "Azimuth angle" annotation (
      Placement(transformation(extent={{-80,-110},{-40,-70}}),
        iconTransformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Blocks.Interfaces.RealInput Ctrl(min=0, max=1) if controlled
    "Control signal between 0 and 1, i.e. 1 is fully closed" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-10,-110}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-100})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-50,-100},{50,100}}), graphics={
        Polygon(
          points={{-50,80},{0,60},{4,60},{4,-20},{-50,0},{-50,80}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{4,40},{50,20},{50,-32},{20,-20},{4,-20},{4,40}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          fillColor={179,179,179},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Line(
          points={{0,60},{20,60},{20,80},{50,80}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{0,-20},{20,-20},{20,-70},{20,-70},{50,-70}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{0,60},{0,66},{0,100},{50,100}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{0,-20},{0,-90},{50,-90}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{4,60},{4,-20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None)}),
    Documentation(revisions="<html>
<ul>
<li>
July 18, 2016 by Filip Jorissen:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>", info="<html>
<p>Partial model for shading computations.</p>
</html>"));
end PartialShading;
