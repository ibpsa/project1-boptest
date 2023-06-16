within BuildingControlEmulator.Devices.WaterSide.Control.Example;
model PumpStageN
  import BuildingControlEmulator;

  extends Modelica.Icons.Example;
  parameter Real tWai = 300 "Waiting time";

  Modelica.Blocks.Sources.Sine s1(
    f=1/3600/24,
    amplitude=0.5,
    offset=0.5)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Sources.Step On(
    height=-1,
    offset=1,
    startTime=80000)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-24,60},{-4,80}})));
  Modelica.Blocks.Sources.Sine s2(
    f=1/3600/24,
    amplitude=0.5,
    offset=0.5,
    startTime=2400)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  BuildingControlEmulator.Devices.WaterSide.Control.PumpStageN pumpStageN(
    tWai=300,
    thehol_up=0.9,
    thehol_down=0.6,
    n=2) annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation

  connect(On.y, realToBoolean.u)
    annotation (Line(points={{-39,70},{-32.5,70},{-26,70}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realToBoolean.y, pumpStageN.On) annotation (Line(
      points={{-3,70},{10,70},{20,70},{20,30},{-20,30},{-20,8},{-10,8}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(s1.y, pumpStageN.Status[1]) annotation (Line(
      points={{-59,-10},{-32,-10},{-32,-9},{-10,-9}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(s2.y, pumpStageN.Status[2]) annotation (Line(
      points={{-59,-50},{-26,-50},{-26,-7},{-10,-7}},
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
end PumpStageN;
