within OU44Emulator;
package Documentation "Documentation"
  extends Modelica.Icons.Information;

  annotation (preferredView="info",
  Documentation(info="<html>
<p><b><span style=\"font-size: 10pt;\">Single-zone emulator (SDU)</span></b> </p>
<p><b><span style=\"font-size: 10pt;\">Gereral model description</span></b></p>
<p><br><img src=\"modelica://OU44Emulator/Resources/Images/ou44.jpg\" alt=\"OU44 building\"/> </p>
<p><b><span style=\"font-size: 10pt;\">Building Design and Use</span></b> </p>
<p>The overall description of the actual building can be found in the following paper: <a href=\"https://www.sciencedirect.com/science/article/pii/S1876610217347720\">M. Jradi et al., A World Class Energy Efficient University Building by Danish 2020 Standards, Energy Procedia 132 (2017), 21-26.</a> Some of validation reference data are taken from this paper directly. The following documentation contains only information relevant for the simplified model included in BOPTEST. </p>
<p><b>Architecture</b> </p>
<p>The building surface area is 8500 m2. There are 3 above-ground floors containing classrooms (40&percnt; of floor area), study zones (25&percnt;), offices (15&percnt;), and common spaces (20&percnt;). There is also a basement level containing main HVAC facilities and the main heat exchanger connected to district heating. The building can accommodate around 1350 people. </p>
<p><b>Constructions</b> </p>
<p>The building thermal envelope is comprised of three different opaque constructions: ground floor (<span style=\"font-family: Courier New;\">floor</span>), external wall (<span style=\"font-family: Courier New;\">extWall</span>), and roof (<span style=\"font-family: Courier New;\">roof</span>). The internal walls are modeled by a single-layer generic construction representing medium-weight partitions. All opaqua construction layers and thermal characteristics are described in Table 1. All windows are modeled using the same contruction type, based on a triple-glass window model from the <span style=\"font-family: Courier New;\">Buildings</span> library (<span style=\"font-family: Courier New;\">Buildings.HeatTransfer.Data.GlazingSystems.TripleClearAir13ClearAir13Clear</span>), with the following layers: triple pane, clear glass 3mm, air 12.7 mm, clear glass 3mm, air 12.7 mm, clear glass 3mm. </p>
<p><b>Table 1:</b> Opaque constructions and their thermal parameters (x - width [m], k - conductivity [W/(mK)], c - specific heat [J/(kgK)], d - density [g/cm3])</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Construction</h4></p></td>
<td><p align=\"center\"><h4>Layers</h4></p></td>
<td><p align=\"center\"><h4>Parameters (x, k, c, d)</h4></p></td>
</tr>
<tr>
<td><p><span style=\"font-family: Courier New;\">floor</span></p></td>
<td><p>Concrete</p></td>
<td><p>0.2, 1.4, 840, 2.24</p></td>
</tr>
<tr>
<td></td>
<td><p><br>Insulation</p></td>
<td><p>0.15, 0.04, 1000, 0.05</p></td>
</tr>
<tr>
<td><p><span style=\"font-family: Courier New;\">extWall</span></p></td>
<td><p>Concrete</p></td>
<td><p>0.2, 1.4, 840, 2.24</p></td>
</tr>
<tr>
<td></td>
<td><p><br>Insulation</p></td>
<td><p>0.27, 0.04, 1000, 0.05</p></td>
</tr>
<tr>
<td><p><span style=\"font-family: Courier New;\">roof</span></p></td>
<td><p>Concrete</p></td>
<td><p>0.27, 1.4, 840, 2.24</p></td>
</tr>
<tr>
<td></td>
<td><p><br>Insulation</p></td>
<td><p>0.52, 0.04, 1000, 0.05</p></td>
</tr>
<tr>
<td><p><span style=\"font-family: Courier New;\">intWall</span></p></td>
<td><p>Generic material</p></td>
<td><p>0.15, 0.5, 1000, 0.25</p></td>
</tr>
</table>
<p><br><br><br><br><b>Occupancy schedules and comfort requirements</b> </p>
<p>The building is equiped with camera-based sensors that estimate real-time occupants number. Occupancy data is extracted from our internal database&quot;Volta&quot; and stored in &quot;occ.txt&quot; file in the model. Comfort requirements are defined as indoor thermal comfort (temperature) and CO2 concentration, temperature setpoint is 21&deg;C, CO2 concentration has to be lower than 800ppm. </p>
<p><b>Internal loads and schedules</b> </p>
<p>Internal heat gains only consider heat from occupancy. It is assumed that the internal gain per person is 120W and it is evenly distributed over the floor area (i.e. 120 W / 8500 m2). The heat generated per occupant is divided as 40&percnt; radiant, 40&percnt; convective and 20&percnt; latent heat.</p>
<p><br><b>Climate</b> <b>data</b></p>
<p>The weather data is based on Copenhagen Typical Meteorological Year. The weather file is located in <span style=\"font-family: Courier New;\">modelica://OU44Emulator/Resources/Weather/DNK_Copenhagen.061800_IWEC.mos</span>. </p>
<p><b><span style=\"font-size: 10pt;\">HVAC System Design</span></b> </p>
<h4>Primary and secondary system designs</h4>
<p>The actual building is equipped with 4 balanced Air Handling Units (AHU) with heat recovery wheels and pre-heating coils (Fig. 1) and each room is equipped with radiator heating. The heating is provided by district heating grid. Since the model is a single-zone model, all AHUs are modeled with a single AHU oversized by a factor of 4, and all radiators are modeled with a single radiator. The following description covers the HVAC design as implemented in the model, and not the HVAC system in the actual building. The AHU contains two identical fans, one for supply air and one for extract air. The nominal air volume flow rate capacity is 140000 m3/h. Both the radiator and the pre-heating coil in the AHU are connected to the main heat exchanger connected to the district heating grid. The water flow to the radiator and AHU&apos;s pre-heating coil is controlled with two 3-way valves. In real building, supply air of ventilation is controlled via adjusting damper position, and temperature of supply air from ventilation has been controlled to be 21<span style=\"font-family: arial,sans-serif; font-size: 7pt; color: #222222; background-color: #ffffff;\">&deg; C.</span></p>
<p><b>Fig. 1:</b> Air Handling Unit diagram with exemplary measurements from the BMS system (screenshot).</p>
<p><img src=\"modelica://OU44Emulator/Resources/Images/bms_ahu.png\" alt=\"AHU\"/> </p>
<p><br><b>Rule-based or local-loop controllers</b> </p>
<p>The model implements three PID controllers, one regulates indoor CO2 concentration by controlling supply air in air handling unit. The second controller ensures supply air temperature of ventilation to be consistent with setpoint. The last controller regulates indoor temperature of the zone via controlling radiator power.</p>
<p><br><b><span style=\"font-size: 10pt;\">Model IO&apos;s</span></b></p>
<h4>Inputs</h4>
<p>The model inputs are</p>
<ul>
<li>
<code>ahu_oveFanRet_u</code> [1] [min=0.0, max=1.0]: AHU return fan speed control signal
</li>
<li>
<code>ahu_oveFanSup_u</code> [1] [min=0.0, max=1.0]: AHU supply fan speed control signal
</li>
<li>
<code>oveCO2ZonSet_u</code> [ppm] [min=400.0, max=1000.0]: Zone CO2 concentration setpoint
</li>
<li>
<code>ovePum_u</code> [1] [min=0.0, max=1.0]: Pump speed control signal for heating distribution system
</li>
<li>
<code>oveTSupSet_u</code> [K] [min=288.15, max=313.15]: AHU supply air temperature set point for heating
</li>
<li>
<code>oveTZonSet_u</code> [K] [min=283.15, max=303.15]: Zone temperature set point for heating
</li>
</ul>
<h4>Outputs</h4>
<p>The model outputs are</p>
<ul>
<li>
<code>ahu_reaFloSupAir_y</code> [kg/s] [min=None, max=None]: AHU supply air mass flowrate
</li>
<li>
<code>ahu_reaPFanRet_y</code> [W] [min=None, max=None]: AHU return fan electrical power consumption
</li>
<li>
<code>ahu_reaPFanSup_y</code> [W] [min=None, max=None]: AHU supply fan electrical power consumption
</li>
<li>
<code>ahu_reaTRetAir_y</code> [K] [min=None, max=None]: AHU return air temperature
</li>
<li>
<code>ahu_reaTSupAir_y</code> [K] [min=None, max=None]: AHU supply air temperature
</li>
<li>
<code>reaCO2Zon_y</code> [ppm] [min=None, max=None]: Zone CO2 concentration
</li>
<li>
<code>reaPEle_y</code> [W] [min=None, max=None]: Electrical power consumption for AHU fans and heating system pump
</li>
<li>
<code>reaPFan_y</code> [W] [min=None, max=None]: Electrical power consumption of AHU supply and return fans
</li>
<li>
<code>reaPPum_y</code> [W] [min=None, max=None]: Electrical power consumption of pump
</li>
<li>
<code>reaQHea_y</code> [W] [min=None, max=None]: District heating thermal power consumption
</li>
<li>
<code>reaTSupSet_y</code> [K] [min=None, max=None]: AHU supply air temperature setpoint for heating
</li>
<li>
<code>reaTZonSet_y</code> [K] [min=None, max=None]: Zone temperature set point for heating
</li>
<li>
<code>reaTZon_y</code> [K] [min=None, max=None]: Zone air temperature
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
<p><br><b><span style=\"font-size: 10pt;\">Additional System Design</span></b> </p>
<p><b>Lighting</b> </p>
<p>Lighting is not considered in the model.</p>
<p><b>Shading</b> </p>
<p>The model assume there is no shading in the building.</p>
<p><b>Onsite generation and storage</b> </p>
<p>There is no onsite power generation or energy storage in the model. </p>
<p><br><b><span style=\"font-size: 10pt;\">Model Implementation Details</span></b></p>
<h4>Moist vs .dry air</h4>
<p><span style=\"font-family: Arial,sans-serif; font-size: 9pt;\">The model uses moist air despite that no condensation is modelled in any of the used components.</span></p>
<h4>Pressure-flow models</h4>
<p><span style=\"font-family: Arial,sans-serif; font-size: 9pt;\">A circulation hot water loop is used to model the heating emission system.</span></p>
<h4>Infiltration models</h4>
<p><br>Inflitration is modeled with a fixed ach parameter (0.2).</p>
<h4>CO2 models</h4>
<p><br>CO2 concentration of the zone is included in the model.</p>
<p><b><span style=\"font-size: 10pt;\">Important Model Implementation Assumption</span></b> </p>
<p>The major assumptions are as follows: </p>
<ul>
<li>Single zone used to model the entire building. </li>
<li>Single Air Handling Unit (AHU) used to model 4 actual AHUs. Fans in the AHU oversized by a factor of 4. </li>
<li>Single radiator representing all radiators in the building. </li>
<li>Constant infiltration rate of 0.2 air changes per hour. </li>
<li>we introduce a scale factor of 4 for occupancy CO2 generation as lumped to one single zone model.</li>
<li>Constant ground temperature 10 degC. </li>
<li>Constant efficiency of heat exchangers. </li>
<li>Internal heat gains (100&percnt;) are divided into radiative (40&percnt;), convective (40&percnt;), and latent gains (20&percnt;). These proportions are constant. </li>
</ul>
<p><br><b><span style=\"font-size: 10pt;\">Scenario Information</span></b> </p>
<p><b>Energy pricing</b> </p>
<p>Energy Price consists of electric power price and district heating price.</p>
<p>Electric power price:</p>
<ul>
<li>constant price is <span style=\"font-family: Consolas,Courier New,monospace;\">obtained&nbsp;from&nbsp;Nordpool&nbsp;DK1:&nbsp;average&nbsp;value for&nbsp;Feb,&nbsp;2019, source: https://www.nordpoolgroup.com/Market-data1/Dayahead/Area-Prices/DK/Yearly/?view=table</span></li>
<li>dynamic price is obtained from <span style=\"font-family: Consolas,Courier New,monospace;\">from&nbsp;Nordpool&nbsp;DK1:&nbsp;12&nbsp;Feb,&nbsp;2019,&nbsp;using peak&nbsp;and&nbsp;off&nbsp;peak&nbsp;price&nbsp;of&nbsp;the&nbsp;selected&nbsp;day, source: https://www.nordpoolgroup.com/Market-data1/Dayahead/Area-Prices/DK/Hourly/?view=table</span></li>
<li>highly dynamic price is obtained from <span style=\"font-family: Consolas,Courier New,monospace;\">&nbsp;Nord&nbsp;pool&nbsp;DK1:&nbsp;day-ahead&nbsp;price,&nbsp;using hourly&nbsp;price&nbsp;on&nbsp;12&nbsp;Feb,&nbsp;2019, source:https://www.nordpoolgroup.com/Market-data1/Dayahead/Area-Prices/DK/Hourly/?view=chart </span><br></li>
</ul>
<p>Distric heating price=<span style=\"font-family: Consolas,Courier New,monospace;\">0.0828&nbsp;euro/kWh,source:https://www.c40.org/case_studies/98-of-copenhagen-city-heating-supplied-by-waste-heat</span></p>
<h4>Emission factors</h4>
<p align=\"justify\">Two emission factors are considered based on Danish scenario:</p>
<ul>
<li>emission factor for district heating=0.1163 kg CO2e/kWh, source from: https://www.banktrack.org/download/carbon_accounting_report_2018/dnb_asa_carbon_footprint_report_2018.pdf</li>
<li>emission factor for electric power=0.2090 kg CO2e/kWh, source from: https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf</li>
</ul>
</html>"),
    experiment(StopTime=2678400));

end Documentation;
