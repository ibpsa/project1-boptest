within BuildingControlEmulator.Devices.FlowMover.Control.Examples;
model CyclingOn
    "This example models the on/off control"
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  BuildingControlEmulator.Devices.FlowMover.Control.CyclingOn cyclingOn(
      waitTime=5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.BooleanPulse booleanStep(startTime=0, period=30)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startValue=false, startTime=
        500) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
equation
  connect(booleanStep.y, cyclingOn.CyclingOn) annotation (Line(
      points={{-49,0},{-49,0},{-28,0},{-12,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanStep1.y, cyclingOn.OnSigIn) annotation (Line(
      points={{-49,50},{-20,50},{-20,4},{-12,4}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000));
end CyclingOn;
