within BuildingControlEmulator.Devices.Fault.Examples;
model MultiHeterChillers "Test model for MultiChillerSystem"
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;

  Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19XR_742kW_5_42COP_VSD
    datChi[3] annotation (Placement(transformation(extent={{-12,42},{8,62}})));

  package MediumCHW = Buildings.Media.Water "Medium model";
  package MediumCW = Buildings.Media.Water "Medium model";
  parameter Modelica.Units.SI.TemperatureDifference dTCHW_nominal=5.56
    "Temperature difference at the chilled water side";
  parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal=5.18
    "Temperature difference at the condenser water wide";
  parameter Modelica.Units.SI.Pressure dPCHW_nominal=91166
    "Pressure difference at the chilled water side";
  parameter Modelica.Units.SI.Pressure dPCW_nominal=92661
    "Pressure difference at the condenser water wide";
  parameter Modelica.Units.SI.Temperature TCHW_nominal=273.15 + 5.56
    "Temperature at the chilled water side";
  parameter Modelica.Units.SI.Temperature TCW_nominal=273.15 + 29.44
    "Temperature at the condenser water wide";
  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[:]={-datChi[1].QEva_flow_nominal
      /4200/5.56 for i in linspace(
      1,
      3,
      3)} "Nominal mass flow rate at the chilled water side";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]={
      mCHW_flow_nominal[1]*(datChi[1].COP_nominal + 1)/datChi[1].COP_nominal
      for i in linspace(
      1,
      3,
      3)} "Nominal mass flow rate at the condenser water wide";

  BuildingControlEmulator.Subsystems.Chiller.MultiHeterChillers mulChiSys(
    redeclare package MediumCHW = MediumCHW,
    redeclare package MediumCW = MediumCW,
    dPCHW_nominal=dPCHW_nominal,
    dPCW_nominal=dPCW_nominal,
    mCHW_flow_nominal=mCHW_flow_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    TCW_start=273.15 + 29.44,
    TCHW_start=273.15 + 5.56,
    n=1,
    m=2,
    per=datChi,
    ch1(redeclare BuildingControlEmulator.Devices.Fault.TemSensorDev senTCHWLea(
          dt=-2, FauTime=20000)))
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Sources.Step OnA(height=1, startTime=0) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Sources.Step OnB(          startTime=21600,
    height=1,
    offset=0)                                                 annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.Step OnC(          startTime=43200,
    height=1,
    offset=0)                                                 annotation (Placement(transformation(extent={{80,70},{60,90}})));
  Modelica.Blocks.Sources.Constant TCHWSet(k=273.15 + 5.56)
    annotation (Placement(transformation(extent={{80,30},{60,50}})));
  Buildings.Obsolete.Fluid.Sources.FixedBoundary sinCW(redeclare package Medium
      = MediumCW, nPorts=1) "Sink for CW" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,4})));
  Buildings.Fluid.Sources.MassFlowSource_T souCW(
    redeclare package Medium = MediumCW,
    nPorts=1,
    m_flow=sum(mCW_flow_nominal),
    use_m_flow_in=true,
    use_T_in=false,
    T(displayUnit="K") = 273.15 + 21.11) "Source for CW"
    annotation (Placement(transformation(extent={{-48,-50},{-28,-30}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCHW(
    use_T_in=true,
    redeclare package Medium = MediumCHW,
    nPorts=1,
    m_flow=sum(mCW_flow_nominal),
    use_m_flow_in=true,
    T=298.15) "Source for CHW"
    annotation (Placement(transformation(extent={{42,-24},{22,-4}})));
  Buildings.Obsolete.Fluid.Sources.FixedBoundary sinCHW(redeclare package
      Medium =
        MediumCHW, nPorts=1) "Sink for CHW" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,-50})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWLeaChi(
      redeclare package Medium = MediumCHW, m_flow_nominal=sum(mCHW_flow_nominal),
    T_start=273.15 + 5.56)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Sources.Sine TCHWEntChi(
    f=1/21600,
    amplitude=2,
    offset=273.15 + 5.56 + 2)
    annotation (Placement(transformation(extent={{80,-22},{60,-2}})));
  Modelica.Blocks.Sources.RealExpression mCW_flow(y=(OnA.y + OnB.y + OnC.y)*mCW_flow_nominal[1])
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Sources.RealExpression mCHW_flow(y=(OnA.y + OnB.y + OnC.y)*mCHW_flow_nominal[1])
    annotation (Placement(transformation(extent={{80,2},{60,22}})));

equation

  connect(TCHWSet.y, mulChiSys.TCHWSet) annotation (Line(
      points={{59,40},{-20,40},{-20,2},{-10.9,2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sinCW.ports[1], mulChiSys.port_b_CW)
    annotation (Line(
      points={{-60,4},{-36,4},{-36,6},{-10,6}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(souCW.ports[1], mulChiSys.port_a_CW)
    annotation (Line(
      points={{-28,-40},{-20,-40},{-20,-10},{-10,-10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TCHWEntChi.y,souCHW. T_in)
    annotation (Line(
      points={{59,-12},{52,-12},{52,-10},{44,-10}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(senTCHWLeaChi.port_b,sinCHW. ports[1])
    annotation (Line(
      points={{40,-50},{60,-50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(souCHW.ports[1], mulChiSys.port_a_CHW)
    annotation (Line(
      points={{22,-14},{18,-14},{18,6},{10,6}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(mulChiSys.port_b_CHW,senTCHWLeaChi. port_a)
    annotation (Line(
      points={{10,-10},{16,-10},{16,-50},{20,-50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(mCW_flow.y, souCW.m_flow_in)
    annotation (Line(
      points={{-59,-60},{-54,-60},{-54,-32},{-50,-32}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(mCHW_flow.y, souCHW.m_flow_in)
    annotation (Line(
      points={{59,12},{52,12},{52,-6},{44,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(OnA.y, mulChiSys.On[1]) annotation (Line(
      points={{-59,40},{-44,40},{-44,-5.4},{-10.9,-5.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(OnB.y, mulChiSys.On[2]) annotation (Line(
      points={{-59,80},{-44,80},{-28,80},{-28,-6},{-10.9,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(OnC.y, mulChiSys.On[3]) annotation (Line(
      points={{59,80},{8,80},{8,90},{-36,90},{-36,-6.6},{-10.9,-6.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/LejeunePlant/Chiller/Example/MultiChillerSystem.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(StopTime=86400),
    __Dymola_experimentSetupOutput);
end MultiHeterChillers;
