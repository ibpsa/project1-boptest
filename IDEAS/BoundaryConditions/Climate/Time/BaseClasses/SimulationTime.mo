within IDEAS.BoundaryConditions.Climate.Time.BaseClasses;
model SimulationTime

  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Modelica.SIunits.Time delay = 0
    "Delay [s] for simulations not starting on the first of january";

  Modelica.Blocks.Interfaces.RealOutput timSim
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  timSim = rem(time+delay, 31536000);

  annotation (Diagram(graphics));
end SimulationTime;
