within BuildingControlEmulator.Devices.AirSide.Coil.Control.Examples;
model OnOffSta
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  BuildingControlEmulator.Devices.AirSide.Coil.Control.OnOffSta
                                                        onOffSta(
    minOffTim=300,
    minOnTim=300,
    OffTim(fixed=true),
    OnTim(fixed=true),
    dT=0.5) annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startValue=false, startTime=1
        *86400/2)
             annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Sine sine(f=1/86400)
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(booleanStep.y, onOffSta.OnSigIn) annotation (Line(
      points={{-79,60},{-40,60},{-40,6},{-14,6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(sine.y, onOffSta.Mea) annotation (Line(
      points={{-79,-60},{-60,-60},{-40,-60},{-40,-6},{-14,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const.y, onOffSta.SetPoi) annotation (Line(
      points={{-79,0},{-14,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=172800));
end OnOffSta;
