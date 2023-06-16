within BuildingControlEmulator.Subsystems.HydDisturbution;
model FivZonNetWor
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  parameter Modelica.Units.SI.Pressure PreDroMai1
    "Pressure drop 1 across the duct";

  parameter Modelica.Units.SI.Pressure PreDroMai2
    "Pressure drop 2 across the main duct";

  parameter Modelica.Units.SI.Pressure PreDroMai3
    "Pressure drop 3 across the main duct";

  parameter Modelica.Units.SI.Pressure PreDroMai4
    "Pressure drop 4 across the main duct";

  parameter Modelica.Units.SI.Pressure PreDroBra1
    "Pressure drop 1 across the duct branch 1";

  parameter Modelica.Units.SI.Pressure PreDroBra2
    "Pressure drop 1 across the duct branch 2";

  parameter Modelica.Units.SI.Pressure PreDroBra3
    "Pressure drop 1 across the duct branch 3";

  parameter Modelica.Units.SI.Pressure PreDroBra4
    "Pressure drop 1 across the duct branch 4";

  parameter Modelica.Units.SI.Pressure PreDroBra5
    "Pressure drop 1 across the duct branch 5";

  parameter Modelica.Units.SI.MassFlowRate mFloRat1
    "mass flow rate for the first branch1";

  parameter Modelica.Units.SI.MassFlowRate mFloRat2
    "mass flow rate for the first branch2";

  parameter Modelica.Units.SI.MassFlowRate mFloRat3
    "mass flow rate for the first branch3";

  parameter Modelica.Units.SI.MassFlowRate mFloRat4
    "mass flow rate for the first branch4";

  parameter Modelica.Units.SI.MassFlowRate mFloRat5
    "mass flow rate for the first branch5";

  Buildings.Fluid.FixedResistances.Junction junSup1(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                                    m_flow_nominal={mFloRat1 + mFloRat2 + mFloRat3 + mFloRat4 + mFloRat5,-mFloRat2-mFloRat3-mFloRat4 - mFloRat5,-
        mFloRat1}, redeclare package Medium = Medium,
    dp_nominal={PreDroMai1/2,PreDroMai2/2,PreDroBra1/2})
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Buildings.Fluid.FixedResistances.Junction junRet1(redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,                         m_flow_nominal={mFloRat2 + mFloRat3 + mFloRat4 + mFloRat5,-mFloRat1-mFloRat2-mFloRat3-
        mFloRat4 - mFloRat5,mFloRat1},
    dp_nominal={PreDroMai2/2,PreDroMai1/2,PreDroBra1/2})
                                                annotation (Placement(transformation(extent={{-70,-70},{-90,-50}})));
  Buildings.Fluid.FixedResistances.Junction junRet2( redeclare package Medium
      =                                                                         Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,                          m_flow_nominal={mFloRat3 + mFloRat4 + mFloRat5,-mFloRat2-mFloRat3-
        mFloRat4 - mFloRat5,mFloRat2},
    dp_nominal={PreDroMai3/2,PreDroMai2/2,PreDroBra2/2})
                                                annotation (Placement(transformation(extent={{-30,-70},{-50,-50}})));
  Buildings.Fluid.FixedResistances.Junction junSup2(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                                    m_flow_nominal={mFloRat2 + mFloRat3 + mFloRat4 + mFloRat5,-mFloRat3-mFloRat4 - mFloRat5,-
        mFloRat2}, redeclare package Medium = Medium,
    dp_nominal={PreDroMai2/2,PreDroMai3/2,PreDroBra2/2})
                      annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Buildings.Fluid.FixedResistances.Junction junSup3(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                                    m_flow_nominal={mFloRat3 + mFloRat4 + mFloRat5,-mFloRat4 - mFloRat5,-
        mFloRat3}, redeclare package Medium = Medium,
    dp_nominal={PreDroMai3/2,PreDroMai4/2,PreDroBra3/2})
                                                annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Buildings.Fluid.FixedResistances.Junction junRet3(redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,                         m_flow_nominal={mFloRat4 + mFloRat5,-mFloRat3-
        mFloRat4 - mFloRat5,mFloRat3},
    dp_nominal={PreDroMai4/2,PreDroMai3/2,PreDroBra3/2})
                                                annotation (Placement(transformation(extent={{10,-50},{-10,-70}})));
  Buildings.Fluid.FixedResistances.Junction junSup4(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                                    m_flow_nominal={mFloRat4 + mFloRat5,-mFloRat5,-mFloRat4}, redeclare
      package Medium =
               Medium,
    dp_nominal={PreDroMai4/2,PreDroBra5/2,PreDroBra4/2})
                                                annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Buildings.Fluid.FixedResistances.Junction junRet4(redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,                         m_flow_nominal={mFloRat5,-mFloRat4 - mFloRat5,
        mFloRat4},
    dp_nominal={PreDroBra5/2,PreDroMai4/2,PreDroBra4/2})
                                                annotation (Placement(transformation(extent={{50,-70},{30,-50}})));



  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) "Second port, typically outlet"
                                    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Second port, typically outlet"
                                    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  replaceable Buildings.Fluid.Sensors.Pressure         senRelPre(redeclare
      package Medium =                                                                  Medium)
                                                 annotation (Placement(transformation(extent={{34,70},
            {14,90}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_b[5](redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,6},{110,86}})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_a[5](redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-102},{110,-22}})));
  Modelica.Blocks.Interfaces.RealOutput p "Pressure at port"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(junSup1.port_2, junSup2.port_1) annotation (Line(
      points={{-70,40},{-62,40},{-50,40}},
      color={0,127,255},
      thickness=1));
  connect(junSup2.port_2, junSup3.port_1) annotation (Line(
      points={{-30,40},{-30,40},{-10,40}},
      color={0,127,255},
      thickness=1));
  connect(junSup3.port_2, junSup4.port_1) annotation (Line(
      points={{10,40},{10,40},{30,40}},
      color={0,127,255},
      thickness=1));
  connect(junRet4.port_2, junRet3.port_1) annotation (Line(
      points={{30,-60},{10,-60}},
      color={0,127,255},
      thickness=1));
  connect(junRet3.port_2, junRet2.port_1)
    annotation (Line(
      points={{-10,-60},{-10,-60},{-30,-60}},
      color={0,127,255},
      thickness=1));
  connect(junRet2.port_2, junRet1.port_1)
    annotation (Line(
      points={{-50,-60},{-50,-60},{-70,-60}},
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
  connect(junSup4.port_3, ports_b[4])
    annotation (Line(
      points={{40,30},{40,16},{60,16},{60,62},{100,62}},
      color={0,127,255},
      thickness=1));
  connect(junSup3.port_3, ports_b[3])
    annotation (Line(
      points={{0,30},{0,12},{78,12},{78,46},{100,46}},
      color={0,127,255},
      thickness=1));
  connect(junSup2.port_3, ports_b[2])
    annotation (Line(
      points={{-40,30},{-40,30},{-40,8},{84,8},{84,30},{100,30}},
      color={0,127,255},
      thickness=1));
  connect(junSup1.port_3, ports_b[1])
    annotation (Line(
      points={{-80,30},{-80,30},{-80,0},{90,0},{90,14},{100,14}},
      color={0,127,255},
      thickness=1));
  connect(junRet4.port_1, ports_a[5])
    annotation (Line(
      points={{50,-60},{70,-60},{70,-34},{70,-30},{100,-30}},
      color={0,127,255},
      thickness=1));
  connect(junRet4.port_3, ports_a[4])
    annotation (Line(
      points={{40,-70},{40,-70},{70,-70},{86,-70},{86,-46},{100,-46}},
      color={0,127,255},
      thickness=1));
  connect(junRet2.port_3, ports_a[2])
    annotation (Line(
      points={{-40,-70},{-40,-86},{100,-86},{100,-78}},
      color={0,127,255},
      thickness=1));
  connect(junRet1.port_3, ports_a[1])
    annotation (Line(
      points={{-80,-70},{-80,-70},{-80,-94},{96,-94},{100,-94}},
      color={0,127,255},
      thickness=1));
  connect(junRet3.port_3, ports_a[3])
    annotation (Line(
      points={{0,-50},{0,-38},{82,-38},{82,-62},{100,-62}},
      color={0,127,255},
      thickness=1));
  connect(senRelPre.port, junSup4.port_2) annotation (Line(
      points={{24,70},{24,60},{56,60},{56,40},{50,40}},
      color={0,127,255},
      thickness=1));
  connect(junSup4.port_2, ports_b[5]) annotation (Line(
      points={{50,40},{54,40},{56,40},{56,82},{100,82},{100,78}},
      color={0,127,255},
      thickness=1));
  connect(senRelPre.p, p) annotation (Line(
      points={{13,80},{-20,80},{-20,-20},{96,-20},{96,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-90,40},{80,40}}, color={0,127,255}),
        Line(points={{-90,-60},{80,-60}}, color={0,127,255}),
        Line(points={{80,40},{80,-60}}, color={0,127,255}),
        Line(points={{50,40},{50,-60}}, color={0,127,255}),
        Line(points={{20,40},{20,-60}}, color={0,127,255}),
        Line(points={{-10,40},{-10,-60}}, color={0,127,255}),
        Line(points={{-40,40},{-40,-60}}, color={0,127,255})}),  Diagram(coordinateSystem(preserveAspectRatio=false)));
end FivZonNetWor;
