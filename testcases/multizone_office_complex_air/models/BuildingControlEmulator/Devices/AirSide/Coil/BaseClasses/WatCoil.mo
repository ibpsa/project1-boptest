within BuildingControlEmulator.Devices.AirSide.Coil.BaseClasses;
partial model WatCoil
  import BuildingControlEmulator;
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  replaceable package MediumWat = Modelica.Media.Interfaces.PartialMedium "Medium for the water";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat
    "mass flow rate for water";
  parameter Modelica.Units.SI.Pressure PreDroAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroWat
    "Pressure drop in the water side";
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium = MediumAir)
                                                   "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,-90},{-92,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium = MediumAir)
                                                   "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package Medium = MediumWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package Medium = MediumWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = MediumWat,
    m_flow_nominal=mWatFloRat,
    dpValve_nominal=PreDroWat)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,40})));
  BuildingControlEmulator.Devices.Control.conPI pI(k=k, Ti=Ti)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Continuous.LimitSlewRate ramLim(raisingSlewRate=1/
        120) "Ramp limiter for water coil control signal"
    annotation (Placement(transformation(extent={{-8,10},{12,30}})));
equation
  connect(val.port_b, port_b_Wat) annotation (Line(
      points={{40,50},{40,80},{100,80}},
      color={0,127,255},
      thickness=1));
  connect(pI.On, On)
    annotation (Line(
      points={{-42,26},{-42,26},{-52,26},{-80,26},{-80,40},{-120,40}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(pI.SetPoi, SetPoi)
    annotation (Line(
      points={{-42,20},{-42,20},{-80,20},{-80,-20},{-120,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pI.y, ramLim.u)
    annotation (Line(points={{-19,20},{-10,20}}, color={0,0,127}));
  connect(ramLim.y, val.y) annotation (Line(points={{14,20},{20,20},{20,40},{28,
          40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end WatCoil;
