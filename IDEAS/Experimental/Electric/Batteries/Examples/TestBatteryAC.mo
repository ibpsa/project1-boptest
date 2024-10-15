within IDEAS.Experimental.Electric.Batteries.Examples;
model TestBatteryAC
extends Modelica.Icons.Example;
Modelica.SIunits.Power Pnet;

  AC.BatterySystemGeneral batterySystemGeneral(
    redeclare Data.Batteries.LiIon                technology,
    SoC_start=0.6,
    Pnet=Pnet,
    EBat=10,
    DOD_max=0.8,
    numPha=1) annotation (Placement(transformation(extent={{40,-38},{60,-18}})));
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
  IDEAS.Experimental.Electric.BaseClasses.AC.WattsLaw wattsLaw(numPha=1)
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
  Distribution.AC.Grid_3P grid_3P(
    redeclare Data.Grids.TestGrid2Nodes                grid,
    redeclare Data.TransformerImp.Transfo_100kVA                transformer,
    traTCal=false)
    annotation (Placement(transformation(extent={{-76,-38},{-56,-18}})));
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
Pnet = ramp1.y + ramp2.y + ramp3.y;
  connect(const.y, wattsLaw.Q) annotation (Line(
      points={{-19,20},{-10,20},{-10,51},{3,51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp1.y, add3_1.u1) annotation (Line(
      points={{-59,90},{-50,90},{-50,58},{-42,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp2.y, add3_1.u2) annotation (Line(
      points={{-59,50},{-42,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add3_1.y, wattsLaw.P) annotation (Line(
      points={{-19,50},{-10,50},{-10,55},{4,55}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp3.y, add3_1.u3) annotation (Line(
      points={{-59,10},{-50,10},{-50,42},{-42,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(grid_3P.gridNodes3P[1, 2], batterySystemGeneral.pin[1]) annotation (
      Line(
      points={{-56,-28.6667},{-7.6,-28.6667},{-7.6,-28},{40.4,-28}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(wattsLaw.vi[1], grid_3P.gridNodes3P[1, 2]) annotation (Line(
      points={{20,50},{20,-28.6667},{-56,-28.6667}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end TestBatteryAC;
