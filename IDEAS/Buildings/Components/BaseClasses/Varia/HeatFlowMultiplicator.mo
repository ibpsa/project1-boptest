within IDEAS.Buildings.Components.BaseClasses.Varia;
model HeatFlowMultiplicator "Component to scale the energy flow of a energyPort"
  parameter Real k = 1 "Multiplication factor for heat flow rate";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Port with unscaled heat flow rate"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Port with scaled heat flow rate"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  port_a.Q_flow * k = - port_b.Q_flow;
  port_a.T = port_b.T;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
          points={{-100,100},{100,-2},{-100,-100},{-100,100}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-78,36},{50,-34}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q_flow x n"),
        Text(
          extent={{-150,-138},{150,-98}},
          lineColor={0,0,0},
          textString="k=%k"),
        Text(
          extent={{-150,142},{150,102}},
          textString="%name",
          lineColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<ul>
<li>
August 10, 2018 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end HeatFlowMultiplicator;
