within IDEAS.BoundaryConditions.Occupants.Components.BaseClasses;
block CloValue "clothing"

  extends Modelica.Blocks.Interfaces.BlockIcon;

  Modelica.Blocks.Interfaces.RealOutput RClo "clothing thermal resistance"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput CloFrac "clothign fraction"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

  parameter Real CloWin=0.9 "Clo value for winter conditions";
  parameter Real CloSum=0.5 "Clo value for summer conditions";

algorithm
  if noEvent(sim.TeAv > 22 + 273.15) then
    RClo := 0.155*CloSum;
  else
    RClo := 0.155*CloWin;
  end if;

  if noEvent(RClo > 0.078) then
    CloFrac := 1.05 + 0.645*RClo;
  else
    CloFrac := 1.00 + 1.29*RClo;
  end if;

  annotation (Icon(graphics));
end CloValue;
