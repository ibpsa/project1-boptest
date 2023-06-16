within BuildingControlEmulator.Devices.WaterSide.BaseClasses.Examples;
model ElectricEIR
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package MediumCHW = Buildings.Media.Water "Medium for chilled water";
  package MediumCW = Buildings.Media.Water "Medium for condenser water";

  BuildingControlEmulator.Devices.WaterSide.BaseClasses.ElectricEIR chi(
    redeclare package Medium1 = MediumCW,
    redeclare package Medium2 = MediumCHW,
    dp1_nominal=1000,
    dp2_nominal=1000,
    per=per,
    m2_flow_nominal=per.mEva_flow_nominal,
    m1_flow_nominal=per.mCon_flow_nominal)
    annotation (Placement(transformation(extent={{-12,-8},{8,12}})));
   parameter Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_23XL_724kW_6_04COP_Vanes
                                                               per
    "Performance data"
    annotation (choicesAllMatching = true,
                Placement(transformation(extent={{40,66},{60,86}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCHW(
    nPorts=1,
    redeclare package Medium = MediumCHW,
    use_T_in=false,
    m_flow=per.mEva_flow_nominal,
    T=273.15 + 20) "Source for CHW"
    annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCW(
    nPorts=1,
    redeclare package Medium = MediumCW,
    use_T_in=false,
    T=273.15 + 21.11,
    m_flow=per.mCon_flow_nominal) "Source for CHW"
    annotation (Placement(transformation(extent={{-80,18},{-60,38}})));
  Buildings.Fluid.Sources.Boundary_pT sinCHW(redeclare package Medium =
        MediumCHW, nPorts=1) "Sink for CHW" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,-20})));
  Buildings.Fluid.Sources.Boundary_pT sinCW(nPorts=1, redeclare package Medium
      = MediumCW) "Sink for CW" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={48,30})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.Ramp ramp(height=1, duration=86400)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWLea(
    allowFlowReversal=true,
    redeclare package Medium = MediumCHW,
    m_flow_nominal=per.mEva_flow_nominal) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-40,-20})));
equation
  connect(souCW.ports[1], chi.port_a1) annotation (Line(
      points={{-60,28},{-40,28},{-40,8},{-12,8}},
      color={0,127,255},
      thickness=1));
  connect(sinCW.ports[1], chi.port_b1) annotation (Line(
      points={{38,30},{20,30},{20,8},{8,8}},
      color={0,127,255},
      thickness=1));
  connect(souCHW.ports[1], chi.port_a2) annotation (Line(
      points={{40,-20},{20,-20},{20,-4},{8,-4}},
      color={0,127,255},
      thickness=1));
  connect(chi.on, booleanExpression.y) annotation (Line(
      points={{-14,5},{-32,5},{-32,60},{-59,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(ramp.y, chi.y) annotation (Line(
      points={{-39,-50},{-32,-50},{-20,-50},{-20,-1},{-14,-1}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sinCHW.ports[1], senTCHWLea.port_b) annotation (Line(
      points={{-62,-20},{-56,-20},{-50,-20}},
      color={0,127,255},
      thickness=1));
  connect(senTCHWLea.port_a, chi.port_b2) annotation (Line(
      points={{-30,-20},{-24,-20},{-16,-20},{-16,-4},{-12,-4}},
      color={0,127,255},
      thickness=1));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end ElectricEIR;
