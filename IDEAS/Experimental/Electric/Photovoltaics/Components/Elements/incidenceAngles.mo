within IDEAS.Experimental.Electric.Photovoltaics.Components.Elements;
model incidenceAngles "incidence angle modifier (IAM)"

  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Modelica.SIunits.Angle inc "inclination";
  parameter Modelica.SIunits.Angle azi "azimuth";

  Modelica.Blocks.Interfaces.RealOutput angIncDir "Incidence Angle"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput angIncDif
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Interfaces.RealOutput angIncRef
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));

  Modelica.Blocks.Interfaces.RealInput angInc "IcosXi"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput angZen
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput angHou
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));

equation
  angIncDir = angInc;
  angIncDif = inc/2;
  angIncRef = {-cos(angHou)*sin(angZen),sin(-angHou)*sin(angZen),cos(angZen)}*{
    cos(-azi)*cos(inc),sin(-azi)*cos(inc),sin(inc)};

  annotation (Diagram(graphics), Icon(graphics));
end incidenceAngles;
