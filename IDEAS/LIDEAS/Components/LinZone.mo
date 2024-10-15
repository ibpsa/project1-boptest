within IDEAS.LIDEAS.Components;
model LinZone "Linearisable zone model"
  extends IDEAS.Buildings.Components.Zone(
    redeclare IDEAS.Buildings.Components.ZoneAirModels.WellMixedAir
      airModel(stateSelectTVol=StateSelect.prefer),
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow);
  parameter Boolean linearise=sim.linearise
    "Linearise model equations";

equation
  assert(Medium.nX ==1,
    "LinZone model does not allow moist air or air with CO2 medium. 
    Use the IDEAS.Media.Specialized.DryAir medium.");
  annotation (Documentation(info="<html>
<p>
Extension of 
<a href=\"IDEAS.Buildings.Components.Zone\">
IDEAS.Buildings.Components.Zone</a> that supports zone linearisation.
The model is therefore configured to used the well-mixed air model with the temperature as preferred state of the
mixing volume and using 
<a href=\"IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure\">
IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure</a> for the air infiltration.
</p>
<p>
An assert statement is added to ensure that the user only uses the medium <code>IDEAS.Media.Specialized.DryAir</code> since
the linearization does not support other type of media.
</p>
</html>", revisions="<html>
<ul>
<li>August 21, 2018 by Damien Picard: <br/>Remove custom air model and use 
<code>IDEAS.Buildings.Components.ZoneAirModels.WellMixedAir</code> with correct
parametrization instead.</li>
</ul>
</html>"));
end LinZone;
