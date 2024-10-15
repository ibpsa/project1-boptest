within IDEAS.Utilities.IO.SignalExchange.SignalTypes;
type SignalsForActuatorTravel = enumeration(
    None
      "Not used for control actuators",
    Damper
      "Damper",
    Valve
      "Valve",
    Fan
      "Fan",
    Pump
      "Pump",
    HVACEquipment
      "HVAC Equipment")
  "Signals used for the calculation of key performance indexes"
  annotation (Documentation(info="<html>
<p>
This enumeration defines the signal types that are used by BOPTEST
to compute the key performance indices (KPI).
</p>
<p>
The following signal types are supported.
</p>
<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><th>Value</th>
    <th>Description</th>
</tr>
<tr><td><code>None</code></td>
    <td>Not used for KPI</td>
</tr>
<tr><td><code>AirZoneTemperature</code></td>
    <td>Air zone temperature</td>
</tr>
<tr><td><code>RadiativeZoneTemperature</code></td>
    <td>Radiative zone temperature</td>
</tr>
<tr><td><code>OperativeZoneTemperature</code></td>
    <td>Operative zone temperature</td>
</tr>
<tr><td><code>RelativeHumidity</code></td>
    <td>Relative humidity</td>
</tr>
<tr><td><code>CO2Concentration</code></td>
    <td>CO<sub>2</sub> concentration</td>
</tr>
<tr><td><code>ElectricPower</code></td>
    <td>Electric power from grid</td>
</tr>
<tr><td><code>DistrictHeatingPower</code></td>
    <td>Thermal power from district heating</td>
</tr>
<tr><td><code>GasPower</code></td>
    <td>Thermal power from natural gas</td>
</tr>
<tr><td><code>BiomassPower</code></td>
    <td>Thermal power from biomass</td>
</tr>
<tr><td><code>SolarThermalPower</code></td>
    <td>Thermal power from solar thermal</td>
</tr>
<tr><td><code>FreshWaterFlowRate</code></td>
    <td>FreshWaterFlowRate</td>
</tr>
</table>
</html>", revisions="<html>
<ul>
<li>
July 17, 2019, by Michael Wetter:<br/>
Added documentation.
</li>
<li>
April 10, 2019, by Javier Arroyo:<br/>
First implementation.
</li>
</ul>
</html>"));
