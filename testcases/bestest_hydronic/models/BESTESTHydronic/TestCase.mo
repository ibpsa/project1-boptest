within BESTESTHydronic;
model TestCase "Single zone residential hydronic example model"
  extends Modelica.Icons.Example;
  String test = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/Uccle.TMY") "This is to ensure that the weather file is loaded when encapsulating this model into an FMU";
  package MediumWater = IDEAS.Media.Water "Water medium";
  package MediumAir = IDEAS.Media.Air(extraPropertiesNames={"CO2"}) "Air medium";
  parameter Modelica.Units.SI.Temperature TSetCooUno=273.15 + 30
    "Unoccupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.Units.SI.Temperature TSetCooOcc=273.15 + 24
    "Occupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.Units.SI.Temperature TSetHeaUno=273.15 + 15
    "Unoccupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.Units.SI.Temperature TSetHeaOcc=273.15 + 21
    "Occupied heating setpoint" annotation (Dialog(group="Setpoints"));

  inner IDEAS.BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-180,80},{-160,100}})));

  Modelica.Units.SI.Efficiency eta={-6.017763e-11,2.130271e-8,-3.058709e-6,
      2.266453e-4,-9.048470e-3,1.805752e-1,-4.540036e-1}*{TCorr^(6 - i) for i in
          0:6} "Boiler efficiency";
  Real TCorr=min(max(pump.heatPort.T - 273.15, 25), 75)
    "Temperature within validity range of correlation";

  IDEAS.Buildings.Validation.Cases.Case900Template case900Template(
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Buildings.Components.Occupants.Input
                                                   occNum,
    redeclare IDEAS.Buildings.Components.OccupancyType.OfficeWork
                                                            occTyp,
    mSenFac=1,
    n50=10)
    "Case 900 BESTEST model"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = MediumWater,
    T_a_nominal=273.15 + 70,
    T_b_nominal=273.15 + 50,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Q_flow_nominal=5000,
    dp_nominal=pump.dp_nominal)
    "Radiator"               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,10})));
  IDEAS.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = MediumWater,
    m_flow_nominal=pump.m_flow_nominal,
    dp_nominal=0,
    QMax_flow=5000) "Ideal heater - pressure drop merged into radiator"
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  IDEAS.Fluid.Movers.FlowControlled_dp pump(
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_riseTime=false,
    redeclare package Medium = MediumWater,
    m_flow_nominal=rad.m_flow_nominal,
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    dp_nominal=100000) "Hydronic pump"
    annotation (Placement(transformation(extent={{0,0},{20,-20}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(
    nPorts=1,
    redeclare package Medium = MediumWater)
    "Absolute pressure boundary"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Interfaces.RealOutput Q(unit="W")
    "Thermal power use of heater"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput TZone(unit="K")
    "Zone operative temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  IDEAS.Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
    annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
  Modelica.Blocks.Sources.RealExpression yOcc(y=if (calTim.hour < 7 or calTim.hour
         > 19) or calTim.weekDay > 5 then 1 else 0)
    "Fixed schedule of 1 occupant between 7 am and 8 pm"
    annotation (Placement(transformation(extent={{-92,38},{-72,58}})));
  IDEAS.Utilities.IO.SignalExchange.Read reaTRoo(
    description="Operative zone temperature",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.OperativeZoneTemperature,
    y(unit="K")) "Block for reading the operative zone temperature"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSetSup(u(
      min=273.15 + 20,
      max=273.15 + 80,
      unit="K"), description="Supply temperature setpoint of the heater")
    "Block for overwriting supply temperature control signal" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-18,80})));
  Modelica.Blocks.Sources.Constant offSet(k=0.1, y(unit="K"))
    "Offset above heating temperature setpoint to ensure comfort"
    annotation (Placement(transformation(extent={{-180,-20},{-160,0}})));
  IDEAS.Utilities.IO.SignalExchange.Read reaQHea(
    description="Heating thermal power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    y(unit="W")) "Block for outputting the thermal power"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));

  IDEAS.Utilities.IO.SignalExchange.Read reaPPum(
    description="Pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Block for reading the pump electrical power"
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));

  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  IDEAS.Controls.Discrete.HysteresisRelease con(revert=true)
    "Hysteresis controller for emission system "
    annotation (Placement(transformation(extent={{-32,-80},{-12,-60}})));
  IDEAS.Utilities.IO.SignalExchange.Overwrite ovePum(u(
      min=0,
      max=1,
      unit="1"), description="Integer signal to control the stage of the pump either on or off")
    "Block for overwriting pump control signal" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,-70})));

  IDEAS.Utilities.IO.SignalExchange.Read reaCO2RooAir(
    description="CO2 concentration in the zone",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm")) "Block for reading CO2 concentration in the zone"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Modelica.Blocks.Sources.RealExpression QGas(y=hea.Q_flow/eta)
    "Primary gas thermal power"
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(
      unit="K",
      min=273.15 + 5,
      max=273.15 + 35), description=
        "Zone operative temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,-50})));
  IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSetHea(u(
      max=273.15 + 35,
      unit="K",
      min=273.15 + 5), description=
        "Zone operative temperature setpoint for heating")
    "Overwrite for zone heating setpoint" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,-80})));
  Modelica.Blocks.Sources.RealExpression TSetCoo(y=if yOcc.y > 0 then
        TSetCooOcc else TSetCooUno) "Cooling temperature setpoint with setback"
    annotation (Placement(transformation(extent={{-180,-60},{-160,-40}})));
  Modelica.Blocks.Sources.RealExpression TSetHea(y=if yOcc.y > 0 then
        TSetHeaOcc else TSetHeaUno) "Heating temperature setpoint with setback"
    annotation (Placement(transformation(extent={{-180,-90},{-160,-70}})));
  Modelica.Blocks.Continuous.LimPID conPI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=10,
    Ti=300,
    yMax=273.15 + 80,
    yMin=273.15 + 20,
    initType=Modelica.Blocks.Types.Init.InitialState)
    "PI controller for the boiler supply water temperature"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-150,-90},{-130,-70}})));
  IDEAS.Utilities.IO.SignalExchange.WeatherStation weaSta
    "BOPTEST weather station"
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
equation
  connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points={{-37.2,
          12},{-48,12},{-48,7},{-60,7}}, color={191,0,0}));
  connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points={{-37.2,
          8},{-46,8},{-46,4},{-60,4}}, color={191,0,0}));
  connect(pump.port_a, rad.port_b)
    annotation (Line(points={{0,-10},{-30,-10},{-30,0}}, color={0,127,255}));
  connect(pump.port_b, hea.port_a) annotation (Line(points={{20,-10},{40,-10},{40,
          30},{20,30}}, color={0,127,255}));
  connect(bou.ports[1], pump.port_a)
    annotation (Line(points={{-20,-30},{0,-30},{0,-10}}, color={0,127,255}));
  connect(case900Template.yOcc, yOcc.y)
    annotation (Line(points={{-81,18},{-81,48},{-71,48}},color={0,0,127}));
  connect(case900Template.TSensor,reaTRoo. u) annotation (Line(points={{-59,12},
          {46,12},{46,30},{58,30}},
                                  color={0,0,127}));
  connect(reaTRoo.y, TZone)
    annotation (Line(points={{81,30},{96,30},{96,0},{110,0}},
                                              color={0,0,127}));
  connect(reaQHea.y, Q)
    annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(reaPPum.u, pump.P) annotation (Line(points={{58,-30},{24,-30},{24,-19},
          {21,-19}},               color={0,0,127}));
  connect(hea.port_b, rad.port_a)
    annotation (Line(points={{0,30},{-30,30},{-30,20}}, color={0,127,255}));
  connect(case900Template.TSensor, con.u) annotation (Line(points={{-59,12},{-54,
          12},{-54,-40},{-40,-40},{-40,-70},{-34,-70}},               color={0,
          0,127}));
  connect(con.y, ovePum.u)
    annotation (Line(points={{-11,-70},{-2,-70}}, color={0,0,127}));
  connect(realToInteger.y, pump.stage) annotation (Line(points={{81,-70},{88,
          -70},{88,-48},{10,-48},{10,-22}}, color={255,127,0}));
  connect(case900Template.ppm, reaCO2RooAir.u) annotation (Line(points={{-59,10},
          {-50,10},{-50,0},{58,0}}, color={0,0,127}));
  connect(QGas.y,reaQHea. u)
    annotation (Line(points={{51,60},{58,60}}, color={0,0,127}));
  connect(TSetCoo.y, oveTSetCoo.u)
    annotation (Line(points={{-159,-50},{-122,-50}}, color={0,0,127}));
  connect(conPI.y, oveTSetSup.u)
    annotation (Line(points={{-59,80},{-30,80}}, color={0,0,127}));
  connect(offSet.y, add.u1) annotation (Line(points={{-159,-10},{-156,-10},{-156,
          -74},{-152,-74}},
                          color={0,0,127}));
  connect(case900Template.TSensor, conPI.u_m) annotation (Line(points={{-59,12},
          {-54,12},{-54,60},{-70,60},{-70,68}}, color={0,0,127}));
  connect(sim.weaDatBus, weaSta.weaBus) annotation (Line(
      points={{-160.1,90},{-150,90},{-150,89.9},{-139.9,89.9}},
      color={255,204,51},
      thickness=0.5));
  connect(TSetHea.y, add.u2) annotation (Line(points={{-159,-80},{-156,-80},{-156,
          -86},{-152,-86}}, color={0,0,127}));
  connect(add.y, oveTSetHea.u)
    annotation (Line(points={{-129,-80},{-122,-80}}, color={0,0,127}));
  connect(oveTSetSup.y, hea.TSet) annotation (Line(points={{-7,80},{26,80},{26,38},
          {22,38}}, color={0,0,127}));
  connect(ovePum.y, realToInteger.u)
    annotation (Line(points={{21,-70},{58,-70}}, color={0,0,127}));
  connect(oveTSetCoo.y, con.uHigh) annotation (Line(points={{-99,-50},{-54,-50},
          {-54,-74},{-34,-74}}, color={0,0,127}));
  connect(oveTSetHea.y, con.uLow) annotation (Line(points={{-99,-80},{-40,-80},{
          -40,-78},{-34,-78}}, color={0,0,127}));
  connect(oveTSetHea.y, conPI.u_s) annotation (Line(points={{-99,-80},{-94,-80},
          {-94,80},{-82,80}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=31500000),
    Documentation(info="<html>
<p>
This is a single zone residential hydronic system model 
for WP 1.2 of IBPSA project 1. 
</p>
<h3>Building Design and Use</h3>
<h4>Architecture</h4>
<p>
This building envelope model corresponds to the BESTEST case 900 test case. 
It consists of a single zone with a rectangular floor plan of 6 by 8 meters 
and a height of 2.7 m. The zone further consists of two south-oriented windows 
of 6 m2 each, which are modelled using a single window of 12 m2. 
</p>
<h4>Constructions</h4>
<p>
The walls consist of 10 cm thick concrete blocks and 6 cm of foam insulation. 
For more details see 
<a href=\"modelica://IDEAS.Buildings.Validation.Data.Constructions.HeavyWall\">
IDEAS.Buildings.Validation.Data.Constructions.HeavyWall</a>. 
The floor consists of 8 cm of concrete and 1 m of insulation, representing a 
perfectly insulated floor. The roof consists of a light construction and 11 cm 
of fibreglass. 
</p>
<h4>Occupancy schedules</h4>
<p>
The zone is occupied by one person before 7 am and after 8 pm each weekday 
and full time during weekends. 
</p>
<h4>Internal loads and schedules</h4>
<p>
There are no internal loads other than the occupants. 
</p>
<h4>Climate data</h4>
<p>
The model uses a climate file containing one year
of weather data for Brussels, Belgium.
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
The model only has a primary heating system that heats the zone using a 
single radiator with thermostatic valve, a circulation pump and a water heater.
The system is presented in Figure 1 below.
The radiator nominal thermal power and heater maximum thermal power is 5 kW. 
The heating setpoint is set to 21 &#176;C during occupied 
periods and 15 &#176;C during unoccupied periods. The cooling setpoint is set to 
24 &#176;C during occupied peridos and 30 &#176;C during unoccupied periods. 
The gas heater efficiency is computed using a polynomial curve and it uses a PI 
controller to modulate supply water temperature between 20 and 80 &#176;C to 
track a reference for the operative zone temperature 
that equals the heating setpoint plus an offset 
of 0.1 &#176;C by default. 

<p>
<br>
</p>

</p>
<p align=\"center\">
<img src=\"modelica://IDEAS/Resources/Images/Examples/IBPSA/SingleZoneResidentialHydronic_Schematic.png\" alt=\"image\"/>
<figcaption><small>Figure 1: System schematic.</small></figcaption>
</p>

<p>
<br>
</p>

</p>
<h4>Equipment specifications and performance maps</h4>
<p>
The heating system circulation pump has the default efficiency of the pump 
model, which is 49%; at the time of writing. The heater efficiency is 
computed using a polynomial curve. 
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
The model assumes a pump with a constant head, 
which results in a fixed flow rate due to the fixed pressure drop coefficient of the radiator.
The supply water temperature set point of the boiler is modulated using a PI
controller that tracks zone operative temperature to follow the zone operative temperature setpoint,
depicted as controller C1 in Figure 1 and shown in Figure 2 below.
For baseline control, this setpoint is defined as 
the heating comfort setpoint plus an offset of 0.1 &#176;C. 
The pump is switched on and off with hysteresis based on the indoor 
temperature with the heating set point as the low point and the cooling set point
as the high point.  It is assumed that the boiler exactly 
outputs the supply water temperature set point using an ideal controller
depicted as C2 in Figure 1.
</p>

<p>
<br>
</p>

</p>
<p align=\"center\">
<img src=\"modelica://IDEAS/Resources/Images/Examples/IBPSA/SingleZoneResidentialHydronic_C1.png\" alt=\"image\"/>
<figcaption><small>Figure 2: Controller C1.</small></figcaption>
</p>

<p>
<br>
</p>

<h3>Model IO's</h3>
<h4>Inputs</h4>
<p>The model inputs are: </p>
<ul>
<li>
<code>ovePum_activate</code> [1] [min=0, max=1]: Activation signal to overwrite input ovePum_u where 1 activates, 0 deactivates (default value)
</li>
<li>
<code>ovePum_u</code> [1] [min=0.0, max=1.0]: Integer signal to control the stage of the pump either on or off
</li>
<li>
<code>oveTSetCoo_activate</code> [1] [min=0, max=1]: Activation signal to overwrite input oveTSetCoo_u where 1 activates, 0 deactivates (default value)
</li>
<li>
<code>oveTSetCoo_u</code> [K] [min=278.15, max=308.15]: Zone operative temperature setpoint for cooling
</li>
<li>
<code>oveTSetHea_activate</code> [1] [min=0, max=1]: Activation signal to overwrite input oveTSetHea_u where 1 activates, 0 deactivates (default value)
</li>
<li>
<code>oveTSetHea_u</code> [K] [min=278.15, max=308.15]: Zone operative temperature setpoint for heating
</li>
<li>
<code>oveTSetSup_activate</code> [1] [min=0, max=1]: Activation signal to overwrite input oveTSetSup_u where 1 activates, 0 deactivates (default value)
</li>
<li>
<code>oveTSetSup_u</code> [K] [min=293.15, max=353.15]: Supply temperature setpoint of the heater
</li>
</ul>
<h4>Outputs</h4>
<p>The model outputs are: </p>
<ul>
<li>
<code>reaQHea_y</code> [W] [min=None, max=None]: Heating thermal power
</li>
<li>
<code>reaPPum_y</code> [W] [min=None, max=None]: Pump electrical power
</li>
<li>
<code>reaCO2RooAir_y</code> [ppm] [min=None, max=None]: CO2 concentration in the zone
</li>
<li>
<code>reaTRoo_y</code> [K] [min=None, max=None]: Operative zone temperature
</li>
<li>
<code>weaSta_reaWeaPAtm_y</code> [Pa] [min=None, max=None]: Atmospheric pressure measurement
</li>
<li>
<code>weaSta_reaWeaHGloHor_y</code> [W/m2] [min=None, max=None]: Global horizontal solar irradiation measurement
</li>
<li>
<code>weaSta_reaWeaNOpa_y</code> [1] [min=None, max=None]: Opaque sky cover measurement
</li>
<li>
<code>weaSta_reaWeaTBlaSky_y</code> [K] [min=None, max=None]: Black-body sky temperature measurement
</li>
<li>
<code>weaSta_reaWeaNTot_y</code> [1] [min=None, max=None]: Sky cover measurement
</li>
<li>
<code>weaSta_reaWeaSolAlt_y</code> [rad] [min=None, max=None]: Solar altitude angle measurement
</li>
<li>
<code>weaSta_reaWeaSolZen_y</code> [rad] [min=None, max=None]: Solar zenith angle measurement
</li>
<li>
<code>weaSta_reaWeaHHorIR_y</code> [W/m2] [min=None, max=None]: Horizontal infrared irradiation measurement
</li>
<li>
<code>weaSta_reaWeaSolTim_y</code> [s] [min=None, max=None]: Solar time
</li>
<li>
<code>weaSta_reaWeaCloTim_y</code> [s] [min=None, max=None]: Day number with units of seconds
</li>
<li>
<code>weaSta_reaWeaLon_y</code> [rad] [min=None, max=None]: Longitude of the location
</li>
<li>
<code>weaSta_reaWeaRelHum_y</code> [1] [min=None, max=None]: Outside relative humidity measurement
</li>
<li>
<code>weaSta_reaWeaSolDec_y</code> [rad] [min=None, max=None]: Solar declination angle measurement
</li>
<li>
<code>weaSta_reaWeaHDirNor_y</code> [W/m2] [min=None, max=None]: Direct normal radiation measurement
</li>
<li>
<code>weaSta_reaWeaWinDir_y</code> [rad] [min=None, max=None]: Wind direction measurement
</li>
<li>
<code>weaSta_reaWeaTWetBul_y</code> [K] [min=None, max=None]: Wet bulb temperature measurement
</li>
<li>
<code>weaSta_reaWeaTDewPoi_y</code> [K] [min=None, max=None]: Dew point temperature measurement
</li>
<li>
<code>weaSta_reaWeaWinSpe_y</code> [m/s] [min=None, max=None]: Wind speed measurement
</li>
<li>
<code>weaSta_reaWeaHDifHor_y</code> [W/m2] [min=None, max=None]: Horizontal diffuse solar radiation measurement
</li>
<li>
<code>weaSta_reaWeaLat_y</code> [rad] [min=None, max=None]: Latitude of the location
</li>
<li>
<code>weaSta_reaWeaTDryBul_y</code> [K] [min=None, max=None]: Outside drybulb temperature measurement
</li>
<li>
<code>weaSta_reaWeaCeiHei_y</code> [m] [min=None, max=None]: Cloud cover ceiling height measurement
</li>
<li>
<code>weaSta_reaWeaSolHouAng_y</code> [rad] [min=None, max=None]: Solar hour angle measurement
</li>
</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>No lighting model is included. </p>
<h4>Shading</h4>
<p>
No shading model is included.
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
The model uses moist air despite that no condensation is modelled in any of the used components. 
</p>
<h4>Pressure-flow models</h4>
<p>
A simple, single circulation loop is used to model the heating system. 
</p>
<h4>Infiltration models</h4>
<p>
Fixed air infiltration corresponding to an n50 value of 10
is modelled.
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
Start Time: Day 311.
</ul>
<ul>
End Time: Day 325.
</ul>
</p>
<p>
The <b>Typical Heat Day</b> (specifier for <code>/scenario</code> API is <code>'typical_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with 
the maximum 15-minute system heating load that is closest from below to the
median of all 15-minute maximum heating loads of all days in the year.
</ul>
<ul>
Start Time: Day 334.
</ul>
<ul>
End Time: Day 348.
</ul>
</p>
<h4>Energy Pricing</h4>
<p>
All pricing scenarios include the same constant value for transmission fees and taxes
of each commodity. The used value is the typical price that household users pay 
for the network, taxes and levies, as calculateed by Eurostat and obtained from: 
<a href=\"https://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=CELEX:52020DC0951&from=EN\">
\"The energy prices and costs in Europe report\"</a>.
For the assumed location of the test case, this value is of
0.20 EUR/kWh for electricity and of 0.03 EUR/kWh for gas. 
</p>
<p>
The <b>Constant Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'constant'</code>) profile is:
<ul>
The constant electricity price scenario uses a constant price of 0.0535 EUR/kWh,
as obtained from the \"Easy Indexed\" deal for electricity (normal rate) in 
<a href=\"https://www.energyprice.be/products-list/Engie\">
https://www.energyprice.be/products-list/Engie</a> 
(accessed on June 2020). 
Adding up the transmission fees and taxes, the final constant electricity price is
of 0.2535 EUR/kWh. 
</ul>
</p>
<p>
The <b>Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'dynamic'</code>) profile is:
<ul>
The dynamic electricity price scenario uses a dual rate of 0.0666 EUR/kWh during 
day time and 0.0383 EUR/kWh during night time,
as obtained from the \"Easy Indexed\" deal for electricity (dual rate) in 
<a href=\"https://www.energyprice.be/products-list/Engie\">
https://www.energyprice.be/products-list/Engie</a> 
(accessed on June 2020). 
The on-peak daily period takes place between 7:00 a.m. and 10:00 p.m.
The off-peak daily period takes place between 10:00 p.m. and 7:00 a.m. 
Adding up the transmission fees and taxes, the final dynamic electricity prices are
of 0.2666 EUR/kWh during on-peak periods and of 0.2383 during off-peak periods. 
</ul>
</p>
<p>
The <b>Highly Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'highly_dynamic'</code>) profile is:
<ul>
The highly dynamic electricity price scenario is based on the the
Belgian day-ahead energy prices as determined by the BELPEX wholescale electricity 
market in the year 2019.
Obtained from:
<a href=\"https://my.elexys.be/MarketInformation/SpotBelpex.aspx\">
https://my.elexys.be/MarketInformation/SpotBelpex.aspx</a> 
Notice that the same constant transmission fees and taxes of 0.20 EUR/kWh are 
added up on top of these prices. 
</ul>
</p>
The <b>Gas Price</b> profile is:
<p>
<ul>
The gas price is assumed constant and of 0.0198 EUR/kWh 
as obtained from the \"Easy Indexed\" deal for gas
<a href=\"https://www.energyprice.be/products-list/Engie\">
https://www.energyprice.be/products-list/Engie</a> 
(accessed on June 2020). 
Adding up the transmission fees and taxes, the final constant gas price is
of 0.0498 EUR/kWh. 
</ul>
</p>
<h4>Emission Factors</h4>
<p>
The <b>Electricity Emissions Factor</b> profile is:
<ul>
It is used a constant emission factor for electricity of 0.167 kgCO2/kWh 
which is the grid electricity emission factor reported by the Association of Issuing Bodies (AIB)
for year 2018. For reference, see:
 <a href=\"https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf\">
https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf</a> 
</ul>
</p>
<p>
The <b>Gas Emissions Factor</b> profile is:
<ul>
Based on the kgCO2 emitted per amount of natural gas burned in terms of 
energy content.  It is 0.18108 kgCO2/kWh (53.07 kgCO2/milBTU).
For reference,
see:
<a href=\"https://www.eia.gov/environment/emissions/co2_vol_mass.php\">
https://www.eia.gov/environment/emissions/co2_vol_mass.php</a> 
</ul>
</p>
</html>", revisions="<html>
<ul>
<li>
October 30, 2024, by Lucas Verleyen:<br/>
Updates according to <a href=\\\"https://github.com/ibpsa/modelica-ibpsa/tree/8ed71caee72b911a1d9b5a76e6cb7ed809875e1e\\\">IBPSA</a>.<br/>
See <a href=\\\"https://github.com/open-ideas/IDEAS/pull/1383\\\">#1383</a> 
(and <a href=\\\"https://github.com/ibpsa/modelica-ibpsa/issues/1926\\\">IBPSA, #1926</a>).
</li>
<li>
October 18, 2024, by Ettore Zanetti:<br/>
Update <code>min</code> and <code>max</code> for ovewrite blocks <code>oveTSetHea_u</code> and <code>oveTSetCoo_u</code>.
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/658>
BOPTEST issue #658</a>.
</li>
<li>
October 18, 2024, by Ettore Zanetti:<br/>
Add <code>activate</code> inputs to documentation.
This is for
<a href=\"https://github.com/ibpsa/project1-boptest/issues/625\">BOPTEST issue #625</a>. 
</li>
<li>
October 18, 2024, by Ettore Zanetti:<br/>
Changed IDEAS dependency from extending <code>IDEAS.Examples.IBPSA.SingleZoneResidentialHydronic</code>
to duplicating the model.
This is for
<a href=\"https://github.com/ibpsa/project1-boptest/issues/680\">BOPTEST issue #680</a>. 
</li>
<li>
December 2, 2021, by David Blum:<br/>
Remove read blocks for control signals.
This is for
<a href=\"https://github.com/ibpsa/project1-boptest/issues/364\">BOPTEST issue #364</a>. 
</li>
<li>
June 23, 2021, by David Blum:<br/>
Add schematics to documentation and move heating set point offset to 
before overwrite block.
This is for
<a href=\"https://github.com/open-ideas/IDEAS/issues/1220\">#1220</a>. 
</li>
<li>
April 22, 2021, by Javier Arroyo:<br/>
Add time period documentation.
</li>
<li>
April 2, 2021 by Javier Arroyo<br/>
Add CO2 to air medium. 
</li>
<li>
February 22, 2021 by Javier Arroyo<br/>
Add transmission fees and taxes to pricing scenarios. 
</li>
<li>
December 1, 2020 by David Blum:<br/>
Added weather station. 
</li>
<li>
June 12, 2020 by Javier Arroyo:<br/>
Implemented PI controller for boiler supply temperature. 
</li>
<li>
June 2, 2020 by Javier Arroyo:<br/>
Implemented temperature setpoint setback. 
</li>
<li>
March 21, 2019 by Filip Jorissen:<br/>
Revised implementation based on first review for 
<a href=\"https://github.com/open-ideas/IDEAS/issues/996\">#996</a>. 
</li>
<li>
January 22nd, 2019 by Filip Jorissen:<br/>
Revised implementation by adding external inputs. 
</li>
<li>
May 2, 2018 by Filip Jorissen:<br/>
First implementation. 
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-180,-100},{100,100}},
          preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end TestCase;
