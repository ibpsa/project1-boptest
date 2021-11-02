﻿within MultiZoneOfficeSimpleAir.TestCases;
model TestCase
  "Variable air volume flow system with terminal reheat and five thermal zones based on Buildings.Examples.VAVReheat.ASHRAE2006"
  extends Modelica.Icons.Example;
  extends BaseClasses.HVACBuilding(
    MediumA(extraPropertiesNames={"CO2"}),
    mCor_flow_nominal=ACHCor*VRooCor*conv,
    mSou_flow_nominal=ACHSou*VRooSou*conv,
    mEas_flow_nominal=ACHEas*VRooEas*conv,
    mNor_flow_nominal=ACHNor*VRooNor*conv,
    mWes_flow_nominal=ACHWes*VRooWes*conv,
    redeclare BaseClasses.ASHRAE2006 hvac(
      amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
      /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumA.nC))),
    redeclare Buildings.Examples.VAVReheat.Validation.BaseClasses.Floor flo,
    boiCoi(descriptor="heating coil", m_flow_nominal=hvac.mHeaWat_flow_nominal),
    boiReh(descriptor="reheat", m_flow_nominal=hvac.cor.val.m_flow_nominal +
          hvac.sou.val.m_flow_nominal + hvac.eas.val.m_flow_nominal + hvac.nor.val.m_flow_nominal
           + hvac.wes.val.m_flow_nominal),
    chi(QEva_flow_min=-hvac.mCooWat_flow_nominal*4200*10));

  parameter Real ACHCor(final unit="1/h")=6
    "Design air change per hour core";
  parameter Real ACHSou(final unit="1/h")=6
    "Design air change per hour south";
  parameter Real ACHEas(final unit="1/h")=9
    "Design air change per hour east";
  parameter Real ACHNor(final unit="1/h")=6
    "Design air change per hour north";
  parameter Real ACHWes(final unit="1/h")=7
    "Design air change per hour west";

  Modelica.Blocks.Sources.RealExpression CO2Cor(y=flo.cor.air.vol.C[1])
    "Measure CO2 concentration in core zone"
    annotation (Placement(transformation(extent={{-100,28},{-80,48}})));
  Modelica.Blocks.Sources.RealExpression CO2Sou(y=flo.sou.air.vol.C[1])
    "Measure CO2 concentration in south zone"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Blocks.Sources.RealExpression CO2Eas(y=flo.eas.air.vol.C[1])
    "Measure CO2 concentration in East zone"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.RealExpression CO2Nor(y=flo.nor.air.vol.C[1])
    "Measure CO2 concentration in East zone"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.RealExpression CO2Wes(y=flo.wes.air.vol.C[1])
    "Measure CO2 concentration in West zone"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Routing.Multiplex5 multiplex5_1
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta
    "BOPTEST weather station"
    annotation (Placement(transformation(extent={{-70,-30},{-90,-10}})));
equation
  connect(CO2Cor.y, multiplex5_1.u5[1]) annotation (Line(points={{-79,38},{-76,38},
          {-76,40},{-42,40}}, color={0,0,127}));
  connect(CO2Sou.y, multiplex5_1.u1[1]) annotation (Line(points={{-79,80},{-70,80},
          {-70,60},{-42,60}}, color={0,0,127}));
  connect(CO2Eas.y, multiplex5_1.u2[1]) annotation (Line(points={{-79,70},{-72,70},
          {-72,55},{-42,55}}, color={0,0,127}));
  connect(CO2Nor.y, multiplex5_1.u3[1]) annotation (Line(points={{-79,60},{-74,60},
          {-74,50},{-42,50}}, color={0,0,127}));
  connect(CO2Wes.y, multiplex5_1.u4[1]) annotation (Line(points={{-79,50},{-76,50},
          {-76,45},{-42,45}}, color={0,0,127}));
  connect(multiplex5_1.y, hvac.CO2Roo) annotation (Line(points={{-19,50},{-10,50},
          {-10,34},{-56,34},{-56,22},{-48.75,22}}, color={0,0,127}));
  connect(weaSta.weaBus, chi.weaBus) annotation (Line(
      points={{-70.1,-20.1},{-66,-20.1},{-66,-68},{-10,-68},{-10,-80}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
This is the multi zone office air simple emulator model
of BOPTEST.  It is based on the Modelica model
<a href=\"https://simulationresearch.lbl.gov/modelica/releases/latest/help/Buildings_Examples_VAVReheat.html#Buildings.Examples.VAVReheat.ASHRAE2006\"><code>Buildings.Examples.VAVReheat.ASHRAE2006</code></a>.
with the addition of CO2 concentration tracking,
constant efficiency boiler model, variable efficiency chiller model,
and BOPTEST signal exchange blocks.
</p>
<h4>Architecture</h4>
<p>
The test case represents one floor with five zones of the new construction
medium office building for Chicago, IL, as described in the set of DOE
Commercial Building Benchmarks (Deru et al, 2009).
There are four perimeter zones and one core zone, with each perimeter zone
having a window-to-wall ratio of 0.33.  The height of each zone is 2.74 m
and the areas are as follows:
<ul>
<li>
North and South: 207.58 m<sup>2</sup>
</li>
<li>
East and West: 131.416 m<sup>2</sup>
</li>
<li>
Core: 984.672 m<sup>2</sup>
</li>
</ul>
</p>
<p>
Deru M., K. Field, D. Studer, K. Benne, B. Griffith, P. Torcellini,
 M. Halverson, D. Winiarski, B. Liu, M. Rosenberg, J. Huang, M. Yazdanian, and D. Crawley.
<i>DOE commercial building research benchmarks for commercial buildings</i>.
Technical report, U.S. Department of Energy, Energy Efficiency and
Renewable Energy, Office of Building Technologies, Washington, DC, 2009.
</p>
<h4>Constructions</h4>
<p>
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
</p>
<h4>Occupancy schedules</h4>
<p>
The design occupancy density is 0.05 people/m<sup>2</sup>.  The number of occupants
present in each zone at any time coincides with the internal gain schedule
defined in the next section.
The occupied time for the HVAC system is between 6 AM and 7 PM each day.  The
unoccupied time is outside of this period.
</p>
<h4>Internal loads and schedules</h4>
<p>
The design internal gains including lighting, plug loads, and people
are combined 20 W/m<sup>2</sup> with a radiant-convective-latent split of 40%-40%-20%.
The internal gains are activated according to the schedule in the figure below.
</p>
<p align=\"center\">
<img alt=\"Internal gains schedule.\"
src=\"../../../doc/images/InternalGainsSchedule.png\" width=600 />
</p>
<h4>Climate data</h4>
<p>
The weather data is from TMY3 for Chicago O'Hare International Airport.
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
The HVAC system is a multi-zone single-duct Variable Air Volume (VAV) system
with pressure-independent terminal boxes with reheat.
A schematic of the system is shown in the
figure below.  The cooling and heating coils are water-based.
Only the air distribution system is included, while the central plant is
ideally modeled using water sources with prescribed temperatures and constant
plant equipment efficiencies. The available sensor and control points, marked
on the figure below and described in more detail in the Section Model IO's,
are those specified as required by ASHRAE Guideline 36 2018
Section 4 List of Hardwired Points, specifically
Table 4.2 VAV Terminal Unit with Reheat and Table 4.6 Multiplie-Zone VAV Air
Handling Unit, as well as many that are specified as
application specific or optional.
</p>
<p align=\"center\">
<img alt=\"Schematic of HVAC system.\"
src=\"../../../doc/images/Schematic.png\"/>
</p>
<h4>Equipment specifications and performance maps</h4>
<p>
The terminal box dampers have exponential opening characteristics with design
airflow rates defined in the table below.  The design system airflow rate includes
a 0.7 load diversity factor and is defined in the table below.

The minimum outside airflow for each zone is calculated using outside
airflow rates of 0.3e-3 m<sup>3</sup>/s-m<sup>2</sup> and 2.5e-3 m<sup>3</sup>/s-person.  The limiting
zone air distribution effectiveness is 0.8 and the occupant diversity
ratio is 0.7.  This leads to the minimum outside airflow rates for each zone
and system defined in the table below.
</p>
<p>
<b>Table 1: Zone and System Specifications Summary</b>
<table>
  <tr>
  <th>Name</th>
  <th>Design Airflow [m<sup>3</sup>/s]</th>
  <th>Min OA Airflow [m<sup>3</sup>/s]</th>
  </tr>
  <tr>
  <td>North</td>
  <td>0.947948667</td>
  <td>0.1102769</td>
  </tr>
  <tr>
  <td>South</td>
  <td>0.947948667</td>
  <td>0.1102769</td>
  </tr>
  <tr>
  <td>East</td>
  <td>0.9001996</td>
  <td>0.0698148</td>
  </tr>
  <tr>
  <td>west</td>
  <td>0.700155244</td>
  <td>0.0698148</td>
  </tr>
  <tr>
  <td>Core</td>
  <td>4.4966688</td>
  <td>0.5231070</td>
  </tr>
  <tr>
  <td>System</td>
  <td>5.595044684</td>
  <td>0.8590431</td>
  </tr>
</table>
</p>

<p>
The supply fan hydraulic efficiency is constant at 0.7 and the motor
efficiency is constant at 0.7.  The cooling coil is served by a heat pump
with constant COP of 3.2 and the heating coils are served by a heat pump
with constant COP of 4.0.
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
The baseline control emulates a typical scheme seen in practice and is based on
the ASHRAE VAV 2A2-21232 of the Sequences of Operation for Common HVAC Systems 2006
as well as that which is implemented as baseline control in the Modelica Buildings
Library model
<a href=\"https://simulationresearch.lbl.gov/modelica/releases/latest/help/Buildings_Examples_VAVReheat.html#Buildings.Examples.VAVReheat.ASHRAE2006\"><code>Buildings.Examples.VAVReheat.ASHRAE2006</code></a>.
Setpoints and equipment enable/disable are determined by a schedule-based supervisory control
scheme that defines a set of operating modes.  This scheme is summarized in
Table 2 below.
</p>
<p>
<b>Table 2: HVAC Operating Mode Summary</b>
<table>
  <tr>
  <th>Name</th>
  <th>Condition </th>
  <th>TZonHeaSet [degC]</th>
  <th>TZonCooSet [degC]</th>
  <th>Fan [degC]</th>
  <th>TSupSet [degC]</th>
  <th>Economizer</th>
  <th>Min OA Flow</th>
  </tr>
  <tr>
  <td>Occupied</td>
  <td>In occupied period</td>
  <td>20</td>
  <td>24</td>
  <td>Enabled</td>
  <td>12</td>
  <td>Enabled</td>
  <td>Ventilation</td>
  </tr>
  <tr>
  <td>Unoccupied off</td>
  <td>In unoccupied period, all TZon within setback deadband</td>
  <td>12</td>
  <td>30</td>
  <td>Disabled</td>
  <td>12</td>
  <td>Disabled</td>
  <td>Zero</td>
  </tr>
  <tr>
  <td>Unoccupied, night setback</td>
  <td>In unoccupied period, minimum TZon below unoccupied TZonHeaSet</td>
  <td>12</td>
  <td>30</td>
  <td>Enabled</td>
  <td>35</td>
  <td>Disabled</td>
  <td>Zero</td>
  </tr>
  <tr>
  <td>Unoccupied, warm-up</td>
  <td>In unoccupied period, within 30 minutes of occupied period, average TZon below occupied TZonHeaSet</td>
  <td>20</td>
  <td>30</td>
  <td>Enabled</td>
  <td>35</td>
  <td>Disabled</td>
  <td>Zero</td>
  </tr>
  <tr>
  <td>Unoccupied, pre-cool</td>
  <td>In unoccupied period, within 30 minutes of occupied period, outside TDryBul below limit of 13 degC, average TZon above occupied TZonCooSet</td>
  <td>12</td>
  <td>24</td>
  <td>Enabled</td>
  <td>12</td>
  <td>Enabled</td>
  <td>Zero</td>
  </tr>
</table>
</p>
<p>
Once the operating mode is determined, a number of low-level, local-loop
controllers are used to maintain the desired setpoints using the available
actuators.  The primary local-loop controllers are specified on the diagram above
as C1 to C3.
</p>
<p>
C1 is responsible for maintaining the zone temperature setpoints as
determined by the operating mode of the system and implements
dual-maximum logic, as shown in the Figure below.  It takes
as inputs the zone temperature heating and cooling setpoints and zone temperature
measurement, and outputs the desired airflow rate of the damper and position
of the reheat valve.  Seperate PI controllers are used for control of the
damper airflow for cooling and reheat valve position for heating.  If the
zone requires heating, the desired airflow rate of the damper is mapped
to the specified maximum value for heating.
</p>

<p align=\"center\">
<img alt=\"Controller C1.\"
src=\"../../../doc/images/C1.png\"/>
</p>

<p>
C2 is responsible for maintaining the duct static pressure setpoint
and implements a duct static pressure reset strategy.  The first step of
the controller takes as input all of the terminal box damper positions and
outputs a duct static pressure setpoint using a PI controller such that the
maximum damper position is maintained at 0.9.  The second step then maintains
this setpoint using a PI controller and measured duct static pressure as input
to output a fan speed setpoint.
</p>

<p align=\"center\">
<img alt=\"Controller C2.\"
src=\"../../../doc/images/C2.png\"/>
</p>

<p>
C3 is responsible for maintaining the supply air temperature setpoint as well
as the minimum outside air flow rate as determined by the operating mode
of the system.  It takes as inputs the
supply air temperature setpoint, supply air temperature measurement, outside
airflow rate setpoint, outside airflow rate measurement, and outside
drybulb temperature measurement.  The first part
of the controller uses a PI controller for supply air temperature setpoint
tracking to output a signal that is then mapped to position
setpoints for the heating coil valve, cooling coil valve, and outside air
damper position.  The second part of the controller uses a PI controller
for outside airflow setpoint tracking to output a second signal for
outside air damper position.  The maximum of the two outside air damper position
signals is finally output to ensure at least enough enough airflow is delivered
for ventilation when needed.  The economizer is enabled only if the outside
drybulb temperature is lower than the return air temperature.
</p>

<p align=\"center\">
<img alt=\"Controller C3.\"
src=\"../../../doc/images/C3.png\"/>
</p>

<p>
Also present, but not depicted in the diagrams above, is a freeze stat controller.
This controller detects potentially freezing conditions by measuring the
mixed air temperature and determining if it is less than a limit, 3 degC.
If true, the controller will enable C3 to track the supply air temperature setpoint.
In this case, the heating coil will be activated to do so.
</p>

<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>oveAhu_TSupSet_u</code> [K] [min=285.15, max=313.15]: Supply air temperature setpoint for AHU
</li>
<li>
<code>oveAhu_dpSet_u</code> [Pa] [min=50.0, max=410.0]: Supply duct pressure setpoint for AHU
</li>
<li>
<code>oveAhu_yCoo_u</code> [1] [min=0.0, max=1.0]: Cooling coil control signal for AHU
</li>
<li>
<code>oveAhu_yFan_u</code> [1] [min=0.0, max=1.0]: Supply fan speed setpoint for AHU
</li>
<li>
<code>oveAhu_yHea_u</code> [1] [min=0.0, max=1.0]: Heating coil control signal for AHU
</li>
<li>
<code>oveAhu_yOA_u</code> [1] [min=0.0, max=1.0]: Outside air damper position setpoint for AHU
</li>
<li>
<code>oveAhu_yRet_u</code> [1] [min=0.0, max=1.0]: Return air damper position setpoint for AHU
</li>
<li>
<code>oveCorLoc_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone Core
</li>
<li>
<code>oveCorLoc_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone Core
</li>
<li>
<code>oveCorSup_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone Core
</li>
<li>
<code>oveCorSup_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone Core
</li>
<li>
<code>oveEasLoc_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone East
</li>
<li>
<code>oveEasLoc_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone East
</li>
<li>
<code>oveEasSup_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone East
</li>
<li>
<code>oveEasSup_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone East
</li>
<li>
<code>oveNorLoc_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone North
</li>
<li>
<code>oveNorLoc_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone North
</li>
<li>
<code>oveNorSup_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone North
</li>
<li>
<code>oveNorSup_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone North
</li>
<li>
<code>oveSouLoc_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone South
</li>
<li>
<code>oveSouLoc_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone South
</li>
<li>
<code>oveSouSup_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone South
</li>
<li>
<code>oveSouSup_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone South
</li>
<li>
<code>oveWesLoc_yDam_u</code> [1] [min=0.0, max=1.0]: Damper position setpoint for zone West
</li>
<li>
<code>oveWesLoc_yReaHea_u</code> [1] [min=0.0, max=1.0]: Reheat control signal for zone West
</li>
<li>
<code>oveWesSup_TZonCooSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature cooling setpoint for zone West
</li>
<li>
<code>oveWesSup_TZonHeaSet_u</code> [K] [min=285.15, max=313.15]: Zone air temperature heating setpoint for zone West
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>reaAhu_PCoo_y</code> [W] [min=None, max=None]: Electrical power measurement of cooling for AHU
</li>
<li>
<code>reaAhu_PFanSup_y</code> [W] [min=None, max=None]: Electrical power measurement of supply fan for AHU
</li>
<li>
<code>reaAhu_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for heating coil for AHU
</li>
<li>
<code>reaAhu_TMix_y</code> [K] [min=None, max=None]: Mixed air temperature measurement for AHU
</li>
<li>
<code>reaAhu_TRet_y</code> [K] [min=None, max=None]: Return air temperature measurement for AHU
</li>
<li>
<code>reaAhu_TSup_y</code> [K] [min=None, max=None]: Supply air temperature measurement for AHU
</li>
<li>
<code>reaAhu_V_flow_out_y</code> [m3/s] [min=None, max=None]: Outside air flowrate measurement for AHU
</li>
<li>
<code>reaAhu_V_flow_ret_y</code> [m3/s] [min=None, max=None]: Return air flowrate measurement for AHU
</li>
<li>
<code>reaAhu_V_flow_sup_y</code> [m3/s] [min=None, max=None]: Supply air flowrate measurement for AHU
</li>
<li>
<code>reaAhu_dp_sup_y</code> [Pa] [min=None, max=None]: Discharge pressure of supply fan for AHU
</li>
<li>
<code>reaAhu_yCooAct_y</code> [1] [min=None, max=None]: Cooling coil control signal feedback for AHU
</li>
<li>
<code>reaAhu_yFanAct_y</code> [1] [min=None, max=None]: Supply fan speed set point feedback for AHU
</li>
<li>
<code>reaAhu_yHeaAct_y</code> [1] [min=None, max=None]: Heating coil control signal feedback for AHU
</li>
<li>
<code>reaAhu_yOA_y</code> [1] [min=None, max=None]: Outside air damper position set point feedback for AHU
</li>
<li>
<code>reaAhu_yRelAct_y</code> [1] [min=None, max=None]: Relief air damper position set point feedback for AHU
</li>
<li>
<code>reaAhu_yRetAct_y</code> [1] [min=None, max=None]: Return air damper position set point feedback for AHU
</li>
<li>
<code>reaCor_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone Core
</li>
<li>
<code>reaCor_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone Core
</li>
<li>
<code>reaCor_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone Core
</li>
<li>
<code>reaCor_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone Core
</li>
<li>
<code>reaCor_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone Core
</li>
<li>
<code>reaCor_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone Core
</li>
<li>
<code>reaCor_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone Core
</li>
<li>
<code>reaEas_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone East
</li>
<li>
<code>reaEas_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone East
</li>
<li>
<code>reaEas_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone East
</li>
<li>
<code>reaEas_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone East
</li>
<li>
<code>reaEas_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone East
</li>
<li>
<code>reaEas_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone East
</li>
<li>
<code>reaEas_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone East
</li>
<li>
<code>reaNor_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone North
</li>
<li>
<code>reaNor_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone North
</li>
<li>
<code>reaNor_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone North
</li>
<li>
<code>reaNor_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone North
</li>
<li>
<code>reaNor_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone North
</li>
<li>
<code>reaNor_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone North
</li>
<li>
<code>reaNor_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone North
</li>
<li>
<code>reaSou_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone South
</li>
<li>
<code>reaSou_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone South
</li>
<li>
<code>reaSou_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone South
</li>
<li>
<code>reaSou_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone South
</li>
<li>
<code>reaSou_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone South
</li>
<li>
<code>reaSou_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone South
</li>
<li>
<code>reaSou_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone South
</li>
<li>
<code>reaWes_CO2Zon_y</code> [ppm] [min=None, max=None]: Zone air CO2 measurement for zone West
</li>
<li>
<code>reaWes_PHea_y</code> [W] [min=None, max=None]: Electrical power consumption for reheat for zone West
</li>
<li>
<code>reaWes_TSup_y</code> [K] [min=None, max=None]: Discharge air temperature to zone measurement for zone West
</li>
<li>
<code>reaWes_TZon_y</code> [K] [min=None, max=None]: Zone air temperature measurement for zone West
</li>
<li>
<code>reaWes_V_flow_y</code> [m3/s] [min=None, max=None]: Discharge air flowrate to zone measurement for zone West
</li>
<li>
<code>reaWes_yDamAct_y</code> [1] [min=None, max=None]: Damper position set point feedback for zone West
</li>
<li>
<code>reaWes_yReaHeaAct_y</code> [1] [min=None, max=None]: Reheat control signal set point feedback for zone West
</li>
<li>
<code>weaSta_reaWeaCeiHei_y</code> [m] [min=None, max=None]: Cloud cover ceiling height measurement
</li>
<li>
<code>weaSta_reaWeaCloTim_y</code> [s] [min=None, max=None]: Day number with units of seconds
</li>
<li>
<code>weaSta_reaWeaHDifHor_y</code> [W/m2] [min=None, max=None]: Horizontal diffuse solar radiation measurement
</li>
<li>
<code>weaSta_reaWeaHDirNor_y</code> [W/m2] [min=None, max=None]: Direct normal radiation measurement
</li>
<li>
<code>weaSta_reaWeaHGloHor_y</code> [W/m2] [min=None, max=None]: Global horizontal solar irradiation measurement
</li>
<li>
<code>weaSta_reaWeaHHorIR_y</code> [W/m2] [min=None, max=None]: Horizontal infrared irradiation measurement
</li>
<li>
<code>weaSta_reaWeaLat_y</code> [rad] [min=None, max=None]: Latitude of the location
</li>
<li>
<code>weaSta_reaWeaLon_y</code> [rad] [min=None, max=None]: Longitude of the location
</li>
<li>
<code>weaSta_reaWeaNOpa_y</code> [1] [min=None, max=None]: Opaque sky cover measurement
</li>
<li>
<code>weaSta_reaWeaNTot_y</code> [1] [min=None, max=None]: Sky cover measurement
</li>
<li>
<code>weaSta_reaWeaPAtm_y</code> [Pa] [min=None, max=None]: Atmospheric pressure measurement
</li>
<li>
<code>weaSta_reaWeaRelHum_y</code> [1] [min=None, max=None]: Outside relative humidity measurement
</li>
<li>
<code>weaSta_reaWeaSolAlt_y</code> [rad] [min=None, max=None]: Solar altitude angle measurement
</li>
<li>
<code>weaSta_reaWeaSolDec_y</code> [rad] [min=None, max=None]: Solar declination angle measurement
</li>
<li>
<code>weaSta_reaWeaSolHouAng_y</code> [rad] [min=None, max=None]: Solar hour angle measurement
</li>
<li>
<code>weaSta_reaWeaSolTim_y</code> [s] [min=None, max=None]: Solar time
</li>
<li>
<code>weaSta_reaWeaSolZen_y</code> [rad] [min=None, max=None]: Solar zenith angle measurement
</li>
<li>
<code>weaSta_reaWeaTBlaSky_y</code> [K] [min=None, max=None]: Black-body sky temperature measurement
</li>
<li>
<code>weaSta_reaWeaTDewPoi_y</code> [K] [min=None, max=None]: Dew point temperature measurement
</li>
<li>
<code>weaSta_reaWeaTDryBul_y</code> [K] [min=None, max=None]: Outside drybulb temperature measurement
</li>
<li>
<code>weaSta_reaWeaTWetBul_y</code> [K] [min=None, max=None]: Wet bulb temperature measurement
</li>
<li>
<code>weaSta_reaWeaWinDir_y</code> [rad] [min=None, max=None]: Wind direction measurement
</li>
<li>
<code>weaSta_reaWeaWinSpe_y</code> [m/s] [min=None, max=None]: Wind speed measurement
</li>
</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
Lighting heat gain is included in the internal heat gains and is not controllable.
</p>
<h4>Shading</h4>
<p>
There is no shading on this building.
</p>
<h4>Onsite Generation and Storage</h4>
<p>
There is no onsite generation or storage on this building site.
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
A moist air model is used.  Relative humidity is tracked based on latent
heat gain from occupants, outside air relative humidity, and a cooling
coil model that includes condensation.
</p>
<h4>Pressure-flow models</h4>
<p>
The duct airflow is modeled using a pressure-flow network.
</p>
<h4>Infiltration models</h4>
<p>
Airflow due to infiltration is calculated based on time-varying
wind pressure coefficients for each facade using
<a href=\"https://simulationresearch.lbl.gov/modelica/releases/latest/help/Buildings_Fluid_Sources.html#Buildings.Fluid.Sources.Outside_CpLowRise\"><code>Buildings.Fluid.Sources.Outside_CpLowRise</code></a>.
</p>
<h4>CO2 models</h4>
<p>
CO2 generation is 0.0048 L/s per person (Table 5, Persily and De Jonge 2017)
and density of CO2 assumed to be 1.8 kg/m<sup>3</sup>,
making CO2 generation 8.64e-6 kg/s per person.
Outside air CO2 concentration is 400 ppm.
</p>
<p>
Persily, A. and De Jonge, L. (2017).
Carbon dioxide generation rates for building occupants.
Indoor Air, 27, 868–879.  https://doi.org/10.1111/ina.12383.
</p>
<h3>Scenario Information</h3>
<h4>Energy Pricing</h4>
<p>
Constant electricity prices are based on those from ComEd [1], the utility serving
the greater Chicago area.  The price is based on the Basic Electricity Service (BES)
rate provided to the Watt-Hour customer class for applicable charges per kWh.
This calculation is an approximation to obtain a reasonable estimate of price.
The charges included are as follows:
</p>
<ul>
<li>
PJM Services Charge: $0.01211
</li>
<li>
Retail Purchased Electricity Charge: $0.05158
</li>
<li>
Delivery Services Charge:
i) Distribution Facilities Charge: $0.01935
ii) Illinois Electricity Distribution Tax Charge: $0.00121
</li>
<li>
Rider ECR - Environmental Cost Recovery Adjustment: $0.00031
</li>
<li>
Rider EEPP - Energy Efficiency Pricing and Performance: $0.0026
</li>
<li>
Rider REA - Renewable Energy Adjustment: $0.00189
</li>
<li>
Rider TAX - Municipal and State Tax Additions: $0.003
</li>
<li>
Rider ZEA - Zero Emission Adjustment: $0.00195
</li>
</ul>

<p>
The total constant electricity price is $0.094/kWh
</p>
<p>
Dynamic electricity prices are based on those from ComEd [1], the utility serving
the greater Chicago area.  The price is based on the Residential Time of Use Pricing Pilot
(RTOUPP) rate for applicable charges per kWh.
This calculation is an approximation to obtain a reasonable estimate of dynamic
price.  The charges included are the same as the constant scenario (using BES)
except for the following change:

<li>
Retail Purchased Electricity Charge:
<p>
Summer (Jun, Jul, Aug, Sep):
<ul>
<li>
i) Super Peak Period: $0.12727, 2pm-7pm
</li>
<li>
ii) Peak Period: $0.02868, 6am-2pm and 7pm-10pm
</li>
<li>
iii) Off Peak Period: $0.01584, 10pm-6am
</li>
</ul>
Winter:
<ul>
<li>
i) Super Peak Period: $0.11748, 2pm-7pm
</li>
<li>
ii) Peak Period: $0.02664, 6am-2pm and 7pm-10pm
</li>
<li>
iii) Off Peak Period: $0.01629, 10pm-6am
</li>
</ul>
</p>
</li>
</p>
<p>
Highly Dynamic electricity prices are based on those from ComEd [1], the utility serving
the greater Chicago area.  The price is based on the Basic Electric Service Hourly Pricing
(BESH) rate for applicable charges per kWh.
This calculation is an approximation to obtain a reasonable estimate of
highly dynamic price.  The charges included are the same as the constant
scenario (using BES) except for the following change:

<li>
PJM Services Charge: $0.00836
</li>
<li>
Retail Purchased Electricity Charge: Based on Wholesale Day-Ahead Prices
for the year of 2019 based on [2].
</li>
</p>

<p>
References:
<li>
[1] https://www.comed.com/MyAccount/MyBillUsage/Pages/CurrentRatesTariffs.aspx
</li>
<li>
[2] https://secure.comed.com/MyAccount/MyBillUsage/Pages/RatesPricing.aspx
</li>
</p>
<h4>Emission Factors</h4>
<p>
The Electricity Emissions Factor profile is based on the average annual emissions
from 2019 for the state of Illinois, USA per the EIA.
It is 752 lbs/MWh or 0.341 kgCO2/kWh.
For reference, see https://www.eia.gov/electricity/state/illinois/
</p>
<p>
The Gas Emissions Factor profile is based on the kgCO2 emitted per amount of
natural gas burned in terms of energy content.
It is 0.18108 kgCO2/kWh (53.07 kgCO2/milBTU).
For reference, see https://www.eia.gov/environment/emissions/co2_vol_mass.php.
</p>
</html>", revisions="<html>
<ul>
<li>
October 4, 2021, by Michael Wetter:<br/>
Refactored <a href=\"modelica://Buildings.Examples.VAVReheat\">Buildings.Examples.VAVReheat</a>
and its base classes to separate building from HVAC model.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2652\">issue #2652</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed assignment of parameter <code>lat</code> as this is now obtained from the weather data reader.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
September 3, 2021, by Michael Wetter:<br/>
Updated documentation.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2600\">issue #2600</a>.
</li>
<li>
August 24, 2021, by Michael Wetter:<br/>
Changed model to include the hydraulic configurations of the cooling coil,
heating coil and VAV terminal box.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2594\">issue #2594</a>.
</li>
<li>
May 6, 2021, by David Blum:<br/>
Change to <code>from_dp=false</code> for exhaust air damper.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2485\">issue #2485</a>.
</li>
<li>
April 30, 2021, by Michael Wetter:<br/>
Reformulated replaceable class and introduced floor areas in base class
to avoid access of components that are not in the constraining type.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2471\">issue #2471</a>.
</li>
<li>
April 16, 2021, by Michael Wetter:<br/>
Refactored model to implement the economizer dampers directly in
<code>Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC</code> rather than through the
model of a mixing box. Since the version of the Guideline 36 model has no exhaust air damper,
this leads to simpler equations.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2454\">issue #2454</a>.
</li>
<li>
March 15, 2021, by David Blum:<br/>
Update documentation graphic to include relief damper.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2399\">#2399</a>.
</li>
<li>
October 27, 2020, by Antoine Gautier:<br/>
Refactored the supply air temperature control sequence.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2024\">#2024</a>.
</li>
<li>
July 10, 2020, by Antoine Gautier:<br/>
Changed design and control parameters for outdoor air flow.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2019\">#2019</a>.
</li>
<li>
April 20, 2020, by Jianjun Hu:<br/>
Exported actual VAV damper position as the measured input data for
defining duct static pressure setpoint.<br/>
This is
for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1873\">#1873</a>.
</li>
<li>
May 19, 2016, by Michael Wetter:<br/>
Changed chilled water supply temperature to <i>6&deg;C</i>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/509\">#509</a>.
</li>
<li>
April 26, 2016, by Michael Wetter:<br/>
Changed controller for freeze protection as the old implementation closed
the outdoor air damper during summer.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/511\">#511</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Set default temperature for medium to avoid conflicting
start values for alias variables of the temperature
of the building and the ambient air.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/ASHRAE2006.mos"
        "Simulate and plot"),
    experiment(
      StopTime=31536000,
      Interval=600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end TestCase;