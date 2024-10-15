within IDEAS.BoundaryConditions.Climate.Time.BaseClasses;
model LocalTime

  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Modelica.SIunits.Angle lon(displayUnit="deg") "longitude";

  Modelica.Blocks.Interfaces.RealInput timZon(final quantity="Time", final unit=
       "s") "time zone"
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput timSim(final quantity="Time", final unit=
       "s") "simulation time"
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput timLoc(final quantity="Time", final unit=
       "s") "local time"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  timLoc = timSim - timZon + lon*43200/Modelica.Constants.pi;

  annotation (Diagram(graphics));
end LocalTime;
