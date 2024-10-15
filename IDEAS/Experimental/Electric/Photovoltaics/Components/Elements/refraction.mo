within IDEAS.Experimental.Electric.Photovoltaics.Components.Elements;
model refraction "incidence angle modifier (IAM)"

  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Real K=4 "glazing extinction coefficient, /m";
  parameter Modelica.SIunits.Length d=2*10^(-3) "pane thickness, m";
  parameter Real n=1.526 "refractve index";
  final parameter Real Tau_null=exp(-K*d)
    "transmittance of the cover for incdence angle perpendicular to pane";

  Modelica.Blocks.Interfaces.RealOutput IncAngMod "Incidence Angle Modifier"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealInput angInc "Incedence angle"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));

protected
  Modelica.SIunits.Angle angRef "refracted angle of the incedence beam";
  Modelica.SIunits.TransmissionCoefficient Tau
    "transmittance of the cover for incdence angle";

algorithm
  angRef := asin(sin(angInc)/n);
  Tau := exp(-((K*d)/(cos(angRef))))*(1 - 1/2*(((sin(angRef - angInc)^2)/(sin(
    angRef + angInc)^2)) + ((tan(angRef - angInc)^2)/(tan(angRef + angInc)^2))));
  IncAngMod := Tau/Tau_null;

  annotation (Diagram(graphics), Icon(graphics={Rectangle(
          extent={{-20,92},{18,-94}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),Line(
          points={{-20,34},{18,20},{-20,6},{-56,-80}},
          color={0,0,0},
          smooth=Smooth.None),Line(
          points={{-56,92},{-20,34},{-72,-80}},
          color={0,0,0},
          smooth=Smooth.None),Line(
          points={{18,20},{28,-2},{60,-74}},
          color={0,0,0},
          smooth=Smooth.None)}));
end refraction;
