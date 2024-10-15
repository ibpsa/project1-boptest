within IDEAS.Templates.Interfaces.BaseClasses;
model CausalInhomeFeeder
  "Causal inhome feeder model for a single phase grid connection"

  // Building characteristics  //////////////////////////////////////////////////////////////////////////

  parameter Modelica.SIunits.Length len=10 "Cable length to district feeder";

  // Interfaces  ///////////////////////////////////////////////////////////////////////////////////////

  Modelica.Blocks.Interfaces.RealOutput VGrid
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
    nodeSingle(m=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
    pinSingle annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));

  // Components  ///////////////////////////////////////////////////////////////////////////////////////

  Experimental.Electric.BaseClasses.AC.WattsLaw wattsLaw(numPha=1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Experimental.Electric.Distribution.AC.BaseClasses.BranchLenTyp branch(len=len)
    "Cable to district feeder"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  IDEAS.Experimental.Electric.BaseClasses.AC.PotentialSensor voltageSensor
    "District feeder voltagesensor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,20})));

protected
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    f=50,
    V=230,
    phi=0,
    gamma(fixed=true))
           "Steady building-side 230 V voltage source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-80,-42})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground(pin(
        final reference)) "Grounding for the building-side voltage source"
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p plugToPin_p(
      m=1) "Plug-to-pin conversion" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-22})));


equation
  wattsLaw.P = -Modelica.ComplexMath.real(plugToPin_p.plug_p.pin[1].v*
    Modelica.ComplexMath.conj(plugToPin_p.plug_p.pin[1].i));
  wattsLaw.Q = -Modelica.ComplexMath.imag(plugToPin_p.plug_p.pin[1].v*
    Modelica.ComplexMath.conj(plugToPin_p.plug_p.pin[1].i));

  connect(nodeSingle, plugToPin_p.plug_p) annotation (Line(
      points={{-100,0},{-80,0},{-80,-20},{-80,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource.pin_p, plugToPin_p.pin_p) annotation (Line(
      points={{-80,-34},{-80,-24}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ground.pin, voltageSource.pin_n) annotation (Line(
      points={{-80,-60},{-80,-50}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(wattsLaw.vi[1], voltageSensor.vi) annotation (Line(
      points={{40,0},{50,0},{50,10}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSensor.VGrid, VGrid) annotation (Line(
      points={{50,30.4},{50,40},{106,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wattsLaw.vi[1], branch.pin_p) annotation (Line(
      points={{40,0},{60,0}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(branch.pin_n, pinSingle) annotation (Line(
      points={{80,0},{100,0}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={85,170,255}),
        Rectangle(
          extent={{28,60},{70,20}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-26,54},{-26,20},{-6,20},{-6,28},{4,28},{4,32},{-6,32},{-6,
              44},{8,44},{8,50},{-6,50},{-6,54},{-26,54}},
          lineColor={85,170,255},
          smooth=Smooth.None,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-14,20},{-14,0},{-94,0}},
          color={85,170,255},
          smooth=Smooth.None),
        Rectangle(
          extent={{46,50},{50,42}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{56,34},{60,26}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{38,34},{42,26}},
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{48,20},{48,0},{96,0}},
          color={85,170,255},
          smooth=Smooth.None)}),
    Diagram(graphics),
    Documentation(info="<html>
<p>This gives an in home grid with single phase plugs and single phase grid connection</p>
</html>"));
end CausalInhomeFeeder;
