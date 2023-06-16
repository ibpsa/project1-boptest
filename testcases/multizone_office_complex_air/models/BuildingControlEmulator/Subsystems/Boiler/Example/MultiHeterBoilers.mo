within BuildingControlEmulator.Subsystems.Boiler.Example;
model MultiHeterBoilers
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;

 package MediumHW =
     Buildings.Media.Water
    "Medium in the hot water side";
  parameter Modelica.Units.SI.Pressure dPHW_nominal=3000
    "Pressure difference at the chilled water side";
  parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal[:]={10,10}
    "Nominal mass flow rate at the chilled water side";
  parameter Modelica.Units.SI.Temperature THW=273.15 + 80
    "The start temperature of chilled water side";
  parameter Modelica.Units.SI.TemperatureDifference dTHW_nominal=20
    "Temperature difference between the outlet and inlet of the module";

  parameter Real eta[2,:]={{0.8}, {0.8}} "Fan efficiency";

  BuildingControlEmulator.Subsystems.Boiler.MultiHeterBoilers
                                                          mulBoiSys(
    redeclare package MediumHW = MediumHW,
    dPHW_nominal=dPHW_nominal,
    mHW_flow_nominal=mHW_flow_nominal,
    dTHW_nominal=dTHW_nominal,
    eta=eta,
    THW_start=THW,
    n=1,
    m=1) annotation (Placement(transformation(extent={{-20,-36},{0,-16}})));
  Modelica.Blocks.Sources.Step OnB(          startTime=43200,
    height=1,
    offset=0)                                                 annotation (Placement(transformation(extent={{80,70},{60,90}})));
  Modelica.Blocks.Sources.Constant THWSet(k=273.15 + 80) annotation (Placement(transformation(extent={{80,30},{60,50}})));
  Buildings.Fluid.Sources.MassFlowSource_T souHW(
    use_T_in=true,
    redeclare package Medium = MediumHW,
    nPorts=1,
    m_flow=sum(mHW_flow_nominal),
    use_m_flow_in=true,
    T=298.15) "Source for HW"  annotation (Placement(transformation(extent={{42,-24},{22,-4}})));
  Buildings.Fluid.Sources.Boundary_pT sinHW(redeclare package Medium = MediumHW, nPorts=1) "Sink for CHW"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,-50})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTHWLeaBoi(
    redeclare package Medium = MediumHW,
    m_flow_nominal=sum(mHW_flow_nominal),
    T_start=273.15 + 5.56)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Sources.Sine THWEntBoi(
    f=1/21600,
    amplitude=10,
    offset=273.15 + 70)
    annotation (Placement(transformation(extent={{80,-22},{60,-2}})));
  Modelica.Blocks.Sources.RealExpression mHW_flow(y=(OnA.y + OnB.y) *mHW_flow_nominal[1])
    annotation (Placement(transformation(extent={{80,2},{60,22}})));
  Modelica.Blocks.Sources.Step OnA(
    startTime=43200,
    height=0,
    offset=1) annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
equation
  connect(THWEntBoi.y, souHW.T_in) annotation (Line(
      points={{59,-12},{52,-12},{52,-10},{44,-10}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(senTHWLeaBoi.port_b, sinHW.ports[1]) annotation (Line(
      points={{40,-50},{60,-50}},
      color={255,0,0},
      thickness=1));
  connect(mHW_flow.y, souHW.m_flow_in) annotation (Line(
      points={{59,12},{52,12},{52,-6},{44,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(mulBoiSys.port_a_HW, souHW.ports[1])
    annotation (Line(
      points={{0,-18},{10,-18},{10,-14},{22,-14}},
      color={255,0,0},
      thickness=1));
  connect(mulBoiSys.port_b_HW, senTHWLeaBoi.port_a) annotation (Line(
      points={{0,-34},{12,-34},{12,-50},{20,-50}},
      color={255,0,0},
      thickness=1));
  connect(OnA.y, mulBoiSys.On[1]) annotation (Line(
      points={{-67,30},{-46,30},{-46,-29.55},{-20.9,-29.55}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(OnB.y, mulBoiSys.On[2]) annotation (Line(
      points={{59,80},{10,80},{-40,80},{-40,-30.45},{-20.9,-30.45}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(mulBoiSys.THWSet, THWSet.y)
    annotation (Line(
      points={{-20.9,-22},{-30,-22},{-30,40},{59,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end MultiHeterBoilers;
