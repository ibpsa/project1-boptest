within IDEAS.BoundaryConditions.Climate.Time.BaseClasses;
model SimulationDelay

  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Modelica.SIunits.Time delay;

  Modelica.Blocks.Interfaces.RealOutput timSim
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  timSim = delay;

  annotation (Diagram(graphics));
end SimulationDelay;
