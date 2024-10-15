within IDEAS.BoundaryConditions.Climate.Time.BaseClasses;
model SolarTime

  extends Modelica.Blocks.Interfaces.BlockIcon;

  Modelica.Blocks.Interfaces.RealInput timLoc(quantity="Time", unit="s")
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput timSim(quantity="Time", unit="s")
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput timSol(quantity="Time", unit="s")
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

protected
  Modelica.SIunits.Angle Bt;
  Modelica.SIunits.Time delta "difference of solar time to local time";
  Modelica.SIunits.Time nDay "Zero-based day number in seconds";

equation
  nDay = timSim;
  Bt = Modelica.Constants.pi*((nDay + 86400)/86400 - 81)/182;
  delta = 60*(9.87*sin(2*Bt) - 7.53*cos(Bt) - 1.5*sin(Bt));
  timSol = timLoc + delta;

  annotation (Diagram(graphics));
end SolarTime;
