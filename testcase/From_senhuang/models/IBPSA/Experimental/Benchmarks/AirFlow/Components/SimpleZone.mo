within IBPSA.Experimental.Benchmarks.AirFlow.Components;
model SimpleZone "A room as a thermal zone represented by its air volume"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component";

  parameter Medium.Temperature TRoom(start=293.15) = 293.15
    "Indoor air temperature of room in K";
  parameter Modelica.SIunits.Height heightRoom = 3 "Height of room in m";
  parameter Modelica.SIunits.Length lengthRoom = 5 "Length of room in m";
  parameter Modelica.SIunits.Length widthRoom = 5 "Width of room in m";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer UValue = 1
    "Heat transfer coefficient for outside wall";

  parameter Real doorOpening = 1
    "Opening of door (between 0:closed and 1:open)";

  parameter Boolean forceErrorControlOnFlow = true
    "Flag to force error control on m_flow. Set to true if interested in flow rate";

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conRoom(G=
        heightRoom*lengthRoom*UValue,
        port_a(T(start=Medium.T_default)))
    "Thermal conductor between fixed T and Volume"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Fluid.MixingVolumes.MixingVolume volRoom(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=TRoom,
    m_flow_nominal=0.001,
    V=heightRoom*lengthRoom*widthRoom,
    redeclare package Medium = Medium,
    nPorts=3,
    mSenFac=75) "Indoor air volume of room"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Fluid port that connects to the top of the door"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) "Fluid port that connects to the bottom of the door"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Airflow.Multizone.DoorDiscretizedOperable door(
    redeclare package Medium = Medium,
    LClo=20*1E-4,
    wOpe=1,
    hOpe=2.2,
    CDOpe=0.78,
    CDClo=0.78,
    nCom=10,
    hA=3/2,
    hB=3/2,
    dp_turbulent(displayUnit="Pa") = 0.01,
    forceErrorControlOnFlow=forceErrorControlOnFlow) "Discretized door"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Constant const(k=doorOpening)
    "Input for the door opening"
    annotation (Placement(transformation(extent={{28,40},{48,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_vent(redeclare package Medium =
        Medium) "Port that connects to the room volume"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemp(T(start=Medium.T_default),
        port(T(start=Medium.T_default))) "Dry bulb air temperature"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data connection for outdoor air temperature"
    annotation (Placement(
        transformation(extent={{-20,80},{20,120}}), iconTransformation(extent={{
            -128,30},{-108,50}})));
equation
  connect(conRoom.port_b, volRoom.heatPort) annotation (Line(
      points={{0,0},{20,0}},
      color={191,0,0}));
  connect(volRoom.ports[1], door.port_b2) annotation (Line(
      points={{27.3333,-10},{27.3333,-34},{52,-34},{52,-6},{60,-6}},
      color={0,127,255}));
  connect(volRoom.ports[2], door.port_a1) annotation (Line(
      points={{30,-10},{32,-24},{44,-24},{44,6},{60,6}},
      color={0,127,255}));
  connect(door.port_b1, port_a) annotation (Line(
      points={{80,6},{86,6},{86,60},{100,60}},
      color={0,127,255}));
  connect(door.port_a2, port_b) annotation (Line(
      points={{80,-6},{86,-6},{86,-60},{100,-60}},
      color={0,127,255}));
  connect(const.y, door.y) annotation (Line(
      points={{49,50},{54,50},{54,0},{59,0}},
      color={0,0,127}));
  connect(port_a_vent, volRoom.ports[3]) annotation (Line(
      points={{-100,80},{-84,80},{-84,-54},{32.6667,-54},{32.6667,-10}},
      color={0,127,255}));
  connect(preTemp.port, conRoom.port_a) annotation (Line(
      points={{-40,0},{-20,0}},
      color={191,0,0}));
  connect(preTemp.T, weaBus.TDryBul) annotation (Line(points={{-62,0},{-62,0},{
          -70,0},{-70,80},{0,80},{0,100}}, color={0,0,127}));
  annotation ( Documentation(info="<html>
<p>An air volume to represent a zone/room within a building that can be connected to a hallway
element and to ventilation equipment. </p>
<h4>Assumptions and limitations</h4>
<p>This is a very simple room representation. The model is intended to roughly approximate a first
order response of the zone to changes in outdoor air temperature. This is achieved by a thermal
resistance in model <code>conRoom</code> and the capitancy of the mixing volume represented by the
value for <code>mSenFac</code>. The G-Value of <code>conRoom</code> is approximated by the area of
one outside wall multiplied with a U-Value of <i>1 W/(m&sup2; K)</i>. The value for <code>mSenFac</code>
has been estimated from comparisons with other room models as shown in
<a href=\"modelica://IBPSA.Experimental.Benchmarks.AirFlow.Examples.ZoneStepResponse\">
IBPSA.Experimental.Benchmarks.AirFlow.Examples.ZoneStepResponse</a>.</p>
<h4>Typical use and important parameters</h4>
<p><code>port_a</code> and <code>port_b</code> should be connected to the corresponding ports of
<code>ZoneHallway</code> so that there is an air exchange through the door connecting the room to
the hallway element. </p>
<h4>Validation</h4>
<p>This model is following the approach used in
<a href=\"modelica://IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam\">
IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam</a>, only in a more modularized way
in order to be part of a scalable benchmark. </p>
<h4>References</h4>
<p>Inspired by
<a href=\"modelica://IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam\">
IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam</a> </p>
</html>", revisions="<html>
<ul>
<li>
September, 2, 2015 by Marcus Fuchs:<br/>
Add start values to the ports and temperature in the <code>ThermalConductor</code> and the
<code>PrescripedTemperature</code> model. This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\"> #266</a>, to work with
Dymola 2016 in pedantic mode.
</li>
<li>
February 2015 by Marcus Fuchs:<br/>
First implementation
</li>
</ul>
</html>"));
end SimpleZone;
