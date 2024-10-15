within IDEAS.Controls.ControlHeating.HeatingCurves;
block HeatingCurveFilter
  "Block to compute the supply and return set point of heating systems"

  /* 
  Model extended from Buildings library with a first order filter to 
  filter the ambient temperature
  */
  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Real m=1.3 "Exponent for heat transfer";
  parameter Modelica.SIunits.Temperature TSup_nominal "Supply temperature"
    annotation (Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.Temperature TSupMin=273.15 + 30 if minSup
    "Minimum supply temperature if enabled"
    annotation(Dialog(enable=minSup));
  parameter Boolean minSup=true
    "= true, to set a lower bound on the supply temperature";
  parameter Modelica.SIunits.Temperature TRet_nominal "Return temperature"
    annotation (Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.Temperature TRoo_nominal=293.15 "Room temperature"
    annotation (Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.Temperature TOut_nominal "Outside temperature"
    annotation (Dialog(group="Nominal conditions"));

  parameter Boolean use_TRoo_in=false
    "Get the room temperature set point from the input connector" annotation (
    Evaluate=true,
    choices(checkBox=true));
  parameter Modelica.SIunits.Temperature TRoo=293.15
    "Fixed value of room air temperature set point if use_TRoo_in=false"
    annotation (Evaluate=true, Dialog(enable=not use_TRoo_in));
  parameter Modelica.SIunits.TemperatureDifference dTOutHeaBal=8
    "Offset for heating curve";
  parameter Modelica.SIunits.Time timeFilter=86400
    "Time constant for filter on ambient temperature";
  Modelica.Blocks.Interfaces.RealInput TRoo_in(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) if use_TRoo_in "Room air temperature set point" annotation (
      Placement(transformation(extent={{-139,-80},{-99,-40}}, rotation=0)));

  Modelica.Blocks.Interfaces.RealInput TOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Outside temperature"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput TSup(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Setpoint for supply temperature"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput TRet(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Setpoint for return temperature"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  replaceable Modelica.Blocks.Interfaces.SISO filter annotation (choices(choice(
          redeclare Modelica.Blocks.Continuous.FirstOrder filter(T=timeFilter)),
        choice(redeclare IDEAS.BaseClasses.Math.MovingAverage filter(period=
              timeFilter))), Placement(transformation(extent={{-42,50},{-22,70}})));
protected
  parameter Modelica.SIunits.Temperature TOutOffSet_nominal=TOut_nominal +
      dTOutHeaBal
    "Effective outside temperature for heat transfer at nominal conditions (takes into account room heat gains)";

  Modelica.Blocks.Interfaces.RealInput TRoo_in_internal(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Needed to connect to conditional connector";
  Real qRel "Relative heat load = Q_flow/Q_flow_nominal";
  Modelica.SIunits.Temperature TOutOffSet
    "Effective outside temperature for heat transfer (takes into account room heat gains)";
  Real TSup_internal "Internal variable for more readable code";
equation
  connect(TRoo_in, TRoo_in_internal);
  if not use_TRoo_in then
    TRoo_in_internal = TRoo;
  end if;
  TOutOffSet = filter.y + dTOutHeaBal;
  // Relative heating load, compared to nominal conditions
  qRel = max(0, (TRoo_in_internal - TOutOffSet)*IDEAS.Utilities.Math.Functions.inverseXRegularized(TRoo_nominal -TOutOffSet_nominal, 0.01));

  TSup_internal = TRoo_in_internal +
                  ((TSup_nominal + TRet_nominal)/2 - TRoo_nominal)*qRel^(1/m) + (TSup_nominal - TRet_nominal)/2*qRel;
  TSup = if minSup then max(TSupMin, TSup_internal) else TSup_internal;
  TRet = TSup - qRel*(TSup_nominal - TRet_nominal);
  connect(TOut, filter.u) annotation (Line(
      points={{-120,60},{-44,60}},
      color={0,0,127},
      smooth=Smooth.None));
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
<p>
No specific example foreseen for the heating curve, see the 
<a href=\"modelica://IDEAS.Thermal.HeatingSystems.Examples\">heating system examples</a>. 
</p>
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
    Icon(graphics={Polygon(
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
end HeatingCurveFilter;
