within IDEAS.Templates.Examples;
model ConstantAirFlowRecup
  "Example of model with ventilation system"
  extends Modelica.Icons.Example;
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));

  package Medium = IDEAS.Media.Air "Air medium";

  IDEAS.Templates.Structure.ThreeZone structure(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-80,-40},{-50,-20}})));
  replaceable IDEAS.Templates.Ventilation.ConstantAirFlowRecup constantAirFlowRecup(
    n=2.*structure.VZones)
  constrainedby IDEAS.Templates.Interfaces.BaseClasses.VentilationSystem(
    nZones=3,
    VZones=structure.VZones,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-38,-10},{-2,8}})));
  IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder causalInhomeFeeder
    annotation (Placement(transformation(extent={{16,-10},{36,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    f=50,
    V=230,
    phi=0,
    gamma(fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={58,-30})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{48,-80},{68,-60}})));

equation
  connect(voltageSource.pin_p, ground.pin) annotation (Line(
      points={{58,-40},{58,-60}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(causalInhomeFeeder.pinSingle, voltageSource.pin_n) annotation (Line(
      points={{36,0},{58,0},{58,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(constantAirFlowRecup.plugLoad, causalInhomeFeeder.nodeSingle)
    annotation (Line(
      points={{-2,-1},{0,-1},{0,0},{16,0}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(structure.TSensor, constantAirFlowRecup.TSensor) annotation (Line(
      points={{-49.4,-36},{-42,-36},{-42,-6.4},{-38.36,-6.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(structure.port_b, constantAirFlowRecup.port_a) annotation (Line(
        points={{-67,-20},{-68,-20},{-68,0.8},{-38,0.8}}, color={0,127,255}));
  connect(structure.port_a, constantAirFlowRecup.port_b) annotation (Line(
        points={{-63,-20},{-64,-20},{-64,-2.8},{-38,-2.8}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>
Model demonstrating the use of the ventilation system template.
</p>
</html>",     revisions="<html>
<ul>
<li>
January 23, 2017 by Glenn Reynders:<br/>
Revised implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Templates/Examples/ConstantAirFlowRecup.mos"
        "Simulate and Plot"),
    experiment(
      StopTime=2000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end ConstantAirFlowRecup;
