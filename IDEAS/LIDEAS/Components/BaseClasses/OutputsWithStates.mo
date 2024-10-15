within IDEAS.LIDEAS.Components.BaseClasses;
connector OutputsWithStates
  extends Outputs;
  parameter Integer nSta=2;
  Modelica.SIunits.Temperature TStaInit[nSta];
end OutputsWithStates;
