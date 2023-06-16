within BuildingControlEmulator.Devices.FlowMover.Control.Examples;
model TempCheck
  "This example models the logic to check if any element of the temperature vector is beyond the band"
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  BuildingControlEmulator.Devices.FlowMover.Control.TempCheck tempCheck(numTemp=
       3) annotation (Placement(transformation(extent={{-8,30},{12,50}})));
  Modelica.Blocks.Sources.Sine sine(f=1/60)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Sine sine1(f=1/60, phase=1.9198621771938)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Sine sine2(f=1/60, phase=0.34906585039887)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Sources.Constant const[3](k=0)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Constant const1[3](k=-0.5)
    annotation (Placement(transformation(extent={{-32,-92},{-12,-72}})));
equation
  connect(sine.y, tempCheck.Temp[1]) annotation (Line(
      points={{-59,0},{-46,0},{-24,0},{-24,38.6667},{-10,38.6667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sine1.y, tempCheck.Temp[2]) annotation (Line(
      points={{-59,-40},{-34,-40},{-34,40},{-10,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sine2.y, tempCheck.Temp[3]) annotation (Line(
      points={{-59,-80},{-44,-80},{-44,41.3333},{-10,41.3333}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const.y, tempCheck.CooSetPoi) annotation (Line(
      points={{-59,70},{-20,70},{-20,46},{-10,46}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const1.y, tempCheck.HeaSetPoi) annotation (Line(
      points={{-11,-82},{10,-82},{10,0},{-20,0},{-20,34},{-10,34}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000));
end TempCheck;
