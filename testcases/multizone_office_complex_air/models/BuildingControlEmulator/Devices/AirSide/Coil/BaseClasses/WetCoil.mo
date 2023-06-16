within BuildingControlEmulator.Devices.AirSide.Coil.BaseClasses;
model WetCoil
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  replaceable package MediumWat = Modelica.Media.Interfaces.PartialMedium "Medium for the water";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat
    "mass flow rate for water";
  parameter Modelica.Units.SI.Pressure PreDroAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroWat
    "Pressure drop in the water side";
  parameter Real UA "Rated heat exchange coefficients";

  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(redeclare package
      Medium1 = MediumWat, redeclare package Medium2 = MediumAir,
    m1_flow_nominal=mWatFloRat,
    m2_flow_nominal=mAirFloRat,
    dp1_nominal=PreDroWat,
    dp2_nominal=PreDroAir,
    UA_nominal=UA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temEntWat(redeclare package Medium
      = MediumWat)
    annotation (Placement(transformation(extent={{-74,-4},{-54,16}})));
   Modelica.Fluid.Sensors.TemperatureTwoPort temLeaWat(redeclare package Medium
      = MediumWat)
    annotation (Placement(transformation(extent={{62,-4},{82,16}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package Medium =
        MediumWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package Medium =
        MediumWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temEntAir(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Modelica.Fluid.Sensors.MassFlowRate masFloWat(redeclare package Medium =
        MediumWat)
    annotation (Placement(transformation(extent={{32,-4},{52,16}})));
  Modelica.Fluid.Sensors.Pressure preWatEnt(redeclare package Medium =
        MediumWat)
    annotation (Placement(transformation(extent={{-20,6},{-40,26}})));
  Modelica.Fluid.Sensors.Pressure preWatLea(redeclare package Medium =
        MediumWat)
    annotation (Placement(transformation(extent={{32,6},{12,26}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium =
        MediumAir)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Sensors.MassFlowRate masFloAir(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
  replaceable Buildings.Fluid.Sensors.TemperatureTwoPort temLeaAir(redeclare
      package Medium =
        MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{-68,-70},{-88,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium =
        MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Sensors.Pressure preAirLea(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-30,-46},{-50,-26}})));
  Modelica.Fluid.Sensors.Pressure preAirEnt(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{50,-44},{30,-24}})));
  Modelica.Blocks.Interfaces.RealOutput TAirLea
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
equation
  connect(cooCoi.port_a1, temEntWat.port_b) annotation (Line(
      points={{-14,6},{-40,6},{-54,6}},
      color={0,127,255},
      thickness=1));
  connect(temEntWat.port_a, port_a_Wat) annotation (Line(
      points={{-74,6},{-88,6},{-88,60},{-100,60}},
      color={0,127,255},
      thickness=1));
  connect(temLeaWat.port_b, port_b_Wat) annotation (Line(
      points={{82,6},{90,6},{90,60},{100,60}},
      color={0,127,255},
      thickness=1));
  connect(cooCoi.port_b1, masFloWat.port_a) annotation (Line(
      points={{6,6},{32,6}},
      color={0,127,255},
      thickness=1));
  connect(masFloWat.port_b, temLeaWat.port_a) annotation (Line(
      points={{52,6},{52,6},{62,6}},
      color={0,127,255},
      thickness=1));
  connect(preWatEnt.port, temEntWat.port_b) annotation (Line(
      points={{-30,6},{-30,6},{-40,6},{-54,6}},
      color={0,127,255},
      thickness=1));
  connect(preWatLea.port, masFloWat.port_a) annotation (Line(
      points={{22,6},{22,6},{32,6}},
      color={0,127,255},
      thickness=1));
  connect(temEntAir.port_b, cooCoi.port_a2) annotation (Line(
      points={{30,-60},{20,-60},{20,-6},{6,-6}},
      color={0,127,255},
      thickness=1));
  connect(temEntAir.port_a, port_a_Air) annotation (Line(
      points={{50,-60},{100,-60}},
      color={0,127,255},
      thickness=1));
  connect(masFloAir.port_a, cooCoi.port_b2) annotation (Line(
      points={{-40,-60},{-20,-60},{-20,-6},{-14,-6}},
      color={0,127,255},
      thickness=1));
  connect(temLeaAir.port_a, masFloAir.port_b) annotation (Line(
      points={{-68,-60},{-60,-60}},
      color={0,127,255},
      thickness=1));
  connect(temLeaAir.port_b, port_b_Air) annotation (Line(
      points={{-88,-60},{-100,-60}},
      color={0,127,255},
      thickness=1));
  connect(preAirLea.port, cooCoi.port_b2) annotation (Line(
      points={{-40,-46},{-20,-46},{-20,-6},{-14,-6}},
      color={0,127,255},
      thickness=1));
  connect(preAirEnt.port, cooCoi.port_a2) annotation (Line(
      points={{40,-44},{40,-46},{20,-46},{20,-6},{6,-6}},
      color={0,127,255},
      thickness=1));
  connect(temLeaAir.T, TAirLea) annotation (Line(
      points={{-78,-49},{-78,-20},{110,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooCoi.port_a1, preWatEnt.port)
    annotation (Line(points={{-14,6},{-30,6}}, color={0,127,255}));
  connect(cooCoi.port_b1, preWatLea.port)
    annotation (Line(points={{6,6},{22,6}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-90,60},{-40,60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-76,60}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{40,60},{90,60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,60},{-40,-60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,60},{40,-60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,-60},{40,-60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,60},{40,60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,60},{40,-60}},
          color={0,0,127},
          thickness=0.5),
        Text(
          extent={{-10,30},{44,-12}},
          lineColor={0,0,127},
          lineThickness=0.5,
          textString="-"),
        Line(
          points={{-90,-60},{-40,-60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,-60},{90,-60}},
          color={0,0,127},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WetCoil;
