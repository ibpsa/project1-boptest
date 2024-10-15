within IDEAS.Fluid.HeatPumps;
package Deprecated "Deprecated models"
  extends Modelica.Icons.ObsoleteModel;
  model Boiler
    "Modulating boiler with losses to environment, based on performance tables"
    extends IDEAS.Fluid.HeatPumps.Interfaces.PartialDynamicHeaterWithLosses(
        final heaterType=BaseClasses.HeaterType.Boiler);

    Real eta "Instanteanous efficiency";

    IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_CondensingGasBurner heatSource(
      QNom=QNom,
      TBoilerSet=TSet,
      TEnvironment=heatPort.T,
      UALoss=UALoss,
      modulationMin=modulationMin,
      modulationStart=modulationStart,
      THxIn=Tin.T,
      hIn=inStream(port_a.h_outflow),
      m_flowHx=port_a.m_flow,
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    parameter Real modulationMin=25 "Minimal modulation percentage";
    parameter Real modulationStart=35
      "Min estimated modulation level required for start of HP";
  equation
    // Electricity consumption for electronics and fan only.  Pump is covered by pumpHeater;
    // This data is taken from Viessmann VitoDens 300W, smallest model.  So only valid for
    // very small household condensing gas boilers.
    PEl = 7 + heatSource.modulation/100*(33 - 7);
    PFuel = heatSource.PFuel;
    eta = heatSource.eta;
    connect(heatSource.heatPort, vol.heatPort) annotation (Line(
        points={{-60,30},{40,30},{40,-20}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              120}}),
              graphics),
      Icon(graphics={
          Ellipse(
            extent={{-60,60},{58,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={95,95,95}),
          Ellipse(extent={{-48,46},{46,-46}}, lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-32,34},{30,-34}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{100,60},{44,60}},
            color={0,0,127},
            smooth=Smooth.None),
          Line(
            points={{44,60},{34,48}},
            color={0,0,127},
            smooth=Smooth.None),
          Line(
            points={{44,-60},{34,-48}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash),
          Line(
            points={{100,-60},{44,-60}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash)}),
      Documentation(info="<html>
<p>
This model is deprecated since it is not sufficiently generic.
Consider using a different model such as 
<a href=\"IDEAS.Fluid.HeatExchangers.Heater_T\">Heater_T</a>.
</p>
<h4>Description </h4>
<p>Dynamic boiler model, based on interpolation in performance tables. The boiler has thermal losses to the environment which are often not mentioned in the performance tables. Therefore, the additional environmental heat losses are added to the heat production in order to ensure the same performance as in the manufacturers data, while still obtaining a dynamic model with heat losses (also when boiler is off). The heatSource will compute the required power and the environmental heat losses, and try to reach the set point. </p>
<p>See<a href=\"modelica://IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses\"> IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses</a> for more details about the heat losses and dynamics. </p>
<h4>Assumptions and limitations </h4>
<ol>
<li>Dynamic model based on water content and lumped dry capacity</li>
<li>Limited power (based on QNom and interpolation tables in heatSource) </li>
<li>Heat losses to environment which are compensated &apos;artifically&apos; to meet the manufacturers data in steady state conditions</li>
<li>No enforced min on or min off time; Hysteresis on start/stop thanks to different parameters for minimum modulation to start and stop the heat pump</li>
</ol>
<h4>Model use</h4>
<p>This model is based on performance tables of a specific boiler, as specified by <a href=\"modelica://IDEAS.Thermal.Components.Production.BaseClasses.HeatSource_CondensingGasBurner\">IDEAS.Thermal.Components.Production.BaseClasses.HeatSource_CondensingGasBurner</a>. If a different gas boiler is to be simulated, create a different Burner model with adapted interpolation tables.</p>
<ol>
<li>Specify medium and initial temperature (of the water + dry mass)</li>
<li>Specify the nominal power</li>
<li>Specify the minimum required modulation level for the boiler to start (modulation_start) and the minimum modulation level when the boiler is operating (modulation_min). The difference between both will ensure some off-time in case of low heat demands</li>
<li>Connect TSet, the flowPorts and the heatPort to environment. </li>
</ol>
<p>See also<a href=\"modelica://IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses\"> IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses</a> for more details about the heat losses and dynamics. </p>
<h4>Validation </h4>
<p>The model has been verified in order to check if the &apos;artificial&apos; heat loss compensation still leads to correct steady state efficiencies according to the manufacturer data. This verification is integrated in the example model <a href=\"modelica://IDEAS.Thermal.Components.Examples.Boiler_validation\">IDEAS.Thermal.Components.Examples.Boiler_validation</a>.</p>
<h4>Example</h4>
<p>See validation.</p>
</html>",   revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>2014 March, Filip Jorissen, Annex60 compatibility</li>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011 August, Roel De Coninck: first version</li>
</ul>
</html>"));
  end Boiler;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Deprecated;
