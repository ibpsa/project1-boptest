within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Network;
model PipeNetwork "Water distribution network"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  parameter Modelica.Units.SI.Pressure PreDroMai1
    "Pressure drop 1 across the duct";

  parameter Modelica.Units.SI.Pressure PreDroMai2
    "Pressure drop 2 across the main duct";

  parameter Modelica.Units.SI.Pressure PreDroBra1
    "Pressure drop 1 across the duct branch 1";

  parameter Modelica.Units.SI.Pressure PreDroBra2
    "Pressure drop 1 across the duct branch 2";

  parameter Modelica.Units.SI.Pressure PreDroBra3
    "Pressure drop 1 across the duct branch 3";

  parameter Modelica.Units.SI.MassFlowRate mFloRat1
    "mass flow rate for the first branch1";

  parameter Modelica.Units.SI.MassFlowRate mFloRat2
    "mass flow rate for the first branch2";

  parameter Modelica.Units.SI.MassFlowRate mFloRat3
    "mass flow rate for the first branch3";

  Buildings.Fluid.FixedResistances.Junction junSup1(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mFloRat1 + mFloRat2 + mFloRat3,-mFloRat2 - mFloRat3,-
        mFloRat1}, redeclare package Medium = Medium,
    dp_nominal={PreDroMai1/2,-PreDroMai2/2,-PreDroBra1/2})
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Buildings.Fluid.FixedResistances.Junction junRet1(redeclare package
      Medium =                                                                 Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mFloRat2 + mFloRat3,-mFloRat1 - mFloRat2 - mFloRat3,
        mFloRat1},
    dp_nominal={PreDroMai2/2,-PreDroMai1/2,PreDroBra1/2})
                                                annotation (Placement(transformation(extent={{-70,-70},{-90,-50}})));
  Buildings.Fluid.FixedResistances.Junction junRet2( redeclare package
      Medium =                                                                  Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mFloRat3,-mFloRat2 - mFloRat3,mFloRat2},
    dp_nominal={PreDroBra3/2,-PreDroMai2/2,PreDroBra2/2})
                                                annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
  Buildings.Fluid.FixedResistances.Junction junSup2(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mFloRat2 + mFloRat3,-mFloRat3,-mFloRat2},
                   redeclare package Medium = Medium,
    dp_nominal={PreDroMai2/2,-PreDroBra3/2,-PreDroBra2/2})
                      annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) "Second port, typically outlet"
                                    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Second port, typically outlet"
                                    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package
      Medium =                                                                  Medium)
                                                 annotation (Placement(transformation(extent={{-80,-26},{-60,-6}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_b[3](redeclare package
      Medium =                                                                 Medium)
    annotation (Placement(transformation(extent={{90,6},{110,86}})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_a[3](redeclare package
      Medium =                                                                 Medium)
    annotation (Placement(transformation(extent={{90,-102},{110,-22}})));
  Modelica.Blocks.Interfaces.RealOutput p "Pressure at port"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(junSup1.port_2, junSup2.port_1) annotation (Line(
      points={{-70,40},{-10,40}},
      color={0,127,255},
      thickness=1));
  connect(junRet2.port_2, junRet1.port_1)
    annotation (Line(
      points={{-10,-60},{-10,-60},{-70,-60}},
      color={0,127,255},
      thickness=1));
  connect(junRet1.port_2, port_b) annotation (Line(
      points={{-90,-60},{-100,-60}},
      color={0,127,255},
      thickness=1));
  connect(junSup1.port_1, port_a) annotation (Line(
      points={{-90,40},{-100,40}},
      color={0,127,255},
      thickness=1));

  connect(ports_b, ports_b) annotation (Line(points={{100,46},{100,46}}, color={0,127,255}));
  connect(junSup2.port_3, ports_b[2])
    annotation (Line(
      points={{0,30},{0,30},{0,8},{84,8},{84,46},{100,46}},
      color={0,127,255},
      thickness=1));
  connect(junSup1.port_3, ports_b[1])
    annotation (Line(
      points={{-80,30},{-80,30},{-80,0},{90,0},{90,19.3333},{100,19.3333}},
      color={0,127,255},
      thickness=1));
  connect(junRet2.port_3, ports_a[2])
    annotation (Line(
      points={{0,-70},{0,-86},{100,-86},{100,-62}},
      color={0,127,255},
      thickness=1));
  connect(junRet1.port_3, ports_a[1])
    annotation (Line(
      points={{-80,-70},{-80,-70},{-80,-94},{100,-94},{100,-88.6667}},
      color={0,127,255},
      thickness=1));
  connect(junSup2.port_2, ports_b[3])
    annotation (Line(
      points={{10,40},{100,40},{100,72.6667}},
      color={0,127,255},
      thickness=1));
  connect(junRet2.port_1, ports_a[3])
    annotation (Line(
      points={{10,-60},{100,-60},{100,-35.3333}},
      color={0,127,255},
      thickness=1));
  connect(senRelPre.port_a, port_a) annotation (Line(points={{-80,-16},{-94,-16},{-94,40},{-100,40}}, color={0,127,
          255}));
  connect(senRelPre.port_b, port_b)
    annotation (Line(points={{-60,-16},{-48,-16},{-48,-40},{-94,-40},{-94,-60},{-100,-60}}, color={0,127,
          255}));
  connect(senRelPre.p_rel, p) annotation (Line(
      points={{-70,-25},{-70,-34},{90,-34},{90,0},{110,0}},
      color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-90,40},{80,40}}, color={0,127,255}),
        Line(points={{-90,-60},{80,-60}}, color={0,127,255}),
        Line(points={{80,40},{80,-60}}, color={0,127,255}),
        Line(points={{50,40},{50,-60}}, color={0,127,255}),
        Line(points={{20,40},{20,-60}}, color={0,127,255}),
        Text(
          extent={{-148,106},{152,146}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
end PipeNetwork;
