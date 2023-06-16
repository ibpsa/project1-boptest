within BuildingControlEmulator.Devices.WaterSide.Example;
model Bypass

  extends Modelica.Icons.Example;
  package MediumCW = Buildings.Media.Water "Medium model";
  parameter Modelica.SIunits.Pressure dPByp_nominal=1000
    "Pressure difference between the outlet and inlet of the modules ";
  parameter Modelica.SIunits.MassFlowRate mCW_flow_nominal=10
    "Nominal mass flow rate at condenser water wide";
  BuildingControlEmulator.Devices.WaterSide.Bypass              byp(
    redeclare package MediumCW = MediumCW,
    dPByp_nominal=dPByp_nominal,
    m_flow_nominal=mCW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Step On(
    height=-1,
    offset=1,
    startTime=1800)  annotation (Placement(transformation(extent={{-80,20},{-60,
            40}})));
  Buildings.Fluid.Sources.MassFlowSource_T sou1(
    m_flow=mCW_flow_nominal,
    redeclare package Medium = MediumCW,
    T=273.15 + 29.44,
    nPorts=1,
    use_T_in=false) "Source1"
    annotation (Placement(transformation(extent={{80,-22},{60,-2}})));
  Buildings.Fluid.Sources.Boundary_pT   sin1(redeclare package Medium =
               MediumCW, nPorts=1) "Sink1" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-10})));
  Buildings.Fluid.Sources.MassFlowSource_T sou2(
    m_flow=mCW_flow_nominal,
    redeclare package Medium = MediumCW,
    T=273.15 + 29.44,
    nPorts=1,
    use_T_in=false) "Source1"
    annotation (Placement(transformation(extent={{-80,-62},{-60,-42}})));
  Buildings.Fluid.Sources.Boundary_pT   sin2(redeclare package Medium =
               MediumCW, nPorts=1) "Sink1" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,-52})));
  Buildings.Fluid.FixedResistances.PressureDrop       res(
    redeclare package Medium = MediumCW,
    m_flow_nominal=mCW_flow_nominal,
    dp_nominal=dPByp_nominal)
    annotation (Placement(transformation(extent={{-30,-20},{-50,0}})));
equation

  connect(sou1.ports[1], byp.port_a1) annotation (Line(
      points={{60,-12},{40,-12},{40,4},{10,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sou2.ports[1], byp.port_a2) annotation (Line(
      points={{-60,-52},{-16,-52},{-16,-4},{-10,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sin2.ports[1], byp.port_b2) annotation (Line(
      points={{60,-52},{20,-52},{20,-4},{10,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(On.y, byp.yBypVal) annotation (Line(
      points={{-59,30},{-40,30},{-40,8},{-12,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sin1.ports[1], res.port_b) annotation (Line(
      points={{-60,-10},{-50,-10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(res.port_a, byp.port_b1) annotation (Line(
      points={{-30,-10},{-20,-10},{-20,4},{-10,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/BaseClasses/Components/Example/Bypass.mos"
        "Simulate and plot"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput);
end Bypass;
