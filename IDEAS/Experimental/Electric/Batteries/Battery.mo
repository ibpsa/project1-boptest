within IDEAS.Experimental.Electric.Batteries;
model Battery
  extends Modelica.Blocks.Interfaces.BlockIcon;

// Inputs and Outputs
  Modelica.Blocks.Interfaces.RealInput PFlow "Active power exchange"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));

  Modelica.Blocks.Interfaces.RealOutput SoC_out "SoC measurement" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-100,-30})));
  Modelica.SIunits.Power P "Active power exchange";

// Parameters
protected
parameter Modelica.SIunits.Efficiency eta_out;
parameter Modelica.SIunits.Efficiency eta_in;
parameter Modelica.SIunits.Efficiency eta_d;
parameter Modelica.SIunits.Efficiency eta_c;
parameter Modelica.SIunits.Efficiency delta_sd;
parameter Modelica.SIunits.Efficiency SoC_start;
parameter Modelica.SIunits.Conversions.NonSIunits.Energy_kWh EBat;

// Variables
public
  Modelica.SIunits.ActivePower PExch "Power exchange = Energy exchange";
  Modelica.SIunits.Efficiency SoC(start=SoC_start,min=0,max=1)
    "State of Charge of battery capacity in [%/100]";
  Modelica.SIunits.Efficiency dSoC "Change in SoC in time interval";

  Modelica.SIunits.ActivePower PlosCha
    "Power losses (converters) during charging";
  Modelica.SIunits.ActivePower PlosDisCha
    "Power losses (converters) during discharging";

equation
  P = PFlow;

  if P <= 0 then      // Discharging batteries
    PExch = P*(2 - eta_out*eta_d);
  else                // Charging batteries
    PExch = P*(eta_in*eta_c);
  end if;

  if P <=0 then
    PlosCha = 0;
    PlosDisCha = (1-eta_out)*PExch;
  else
    PlosCha = (1-eta_in)*P;
    PlosDisCha = 0;
  end if;

  dSoC = PExch/EBat;
  der(SoC) = dSoC - delta_sd;

  SoC_out = SoC;

annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Polygon(
          points={{-62,40},{-62,-40},{72,-40},{72,40},{-62,40}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{58,32},{58,-30},{32,-30},{10,32},{58,32}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,32},{20,-30},{0,-30},{-22,32},{-2,32}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-74,12},{-74,-12},{-62,-12},{-62,12},{-74,12}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})},
          defaultComponentName="battery",
          defaultComponentPrefixes="inner"),
          Documentation(info="<html>
<h4>General description</h4>
<h5>Goal</h5>
<p>The <code>Battery.mo</code> model describes the calculations of the 
State of Charge (SoC) of a battery. The implementation is based on [Tant12].
</p>
<h5>Description</h5>
<p>
The dynamic SoC calculation equation is: SoC_t = SoC_{t-1} - sd_t + (eta_c x Pc_t x T_s - 1/eta_d x Pd_t x T_s) / E_nom,
with sd_t the self-discharge on time t, eta_c and eta_d the charge and discharge efficiency, 
Pc_t and Pd_t the charge and discharge power, T_s 
the time step resolution and E_nom the nominal battery capacity.
</p>
<p>
It is impossible to charge/discharge a battery at the same time: Pc_t x Pd_t = 0.
</p>
</html>"));
end Battery;
