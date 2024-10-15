within IBPSA.Obsolete.Fluid.Movers.Validation;
model PowerEuler
  "Power calculation comparison among three mover types, using Euler number computation for m_flow and dp"
  extends IBPSA.Obsolete.Fluid.Movers.Validation.PowerSimplified(
    pump_dp(per=perPea),
    pump_m_flow(per=perPea));

  parameter IBPSA.Fluid.Movers.Data.Generic perPea(
    final powerOrEfficiencyIsHydraulic=per.powerOrEfficiencyIsHydraulic,
    final etaHydMet=
            IBPSA.Fluid.Movers.BaseClasses.Types.HydraulicEfficiencyMethod.EulerNumber,
    final etaMotMet=
            IBPSA.Fluid.Movers.BaseClasses.Types.MotorEfficiencyMethod.NotProvided,
    final peak=IBPSA.Fluid.Movers.BaseClasses.Euler.getPeak(
                 pressure=per.pressure,
                 power=per.power))
    "Peak condition";

  annotation (
    experiment(Tolerance=1e-6, StopTime=200),
    __Dymola_Commands(file=
          "modelica://IBPSA/Resources/Scripts/Dymola/Obsolete/Fluid/Movers/Validation/PowerEuler.mos"
        "Simulate and plot"),
    obsolete = "Obsolete model - refer to IBPSA.Fluid.Movers.Validation.ComparePowerInput",
    Documentation(
info="<html>
<p>
This example is identical to
<a href=\"modelica://IBPSA.Obsolete.Fluid.Movers.Validation.PowerSimplified\">
IBPSA.Obsolete.Fluid.Movers.Validation.PowerSimplified</a>,
except that the efficiency of the flow controlled pumps
<code>pump_dp</code> and <code>pump_m_flow</code>
is estimated by using the Euler number and its correlation as implemented in
<a href=\"modelica://IBPSA.Fluid.Movers.BaseClasses.Euler\">
IBPSA.Fluid.Movers.BaseClasses.Euler</a>.
</p>
<p>
The figure below shows the approximation error for the
power calculation where the speed <i>y</i> differs from
the nominal speed <i>y<sub>nominal</sub></i>.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://IBPSA/Resources/Images/Obsolete/Fluid/Movers/Validation/PowerEuler.png\"/>
</p>
</html>",
revisions="<html>
<ul>
<li>
May 14, 2024, by Hongxiang Fu:<br/>
Moved this model to the Obsolete package.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1880\">IBPSA, #1880</a>.
</li>
<li>
November 22, 2021, by Hongxiang Fu:<br/>
First implementation.
</li>
</ul>
</html>"));
end PowerEuler;
