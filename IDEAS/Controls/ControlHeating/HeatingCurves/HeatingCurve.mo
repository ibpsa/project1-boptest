within IDEAS.Controls.ControlHeating.HeatingCurves;
block HeatingCurve
  "Block to compute the supply and return set point of heating systems"

  extends IDEAS.Controls.ControlHeating.HeatingCurves.HeatingCurveFilter(
      redeclare Modelica.Blocks.Routing.RealPassThrough filter);
  annotation (
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>This block computes the set point temperatures for the supply and return temperature of a heating system. The set point for the room air temperature can either be specified by a parameter, or it can be an input to the model. The latter allows to use this model with systems that have night set back. </p>
<p>The parameter <code>dTOutHeaBal</code> can be used to shift the heating curve to account for the fact that solar heat gains and heat gains from equipment and people make up for some of the transmission losses. For example, in energy efficient houses, the heating may not be switched on above 12 degree Celsius, even if a room temperature of 20 degree is required. In such a situation, set <code>dTOutHeaBal=20-12=8</code> Kelvin to shift the heating curve. </p>
<p>The outdoor temperature is filtered with a first order or moving average filter (replaceable component). The time constant of this filter can be set. </p>
<p>If desired (minSup=true), a minimum supply temperature can be set for the heating curve output.</p>
<h4>Assumptions and limitations </h4>
<ol>
<li>Filtered ambient temperature</li>
<li>Takes into account radiator exponent of emission system</li>
</ol>
<h4>Model use</h4>
<ol>
<li>This model is normally used inside a controller for the heating, but it can be used directly if desired. </li>
</ol>
<h4>Validation </h4>
<p>No validation performed.</p>
<h4>Example </h4>
<p>No specific example foreseen for the heating curve, see the <a href=\"modelica://IDEAS.Thermal.HeatingSystems.Examples\">heating system examples</a>. </p>
</html>", revisions="<html>
<ul>
<li>2016 April, Filip Jorissen: Redesigned HeatingCurves and fixed bug 
(see <a href=\"https://github.com/open-ideas/IDEAS/issues/477\">#477</a>) </li>
<li>2014 May, Damien Picard: fixed bug reported in Buildings Library (see <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/74\">#74</a>) </li>
<li>2013 June, Roel De Coninck: documentation</li>
<li>2011, Roel De Coninck: minimum guaranteed supply temperature and filter or moving average of ambient temperature.</li>
<li>February 5, 2009 by Michael Wetter:first implementation. </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={Polygon(
          points={{90,-82},{68,-74},{68,-90},{90,-82}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),Line(points={{-90,-82},{82,-82}},
          color={192,192,192}),Line(points={{-80,76},{-80,-92}}, color={192,192,
          192}),Polygon(
          points={{-80,88},{-88,66},{-72,66},{-80,86},{-80,88}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
                                Text(
          extent={{-152,120},{-102,70}},
          lineColor={0,0,127},
          textString="TOut"),Text(
          visible=use_TRoo_in,
          extent={{-152,-4},{-102,-54}},
          lineColor={0,0,127},
          textString="TRoo"),Text(
          extent={{40,86},{90,36}},
          lineColor={0,0,127},
          textString="TSup"),
        Line(
          points={{-68,38},{8,2},{40,-60}},
          color={175,175,175},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{-64,48},{12,12},{44,-50}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-60,58},{16,22},{48,-40}},
          color={175,175,175},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Ellipse(
          extent={{10,14},{14,10}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-66,50},{-62,46}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{42,-48},{46,-52}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
                             Text(
          extent={{42,-30},{92,-80}},
          lineColor={0,0,127},
          textString="TRet")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics));
end HeatingCurve;
