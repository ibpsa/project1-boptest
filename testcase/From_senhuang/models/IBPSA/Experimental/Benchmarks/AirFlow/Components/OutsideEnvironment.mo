within IBPSA.Experimental.Benchmarks.AirFlow.Components;
model OutsideEnvironment
  "Outside Environment air volume for simple air flow benchmark"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component";

  parameter Modelica.SIunits.Height heightRoom = 3
    "Height of room connected to outdoor air in m";

  Airflow.Multizone.MediumColumn colOutBot(
    redeclare package Medium = Medium,
    h=heightRoom/2,
    densitySelection=IBPSA.Airflow.Multizone.Types.densitySelection.fromTop)
    "Lower air column"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Airflow.Multizone.MediumColumn colOutTop(
    redeclare package Medium = Medium,
    h=heightRoom/2,
    densitySelection=IBPSA.Airflow.Multizone.Types.densitySelection.fromBottom)
    "Upper air column"
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Fluid port at the top of the room"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) "Fluid port at the bottom of the room"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Fluid.Sources.Outside_CpLowRise out(
    nPorts=2,
    redeclare package Medium = Medium,
    s=1,
    azi=0) "Outdoor air volume"
                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,0})));
  BoundaryConditions.WeatherData.Bus weaBus1 "Bus with weather data"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(port_a, colOutTop.port_a) annotation (Line(
      points={{-100,60},{0,60},{0,40}},
      color={0,127,255}));
  connect(port_b, colOutBot.port_b) annotation (Line(
      points={{-100,-60},{0,-60},{0,-40}},
      color={0,127,255}));
  connect(colOutBot.port_a, out.ports[1]) annotation (Line(
      points={{0,-20},{0,-2},{40,-2}},
      color={0,127,255}));
  connect(colOutTop.port_b, out.ports[2]) annotation (Line(
      points={{0,20},{0,2},{40,2}},
      color={0,127,255}));
  connect(out.weaBus, weaBus1) annotation (Line(
      points={{60,-0.2},{76,-0.2},{76,0},{100,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (           Documentation(info="<html>
<p>An air volume to represent the outside environment for air flow benchmark. </p>
<h4>Assumptions and limitations</h4>
<p>So far, the side ratio for the building is set to <i>1</i> for testing the general modeling
approach. It may be necessary to calculate this parameter depending on the scale of the test. </p>
<h4>Typical use and important parameters</h4>
<p><code>port_a</code> and <code>port_b</code> should be connected to the corresponding ports of
<code>ZoneHallway</code> so that there is an air exchange through the orifices of the hallway
element. </p>
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
end OutsideEnvironment;
