within IDEAS.Controls.ControlHeating;
model Ctrl_Heating_TES
  "Heating curve control for heating based on a water storage tank"
  extends Interfaces.Partial_Ctrl_Heating_TES;

equation
  TTopSet = max(TDHWSet, heatingCurve.TSup) + dTSafetyTop;
  TBotSet = max(TDHWSet, heatingCurve.TSup) + dTSafetyBot;
  THPSet = TTopSet + dTHPTankSet;

  if noEvent(TTankTop < TTopSet and TTankBot < (TBotSet - dTSafetyBot)) then
    // top too cold, system MUST be on except if bottom is still very hot (temp inversion?)
    onOff = 1;
  elseif noEvent(TTankBot < TBotSet and onOff > 0.5) then
    // HP running, top is fine, bottom too cold: keep running
    onOff = 1;
  else
    // all other cases: shut down
    onOff = 0;
  end if;

  annotation (Diagram(graphics), Documentation(info="<html>
<p><b>Description</b> </p>
<p>Heating curve based control of a heater + TES charging control. The set point temperature for the heater is higher than the heating curve output in order to make sure that the heating curve temperature is met also when thermal losses are present in the circuit. The heater set temperature is the maximum of the requirements for space heating and DHW: if tank charging is occurring, the DHW temperature requirements will normally be higher than for space heating. </p>
<p>This controller tries to limit and even avoid the creating of events.</p>
<h4>Model use</h4>
<ol>
<li>Use this controller in a heating system with a TES tank where you want to follow a heating curve for space heating.</li>
</ol>
<h4>Validation </h4>
<p>No validation performed.</p>
<h4>Example </h4>
<p>This controller is not used in any of the preconfigured heating systems. </p>
</html>", revisions="<html>
<ul>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011, Roel De Coninck: first version and validation</li>
</ul>
</html>"));
end Ctrl_Heating_TES;
