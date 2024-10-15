within IDEAS.BoundaryConditions.Climate.Time.Elements;
model LocalTime

extends Modelica.Blocks.Interfaces.BlockIcon;

parameter Modelica.SIunits.Angle lon(displayUnit="deg") "longitude";

  Modelica.Blocks.Interfaces.RealInput timZon "time zone"
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput timSim "simulation time"
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput timLoc "local time"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  timLoc = timSim - timZon + lon * 43200 / Modelica.Constants.pi;

  annotation (Diagram(graphics));
end LocalTime;
