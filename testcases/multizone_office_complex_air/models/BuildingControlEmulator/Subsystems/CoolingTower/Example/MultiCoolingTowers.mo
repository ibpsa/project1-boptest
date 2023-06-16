within BuildingControlEmulator.Subsystems.CoolingTower.Example;
model MultiCoolingTowers

  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package MediumCW = Buildings.Media.Water "Medium model";
  parameter Modelica.Units.SI.Power P_nominal[:]={30000 for i in linspace(
      1,
      3,
      3)} "Nominal power (at y=1)";
  parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal=5.18
    "Temperature difference between the outlet and inlet of the cooling tower";
  parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal=4.44
    "Nominal approach temperature";
  parameter Modelica.Units.SI.Temperature TWetBul_nominal=273.15 + 25
    "Nominal wet bulb temperature";
  parameter Modelica.Units.SI.Pressure dP_nominal=1000
    "Pressure difference between the outlet and inlet of the modules ";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]={10 for i in
      linspace(
      1,
      3,
      3)} "Nominal mass flow rate at condenser water wide";
  parameter Real GaiPi=1 "Gain of the PI controller";
  parameter Real tIntPi=60 "Integration time of the PI controller";
  parameter Real v_flow_rate[3,:]={{0.3,0.6,1},{0.3,0.6,1},{0.3,0.6,1}} "Volume flow rate ratio";
  parameter Real eta[3,:]={{0.6,0.7,1},{0.6,0.7,1},{0.6,0.7,1}} "Fan efficiency";
  parameter Modelica.Units.SI.Pressure dPByp_nominal=1000
    "Pressure difference between the outlet and inlet of the modules ";
  BuildingControlEmulator.Subsystems.CoolingTower.MultiCoolingTowers
    cooTow(
    redeclare package MediumCW = MediumCW,
    P_nominal=P_nominal,
    dTCW_nominal=dTCW_nominal,
    dP_nominal=dP_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    GaiPi=GaiPi,
    tIntPi=tIntPi,
    v_flow_rate=v_flow_rate,
    TCW_start=273.15 + 29.44,
    dTApp_nominal=dTApp_nominal,
    TWetBul_nominal=TWetBul_nominal,
    eta=eta,
    n=3)
    annotation (Placement(transformation(extent={{-20,2},{0,22}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCW(
    use_T_in=true,
    redeclare package Medium = MediumCW,
    T=273.15 + 29.44,
    nPorts=1,
    use_m_flow_in=true) "Source for CW"
    annotation (Placement(transformation(extent={{40,14},{20,34}})));
  Buildings.Fluid.Sources.Boundary_pT sinCW(redeclare package Medium =
               MediumCW, nPorts=1) "Sink for CW" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-70})));
  Modelica.Blocks.Sources.Constant TWetBul(k=273.15 + 20)   annotation (Placement(transformation(extent={{-80,-80},
            {-60,-60}})));
  Modelica.Blocks.Sources.Constant TCWSet(k=273.15 + 29.44)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.Step OnA(
    offset=1,
    startTime=21600,
    height=0)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Step OnB(
    height=-1,
    offset=1,
    startTime=43200)
    annotation (Placement(transformation(extent={{-80,38},{-60,58}})));
  Modelica.Blocks.Sources.Step OnC(
    height=-1,
    offset=1,
    startTime=64800)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Blocks.Sources.Sine TCWLeaChi(
    f=1/21600,
    amplitude=17.31,
    offset=273.15 + 17.31)
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Modelica.Blocks.Sources.RealExpression mCHW_flow(y=(OnA.y + OnB.y + OnC.y)*mCW_flow_nominal[1])
    annotation (Placement(transformation(extent={{80,14},{60,34}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEntChi(
      redeclare package Medium = MediumCW, m_flow_nominal=sum(mCW_flow_nominal))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,-30})));
equation

  connect(TWetBul.y, cooTow.TWetBul) annotation (Line(
      points={{-59,-70},{-32,-70},{-32,6},{-20.9,6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TCWSet.y, cooTow.TCWSet) annotation (Line(
      points={{-59,-30},{-40,-30},{-40,19.9},{-20.9,19.9}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TCWLeaChi.y, souCW.T_in) annotation (Line(
      points={{59,-30},{50,-30},{50,28},{42,28}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(mCHW_flow.y, souCW.m_flow_in) annotation (Line(
      points={{59,24},{50,24},{50,32},{42,32}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sinCW.ports[1],senTCWEntChi. port_b) annotation (Line(
      points={{20,-70},{10,-70},{10,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(OnA.y, cooTow.On[1]) annotation (Line(
      points={{-59,10},{-44,10},{-44,15.3},{-20.9,15.3}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(OnB.y, cooTow.On[2]) annotation (Line(
      points={{-59,48},{-42,48},{-42,15.9},{-20.9,15.9}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(OnC.y, cooTow.On[3]) annotation (Line(
      points={{59,50},{14,50},{-32,50},{-32,16.5},{-20.9,16.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooTow.port_a_CW, souCW.ports[1]) annotation (Line(
      points={{-20,12},{-28,12},{-28,24},{10,24},{20,24}},
      color={0,127,255},
      thickness=1));
  connect(cooTow.port_b_CW, senTCWEntChi.port_a)
    annotation (Line(
      points={{0,12},{10,12},{10,-20}},
      color={0,127,255},
      thickness=1));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/LejeunePlant/CoolingTower/Example/CoolingTowerWithBypass.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=86400),
    __Dymola_experimentSetupOutput);
end MultiCoolingTowers;
