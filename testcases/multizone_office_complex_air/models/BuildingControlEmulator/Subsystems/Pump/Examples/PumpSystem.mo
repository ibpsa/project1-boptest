within BuildingControlEmulator.Subsystems.Pump.Examples;
model PumpSystem
  import BuildingControlEmulator.Subsystems.Pump;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium model";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=10
    "Nominal mass flow rate ";
  parameter Real Motor_eta[3,:] = {{1,1,1},{1,1,1},{1,1,1}} "Motor efficiency";
  parameter Real Hydra_eta[3,:] = {{1,1,1},{1,1,1},{1,1,1}} "Hydraulic efficiency";
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[3,:]={{5/1000,10/1000,20
      /1000},{5/1000,10/1000,20/1000},{5/1000,10/1000,20/1000}}
    "Volume flow rate curve";
  parameter Modelica.Units.SI.Pressure PreCur[3,:]={{8000,6000,4000},{8000,6000,
      4000},{8000,6000,4000}} "Pressure curve";

  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    nPorts=2,
    p=101325,
    T=293.15) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}},
          rotation=0)));
  Buildings.Fluid.FixedResistances.PressureDrop       dpDyn(
    redeclare package Medium = Medium,
    m_flow_nominal=3*m_flow_nominal,
    dp_nominal=3000)                 "Pressure drop"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Step OnC(startTime=500)
    annotation (Placement(transformation(extent={{80,60},{60,80}})));
  Modelica.Blocks.Sources.Step OnB(startTime=800)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Step OnA(startTime=10)
    annotation (Placement(transformation(extent={{-82,20},{-62,40}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{20,-88},{0,-68}})));
  Pump.PumpSystem    pumSys(
    redeclare package Medium = Medium,
    n=3,
    HydEff=Hydra_eta,
    MotEff=Motor_eta,
    VolFloCur=VolFloCur,
    PreCur=PreCur,
    m_flow_nominal={m_flow_nominal,m_flow_nominal,m_flow_nominal},
    dp(displayUnit="Pa") = {3000,3000,3000})
                                annotation (Placement(transformation(extent={{-8,-6},{22,24}})));
equation

  connect(dpDyn.port_b,senMasFlo. port_a) annotation (Line(
      points={{80,0},{88,0},{88,-78},{20,-78}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senMasFlo.port_b,sou. ports[1]) annotation (Line(
      points={{0,-78},{-60,-78},{-60,-18}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pumSys.port_b, dpDyn.port_a)
    annotation (Line(
      points={{22,9},{36,9},{36,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sou.ports[2], pumSys.port_a)
    annotation (Line(
      points={{-60,-22},{-60,9},{-8,9}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(OnC.y, pumSys.SpeSig[3]) annotation (Line(
      points={{59,70},{-20,70},{-20,21.9},{-9.35,21.9}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(OnB.y, pumSys.SpeSig[2]) annotation (Line(
      points={{-59,70},{-40,70},{-40,21},{-9.35,21}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(OnA.y, pumSys.SpeSig[1]) annotation (Line(
      points={{-61,30},{-44,30},{-44,20.1},{-9.35,20.1}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/LejeunePlant/Pump/Example/PumpSystem.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(StopTime=1000),
    __Dymola_experimentSetupOutput);
end PumpSystem;
