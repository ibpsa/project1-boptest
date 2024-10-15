within IDEAS.Buildings.Components.BaseClasses.Varia;
model EnergyFlowMultiplicator "Component to scale the energy flow of a energyPort"
  parameter Real k = 1 "Multiplication factor for heat flow";

  ConservationOfEnergy.EnergyPort E_a
    "Unscaled port"
    annotation (Placement(transformation(extent={{-108,-10},{-88,10}})));
  ConservationOfEnergy.EnergyPort E_b
    "Scaled port"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  E_a.E  * k = - E_b.E;
  E_a.Etot = E_b.Etot;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
          points={{-100,100},{100,-2},{-100,-100},{-100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-50,28},{50,-34}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="E x n"),
        Text(
          extent={{-150,-138},{150,-98}},
          lineColor={0,0,0},
          textString="k=%k"),
        Text(
          extent={{-150,142},{150,102}},
          textString="%name",
          lineColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
August 10, 2018 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end EnergyFlowMultiplicator;
