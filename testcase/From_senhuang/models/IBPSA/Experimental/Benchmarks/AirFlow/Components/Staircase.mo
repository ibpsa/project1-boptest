within IBPSA.Experimental.Benchmarks.AirFlow.Components;
model Staircase
  "Zone representing a staircase connecting multiple floor models"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component";

  parameter Modelica.SIunits.Temperature TRoom = 293.15
    "Indoor air temperature of room in K";
  parameter Modelica.SIunits.Height heightRoom = 3 "Height of room in m";
  parameter Modelica.SIunits.Length lengthRoom = 3 "Length of room in m";
  parameter Modelica.SIunits.Length widthRoom = 3 "Width of room in m";
  parameter Real doorOpening = 1
    "Opening of door (between 0:closed and 1:open)";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer UValue = 1
    "Heat transfer coefficient for outside wall";

  parameter Boolean forceErrorControlOnFlow = true
    "Flag to force error control on m_flow. Set to true if interested in flow rate";

  Fluid.MixingVolumes.MixingVolume volumeStairs(
    redeclare package Medium = Medium,
    m_flow_nominal=0.001,
    V=heightRoom*lengthRoom*widthRoom,
    T_start=TRoom,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPorts=4,
    mSenFac=60) "Air volume of staircase element"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conRoom(G=
        heightRoom*widthRoom*UValue,
        port_a(T(start=Medium.T_default)))
    "Thermal conductor between fixed T and Volume"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_toHallway(redeclare package
      Medium = Medium) "Upper fluid port to hallway element"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_toHallway(redeclare package
      Medium = Medium) "Lower fluid port to hallway element"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_bot(redeclare package Medium =
        Medium) "Fluid port to lower staircase element"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_top(redeclare package Medium =
        Medium) "Fluid port to higher staircase element"
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  Airflow.Multizone.MediumColumn col2(
    redeclare package Medium = Medium,
    h=heightRoom/2,
    densitySelection=IBPSA.Airflow.Multizone.Types.densitySelection.fromTop)
    "Air column between staircase air volume and lower staircase element"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={0,-60})));

  Airflow.Multizone.MediumColumn col1(
    redeclare package Medium = Medium,
    h=heightRoom/2,
    densitySelection=IBPSA.Airflow.Multizone.Types.densitySelection.fromBottom)
    "Air column between staircase air volume and higher staircase element"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Airflow.Multizone.Orifice ori(
    redeclare package Medium = Medium,
    forceErrorControlOnFlow=forceErrorControlOnFlow,
    A=widthRoom*lengthRoom) "Orifice to higher staircase element"
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,78})));
  Airflow.Multizone.DoorDiscretizedOperable doo(
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
    forceErrorControlOnFlow=forceErrorControlOnFlow)
    "Door for connection to hallway element"
     annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-80,0})));
  Modelica.Blocks.Sources.Constant const(k=doorOpening)
    "Input for door openign"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-60,30})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemp(T(start=Medium.T_default),
        port(T(start=Medium.T_default))) "Dry bulb air temperature"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather data connection"
                            annotation (Placement(
        transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={{
            -128,30},{-108,50}})));
equation
  connect(conRoom.port_b, volumeStairs.heatPort) annotation (Line(
      points={{10,0},{20,0}},
      color={191,0,0}));
  connect(port_a_bot, col2.port_b) annotation (Line(
      points={{0,-100},{0,-70}},
      color={0,127,255}));
  connect(doo.port_b1, port_b_toHallway) annotation (Line(
      points={{-90,-6},{-92,-6},{-92,-60},{-100,-60}},
      color={0,127,255}));
  connect(doo.port_a2, port_a_toHallway) annotation (Line(
      points={{-90,6},{-92,6},{-92,60},{-100,60}},
      color={0,127,255}));
  connect(const.y, doo.y) annotation (Line(
      points={{-60,23.4},{-60,0},{-69,0}},
      color={0,0,127}));
  connect(ori.port_b, port_a_top) annotation (Line(
      points={{4.44089e-016,88},{4.44089e-016,96},{0,96},{0,98}},
      color={0,127,255}));
  connect(ori.port_a, col1.port_a) annotation (Line(
      points={{-6.66134e-016,68},{-6.66134e-016,64},{0,64},{0,60}},
      color={0,127,255}));
  connect(doo.port_b2, volumeStairs.ports[1]) annotation (Line(
      points={{-70,6},{-56,6},{-56,-24},{27,-24},{27,-10}},
      color={0,127,255}));
  connect(doo.port_a1, volumeStairs.ports[2]) annotation (Line(
      points={{-70,-6},{-62,-6},{-62,-26},{29,-26},{29,-10}},
      color={0,127,255}));
  connect(col2.port_a, volumeStairs.ports[3]) annotation (Line(
      points={{0,-50},{0,-28},{31,-28},{31,-10}},
      color={0,127,255}));
  connect(col1.port_b, volumeStairs.ports[4]) annotation (Line(
      points={{0,40},{0,32},{62,32},{62,-26},{33,-26},{33,-10}},
      color={0,127,255}));
  connect(preTemp.port, conRoom.port_a) annotation (Line(
      points={{-20,0},{-10,0}},
      color={191,0,0}));
  connect(preTemp.T, weaBus.TDryBul) annotation (Line(points={{-42,0},{-48,0},{
          -48,20},{80,20},{80,0},{100,0}}, color={0,0,127}));
  annotation (    Documentation(info="<html>
<p>An air volume to represent a staircase element for a scalable air flow benchmark. </p>
<h4>Assumptions and limitations</h4>
<p>This is a very simple room representation. The model is intended to roughly approximate a first
order response of the zone to changes in outdoor air temperature. This is achieved by a thermal
resistance in model <code>conRoom</code> and the capitancy of the mixing volume represented by the
value for <code>mSenFac</code>. The G-Value of <code>conRoom</code> is approximated by the area of
one outside wall multiplied with a U-Value of<i> 1 W/(m&sup2; K)</i>. The value for <code>mSenFac</code>
has been estimated from comparisons with other room models as shown in
<a href=\"modelica://IBPSA.Experimental.Benchmarks.AirFlow.Examples.ZoneStepResponse\">
IBPSA.Experimental.Benchmarks.AirFlow.Examples.ZoneStepResponse</a>. For this model, a value for
<code>mSenFac</code> slightly lower than in
<a href=\"modelica://IBPSA.Experimental.Benchmarks.AirFlow.Components.SimpleZone\">
IBPSA.Experimental.Benchmarks.AirFlow.Components.SimpleZone</a> has been chosen.</p>
<h4>Typical use and important parameters</h4>
<p><code>port_a_toHallway</code> and <code>port_b_toHallway</code> should be connected to the
corresponding ports of a hallway model. <code>port_a_top</code> and <code>port_b_top</code> can be
connected to another staircase model via its respective <code>port_a_bot</code> and
<code>port_b_bot</code>. </p>
<h4>References</h4>
<p>Inspired by
<a href=\"modelica://IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam\">
IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam</a> </p>
</html>",
   revisions="<html>
<ul>
<li>
April, 25, 2016 by Marcus Fuchs:<br/>
Removed wrong connection statement. This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/454\"> #454</a>,
to prevent a warning in OpenModelica.
</li>
<li>
September, 2, 2015 by Marcus Fuchs:<br/>
Add start values to the ports and temperature in the <code>ThermalConductor</code> and the
<code>PrescripedTemperature</code> model. This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\"> #266</a>,
to work with Dymola 2016 in pedantic mode.
</li>
<li>
February 2015 by Marcus Fuchs:<br/>
First implementation
</li>
</ul>
</html>"));
end Staircase;
