within OU44Emulator;
package Documentation "Documentation"
  extends Modelica.Icons.Information;

  annotation (preferredView="info",
  Documentation(info="<html>
<p><b><span style=\"font-size: 10pt;\">Single-zone emulator (SDU)</span></b> </p>
<p><img src=\"modelica://OU44Emulator/Resources/Images/ou44.jpg\" alt=\"OU44 building\"/> </p>
<p><b><span style=\"font-size: 10pt;\">Building Design and Use</span></b> </p>
<p>The overall description of the actual building can be found in the following paper: <a href=\"https://www.sciencedirect.com/science/article/pii/S1876610217347720\">M. Jradi et al., A World Class Energy Efficient University Building by Danish 2020 Standards, Energy Procedia 132 (2017), 21-26.</a> Some of validation reference data are taken from this paper directly.The following documentation contains only information relevant for the simplified model included in BOPTEST. </p>
<p><b>Architecture</b> </p>
<p>The building surface area is 8500 m2. There are 3 above-ground floors containing classrooms (40&percnt; of floor area), study zones (25&percnt;), offices (15&percnt;), and common spaces (20&percnt;). There is also a basement level containing main HVAC facilities and the main heat exchanger connected to district heating. The building can accommodate around 1350 people. </p>
<p><b>Constructions</b> </p>
<p>The building thermal envelope is comprised of three different opaque constructions: ground floor (<span style=\"font-family: Courier New;\">floor</span>), external wall (<span style=\"font-family: Courier New;\">extWall</span>), and roof (<span style=\"font-family: Courier New;\">roof</span>). The internal walls are modeled by a single-layer generic construction representing medium-weight partitions. All opaqua construction layers and thermal characteristics are described in Table 1. All windows are modeled using the same contruction type, based on a triple-glass window model from the <span style=\"font-family: Courier New;\">Buildings</span> library (<span style=\"font-family: Courier New;\">Buildings.HeatTransfer.Data.GlazingSystems.TripleClearAir13ClearAir13Clear</span>), with the following layers: triple pane, clear glass 3mm, air 12.7 mm, clear glass 3mm, air 12.7 mm, clear glass 3mm. </p>
<p><b>Table 1:</b> Opaque constructions and their thermal parameters (x - width [m], k - conductivity [W/(mK)], c - specific heat [J/(kgK)], d - density [g/cm3]) </p>
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
<td><p><br><br><br><br>Insulation</p></td>
<td><p>0.15, 0.04, 1000, 0.05</p></td>
</tr>
<tr>
<td><p><span style=\"font-family: Courier New;\">extWall</span></p></td>
<td><p>Concrete</p></td>
<td><p>0.2, 1.4, 840, 2.24</p></td>
</tr>
<tr>
<td></td>
<td><p><br><br><br><br>Insulation</p></td>
<td><p>0.27, 0.04, 1000, 0.05</p></td>
</tr>
<tr>
<td><p><span style=\"font-family: Courier New;\">roof</span></p></td>
<td><p>Concrete</p></td>
<td><p>0.27, 1.4, 840, 2.24</p></td>
</tr>
<tr>
<td></td>
<td><p><br><br><br><br>Insulation</p></td>
<td><p>0.52, 0.04, 1000, 0.05</p></td>
</tr>
<tr>
<td><p><span style=\"font-family: Courier New;\">intWall</span></p></td>
<td><p>Generic material</p></td>
<td><p>0.15, 0.5, 1000, 0.25</p></td>
</tr>
</table>
<p><br><br><br><br><b>Occupancy schedules and comfort requirements</b> </p>
<p>The building is equiped with camera-based sensors that estimate real-time occupants number. Occupancy data is extracted from our internal database&quot;Volta&quot; and stored in &quot;occ.txt&quot; file in the model. Comfort requirements are defined as indoor thermal comfort (temperature) and CO2 concentratin, temperature setpoint is 21&deg;C, CO2 concentraiton has to be lower than 800ppm. </p>
<p><b>Internal loads and schedules</b> </p>
<p>... </p>
<p><b>Climate</b> </p>
<p>The weather data is based on Copenhagen Typical Meteorological Year. The weather file is located in <span style=\"font-family: Courier New;\">modelica://OU44Emulator/Resources/Weather/DNK_Copenhagen.061800_IWEC.mos</span>. </p>
<p><b><span style=\"font-size: 10pt;\">HVAC System Design</span></b> </p>
<h4>Primary and secondary system designs</h4>
<p>The actual building is equipped with 4 balanced Air Handling Units (AHU) with heat recovery wheels and pre-heating coils (Fig. 1) and each room is equipped with radiator heating. The heating is provided by district heating grid. Since the model is a single-zone model, all AHUs are modeled with a single AHU oversized by a factor of 4, and all radiators are modeled with a single radiator. The following description covers the HVAC design as implemented in the model, and not the HVAC system in the actual building. The AHU contains two identical fans, one for supply air and one for extract air. The nominal air volume flow rate capacity is 140000 m3/h. Both the radiator and the pre-heating coil in the AHU are connected to the main heat exchanger connected to the district heating grid. The water flow to the radiator and AHU&apos;s pre-heating coil is controlled with two 3-way valves. In real building, supply air of ventilation is controlled via adjusting damper position, and temperature of supply air from ventilation has been controlled to be 21<span style=\"font-family: arial,sans-serif; font-size: 7pt; color: #222222; background-color: #ffffff;\">&deg; C.</span></p>
<p><b>Fig. 1:</b> Air Handling Unit diagram with exemplary measurements from the BMS system (screenshot).</p>
<p><img src=\"modelica://OU44Emulator/Resources/Images/bms_ahu.png\" alt=\"AHU\"/> </p>
<p>... </p>
<p><b>Equipment specifications and performance maps</b> </p>
<p>... </p>
<p><b>Rule-based or local-loop controllers</b> </p>
<p>The model implements three PID controllers, one regulates indoor CO2 concentration by controlling supply air in air handling unit. The second controller ensures supply air temperature of ventilation to be consistent with setpoint. The last controller regulates indoor temperature of the zone via controlling radiator power.</p>
<p><b><span style=\"font-size: 10pt;\">Additional System Design</span></b> </p>
<p><b>Lighting</b> </p>
<p>Lighting is not considered in the model.</p>
<p><b>Shading</b> </p>
<p>The model assume there is no shading in the building.</p>
<p><b>Onsite generation and storage</b> </p>
<p>There is no onsite power generation or energy storage in the model. </p>
<p><b><span style=\"font-size: 10pt;\">Points List</span></b> </p>
<p><b>Control input signals, descriptions, and meta-data</b> </p>
<p>... </p>
<p><b>Measurement output signals, descriptions, and meta-data</b> </p>
<p>... </p>
<p><b><span style=\"font-size: 10pt;\">Important Model Implementation Assumption</span></b> </p>
<p>The major assumptions are as follows: </p>
<ul>
<li>Single zone used to model the entire building. </li>
<li>Single Air Handling Unit (AHU) used to model 4 actual AHUs. Fans in the AHU oversized by a factor of 4. </li>
<li>Single radiator representing all radiators in the building. </li>
<li>Constant infiltration rate of 0.2 air changes per hour. </li>
<li>we introduce a scale factor of 2 for occupancy CO2 generation as lumped to one single zone model.</li>
<li>Constant ground temperature 10 degC. </li>
<li>Constant efficiency of heat exchangers. </li>
<li>Internal heat gains (100&percnt;) are divided into radiative (40&percnt;), convective (40&percnt;), and latent gains (20&percnt;). These proportions are constant. </li>
</ul>
<p><br><b><span style=\"font-size: 10pt;\">Scenario Information</span></b> </p>
<p><b>Energy pricing</b> </p>
<p>... </p>
<p><b>Emission factors</b> </p>
<p>... </p>
</html>"));

end Documentation;
