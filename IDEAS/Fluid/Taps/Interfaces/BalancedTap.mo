within IDEAS.Fluid.Taps.Interfaces;
partial model BalancedTap "partial DHW model"
  import IDEAS;

  parameter Modelica.SIunits.Temperature TDHWSet(max=273.15 + 60) = 273.15 + 45
    "DHW temperature setpoint";
  parameter Modelica.SIunits.Temperature TCold=273.15 + 10
    "Nominal cold water temperature";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";

protected
  Modelica.SIunits.MassFlowRate mFlo60C "DHW flow rate at 60 degC";
  parameter SI.Time tau=30
    "Tin time constant of temperature sensor at nominal flow rate";

public
  Modelica.Fluid.Interfaces.FluidPort_a port_hot(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));

  Modelica.Blocks.Sources.RealExpression TCold_expr(y=TCold)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_cold(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);

  IDEAS.Fluid.Sensors.TemperatureTwoPort THot(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=tau) annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));

  IDEAS.Fluid.Interfaces.IdealSource idealSource(
    redeclare package Medium = Medium,
    control_m_flow=true,
    allowFlowReversal=false,
    control_dp=false)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    nPorts=2,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    final massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    V=1) "Mixing volume for heat injection"
    annotation (Placement(transformation(extent={{60,0},{80,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

  Modelica.SIunits.Temperature TDHW_actual = min(THot.T,TDHWSet);
  Modelica.Blocks.Sources.RealExpression mFloCor(y=mFlo60C*(273.15 + 60 - TCold)
        /(TDHWSet - TCold)) "Corrected desired mass flow rate for TDHWSet"
    annotation (Placement(transformation(extent={{-84,76},{-22,96}})));
  Modelica.Blocks.Sources.RealExpression deltaT(y=THot.T - TCold) "THot-TCold"
    annotation (Placement(transformation(extent={{-84,62},{-58,82}})));
  IDEAS.Utilities.Math.SmoothMax deltaT_with_smoothmax(deltaX=0.1)
    annotation (Placement(transformation(extent={{-46,56},{-28,74}})));
  Modelica.Blocks.Sources.RealExpression minValTemDif(y=0.1)
    "minimal value of the temperature difference, to avoid division by zero."
    annotation (Placement(transformation(extent={{-66,48},{-58,64}})));
  Modelica.Blocks.Sources.RealExpression mFloHot_intermediate(y=mFlo60C*(273.15 +
        60 - TCold)/(deltaT_with_smoothmax.y))
    "Requied mass flow rate based on current THot"
    annotation (Placement(transformation(extent={{-84,28},{-20,50}})));
  IDEAS.Utilities.Math.SmoothMin mFloHot(deltaX=1e-3*m_flow_nominal)
    "Hot and cold water flowrate"
    annotation (Placement(transformation(extent={{0,34},{18,52}})));
equation
  connect(port_hot, THot.port_a) annotation (Line(
      points={{-100,4.44089e-16},{-88,4.44089e-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(idealSource.port_a, THot.port_b) annotation (Line(
      points={{30,0},{-68,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(preTem.port, vol.heatPort) annotation (Line(
      points={{40,-30},{60,-30},{60,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TCold_expr.y, preTem.T) annotation (Line(
      points={{-19,-30},{18,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(deltaT.y,deltaT_with_smoothmax. u1) annotation (Line(
      points={{-56.7,72},{-52,72},{-52,70.4},{-47.8,70.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(minValTemDif.y,deltaT_with_smoothmax. u2) annotation (Line(
      points={{-57.6,56},{-52,56},{-52,59.6},{-47.8,59.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFloHot_intermediate.y, mFloHot.u2) annotation (Line(
      points={{-16.8,39},{-6.4,39},{-6.4,37.6},{-1.8,37.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFloCor.y, mFloHot.u1) annotation (Line(
      points={{-18.9,86},{-8,86},{-8,48.4},{-1.8,48.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFloHot.y, idealSource.m_flow_in) annotation (Line(
      points={{18.9,43},{34,43},{34,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(idealSource.port_b, vol.ports[1])
    annotation (Line(points={{50,0},{68,0}}, color={0,127,255}));
  connect(vol.ports[2], port_cold)
    annotation (Line(points={{72,0},{100,0}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=
            false), graphics={
        Line(
          points={{-20,30},{20,-30},{-20,-30},{20,30},{-20,30}},
          color={0,0,127},
          smooth=Smooth.None,
          origin={-50,0},
          rotation=-90),
        Line(
          points={{0,40},{0,0},{0,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-20,40},{20,40},{14,80},{-16,80},{-20,40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-20,30},{20,-30},{-20,-30},{20,30},{-20,30}},
          color={0,0,127},
          smooth=Smooth.None,
          origin={50,0},
          rotation=-90),
        Line(
          points={{-20,0},{20,0},{20,-2}},
          color={0,0,127},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<h4>Description</h4>
<p>
Partial model of a domestic hot water (DHW) system composed mainly of a thermostatic mixing valve. 
The model foresees a cold water flowPort which has to be connected to the system (eg. storage tank).
</p>
<p>
The model has two flowPorts and a realInput:
</p>
<ul>
<li><i>port_hot</i>: connection to the hot water source (designation: <i>hot</i>)</li>
<li><i>port_cold</i>: connection to the inlet of cold water in the hot water source (designation: <i>cold</i>)</li>
<li><i>mDHW60C</i>: desired flowrate of DHW water, equivalent at 60&deg;C</li>
</ul>
<p>
In a first step, the desired DHW flow rate at 60&deg;C is corrected for the set temperature <i>TDHWSet</i>. 
The model tries to reach the given DHW flow rate at a the desired mixing temperature <i>TDHWSet </i>by mixing the hot water with cold water. 
The resulting hot flowrate will be extracted automatically from the hot source, 
and through the connection of port_cold to the hot source, this same flow rate will be injected (at TCold) in the production system. 
</p>
<p>
There are currently two implementations of this partial model:
</p>
<ol>
<li><a href=\"modelica://IDEAS.Thermal.Components.Domestic_Hot_Water.DHW_ProfileReader\">Reading in mDHW60c from a table</a></li>
<li><a href=\"modelica://IDEAS.Thermal.Components.Domestic_Hot_Water.DHW_RealInput\">Getting mDHW60c from a realInput</a></li>
</ol>
<h4>Assumptions and limitations </h4>
<ol>
<li>No heat losses</li>
<li>Inertia is foreseen through the inclusion of a water volume on the hot water side (default=1 liter). This parameter is not propagated to the interface, but it can be changed by modifying pumpHot.m. Putting this water content to zero may lead to numerical problems (not tested)</li>
<li>If THot is smaller than TDHWSEt, there is no mixing and TMixed = THot</li>
<li>Fixed TDHWSet and TCold as parameters</li>
<li>The mixed DHW is not available as an outlet or flowPort, it is assumed to be &apos;consumed&apos;. </li>
</ol>
<h4>Model use</h4>
<ol>
<li>Set the parameters for cold water temperature and the DHW set temperature (mixed)</li>
<li>Connect <i>port_hot </i>to the hot water source</li>
<li>Connect <i>port_</i>c<i>old</i> to the cold water inlet of the hot water source</li>
<li>Depending on the implementation: fill out the table or provide a realInput for <i>mDHW60C</i></li>
<li>Thanks to the use of <a href=\"modelica://IDEAS.Thermal.Components.BaseClasses.Ambient\">ambient</a> components in this model, it is <b>NOT</b> required to add additional pumps, ambients or AbsolutePressure to the DHW circuit.</li>
</ol>
<h4>Validation </h4>
<p>The model is verified to work properly by simulation of the different operating conditions.</p>
<h4>Examples</h4>
<p>
An example of this model is given in 
<a href=\"IDEAS.Fluid.Domestic_Hot_Water.Examples.DHW_example\">IDEAS.Fluid.Domestic_Hot_Water.Examples.DHW_example</a> and 
<a href=\"modelica://IDEAS.Thermal.Components.Examples.StorageTank_DHW_HP\">IDEAS.Thermal.Components.Examples.StorageTank_DHW_HP</a>.
</p>
</html>", revisions="<html>
<ul>
<li>2013 June, Roel De Coninck: documentation.</li>
<li>2012 September, Roel De Coninck, simplification of equations.</li>
<li>2012 August, Roel De Coninck, first implementation.</li>
</ul>
</html>"));
end BalancedTap;
