within IDEAS.Experimental.Electric.Batteries;
package UsersGuide "User's Guide"
extends Modelica.Icons.Information;


annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>
The Battery Package implements everything that 
has to do with a battery system itself.
</p>
<p>
The possibility exist to charge and discharge the batteries 
according to a certain strategy (to define) 
<a href=\"modelica://IDEAS.Electric.Battery.BatterySystemGeneral\">BatterySystemGeneral</a>.
</p>
<p>
The battery is modeled on system level. 
The SoC (State of Charge) of the battery is calculated with the energy flows. 
The models are:
</p>
<ol>
<li>Battery: Calculation of SoC.</li>
<li>BatteryCtrlGeneral: Depending on the current SoC of the battery system, it may be required to limit the power exchange.</li>
<li>BatterySystemGeneral: Total battery system with connection possibilities to the grid.</li>
</ol>
<p>
The following battery parameters are included:
</p>
<ol>
<li>Inverter efficienties: charging and discharging (grid <-> inverter)</li>
<li>Battery efficiencies: charging and discharging (invertor <-> battery)</li>
<li>Self-discharge: %/month</li>
<li>Ratio of maximum (dis)charging powers vs. nominal battery capacity</li>
</ol>
</html>"));
end UsersGuide;
