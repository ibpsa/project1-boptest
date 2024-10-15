within IDEAS.BoundaryConditions.Occupants.Components.BaseClasses;
block PredictedPercentageDissatisfied "predicted percentage of dissatisfied"

  extends Modelica.Blocks.Interfaces.BlockIcon;

  Modelica.Blocks.Interfaces.RealInput PMV "predicted mean vote"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealOutput PPD
    "predicted percentage of dissatisfied"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));

algorithm
  PPD := 100 - 95*exp(-0.003353*PMV^4 - 0.2179*PMV^2);

  annotation (Icon(graphics), Diagram(graphics));
end PredictedPercentageDissatisfied;
