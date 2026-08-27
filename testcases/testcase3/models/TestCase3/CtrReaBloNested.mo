within TestCase3;
model CtrReaBloNested
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCtr "Input for control"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCO2 "Input for CO2 signal"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2RooAir(
    y(unit="ppm"),
    description=descriptionCO2) "Read the room air CO2 concentration in zone"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  parameter String descriptionCtr="Heater thermal power of north zone"
    "Description of the signal being overwritten";
  parameter String descriptionCO2="Zone air CO2 concentration of north zone"
    "Description of the signal being read";
  Buildings.Utilities.IO.SignalExchange.Overwrite oveActGenDes(u(
      unit="W",
      min=-10000,
      max=10000), description="Overwrite the heating power of zone")
    "Overwrite the heating power of zone"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveAct(u(
      unit="W",
      min=-10000,
      max=10000), description=descriptionCtr)
    "Overwrite the heating power of zone"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
equation
  connect(uCO2, CO2RooAir.u)
    annotation (Line(points={{-120,-40},{-22,-40}}, color={0,0,127}));
  connect(uCtr, oveAct.u)
    annotation (Line(points={{-120,10},{-22,10}}, color={0,0,127}));
  connect(uCtr, oveActGenDes.u) annotation (Line(points={{-120,10},{-40,10},{-40,
          50},{-22,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This model is a test fixture used to validate the BOPTEST Modelica parser's
ability to flatten signal exchange blocks that are nested inside a submodel,
rather than declared directly at the top level of a test case.
</p>
<p>
The model contains one <a href=\"modelica://Buildings.Utilities.IO.SignalExchange.Read\">
Buildings.Utilities.IO.SignalExchange.Read</a> block (<code>CO2RooAir</code>) and
two <a href=\"modelica://Buildings.Utilities.IO.SignalExchange.Overwrite\">
Buildings.Utilities.IO.SignalExchange.Overwrite</a> blocks (<code>oveAct</code> and
<code>oveActGenDes</code>), each exercising a different way of setting the
signal exchange block's <code>description</code> parameter:
</p>
<ul>
<li>
<code>oveAct</code> takes its <code>description</code> from the model
parameter <code>descriptionCtr</code>, which is propagated from the
enclosing model. This tests parsing of a description that is set through
a parameter binding rather than a literal string.
</li>
<li>
<code>oveActGenDes</code> uses a fixed, literal <code>description</code>
string (\"Overwrite the heating power of zone\") that is identical
regardless of how many instances of this model are created. This tests
parsing of signal exchange blocks whose description does not vary across
array elements of the enclosing array of submodels.
</li>
<li>
<code>CO2RooAir</code> takes its <code>description</code> from the model parameter <code>descriptionCO2</code>
, mirroring the same parameter-binding pattern as <code>oveAct</code> but for a <a href=\"modelica://Buildings.Utilities.IO.SignalExchange.Read\">
Buildings.Utilities.IO.SignalExchange.Read</a> block.
</li>
</ul>
<p>
This model is intended to be instantiated as an array (e.g.
<code>ctrReaBloNested[n]</code>) inside another model such
as <a href=\"modelica://TestCase3.CtrReaBlo\">
TestCase3.CtrReaBlo</a>, so that the signal exchange blocks it contains
are exposed in the compiled FMU as flattened array-indexed variables, e.g.
<code>ctrReaBloNested[1].oveAct.u</code>,
<code>ctrReaBloNested[2].oveActGenDes.u</code>,
<code>ctrReaBloNested[1].CO2RooAir.y</code>. When further nested inside an
array of the enclosing model, this produces two levels of array indexing
along a single signal exchange block's instance path (e.g.
<code>ctrReaBlo[i].ctrReaBloNested[j].oveAct.u</code>), which is used to
test multi-level array flattening in the BOPTEST parser.
</p>
</html>"));
end CtrReaBloNested;
