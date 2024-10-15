within IDEAS.Fluid.HeatPumps;
model HP_AirWater_TSet "Air-to-water heat pump with temperature set point"


  extends IDEAS.Fluid.HeatPumps.Interfaces.PartialDynamicHeaterWithLosses(
    final allowFlowReversal=false);
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-82,66},{-62,86}})));

  parameter Modelica.SIunits.Power QDesign=0
    "Overrules QNom if different from 0. Design heat load, typically at -8 or -10 degC in Belgium.  ";
  parameter Real fraLosDesNom=0.68
    "Ratio of power at design conditions over power at 2/35degC";
  parameter Real betaFactor=0.8 "Relative sizing compared to design heat load";
  final parameter SI.Power QNomFinal=if abs(QDesign) < Modelica.Constants.small then QNom else QDesign/
      fraLosDesNom*betaFactor "Used nominal power in the heatSource model";
  parameter Real modulation_min=20 "Minimal modulation percentage";
  parameter Real modulation_start=35
    "Min estimated modulation level required for start of HP";
  Real COP "Instanteanous COP";

  Real modulation(max=100) = IDEAS.Utilities.Math.Functions.smoothMax(0, heatSource.modulation, 1)
    "Current modulation percentage";

  replaceable IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW heatSource
  constrainedby IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW2(
    final QNom=QNomFinal,
    final TEvaporator=sim.Te,
    final TEnvironment=heatPort.T,
    final UALoss=UALoss,
    final modulation_min=modulation_min,
    final modulation_start=modulation_start,
    final hIn=inStream(port_a.h_outflow),
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-16},{-40,4}})));

  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-20,-16},{0,4}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-40,20},{-60,40}})));
equation
  PEl = heatSource.PEl;
  COP =if noEvent(PEl > 0) then vol.heatPort.Q_flow/PEl else 0;

  connect(TSet, heatSource.TCondensor_set) annotation (Line(
      points={{-106,0},{-84,0},{-84,-6},{-60,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo.m_flow, heatSource.m_flowCondensor) annotation (Line(
      points={{40,-49},{40,-38},{-52,-38},{-52,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tin.T, heatSource.TCondensor_in) annotation (Line(
      points={{70,-49},{70,-42},{-55,-42},{-55,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource.heatPort, heatFlowSensor.port_a) annotation (Line(
      points={{-40,-6},{-20,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatFlowSensor.port_b, vol.heatPort) annotation (Line(
      points={{0,-6},{16,-6},{16,-20},{10,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(booleanExpression.y, heatSource.on) annotation (Line(
      points={{-61,30},{-76,30},{-76,-3},{-60,-3}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Polygon(
          points={{-52,100},{-32,100},{-32,80},{28,80},{28,-80},{-2,-80},{-2,
              -72},{-12,-80},{-22,-72},{-22,-80},{-52,-80},{-52,100}},
          smooth=Smooth.None,
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{78,70},{78,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{96,60},{80,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{96,-60},{80,-60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{78,-50},{78,-70}},
          color={0,0,127},
          smooth=Smooth.None),
        Ellipse(extent={{-82,50},{-22,-10}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,20},{-70,20},{-42,32},{-62,8},{-34,20},{-22,20}},
          color={0,127,255},
          smooth=Smooth.None),
        Ellipse(extent={{-2,-10},{58,-70}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-2,-40},{10,-40},{38,-28},{18,-52},{40,-44},{40,-60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{80,-50},{80,-70}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{80,70},{80,50}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-22,20},{-12,20},{-32,-40},{-100,-40}},
          color={0,127,255},
          smooth=Smooth.None),
        Line(
          points={{-2,-40},{-12,-40},{20,60},{78,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-22,-72},{-22,-88},{-2,-72},{-2,-88},{-22,-72}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-52,-10},{-52,-80},{-22,-80}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{-2,-80},{28,-80},{28,-70}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{-52,50},{-52,100},{-32,100}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{28,-10},{28,80},{8,80}},
          smooth=Smooth.None,
          color={0,0,0}),
        Polygon(
          points={{-22,120},{-2,120},{6,118},{8,110},{8,70},{6,62},{-2,60},{-22,
              60},{-30,62},{-32,70},{-32,110},{-30,118},{-22,120}},
          smooth=Smooth.None,
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{12,100},{8,110}},
          lineColor={95,95,95},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,-60},{78,-60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-80,20},{-160,20},{-160,0},{-100,0},{-100,-20},{-160,-20},{
              -160,-40},{-80,-40}},
          color={0,127,255},
          smooth=Smooth.None),
        Line(
          points={{-152,30},{-152,-52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-142,30},{-142,-52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-132,30},{-132,-52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-122,30},{-122,-52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-112,30},{-112,-52}},
          color={0,0,0},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<h4>Description </h4>
<p>Dynamic heat pump model, based on interpolation in performance tables for a Daikin Altherma heat pump. These tables are encoded in the <a href=\"modelica://IDEAS.Thermal.Components.Production.BaseClasses.HeatSource_HP_AW\">heatSource</a> model. If a different heat pump is to be simulated, create a different heatSource model with adapted interpolation tables.</p>
<p>The nominal power of the heat pump can be adapted, this will NOT influence the efficiency as a function of ambient air temperature, condenser temperature and modulation level. </p>
<p>The heat pump has thermal losses to the environment which are often not mentioned in the performance tables. Therefore, the additional environmental heat losses are added to the heat production in order to ensure the same performance as in the manufacturers data, while still obtaining a dynamic model with heat losses (also when heat pump is off). The heatSource will compute the required power and the environmental heat losses, and try to reach the set point. </p>
<p>See<a href=\"modelica://IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses\"> IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses</a> for more details about the heat losses and dynamics. </p>
<h4>Assumptions and limitations </h4>
<ol>
<li>Dynamic model based on water content and lumped dry capacity</li>
<li>Inverter controlled heat pump with limited power (based on QNom and interpolation tables in heatSource) </li>
<li>Heat losses to environment which are compensated &apos;artifically&apos; to meet the manufacturers data in steady state conditions</li>
<li>No defrosting taken into account</li>
<li>No enforced min on or min off time; Hysteresis on start/stop thanks to different parameters for minimum modulation to start and stop the heat pump</li>
</ol>
<h4>Model use</h4>
<p>This model is based on performance tables of a specific heat pump, as specified by the <a href=\"modelica://IDEAS.Thermal.Components.Production.BaseClasses.HeatSource_HP_AW\">heatSource</a> model. If a different heat pump is to be simulated, create a different heatSource model with adapted interpolation tables.</p>
<ol>
<li>Specify medium and initial temperature (of the water + dry mass)</li>
<li>Specify the nominal power QNom. There are two options: (1) specify QNom and put QDesign = 0 or (2) specify QDesign greater than 0 and QNom wil be calculated from QDesign as follows:</li>
<li>QNom = QDesign * betaFactor / fraLosDesNom</li>
<li>Connect TSet, the flowPorts and the heatPort to environment. </li>
<li>Specify the minimum required modulation level for the boiler to start (modulation_start) and the minimum modulation level when the boiler is operating (modulation_min). The difference between both will ensure some off-time in case of low heat demands</li>
</ol>
<p>See also<a href=\"modelica://IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses\"> IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses</a> for more details about the heat losses and dynamics. </p>
<h4>Validation </h4>
<p>The model has been verified in order to check if the &apos;artificial&apos; heat loss compensation still leads to correct steady state efficiencies according to the manufacturer data. This verification is integrated in the example model <a href=\"modelica://IDEAS.Thermal.Components.Examples.Boiler_validation\">IDEAS.Thermal.Components.Examples.Boiler_validation</a>.</p>
<h4>Example</h4>
<p>A specific heat pump example is given in <a href=\"modelica://IDEAS.Thermal.Components.Examples.HeatPump_AirWater\">IDEAS.Thermal.Components.Examples.HeatPump_AirWater</a>.</p>
</html>", revisions="<html>
<ul>
<li>
September 10, 2020 by Filip Jorissen:<br/>
Fixed real equality comparison for
<a href=\"https://github.com/open-ideas/IDEAS/issues/1172\">#1172</a>.
</li>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>2014 March, Filip Jorissen, Annex60 compatibility</li>
<li>2013 May, Roel De Coninck: propagation of heatSource parameters and better definition of QNom used.  Documentation and example added</li>
<li>2011 Roel De Coninck: first version</li>
</ul>
</html>"));
end HP_AirWater_TSet;
