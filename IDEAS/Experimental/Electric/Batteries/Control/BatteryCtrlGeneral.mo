within IDEAS.Experimental.Electric.Batteries.Control;
model BatteryCtrlGeneral
  extends Modelica.Blocks.Interfaces.BlockIcon;

protected
  parameter Integer numPha=1 "Number of phases";

// Inputs and outputs
public
  Modelica.Blocks.Interfaces.RealOutput PInit "Active power flow with battery" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={100,30})));
  Modelica.Blocks.Interfaces.RealInput SoC "SoC of the battery" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-30})));
  Modelica.Blocks.Interfaces.RealOutput PFinal "Active power flow with grid" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-100,30})));
   Modelica.Blocks.Interfaces.RealOutput QFinal "Reactive power flow with grid" annotation (Placement(
         transformation(
         extent={{-20,-20},{20,20}},
         rotation=180,
         origin={-100,-30})));

// Parameters battery
  parameter Modelica.SIunits.Efficiency DOD_max;
  parameter Modelica.SIunits.Conversions.NonSIunits.Energy_kWh EBat;
  // Total battery capacity in [kW.h]
  parameter Modelica.SIunits.Efficiency eta_out;
  parameter Modelica.SIunits.Efficiency eta_in;
  parameter Modelica.SIunits.Efficiency eta_d;
  parameter Modelica.SIunits.Efficiency eta_c;
  parameter Real e_c;
  parameter Real e_d;

// Variables
  Modelica.SIunits.Power P "Power available to be charged/discharged";
  Modelica.SIunits.Power PBat "Actual power flow to/from battery";

equation
  // Limiting powers when battery almost full/empty
  if (P >= 0) then   // Discharging batteries
    PBat = if (((SoC - (1 - DOD_max))*EBat) < (P*(2-eta_out*eta_d)))
      then ((SoC - (1 - DOD_max))*EBat) else min(P, EBat*1000*e_d);
  else               // Charging batteries
    PBat = if (((1 - SoC)*EBat) < (abs(P)*eta_in*eta_c)) then ((
      SoC - 1)*EBat) else max(P,-EBat*1000*e_c);
  end if;

PFinal = -PBat;
QFinal = 0;
PInit = -PBat;

  annotation (Diagram(graphics));
end BatteryCtrlGeneral;
