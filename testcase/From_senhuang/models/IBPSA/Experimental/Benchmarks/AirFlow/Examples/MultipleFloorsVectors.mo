within IBPSA.Experimental.Benchmarks.AirFlow.Examples;
model MultipleFloorsVectors
  "Test case for air flow between multiple floors in vector design"
  extends Modelica.Icons.Example;

  replaceable package Medium = IBPSA.Media.Air;

  parameter Integer nZones(min=1) = 4 "Number of zone elements per floor";
  parameter Integer nFloors(min=2) = 2 "Number of floors";

  parameter Modelica.SIunits.Temperature TRoom = 298.15
    "Indoor air temperature of room in K";
  parameter Modelica.SIunits.Temperature THallway = 293.15
    "Indoor air temperature of hallway in K";
  parameter Modelica.SIunits.Temperature TStaircase = 293.15
    "Indoor air temperature of staircase in K";
  parameter Modelica.SIunits.Height heightRooms = 3 "Height of rooms in m";

  parameter Modelica.SIunits.Length lengthZone = 5 "Length of room in m";
  parameter Modelica.SIunits.Length widthZone = 5 "Width of room in m";
  parameter Modelica.SIunits.Length widthHallway = 3 "Width of room in m";
  parameter Real doorOpening = 1
    "Opening of door (between 0:closed and 1:open)";

  parameter Boolean forceErrorControlOnFlow = true
    "Flag to force error control on m_flow. Set to true if interested in flow rate";

  Components.Floor floor[nFloors](
    each nZones=nZones,
    each TRoom=TRoom,
    each THallway=THallway,
    each TStaircase=TStaircase,
    each heightRooms=heightRooms,
    each lengthZone=lengthZone,
    each widthZone=widthZone,
    each widthHallway=widthHallway,
    redeclare each package Medium = Medium,
    each forceErrorControlOnFlow=forceErrorControlOnFlow)
    "Vector of floor elements"
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));

  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=Modelica.Utilities.Files.loadResource("modelica://IBPSA/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader for input into floor models"
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
equation
  for i in 1:(nFloors-1) loop
    connect(floor[i].port_a_top, floor[i+1].port_a_bot);
  end for;
  for i in 1:(nFloors) loop
    connect(weaDat.weaBus, floor[i].weaBus1) annotation (Line(
      points={{-60,-30},{-14,-30},{-14,-20}},
      color={255,204,51},
      thickness=0.5));
  end for;
  annotation (    experiment(Tolerance=1e-6, StopTime=3600),
    __Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Experimental/Benchmarks/AirFlow/Examples/MultipleFloorsVectors.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
February 2015 by Marcus Fuchs:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>A fully scalable air flow benchmark model </p>
<h4>Typical use and important parameters</h4>
<p>With <code>nZones</code> and <code>nFloors</code>, this vectorized model can be scaled to represent a simple building of any size. </p>
<h4>References</h4>
<p>Inspired by
<a href=\"modelica://IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam\">
IBPSA.Airflow.Multizone.Validation.ThreeRoomsContam</a> </p>
</html>"));
end MultipleFloorsVectors;
