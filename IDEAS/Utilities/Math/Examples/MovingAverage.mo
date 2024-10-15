within IDEAS.Utilities.Math.Examples;
model MovingAverage
  extends Modelica.Icons.Example;
  IDEAS.Utilities.Math.MovingAverage movingAverage(period=2, resetIntegral=10)
    annotation (Placement(transformation(extent={{-16,8},{4,28}})));
  Modelica.Blocks.Sources.Pulse step(
    offset=50,
    startTime=5,
    amplitude=150,
    period=10) annotation (Placement(transformation(extent={{-74,8},{-54,28}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=50,
    k=1)
    annotation (Placement(transformation(extent={{-14,-28},{6,-8}})));
equation
  connect(step.y, movingAverage.u) annotation (Line(
      points={{-53,18},{-53,18},{-18,18}},
      color={0,0,127},
      thickness=0.5,
      smooth=Smooth.Bezier));
  connect(step.y, firstOrder.u) annotation (Line(
      points={{-53,18},{-44,18},{-44,-18},{-16,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics),
    experiment(StopTime=30, Tolerance=1e-06),
    __Dymola_experimentSetupOutput);
end MovingAverage;
