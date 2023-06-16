within BuildingControlEmulator.Subsystems.AirDisturbution;
model FivZonNetWor
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  replaceable package MediumWat = Modelica.Media.Interfaces.PartialMedium "Medium for the water";


  Buildings.Fluid.FixedResistances.Junction jun annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Buildings.Fluid.FixedResistances.Junction jun1 annotation (Placement(transformation(extent={{-70,-50},{-90,-70}})));
  Buildings.Fluid.FixedResistances.Junction jun2 annotation (Placement(transformation(extent={{-34,-50},{-54,-70}})));
  Buildings.Fluid.FixedResistances.Junction jun3 annotation (Placement(transformation(extent={{-52,30},{-32,50}})));
  Buildings.Fluid.FixedResistances.Junction jun4 annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Buildings.Fluid.FixedResistances.Junction jun5 annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
  Buildings.Fluid.FixedResistances.Junction jun6 annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Buildings.Fluid.FixedResistances.Junction jun7 annotation (Placement(transformation(extent={{50,-50},{30,-70}})));
  Devices.Terminal.BaseClasses.VAV vAVTerm5(redeclare package MediumAir = MediumAir, redeclare
      package                                                                                          MediumWat = MediumWat)
    annotation (Placement(transformation(extent={{72,-20},{88,-4}})));
  Devices.Terminal.BaseClasses.VAV vAVTerm4(redeclare package MediumAir = MediumAir, redeclare
      package                                                                                          MediumWat = MediumWat)
    annotation (Placement(transformation(extent={{34,-20},{50,-4}})));
  Devices.Terminal.BaseClasses.VAV vAVTerm3(redeclare package MediumAir = MediumAir, redeclare
      package                                                                                          MediumWat = MediumWat)
    annotation (Placement(transformation(extent={{-10,-20},{6,-4}})));
  Devices.Terminal.BaseClasses.VAV vAVTerm2(redeclare package MediumAir = MediumAir, redeclare
      package                                                                                          MediumWat = MediumWat)
    annotation (Placement(transformation(extent={{-50,-20},{-34,-4}})));
  Devices.Terminal.BaseClasses.VAV vAVTerm1(redeclare package MediumAir = MediumAir, redeclare
      package                                                                                          MediumWat = MediumWat)
    annotation (Placement(transformation(extent={{-86,-20},{-70,-4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b
    "Second port, typically outlet" annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a
    "Second port, typically outlet" annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre annotation (Placement(transformation(extent={{50,70},{30,90}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-124,-92},{-100,-68}})));
  Modelica.Blocks.Interfaces.RealInput AirFlowRatSetPoi[5] "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-126,66},{-100,92}})));
  Modelica.Blocks.Interfaces.RealInput yVal[5] "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-124,-12},{-100,12}})));
  Modelica.Blocks.Interfaces.RealOutput TAirLea
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
equation
  connect(jun.port_2, jun3.port_1) annotation (Line(
      points={{-70,40},{-52,40}},
      color={0,127,255},
      thickness=1));
  connect(jun3.port_2, jun4.port_1) annotation (Line(
      points={{-32,40},{-10,40}},
      color={0,127,255},
      thickness=1));
  connect(jun4.port_2, jun6.port_1) annotation (Line(
      points={{10,40},{10,40},{30,40}},
      color={0,127,255},
      thickness=1));
  connect(jun7.port_2, jun5.port_1) annotation (Line(
      points={{30,-60},{8,-60}},
      color={0,127,255},
      thickness=1));
  connect(jun5.port_2, jun2.port_1) annotation (Line(
      points={{-12,-60},{-34,-60}},
      color={0,127,255},
      thickness=1));
  connect(jun2.port_2, jun1.port_1) annotation (Line(
      points={{-54,-60},{-54,-60},{-70,-60}},
      color={0,127,255},
      thickness=1));
  connect(jun6.port_2, vAVTerm5.port_a)
    annotation (Line(
      points={{50,40},{64,40},{64,-12},{72,-12}},
      color={0,127,255},
      thickness=1));
  connect(vAVTerm5.port_b, jun7.port_1)
    annotation (Line(
      points={{88,-12},{94,-12},{94,-60},{50,-60}},
      color={0,127,255},
      thickness=1));
  connect(jun6.port_3, vAVTerm4.port_a)
    annotation (Line(
      points={{40,30},{40,30},{40,12},{40,10},{26,10},{26,-12},{34,-12}},
      color={0,127,255},
      thickness=1));
  connect(vAVTerm4.port_b, jun7.port_3)
    annotation (Line(
      points={{50,-12},{60,-12},{60,-40},{40,-40},{40,-50}},
      color={0,127,255},
      thickness=1));
  connect(vAVTerm3.port_a, jun4.port_3)
    annotation (Line(
      points={{-10,-12},{-20,-12},{-20,10},{0,10},{0,30}},
      color={0,127,255},
      thickness=1));
  connect(vAVTerm3.port_b, jun5.port_3)
    annotation (Line(
      points={{6,-12},{18,-12},{18,-40},{-2,-40},{-2,-50}},
      color={0,127,255},
      thickness=1));
  connect(vAVTerm2.port_a, jun3.port_3)
    annotation (Line(
      points={{-50,-12},{-58,-12},{-58,20},{-42,20},{-42,30}},
      color={0,127,255},
      thickness=1));
  connect(vAVTerm2.port_b, jun2.port_3)
    annotation (Line(
      points={{-34,-12},{-24,-12},{-24,-42},{-44,-42},{-44,-50}},
      color={0,127,255},
      thickness=1));
  connect(vAVTerm1.port_a, jun.port_3)
    annotation (Line(
      points={{-86,-12},{-92,-12},{-92,18},{-80,18},{-80,30}},
      color={0,127,255},
      thickness=1));
  connect(vAVTerm1.port_b, jun1.port_3)
    annotation (Line(
      points={{-70,-12},{-62,-12},{-62,-40},{-80,-40},{-80,-50}},
      color={0,127,255},
      thickness=1));
  connect(jun1.port_2, port_b) annotation (Line(
      points={{-90,-60},{-100,-60}},
      color={0,127,255},
      thickness=1));
  connect(jun.port_1, port_a) annotation (Line(
      points={{-90,40},{-100,40}},
      color={0,127,255},
      thickness=1));

  connect(vAVTerm1.On, On);
  connect(vAVTerm2.On, On);
  connect(vAVTerm3.On, On);
  connect(vAVTerm4.On, On);
  connect(vAVTerm5.On, On);
  connect(vAVTerm1.AirFlowRatSetPoi, AirFlowRatSetPoi[1]);
  connect(vAVTerm2.AirFlowRatSetPoi, AirFlowRatSetPoi[2]);
  connect(vAVTerm3.AirFlowRatSetPoi, AirFlowRatSetPoi[3]);
  connect(vAVTerm4.AirFlowRatSetPoi, AirFlowRatSetPoi[4]);
  connect(vAVTerm5.AirFlowRatSetPoi, AirFlowRatSetPoi[5]);
  connect(yVal[1], vAVTerm1.yVal);
  connect(yVal[2], vAVTerm1.yVal);
  connect(yVal[3], vAVTerm1.yVal);
  connect(yVal[4], vAVTerm1.yVal);
  connect(yVal[5], vAVTerm1.yVal);
  connect(vAVTerm1.TAirLea, TAirLea) annotation (Line(points={{-69.2,-16.8},{
          -58,-16.8},{-58,-80},{110,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end FivZonNetWor;
