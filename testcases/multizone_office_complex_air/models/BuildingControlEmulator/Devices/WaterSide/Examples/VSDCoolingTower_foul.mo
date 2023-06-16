within BuildingControlEmulator.Devices.WaterSide.Examples;
model VSDCoolingTower_foul
  extends Modelica.Icons.Example;
  package MediumCW = Buildings.Media.Water "Medium model";
  parameter Modelica.Units.SI.Power P_nominal=30000
    "Nominal compressor power (at y=1)";
  parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal=5.18
    "Temperature difference between the outlet and inlet of the modules";
  parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal=4.44
    "Nominal approach temperature";
  parameter Modelica.Units.SI.Temperature TWetBul_nominal=273.15 + 25
    "Nominal wet bulb temperature";
  parameter Modelica.Units.SI.Pressure dP_nominal=1000
    "Pressure difference between the outlet and inlet of the modules ";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal=10
    "Nominal mass flow rate at condenser water wide";
  parameter Real GaiPi=1 "Gain of the PI controller";
  parameter Real tIntPi=60 "Integration time of the PI controller";
  parameter Real v_flow_rate[:]={1} "Volume flow rate rate";
  parameter Real eta[:]={1} "Fan efficiency";
  BuildingControlEmulator.Devices.WaterSide.VSDCoolingTower
                  cooTowMod(
    P_nominal=P_nominal,
    dTCW_nominal=dTCW_nominal,
    dTApp_nominal=dTApp_nominal,
    TWetBul_nominal=TWetBul_nominal,
    dP_nominal=dP_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    GaiPi=GaiPi,
    tIntPi=tIntPi,
    v_flow_rate=v_flow_rate,
    eta=eta,
    redeclare package MediumCW = MediumCW,
    TCW_start=273.15 + 29.44,
    yorkCalc(eps=0.8))        "Single cooling tower module"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant TSet(k=273.15 + 29.44)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Buildings.Fluid.Sources.Boundary_pT   sinCW(redeclare package Medium =
               MediumCW, nPorts=1) "Sink for CW" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,0})));
  Buildings.Fluid.Sources.MassFlowSource_T souCW(
    nPorts=1,
    use_T_in=true,
    m_flow=mCW_flow_nominal,
    redeclare package Medium = MediumCW,
    T=273.15 + 29.44) "Source for CW"
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Modelica.Blocks.Sources.Sine TCWLeachi(
    f=1/86400,
    amplitude=2.59,
    offset=273.15 + 32.03)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Sources.Constant TWetBul(k=273.15 + 25)   annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.Step On(
    height=-1,
    offset=1,
    startTime=43200) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation

  connect(TSet.y, cooTowMod.TSet) annotation (Line(
      points={{-59,70},{-20,70},{-20,8},{-12,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sinCW.ports[1], cooTowMod.port_b_CW) annotation (Line(
      points={{60,0},{10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(souCW.ports[1], cooTowMod.port_a_CW) annotation (Line(
      points={{-30,-40},{-20,-40},{-20,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TCWLeachi.y, souCW.T_in) annotation (Line(
      points={{-59,-10},{-56,-10},{-56,-36},{-52,-36}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TWetBul.y, cooTowMod.TWetBul)
    annotation (Line(
      points={{-59,-70},{-16,-70},{-16,-4},{-12,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(On.y, cooTowMod.On) annotation (Line(
      points={{-59,30},{-36,30},{-36,4},{-12,4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/BaseClasses/Components/Example/CoolingTowerModule.mos"
        "Simulate and plot"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=86400),
    __Dymola_experimentSetupOutput);
end VSDCoolingTower_foul;
