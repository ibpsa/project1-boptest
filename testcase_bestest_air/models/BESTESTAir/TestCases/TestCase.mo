within BESTESTAir.TestCases;
model TestCase "Testcase model"
  extends Modelica.Icons.Example;
  BaseClasses.Case900FF zon
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,15 + 273.15; 8*3600,21 + 273.15; 18*3600,15 + 273.15; 24*3600,15
         + 273.15])
    "Heating temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,-52},{-80,-32}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetCoo(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,30 + 273.15; 8*3600,24 + 273.15; 18*3600,30 + 273.15; 24*3600,30
         + 273.15])
    "Cooling temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  BaseClasses.Thermostat con
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  BaseClasses.FanCoilUnit fcu(dpAir_nominal(displayUnit="Pa"))
    annotation (Placement(transformation(extent={{0,-14},{20,14}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSetHea(description=
        "Zone temperature setpoint for heating", u(
      max=273.15 + 23,
      unit="K",
      min=273.15 + 15)) "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(
      unit="K",
      min=273.15 + 23,
      max=273.15 + 30), description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTRooAir(
    description="Zone air temperature",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K")) "Read room air temperature"
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPCoo(
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    description="Cooling electrical power consumption")
    "Read power for cooling"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPHea(
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heating thermal power consumption") "Read power for heating"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPFan(
    y(unit="W"),
    description="Supply fan electrical power consumption",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
    "Read power for supply fan"
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
equation
  connect(con.yFan, fcu.yFan) annotation (Line(points={{-29,-2},{-26,-2},{-26,
          -6},{-2,-6}},
                     color={0,0,127}));
  connect(fcu.supplyAir, zon.supplyAir)
    annotation (Line(points={{20,6},{44,6},{44,2},{54,2}}, color={0,127,255}));
  connect(zon.returnAir, fcu.returnAir) annotation (Line(points={{54,-2},{44,-2},
          {44,-10},{20,-10}}, color={0,127,255}));
  connect(con.TSupSet, fcu.TSupSet) annotation (Line(points={{-29,2},{-26,2},{
          -26,6},{-2,6}}, color={0,0,127}));
  connect(TSetHea.y[1], oveTSetHea.u) annotation (Line(points={{-79,-42},{-76,
          -42},{-76,-50},{-72,-50}}, color={0,0,127}));
  connect(oveTSetHea.y, con.TSetHea) annotation (Line(points={{-49,-50},{-40,
          -50},{-40,-32},{-70,-32},{-70,4},{-52,4}}, color={0,0,127}));
  connect(TSetCoo.y[1], oveTSetCoo.u) annotation (Line(points={{-79,30},{-76,30},
          {-76,40},{-72,40}}, color={0,0,127}));
  connect(oveTSetCoo.y, con.TSetCoo) annotation (Line(points={{-49,40},{-40,40},
          {-40,20},{-70,20},{-70,8},{-52,8}}, color={0,0,127}));
  connect(zon.TRooAir, reaTRooAir.u) annotation (Line(points={{81,0},{100,0},{
          100,-30},{82,-30}}, color={0,0,127}));
  connect(reaTRooAir.y, con.TZon) annotation (Line(points={{59,-30},{-60,-30},{
          -60,0},{-52,0}}, color={0,0,127}));
  connect(fcu.PCoo, reaPCoo.u) annotation (Line(points={{21,14},{32,14},{32,80},
          {58,80}}, color={0,0,127}));
  connect(fcu.PHea, reaPHea.u) annotation (Line(points={{21,12},{36,12},{36,60},
          {58,60}}, color={0,0,127}));
  connect(reaPFan.u, fcu.PFan) annotation (Line(points={{58,40},{40,40},{40,10},
          {21,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=599.999616,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
Documentation(info="<html>
General model description.
<h3>Building Design and Use</h3>
<h4>Architecture</h4>
<p>
The building is a single room based on the BESTEST Case 900 model definition.
The floor dimensions are 6m x 8m and the floor-to-ceiling height is 2.7m.  
There are four exterior walls facing the cardinal directions and a flat roof.
The walls facing east-west have the short dimension.  The south wall contains
two windows, each 3m wide and 2m tall.  The use of the building is assumed
to be a two-person office with a light load density.
</p>
<h4>Constructions</h4>
<p>
The constructions are based on the BESTEST Case 900 model definition.  The
exterior walls are made of concrete block and insulation, while the floor
is a concrete slab.  The roof is made of wood frame with insulation.  The 
layer-by-layer specifications are (Outside to Inside):
</p>
<p>
<b>Exterior Walls</b>
<table>
  <tr>
  <th>Name</th>
  <th>Thickness [m]</th>
  <th>Thermal Conductivity [W/m-K]</th>
  <th>Specific Heat Capacity [J/kg-K]</th>
  <th>Density [kg/m3]</th>
  </tr>
  <tr>
  <td>Layer 1</td>
  <td>0.009</td>
  <td>0.140</td>
  <td>900</td>
  <td>530</td>
  </tr>
  <tr>
  <td>Layer 2</td>
  <td>0.0615</td>
  <td>0.040</td>
  <td>1400</td>
  <td>10</td>
  </tr>
  <tr>
  <td>Layer 3</td>
  <td>0.100</td>
  <td>0.510</td>
  <td>1000</td>
  <td>1400</td>
  </tr>
  </table>
<table>
  <tr>
  <th>Name</th>
  <th>IR Emissivity [-]</th>
  <th>Solar Emissivity [-]</th>
  </tr>
  <tr>
  <td>Outside</td>
  <td>0.9</td>
  <td>0.6</td>
  </tr>
  <tr>
  <td>Inside</td>
  <td>0.9</td>
  <td>0.6</td>
  </tr>
</table>
</p>
<p>
<b>Floor</b>
<table>
  <tr>
  <th>Name</th>
  <th>Thickness [m]</th>
  <th>Thermal Conductivity [W/m-K]</th>
  <th>Specific Heat Capacity [J/kg-K]</th>
  <th>Density [kg/m3]</th>
  </tr>
  <tr>
  <td>Layer 1</td>
  <td>1.007</td>
  <td>0.040</td>
  <td>0</td>
  <td>0</td>
  </tr>
  <tr>
  <td>Layer 2</td>
  <td>0.080</td>
  <td>1.130</td>
  <td>1000</td>
  <td>1400</td>
  </tr>
</table>
<table>
  <tr>
  <th>Name</th>
  <th>IR Emissivity [-]</th>
  <th>Solar Emissivity [-]</th>
  </tr>
  <tr>
  <td>Outside</td>
  <td>0.9</td>
  <td>0.6</td>
  </tr>
  <tr>
  <td>Inside</td>
  <td>0.9</td>
  <td>0.6</td>
  </tr>
</table>
</p>
<p>
<b>Roof</b>
<table>
  <tr>
  <th>Name</th>
  <th>Thickness [m]</th>
  <th>Thermal Conductivity [W/m-K]</th>
  <th>Specific Heat Capacity [J/kg-K]</th>
  <th>Density [kg/m3]</th>
  </tr>
  <tr>
  <td>Layer 1</td>
  <td>0.019</td>
  <td>0.140</td>
  <td>900</td>
  <td>530</td>
  </tr>
  <tr>
  <td>Layer 2</td>
  <td>0.1118</td>
  <td>0.040</td>
  <td>840</td>
  <td>12</td>
  </tr>
  <tr>
  <td>Layer 3</td>
  <td>0.010</td>
  <td>0.160</td>
  <td>840</td>
  <td>950</td>
  </tr>
</table>
<table>
  <tr>
  <th>Name</th>
  <th>IR Emissivity [-]</th>
  <th>Solar Emissivity [-]</th>
  </tr>
  <tr>
  <td>Outside</td>
  <td>0.9</td>
  <td>0.6</td>
  </tr>
  <tr>
  <td>Inside</td>
  <td>0.9</td>
  <td>0.6</td>
  </tr>
</table>
<p>
The windows are double pane clear 3.175mm glass with 13mm air gap.
</p>

<h4>Occupancy schedules</h4>
<p>
There is maximum occupancy (two people) from 8am to 6pm each day, 
and no occupancy during all other times.
</p>
<h4>Internal loads and schedules</h4>
<p>
The internal heat gains from plug loads come mainly from computers and monitors.
The internal heat gains from lighting come from hanging fluorescent fixtures.
Both types of loads are at maximum during occupied periods and 0.1 maximum 
during all other times.
</p>
<h4>Climate data</h4>
<p>
The climate is assumed to be near Denver, CO, USA with a latitude and 
longitude of 39.76,-104.86.  The climate data comes from the 
Denver-Stapleton,CO,USA,TMY.
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
Heating and cooling is provided to the office using a four-pipe 
fan coil unit (FCU).  The FCU contains a fan, cooling coil, heating coil, 
and filter.  The fan draws room air into the unit, blows it over the coils 
and through the filter, and supplies the conditioned air back to the room.
There is a variable speed drive attached to the fan motor.  The cooling coil
is served by chilled water produced by a chiller and the heating coil is 
served by hot water produced by a gas boiler.
</p>
<h4>Equipment specifications and performance maps</h4>
<p>
For the fan, the design airflow rate is 0.75 kg/s, design pressure rise is 
875 Pa, and the design motor power consumption is 1.12 kW.  The heat from the
motor is added to the air stream.  

The COP of the chiller is assumed constant at 3.0.  The efficiency of the 
gas boiler is assumed constant at 0.9.
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
A baseline thermostat controller provides heating and cooling as necessary
to the room by switching between heating and cooling modes, and varying the
speed of the fan accordingly.  There are seperate room temperature setpoints 
for heating and cooling with a deadband between them.  The fan speed is 
controlled by a proportional controller based on the error between the 
measured room air temperature and the appropriate setpoint.  The fan is off 
if the room air temperature is within the deadband.  During heating and 
cooling modes, it is assumed the temperature of the air coming off of the 
coils is controlled internally to a heating and cooling supply air temperature 
setpoint respecitvely.
</p>
<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>oveTSetHea_u</code> [K] [min=288.15, max=296.15]: Zone temperature setpoint for heating
</li>
<li>
<code>con_oveTSupSetHea_u</code> [K] [min=303.15, max=313.15]: Supply air temperature setpoint for heating
</li>
<li>
<code>oveTSetCoo_u</code> [K] [min=296.15, max=303.15]: Zone temperature setpoint for cooling
</li>
<li>
<code>con_oveFan_u</code> [1] [min=0.0, max=1.0]: Fan speed control signal
</li>
<li>
<code>con_oveTSupSetCoo_u</code> [K] [min=285.15, max=291.15]: Supply air temperature setpoint for cooling
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>reaPCoo_y</code> [W] [min=None, max=None]: Cooling electrical power consumption
</li>
<li>
<code>reaPFan_y</code> [W] [min=None, max=None]: Supply fan electrical power consumption
</li>
<li>
<code>fcu_reaFloSup_y</code> [kg/s] [min=None, max=None]: Supply air mass flow rate
</li>
<li>
<code>fcu_reaTSup_y</code> [K] [min=None, max=None]: Supply air temperature
</li>
<li>
<code>reaTRooAir_y</code> [K] [min=None, max=None]: Zone air temperature
</li>
<li>
<code>fcu_reaTSupSet_y</code> [K] [min=None, max=None]: Supply air temperature setpoint
</li>
<li>
<code>con_reaTSetCoo_y</code> [K] [min=None, max=None]: Zone air temperature setpoint for cooling
</li>
<li>
<code>reaPHea_y</code> [W] [min=None, max=None]: Heating thermal power consumption
</li>
<li>
<code>zon_reaPPlu_y</code> [W] [min=None, max=None]: Plug load power submeter
</li>
<li>
<code>con_reaTSetHea_y</code> [K] [min=None, max=None]: Zone air temperature setpoint for heating
</li>
<li>
<code>zon_reaPLig_y</code> [W] [min=None, max=None]: Lighting power submeter
</li>
<li>
<code>fcu_reaFanSpeSet_y</code> [1] [min=None, max=None]: Supply fan speed setpoint
</li>
<li>
<code>fcu_reaTRet_y</code> [K] [min=None, max=None]: Return air temperature
</li>
</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
There is no daylighting system in the building.
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
…

</p>
<h4>Pressure-flow models</h4>
<p>
…
</p>
<h4>Infiltration models</h4>
<p>
…
</p>
<h3>Scenario Information</h3>
<h4>Energy Pricing</h4>
<p>
…

</p>
<h4>Emission Factors</h4>
<p>
…
</p>
</html>",
revisions="<html>
<ul>
<li>
October 30, 2019, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"));
end TestCase;
