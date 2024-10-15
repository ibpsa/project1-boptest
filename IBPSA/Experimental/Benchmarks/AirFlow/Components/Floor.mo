within IBPSA.Experimental.Benchmarks.AirFlow.Components;
model Floor
  "Floor element for air flow benchmark, consisting of zones, hallway, outdoor environment, and staircase"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component";

  parameter Integer nZones(min=1) = 4 "Number of zone elements";

  parameter Modelica.Units.SI.Temperature TRoom=298.15
    "Indoor air temperature of room in K";
  parameter Modelica.Units.SI.Temperature THallway=293.15
    "Indoor air temperature of hallway in K";
  parameter Modelica.Units.SI.Temperature TStaircase=293.15
    "Indoor air temperature of staircase in K";
  parameter Modelica.Units.SI.Height heightRooms=3 "Height of rooms in m";

  parameter Modelica.Units.SI.Length lengthZone=5 "Length of room in m";
  parameter Modelica.Units.SI.Length widthZone=5 "Width of room in m";
  parameter Modelica.Units.SI.Length widthHallway=3 "Width of room in m";
  parameter Real doorOpening = 1
    "Opening of door (between 0:closed and 1:open)";

  parameter Boolean forceErrorControlOnFlow = true
    "Flag to force error control on m_flow. Set to true if interested in flow rate";

  Experimental.Benchmarks.AirFlow.Components.Staircase staircase(
    heightRoom=heightRooms,
    widthRoom=widthHallway,
    redeclare package Medium = Medium,
    forceErrorControlOnFlow=forceErrorControlOnFlow,
    TRoom=TStaircase) "Staircase element for connection to other floors"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_top(redeclare package Medium =
        Medium) "Fluid port for connection to higher floors"
    annotation (Placement(transformation(extent={{60,90},{80,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_bot(redeclare package Medium =
        Medium) "Fluid port for connection to lower floors"
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
  Experimental.Benchmarks.AirFlow.Components.ZoneHallway zoneHallway[nZones](
    each heightRoom=heightRooms,
    each lengthRoom=lengthZone,
    each widthRoom=widthHallway,
    redeclare each package Medium = Medium,
    each forceErrorControlOnFlow=forceErrorControlOnFlow,
    each TRoom=THallway) "Vector of hallway elements"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-30,-30})));
  Experimental.Benchmarks.AirFlow.Components.OutsideEnvironment
    outsideEnvironment[nZones](redeclare each package Medium = Medium, each
      heightRoom=heightRooms)
    "Vector of outside environments connected to Hallway elements"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Experimental.Benchmarks.AirFlow.Components.SimpleZone simpleZone[nZones](
    each heightRoom=heightRooms,
    each lengthRoom=lengthZone,
    each widthRoom=widthZone,
    redeclare each package Medium = Medium,
    each forceErrorControlOnFlow=forceErrorControlOnFlow,
    each TRoom=TRoom) "Vector of zone elements"
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_vent[nZones](redeclare each
      package Medium =
        Medium) "Port to connect mechanical ventilation equipment to each zone"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  BoundaryConditions.WeatherData.Bus weaBus1 "Bus with weather data"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
equation
  connect(staircase.port_a_top, port_a_top) annotation (Line(
      points={{70,9.8},{70,100}},
      color={0,127,255}));
  connect(staircase.port_a_bot, port_a_bot) annotation (Line(
      points={{70,-10},{70,-100}},
      color={0,127,255}));
  connect(staircase.port_a_toHallway, zoneHallway[1].port_a2) annotation (Line(
      points={{60,6},{-36,6},{-36,-20}},
      color={0,127,255}));
  connect(staircase.port_b_toHallway, zoneHallway[1].port_b2) annotation (Line(
      points={{60,-6},{-24,-6},{-24,-20}},
      color={0,127,255}));

  for i in 1:(nZones-1) loop
    connect(zoneHallway[i].port_a1, zoneHallway[i+1].port_a2);
    connect(zoneHallway[i].port_b1, zoneHallway[i+1].port_b2);
  end for;

  for i in 1:nZones loop
    connect(simpleZone[i].port_a, zoneHallway[i].port_a_toZone) annotation (Line(
      points={{-60,-24},{-40,-24}},
      color={0,127,255}));
    connect(simpleZone[i].port_b, zoneHallway[i].port_b_toZone) annotation (Line(
      points={{-60,-36},{-40,-36}},
      color={0,127,255}));
    connect(zoneHallway[i].port_a_toOutside, outsideEnvironment[i].port_a)
    annotation (Line(
      points={{-20,-24},{0,-24}},
      color={0,127,255}));
    connect(zoneHallway[i].port_b_toOutside, outsideEnvironment[i].port_b)
    annotation (Line(
      points={{-20,-36},{0,-36}},
      color={0,127,255}));
  end for;
  for i in 1:nZones loop
    connect(port_a_vent[i], simpleZone[i].port_a_vent) annotation (Line(
      points={{-100,60},{-88,60},{-88,-22},{-80,-22}},
      color={0,127,255}));
  end for;

  for i in 1:nZones loop
    connect(outsideEnvironment[i].weaBus1, weaBus1) annotation (Line(
      points={{20,-30},{34,-30},{34,-72},{-40,-72},{-40,-100}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  end for;
  for i in 1:nZones loop
    connect(weaBus1, simpleZone[i].weaBus) annotation (Line(
      points={{-40,-100},{-40,-72},{-90,-72},{-90,-26},{-81.8,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  end for;
  for i in 1:nZones loop
    connect(weaBus1, zoneHallway[i].weaBus) annotation (Line(
      points={{-40,-100},{-40,-50},{-50,-50},{-50,-26},{-41.8,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  end for;
  connect(weaBus1, staircase.weaBus) annotation (Line(
      points={{-40,-100},{-40,-72},{34,-72},{34,4},{58.2,4}},
      color={255,204,51},
      thickness=0.5), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation ( Documentation(info="<html>
<p>A floor model for a scalable air flow benchmark. </p>
<h4>Assumptions and limitations</h4>
<p>See e.g. <a href=\"modelica://IBPSA.Experimental.Benchmarks.AirFlow.Components.SimpleZone\">
IBPSA.Experimental.Benchmarks.AirFlow.Components.SimpleZone</a> for limitations and assumptions on
 the zone level representation.</p>
<h4>Typical use and important parameters</h4>
<p>This floor model consists of a staircase element connected to at least one hallway element. The
hallway is connected to a simple zone model through a door model, and to the outside environment via
orifice models. Zone, hallway and outside environment are vectorized. Thus, by setting the number of
zones <code>nZones</code>, the floor model can be scaled to represent a floor with varying numbers of rooms. In
addition, the staircase element can be connected to other floor models in order to also scale the
model representation of air flows in a building regarding the number of floors on top of each
other. </p>
<h4>References</h4>
<p>Inspired by
<a href=\"modelica://IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam\">
IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam</a> </p>
</html>", revisions="<html>
<ul>
<li>
February 2015 by Marcus Fuchs:<br/>
First implementation
</li>
</ul>
</html>"));
end Floor;
