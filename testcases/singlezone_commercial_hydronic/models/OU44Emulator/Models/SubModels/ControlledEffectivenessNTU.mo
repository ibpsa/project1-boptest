within OU44Emulator.Models.SubModels;
model ControlledEffectivenessNTU
  "Heat exchanger with controlled effectiveness e.g rotary wheel, for variable flow"
  extends Buildings.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTU(
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
      UA=UA_nominal*rel_eps_contr,
      use_Q_flow_nominal=false);

  Modelica.Blocks.Interfaces.RealInput rel_eps_contr(max=1, min=0)
  "control input for relative effectiveness"
   annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,108}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={0,88})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-70,78},{70,-82}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,-12},{54,-72}},
          lineColor={255,255,255},
          textString="eps=%eps")}),
          preferredView="info",
defaultComponentName="hex",
Documentation(info="<html>
<p>
Model for a heat exchanger with constant effectiveness.
</p>
<p>
This model transfers heat in the amount of
</p>
<p align=\"center\" style=\"font-style:italic;\">
  Q = Q<sub>max</sub> &epsilon;,
</p>
<p>
where <i>&epsilon;</i> is a constant effectiveness and
<i>Q<sub>max</sub></i> is the maximum heat that can be transferred.
</p>
<p>
For a heat and moisture exchanger, use
<a href=\"modelica://Buildings.Fluid.MassExchangers.ConstantEffectiveness\">
Buildings.Fluid.MassExchangers.ConstantEffectiveness</a>
instead of this model.
</p>
</html>",
revisions="<html>
<ul>
<li>
August 13, 2013 by Michael Wetter:<br/>
Corrected error in the documentation.
</li>
<li>
July 30, 2013 by Michael Wetter:<br/>
Updated model to use new variable <code>mWat_flow</code>
in the base class.
</li>
<li>
January 28, 2010, by Michael Wetter:<br/>
Added regularization near zero flow.
</li>
<li>
October 2, 2009, by Michael Wetter:<br/>
Changed computation of inlet temperatures to use
<code>state_*_inflow</code> which is already known in base class.
</li>
<li>
April 28, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end ControlledEffectivenessNTU;
