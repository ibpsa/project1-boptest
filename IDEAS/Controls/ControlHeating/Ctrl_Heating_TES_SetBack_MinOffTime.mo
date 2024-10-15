within IDEAS.Controls.ControlHeating;
model Ctrl_Heating_TES_SetBack_MinOffTime
  "Heating curve control for heating based on a water storage tank, temperature set back + minimum off-time"
  extends Interfaces.Partial_Ctrl_Heating_TES;

  parameter Modelica.SIunits.Time timeOff=60*15;
  Real debug(start=-1);
  Real smoothed;

  Modelica.Blocks.Sources.CombiTimeTable daytime(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0, 0; 43200, 0; 43200, 1; 68400, 1; 68400, 0; 86400, 0])
    "Defines daytime, means period where storage tank can be charged"
    annotation (Placement(transformation(extent={{-64,-6},{-44,14}})));
  // this timer gives 0 during timing and 1 outside of timing
  IDEAS.BaseClasses.Control.Timer_NoEvents timerOff(duration=timeOff)
    annotation (Placement(transformation(extent={{-62,-42},{-42,-22}})));
equation
  smoothed = smooth(1, timerOff.y);
  TTopSet = max(TDHWSet, heatingCurve.TSup) + dTSafetyTop + smooth(1, daytime.y[
    1])*5;
  TBotSet = max(TDHWSet, heatingCurve.TSup) + dTSafetyBot + smooth(1, daytime.y[
    1])*5;
  THPSet = TTopSet + dTHPTankSet;

  if noEvent(smooth(2, timerOff.y) > 0.5) then
    // with noEvent it is NOT possible to run this model:
    // Error: Cannot reduce the DAE index and select states.
    if noEvent(TTankTop < TTopSet and TTankBot < (TBotSet - dTSafetyBot)) then
      // top too cold, off-time passed: system MUST be on except if bottom is still very hot (temp inversion?)
      onOff = 1;
      debug = 1;
    elseif noEvent(TTankBot < TBotSet and onOff > 0.5) then
      // HP running, top is fine, bottom too cold: keep running
      onOff = 1;
      debug = 2;
    else
      // all other cases: shut down
      onOff = 0;
      debug = 3;
    end if;
  else
    onOff = 0;
    debug = 4;
  end if;

algorithm
  timerOff.u := onOff;

  annotation (Documentation(info="<html>
<p><b>Description</b> </p>
<p>Heating curve based control of a heater + TES charging control with time based temperauture increase of decrease of the TES tank and (experimental) minimum off-time for the heater. The set point temperature for the heater is higher than the heating curve output in order to make sure that the heating curve temperature is met also when thermal losses are present in the circuit. The heater set temperature is the maximum of the requirements for space heating and DHW: if tank charging is occurring, the DHW temperature requirements will normally be higher than for space heating. </p>
<p>This controller tries to limit and even avoid the creating of events.</p>
<h4>Model use</h4>
<ol>
<li>Use this controller in a heating system with a TES tank where you want to follow a heating curve for space heating and where you have a time based temperauture increase of decrease of the TES tank.</li>
</ol>
<h4>Validation </h4>
<p>No validation performed.  The minimum off-time featuer is not validated.</p>
<h4>Example </h4>
<p>This controller is not used in any of the preconfigured heating systems. </p>
</html>", revisions="<html>
<ul>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011, Roel De Coninck: first version and validation</li>
</ul>
</html>"));
end Ctrl_Heating_TES_SetBack_MinOffTime;
