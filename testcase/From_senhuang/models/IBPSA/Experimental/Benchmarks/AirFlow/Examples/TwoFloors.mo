within IBPSA.Experimental.Benchmarks.AirFlow.Examples;
model TwoFloors "Test case for air flow between two floors"
  extends Modelica.Icons.Example;

  replaceable package Medium = IBPSA.Media.Air "Medium in the components";
  parameter Boolean forceErrorControlOnFlow = true
    "Optional forcing of error control";

  Components.ZoneHallway zoneHallway(
      forceErrorControlOnFlow=forceErrorControlOnFlow, redeclare package Medium
      = Medium) "Single hallway element"
    annotation (Placement(transformation(extent={{42,-94},{62,-74}})));
  Components.SimpleZone simpleZone1_4(
      forceErrorControlOnFlow=forceErrorControlOnFlow,
      TRoom = 298.15,
    redeclare package Medium = Medium) "Single simple zone element"
    annotation (Placement(transformation(extent={{12,-94},{32,-74}})));
  Components.OutsideEnvironment outsideEnvironment(redeclare package Medium =
        Medium) "Single outside environment element"
    annotation (Placement(transformation(extent={{72,-94},{92,-74}})));
  Components.ZoneHallway zoneHallway1(
      forceErrorControlOnFlow=forceErrorControlOnFlow, redeclare package Medium
      = Medium) "Single hallway element"
    annotation (Placement(transformation(extent={{42,-54},{62,-34}})));
  Components.ZoneHallway zoneHallway2(
      forceErrorControlOnFlow=forceErrorControlOnFlow, redeclare package Medium
      = Medium) "Single hallway element"
    annotation (Placement(transformation(extent={{42,-14},{62,6}})));
  Components.ZoneHallway zoneHallway3(
      forceErrorControlOnFlow=forceErrorControlOnFlow, redeclare package Medium
      = Medium) "Single hallway element"
    annotation (Placement(transformation(extent={{42,26},{62,46}})));
  Components.SimpleZone simpleZone1_3(
    forceErrorControlOnFlow=forceErrorControlOnFlow,
    TRoom = 298.15,
    redeclare package Medium = Medium) "Single simple zone element"
    annotation (Placement(transformation(extent={{12,-54},{32,-34}})));
  Components.SimpleZone simpleZone1_2(
    forceErrorControlOnFlow=forceErrorControlOnFlow,
    TRoom = 298.15,
    redeclare package Medium = Medium) "Single simple zone element"
    annotation (Placement(transformation(extent={{12,-14},{32,6}})));
  Components.SimpleZone simpleZone1_1(
    forceErrorControlOnFlow=forceErrorControlOnFlow,
    TRoom = 298.15,
    redeclare package Medium = Medium) "Single simple zone element"
    annotation (Placement(transformation(extent={{12,26},{32,46}})));
  Components.OutsideEnvironment outsideEnvironment1(redeclare package Medium =
        Medium) "Single outside environment element"
    annotation (Placement(transformation(extent={{72,-54},{92,-34}})));
  Components.OutsideEnvironment outsideEnvironment2(redeclare package Medium =
        Medium) "Single outside environment element"
    annotation (Placement(transformation(extent={{72,-14},{92,6}})));
  Components.OutsideEnvironment outsideEnvironment3(redeclare package Medium =
        Medium) "Single outside environment element"
    annotation (Placement(transformation(extent={{72,26},{92,46}})));
  Components.ZoneHallway zoneHallway4(
      forceErrorControlOnFlow=forceErrorControlOnFlow, redeclare package Medium
      = Medium) "Single hallway element"
    annotation (Placement(transformation(extent={{-62,-94},{-42,-74}})));
  Components.SimpleZone simpleZone2_4(
      forceErrorControlOnFlow=forceErrorControlOnFlow,
      TRoom = 298.15,
    redeclare package Medium = Medium) "Single simple zone element"
    annotation (Placement(transformation(extent={{-92,-94},{-72,-74}})));
  Components.OutsideEnvironment outsideEnvironment4(redeclare package Medium =
        Medium) "Single outside environment element"
    annotation (Placement(transformation(extent={{-32,-94},{-12,-74}})));
  Components.ZoneHallway zoneHallway5(
      forceErrorControlOnFlow=forceErrorControlOnFlow, redeclare package Medium
      = Medium) "Single hallway element"
    annotation (Placement(transformation(extent={{-62,-54},{-42,-34}})));
  Components.ZoneHallway zoneHallway6(
      forceErrorControlOnFlow=forceErrorControlOnFlow, redeclare package Medium
      = Medium) "Single hallway element"
    annotation (Placement(transformation(extent={{-62,-14},{-42,6}})));
  Components.ZoneHallway zoneHallway7(
      forceErrorControlOnFlow=forceErrorControlOnFlow, redeclare package Medium
      = Medium) "Single hallway element"
    annotation (Placement(transformation(extent={{-62,26},{-42,46}})));
  Components.SimpleZone simpleZone2_3(
    forceErrorControlOnFlow=forceErrorControlOnFlow,
    TRoom = 298.15,
    redeclare package Medium = Medium) "Single simple zone element"
    annotation (Placement(transformation(extent={{-92,-54},{-72,-34}})));
  Components.SimpleZone simpleZone2_2(
    forceErrorControlOnFlow=forceErrorControlOnFlow,
    TRoom = 298.15,
    redeclare package Medium = Medium) "Single simple zone element"
    annotation (Placement(transformation(extent={{-92,-14},{-72,6}})));
  Components.SimpleZone simpleZone2_1(
    forceErrorControlOnFlow=forceErrorControlOnFlow,
    TRoom = 298.15,
    redeclare package Medium = Medium) "Single simple zone element"
    annotation (Placement(transformation(extent={{-92,26},{-72,46}})));
  Components.OutsideEnvironment outsideEnvironment5(redeclare package Medium =
        Medium) "Single outside environment element"
    annotation (Placement(transformation(extent={{-32,-54},{-12,-34}})));
  Components.OutsideEnvironment outsideEnvironment6(redeclare package Medium =
        Medium) "Single outside environment element"
    annotation (Placement(transformation(extent={{-32,-14},{-12,6}})));
  Components.OutsideEnvironment outsideEnvironment7(redeclare package Medium =
        Medium) "Single outside environment element"
    annotation (Placement(transformation(extent={{-32,26},{-12,46}})));
  Components.Staircase staircase1(redeclare package Medium = Medium)
    "First staircase element"     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={52,70})));
  Components.Staircase staircase2(redeclare package Medium = Medium)
    "Second staircase element"    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-52,70})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://IBPSA/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather file reader for input to air flow models"
    annotation (Placement(transformation(extent={{-24,100},{-4,120}})));
equation
  connect(simpleZone2_4.port_a, zoneHallway4.port_a_toZone) annotation (Line(
      points={{-72,-78},{-62,-78}},
      color={0,127,255}));
  connect(simpleZone2_4.port_b, zoneHallway4.port_b_toZone) annotation (Line(
      points={{-72,-90},{-62,-90}},
      color={0,127,255}));
  connect(zoneHallway4.port_a2, zoneHallway5.port_a1) annotation (Line(
      points={{-58,-74},{-58,-54}},
      color={0,127,255}));
  connect(zoneHallway4.port_b2, zoneHallway5.port_b1) annotation (Line(
      points={{-46,-74},{-46,-54}},
      color={0,127,255}));
  connect(zoneHallway4.port_a_toOutside, outsideEnvironment4.port_a)
    annotation (Line(
      points={{-42,-78},{-32,-78}},
      color={0,127,255}));
  connect(zoneHallway4.port_b_toOutside, outsideEnvironment4.port_b)
    annotation (Line(
      points={{-42,-90},{-32,-90}},
      color={0,127,255}));
  connect(zoneHallway5.port_b_toOutside, outsideEnvironment5.port_b)
    annotation (Line(
      points={{-42,-50},{-32,-50}},
      color={0,127,255}));
  connect(zoneHallway5.port_a_toOutside, outsideEnvironment5.port_a)
    annotation (Line(
      points={{-42,-38},{-32,-38}},
      color={0,127,255}));
  connect(simpleZone2_3.port_b, zoneHallway5.port_b_toZone) annotation (Line(
      points={{-72,-50},{-62,-50}},
      color={0,127,255}));
  connect(simpleZone2_3.port_a, zoneHallway5.port_a_toZone) annotation (Line(
      points={{-72,-38},{-62,-38}},
      color={0,127,255}));
  connect(zoneHallway5.port_a2, zoneHallway6.port_a1) annotation (Line(
      points={{-58,-34},{-58,-14}},
      color={0,127,255}));
  connect(zoneHallway5.port_b2, zoneHallway6.port_b1) annotation (Line(
      points={{-46,-34},{-46,-14}},
      color={0,127,255}));
  connect(simpleZone2_2.port_b, zoneHallway6.port_b_toZone) annotation (Line(
      points={{-72,-10},{-62,-10}},
      color={0,127,255}));
  connect(simpleZone2_2.port_a, zoneHallway6.port_a_toZone) annotation (Line(
      points={{-72,2},{-62,2}},
      color={0,127,255}));
  connect(zoneHallway6.port_a2, zoneHallway7.port_a1) annotation (Line(
      points={{-58,6},{-58,26}},
      color={0,127,255}));
  connect(zoneHallway6.port_b2, zoneHallway7.port_b1) annotation (Line(
      points={{-46,6},{-46,26}},
      color={0,127,255}));
  connect(zoneHallway6.port_a_toOutside, outsideEnvironment6.port_a)
    annotation (Line(
      points={{-42,2},{-32,2}},
      color={0,127,255}));
  connect(zoneHallway6.port_b_toOutside, outsideEnvironment6.port_b)
    annotation (Line(
      points={{-42,-10},{-32,-10}},
      color={0,127,255}));
  connect(zoneHallway7.port_b_toOutside, outsideEnvironment7.port_b)
    annotation (Line(
      points={{-42,30},{-32,30}},
      color={0,127,255}));
  connect(zoneHallway7.port_a_toOutside, outsideEnvironment7.port_a)
    annotation (Line(
      points={{-42,42},{-32,42}},
      color={0,127,255}));
  connect(simpleZone2_1.port_b, zoneHallway7.port_b_toZone) annotation (Line(
      points={{-72,30},{-62,30}},
      color={0,127,255}));
  connect(simpleZone2_1.port_a, zoneHallway7.port_a_toZone) annotation (Line(
      points={{-72,42},{-62,42}},
      color={0,127,255}));
  connect(zoneHallway7.port_a2,staircase2. port_a_toHallway) annotation (Line(
      points={{-58,46},{-58,60}},
      color={0,127,255}));
  connect(zoneHallway7.port_b2,staircase2. port_b_toHallway) annotation (Line(
      points={{-46,46},{-46,60}},
      color={0,127,255}));
  connect(staircase2.port_a_bot, staircase1.port_a_top) annotation (Line(
      points={{-42,70},{42.2,70}},
      color={0,127,255}));
  connect(staircase1.port_a_toHallway, zoneHallway3.port_a2) annotation (Line(
      points={{46,60},{46,46}},
      color={0,127,255}));
  connect(staircase1.port_b_toHallway, zoneHallway3.port_b2) annotation (Line(
      points={{58,60},{58,46}},
      color={0,127,255}));
  connect(simpleZone1_1.port_a, zoneHallway3.port_a_toZone) annotation (Line(
      points={{32,42},{42,42}},
      color={0,127,255}));
  connect(simpleZone1_1.port_b, zoneHallway3.port_b_toZone) annotation (Line(
      points={{32,30},{42,30}},
      color={0,127,255}));
  connect(zoneHallway3.port_a_toOutside, outsideEnvironment3.port_a)
    annotation (Line(
      points={{62,42},{72,42}},
      color={0,127,255}));
  connect(zoneHallway3.port_b_toOutside, outsideEnvironment3.port_b)
    annotation (Line(
      points={{62,30},{72,30}},
      color={0,127,255}));
  connect(zoneHallway3.port_a1, zoneHallway2.port_a2) annotation (Line(
      points={{46,26},{46,6}},
      color={0,127,255}));
  connect(zoneHallway3.port_b1, zoneHallway2.port_b2) annotation (Line(
      points={{58,26},{58,6}},
      color={0,127,255}));
  connect(zoneHallway2.port_a_toOutside, outsideEnvironment2.port_a)
    annotation (Line(
      points={{62,2},{72,2}},
      color={0,127,255}));
  connect(zoneHallway2.port_b_toOutside, outsideEnvironment2.port_b)
    annotation (Line(
      points={{62,-10},{72,-10}},
      color={0,127,255}));
  connect(zoneHallway2.port_a1, zoneHallway1.port_a2) annotation (Line(
      points={{46,-14},{46,-34}},
      color={0,127,255}));
  connect(zoneHallway2.port_b1, zoneHallway1.port_b2) annotation (Line(
      points={{58,-14},{58,-34}},
      color={0,127,255}));
  connect(simpleZone1_3.port_a, zoneHallway1.port_a_toZone) annotation (Line(
      points={{32,-38},{42,-38}},
      color={0,127,255}));
  connect(simpleZone1_3.port_b, zoneHallway1.port_b_toZone) annotation (Line(
      points={{32,-50},{42,-50}},
      color={0,127,255}));
  connect(zoneHallway1.port_a_toOutside, outsideEnvironment1.port_a)
    annotation (Line(
      points={{62,-38},{72,-38}},
      color={0,127,255}));
  connect(zoneHallway1.port_b_toOutside, outsideEnvironment1.port_b)
    annotation (Line(
      points={{62,-50},{72,-50}},
      color={0,127,255}));
  connect(zoneHallway1.port_a1, zoneHallway.port_a2) annotation (Line(
      points={{46,-54},{46,-74}},
      color={0,127,255}));
  connect(zoneHallway1.port_b1, zoneHallway.port_b2) annotation (Line(
      points={{58,-54},{58,-74}},
      color={0,127,255}));
  connect(simpleZone1_4.port_a, zoneHallway.port_a_toZone) annotation (Line(
      points={{32,-78},{42,-78}},
      color={0,127,255}));
  connect(simpleZone1_4.port_b, zoneHallway.port_b_toZone) annotation (Line(
      points={{32,-90},{42,-90}},
      color={0,127,255}));
  connect(zoneHallway.port_a_toOutside, outsideEnvironment.port_a) annotation (
      Line(
      points={{62,-78},{72,-78}},
      color={0,127,255}));
  connect(zoneHallway.port_b_toOutside, outsideEnvironment.port_b) annotation (
      Line(
      points={{62,-90},{72,-90}},
      color={0,127,255}));
  connect(simpleZone1_2.port_b, zoneHallway2.port_b_toZone) annotation (Line(
      points={{32,-10},{42,-10}},
      color={0,127,255}));
  connect(simpleZone1_2.port_a, zoneHallway2.port_a_toZone) annotation (Line(
      points={{32,2},{42,2}},
      color={0,127,255}));
  connect(weaDat.weaBus, outsideEnvironment7.weaBus1) annotation (Line(
      points={{-4,110},{0,110},{0,36},{-12,36}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, outsideEnvironment6.weaBus1) annotation (Line(
      points={{-4,110},{0,110},{0,-4},{-12,-4}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, outsideEnvironment5.weaBus1) annotation (Line(
      points={{-4,110},{0,110},{0,-44},{-12,-44}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, outsideEnvironment4.weaBus1) annotation (Line(
      points={{-4,110},{0,110},{0,-84},{-12,-84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, outsideEnvironment3.weaBus1) annotation (Line(
      points={{-4,110},{98,110},{98,36},{92,36}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, outsideEnvironment2.weaBus1) annotation (Line(
      points={{-4,110},{98,110},{98,-4},{92,-4}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, outsideEnvironment1.weaBus1) annotation (Line(
      points={{-4,110},{98,110},{98,-44},{92,-44}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, outsideEnvironment.weaBus1) annotation (Line(
      points={{-4,110},{98,110},{98,-84},{92,-84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, simpleZone1_1.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,40},{10.2,40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, simpleZone1_2.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,0},{10.2,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, simpleZone1_3.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,-40},{10.2,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, simpleZone1_4.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,-80},{10.2,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, staircase1.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{48,52},{48,58.2}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneHallway3.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{36,52},{36,40},{40.2,40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneHallway2.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{36,52},{36,0},{40.2,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneHallway1.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{36,52},{36,-40},{40.2,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneHallway.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{36,52},{36,-80},{40.2,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, simpleZone2_1.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-98,52},{-98,40},{-93.8,40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, simpleZone2_2.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-98,52},{-98,0},{-93.8,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, simpleZone2_3.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-98,52},{-98,-40},{-93.8,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, simpleZone2_4.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-98,52},{-98,-80},{-93.8,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, staircase2.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-56,52},{-56,58.2}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneHallway7.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-68,52},{-68,40},{-63.8,40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneHallway6.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-68,52},{-68,0},{-63.8,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneHallway5.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-68,52},{-68,-40},{-63.8,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneHallway4.weaBus) annotation (Line(
      points={{-4,110},{0,110},{0,52},{-68,52},{-68,-80},{-63.8,-80}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics),
    experiment(Tolerance=1e-6, StopTime=3600),
    __Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Experimental/Benchmarks/AirFlow/Examples/TwoFloors.mos"
        "Simulate and plot"),
    Icon(coordinateSystem(extent={{-100,-100},{100,120}})),
    Documentation(info="<html>
<p>A reference model to compare to the floor model for a scalable air flow benchmark. </p>
<h4>Validation</h4>
<p>This model should give the same results as the
<a href=\"modelica://IBPSA.Experimental.Benchmarks.AirFlow.Examples.MultipleFloorsVectors\">
IBPSA.Experimental.Benchmarks.AirFlow.Examples.MultipleFloorsVectors</a> model with
<code>nZones</code> = <i>4</i> and <code>nFloors</code> = <i>2</i>. </p>
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
end TwoFloors;
