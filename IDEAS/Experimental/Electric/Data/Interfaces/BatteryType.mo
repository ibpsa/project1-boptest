within IDEAS.Experimental.Electric.Data.Interfaces;
record BatteryType
  extends Modelica.Icons.MaterialProperty;

  /* Battery parameters:
   1: eta_in    Efficiency from grid --> invertor
   2: eta_out   Efficiency from invertor --> grid
   3: eta_c     Efficiency from invertor --> battery
   4: eta_d     Efficiency from battery --> invertor
   5: alpha_sd  Self-discharge per month
   6: e_c       Ratio: Maximum charge power to maximum battery capacity
   7: e_d       Ratio: Maximum discharge power to maximum battery capacity
   
   This model includes the parameters (charging and discharging efficiencies for a battery according to:
   [Ahlert] Ahlert, K.-H., "Economics of Distributed Storage Systems: An economical analysis of arbitrage-maximizing storage 
   systems at the end consumer lever", PhD Thesis, 23 February 2010, Karlsuher Institut fur Technologie
*/

  parameter Modelica.SIunits.Efficiency eta_in(min=0,max=1)
    "Efficiency Grid --> Invertor";
  parameter Modelica.SIunits.Efficiency eta_out(min=0,max=1)
    "Efficiency Invertor --> Grid";
  parameter Modelica.SIunits.Efficiency eta_c(min=0,max=1)
    "Efficiency Invertor --> Battery";
  parameter Modelica.SIunits.Efficiency eta_d(min=0,max=1)
    "Efficiency Battery --> Invertor";
  parameter Modelica.SIunits.Efficiency alpha_sd(min=0,max=1)
    "Self-discharge (%/100) per month";
  parameter Modelica.SIunits.Efficiency delta_sd=alpha_sd/(365.25/12*24*3600)
    "Standby SOC-loss in time interval";
  parameter Real e_c "Ratio: Maximum charge power to maximum battery capacity";
  parameter Real e_d
    "Ratio: Maximum discharge power to maximum battery capacity ";

end BatteryType;
