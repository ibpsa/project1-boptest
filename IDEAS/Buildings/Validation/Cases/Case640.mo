within IDEAS.Buildings.Validation.Cases;
model Case640
Modelica.SIunits.Temperature TSen = building.TSensor[1];

  extends IDEAS.Buildings.Validation.Cases.Case600(
    redeclare replaceable BaseClasses.HeatingSystem.ThermostatSetback
      heatingSystem(VZones=building.VZones),
    redeclare replaceable IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder
      inHomeGrid);
end Case640;
