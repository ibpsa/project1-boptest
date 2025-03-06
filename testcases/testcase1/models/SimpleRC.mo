within ;
model SimpleRC
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C=1e6)
    "Thermal capacitance of room"
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res(R=0.01)
    "Thermal resistance to outside"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZone
    "Room air temperature sensor"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut
    "Set the outside air temperature"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Sine souTOut(
    freqHz=1/(3600*24),
    offset=273.15 + 20,
    amplitude=10) "Artificial outside air temperature"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Step set(
    height=2,
    offset=273.15 + 20,
    startTime=3600*24) "Room temperature sepoint"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Continuous.LimPID con(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=2000,
    yMin=0,
    yMax=100000)
    "Feedback controller for the heater/cooler based on room temperature"
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                           oveAct(u(
      unit="W",
      min=-10000,
      max=10000), description="Heater/Cooler thermal power")
    "Overwrite the heating/cooling power"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeat
    "Set the heating or cooling power to the room"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Math.Gain eff(k=1/0.99) "Heater/Cooler efficiency"
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Buildings.Utilities.IO.SignalExchange.Read
                      TRooAir(                y(unit="K"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    description="Zone air temperature") "Read the room air temperature"
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Buildings.Utilities.IO.SignalExchange.Read PHeaCoo(
    y(unit="W"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heater/Cooler power") "Read the heater/cooler power"
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
  Modelica.Blocks.Math.Abs abs
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Buildings.Utilities.IO.SignalExchange.Read
                                         CO2RooAir(
    y(unit="ppm"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    description="Zone air CO2 concentration")
    "Read the room air CO2 concentration"
    annotation (Placement(transformation(extent={{80,50},{100,70}})));

  Modelica.Blocks.Sources.Sine     conCO2(
    amplitude=250,
    freqHz=1/(3600*24),
    offset=750) "Concetration of CO2"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
equation
  connect(res.port_b, cap.port)
    annotation (Line(points={{20,0},{40,0}},color={191,0,0}));
  connect(cap.port, senTZone.port)
    annotation (Line(points={{40,0},{60,0}}, color={191,0,0}));
  connect(preTOut.port, res.port_a)
    annotation (Line(points={{-20,0},{0,0}},   color={191,0,0}));
  connect(souTOut.y, preTOut.T)
    annotation (Line(points={{-79,0},{-42,0}}, color={0,0,127}));
  connect(con.y, oveAct.u)
    annotation (Line(points={{-49,-30},{-42,-30}}, color={0,0,127}));
  connect(oveAct.y, preHeat.Q_flow)
    annotation (Line(points={{-19,-30},{0,-30}},color={0,0,127}));
  connect(preHeat.port, cap.port)
    annotation (Line(points={{20,-30},{40,-30},{40,0}}, color={191,0,0}));
  connect(oveAct.y, eff.u) annotation (Line(points={{-19,-30},{-10,-30},{-10,
          -80},{-2,-80}}, color={0,0,127}));
  connect(set.y, con.u_s)
    annotation (Line(points={{-79,-30},{-72,-30}}, color={0,0,127}));
  connect(senTZone.T, TRooAir.u) annotation (Line(points={{81,0},{90,0},{90,-50},
          {82,-50}}, color={0,0,127}));
  connect(TRooAir.y, con.u_m)
    annotation (Line(points={{59,-50},{-60,-50},{-60,-42}}, color={0,0,127}));
  connect(eff.y, abs.u)
    annotation (Line(points={{21,-80},{28,-80}}, color={0,0,127}));
  connect(abs.y, PHeaCoo.u)
    annotation (Line(points={{51,-80},{78,-80}}, color={0,0,127}));
  connect(conCO2.y, CO2RooAir.u)
    annotation (Line(points={{61,60},{78,60}}, color={0,0,127}));

  annotation (uses(Modelica(version="3.2.3"),
      Buildings(version="8.0.0")),
      experiment(
      StopTime=60,
      Interval=1,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>General model description. </p>
<p></span><b><span style=\"font-size: 10.8pt;\">Building Design and Use</b></p>
<h4>Architecture</h4>
<p>The considered building is a simple fixed capacitance which models the zone air temperature which is separated from the ambient by a fixed resistance. This is a trivial test case intended for a first exploration of BOPTEST. </p>
<h4>Constructions</h4>
<p>The value of the R and C parameters are given below: </p>
<p><b>R and C parameters</b> </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p align=\"center\"><h4>Name</h4></p></td>
<td><p align=\"center\"><h4>Value</h4></p></td>
</tr>
<tr>
<td><p align=\"center\"><h4>Zone capacitance [J/K]</h4></p></td>
<td><p>10^6</p></td>
</tr>
<tr>
<td><p align=\"center\"><h4>Transmission loss resistance [K/W]</h4></p></td>
<td><p>0.01</p></td>
</tr>
</table>
<p><br><h4>Occupancy schedules</h4></p>
<p>No occupancy is considered in this test case. </p>
<h4>Internal loads and schedules</h4>
<p>No internal loads and schedules are considered in this test case. </p>
<h4>Climate data</h4>
<p>Climate data is limited to an assumed sinusoidal temperature profile with a 24-hour period with an offset of 20 degree C and an amplitude of 10 degree C. </p>
<p></span><b><span style=\"font-size: 10.8pt;\">HVAC System Design</b></p>
<h4>Primary and secondary system designs</h4>
<p>The HVAC system in question consists of a simple prescribed heat flow into the zone air capacitance. This heat flow can attain both positive and negative values, representing heating and cooling respectively. This heat flow is powered by an electric heater/cooler with a fixed efficiency of 99&percnt; in both operating regimes. </p>
<h4>Equipment specifications and performance maps</h4>
<p>The electric heater/cooler is modeled as a simple fixed efficiency device. The efficiency is 99&percnt; in both heating and cooling modes. </p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>A baseline proportional feedback controller (P-controller) is implemented to control the prescribed heat flow. This baseline implementation only transmits a signal when the observed air temperature is lower than a certain setpoint. Therefore, the heating system only operates in heating mode using the baseline controller, but cooling mode can be activated with a custom user-implemented controller. </p><p>A step function is implemented as a baseline, which is 20 degree C initially. After one day, the setpoint changes to 22 degree C. </p>
<p></span><b><span style=\"font-size: 10.8pt;\">Model IO&apos;s</b></p>
<h4>Inputs</h4>
<p>The model inputs are: </p>
<ul>
<li><span style=\"font-family: Courier New;\">oveAct_activate</span> [1] [min=0, max=1]: Activation signal for heater/cooler thermal power oveAct_u where 1 activates (default value), 0 deactivates </li>
<li><span style=\"font-family: Courier New;\">oveAct_u</span> [W] [min=-10000, max=10000]: Heater/cooler thermal power </li>
</ul>
<h4>Outputs</h4>
<p>The model outputs are: </p>
<ul>
<li><span style=\"font-family: Courier New;\">CO2rooAir_y</span> [ppm] [min=None, max=None]: Zone air CO2 concentration </li>
<li><span style=\"font-family: Courier New;\">PHeaCoo_y</span> [W] [min=None, max=None]: Electrical heater/cooler power </li>
<li><span style=\"font-family: Courier New;\">TRooAir_y</span> [K] [min=None, max=None]:Zone air temperature </li>
</ul>
<h4>Forecasts</h4>
<p>The model forecasts are: </p>
<ul>
<li><span style=\"font-family: Courier New;\">EmissionsBiomassPower</span> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from biomass </li>
<li><span style=\"font-family: Courier New;\">EmissionsDistrictHeatingPower</span> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal district heating </li>
<li><span style=\"font-family: Courier New;\">EmissionsElectricPower</span> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh of electricity </li>
<li><span style=\"font-family: Courier New;\">EmissionsGasPower</span> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from gas </li>
<li><span style=\"font-family: Courier New;\">EmissionsSolarThermalPower</span> [kgCO2/kWh]: Kilograms of carbon dioxide to produce 1 kWh thermal from solar irradiation </li>
<li><span style=\"font-family: Courier New;\">InternalGainsCon[1]</span> [W]: Convective internal gains of zone </li>
<li><span style=\"font-family: Courier New;\">InternalGainsLat[1]</span> [W]: Latent internal gains of zone </li>
<li><span style=\"font-family: Courier New;\">InternalGainsRad[1]</span> [W]: Radiative internal gains of zone </li>
<li><span style=\"font-family: Courier New;\">LowerSetp[1]</span> [K]: Lower temperature set point for thermal comfort of zone </li>
<li><span style=\"font-family: Courier New;\">Occupancy[1]</span> [number of people]: Number of occupants of zone </li>
<li><span style=\"font-family: Courier New;\">PriceBiomassPower</span> [($/Euro)/kWh]: Price to produce 1 kWh thermal from biomass </li>
<li><span style=\"font-family: Courier New;\">PriceDistrictHeatingPower</span> [($/Euro)/kWh]: Price of 1 kWh thermal from district heating </li>
<li><span style=\"font-family: Courier New;\">PriceElectricPowerConstant</span> [($/Euro)/kWh]: Completely constant electricity price </li>
<li><span style=\"font-family: Courier New;\">PriceElectricPowerDynamic</span> [($/Euro)/kWh]: Electricity price for a day/night tariff </li>
<li><span style=\"font-family: Courier New;\">PriceElectricPowerHighlyDynamic</span> [($/Euro)/kWh]: Spot electricity price </li>
<li><span style=\"font-family: Courier New;\">PriceGasPower</span> [($/Euro)/kWh]: Price to produce 1 kWh thermal from gas </li>
<li><span style=\"font-family: Courier New;\">PriceSolarThermalPower</span> [($/Euro)/kWh]: Price to produce 1 kWh thermal from solar irradiation </li>
<li><span style=\"font-family: Courier New;\">TDryBul</span> [K]: Dry bulb temperature at ground level </li>
<li><span style=\"font-family: Courier New;\">UpperCO2[1]</span> [ppm]: Upper CO2 set point for indoor air quality of zone </li>
<li><span style=\"font-family: Courier New;\">UpperSetp[1]</span> [K]: Upper temperature set point for thermal comfort of zone </li>
</ul>
<p></span><b><span style=\"font-size: 10.8pt;\">Additional System Design</b></p>
<h4>Lighting</h4>
<p>No lighting included in this test case. </p>
<h4>Shading</h4>
<p>There are no shades on the building. </p>
<h4>Onsite Generation and Storage</h4>
<p>There is no energy generation or storage on the site. </p>
<p></span><b><span style=\"font-size: 10.8pt;\">Model Implementation Details</b></p>
<h4>Moist vs. dry air</h4>
<p>Not applicable. </p>
<h4>Pressure-flow models</h4>
<p>Not applicable </p>
<h4>Infiltration models</h4>
<p>Not applicable </p>
<h4>Other assumptions</h4>
<p>None </p>
<p></span><b><span style=\"font-size: 10.8pt;\">Scenario Information</b></p>
<h4>Time Periods</h4>
<p>The <b>Test day</b> (specifier for <span style=\"font-family: Courier New;\">/scenario</span> API is <span style=\"font-family: Courier New;\">&apos;test_day&apos;</span>) period is: </p>
<p>This testing time period is a two-week test utilizing baseline control, starting on the 13th day of the year. </p>
<p>Start Time: Day 13. </p>
<p>End Time: Day 27. </p>
<h4>Energy Pricing</h4>
<p>The <b>Constant Electricity Price</b> (specifier for <span style=\"font-family: Courier New;\">/scenario</span> API is <span style=\"font-family: Courier New;\">&apos;constant&apos;</span>) profile is: </p>
<p>Based on the Schedule R tariff for winter season and summer season first 500 kWh as defined by the utility servicing the assumed location of the test case. It is $0.05461/kWh. For reference, see https://www.xcelenergy.com/company/rates_and_regulations/rates/rate_books in the section on Current Tariffs/Electric Rate Books (PDF). </p>
<p>Specifier for <span style=\"font-family: Courier New;\">/scenario</span> API is <span style=\"font-family: Courier New;\">&apos;constant&apos;</span>. </p>
<p>The <b>Dynamic Electricity Price</b> (specifier for <span style=\"font-family: Courier New;\">/scenario</span> API is <span style=\"font-family: Courier New;\">&apos;dynamic&apos;</span>) profile is: </p>
<p>Based on the Schedule RE-TOU tariff as defined by the utility servicing the assumed location of the test case. For reference, see https://www.xcelenergy.com/company/rates_and_regulations/rates/rate_books in the section on Current Tariffs/Electric Rate Books (PDF). </p>
<ul>
<li>Summer on-peak is $0.13814/kWh. </li>
<li>Summer mid-peak is $0.08420/kWh. </li>
<li>Summer off-peak is $0.04440/kWh. </li>
<li>Winter on-peak is $0.08880/kWh. </li>
<li>Winter mid-peak is $0.05413/kWh. </li>
<li>Winter off-peak is $0.04440/kWh. </li>
<li>The Summer season is June 1 to September 30. </li>
<li>The Winter season is October 1 to May 31. </li>
</ul>
<p><u>The On-Peak Period is</u>: </p>
<ul>
<li>Summer and Winter weekdays except Holidays, between 2:00 p.m. and 6:00 p.m. local time. </li>
</ul>
<p><u>The Mid-Peak Period is</u>: </p>
<ul>
<li>Summer and Winter weekdays except Holidays, between 9:00 a.m. and 2:00 p.m. and between 6:00 p.m. and 9:00 p.m. local time. </li>
<li>Summer and Winter weekends and Holidays, between 9:00 a.m. and 9:00 p.m. local time. </li>
</ul>
<p><u>The Off-Peak Period is</u>: </p>
<ul>
<li>Summer and Winter daily, between 9:00 p.m. and 9:00 a.m. local time. </li>
</ul>
<p>The <b>Highly Dynamic Electricity Price</b> (specifier for <span style=\"font-family: Courier New;\">/scenario</span> API is <span style=\"font-family: Courier New;\">&apos;highly_dynamic&apos;</span>) profile is: </p>
<p>Based on the the day-ahead energy prices (LMP) as determined in the Southwest Power Pool wholesale electricity market for node LAM345 in the year 2018. For reference, see https://marketplace.spp.org/pages/da-lmp-by-location#&percnt;2F2018. </p>
<p>The <b>Gas Price</b> profile is: </p>
<p>Based on the Schedule R tariff for usage price per therm as defined by the utility servicing the assumed location of the test case. It is $0.002878/kWh ($0.0844/therm). For reference, see https://www.xcelenergy.com/company/rates_and_regulations/rates/rate_books in the section on Summary of Gas Rates for 10/1/19. </p>
<h4>Emission Factors</h4>
<p>The <b>Electricity Emissions Factor</b> profile is: </p>
<p>Based on the average electricity generation mix for CO,USA for the year of 2017. It is 0.6618 kgCO2/kWh (1459 lbsCO2/MWh). For reference, see https://www.eia.gov/electricity/state/colorado/. </p>
<p>The <b>Gas Emissions Factor</b> profile is: </p>
<p>Based on the kgCO2 emitted per amount of natural gas burned in terms of energy content. It is 0.18108 kgCO2/kWh (53.07 kgCO2/milBTU). For reference, see https://www.eia.gov/environment/emissions/co2_vol_mass.php. </p>
</html>", revisions="<html>
<ul>
<li>
March 6th, 2025, by Jaap Neven:<br/>
Initial version.
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/582>
BOPTEST issue #582</a>.
</li>
</ul>
</html>"));

end SimpleRC;
