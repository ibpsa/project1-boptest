within IDEAS.Fluid.HeatPumps.BaseClasses;
model HeatSource_HP_AW
  "Computation of theoretical condensation power of the refrigerant based on interpolation data.  Takes into account losses of the heat pump to the environment"
  //fixme: adaptation of heatSource_CondensingGasBurner should also be applied on this model.
  /*
  This model is based on data we received from Daikin from an Altherma heat pump.
  The nominal power of the original heat pump is 7177W at 2/35degC
   
  First, the thermal power and electricity consumption are interpolated for the 
  evaporator and condensing temperature at 4 different modulation levels.  The results
  are rescaled to the nominal power of the modelled heatpump (with QNom/QNom_data) and
  stored in 2 different vectors, Q_vector and P_vector.
  
  Finally, the modulation is calculated based on the asked power and the max power at 
  operating conditions: 
  - if modulation_init < modulation_min, the heat pump is OFF, modulation = 0.  
  - if modulation_init > 100%, the modulation is 100%
  - if modulation_init between modulation_min and modulation_start: hysteresis for on/off cycling.
  
  If the heat pump is on another modulation, interpolation is made to get P and Q at the real modulation.
  
  ATTENTION
  This model takes into account environmental heat losses of the heat pump (at condensor side).
  In order to keep the same nominal COP's during operation of the heat pump, these heat losses are added
  to the computed power.  Therefore, the heat losses are only really 'losses' when the heat pump is 
  NOT operating. 
  
  The COP is calculated as the heat delivered to the condensor divided by the electrical consumption (P). 
  
  */
  //protected
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";
  final parameter Modelica.SIunits.Power QNomRef=7177
    "Nominal power of the Daikin Altherma.  See datafile";
  final parameter Real[5] mod_vector={0,30,50,90,100} "5 modulation steps, %";
  Real[5] Q_vector "Thermal power for 5 modulation steps, in kW";
  Real[5] P_vector "Electrical power for 5 modulation steps, in kW";
  Modelica.SIunits.Power QMax
    "Maximum thermal power at specified evap and condr temperatures, in W";
  Modelica.SIunits.Power QAsked(start=0);
  parameter Modelica.SIunits.ThermalConductance UALoss
    "UA of heat losses of HP to environment";
  parameter Modelica.SIunits.Power QNom
    "The power at nominal conditions (2/35)";
public
  parameter Real modulation_min(max=29) = 20 "Minimal modulation percentage";
  // dont' set this to 0 or very low values, you might get negative P at very low modulations because of wrong extrapolation
  parameter Real modulation_start(min=min(30, modulation_min + 5)) = 35
    "Min estimated modulation level required for start of HP";
  Real modulationInit "Initial modulation, decides on start/stop of the HP";
  Real modulation(min=0, max=100) "Current modulation percentage";
  Modelica.SIunits.Power PEl "Resulting electrical power";
  input Modelica.SIunits.Temperature TEvaporator "Evaporator temperature";
  input Modelica.SIunits.Temperature TEnvironment
    "Temperature of environment for heat losses";
  input Modelica.SIunits.SpecificEnthalpy hIn "Specific enthalpy at the inlet";
  Modelica.Blocks.Tables.CombiTable2D P100(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, -15, -10, -7, -2, 2, 7, 12, 18, 30; 30, 1.96, 2.026, 2.041,
        2.068, 2.075, 2.28, 2.289, 2.277, 2.277; 35, 2.08, 2.174, 2.199, 2.245,
        2.266, 2.508, 2.537, 2.547, 2.547; 40, 2.23, 2.338, 2.374, 2.439, 2.473,
        2.755, 2.804, 2.838, 2.838; 45, 2.39, 2.519, 2.566, 2.65, 2.699, 3.022,
        3.091, 3.149, 3.149; 50, 2.56, 2.718, 2.777, 2.88, 2.942, 3.309, 3.399,
        3.481, 3.481])
    annotation (Placement(transformation(extent={{4,-14},{24,6}})));
  Modelica.Blocks.Tables.CombiTable2D P90(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, -15, -10, -7, -2, 2, 7, 12, 18, 30; 30, 1.76, 1.79, 1.8, 1.81,
        1.81, 1.94, 1.93, 1.9, 1.9; 35, 1.88, 1.96, 1.98, 1.98, 1.99, 2.19,
        2.16, 2.15, 2.15; 40, 2.01, 2.11, 2.14, 2.16, 2.18, 2.42, 2.4, 2.41,
        2.41; 45, 2.16, 2.28, 2.32, 2.39, 2.39, 2.66, 2.71, 2.69, 2.69; 50,
        2.32, 2.46, 2.51, 2.6, 2.61, 2.92, 2.99, 3.05, 3.05])
    annotation (Placement(transformation(extent={{4,-40},{24,-20}})));
  Modelica.Blocks.Tables.CombiTable2D P50(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, -15, -10, -7, -2, 2, 7, 12, 18, 30; 30, 1.14, 1.11, 1.09, 1.02,
        0.98, 0.98, 0.92, 0.81, 0.81; 35, 1.26, 1.24, 1.22, 1.16, 1.12, 1.14,
        1.09, 0.98, 0.98; 40, 1.39, 1.39, 1.37, 1.35, 1.28, 1.36, 1.28, 1.21,
        1.21; 45, 1.54, 1.55, 1.53, 1.49, 1.46, 1.52, 1.49, 1.38, 1.38; 50,
        1.68, 1.73, 1.72, 1.68, 1.66, 1.75, 1.72, 1.62, 1.62])
    annotation (Placement(transformation(extent={{4,-66},{24,-46}})));
  Modelica.Blocks.Tables.CombiTable2D P30(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, -15, -10, -7, -2, 2, 7, 12, 18, 30; 30, 0.78, 0.7, 0.62, 0.534,
        0.496, 0.494, 0.416, 0.388, 0.388; 35, 0.9, 0.82, 0.71, 0.602, 0.561,
        0.563, 0.477, 0.453, 0.453; 40, 1.04, 0.97, 0.88, 0.696, 0.65, 0.653,
        0.552, 0.531, 0.531; 45, 1.17, 1.13, 1.04, 0.86, 0.774, 0.773, 0.646,
        0.625, 0.625; 50, 1.35, 1.28, 1.23, 1.11, 0.96, 0.931, 0.765, 0.739,
        0.739])
    annotation (Placement(transformation(extent={{4,-92},{24,-72}})));
  Modelica.Blocks.Tables.CombiTable2D Q100(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, -15, -10, -7, -2, 2, 7, 12, 18, 30; 30, 4.82, 5.576, 6.023,
        6.892, 7.642, 10.208, 11.652, 13.518, 13.518; 35, 4.59, 5.279, 5.685,
        6.484, 7.177, 9.578, 10.931, 12.692, 12.692; 40, 4.43, 5.056, 5.43,
        6.174, 6.824, 9.1, 10.386, 12.072, 12.072; 45, 4.32, 4.906, 5.255,
        5.957, 6.576, 8.765, 10.008, 11.647, 11.647; 50, 4.27, 4.824, 5.155,
        5.828, 6.426, 8.564, 9.786, 11.408, 11.408])
    annotation (Placement(transformation(extent={{42,-14},{62,6}})));
  Modelica.Blocks.Tables.CombiTable2D Q90(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, -15, -10, -7, -2, 2, 7, 12, 18, 30; 30, 4.338, 5.019, 5.42,
        6.203, 6.877, 9.188, 10.486, 12.166, 12.166; 35, 4.131, 4.751, 5.117,
        5.836, 6.459, 8.62, 9.838, 11.423, 11.423; 40, 3.987, 4.551, 4.887,
        5.556, 6.141, 8.19, 9.348, 10.865, 10.865; 45, 3.888, 4.415, 4.73,
        5.361, 5.918, 7.888, 9.007, 10.483, 10.483; 50, 3.843, 4.342, 4.639,
        5.245, 5.784, 7.708, 8.807, 10.267, 10.267])
    annotation (Placement(transformation(extent={{42,-40},{62,-20}})));
  Modelica.Blocks.Tables.CombiTable2D Q50(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, -15, -10, -7, -2, 2, 7, 12, 18, 30; 30, 2.41, 2.788, 3.011,
        3.446, 3.821, 5.104, 5.826, 6.759, 6.759; 35, 2.295, 2.639, 2.843,
        3.242, 3.589, 4.789, 5.466, 6.346, 6.346; 40, 2.215, 2.528, 2.715,
        3.087, 3.412, 4.55, 5.193, 6.036, 6.036; 45, 2.16, 2.453, 2.628, 2.979,
        3.288, 4.382, 5.004, 5.824, 5.824; 50, 2.135, 2.412, 2.577, 2.914,
        3.213, 4.282, 4.893, 5.704, 5.704])
    annotation (Placement(transformation(extent={{42,-66},{62,-46}})));
  Modelica.Blocks.Tables.CombiTable2D Q30(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      table=[0, -15, -10, -7, -2, 2, 7, 12, 18, 30; 30, 1.446, 1.673, 1.807,
        2.068, 2.292, 3.063, 3.495, 4.055, 4.055; 35, 1.377, 1.584, 1.706,
        1.945, 2.153, 2.873, 3.279, 3.808, 3.808; 40, 1.329, 1.517, 1.629,
        1.852, 2.047, 2.73, 3.116, 3.622, 3.622; 45, 1.296, 1.472, 1.577, 1.787,
        1.973, 2.629, 3.002, 3.494, 3.494; 50, 1.281, 1.447, 1.546, 1.748,
        1.928, 2.569, 2.936, 3.422, 3.422])
    annotation (Placement(transformation(extent={{42,-92},{62,-72}})));
  Modelica.SIunits.HeatFlowRate QLossesToCompensate "Environment losses";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Controls.Discrete.HysteresisRelease_boolean
                                          onOff(
    enableRelease=true,
    y(start=0),
    release(start=false))
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=modulationInit)
    annotation (Placement(transformation(extent={{-24,70},{-2,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=modulation_start)
    annotation (Placement(transformation(extent={{-50,64},{-26,84}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=modulation_min)
    annotation (Placement(transformation(extent={{-76,54},{-52,74}})));
  Modelica.Blocks.Interfaces.RealInput TCondensor_set annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-110,
            -10},{-90,10}})));
  Modelica.Blocks.Interfaces.BooleanInput on annotation (Placement(
        transformation(extent={{-120,20},{-80,60}}), iconTransformation(extent={{-110,20},
            {-90,40}})));
  Modelica.Blocks.Interfaces.RealInput TCondensor_in
    "In-comming condensor temperature" annotation (Placement(transformation(
          extent={{-120,-60},{-80,-20}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-100})));
  Modelica.Blocks.Interfaces.RealInput m_flowCondensor
    "Condenor mass-flow rate" annotation (Placement(transformation(
          extent={{-120,-100},{-80,-60}}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-100})));
equation
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flowCondensor*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default,TCondensor_set, Medium.X_default)) -hIn), 10);
  P100.u1 = heatPort.T - 273.15;
  P100.u2 = TEvaporator - 273.15;
  P90.u1 = heatPort.T - 273.15;
  P90.u2 = TEvaporator - 273.15;
  P50.u1 = heatPort.T - 273.15;
  P50.u2 = TEvaporator - 273.15;
  P30.u1 = heatPort.T - 273.15;
  P30.u2 = TEvaporator - 273.15;
  Q100.u1 = heatPort.T - 273.15;
  Q100.u2 = TEvaporator - 273.15;
  Q90.u1 = heatPort.T - 273.15;
  Q90.u2 = TEvaporator - 273.15;
  Q50.u1 = heatPort.T - 273.15;
  Q50.u2 = TEvaporator - 273.15;
  Q30.u1 = heatPort.T - 273.15;
  Q30.u2 = TEvaporator - 273.15;
  // all these are in kW
  Q_vector[1] = 0;
  Q_vector[2] = Q30.y*QNom/QNomRef;
  Q_vector[3] = Q50.y*QNom/QNomRef;
  Q_vector[4] = Q90.y*QNom/QNomRef;
  Q_vector[5] = Q100.y*QNom/QNomRef;
  P_vector[1] = 0;
  P_vector[2] = P30.y*QNom/QNomRef;
  P_vector[3] = P50.y*QNom/QNomRef;
  P_vector[4] = P90.y*QNom/QNomRef;
  P_vector[5] = P100.y*QNom/QNomRef;
  QMax = 1000*Q100.y*QNom/QNomRef;
  modulationInit = QAsked/QMax*100;
  modulation = onOff.y*IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100,1);
  // compensation of heat losses (only when the hp is operating)
  QLossesToCompensate = if noEvent(modulation > 0) then UALoss*(heatPort.T -
    TEnvironment) else 0;
  heatPort.Q_flow = -1000*Modelica.Math.Vectors.interpolate(
    mod_vector,
    Q_vector,
    modulation) - QLossesToCompensate;
  PEl = 1000*Modelica.Math.Vectors.interpolate(
    mod_vector,
    P_vector,
    modulation);
  connect(realExpression.y, onOff.u) annotation (Line(
      points={{-0.9,80},{8,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression1.y, onOff.uHigh) annotation (Line(
      points={{-24.8,74},{0,74},{0,76},{8,76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression2.y, onOff.uLow) annotation (Line(
      points={{-50.8,64},{-24,64},{-24,64},{0,64},{0,72},{8,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(on, onOff.release) annotation (Line(
      points={{-100,40},{20,40},{20,68}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html>
<p><b>Description</b> </p>
<p>This&nbsp;model&nbsp;is&nbsp;based&nbsp;on&nbsp;data&nbsp;received&nbsp;from&nbsp;Daikin&nbsp;from&nbsp;an&nbsp;Altherma&nbsp;heat&nbsp;pump, and the full heat pump is implemented as <a href=\"modelica://IDEAS.Thermal.Components.Production.HP_AWMod_Losses\">IDEAS.Thermal.Components.Production.HP_AWMod_Losses</a>. (vermoedelijk <a href=\"Modelica://IDEAS.Thermal.Components.Production.HP_AirWater\">IDEAS.Thermal.Components.Production.HP_AirWater</a></p>
<p>The&nbsp;nominal&nbsp;power&nbsp;of&nbsp;the&nbsp;original&nbsp;heat&nbsp;pump&nbsp;is&nbsp;7177 W&nbsp;at&nbsp;2/35 degC.</p>
<p>First,&nbsp;the&nbsp;thermal&nbsp;power&nbsp;and&nbsp;electricity&nbsp;consumption&nbsp;are&nbsp;interpolated&nbsp;for&nbsp;the&nbsp;evaporator&nbsp;and&nbsp;condensing&nbsp;temperature&nbsp;at&nbsp;4&nbsp;different&nbsp;modulation&nbsp;levels.&nbsp;&nbsp;The&nbsp;results&nbsp;are&nbsp;rescaled&nbsp;to&nbsp;the&nbsp;nominal&nbsp;power&nbsp;of&nbsp;the&nbsp;modelled&nbsp;heatpump&nbsp;(with&nbsp;QNom/QNom_data)&nbsp;and&nbsp;stored&nbsp;in&nbsp;2&nbsp;different&nbsp;vectors,&nbsp;Q_vector&nbsp;and&nbsp;P_vector.</p>
<p>Finally,&nbsp;the&nbsp;modulation&nbsp;is&nbsp;calculated&nbsp;based&nbsp;on&nbsp;the&nbsp;asked&nbsp;power&nbsp;and&nbsp;the&nbsp;max&nbsp;power&nbsp;at&nbsp;operating&nbsp;conditions:&nbsp;</p>
<ul>
<li>if&nbsp;modulation_init&nbsp;&lt;&nbsp;modulation_min,&nbsp;the&nbsp;heat&nbsp;pump&nbsp;is&nbsp;OFF,&nbsp;modulation&nbsp;=&nbsp;0.&nbsp;&nbsp;</li>
<li>if&nbsp;modulation_init&nbsp;&gt;&nbsp;100%,&nbsp;the&nbsp;modulation&nbsp;is&nbsp;100%</li>
<li>if&nbsp;modulation_init&nbsp;between&nbsp;modulation_min&nbsp;and&nbsp;modulation_start:&nbsp;hysteresis&nbsp;for&nbsp;on/off&nbsp;cycling.</li>
</ul>
<p>If&nbsp;the&nbsp;heat&nbsp;pump&nbsp;is&nbsp;on&nbsp;another&nbsp;modulation level, interpolation&nbsp;is&nbsp;made&nbsp;to&nbsp;get&nbsp;P&nbsp;and&nbsp;Q&nbsp;at&nbsp;the&nbsp;real&nbsp;modulation.</p>
<h4>ATTENTION</h4>
<p>This&nbsp;model&nbsp;takes&nbsp;into&nbsp;account&nbsp;environmental&nbsp;heat&nbsp;losses&nbsp;of&nbsp;the&nbsp;heat pump.&nbsp;&nbsp;In&nbsp;order&nbsp;to&nbsp;keep&nbsp;the&nbsp;same&nbsp;nominal&nbsp;efficiency&nbsp;during&nbsp;operation,&nbsp;these&nbsp;heat&nbsp;losses&nbsp;are&nbsp;added&nbsp;to&nbsp;the&nbsp;computed&nbsp;power.&nbsp;&nbsp;Therefore,&nbsp;the&nbsp;heat&nbsp;losses&nbsp;are&nbsp;only&nbsp;really&nbsp;&apos;losses&apos;&nbsp;when&nbsp;the&nbsp;heat pump&nbsp;is&nbsp;NOT&nbsp;operating.&nbsp;</p>
<p>The&nbsp;COP&nbsp;is&nbsp;calculated&nbsp;as&nbsp;the&nbsp;heat&nbsp;delivered&nbsp;to&nbsp;the&nbsp;condensor&nbsp;divided&nbsp;by&nbsp;the&nbsp;electrical&nbsp;consumption&nbsp;(P).</p>
<h4>Assumptions and limitations </h4>
<ol>
<li>Based on interpolation in manufacturer data for Daikin Altherma heat pump</li>
<li>Ensure not to operate the heat pump outside of the manufacturer data. No check is made if this happens, and this can lead to strange and wrong results.</li>
</ol>
<h4>Model use</h4>
<p>This model is used in the <a href=\"Modelica://IDEAS.Thermal.Components.Production.HP_AirWater\">HP_AirWater</a> model. If a different heat pump is to be simulated, copy this model and adapt the interpolation tables.</p>
<h4>Validation </h4>
<p>See the air-water heat pmp model. </p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Line(
          points={{-70,-20},{30,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-70,20},{30,20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-90,0},{-70,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-90,0},{-70,20}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{30,0},{30,40},{60,20},{30,0}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-40},{30,0},{60,-20},{30,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,40},{80,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,-40},{30,60}},
          color={0,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{24,74},{44,54},{40,50},{20,70},{24,74}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135})}));
end HeatSource_HP_AW;
