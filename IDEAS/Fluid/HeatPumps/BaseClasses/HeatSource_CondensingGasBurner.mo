within IDEAS.Fluid.HeatPumps.BaseClasses;
model HeatSource_CondensingGasBurner
  "Burner for use in Boiler, based on interpolation data.  Takes into account losses of the boiler to the environment"
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";
  final parameter Real[6] modVector={0,20,40,60,80,100} "6 modulation steps, %";
  Real eta "Instantaneous efficiency of the boiler (higher heating value)";
  Real[6] etaVector
    "Thermal efficiency (higher heating value) for 6 modulation steps, base 1";
  Real[6] QVector "Thermal power for 6 modulation steps, in kW";
  Modelica.SIunits.Power QMax
    "Maximum thermal power at specified evap and condr temperatures, in W";
  Modelica.SIunits.Power QAsked(start=0);
  parameter Modelica.SIunits.ThermalConductance UALoss
    "UA of heat losses of HP to environment";
  parameter Modelica.SIunits.Power QNom "The power at nominal conditions";
  final parameter Modelica.SIunits.Power QNom0 = 10100
    "Nominal power of the boiler from which the power data are used in this model";
  constant Real etaNom=0.922
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin(max=29) = 10 "Minimal modulation percentage";
  parameter Real modulationStart(min=min(30, modulationMin + 5)) = 20
    "Min estimated modulation level required for start of HP";
  Real modulationInit "Initial modulation, decides on start/stop of the boiler";
  Real modulation(min=0, max=1) "Current modulation percentage";
  Modelica.SIunits.Power PFuel "Resulting fuel consumption";
  input Modelica.SIunits.Temperature THxIn "Condensor temperature";
  input Modelica.SIunits.Temperature TBoilerSet
    "Condensor setpoint temperature.  Not always possible to reach it";
  input Modelica.SIunits.MassFlowRate m_flowHx "Condensor mass flow rate";
  input Modelica.SIunits.Temperature TEnvironment
    "Temperature of environment for heat losses";
  input Modelica.SIunits.SpecificEnthalpy hIn "Specific enthalpy at the inlet";
protected
  Real m_flowHx_scaled = IDEAS.Utilities.Math.Functions.smoothMax(x1=m_flowHx, x2=0,deltaX=0.001) * QNom0/QNom
    "mass flow rate, scaled with the original and the actual nominal power of the boiler";
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";
  Modelica.Blocks.Tables.CombiTable2D eta100(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, 100, 400, 700, 1000, 1300; 20.0, 0.9015, 0.9441, 0.9599, 0.9691,
        0.9753; 30.0, 0.8824, 0.9184, 0.9324, 0.941, 0.9471; 40.0, 0.8736,
        0.8909, 0.902, 0.9092, 0.9143; 50.0, 0.8676, 0.8731, 0.8741, 0.8746,
        0.8774; 60.0, 0.8, 0.867, 0.8681, 0.8686, 0.8689; 70.0, 0.8, 0.8609,
        0.8619, 0.8625, 0.8628; 80.0, 0.8, 0.8547, 0.8558, 0.8563, 0.8566])
    annotation (Placement(transformation(extent={{-58,66},{-38,86}})));
  Modelica.Blocks.Tables.CombiTable2D eta80(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, 100, 400, 700, 1000, 1300; 20.0, 0.9155, 0.9587, 0.9733, 0.9813,
        0.9866; 30.0, 0.8937, 0.9311, 0.9449, 0.953, 0.9585; 40.0, 0.8753,
        0.9007, 0.9121, 0.9192, 0.9242; 50.0, 0.8691, 0.8734, 0.8755, 0.8804,
        0.884; 60.0, 0.8628, 0.8671, 0.8679, 0.8683, 0.8686; 70.0, 0.7415,
        0.8607, 0.8616, 0.862, 0.8622; 80.0, 0.6952, 0.8544, 0.8552, 0.8556,
        0.8559])
    annotation (Placement(transformation(extent={{-58,32},{-38,52}})));
  Modelica.Blocks.Tables.CombiTable2D eta60(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, 100, 400, 700, 1000, 1300; 20.0, 0.9349, 0.9759, 0.9879, 0.9941,
        0.998; 30.0, 0.9096, 0.9471, 0.9595, 0.9664, 0.9709; 40.0, 0.8831,
        0.9136, 0.9247, 0.9313, 0.9357; 50.0, 0.8701, 0.8759, 0.8838, 0.8887,
        0.8921; 60.0, 0.8634, 0.8666, 0.8672, 0.8675, 0.8677; 70.0, 0.8498,
        0.8599, 0.8605, 0.8608, 0.861; 80.0, 0.8488, 0.8532, 0.8538, 0.8541,
        0.8543])
    annotation (Placement(transformation(extent={{-58,-6},{-38,14}})));
  Modelica.Blocks.Tables.CombiTable2D eta40(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, 100, 400, 700, 1000, 1300; 20.0, 0.9624, 0.9947, 0.9985, 0.9989,
        0.999; 30.0, 0.9333, 0.9661, 0.9756, 0.9803, 0.9833; 40.0, 0.901,
        0.9306, 0.94, 0.9451, 0.9485; 50.0, 0.8699, 0.8871, 0.8946, 0.8989,
        0.9018; 60.0, 0.8626, 0.8647, 0.8651, 0.8653, 0.8655; 70.0, 0.8553,
        0.8573, 0.8577, 0.8579, 0.8581; 80.0, 0.8479, 0.8499, 0.8503, 0.8505,
        0.8506])
    annotation (Placement(transformation(extent={{-58,-44},{-38,-24}})));
  Modelica.Blocks.Tables.CombiTable2D eta20(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, 100, 400, 700, 1000, 1300; 20.0, 0.9969, 0.9987, 0.999, 0.999,
        0.999; 30.0, 0.9671, 0.9859, 0.99, 0.9921, 0.9934; 40.0, 0.9293, 0.9498,
        0.9549, 0.9575, 0.9592; 50.0, 0.8831, 0.9003, 0.9056, 0.9083, 0.9101;
        60.0, 0.8562, 0.857, 0.8575, 0.8576, 0.8577; 70.0, 0.8398, 0.8479,
        0.8481, 0.8482, 0.8483; 80.0, 0.8374, 0.8384, 0.8386, 0.8387, 0.8388])
    annotation (Placement(transformation(extent={{-58,-86},{-38,-66}})));
  Modelica.SIunits.HeatFlowRate QLossesToCompensate "Environment losses";
  Integer i "Integer to select data interval";
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Controls.Discrete.HysteresisRelease     onOff(
    use_input=false,
    enableRelease=true,
    uLow_val=modulationMin,
    uHigh_val=modulationStart,
    y(start=0),
    release(start=0))
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=modulationInit)
    annotation (Placement(transformation(extent={{-12,20},{8,40}})));
algorithm
  // efficiency coefficients
  eta100.u1 :=THxIn - 273.15;
  eta100.u2 :=m_flowHx_scaled*kgps2lph;
  eta80.u1 :=THxIn - 273.15;
  eta80.u2 :=m_flowHx_scaled*kgps2lph;
  eta60.u1 :=THxIn - 273.15;
  eta60.u2 :=m_flowHx_scaled*kgps2lph;
  eta40.u1 :=THxIn - 273.15;
  eta40.u2 :=m_flowHx_scaled*kgps2lph;
  eta20.u1 :=THxIn - 273.15;
  eta20.u2 :=m_flowHx_scaled*kgps2lph;
  // all these are in kW
  etaVector[1] :=0;
  etaVector[2] :=eta20.y;
  etaVector[3] :=eta40.y;
  etaVector[4] :=eta60.y;
  etaVector[5] :=eta80.y;
  etaVector[6] :=eta100.y;
  QVector :=etaVector/etaNom .* modVector/100*QNom;
  // in W
  QMax :=QVector[6];
  // Interpolation if  QVector[1]<QAsked<QVector[6], other wise extrapolation with slope = 0
  i := 1;
  for j in 1:6-1 loop
    if QAsked > QVector[j] then
      i := j;
    end if;
  end for;
  modulationInit :=
    IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=QAsked,
    x1=QVector[i],
    x2=QVector[i + 1],
    y1=modVector[i],
    y2=modVector[i + 1],
    y1d=0,
    y2d=0);
  modulation :=onOff.y*min(modulationInit, 100);
  eta :=IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=modulation,
    x1=modVector[i],
    x2=modVector[i + 1],
    y1=etaVector[i],
    y2=etaVector[i + 1],
    y1d=0,
    y2d=0);
  heatPort.Q_flow :=-
    IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=modulation,
    x1=modVector[i],
    x2=modVector[i + 1],
    y1=QVector[i],
    y2=QVector[i + 1],
    y1d=0,
    y2d=0) - onOff.y*QLossesToCompensate;
equation
  assert(TBoilerSet < 80+273.15 and TBoilerSet > 20 + 273.15, "The given set point temperature is not inside the covered range (20 -> 80 degC)");
  assert(m_flowHx_scaled*kgps2lph < 1300, "The given mass flow rate is outside the allowed range. Make sure that the mass flow
  is positive and not too high. The current mass flow equals " + String(m_flowHx) + " [kg/s] but its maximum value is for the chosen QNom is " + String(1300*QNom/QNom0/kgps2lph));
  onOff.release = if noEvent(m_flowHx > Modelica.Constants.eps) then 1.0 else 0.0;
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flowHx*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default,TBoilerSet, Medium.X_default)) -hIn), 10);
  // compensation of heat losses (only when the hp is operating)
  QLossesToCompensate = if noEvent(modulation > 0) then UALoss*(heatPort.T -
    TEnvironment) else 0;
  PFuel = if onOff.release > 0.5 and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;
  connect(realExpression.y, onOff.u) annotation (Line(
      points={{9,30},{18,30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html>
<p><b>Description</b> </p>
<p>This&nbsp;model&nbsp;is&nbsp;based&nbsp;on&nbsp;data&nbsp;from&nbsp;a Remeha boiler. It is used in the <a href=\"modelica://IDEAS.Thermal.Components.Production.Boiler\">Boiler</a> model. </p>
<p>The&nbsp;nominal&nbsp;power&nbsp;of&nbsp;the&nbsp;original&nbsp;boiler&nbsp;is&nbsp;10.1&nbsp;kW&nbsp;at &nbsp;50/30 degC&nbsp;water&nbsp;temperatures.&nbsp;&nbsp;&nbsp;The&nbsp;efficiency&nbsp;in&nbsp;this&nbsp;point&nbsp;is&nbsp;92.2%&nbsp;on&nbsp;higher&nbsp;heating&nbsp;value.&nbsp;</p>
<p>First,&nbsp;the&nbsp;efficiency&nbsp;is&nbsp;interpolated&nbsp;for&nbsp;the&nbsp;&nbsp;return&nbsp;water&nbsp;temperature&nbsp;and&nbsp;flowrate&nbsp;at&nbsp;5&nbsp;different&nbsp;modulation&nbsp;levels.&nbsp;These&nbsp;modulation&nbsp;levels&nbsp;are&nbsp;the&nbsp;FUEL&nbsp;input&nbsp;power&nbsp;to&nbsp;the&nbsp;boiler.&nbsp;&nbsp;The&nbsp;results&nbsp;&nbsp;are&nbsp;rescaled&nbsp;to&nbsp;the&nbsp;nominal&nbsp;power&nbsp;of&nbsp;the&nbsp;modelled&nbsp;heatpump&nbsp;(with&nbsp;QNom/QNom_data)&nbsp;and&nbsp;&nbsp;stored&nbsp;in&nbsp;a&nbsp;vector,&nbsp;eta_vector.</p>
<p>Finally,&nbsp;the&nbsp;initial&nbsp;modulation&nbsp;is&nbsp;calculated&nbsp;based&nbsp;on&nbsp;the&nbsp;asked&nbsp;power&nbsp;and&nbsp;the&nbsp;max&nbsp;power&nbsp;at&nbsp;&nbsp;operating&nbsp;conditions:&nbsp;</p>
<ul>
<li>&nbsp;&nbsp;if&nbsp;modulation_init&nbsp;&lt;&nbsp;modulation_min,&nbsp;the&nbsp;boiler&nbsp;is&nbsp;OFF,&nbsp;modulation&nbsp;=&nbsp;0.&nbsp;&nbsp;</li>
<li>&nbsp;&nbsp;if&nbsp;modulation_init&nbsp;&gt;&nbsp;100%,&nbsp;the&nbsp;modulation&nbsp;is&nbsp;100%</li>
<li>&nbsp;&nbsp;if&nbsp;modulation_init&nbsp;between&nbsp;modulation_min&nbsp;and&nbsp;modulation_start:&nbsp;hysteresis&nbsp;for&nbsp;on/off&nbsp;cycling.</li>
</ul>
<p>If&nbsp;the&nbsp;boiler&nbsp;is&nbsp;on&nbsp;another&nbsp;modulation,&nbsp;interpolation&nbsp;is&nbsp;made&nbsp;to&nbsp;get&nbsp;eta&nbsp;at&nbsp;the&nbsp;real&nbsp;modulation.</p>
<h4>ATTENTION</h4>
<p>This&nbsp;model&nbsp;takes&nbsp;into&nbsp;account&nbsp;environmental&nbsp;heat&nbsp;losses&nbsp;of&nbsp;the&nbsp;boiler.&nbsp;&nbsp;In&nbsp;order&nbsp;to&nbsp;keep&nbsp;the&nbsp;same&nbsp;nominal&nbsp;eta&apos;s&nbsp;during&nbsp;operation,&nbsp;these&nbsp;heat&nbsp;losses&nbsp;are&nbsp;added&nbsp;to&nbsp;the&nbsp;computed&nbsp;power.&nbsp;&nbsp;Therefore,&nbsp;the&nbsp;heat&nbsp;losses&nbsp;are&nbsp;only&nbsp;really&nbsp;&apos;losses&apos;&nbsp;when&nbsp;the&nbsp;boiler&nbsp;is&nbsp;NOT&nbsp;operating.&nbsp;</p>
<p>The&nbsp;eta&nbsp;is&nbsp;calculated&nbsp;as&nbsp;the&nbsp;heat&nbsp;delivered&nbsp;to&nbsp;the&nbsp;heatedFluid&nbsp;divided&nbsp;by&nbsp;the&nbsp;fuel&nbsp;consumption&nbsp;PFuel.&nbsp;</p>
<h4>Assumptions and limitations </h4>
<ol>
<li>Based on interpolation in manufacturer data for Remeha condensing gas boiler</li>
</ol>
<h4>Model use</h4>
<p>This model is used in the <a href=\"modelica://IDEAS.Thermal.Components.Production.Boiler\">Boiler</a> model. If a different gas boiler is to be simulated, copy this Burner model and adapt the interpolation tables.</p>
<h4>Validation </h4>
<p>See the <a href=\"modelica://IDEAS.Thermal.Components.Production.Boiler\">Boiler</a> model. </p>
</html>", revisions="<html>
<ul>
<li>2014 May, Damien Picard: change Modelica.Math.Interpolate to IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation in order to remove non-differentiable equations </li>
<li>2014 May, Damien Picard: correct bug introduced during conversion to Annex on the QAsked </li>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011 August, Roel De Coninck: first version</li>
</ul>
</html>"));
end HeatSource_CondensingGasBurner;
