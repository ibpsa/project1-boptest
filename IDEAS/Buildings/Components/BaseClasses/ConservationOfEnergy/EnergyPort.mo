within IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy;
connector EnergyPort "Port for adding up energy"
  flow Modelica.SIunits.Energy E "Energy port";
  Modelica.SIunits.Energy Etot "Energy port";
  annotation (Documentation(info="<html>
<p>
This connector is used to add up all internal energy terms of the model in the SimInfoManager.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end EnergyPort;
