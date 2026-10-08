within TestCase3;
model CtrReaBlo
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCtr[2] "Input for control"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  parameter String descriptionCtr[2]={"Heater thermal power of zone","Heater thermal power of zone"}
    "Description of the signal being overwritten";
  parameter Real Pnom[2]={10000,10000} "HVAC nominal power";
  CtrReaBloNested ctrReaBloNested[2](descriptionCtr={"Heater thermal power of zone","Heater thermal power of zone"},
      Pnom=Pnom)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput yCtr[2](each unit="W") "Control output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

equation
  connect(uCtr, ctrReaBloNested.uCtr)
    annotation (Line(points={{-120,0},{-12,0}}, color={0,0,127}));
  connect(ctrReaBloNested.yCtr, yCtr)
    annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-154,138},{146,98}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This model connects its two-element control input array
<code>uCtr[2]</code> to an array of two
<a href=\\\"modelica://TestCase3.CtrReaBloNested\\\">
TestCase3.CtrReaBloNested</a> submodels,
<code>ctrReaBloNested[2]</code>, and connects their outputs to
<code>yCtr[2]</code>. Each nested submodel contains one
<a href=\\\"modelica://Buildings.Utilities.IO.SignalExchange.Overwrite\\\">
Buildings.Utilities.IO.SignalExchange.Overwrite</a> block named
<code>oveAct</code>. This model does not directly instantiate any
signal-exchange blocks.
</p>
<p>
When <code>CtrReaBlo</code> is itself instantiated as an array,
the overwrite blocks have paths with two array indices, such as
<code>ctrReaBlo[1].ctrReaBloNested[2].oveAct</code>.
This tests parsing of overwrite blocks reached through nested arrays
of submodels.
</p>
</html>", revisions="<html>
<li>
October 6th, 2026, by Ettore Zanetti:<br/>
Update test case to demonstrate array use
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/190>
BOPTEST issue #190</a>.
</li>
</html>"));
end CtrReaBlo;
