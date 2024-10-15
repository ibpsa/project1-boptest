within IDEAS.Fluid.Interfaces;
connector FlowPort_b "Hollow flow port (used downstream)"

  extends Fluid.Interfaces.FlowPort;
  annotation (
    Documentation(info="<HTML>
Same as FlowPort, but icon allows to differentiate direction of flow.
</HTML>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-50,50},{50,-50}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-48,48},{48,-48}}, lineColor={0,0,255}),
        Text(
          extent={{-100,110},{100,50}},
          lineColor={0,0,255},
          textString="%name")}));
end FlowPort_b;
