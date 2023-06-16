within BuildingControlEmulator.Devices.WaterSide.Control.Example;
model PlantStageN
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  parameter Real tWai = 300 "Waiting time";

  BuildingControlEmulator.Devices.WaterSide.Control.PlantStageN plantSta(
    tWai=tWai,
    n=3,
    thehol={0.9,0.9},
    Cap={1,1,1})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine loa(
    f=1/3600/24,
    amplitude=3,
    offset=0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Step On(
    height=2,
    offset=-1,
    startTime=300)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
equation

  connect(On.y, realToBoolean.u)
    annotation (Line(points={{-59,70},{-59,70},{-42,70}},   color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realToBoolean.y, plantSta.On) annotation (Line(
      points={{-19,70},{40,70},{40,20},{-40,20},{-40,8},{-12,8}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(loa.y, plantSta.Loa) annotation (Line(
      points={{-59,0},{-40,0},{-12,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(plantSta.y, plantSta.Status) annotation (Line(
      points={{11,0},{26,0},{40,0},{40,-60},{-28,-60},{-28,-8},{-12,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/BaseClasses/Control/Example/CompressorStage.mos"
        "Simulate and plot"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(StopTime=86400),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model is designed to test how the stage works when the measured T changes by time(Sine function).</p>
</html>"));
end PlantStageN;
