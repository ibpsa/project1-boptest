within BuildingControlEmulator.Devices.WaterSide.Examples;
model Building
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium model";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=10
    "Nominal mass flow rate ";
  parameter Modelica.Units.SI.Pressure dP_nominal=1000
    "Nominal Pressure difference";
  parameter Real v_flow_rate[:] = {0,m_flow_nominal/996,2*m_flow_nominal/996};
  parameter Real pressure[:] = {2*dP_nominal,dP_nominal,0};
  parameter Real Motor_eta[:] = {1,1,1} "Motor efficiency";
  parameter Real Hydra_eta[:] = {1,1,1} "Hydraulic efficiency";
  BuildingControlEmulator.Devices.WaterSide.Building     bui(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tIntPi=60,
    GaiPi=0.1,
    dP_nominal=dP_nominal*0.999,
    TBuiSetPoi=273.15 + 11.12)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  BuildingControlEmulator.Devices.FlowMover.VariableSpeedMover
                                                pumVarSpe(
    redeclare package Medium = Medium,
    HydEff=Hydra_eta,
    MotEff=Motor_eta,
    VolFloCur=v_flow_rate,
    PreCur=pressure,
    TimCon=60,
    k=1,
    Ti=60)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    nPorts=2,
    T(displayUnit="K") = 273.15 + 5.56)  annotation (Placement(transformation(extent={{
            -90,-12},{-70,8}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression
                                   On(y=true)
    annotation (Placement(transformation(extent={{-90,64},{-70,84}})));
  Modelica.Blocks.Sources.Ramp CooLoa(
    height=4200*m_flow_nominal*5,
    duration=18000,
    startTime=0)
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  Modelica.Blocks.Sources.RealExpression PreSetPoi(y=dP_nominal)
    annotation (Placement(transformation(extent={{-88,30},{-68,50}})));
equation

  connect(sou.ports[1], pumVarSpe.port_a) annotation (Line(
      points={{-70,0},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pumVarSpe.port_b, bui.port_a) annotation (Line(
      points={{-20,0},{20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(bui.port_b, sou.ports[2]) annotation (Line(
      points={{40,0},{60,0},{60,-40},{-60,-40},{-60,-4},{-70,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(CooLoa.y, bui.Loa) annotation (Line(
      points={{-9,70},{10,70},{10,4},{19.1,4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(On.y, pumVarSpe.On) annotation (Line(
      points={{-69,74},{-52,74},{-52,6},{-42,6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(bui.dP, pumVarSpe.Mea) annotation (Line(
      points={{41,6},{54,6},{54,-24},{-52,-24},{-52,-6},{-42,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PreSetPoi.y, pumVarSpe.SetPoi) annotation (Line(
      points={{-67,40},{-48,40},{-48,2},{-42,2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/BaseClasses/Components/Example/Building.mos"
        "Simulate and plot"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(StopTime=21600),
    __Dymola_experimentSetupOutput);
end Building;
