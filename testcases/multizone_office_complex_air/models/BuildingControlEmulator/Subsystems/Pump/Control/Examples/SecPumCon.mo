within BuildingControlEmulator.Subsystems.Pump.Control.Examples;
model SecPumCon
  extends Modelica.Icons.Example;
  BuildingControlEmulator.Subsystems.Pump.Control.SecPumCon
                                               secPumCon(tWai=300, dPSetPoi(
        displayUnit="Pa") = 478250,
    n=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine s1(
    f=1/3600/24,
    amplitude=0.5,
    offset=0.5)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Sine s2(
    f=1/3600/24,
    amplitude=0.5,
    offset=0.5,
    startTime=2400)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Sources.Step On(
    height=-1,
    offset=1,
    startTime=80000)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Modelica.Blocks.Sources.Sine dP(
    f=1/43200,
    amplitude=239125,
    offset=239125)
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
equation
  connect(On.y,realToBoolean. u)
    annotation (Line(points={{-59,70},{-59,70},{-52,70}},   color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realToBoolean.y, secPumCon.On) annotation (Line(points={{-29,70},{-24,
          70},{-20,70},{-20,8},{-12,8}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(dP.y, secPumCon.dP) annotation (Line(points={{-61,0},{-61,0},{-12,0}},
                         color={0,0,127},
      pattern=LinePattern.Dash));
  connect(s1.y, secPumCon.Status[1]) annotation (Line(points={{-59,-40},{-48,
          -40},{-40,-40},{-40,-9},{-12,-9}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(s2.y, secPumCon.Status[2]) annotation (Line(points={{-59,-80},{-26,-80},
          {-26,-7},{-12,-7}},      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end SecPumCon;
