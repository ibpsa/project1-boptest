within IDEAS.Fluid.HeatExchangers.Examples.BaseClasses;
model NakedTabs "HeatPort-only tabs system, without embedded pipe"

  replaceable parameter
    IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.RadiantSlabChar
    radSlaCha constrainedby
    IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.RadiantSlabChar;

  parameter Integer n1=radSlaCha.n1;
  parameter Integer n2=radSlaCha.n2;
  parameter Modelica.SIunits.Area A_floor=1 "Floor surface";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_b
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor[n1 + 1] U1(each G=
        radSlaCha.lambda_b/(radSlaCha.S_1/(n1 + 1))*A_floor)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,32})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor[n2 + 1] U2(each G=
        radSlaCha.lambda_b/(radSlaCha.S_2/(n2 + 1))*A_floor)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-22})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor[n1] C1(each C=
        A_floor*radSlaCha.S_1/n1*radSlaCha.rho_b*radSlaCha.c_b, each
      T(fixed=false))
    annotation (Placement(transformation(extent={{32,54},{52,74}})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor[n2] C2(each C=
        A_floor*radSlaCha.S_2/n2*radSlaCha.rho_b*radSlaCha.c_b)
    annotation (Placement(transformation(extent={{30,-62},{50,-42}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portCore
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  for i in 1:n1 loop
    connect(U1[i].port_b, U1[i + 1].port_a);
    connect(U1[i].port_b, C1[i].port);
  end for;
  for i in 1:n2 loop
    connect(U2[i].port_b, U2[i + 1].port_a);
    connect(U2[i].port_b, C2[i].port);
  end for;
  connect(U1[n1 + 1].port_b, port_a);
  connect(U2[n2 + 1].port_b, port_b);
  connect(portCore, U1[1].port_a) annotation (Line(
      points={{-100,0},{-6.12323e-016,0},{-6.12323e-016,22}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(portCore, U2[1].port_a) annotation (Line(
      points={{-100,0},{6.12323e-016,0},{6.12323e-016,-12}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    Documentation(info="<html>
<p><b>Description</b></p>
<p>Discretized heat transfer model of a thermally activated building layer. The model has 3 heatPorts:</p>
<ol>
<li>portCore: port to the <a href=\"modelica://IDEAS.Thermal.Components.Emission.EmbeddedPipe\">embeddedPipe</a> 
model that computes the heat trransfer to the core of the thermally activated layer</li>
<li>port_a: heatPort for heat emission at the upper side of the TABS</li>
<li>port_b: heatPort for heat emission at the lower side of the TABS</li>
</ol>
<h4>Assumptions and limitations </h4>
<ol>
<li>Discretized model in n1 elements between the core and port_a, and n2 layers between core and port_b</li>
<li>No capacity lumped to the core of the thermally activated layer.</li>
</ol>
<h4>Model use</h4>
<ol>
<li>The geometry, material properties and floor surface is obtained from a record, radSlaCha</li>
<li>To control the discretization in more detail, regardless of material properties, n1 and n2 can be specified specifically.</li>
</ol>
<h4>Validation </h4>
<p>This component is validated together with the EmbeddedPipe.  The effect of discretization is shown in<a href=\"modelica://IDEAS.Thermal.Components.Examples.NakedTabsTester\"> IDEAS.Thermal.Components.Examples.NakedTabsTester</a>.</p>
<p>A specific report of this validation can be found in IDEAS/Specifications/Thermal/ValidationEmbeddedPipeModels_20111006.pdf</p>
<h4>Example (optional) </h4>
<p>The <a href=\"modelica://IDEAS.Thermal.Components.Emission.Tabs\">Tabs</a> model shows the integration of an EmbeddedPipe and a NakedTabs.</p>
</html>", revisions="<html>
<ul>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2012 April, Roel De Coninck: rebasing on common Partial_Emission</li>
<li>2011, Roel De Coninck: first version and validation</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-80,60},{80,20}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Forward,
          fillColor={215,215,215}),
        Rectangle(
          extent={{-80,-20},{80,-62}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Forward,
          fillColor={215,215,215}),
        Rectangle(
          extent={{-80,20},{80,-20}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-66,6},{-54,-6}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,6},{-24,-6}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,6},{36,-6}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,6},{66,-6}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{100,60}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end NakedTabs;
