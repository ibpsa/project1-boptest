within TestCase3;
model CtrReaBlo
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCtr[2] "Input for control"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCO2[2] "Input for CO2 signal"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveAct[2](u(
      each unit="W",
      min={-10000, -5000},
      max={10000, 5000}), description=descriptionCtr)
    "Overwrite the heating power of zone"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2RooAir[2](
    y(unit="ppm"),
    description=descriptionCO2) "Read the room air CO2 concentration in zone"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  parameter String descriptionCtr[2]={"Heater thermal power of zone","Heater thermal power of zone"}
    "Description of the signal being overwritten";
  parameter String descriptionCO2[2]={"Zone air CO2 concentration","Zone air CO2 concentration"}
    "Description of the signal being read";
  CtrReaBloNested ctrReaBloNested[2](
    descriptionCtr=descriptionCtr,
    descriptionCO2=descriptionCO2)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(uCtr, oveAct.u) annotation (Line(points={{-120,10},{-32,10},{-32,70},{
          -22,70}}, color={0,0,127}));
  connect(uCO2, CO2RooAir.u)
    annotation (Line(points={{-120,-40},{-30,-40},{-30,30},{-22,30}},
                                                    color={0,0,127}));
  connect(uCtr, ctrReaBloNested.uCtr) annotation (Line(points={{-120,10},{-32,10},
          {-32,-66},{-22,-66}}, color={0,0,127}));
  connect(uCO2, ctrReaBloNested.uCO2) annotation (Line(points={{-120,-40},{-40,-40},
          {-40,-74},{-22,-74}}, color={0,0,127}));
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
ability to flatten arrays of signal exchange blocks, as well as arrays of
submodels that themselves contain signal exchange blocks, including the
combination of both patterns nested within a single model.
</p>
<p>
The model contains:
</p>
<ul>
<li>
An array of two <a href=\"modelica://Buildings.Utilities.IO.SignalExchange.Overwrite\">
Buildings.Utilities.IO.SignalExchange.Overwrite</a> blocks (<code>oveAct[2]</code>),
where <code>unit</code> is set identically for both elements using
<code>each</code>, while <code>min</code>, <code>max</code>, and
<code>description</code> are set using explicit per-element array
literals/parameters. This tests parsing of a top-level array of
<a href=\"modelica://Buildings.Utilities.IO.SignalExchange.Overwrite\">
Buildings.Utilities.IO.SignalExchange.Overwrite</a> blocks whose bounds differ between array elements.
</li>
<li>
An array of two <a href=\"modelica://Buildings.Utilities.IO.SignalExchange.Read\">
Buildings.Utilities.IO.SignalExchange.Read</a> blocks (<code>CO2RooAir[2]</code>),
with <code>unit</code> and <code>KPIs</code> set using <code>each</code>,
and <code>description</code> set per element via
parameter. This tests parsing of a top-level array of <a href=\"modelica://Buildings.Utilities.IO.SignalExchange.Read\">
Buildings.Utilities.IO.SignalExchange.Read</a> blocks.
</li>
<li>
An array of two instances of the <a href=\"modelica://TestCase3.CtrReaBloNested\">
TestCase3.CtrReaBloNested</a> submodel
(<code>ctrReaBloNested[2]</code>), each of which itself contains a
<code>Read</code> block and two <code>Overwrite</code> blocks. This tests
parsing of signal exchange blocks nested one level below an array of
submodels, e.g. <code>ctrReaBloNested[1].oveAct.u</code>.
</li>
</ul>
<p>
This model is intended to be instantiated as an array (e.g.
<code>CtrReaBlo ctrReaBlo[n]</code>) inside a top-level test case model,
so that all of the signal exchange blocks it contains are further indexed
by an additional array dimension. This produces signal exchange block
instance paths with two levels of array indices (e.g.
<code>ctrReaBlo[i].oveAct[j].u</code>) and, through the nested
<code>ctrReaBloNested</code> array, instance paths combining array indices
at two separate levels of model nesting (e.g.
<code>ctrReaBlo[i].ctrReaBloNested[j].oveAct.u</code>). Together with
<code>CtrReaBloNested</code>, this model is used to exercise the BOPTEST
parser's handling of arbitrarily nested and dimensioned arrays of signal
exchange block instances.
</p>
</html>"));
end CtrReaBlo;
