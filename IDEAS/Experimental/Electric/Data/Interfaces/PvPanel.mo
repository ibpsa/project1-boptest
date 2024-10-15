within IDEAS.Experimental.Electric.Data.Interfaces;
record PvPanel
  "Describes a Photovoltaic panel by its 5 main parameters and some extra parameter"
  extends Modelica.Icons.MaterialProperty;

  //The 5 main parameters
  parameter Modelica.SIunits.ElectricCurrent I_phr
    "Light current under reference conditions";
  parameter Modelica.SIunits.ElectricCurrent I_or
    "Diode reverse saturation current under reference conditions";
  parameter Modelica.SIunits.Resistance R_sr
    "Series resistance under reference conditions";
  parameter Modelica.SIunits.Resistance R_shr
    "Shunt resistance under reference conditions";
  parameter Modelica.SIunits.ElectricPotential V_tr
    "modified ideality factor under reference conditions";

  //Other parameters
  parameter Modelica.SIunits.ElectricCurrent I_scr
    "Short circuit current under reference conditions";
  parameter Modelica.SIunits.ElectricPotential V_ocr
    "Open circuit voltage under reference conditions";
  parameter Modelica.SIunits.ElectricCurrent I_mpr
    "Maximum power point current under reference conditions";
  parameter Modelica.SIunits.ElectricPotential V_mpr
    "Maximum power point voltage under reference conditions";
  parameter Modelica.SIunits.LinearTemperatureCoefficient kV
    "Temperature coefficient for open circuit voltage";
  parameter Modelica.SIunits.LinearTemperatureCoefficient kI
    "Temperature coefficient for short circuit current";
  parameter Modelica.SIunits.Temperature T_ref
    "Reference temperature in Kelvin";

end PvPanel;
