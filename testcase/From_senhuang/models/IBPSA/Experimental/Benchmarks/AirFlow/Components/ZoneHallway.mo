within IBPSA.Experimental.Benchmarks.AirFlow.Components;
model ZoneHallway
  "Zone representing a hallway connecting multiple SimpleZone models"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component";

  parameter Modelica.SIunits.Temperature TRoom = 293.15
    "Indoor air temperature of room in K";
  parameter Modelica.SIunits.Height heightRoom = 3 "Height of room in m";
  parameter Modelica.SIunits.Length lengthRoom = 5 "Length of room in m";
  parameter Modelica.SIunits.Length widthRoom = 3 "Width of room in m";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer UValue = 1
    "Heat transfer coefficient for outside wall";

  parameter Boolean forceErrorControlOnFlow = true
    "Flag to force error control on m_flow. Set to true if interested in flow rate";

  Fluid.MixingVolumes.MixingVolume volumeHall(
    redeclare package Medium = Medium,
    m_flow_nominal=0.001,
    V=heightRoom*lengthRoom*widthRoom,
    nPorts=8,
    T_start=TRoom,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    mSenFac=60) "Air volume of hallway element"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conRoom(G=
        heightRoom*lengthRoom*UValue,
        port_a(T(start=Medium.T_default)))
    "Thermal conductor between fixed T and Volume"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Airflow.Multizone.MediumColumn col(
    redeclare package Medium = Medium,
    h=heightRoom/2,
    densitySelection=IBPSA.Airflow.Multizone.Types.densitySelection.fromTop)
    "Lower air column between bottom orifice to outside and indoor air volume"
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Airflow.Multizone.MediumColumn col1(
    redeclare package Medium = Medium,
    h=heightRoom/2,
    densitySelection=IBPSA.Airflow.Multizone.Types.densitySelection.fromBottom)
    "Upper air column between top orifice to outside and indoor air volume"
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_toZone(redeclare package Medium
      = Medium) "Direct connection to air volume without orifice"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_toZone(redeclare package Medium
      = Medium) "Direct connection to air volume without orifice"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_toOutside(redeclare package
      Medium = Medium) "Indirect connection to air volume with orifice"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_toOutside(redeclare package
      Medium = Medium) "Indirect connection to air volume with orifice"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium) "Indirect connection to air volume with orifice"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium) "Direct connection to air volume without orifice"
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Airflow.Multizone.Orifice oriOutTop(
    redeclare package Medium = Medium,
    A=0.01,
    forceErrorControlOnFlow=forceErrorControlOnFlow)
    "Upper orifice to outdoor environment"
    annotation (Placement(transformation(extent={{68,50},{88,70}})));
  Airflow.Multizone.Orifice oriOutBottom(
    redeclare package Medium = Medium,
    A=0.01,
    forceErrorControlOnFlow=forceErrorControlOnFlow)
    "Lower orifice to outdoor environment"
    annotation (Placement(transformation(extent={{68,-70},{88,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium) "Indirect connection to air volume with orifice"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium) "Direct connection to air volume without orifice"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Airflow.Multizone.MediumColumn col2(
    redeclare package Medium = Medium,
    densitySelection=IBPSA.Airflow.Multizone.Types.densitySelection.fromBottom,
    h=heightRoom/4)
    "Upper air column between this hallway element and subsequent hallway element"
     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-60})));

  Airflow.Multizone.MediumColumn col3(
    redeclare package Medium = Medium,
    densitySelection=IBPSA.Airflow.Multizone.Types.densitySelection.fromTop,
    h=heightRoom/4)
    "Lower air column between this hallway element and subsequent hallway element"
     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-60})));
  Airflow.Multizone.Orifice ori(
    redeclare package Medium = Medium,
    A=widthRoom*heightRoom/2,
    forceErrorControlOnFlow=forceErrorControlOnFlow)
    "Upper orifice between this hallway element and subsequent hallway element"
                                                                                annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-80})));
  Airflow.Multizone.Orifice ori1(
    redeclare package Medium = Medium,
    A=widthRoom*heightRoom/2,
    forceErrorControlOnFlow=forceErrorControlOnFlow)
    "Lower orifice between this hallway element and subsequent hallway element"
     annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-80})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemp(T(start=Medium.T_default),
        port(T(start=Medium.T_default))) "Dry bulb air temperature"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data connection for outdoor air temperature"
   annotation (Placement(
        transformation(extent={{-20,80},{20,120}}), iconTransformation(extent={{
            -128,30},{-108,50}})));
equation
  connect(conRoom.port_b, volumeHall.heatPort) annotation (Line(
      points={{0,0},{20,0}},
      color={191,0,0}));
  connect(port_a_toZone, volumeHall.ports[1]) annotation (Line(
      points={{-100,60},{-80,60},{-80,-24},{24,-24},{26.5,-10}},
      color={0,127,255}));
  connect(port_b_toZone, volumeHall.ports[2]) annotation (Line(
      points={{-100,-60},{-80,-60},{-80,-28},{26,-28},{27.5,-10}},
      color={0,127,255}));
  connect(col.port_b, oriOutBottom.port_a) annotation (Line(
      points={{60,-40},{60,-60},{68,-60}},
      color={0,127,255}));
  connect(oriOutBottom.port_b, port_b_toOutside) annotation (Line(
      points={{88,-60},{100,-60}},
      color={0,127,255}));
  connect(col1.port_a, oriOutTop.port_a) annotation (Line(
      points={{60,40},{60,60},{68,60}},
      color={0,127,255}));
  connect(oriOutTop.port_b, port_a_toOutside) annotation (Line(
      points={{88,60},{100,60}},
      color={0,127,255}));
  connect(ori.port_b,port_a1)  annotation (Line(
      points={{-40,-90},{-40,-94},{-60,-100}},
      color={0,127,255}));
  connect(ori1.port_b,port_b1)  annotation (Line(
      points={{40,-90},{40,-92},{60,-100}},
      color={0,127,255}));
  connect(ori.port_a, col2.port_a) annotation (Line(
      points={{-40,-70},{-40,-60},{-30,-60}},
      color={0,127,255}));
  connect(col3.port_b, ori1.port_a) annotation (Line(
      points={{30,-60},{40,-60},{40,-70}},
      color={0,127,255}));
  connect(col2.port_b, volumeHall.ports[3]) annotation (Line(
      points={{-10,-60},{-6,-60},{-6,-30},{28,-30},{28.5,-10}},
      color={0,127,255}));
  connect(col3.port_a, volumeHall.ports[4]) annotation (Line(
      points={{10,-60},{2,-60},{2,-34},{30,-34},{29.5,-10}},
      color={0,127,255}));
  connect(col.port_a, volumeHall.ports[5]) annotation (Line(
      points={{60,-20},{60,-10},{52,-10},{52,-36},{34,-36},{30.5,-10}},
      color={0,127,255}));
  connect(col1.port_b, volumeHall.ports[6]) annotation (Line(
      points={{60,20},{60,-4},{50,-4},{50,-32},{38,-32},{31.5,-10}},
      color={0,127,255}));
  connect(volumeHall.ports[7],port_b2)  annotation (Line(
      points={{32.5,-10},{40,-30},{48,-30},{48,80},{60,80},{60,100}},
      color={0,127,255}));
  connect(volumeHall.ports[8],port_a2)  annotation (Line(
      points={{33.5,-10},{42,-28},{44,-28},{44,80},{-60,80},{-60,100}},
      color={0,127,255}));
  connect(preTemp.port, conRoom.port_a) annotation (Line(
      points={{-40,0},{-20,0}},
      color={191,0,0}));
  connect(preTemp.T, weaBus.TDryBul) annotation (Line(points={{-62,0},{-70,0},{
          -70,60},{0,60},{0,100}}, color={0,0,127}));
  annotation (    Documentation(info="<html>
<p>An air volume to represent a hallway element for a scalable air flow benchmark. </p>
<h4>Assumptions and limitations</h4>
<p>This is a very simple room representation. The model is intended to roughly approximate a first
order response of the zone to changes in outdoor air temperature. This is achieved by a thermal
resistance in model <code>conRoom</code> and the capitancy of the mixing volume represented by the
value for <code>mSenFac</code>. The G-Value of <code>conRoom</code> is approximated by the area of
one outside wall multiplied with a U-Value of<i> 1 W/(m&sup2; K)</i>. The value for
<code>mSenFac</code> has been estimated from comparisons with other room models as shown in
<a href=\"modelica://IBPSA.Experimental.Benchmarks.AirFlow.Examples.ZoneStepResponse\">
IBPSA.Experimental.Benchmarks.AirFlow.Examples.ZoneStepResponse</a>. For this model, a value for
<code>mSenFac</code> slightly lower than in
<a href=\"modelica://IBPSA.Experimental.Benchmarks.AirFlow.Components.SimpleZone\">
IBPSA.Experimental.Benchmarks.AirFlow.Components.SimpleZone</a> has been chosen.</p>
<h4>Typical use and important parameters</h4>
<p><code>port_a_toZone</code> and <code>port_b_toZone</code> should be connected to the corresponding
ports of a zone model, <code>port_a_toOutside</code> and <code>port_b_toOutside</code> should be
connected to the corresponding ports of the <code>OutsideEnvironment</code>. <code>port_a2</code>
and <code>port_b2</code> can be connected to either a staircase model or to further hallway elements
via their respective <code>port_a1</code> and <code>port_b2</code>. </p>
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
end ZoneHallway;
