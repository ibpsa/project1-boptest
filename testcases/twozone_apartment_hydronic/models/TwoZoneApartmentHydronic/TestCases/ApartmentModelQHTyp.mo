within TwoZoneApartmentHydronic.TestCases;
model ApartmentModelQHTyp "Hydronic Test case"
    extends Modelica.Icons.Example;
    replaceable package MediumA = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Medium model";
    replaceable package MediumW = Buildings.Media.Water "Medium model";
    parameter Modelica.SIunits.Area Afloor = 22;
    parameter Modelica.SIunits.Temperature T_start = 21+273.15;
    parameter Modelica.SIunits.MassFlowRate mflow_n=2480/3600/4
    "nominal flow rate";
    parameter Real qint=1 "Presence or not of Internal gains";
  TwoZoneApartmentHydronic.Components.Thermostat_T thermostatNigZon(
    occSta=8*3600,
    occEnd=20*3600,
    TSetHeaUno=294.15,
    TSetHeaOcc=289.15,
    TSetHeaWee=289.15)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  TwoZoneApartmentHydronic.Components.HydronicSystem hydronicSystem(
    redeclare package MediumW = MediumW,                            mflow_n=
        2480/3600/2,
    DP_n=DP_n,       QhpDes=5000)
    annotation (Placement(transformation(extent={{-20,-14},{14,20}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-80,-10},{-40,30}}),  iconTransformation(extent=
           {{-268,-10},{-248,10}})));
  TwoZoneApartmentHydronic.Components.Rooms.DayZone dayZon(
    Afloor=Afloor,
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    mflow_n=mflow_n,
    qint=qint,
    Tstart=T_start,
    zonName="Day",
    dp_nominal=20*DP_n)
    annotation (Placement(transformation(extent={{48,28},{72,52}})));
  TwoZoneApartmentHydronic.Components.Rooms.NightZone nigZon(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    Afloor=Afloor,
    mflow_n=mflow_n,
    qint=qint,
    Tstart=T_start,
    zonName="Night",
    dp_nominal=20*DP_n)
    annotation (Placement(transformation(extent={{46,-52},{70,-28}})));
  TwoZoneApartmentHydronic.Components.Thermostat_T thermostatDayZon(
    occSta=8*3600,
    occEnd=20*3600,
    TSetHeaUno=294.15,
    TSetHeaOcc=289.15,
    TSetHeaWee=289.15)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  inner IDEAS.BoundaryConditions.SimInfoManager
                       sim(filNam=Modelica.Utilities.Files.loadResource(
        "modelica://TwoZoneApartmentHydronic/Resources/IT-Milano-Linate-160800TM2.mos"))
    annotation (Placement(transformation(extent={{-104,-2},{-82,20}})));
  Buildings.Airflow.Multizone.DoorDiscretizedOpen doo(
    hA=3/2,
    hB=3/2,
    nCom=10,
    redeclare package Medium = MediumA,
    show_T=true,
    wOpe=0.8,
    hOpe=2,
    dp_turbulent=0.1,
    CD=0.78) "Discretized door" annotation (Placement(transformation(
        extent={{-8,-9},{8,9}},
        rotation=-90,
        origin={42,-3})));
  parameter Modelica.SIunits.Pressure DP_n=500 "nominal flow rate";
  Buildings.Utilities.IO.SignalExchange.WeatherStation weatherStation
    annotation (Placement(transformation(extent={{-80,-40},{-100,-20}})));
equation
  connect(hydronicSystem.ports_b[1],dayZon. supplyWater) annotation (Line(
        points={{12.8667,16.6},{12,16.6},{12,16},{54,16},{54,22},{53.52,22}},
                                                   color={0,127,255}));
  connect(hydronicSystem.ports_b[2], nigZon.supplyWater) annotation (Line(
        points={{12.8667,9.8},{24,9.8},{24,-64},{52,-64},{52,-58},{51.52,-58}},
        color={0,127,255}));
  connect(weaBus, hydronicSystem.weaBus) annotation (Line(
      points={{-60,10},{-54,10},{-54,10.14},{-17.7333,10.14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, nigZon.weaBus) annotation (Line(
      points={{-60,10},{-60,-40},{35.2,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus,dayZon. weaBus) annotation (Line(
      points={{-60,10},{-60,40},{37.2,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dayZon.returnWater, hydronicSystem.ports_a[1]) annotation (Line(
        points={{66.48,22},{74,22},{74,-14},{14,-14},{14,-10.6},{12.8667,-10.6}},
                                                               color={0,127,255}));
  connect(nigZon.returnWater, hydronicSystem.ports_a[2]) annotation (Line(
        points={{64.48,-58},{66,-58},{66,-80},{20,-80},{20,-3.8},{12.8667,-3.8}},
        color={0,127,255}));
  connect(dayZon.surf_conBou[2], nigZon.surf_surBou) annotation (Line(points={{
          61.44,37.36},{61.44,0},{67.6,0},{67.6,-42.88}}, color={191,0,0}));
  connect(sim.weaDatBus, weaBus) annotation (Line(
      points={{-82.11,9},{-72,9},{-72,10},{-60,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(nigZon.TRooAir, thermostatNigZon.TZon) annotation (Line(points={{78.4,
          -35.44},{78,-35.44},{78,-100},{-80,-100},{-80,-70},{-62,-70}}, color=
          {0,0,127}));
  connect(dayZon.TRooAir, thermostatDayZon.TZon) annotation (Line(points={{80.4,
          44.56},{80.4,98},{-80,98},{-80,70},{-62,70}}, color={0,0,127}));
  connect(thermostatNigZon.ValCon, hydronicSystem.ValConNigZon) annotation (
      Line(points={{-39,-64},{-32,-64},{-32,-12},{-18.3567,-12},{-18.3567,
          -11.28}}, color={0,0,127}));
  connect(thermostatDayZon.ValCon, hydronicSystem.ValConDayZon) annotation (
      Line(points={{-39,76},{-32,76},{-32,-5.84},{-18.3567,-5.84}}, color={0,0,
          127}));
  connect(thermostatNigZon.Occ, nigZon.occupation) annotation (Line(points={{-39,
          -70},{-10,-70},{-10,-29.92},{41.2,-29.92}}, color={0,0,127}));
  connect(thermostatDayZon.Occ, dayZon.occupation) annotation (Line(points={{-39,
          70},{0,70},{0,50.08},{43.2,50.08}}, color={0,0,127}));
  connect(doo.port_b2,dayZon. supplyAir) annotation (Line(points={{36.6,5},{
          36.6,43.84},{48,43.84}}, color={0,127,255}));
  connect(doo.port_a1,dayZon. returnAir) annotation (Line(points={{47.4,5},{
          47.4,21.5},{48,21.5},{48,37.6}}, color={0,127,255}));
  connect(doo.port_b1, nigZon.supplyAir) annotation (Line(points={{47.4,-11},{
          47.4,-23.5},{46,-23.5},{46,-36.16}}, color={0,127,255}));
  connect(doo.port_a2, nigZon.returnAir) annotation (Line(points={{36.6,-11},{
          36.6,-42.4},{46,-42.4}}, color={0,127,255}));
  connect(weatherStation.weaBus, weaBus) annotation (Line(
      points={{-80.1,-30.1},{-60,-30.1},{-60,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Radau"),
    Documentation(revisions="<html>
<ul>
<li>
August 5, 2022, by Ettore Zanetti:<br/>
Revision after comments
</li>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<h3>Building Design and use </h3>
<h4>Architecture</h4>
<p>
The building is a two room apartment model representing a real case study in Milan, which consists of two rooms and one bathroom.
The bathroom and the nightzone are considered together in a single thermal zone. So in total, two thermal zones are considered. The aparment is a newly built
heavy construction. The height of each room is 2.7 m, while the other dimensions are reported in the plan below. </p>
<p align=\"center\">
<img src=\"../../../doc/images/SmallApartmentPlan.png\"
     alt=\"SmallApartmentPlan.png\" />
</p>
<p>
The journal paper cited below shows a brief validation of the envelope model using experimental data. However, KPIs results may differ using the latest
version of the testcase due to updates with respect to the manuscript version in terms of internal gains, schedules and air mass exchange between the zones.</p>
<p> Zanetti E, Kim D, Blum D, Scoccia R, Aprile M. Performance comparison of quadratic, nonlinear, and mixed integer nonlinear MPC formulations and solvers on
an air source heat pump hydronic floor heating system. Journal of Building Performance Simulation. 2022 Sep 15:1-9.<a href=\"https://www.tandfonline.com/doi/full/10.1080/19401493.2022.2120631\"> [url]</a>
</p>
<h4>Constructions</h4>
<p>As can be seen from the plan, there are four different types of walls that, with the floor and the ceiling, constitute the boundaries of the thermal zones.
All the geometrical and thermal characteristics of the various material layers are highlighted below.
</p>
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>External wall</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Exterior plaster</td>
<td>0.005</td>
<td>0.300</td>
<td>840</td>
<td>1300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>EPS 120 thermal insulation panel</td>
<td>0.1</td>
<td>0.034</td>
<td>1250</td>
<td>23</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Masonry brick</td>
<td>0.3</td>
<td>0.207</td>
<td>840</td>
<td>750</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Gypsum plaster</td>
<td>0.02</td>
<td>0.570</td>
<td>1000</td>
<td>1300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
</p>
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Internal partition</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Glass wool insulation panel (CTGS Par70)</td>
<td>0.07</td>
<td>0.040</td>
<td>840</td>
<td>40</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
<p></p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Elevator separator</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Gypsum plaster</td>
<td>0.02</td>
<td>0.570</td>
<td>1000</td>
<td>1300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Concrete </td>
<td>0.3</td>
<td>2.15</td>
<td>880</td>
<td>2400</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Glass wool insulation panel (Par45)</td>
<td>0.045</td>
<td>0.038</td>
<td>1030</td>
<td>13</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
<p></p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Apartments separator</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Glass wool insulation panel (CTGS Par70)</td>
<td>0.07</td>
<td>0.040</td>
<td>840</td>
<td>40</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Glass wool insulation panel (CTGS Par70)</td>
<td>0.07</td>
<td>0.040</td>
<td>840</td>
<td>40</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>6</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>7</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
<p></p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Ceiling</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Ceramic tiles</td>
<td>0.015</td>
<td>1.000</td>
<td>840</td>
<td>2300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Concrete slab with additive</td>
<td>0.064</td>
<td>1.000</td>
<td>880</td>
<td>1800</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Expanded polystyrene</td>
<td>0.026</td>
<td>0.034</td>
<td>1300</td>
<td>25</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Isover fonasoft</td>
<td>0.006</td>
<td>0.113</td>
<td>2100</td>
<td>450</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Light substrate</td>
<td>0.105</td>
<td>0.100</td>
<td>1200</td>
<td>400</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>6</td>
<td>Reinforced concrete (1% steel) </td>
<td>0.230</td>
<td>2.300</td>
<td>1000</td>
<td>2300</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>7</td>
<td>Gypsum and sand plaster</td>
<td>0.200</td>
<td>0.800</td>
<td>1000</td>
<td>1600</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
<p></p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Radiant floor</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Ceramic tiles</td>
<td>0.015</td>
<td>1.000</td>
<td>840</td>
<td>2300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Concrete slab with additive</td>
<td>0.064</td>
<td>1.000</td>
<td>880</td>
<td>1800</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Expanded polystyrene</td>
<td>0.026</td>
<td>0.034</td>
<td>1300</td>
<td>25</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Isover fonasoft</td>
<td>0.006</td>
<td>0.113</td>
<td>2100</td>
<td>450</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Light substrate</td>
<td>0.105</td>
<td>0.100</td>
<td>1200</td>
<td>400</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>6</td>
<td>Reinforced concrete (1% steel) </td>
<td>0.230</td>
<td>2.300</td>
<td>1000</td>
<td>2300</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>7</td>
<td>Gypsum and sand plaster</td>
<td>0.200</td>
<td>0.800</td>
<td>1000</td>
<td>1600</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
</p>
<p>These properties are defined in the model of each thermal zone respectively in the component <code>matExtWal</code>, <code>IntWall</code>,
<code>ElevatorSep</code>, <code>AptSep</code>, <code>roof</code> and <code>slaCon</code>. All the material layers are defined starting from  outside to
room-side except for the radiant floor that requires the opposite order, as reported in the Modelica Buildings Library envelope user guide.
<p> Considering the two glazing systems of the small apartment, they have the same construction and shading system,
differing only in the dimensions. These characteristics are reported in the tables below.
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"3\"><b>Glazing system dimensions</b></td></tr>
<tr>
<th>Room</th>
<th>height <br>[m]</th>
<th>length <br>[m]</th>
</tr>
<tr>
<td>Day Zone</td>
<td>2.35</td>
<td>2.5</td>
</tr>
<tr>
<td>Night Zone</td>
<td>2.35</td>
<td>1.6</td>
</table>
</p>
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Glazing system physical properties</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>tauSol <br>[-]</th>
<th>rhoSol <br>[-]</th>
<th>tauIR <br> [-]</th>
<th>absIR <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Glass</td>
<td>0.003</td>
<td>1</td>
<td rowspan=\"3\">0.6</td>
<td>0.075</td>
<td>0</td>
<td>0.84</td>
</tr>
<tr>
<td>2</td>
<td>Air</td>
<td>0.013</td>
<td>-</td>
<td>-</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Glass</td>
<td>0.003</td>
<td>1</td>
<td>0.075</td>
<td>0</td>
<td>0.84</td>
</tr>
</p><p>
</table>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"4\"><b>Shading system physical properties</b></td></tr>
<tr>
<th>tauSol <br>[-]</th>
<th>rhoSol <br>[-]</th>
<th>tauIR <br> [-]</th>
<th>absIR <br>[-]</th>
</tr>
<tr>
<td>0.1</td>
<td>0.8</td>
<td>0</td>
<td>0.84</td>
</tr>
</table>
</p>
<p>The dimensions of the glazing system of the two thermal zones that face towards outside are two parameters that have been defined in the zone components, while the glazing system and shading system physical properties
have been defined in the record \"Window24\".

<p>The thermal zone model also includes the radiant slab component taken from the Modelica Buildings Library.  The properties are reported in the following table.
</p>
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"2\"><b>Radiant slab properties</b></td></tr>
<tr>
<td>Pipe distance [m]</th>
<td>0.1</th>
</tr>
<tr>
<td>Interface layer in which pipes are located [-]</td>
<td>2</td>
</tr>
</table>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"2\"><b>Pipe properties</b></td></tr>
<tr>
<td>Outer diameter [m]</th>
<td>0.017</th>
</tr>
<tr>
<td>Inner diameter [m]</th>
<td>0.015</th>
</tr>
<tr>
<td>Roughness [m]</td>
<td>0.000007</td>
</tr>
<tr>
<td>Density [kg/m<sup>3</sup>]</td>
<td>983</td>
</tr>
<tr>
<td>Thermal conductivity [W/(m K)]</td>
<td>0.4</td>
</tr>
</table>
</p>
<p>
<h4>Occupancy schedule</h4>
<p>The apartment is occupied from 8 P.M. to 8 A.M. from Monday to Friday by two people, one per thermal zone. The thermal zones are considered unoccupied on Saturday and Sunday.</p>
<h4>Internal loads and schedules</h4>
<p>The heating setpoint is considered 21 [°C] for occupied periods and 16 [°C] for unoccupied periods. The main heat gains come from people, appliances and lighting. For people it corresponds to 60 (W/person) of sensible gains divided equally between
convective and radiative contributions and 20 (W) of latent gains. Internal gains for the appliances are 4 (W/m2) and for lighting 1.5 (W/m2) of sensible gains were considred divided
equally between convective and radiative contributions. These values are taken from a combination of ASHRAE 90.1 standard and ENI 13200. CO2 generation is 0.0048 L/s per person (Table 5, Persily and De Jonge 2017) and density of CO2 assumed to be 1.8 kg/m^3,making CO2 generation 8.64e-6 kg/s per person.Outside air CO2 concentration is 400 ppm.  However, CO2 concentration is not controlled for in the model. Lastly, infilatrations was considered a constant value of 0.5 (vol/h) for each thermal zone.</p>
<h4>Climate data</h4>
<p>The climate is assumed to be near Milan, Italy with a latitude and longitude of 45.44,9.27. The climate data comes from the Milano Linate TMY set. </p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>Only heating is considered. The HVAC system is made up of two floor heating circuits, one per thermal zone that can be controlled with an on-off valve.
The generation system is an air source heat pump with a nominal heat capacity of 5kW modelled after a Daikin heat pump. Below is reported a schematic view of the HVAC system.</p>
<p align=\"center\">
<img src=\"../../../doc/images/HVACscheme.png\"
     alt=\"HVACscheme.png\" />
</p>
<h4>Equipment specifications and performance maps</h4>
<p> The heating system circulation pump has the default efficiency of the pump model, which is 49%; at the time of writing. The flow rate for each thermal zone floor heating circuit is 620 [l/h].  The heat pump perfomance map is the default map present in the IDEAS Library heat pump
model coming from a Daikin heat pump.
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
The default controller has two levels of control. The first level is done by the thermostats using a hysteresis controller with 2 [K] bandwidth. When the room temperature
is lower than setpoint minus half the bandwidth the thermostat will open the floor heating circuit valve. Viceversa, when the room temperature is higher than setpoint plus half
the bandwidth the thermostat will close the valve. The second level controller controls the heat pump supply temperature using a climatic curve based on the external temperature and an hysteresis controller.
The figure below reports a scheme of the controls.
<p align=\"center\">
<img src=\"../../../doc/images/ControlScheme.png\"
     alt=\"ControlScheme.png\" />
</p>

<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>hydronicSystem_oveMDayZ_u</code> [1] [min=0.0, max=1.0]: Signal Day zone valve
</li>
<li>
<code>hydronicSystem_oveMNigZ_u</code> [1] [min=0.0, max=1.0]: Signal Night zone valve
</li>
<li>
<code>hydronicSystem_oveMpumCon_u</code> [kg/s] [min=0.0, max=5.0]: Mass flow rate control input to circulation pump for water through floor heating system
</li>
<li>
<code>hydronicSystem_oveTHea_u</code> [K] [min=273.15, max=318.15]: Heat system supply temperature
</li>
<li>
<code>thermostatDayZon_oveTsetZon_u</code> [K] [min=273.15, max=318.15]: Setpoint temperature for thermal zone
</li>
<li>
<code>thermostatNigZon_oveTsetZon_u</code> [K] [min=273.15, max=318.15]: Setpoint temperature for thermal zone
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>dayZon_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Zone air CO2 concentration
</li>
<li>
<code>dayZon_reaMFloHea_y</code> [kg/s] [min=None, max=None]: Zone water mass flow rate floor heating
</li>
<li>
<code>dayZon_reaPLig_y</code> [W] [min=None, max=None]: Lighting power submeter
</li>
<li>
<code>dayZon_reaPPlu_y</code> [W] [min=None, max=None]: Plug load power submeter
</li>
<li>
<code>dayZon_reaPowFlooHea_y</code> [W] [min=None, max=None]: Floor heating power
</li>
<li>
<code>dayZon_reaPowQint_y</code> [W] [min=None, max=None]: Internal heat gains
</li>
<li>
<code>dayZon_reaTRooAir_y</code> [K] [min=None, max=None]: Zone air temperature
</li>
<li>
<code>dayZon_reaTavgFloHea_y</code> [K] [min=None, max=None]: Zone average floor temperature
</li>
<li>
<code>dayZon_reaTretFloHea_y</code> [K] [min=None, max=None]: Zone return water temperature floor heating
</li>
<li>
<code>dayZon_reaTsupFloHea_y</code> [K] [min=None, max=None]: Zone supply water temperature floor heating
</li>
<li>
<code>hydronicSystem_reaCOPhp_y</code> [1] [min=None, max=None]: air source heat pump COP
</li>
<li>
<code>hydronicSystem_reaPPum_y</code> [W] [min=None, max=None]: Pump electrical power
</li>
<li>
<code>hydronicSystem_reaPeleHeaPum_y</code> [W] [min=None, max=None]: Electric consumption of the heat pump
</li>
<li>
<code>hydronicSystem_reaTretFloHea_y</code> [K] [min=None, max=None]: Heat pump return water temperature floor heating
</li>
<li>
<code>nigZon_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Zone air CO2 concentration
</li>
<li>
<code>nigZon_reaMFloHea_y</code> [kg/s] [min=None, max=None]: Zone water mass flow rate floor heating
</li>
<li>
<code>nigZon_reaPLig_y</code> [W] [min=None, max=None]: Lighting power submeter
</li>
<li>
<code>nigZon_reaPPlu_y</code> [W] [min=None, max=None]: Plug load power submeter
</li>
<li>
<code>nigZon_reaPowFlooHea_y</code> [W] [min=None, max=None]: Floor heating power
</li>
<li>
<code>nigZon_reaPowQint_y</code> [W] [min=None, max=None]: Internal heat gains
</li>
<li>
<code>nigZon_reaTRooAir_y</code> [K] [min=None, max=None]: Zone air temperature
</li>
<li>
<code>nigZon_reaTavgFloHea_y</code> [K] [min=None, max=None]: Zone average floor temperature
</li>
<li>
<code>nigZon_reaTretFloHea_y</code> [K] [min=None, max=None]: Zone return water temperature floor heating
</li>
<li>
<code>nigZon_reaTsupFloHea_y</code> [K] [min=None, max=None]: Zone supply water temperature floor heating
</li>
<li>
<code>weatherStation_reaWeaCeiHei_y</code> [m] [min=None, max=None]: Cloud cover ceiling height measurement
</li>
<li>
<code>weatherStation_reaWeaCloTim_y</code> [s] [min=None, max=None]: Day number with units of seconds
</li>
<li>
<code>weatherStation_reaWeaHDifHor_y</code> [W/m2] [min=None, max=None]: Horizontal diffuse solar radiation measurement
</li>
<li>
<code>weatherStation_reaWeaHDirNor_y</code> [W/m2] [min=None, max=None]: Direct normal radiation measurement
</li>
<li>
<code>weatherStation_reaWeaHGloHor_y</code> [W/m2] [min=None, max=None]: Global horizontal solar irradiation measurement
</li>
<li>
<code>weatherStation_reaWeaHHorIR_y</code> [W/m2] [min=None, max=None]: Horizontal infrared irradiation measurement
</li>
<li>
<code>weatherStation_reaWeaLat_y</code> [rad] [min=None, max=None]: Latitude of the location
</li>
<li>
<code>weatherStation_reaWeaLon_y</code> [rad] [min=None, max=None]: Longitude of the location
</li>
<li>
<code>weatherStation_reaWeaNOpa_y</code> [1] [min=None, max=None]: Opaque sky cover measurement
</li>
<li>
<code>weatherStation_reaWeaNTot_y</code> [1] [min=None, max=None]: Sky cover measurement
</li>
<li>
<code>weatherStation_reaWeaPAtm_y</code> [Pa] [min=None, max=None]: Atmospheric pressure measurement
</li>
<li>
<code>weatherStation_reaWeaRelHum_y</code> [1] [min=None, max=None]: Outside relative humidity measurement
</li>
<li>
<code>weatherStation_reaWeaSolAlt_y</code> [rad] [min=None, max=None]: Solar altitude angle measurement
</li>
<li>
<code>weatherStation_reaWeaSolDec_y</code> [rad] [min=None, max=None]: Solar declination angle measurement
</li>
<li>
<code>weatherStation_reaWeaSolHouAng_y</code> [rad] [min=None, max=None]: Solar hour angle measurement
</li>
<li>
<code>weatherStation_reaWeaSolTim_y</code> [s] [min=None, max=None]: Solar time
</li>
<li>
<code>weatherStation_reaWeaSolZen_y</code> [rad] [min=None, max=None]: Solar zenith angle measurement
</li>
<li>
<code>weatherStation_reaWeaTBlaSky_y</code> [K] [min=None, max=None]: Black-body sky temperature measurement
</li>
<li>
<code>weatherStation_reaWeaTDewPoi_y</code> [K] [min=None, max=None]: Dew point temperature measurement
</li>
<li>
<code>weatherStation_reaWeaTDryBul_y</code> [K] [min=None, max=None]: Outside drybulb temperature measurement
</li>
<li>
<code>weatherStation_reaWeaTWetBul_y</code> [K] [min=None, max=None]: Wet bulb temperature measurement
</li>
<li>
<code>weatherStation_reaWeaWinDir_y</code> [rad] [min=None, max=None]: Wind direction measurement
</li>
<li>
<code>weatherStation_reaWeaWinSpe_y</code> [m/s] [min=None, max=None]: Wind speed measurement
</li>
</ul>
<h4>Forecasts</h4>
The model forecasts are:
<ul>
<li>
<code>EmissionsBiomassPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from biomass
</li>
<li>
<code>EmissionsDistrictHeatingPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal district heating
</li>
<li>
<code>EmissionsElectricPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh of electricity
</li>
<li>
<code>EmissionsGasPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from gas
</li>
<li>
<code>EmissionsSolarThermalPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from solar irradiation
</li>
<li>
<code>HDifHor</code> [W/m2]: Horizontal diffuse solar radiation
</li>
<li>
<code>HDirNor</code> [W/m2]: Direct normal radiation
</li>
<li>
<code>HGloHor</code> [W/m2]: Horizontal global radiation
</li>
<li>
<code>InternalGainsCon[Day]</code> [W]: Convective internal gains of zone
</li>
<li>
<code>InternalGainsCon[Night]</code> [W]: Convective internal gains of zone
</li>
<li>
<code>InternalGainsLat[Day]</code> [W]: Latent internal gains of zone
</li>
<li>
<code>InternalGainsLat[Night]</code> [W]: Latent internal gains of zone
</li>
<li>
<code>InternalGainsRad[Day]</code> [W]: Radiative internal gains of zone
</li>
<li>
<code>InternalGainsRad[Night]</code> [W]: Radiative internal gains of zone
</li>
<li>
<code>LowerSetp[Day]</code> [K]: Lower temperature set point for thermal comfort of zone
</li>
<li>
<code>LowerSetp[Night]</code> [K]: Lower temperature set point for thermal comfort of zone
</li>
<li>
<code>Occupancy[Day]</code> [number of people]: Number of occupants of zone
</li>
<li>
<code>Occupancy[Night]</code> [number of people]: Number of occupants of zone
</li>
<li>
<code>PriceBiomassPower</code> [($/Euro)/kWh]: Price to produce 1 kWh thermal from biomass
</li>
<li>
<code>PriceDistrictHeatingPower</code> [($/Euro)/kWh]: Price of 1 kWh thermal from district heating
</li>
<li>
<code>PriceElectricPowerConstant</code> [($/Euro)/kWh]: Completely constant electricity price
</li>
<li>
<code>PriceElectricPowerDynamic</code> [($/Euro)/kWh]: Electricity price for a day/night tariff
</li>
<li>
<code>PriceElectricPowerHighlyDynamic</code> [($/Euro)/kWh]: Spot electricity price
</li>
<li>
<code>PriceGasPower</code> [($/Euro)/kWh]: Price to produce 1 kWh thermal from gas
</li>
<li>
<code>PriceSolarThermalPower</code> [($/Euro)/kWh]: Price to produce 1 kWh thermal from solar irradiation
</li>
<li>
<code>TBlaSky</code> [K]: Black Sky temperature
</li>
<li>
<code>TDewPoi</code> [K]: Dew point temperature
</li>
<li>
<code>TDryBul</code> [K]: Dry bulb temperature at ground level
</li>
<li>
<code>TWetBul</code> [K]: Wet bulb temperature
</li>
<li>
<code>UpperCO2[Day]</code> [ppm]: Upper CO2 set point for indoor air quality of zone
</li>
<li>
<code>UpperCO2[Night]</code> [ppm]: Upper CO2 set point for indoor air quality of zone
</li>
<li>
<code>UpperSetp[Day]</code> [K]: Upper temperature set point for thermal comfort of zone
</li>
<li>
<code>UpperSetp[Night]</code> [K]: Upper temperature set point for thermal comfort of zone
</li>
<li>
<code>ceiHei</code> [m]: Ceiling height
</li>
<li>
<code>cloTim</code> [s]: One-based day number in seconds
</li>
<li>
<code>lat</code> [rad]: Latitude of the location
</li>
<li>
<code>lon</code> [rad]: Longitude of the location
</li>
<li>
<code>nOpa</code> [1]: Opaque sky cover [0, 1]
</li>
<li>
<code>nTot</code> [1]: Total sky Cover [0, 1]
</li>
<li>
<code>pAtm</code> [Pa]: Atmospheric pressure
</li>
<li>
<code>relHum</code> [1]: Relative Humidity
</li>
<li>
<code>solAlt</code> [rad]: Altitude angel
</li>
<li>
<code>solDec</code> [rad]: Declination angle
</li>
<li>
<code>solHouAng</code> [rad]: Solar hour angle.
</li>
<li>
<code>solTim</code> [s]: Solar time
</li>
<li>
<code>solZen</code> [rad]: Zenith angle
</li>
<li>
<code>winDir</code> [rad]: Wind direction
</li>
<li>
<code>winSpe</code> [m/s]: Wind speed
</li>
</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
Artificial lighting is provided by LED lights in the thermal zones.
</p>
<h4>Shading</h4>
<p>
There are no shades on the building.
</p>
<h4>Onsite Generation and Storage</h4>
<p>
There is no energy generation or storage on the site.
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
A moist air model is used, but condensation is not modeled in the HVAC
and humidity is not monitored.

</p>
<h4>Pressure-flow models</h4>
<p>
The pump is an ideal constant head pump and provided each floor heating circuit with exactly 620 [l/h] if the circuit valve is open.
</p>
<h4>Infiltration models</h4>
<p>
A constant infiltration flowrate is assumed to be 0.5 ACH.
</p>
<h4>Other assumptions</h4>
<p>
No further assumptions are needed.
</p>
<h3>Scenario Information</h3>
<h4>Time Periods</h4>
<p>
The <b>Peak Heat Day</b> (specifier for <code>/scenario</code> API is <code>'peak_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with the
maximum 15-minute system heating load in the year.
</ul>
<ul>
Start Time: Day 308.
</ul>
<ul>
End Time: Day 322.
</ul>
</p>
<p>
The <b>Typical Heat Day</b> (specifier for <code>/scenario</code> API is <code>'typical_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with day with
the maximum 15-minute system heating load that is closest from below to the
median of all 15-minute maximum heating loads of all days in the year.
</ul>
<ul>
Start Time: Day 16.
</ul>
<ul>
End Time: Day 30.
</ul>
</p>
<h4>Energy Pricing</h4>
<p>
The <b>Constant Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'constant'</code>) profile is:
<ul>
Based on the ARERA 2021 (Autorità di Regolazione per Energia Reti e Ambiente ,\"Italian authority for grid and environment regulation\") estimates <a href=\"https://www.arera.it/it/inglese/index.htm\">
https://www.arera.it/it/inglese/index.htm</a>. The price for the whole heating season, 10/15 to 04/15 is considered as 0.2 [€/kWh].
</ul>
</p>
<p>
The <b>Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'dynamic'</code>) profile is:
<ul>
Based on the ARERA 2021 estimates for the bi daily profile, price is 0.22 [€/kWh] for the period between 8:00 A.M. and 7 P.M. and 0.19 [€/kWh] for the period between 8 P.M. and 7 A.M. for the whole heating season.
</ul>
</p>

<p>
The <b>Highly Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'highly_dynamic'</code>) profile is:
<ul>
Based on the the
day-ahead energy prices as determined from the GSE <a href=\"https://www.mercatoelettrico.org/it/mercati/mercatoelettrico/mpe.aspx\">
https://www.mercatoelettrico.org/it/mercati/mercatoelettrico/mpe.aspx</a> with the addition of taxes and distribution costs estimated from ARERA for the year 2019.

</ul>
</p>

<h4>Emission Factors</h4>
<p>
The <b>Electricity Emissions Factor</b> profile is:
<ul>
Based on the average electricity generation mix for Italy for the year of
2017.  It is 0.312 kgCO2/kWh.
For reference,
see <a href=\"https://www.isprambiente.gov.it/en\">
https://www.isprambiente.gov.it/en</a>
</ul>
</p>


</html>
"));
end ApartmentModelQHTyp;
