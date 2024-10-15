within IDEAS.Experimental.Electric.Batteries.Examples;
model TestBatteryDC
extends Modelica.Icons.Example;
Modelica.SIunits.Power Pnet;

  Modelica.Blocks.Sources.Ramp ramp2(
    duration=1500,
    startTime=2700,
    height=-8000)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=4000,
    duration=1500,
    startTime=600)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  BaseClasses.DC.WattsLaw
                       wattsLaw
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    duration=1500,
    startTime=4800,
    height=00)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  DC.BatterySystemGeneral batterySystemGeneral(
    redeclare Data.Batteries.LiIon                technology,
    EBat=10,
    SoC_start=0.6,
    DOD_max=0.8,
    Pnet=Pnet)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=400)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-80,-30})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-72},{-70,-52}})));
equation
Pnet = ramp1.y + ramp2.y + ramp3.y;
  connect(ramp1.y, add3_1.u1) annotation (Line(
      points={{-59,90},{-50,90},{-50,58},{-42,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp2.y, add3_1.u2) annotation (Line(
      points={{-59,50},{-42,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add3_1.y, wattsLaw.P) annotation (Line(
      points={{-19,50},{-10,50},{-10,52},{0,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp3.y, add3_1.u3) annotation (Line(
      points={{-59,10},{-50,10},{-50,42},{-42,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wattsLaw.vi[1], batterySystemGeneral.pin) annotation (Line(
      points={{20,50},{32,50},{32,-30},{40.4,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.n, ground.p) annotation (Line(
      points={{-80,-40},{-80,-52}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.p, batterySystemGeneral.pin) annotation (Line(
      points={{-80,-20},{-20,-20},{-20,-30},{40.4,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end TestBatteryDC;
