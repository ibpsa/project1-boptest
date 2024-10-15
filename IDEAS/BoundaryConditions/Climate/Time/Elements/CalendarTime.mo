within IDEAS.BoundaryConditions.Climate.Time.Elements;
model CalendarTime

extends Modelica.Blocks.Interfaces.BlockIcon;

parameter Boolean ifSolCor;

  Modelica.Blocks.Interfaces.RealInput timSim
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput delay
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput timCal
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput timCalSol
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));

equation
  timCal = timSim;// - integer(timSim/31536000)*31536000;

if ifSolCor then
  timCalSol = timSim + delay;
else
  timCalSol = timSim;
end if;

  annotation (Diagram(graphics));
end CalendarTime;
