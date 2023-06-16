within BuildingControlEmulator.Subsystems.HydDisturbution.Examples;
model FivZonNetWorwithCon
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air "Medium model";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat=1
    "mass flow rate for the first branch1";

  parameter Modelica.Units.SI.Pressure PreDroMai1=100
    "Pressure drop 1 across the duck";

  parameter Modelica.Units.SI.Pressure PreDroMai2=100
    "Pressure drop 2 across the main duct";

  parameter Modelica.Units.SI.Pressure PreDroMai3=100
    "Pressure drop 3 across the main duct";

  parameter Modelica.Units.SI.Pressure PreDroMai4=100
    "Pressure drop 4 across the main duct";

  parameter Modelica.Units.SI.Pressure PreDroBra=50
    "Pressure drop across the duct branch";

  parameter Real load[:] = {10,2,4,5,9};

  BuildingControlEmulator.Subsystems.HydDisturbution.FivZonNetWor fivZonNetWor(redeclare
      package Medium = MediumAir,
    mFloRat1=mAirFloRat,
    mFloRat2=mAirFloRat,
    mFloRat3=mAirFloRat,
    mFloRat4=mAirFloRat,
    mFloRat5=mAirFloRat,
    PreDroMai1=PreDroMai1,
    PreDroMai2=PreDroMai2,
    PreDroMai3=PreDroMai3,
    PreDroMai4=PreDroMai4,
    PreDroBra1=PreDroBra,
    PreDroBra2=PreDroBra,
    PreDroBra3=PreDroBra,
    PreDroBra4=PreDroBra,
    PreDroBra5=PreDroBra)
    annotation (Placement(transformation(extent={{-52,-24},{-6,26}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    nPorts=1,
    p(displayUnit="Pa") = 100000 + PreDroMai1 + PreDroMai2 + PreDroMai3 + PreDroMai4 + PreDroBra + 200,
    redeclare package Medium = MediumAir,
    T=278.15)
    annotation (Placement(transformation(extent={{-100,18},{-80,38}})));

  Buildings.Fluid.Sources.Boundary_pT sin(
    nPorts=1,
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 100000,
    T=299.15) annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));

  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val[5](redeclare
      package Medium =                                                                     MediumAir, m_flow_nominal=mAirFloRat,
    dpValve_nominal=200)
    annotation (Placement(transformation(extent={{30,32},{50,52}})));
  Modelica.Blocks.Sources.Ramp ramp[5](duration=86400, height=1) annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol[5](
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=mAirFloRat,
    V=10,
    nPorts=5) annotation (Placement(transformation(extent={{32,-48},{52,-28}})));
  Modelica.Blocks.Sources.Ramp ramp1[5](duration=86400, height=load*100)
                                                                 annotation (Placement(transformation(extent={{-80,-90},
            {-60,-70}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow fixedHeatFlow[5]
    annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
equation
  connect(sou.ports[1], fivZonNetWor.port_a) annotation (Line(points={{-80,28},{-60,28},{-60,11},{-52,11}}, color={0,127,255}));
  connect(sin.ports[1], fivZonNetWor.port_b) annotation (Line(points={{-80,-40},{-60,-40},{-60,-14},{-52,-14}}, color={0,127,255}));
  connect(ramp.y, val.y) annotation (Line(points={{-79,80},{-20,80},{40,80},{40,
          54}},                                                                       color={0,0,127}));
  connect(fivZonNetWor.ports_b[1], val[1].port_a);

  for i in 1:5 loop
   connect(fivZonNetWor.ports_a[i], vol[i].ports[1]);
   connect(val[i].port_b, vol[i].ports[2]);
   connect(fivZonNetWor.ports_b[i], val[i].port_a);
  end for;


  connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-10,-80},{
          20,-80},{20,-38},{32,-38}}, color={191,0,0}));
  connect(fixedHeatFlow.Q_flow, ramp1.y)
    annotation (Line(points={{-30,-80},{-59,-80}},           color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end FivZonNetWorwithCon;
