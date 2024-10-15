within IDEAS.Controls.ControlHeating;
model Ctrl_SolarThermal_Simple
  "Basic solar thermal controller based on temperature differences only."
  extends Interfaces.Partial_Ctrl_SolarThermal;

equation
  if noEvent(TCollector > (TTankBot + dTStart) and TSafety < TSafetyMax) then
    // collector hot enough.  System MUST be on except if safety issues.
    onOff = 1;
  elseif noEvent(TCollector > (TTankBot + dTStop) and TSafety < TSafetyMax and
      onOff > 0.5) then
    // system is running, everything is fine: keep running
    onOff = 1;
  else
    // all other cases: shut down
    onOff = 0;
  end if;

  annotation (Documentation(info="<html>
<p><b>Description</b> </p>
<p>Controller for solar thermal primary circuit. The controller is based on the temperature difference between solar collector and an input (usually bottom of storage tank).  When a safety temperature is exceeded (separate input), the system will go off. </p>
<h4>Assumptions and limitations </h4>
<ol>
<li>Simple temperature based control.</li>
</ol>
<h4>Model use</h4>
<ol>
<li>Connect the controller to collector and storage tank and the output to the pump</li>
<li>Configure the temperature set points.</li>
</ol>
<h4>Validation</h4>
<p>No validation performed.</p>
<h4>Example </h4>
<p>
An example of the use of this model is given in 
<a href=\"modelica://IDEAS.Thermal.Components.Production.SolarThermalSystem_Simple\">IDEAS.Thermal.Components.Production.SolarThermalSystem_Simple</a>.
</p>
</html>", revisions="<html>
<ul>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011, Roel De Coninck: first version and validation</li>
</ul>
</html>"));
end Ctrl_SolarThermal_Simple;
