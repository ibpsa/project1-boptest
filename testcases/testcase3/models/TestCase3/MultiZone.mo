within TestCase3;
model MultiZone

  Modelica.Blocks.Sources.Step Tset[4](
    each height=2,
    each offset=273.15 + 20,
    each startTime=3600*24) "Room temperature sepoint"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Continuous.LimPID conRoo[4](
    each controllerType=Modelica.Blocks.Types.SimpleController.P,
    each k=2000,
    each yMin=0,
    each yMax=100000)
    "Feedback controller of thermal zone for the heater based on room temperature"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

   TheZon Zon[4](zone=zones) "Thermal zones"
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  CtrReaBlo ctrReaBlo[2](descriptionCtr=["Heater thermal power of north " +
        zones[1],"Heater thermal power of  zone " + zones[2]; "Heater thermal power of north zone "
         + zones[3],"Heater thermal power of south zone " + zones[4]], Pnom=[10000,
        11000; 12000,13000])
    annotation (Placement(transformation(extent={{0,60},{20,80}})));

  parameter String zones[4]={"zon1","zon2","zon3","zon4"} "Zone designation, required if KPIs is AirZoneTemperature, 
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity, 
    or CO2Concentration"  annotation(Evaluate=true);
  Buildings.Utilities.IO.SignalExchange.Read PheaCooVec[4](
    y(each unit="W"),
    each KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    description={"Zone air CO2 concentration of zone " + zones[i] for i in 1:
        size(zones, 1)}) "HVAC power consumption"
    annotation (Placement(transformation(extent={{140,98},{160,118}})));
  Buildings.Utilities.IO.SignalExchange.Read TRooAirVec[4](
    y(each unit="K"),
    each KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    description={"Air temperature of zone " + zones[i] for i in 1:size(zones, 1)},
    zone=zones) "Read zones air temperature"
    annotation (Placement(transformation(extent={{140,60},{160,80}})));
equation
  connect(Tset.y,conRoo. u_s)
    annotation (Line(points={{-59,70},{-42,70}}, color={0,0,127}));

  connect(conRoo[1].y, ctrReaBlo[1].uCtr[1])
    annotation (Line(points={{-19,70},{-18,69.5},{-2,69.5}}, color={0,0,127}));
  connect(conRoo[2].y, ctrReaBlo[1].uCtr[2])
    annotation (Line(points={{-19,70},{-18,70.5},{-2,70.5}}, color={0,0,127}));
  connect(conRoo[3].y, ctrReaBlo[2].uCtr[1])
    annotation (Line(points={{-19,70},{-18,69.5},{-2,69.5}}, color={0,0,127}));
  connect(conRoo[4].y, ctrReaBlo[2].uCtr[2])
    annotation (Line(points={{-19,70},{-18,70.5},{-2,70.5}}, color={0,0,127}));
  connect(ctrReaBlo[1].yCtr[1], Zon[1].QZon)
    annotation (Line(points={{21,69.75},{24,70},{78,70}}, color={0,0,127}));
  connect(ctrReaBlo[1].yCtr[2], Zon[2].QZon)
    annotation (Line(points={{21,70.25},{24,70},{78,70}}, color={0,0,127}));
  connect(ctrReaBlo[2].yCtr[1], Zon[3].QZon)
    annotation (Line(points={{21,69.75},{24,70},{78,70}}, color={0,0,127}));
  connect(ctrReaBlo[2].yCtr[2], Zon[4].QZon)
    annotation (Line(points={{21,70.25},{24,70},{78,70}}, color={0,0,127}));
  connect(Zon.PHeaCoo, PheaCooVec.u) annotation (Line(points={{101,76},{128,76},
          {128,108},{138,108}}, color={0,0,127}));
  connect(Zon.TZon, TRooAirVec.u) annotation (Line(points={{101,64},{128,64},{128,
          70},{138,70}}, color={0,0,127}));
  connect(TRooAirVec.y, conRoo.u_m) annotation (Line(points={{161,70},{170,70},{
          170,40},{-30,40},{-30,58}}, color={0,0,127}));
  annotation (
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
The considered building consists of four independent zones (zon1, zon2, zon3, and zon4) which are each modeled as an RC-model. Each RC-model has an air capacitance which models the zone air temperature
  and is separated from the ambient by a fixed resistance. This is a trivial test case intended for a first exploration of BOPTEST and parser testing.
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
The HVAC system in question consists of a simple prescribed heat flow into each zone air capacitance. This heat flow is independent every zone and
  can attain both positive and negative values, representing heating and cooling respectively. Heat flows are
  powered by their own electric heater/cooler with a fixed efficiency of 99% in both operating regimes.
</p>


<h4>Equipment specifications and performance maps</h4>
<p>
The electric heaters/coolers are modeled as a simple fixed efficiency device. The efficiency is 99% in both heating and cooling modes.
</p>

<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
Four baseline proportional feedback controllers (P-controller) are implemented to control the prescribed heat flow to each zone. Btoh
  baseline implementations only transmit a signal when the observed air temperature of their respective zone is lower than a certain setpoint.
  Therefore, the heating system only operates in heating mode using the baseline controller, but cooling mode can be
  activated with a custom user-implemented controller.
  <br>
The setpoint for the P-controllers for each zone is  identical. A step function is implemented as a baseline, which is 20 degree C initially. After one day, the setpoint changes to
  22 degree C.
</p>

<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>ctrReaBlo_1_ctrReaBloNested_1_oveAct_activate</code> [1] [min=0, max=1]: Activation signal to overwrite input ctrReaBlo_1_ctrReaBloNested_1_oveAct_u where 1 activates, 0 deactivates (default value)
</li>
<li>
<code>ctrReaBlo_1_ctrReaBloNested_1_oveAct_u</code> [W] [min=-10000, max=10000]: Heater thermal power of zone
</li>
<li>
<code>ctrReaBlo_1_ctrReaBloNested_2_oveAct_activate</code> [1] [min=0, max=1]: Activation signal to overwrite input ctrReaBlo_1_ctrReaBloNested_2_oveAct_u where 1 activates, 0 deactivates (default value)
</li>
<li>
<code>ctrReaBlo_1_ctrReaBloNested_2_oveAct_u</code> [W] [min=-11000, max=11000]: Heater thermal power of zone
</li>
<li>
<code>ctrReaBlo_2_ctrReaBloNested_1_oveAct_activate</code> [1] [min=0, max=1]: Activation signal to overwrite input ctrReaBlo_2_ctrReaBloNested_1_oveAct_u where 1 activates, 0 deactivates (default value)
</li>
<li>
<code>ctrReaBlo_2_ctrReaBloNested_1_oveAct_u</code> [W] [min=-12000, max=12000]: Heater thermal power of zone
</li>
<li>
<code>ctrReaBlo_2_ctrReaBloNested_2_oveAct_activate</code> [1] [min=0, max=1]: Activation signal to overwrite input ctrReaBlo_2_ctrReaBloNested_2_oveAct_u where 1 activates, 0 deactivates (default value)
</li>
<li>
<code>ctrReaBlo_2_ctrReaBloNested_2_oveAct_u</code> [W] [min=-13000, max=13000]: Heater thermal power of zone
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>PheaCooVec_1_y</code> [W] [min=None, max=None]: Zone air CO2 concentration of zone zon1
</li>
<li>
<code>PheaCooVec_2_y</code> [W] [min=None, max=None]: Zone air CO2 concentration of zone zon2
</li>
<li>
<code>PheaCooVec_3_y</code> [W] [min=None, max=None]: Zone air CO2 concentration of zone zon3
</li>
<li>
<code>PheaCooVec_4_y</code> [W] [min=None, max=None]: Zone air CO2 concentration of zone zon4
</li>
<li>
<code>TRooAirVec_1_y</code> [K] [min=None, max=None]: Air temperature of zone zon1
</li>
<li>
<code>TRooAirVec_2_y</code> [K] [min=None, max=None]: Air temperature of zone zon2
</li>
<li>
<code>TRooAirVec_3_y</code> [K] [min=None, max=None]: Air temperature of zone zon3
</li>
<li>
<code>TRooAirVec_4_y</code> [K] [min=None, max=None]: Air temperature of zone zon4
</li>
<li>
<code>Zon_1_CO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone zon1
</li>
<li>
<code>Zon_2_CO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone zon2
</li>
<li>
<code>Zon_3_CO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone zon3
</li>
<li>
<code>Zon_4_CO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone zon4
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
<code>InternalGainsCon[zon1]</code> [W]: Convective internal gains of zone
</li>
<li>
<code>InternalGainsCon[zon2]</code> [W]: Convective internal gains of zone
</li>
<li>
<code>InternalGainsCon[zon3]</code> [W]: Convective internal gains of zone
</li>
<li>
<code>InternalGainsCon[zon4]</code> [W]: Convective internal gains of zone
</li>
<li>
<code>InternalGainsLat[zon1]</code> [W]: Latent internal gains of zone
</li>
<li>
<code>InternalGainsLat[zon2]</code> [W]: Latent internal gains of zone
</li>
<li>
<code>InternalGainsLat[zon3]</code> [W]: Latent internal gains of zone
</li>
<li>
<code>InternalGainsLat[zon4]</code> [W]: Latent internal gains of zone
</li>
<li>
<code>InternalGainsRad[zon1]</code> [W]: Radiative internal gains of zone
</li>
<li>
<code>InternalGainsRad[zon2]</code> [W]: Radiative internal gains of zone
</li>
<li>
<code>InternalGainsRad[zon3]</code> [W]: Radiative internal gains of zone
</li>
<li>
<code>InternalGainsRad[zon4]</code> [W]: Radiative internal gains of zone
</li>
<li>
<code>LowerSetp[zon1]</code> [K]: Lower temperature set point for thermal comfort of zone
</li>
<li>
<code>LowerSetp[zon2]</code> [K]: Lower temperature set point for thermal comfort of zone
</li>
<li>
<code>LowerSetp[zon3]</code> [K]: Lower temperature set point for thermal comfort of zone
</li>
<li>
<code>LowerSetp[zon4]</code> [K]: Lower temperature set point for thermal comfort of zone
</li>
<li>
<code>Occupancy[zon1]</code> [number of people]: Number of occupants of zone
</li>
<li>
<code>Occupancy[zon2]</code> [number of people]: Number of occupants of zone
</li>
<li>
<code>Occupancy[zon3]</code> [number of people]: Number of occupants of zone
</li>
<li>
<code>Occupancy[zon4]</code> [number of people]: Number of occupants of zone
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
<code>TDryBul</code> [K]: Dry bulb temperature at ground level
</li>
<li>
<code>UpperCO2[zon1]</code> [ppm]: Upper CO2 set point for indoor air quality of zone
</li>
<li>
<code>UpperCO2[zon2]</code> [ppm]: Upper CO2 set point for indoor air quality of zone
</li>
<li>
<code>UpperCO2[zon3]</code> [ppm]: Upper CO2 set point for indoor air quality of zone
</li>
<li>
<code>UpperCO2[zon4]</code> [ppm]: Upper CO2 set point for indoor air quality of zone
</li>
<li>
<code>UpperSetp[zon1]</code> [K]: Upper temperature set point for thermal comfort of zone
</li>
<li>
<code>UpperSetp[zon2]</code> [K]: Upper temperature set point for thermal comfort of zone
</li>
<li>
<code>UpperSetp[zon3]</code> [K]: Upper temperature set point for thermal comfort of zone
</li>
<li>
<code>UpperSetp[zon4]</code> [K]: Upper temperature set point for thermal comfort of zone
</li>
</ul>
<h4>Parser Array Testing</h4>
<p>
The heater overwrite and CO2 concentration read signals for both zones are
implemented using arrays of signal exchange blocks,
<code>oveActVec[2]</code> and <code>CO2RooAirVec[2]</code>, which are the
blocks actually used to control the heating power of each zone and to
report each zone's CO2 concentration. The scalar signal exchange blocks
<code>oveActNor</code>/<code>oveActSou</code> and
<code>CO2RooAirNor</code>/<code>CO2RooAirSou</code> read and write the
same underlying signals in parallel and are included only for comparison,
so that the array-based and scalar-based signal exchange block instances
can be checked against each other.
</p>
<p>
In addition, the model includes an array of the <code>CtrReaBlo</code>
submodel, <code>ctrReaBlo[2]</code>, which is not connected to the
physical zone model and serves only to test the BOPTEST parser's ability
to flatten signal exchange block instance paths with multiple,
independent array dimensions spanning several levels of model nesting.
<code>CtrReaBlo</code> itself contains both a top-level array of signal
exchange blocks (<code>oveAct[2]</code>, <code>CO2RooAir[2]</code>) and a
nested array of a further submodel, <code>ctrReaBloNested[2]</code>,
containing its own signal exchange blocks, producing instance paths such
as <code>ctrReaBlo[i].oveAct[j]</code> and
<code>ctrReaBlo[i].ctrReaBloNested[j].oveAct</code>. See
<code>CtrReaBlo</code> and <code>CtrReaBloNested</code> for further
details on this test structure.
</p>
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
October 6th, 2026, by Ettore Zanetti:<br/>
Update test case to demonstrate array use
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/190>
BOPTEST issue #190</a>.
</li>
<li>
September 6th, 2025, by Ettore Zanetti:<br/>
Update test case to Modelica 4.0 and Buildings 12.1.0
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/422>
BOPTEST issue #422</a>.
</li>
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
end MultiZone;
