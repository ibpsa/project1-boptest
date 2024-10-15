within IDEAS.Experimental.HeatTransfer;
model ThermalResistor
  "Lumped thermal element transporting heat without storing it"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Modelica.SIunits.ThermalResistance R
    "Constant thermal resistance of material";

equation
  dT = R*Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}}),     graphics={
        Rectangle(
          extent={{-34,14},{46,-16}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,20},{40,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{40,0},{100,0}}, color={0,0,0}),
        Line(points={{-100,0},{-40,0}}, color={0,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-80,0},{80,0}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-100,-20},{100,-40}},
          lineColor={255,0,0},
          textString="Q_flow"),
        Text(
          extent={{-100,40},{100,20}},
          lineColor={0,0,0},
          textString="dT = port_a.T - port_b.T")}),
    Documentation(info="<HTML>
<p>
This is a model for transport of heat without storing it, same as the
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">ThermalConductor</a>
but using the thermal resistance instead of the thermal conductance as a parameter.
This is advantageous for series connections of ThermalResistors,
especially if it shall be allowed that a ThermalResistance is defined to be zero (i.e. no temperature difference).
</p>
</html>"));
end ThermalResistor;
