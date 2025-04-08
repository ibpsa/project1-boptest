within ;
model TwoZones

  parameter String zonNorName="North" "Parameter used to designate north zone";
  parameter String zonSouName="South" "Parameter used to designate south zone";

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capSou(C=1e6)
    "Thermal capacitance of south zone"
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor resSou(R=0.01)
    "Thermal resistance of south zone to outside"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZonSou
    "Room air temperature sensor of south zone"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut
    "Set the outside air temperature"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.Sine souTOut(
    freqHz=1/(3600*24),
    offset=273.15 + 20,
    amplitude=10) "Artificial outside air temperature"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Step setSou(
    height=2,
    offset=273.15 + 20,
    startTime=3600*24) "Room temperature sepoint for south zone"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Continuous.LimPID conSou(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=2000,
    yMin=0,
    yMax=100000)
    "Feedback controller of south zone for the heater based on room temperature"
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveActSou(u(
      unit="W",
      min=-10000,
      max=10000), description="Heater thermal power of south zone")
    "Overwrite the heating power of south zone"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaSou
    "Set the heating power to the south zone"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Math.Gain effSou(k=1/0.99) "Heater efficiency in south zone"
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Buildings.Utilities.IO.SignalExchange.Read
                                         TRooAirSou(
    y(unit="K"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.OperativeZoneTemperature,
    description="Operative zone temperature of south zone",
    zone=zonSouName)
    "Read the room air temperature of south zone. In this case it is assumed that the operative zone temperature is being read. "
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));

  Buildings.Utilities.IO.SignalExchange.Read PHeaCooSou(
    y(unit="W"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heater / Cooler power of south zone")
    "Read the heater power consumed in south zone"
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));

  Modelica.Blocks.Math.Abs absSou
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Buildings.Utilities.IO.SignalExchange.Read
                                         CO2RooAirSou(
    y(unit="ppm"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    description="Zone air CO2 concentration of south zone",
    zone=zonSouName)   "Read the room air CO2 concentration in south zone"
    annotation (Placement(transformation(extent={{160,-40},{180,-20}})));

  Modelica.Blocks.Sources.Sine conCO2Sou(
    amplitude=250,
    freqHz=1/(3600*24),
    offset=750) "Concetration of CO2 in south zone"
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capNor(C=1e6)
    "Thermal capacitance of north zone"
    annotation (Placement(transformation(extent={{30,60},{50,40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor resNor(R=0.01)
    "Thermal resistance of north zone to outside"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZonNor
    "Room air temperature sensor of north zone"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Sources.Step setNor(
    height=2,
    offset=273.15 + 21,
    startTime=3600*24) "Room temperature sepoint for north zone"
    annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  Modelica.Blocks.Continuous.LimPID conNor(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=2000,
    yMin=0,
    yMax=100000)
    "Feedback controller of north zone for the heater based on room temperature"
    annotation (Placement(transformation(extent={{-70,110},{-50,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveActNor(u(
      unit="W",
      min=-10000,
      max=10000), description="Heater thermal power of north zone")
    "Overwrite the heating power of north zone"
    annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaNor
    "Set the heating power to the north zone"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));
  Modelica.Blocks.Math.Gain effNor(k=1/0.99) "Heater efficiency in north zone"
    annotation (Placement(transformation(extent={{0,150},{20,170}})));
  Buildings.Utilities.IO.SignalExchange.Read
                                         TRooAirNor(
    y(unit="K"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    description="Zone air temperature of north zone",
    zone=zonNorName)   "Read the room air temperature of north zone"
    annotation (Placement(transformation(extent={{80,120},{60,140}})));

  Buildings.Utilities.IO.SignalExchange.Read PHeaCooNor(
    y(unit="W"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heater / Cooler power of north zone")
    "Read the heater power consumed in north zone"
    annotation (Placement(transformation(extent={{80,150},{100,170}})));

  Modelica.Blocks.Math.Abs absNor
    annotation (Placement(transformation(extent={{30,150},{50,170}})));
  Buildings.Utilities.IO.SignalExchange.Read
                                         CO2RooAirNor(
    y(unit="ppm"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    description="Zone air CO2 concentration of north zone",
    zone=zonNorName)   "Read the room air CO2 concentration in north zone"
    annotation (Placement(transformation(extent={{160,80},{180,100}})));

  Modelica.Blocks.Sources.Sine conCO2Nor(
    amplitude=250,
    freqHz=1/(3600*24),
    offset=750) "Concetration of CO2 in north zone"
    annotation (Placement(transformation(extent={{120,80},{140,100}})));
equation
  connect(resSou.port_b, capSou.port)
    annotation (Line(points={{20,0},{40,0}}, color={191,0,0}));
  connect(capSou.port, senTZonSou.port)
    annotation (Line(points={{40,0},{60,0}}, color={191,0,0}));
  connect(preTOut.port, resSou.port_a) annotation (Line(points={{-20,30},{-10,30},
          {-10,0},{0,0}}, color={191,0,0}));
  connect(souTOut.y, preTOut.T)
    annotation (Line(points={{-79,30},{-42,30}},
                                               color={0,0,127}));
  connect(conSou.y, oveActSou.u)
    annotation (Line(points={{-49,-30},{-42,-30}}, color={0,0,127}));
  connect(oveActSou.y, preHeaSou.Q_flow)
    annotation (Line(points={{-19,-30},{0,-30}}, color={0,0,127}));
  connect(preHeaSou.port, capSou.port)
    annotation (Line(points={{20,-30},{40,-30},{40,0}}, color={191,0,0}));
  connect(oveActSou.y, effSou.u) annotation (Line(points={{-19,-30},{-10,-30},{-10,
          -80},{-2,-80}}, color={0,0,127}));
  connect(setSou.y, conSou.u_s)
    annotation (Line(points={{-79,-30},{-72,-30}}, color={0,0,127}));
  connect(senTZonSou.T, TRooAirSou.u) annotation (Line(points={{81,0},{90,0},{90,
          -50},{82,-50}}, color={0,0,127}));
  connect(TRooAirSou.y, conSou.u_m)
    annotation (Line(points={{59,-50},{-60,-50},{-60,-42}}, color={0,0,127}));
  connect(effSou.y, absSou.u)
    annotation (Line(points={{21,-80},{28,-80}}, color={0,0,127}));
  connect(absSou.y, PHeaCooSou.u)
    annotation (Line(points={{51,-80},{78,-80}}, color={0,0,127}));
  connect(conCO2Sou.y, CO2RooAirSou.u)
    annotation (Line(points={{141,-30},{158,-30}}, color={0,0,127}));
  connect(resNor.port_b, capNor.port)
    annotation (Line(points={{20,60},{40,60}}, color={191,0,0}));
  connect(capNor.port, senTZonNor.port)
    annotation (Line(points={{40,60},{60,60}}, color={191,0,0}));
  connect(preTOut.port, resNor.port_a) annotation (Line(points={{-20,30},{-10,30},
          {-10,60},{0,60}}, color={191,0,0}));
  connect(conNor.y, oveActNor.u)
    annotation (Line(points={{-49,100},{-42,100}}, color={0,0,127}));
  connect(oveActNor.y, preHeaNor.Q_flow)
    annotation (Line(points={{-19,100},{0,100}}, color={0,0,127}));
  connect(setNor.y, conNor.u_s)
    annotation (Line(points={{-79,100},{-72,100}}, color={0,0,127}));
  connect(effNor.y, absNor.u)
    annotation (Line(points={{21,160},{28,160}}, color={0,0,127}));
  connect(absNor.y, PHeaCooNor.u)
    annotation (Line(points={{51,160},{78,160}}, color={0,0,127}));
  connect(conCO2Nor.y, CO2RooAirNor.u)
    annotation (Line(points={{141,90},{158,90}}, color={0,0,127}));
  connect(senTZonNor.T, TRooAirNor.u) annotation (Line(points={{81,60},{90,60},{
          90,130},{82,130}}, color={0,0,127}));
  connect(effNor.u, preHeaNor.Q_flow) annotation (Line(points={{-2,160},{-10,160},
          {-10,100},{0,100}}, color={0,0,127}));
  connect(TRooAirNor.y, conNor.u_m)
    annotation (Line(points={{59,130},{-60,130},{-60,112}}, color={0,0,127}));
  connect(preHeaNor.port, capNor.port)
    annotation (Line(points={{20,100},{40,100},{40,60}}, color={191,0,0}));
  annotation (uses(Modelica(version="3.2.3"), Buildings(version="8.0.0")),
      experiment(
      StopTime=60,
      Interval=1,
      Tolerance=1e-06),
    Diagram(coordinateSystem(extent={{-100,-100},{220,180}})),
    Icon(coordinateSystem(extent={{-100,-100},{220,180}})),
    Documentation(info="<html>
General model description.
<h3>Building Design and Use</h3>
<h4>Architecture</h4>
<p>
The considered building consists of two independent zones (North and Soutch) which are each modeled as an RC-model. Each RC-model has an air capacitance which models the zone air temperature
  and is separated from the ambient by a fixed resistance. This is a trivial test case intended
  for a first exploration of BOPTEST.
</p>
<h4>Constructions</h4>
<p>
The value of the R and C parameters of both zones are identical and are given below:
</p>
<p>
<b>R and C parameters</b>
<table>
  <tr>
  <th>Name</th>
  <th>Value</th>
  </tr>
  <tr>
  <th>Zone capacitance [J/K]</th>
  <td>10^6</td>
  </tr>
  <tr>
  <th>Transmission loss resistance [K/W]</th>
  <td>0.01</td>
  </tr>
  </table>

<h4>Occupancy schedules</h4>
<p>
No occupancy is considered in this test case.
</p>
<h4>Internal loads and schedules</h4>
<p>
No internal loads and schedules are considered in this test case.

</p>
<h4>Climate data</h4>
<p>
Climate data is limited to an assumed sinusoidal temperature profile with a 24-hour period with an offset of
  20 degree C and an amplitude of 10 degree C.
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
The HVAC system in question consists of a simple prescribed heat flow into each zone air capacitance. This heat flow is independent for both zones and
  can attain both positive and negative values, representing heating and cooling respectively. Both heat flows are
  powered by their own electric heater/cooler with a fixed efficiency of 99% in both operating regimes.
</p>


<h4>Equipment specifications and performance maps</h4>
<p>
The electric heaters/coolers are modeled as a simple fixed efficiency device. The efficiency is 99% in both heating and cooling modes.
</p>

<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
Two baseline proportional feedback controllers (P-controller) are implemented to control the prescribed heat flow to each zone. Btoh
  baseline implementations only transmit a signal when the observed air temperature of their respective zone is lower than a certain setpoint.
  Therefore, the heating system only operates in heating mode using the baseline controller, but cooling mode can be
  activated with a custom user-implemented controller.
  <br>
The setpoint for the P-controllers for both zones are not identical. For the northern zone, a step function is implemented as a baseline, which is 21 degree C initially. After one day, the setpoint changes to
  23 degree C. For the southern zone, a similar step function is used, which switches from 20 degree C to 22 degree C after one day.
</p>

<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li><code>oveActNor_activate</code> [None]: Activation for Heater / Cooler thermal power of north zone</li>
<li><code>oveActNor_u</code> [W]: Heater / Cooler thermal power of north zone (Maximum: 10000.0, Minimum: -10000.0)</li>
<li><code>oveActSou_activate</code> [None]: Activation for Heater / Cooler thermal power of south zone</li>
<li><code>oveActSou_u</code> [W]: Heater / Cooler thermal power of south zone (Maximum: 10000.0, Minimum: -10000.0)</li>
</ul>

<h4>Outputs</h4>
The model outputs are:
<ul>
  <li><code>CO2RooAirNor_y</code> [ppm]: Zone air CO2 concentration of north zone</li>
  <li><code>CO2RooAirSou_y</code> [ppm]: Zone air CO2 concentration of south zone</li>
  <li><code>PHeaCooNor_y</code> [W]: Heater / Cooler power of north zone</li>
  <li><code>PHeaCooSou_y</code> [W]: Heater / Cooler power of south zone</li>
  <li><code>TRooAirNor_y</code> [K]: Zone air temperature of north zone</li>
  <li><code>TRooAirSou_y</code> [K]: Operative zone temperature of south zone</li>
</ul>

<h4>Forecasts</h4>
The model forecasts are:
<ul>
  <li><code>EmissionsBiomassPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from biomass</li>
  <li><code>EmissionsDistrictHeatingPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal district heating</li>
  <li><code>EmissionsElectricPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh of electricity</li>
  <li><code>EmissionsGasPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from gas</li>
  <li><code>EmissionsSolarThermalPower</code> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from solar irradiation</li>
  <li><code>InternalGainsCon[North]</code> [W]: Convective internal gains of north zone</li>
  <li><code>InternalGainsCon[South]</code> [W]: Convective internal gains of south zone</li>
  <li><code>InternalGainsLat[North]</code> [W]: Latent internal gains of north zone</li>
  <li><code>InternalGainsLat[South]</code> [W]: Latent internal gains of south zone</li>
  <li><code>InternalGainsRad[North]</code> [W]: Radiative internal gains of north zone</li>
  <li><code>InternalGainsRad[South]</code> [W]: Radiative internal gains of south zone</li>
  <li><code>LowerSetp[North]</code> [K]: Lower temperature set point for thermal comfort of north zone</li>
  <li><code>LowerSetp[South]</code> [K]: Lower temperature set point for thermal comfort of northzone</li>
  <li><code>Occupancy[North]</code> [number of people]: Number of occupants of north zone</li>
  <li><code>Occupancy[South]</code> [number of people]: Number of occupants of northzone</li>
  <li><code>PriceBiomassPower</code> [($/Euro)/kWh]: Price to produce 1 kWh thermal from biomass</li>
  <li><code>PriceDistrictHeatingPower</code> [($/Euro)/kWh]: Price of 1 kWh thermal from district heating</li>
  <li><code>PriceElectricPowerConstant</code> [($/Euro)/kWh]: Completely constant electricity price</li>
  <li><code>PriceElectricPowerDynamic</code> [($/Euro)/kWh]: Electricity price for a day/night tariff</li>
  <li><code>PriceElectricPowerHighlyDynamic</code> [($/Euro)/kWh]: Spot electricity price</li>
  <li><code>PriceGasPower</code> [($/Euro)/kWh]: Price to produce 1 kWh thermal from gas</li>
  <li><code>PriceSolarThermalPower</code> [($/Euro)/kWh]: Price to produce 1 kWh thermal from solar irradiation</li>
  <li><code>TDryBul</code> [K]: Dry bulb temperature at ground level</li>
  <li><code>UpperCO2[North]</code> [ppm]: Upper CO2 set point for indoor air quality of north zone</li>
  <li><code>UpperCO2[South]</code> [ppm]: Upper CO2 set point for indoor air quality of south zone</li>
  <li><code>UpperSetp[North]</code> [K]: Upper temperature set point for thermal comfort of north zone</li>
  <li><code>UpperSetp[South]</code> [K]: Upper temperature set point for thermal comfort of south zone</li>
</ul>

<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
No lighting included in this test case.
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
Not applicable.

</p>
<h4>Pressure-flow models</h4>
<p>
Not applicable
</p>
<h4>Infiltration models</h4>
<p>
Not applicable
</p>
<h4>Other assumptions</h4>
<p>
None
</p>

<h3>Scenario Information</h3>
<h4>Time Periods</h4>
<p>
The <b>Test day</b> (specifier for <code>/scenario</code> API is <code>'test_day'</code>) period is:
<ul>
This testing time period is a two-week test utilizing
baseline control, starting on the 13th day of the year.
</ul>
<ul>
Start Time: Day 13.
</ul>
<ul>
End Time: Day 27.
</ul>
</p>

<h4>Energy Pricing</h4>
<p>
The <b>Constant Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'constant'</code>) profile is:
<ul>
Based on the Schedule R tariff
for winter season and summer season first 500 kWh as defined by the
utility servicing the assumed location of the test case.  It is $0.05461/kWh.
For reference,
see https://www.xcelenergy.com/company/rates_and_regulations/rates/rate_books
in the section on Current Tariffs/Electric Rate Books (PDF).
</ul>
<ul>
Specifier for <code>/scenario</code> API is <code>'constant'</code>.
</ul>
</p>
<p>
The <b>Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'dynamic'</code>) profile is:
<ul>
Based on the Schedule RE-TOU tariff
as defined by the utility servicing the assumed location of the test case.
For reference,
see https://www.xcelenergy.com/company/rates_and_regulations/rates/rate_books
in the section on Current Tariffs/Electric Rate Books (PDF).
</ul>
</p>
<p>
<ul>
<li>
Summer on-peak is $0.13814/kWh.
</li>
<li>
Summer mid-peak is $0.08420/kWh.
</li>
<li>
Summer off-peak is $0.04440/kWh.
</li>
<li>
Winter on-peak is $0.08880/kWh.
</li>
<li>
Winter mid-peak is $0.05413/kWh.
</li>
<li>
Winter off-peak is $0.04440/kWh.
</li>
<li>
The Summer season is June 1 to September 30.
</li>
<li>
The Winter season is October 1 to May 31.
</li>
</p>
<p>
<u>The On-Peak Period is</u>:
<ul>
<li>
Summer and Winter weekdays except Holidays, between 2:00 p.m. and 6:00 p.m.
local time.
</li>
</ul>
<u>The Mid-Peak Period is</u>:
<ul>
<li>
Summer and Winter weekdays except Holidays, between 9:00 a.m. and
2:00 p.m. and between 6:00 p.m. and 9:00 p.m. local time.
</li>
<li>
Summer and Winter weekends and Holidays, between 9:00 a.m. and
9:00 p.m. local time.
</li>
</ul>
<u>The Off-Peak Period is</u>:
<ul>
<li>
Summer and Winter daily, between 9:00 p.m. and 9:00 a.m. local time.
</li>
</ul>
</ul>
</p>
<p>
The <b>Highly Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'highly_dynamic'</code>) profile is:
<ul>
Based on the the
day-ahead energy prices (LMP) as determined in the Southwest Power Pool
wholesale electricity market for node LAM345 in the year 2018.
For reference,
see https://marketplace.spp.org/pages/da-lmp-by-location#%2F2018.
</ul>
</p>
The <b>Gas Price</b> profile is:
<ul>
Based on the Schedule R tariff for usage price per therm as defined by the
utility servicing the assumed location of the test case.  It is $0.002878/kWh
($0.0844/therm).
For reference,
see https://www.xcelenergy.com/company/rates_and_regulations/rates/rate_books
in the section on Summary of Gas Rates for 10/1/19.
</ul>
</p>
<h4>Emission Factors</h4>
<p>
The <b>Electricity Emissions Factor</b> profile is:
<ul>
Based on the average electricity generation mix for CO,USA for the year of
2017.  It is 0.6618 kgCO2/kWh (1459 lbsCO2/MWh).
For reference,
see https://www.eia.gov/electricity/state/colorado/.
</ul>
</p>
<p>
The <b>Gas Emissions Factor</b> profile is:
<ul>
Based on the kgCO2 emitted per amount of natural gas burned in terms of
energy content.  It is 0.18108 kgCO2/kWh (53.07 kgCO2/milBTU).
For reference,
see https://www.eia.gov/environment/emissions/co2_vol_mass.php.
</ul>
</p>
</html>", revisions="<html>
<ul>
<li>
March 6th, 2025, by Jaap Neven:<br/>
Initial version.
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/582>
BOPTEST issue #582</a>.
</li>
<li>
April 7th, 2025, by Jaap Neven:<br/>
Changed naming convention of thermal power to reflect both heating and cooling regime.
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/582>
BOPTEST issue #582</a>.
</li>
</ul>
</html>"));
end TwoZones;
