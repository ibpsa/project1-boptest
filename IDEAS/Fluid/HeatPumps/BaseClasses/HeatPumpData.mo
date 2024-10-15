within IDEAS.Fluid.HeatPumps.BaseClasses;
record HeatPumpData "Data record for storing data for an on/off heat pump"

  extends Modelica.Icons.Record;

  //zeros in powerData and copData indicate that this data is not available
  //or that the working point is outside of the working range of the device
  Modelica.SIunits.Power[:,:] powerData "Power map for the heat pump";
  Real[:,:] copData "Cop map for the heat pump";
  Modelica.SIunits.Mass m1(min=Modelica.Constants.eps)
    "Fluid content of the evaporator";

  Modelica.SIunits.Mass m2(min=Modelica.Constants.eps)
    "Fluid content of the condensor";

  Modelica.SIunits.MassFlowRate m1_flow_nominal
    "Mass flow rate of the brine (evaporator) for calculation of the pressure drop";
  Modelica.SIunits.MassFlowRate m2_flow_nominal
    "Mass flow rate of the fluid (condensor) for calculation of the pressure drop";

  Modelica.SIunits.Pressure dp1_nominal
    "Pressure drop of the evaporator at nominal mass flow rate";
  Modelica.SIunits.Pressure dp2_nominal
    "Pressure drop of the condensor at nominal mass flow rate";

  Modelica.SIunits.ThermalConductance G
    "Thermal conductivity between the evaporator and the environment";
  Modelica.SIunits.Power P_the_nominal "nominal thermal power of the heat pump";

  Modelica.SIunits.Temperature T_evap_min = 273.15
    "Temperature protection threshold evaporator";
  Modelica.SIunits.Temperature T_cond_max = 273.15 + 60
    "Temperature protection threshold condensor";

  annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end HeatPumpData;
