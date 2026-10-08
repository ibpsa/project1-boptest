within TestCase3;
model CtrReaBloNested
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCtr "Input for control"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  parameter String descriptionCtr="Heater thermal power of north zone"
    "Description of the signal being overwritten";
  parameter Real Pnom = 10000 "HVAC nominal power";
  Buildings.Utilities.IO.SignalExchange.Overwrite oveAct(u(
      unit="W",
      min=-Pnom,
      max=Pnom), description=descriptionCtr)
    "Overwrite the heating power of zone"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Interfaces.RealOutput yCtr(unit="W") "Control output"
    annotation (Placement(transformation(extent={{100,0},{120,20}}),
        iconTransformation(extent={{100,-10},{120,10}})));
equation
  connect(uCtr, oveAct.u)
    annotation (Line(points={{-120,10},{-22,10}}, color={0,0,127}));
  connect(oveAct.y, yCtr)
    annotation (Line(points={{1,10},{110,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-156,140},{144,100}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This submodel passes a control signal through one
<a href=\\\"modelica://Buildings.Utilities.IO.SignalExchange.Overwrite\\\">
Buildings.Utilities.IO.SignalExchange.Overwrite</a> block,
<code>oveAct</code>, to its output <code>yCtr</code>.
The block's input has unit W and bounds of -10000 W and 10000 W.
Its <code>description</code> is bound to the model parameter
<code>descriptionCtr</code>.
</p>
<p>
When this submodel is instantiated as an array, each element contains
its own overwrite block. For example, an instance in
<code>CtrReaBlo</code> has a path such as
<code>ctrReaBloNested[1].oveAct</code>. This tests parsing of
signal-exchange blocks inside an array of submodels.
</p>
</html>", revisions="<html>
<li>
October 6th, 2026, by Ettore Zanetti:<br/>
Update test case to demonstrate array use
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/190>
BOPTEST issue #190</a>.
</li>
</html>"));
end CtrReaBloNested;
