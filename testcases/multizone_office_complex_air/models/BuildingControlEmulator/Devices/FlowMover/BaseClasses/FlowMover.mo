within BuildingControlEmulator.Devices.FlowMover.BaseClasses;
partial model FlowMover
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the fluid";
  parameter Real HydEff[:] "Hydraulic efficiency";
  parameter Real MotEff[:] "Motor efficiency";
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]
    "Volume flow rate curve";
  parameter Modelica.Units.SI.Pressure PreCur[:] "Pressure curve";
  parameter Modelica.Units.SI.Time TimCon "Time constant for the fluid";
  WithoutMotor             withoutMotor(
    redeclare package Medium = Medium,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    PreCur=PreCur,
    TimCon=TimCon)
    annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temEnt(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temLea(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Fluid.Sensors.MassFlowRate masFloRat(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Fluid.Sensors.Pressure preEnt(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-32,-20},{-52,-40}})));
  Modelica.Fluid.Sensors.Pressure preLea(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{30,-20},{10,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput P "Electrical power consumed"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.BooleanInput On "On-off signal" annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput Rat
    "Actual normalised pump speed that is used for computations"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  connect(withoutMotor.port_a, temEnt.port_b) annotation (Line(
      points={{-18,0},{-60,0}},
      color={0,127,255},
      thickness=1));
  connect(temEnt.port_a, port_a) annotation (Line(
      points={{-80,0},{-100,0}},
      color={0,127,255},
      thickness=1));
  connect(withoutMotor.port_b, temLea.port_a) annotation (Line(
      points={{2,0},{30,0}},
      color={0,127,255},
      thickness=1));
  connect(temLea.port_b, masFloRat.port_a) annotation (Line(
      points={{50,0},{60,0}},
      color={0,127,255},
      thickness=1));
  connect(masFloRat.port_b, port_b) annotation (Line(
      points={{80,0},{100,0}},
      color={0,127,255},
      thickness=1));
  connect(preEnt.port, temEnt.port_b) annotation (Line(
      points={{-42,-20},{-42,0},{-60,0}},
      color={0,127,255},
      thickness=1));
  connect(preLea.port, temLea.port_a) annotation (Line(
      points={{20,-20},{20,0},{30,0}},
      color={0,127,255},
      thickness=1));
  connect(withoutMotor.P, P) annotation (Line(
      points={{3,6},{12,6},{20,6},{20,40},{110,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(withoutMotor.Rat, Rat) annotation (Line(
      points={{3,-6},{12,-6},{12,-60},{110,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
              200}),
        Ellipse(
          extent={{-66,74},{60,-74}},
          lineColor={28,108,200})}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end FlowMover;
