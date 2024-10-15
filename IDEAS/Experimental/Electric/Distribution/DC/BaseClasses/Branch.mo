within IDEAS.Experimental.Electric.Distribution.DC.BaseClasses;
model Branch
  extends Modelica.Electrical.Analog.Interfaces.OnePort;

  parameter Modelica.SIunits.Resistance R;

  Modelica.SIunits.Power Plos;

equation
  v = R*i;
  Plos = R*(i)^2;
end Branch;
