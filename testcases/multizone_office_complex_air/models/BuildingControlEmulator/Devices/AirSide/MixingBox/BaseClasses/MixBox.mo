within BuildingControlEmulator.Devices.AirSide.MixingBox.BaseClasses;
model MixBox
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the fluid";
  parameter Modelica.Units.SI.Pressure PreDro "Pressure drop in the air side";
  parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat
    "mass flow rate for fresh air";
  parameter Modelica.Units.SI.MassFlowRate mTotAirFloRat
    "mass flow rate for water";



  Buildings.Fluid.FixedResistances.Junction jun(
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    redeclare package Medium = Medium,
    from_dp=false,
    m_flow_nominal={mTotAirFloRat,mFreAirFloRat,-mTotAirFloRat + mFreAirFloRat},
    dp_nominal={PreDro/4,PreDro/4,PreDro/4},
    linearized=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-12})));

  Buildings.Fluid.FixedResistances.Junction jun1(
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    redeclare package Medium = Medium,
    from_dp=false,
    m_flow_nominal={mFreAirFloRat,mTotAirFloRat,mTotAirFloRat - mFreAirFloRat},
    dp_nominal={PreDro/4,PreDro/4,PreDro/4},
    linearized=true)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={60,-12})));

  Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package Medium = Medium)
    "First port, typically inlet"                                              annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package Medium = Medium)
    "Second port, typically outlet"                                              annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valExh(
    redeclare package Medium = Medium,
    m_flow_nominal=mFreAirFloRat,
    dpValve_nominal=PreDro/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,50})));
  replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valFre(
    redeclare package Medium = Medium,
    m_flow_nominal=mFreAirFloRat,
    dpValve_nominal=PreDro/2)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,54})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Fre(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  replaceable Buildings.Fluid.Sensors.TemperatureTwoPort temOut(redeclare
      package Medium =                                                                 Medium,
      m_flow_nominal=mFreAirFloRat)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,82})));
  replaceable Buildings.Fluid.Sensors.TemperatureTwoPort temMix(redeclare
      package Medium =
        Medium, m_flow_nominal=mTotAirFloRat)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-42})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temRet(redeclare package Medium =
        Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-50})));
  Modelica.Fluid.Sensors.MassFlowRate masFloAir(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,20})));
  Modelica.Blocks.Interfaces.RealInput DamPos "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Fluid.Sensors.MassFlowRate masSupAir(redeclare package Medium =
        Medium) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,-72})));
  Modelica.Blocks.Interfaces.RealOutput T "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-52},{120,-32}})));
  Modelica.Blocks.Interfaces.RealOutput TOut "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,72},{120,92}})));
  replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valRet(
    redeclare package Medium = Medium,
    dpValve_nominal=PreDro/2,
    m_flow_nominal=mTotAirFloRat - mFreAirFloRat)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,-12})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1 - DamPos)
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
equation
  connect(valExh.port_a, jun.port_2)
    annotation (Line(
      points={{-70,40},{-70,40},{-70,-2}},
      color={0,127,255},
      thickness=1));
  connect(valExh.port_b, port_Exh)
    annotation (Line(
      points={{-70,60},{-70,60},{-70,100}},
      color={0,127,255},
      thickness=1));
  connect(port_Fre,temOut. port_a) annotation (Line(
      points={{60,100},{60,100},{60,92}},
      color={0,127,255},
      thickness=1));
  connect(jun1.port_2, temMix.port_a) annotation (Line(
      points={{60,-22},{60,-28},{60,-32}},
      color={0,127,255},
      thickness=1));
  connect(jun.port_1, temRet.port_b) annotation (Line(
      points={{-70,-22},{-70,-32},{-70,-40}},
      color={0,127,255},
      thickness=1));
  connect(temRet.port_a, port_Ret) annotation (Line(
      points={{-70,-60},{-70,-80},{-70,-100}},
      color={0,127,255},
      thickness=1));
  connect(masFloAir.port_b, jun1.port_1) annotation (Line(
      points={{60,10},{60,4},{60,-2}},
      color={0,127,255},
      thickness=1));
  connect(valExh.y, valFre.y) annotation (Line(
      points={{-82,50},{-94,50},{-94,20},{38,20},{38,54},{48,54}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(valExh.y, DamPos) annotation (Line(
      points={{-82,50},{-82,50},{-94,50},{-94,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_Fre, port_Fre) annotation (Line(points={{60,100},{60,104},{56,104},{60,104},{60,100}},
                                                                           color={0,127,255}));
  connect(port_Sup,masSupAir. port_b) annotation (Line(
      points={{60,-100},{60,-92},{60,-82}},
      color={0,127,255},
      thickness=1));
  connect(masSupAir.port_a, temMix.port_b) annotation (Line(
      points={{60,-62},{60,-62},{60,-52}},
      color={0,127,255},
      thickness=1));
  connect(temMix.T, T) annotation (Line(
      points={{71,-42},{110,-42}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temOut.T, TOut) annotation (Line(
      points={{71,82},{110,82}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temOut.port_b, valFre.port_a) annotation (Line(
      points={{60,72},{60,64}},
      color={0,127,255},
      thickness=1));
  connect(valFre.port_b, masFloAir.port_a)
    annotation (Line(
      points={{60,44},{60,44},{60,30}},
      color={0,127,255},
      thickness=0.5));
  connect(jun.port_3, valRet.port_a) annotation (Line(
      points={{-60,-12},{-10,-12}},
      color={0,127,255},
      thickness=1));
  connect(valRet.port_b, jun1.port_3) annotation (Line(
      points={{10,-12},{50,-12}},
      color={0,127,255},
      thickness=1));
  connect(realExpression.y, valRet.y)
    annotation (Line(
      points={{-19,6},{-10,6},{0,6},{0,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-70,92},{-70,-92}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{60,92},{60,-92}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{60,0},{-70,0}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-70,72},{-70,32}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-78,64},{-62,64}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-80,38},{-60,38}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-78,64},{-60,38}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-80,38},{-62,64}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{60,74},{60,34}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{52,66},{68,66}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{50,40},{70,40}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{52,66},{70,40}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{50,40},{68,66}},
          color={0,0,127},
          thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)));
end MixBox;
