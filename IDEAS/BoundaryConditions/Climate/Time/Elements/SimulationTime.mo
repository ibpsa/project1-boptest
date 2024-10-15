within IDEAS.BoundaryConditions.Climate.Time.Elements;
model SimulationTime

extends Modelica.Blocks.Interfaces.BlockIcon;

  Modelica.Blocks.Interfaces.RealOutput timSim
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  timSim = rem(time,31536000);

  annotation (Diagram(graphics));
end SimulationTime;
