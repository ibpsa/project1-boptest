within IDEAS.Airflow.AHU.BaseClasses;
partial record AdsolairData
  "Record containing parameters for the different Adsolair type 58 configurations"
  extends Modelica.Icons.Record;
  extends IDEAS.Fluid.Movers.Data.Generic;
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal
    "Nominal mass flow rate of the top duct.";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal
    "Nominal mass flow rate of the bottom duct.";
  parameter Modelica.SIunits.Temperature dT_compressor
    "Nominal temperature difference over the heat pump compressor";
  parameter Modelica.SIunits.ThermalConductance G_condensor
    "Equivalent thermal conductance of the condensor";
  parameter Modelica.SIunits.ThermalConductance G_evaporator
    "Equivalent thermal conductance of the evaporator";
  parameter Real epsHeating = 0 "Thermal efficiency of the heater.";
  parameter Real epsCooling = 0 "Thermal efficiency of the cooler.";
  parameter Real fraPmin(min=0) = 0
    "Minimum fraction of compressor power consumption for 0 modulation of thermal power";
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm
    N_top "Rotational speed of the top fan.";
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm
    N_bottom "Rotational speed of the bottom fan";
  parameter Real Kv_3wayValveHeater = 6.3
    "Kv flow coefficient of the three way valve controlling the heater HEX temperature.";
  parameter Modelica.SIunits.MassFlowRate m_flow_3way_nominal = 1660/3600
    "Nominal mass flow rate of the three way valve controlling the heater HEX temperature.";
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal_heater=1
    "Nominal mass flow rate of the air going through the heater.";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal_heater=1
    "Nominal mass flow rate of the liquid going through the heater.";
  parameter Modelica.SIunits.Pressure dp1_nominal_heater=0
    "Nominal air pressure drop over the heater.";
  parameter Modelica.SIunits.Pressure dp2_nominal_heater=0
    "Nominal liquid pressure drop over the heater.";
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal_cooler=1
    "Nominal mass flow rate of the air going through the cooler.";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal_cooler=1
    "Nominal mass flow rate of the liquid going through the cooler.";
  parameter Modelica.SIunits.Pressure dp1_nominal_cooler=0
    "Nominal air pressure drop over the cooler.";
  parameter Modelica.SIunits.Pressure dp2_nominal_cooler=0
    "Nominal liquid pressure drop over the cooler.";
  parameter Modelica.SIunits.Pressure dp_nominal_top
    "Nominal pressure drop over the top duct components excluding two heat exchangers, including compressor heat exchangers, filters, ...";
  parameter Modelica.SIunits.Pressure dp_nominal_bottom
    "Nominal pressure drop over the bottom duct components excluding two heat exchangers, including compressor heat exchangers, filters...";
  parameter Modelica.SIunits.Pressure dp_nominal_top_recup
    "Nominal pressure drop over the top part of the cross flow heat recuperator";
  parameter Modelica.SIunits.Pressure dp_nominal_bottom_recup
    "Nominal pressure drop over the bottom part of the cross flow heat recuperator";
  parameter Modelica.SIunits.Pressure dp_adiabatic
    "Additional pressure drop in top branch of heat recovery unit when evaporative cooling is enabled";
  parameter Real eps_adia_off = 1
    "Heat exchange efficiency when adiabatic heat exchange is off";
  parameter Real eps_adia_on = 1
    "Heat exchange efficiency when adiabatic heat exchange is on";
  parameter Modelica.SIunits.Area A_dam_byp_top
    "Top bypass damper surface area";
  parameter Modelica.SIunits.Area A_dam_rec_top
    "Top heat recovery damper surface area";
  parameter Modelica.SIunits.Area A_dam_byp_bot
    "Bottom bypass damper surface area";
  parameter Modelica.SIunits.Area A_dam_rec_bot
    "Bottom heat recovery damper surface area";
  parameter Modelica.SIunits.Area A_byp_top_min
    "Minimum cross section area of top bypass branch";
  parameter Modelica.SIunits.Area A_byp_bot_min
    "Minimum cross section area of top bypass branch";
  parameter Modelica.SIunits.ThermalConductance UA_adia_on
    "UA value of heat exchanger when evaporative cooling is on";
  parameter Modelica.SIunits.ThermalConductance UA_adia_off
    "UA value of heat exchanger when evaporative cooling is off";

annotation(Documentation(info="<html>
  <p>
    Generic data file which is used for the 
    <a href=\"modelica://Buildings.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector\">
    Buildings.Fluid.Solarcollectors.BaseClasses.PartialSolarCollector</a> model. Establishes
    the base inputs needed to create model-specific data packages.
  </p>
</html>", revisions="<html>
<ul>
<li>
October 11, 2016, by Filip Jorissen:<br/>
Added first implementation.
</li>
</ul>
</html>"));
end AdsolairData;
