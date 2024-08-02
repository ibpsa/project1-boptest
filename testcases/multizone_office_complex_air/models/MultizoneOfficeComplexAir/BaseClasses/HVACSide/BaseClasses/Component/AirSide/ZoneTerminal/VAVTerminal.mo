within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal;
model VAVTerminal "The model of the VAV terminals"
    parameter String zonNam "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  replaceable package MediumAir =
      Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  replaceable package MediumWat =
      Modelica.Media.Interfaces.PartialMedium "Medium for the water";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.Pressure PreDroAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroWat
    "Pressure drop in the water side";
  parameter Modelica.Units.SI.Efficiency eps(max=1) = 0.8
    "Heat exchanger effectiveness";

  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage dam(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    dpValve_nominal=PreDroAir,
    riseTime=15,
    y_start=0.3)               annotation (Placement(transformation(extent={{-12,-10},
            {8,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TEnt(redeclare package Medium =
               MediumAir) annotation (Placement(transformation(extent=
           {{-88,-10},{-68,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TLea(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    tau=1,
    transferHeat=true)
    annotation (Placement(transformation(extent={{26,10},{46,-10}})));
  Modelica.Fluid.Sensors.MassFlowRate m_flow(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{56,-10},{76,10}})));
  Modelica.Fluid.Sensors.Pressure pEnt(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{-16,
            -20},{-36,-40}})));
  Modelica.Fluid.Sensors.Pressure pLea(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{30,-20},
            {10,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumAir)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Coil.BaseClasses.DryCoil heaCoil(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat,
    mWatFloRat=mWatFloRat,
    PreDroWat=0,
    eps=eps,
    PreDroAir=0)
    annotation (Placement(transformation(extent={{-40,-4},{-60,16}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package
      Medium =
        MediumWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package
      Medium =
        MediumWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
    pI(
    yMin=0.3,
    k=0.02,
    Ti=120)
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Blocks.Math.Gain gain(k=1/mAirFloRat/1.25)
                                 annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={66,24})));
  Modelica.Blocks.Interfaces.RealInput airFloRatSet
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,70},{-100,90}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage rehVal(
    redeclare package Medium = MediumWat,
    m_flow_nominal=mWatFloRat,
    dpValve_nominal=PreDroWat)
                  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-20,42})));
  Modelica.Blocks.Interfaces.RealInput yVal
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Interfaces.RealOutput TAirLea
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-60,76},{-40,96}})));
  ReadOverwrite.WriteZoneLoc oveZonLoc(zonNam=zonNam)
    annotation (Placement(transformation(extent={{-68,40},{-48,60}})));
equation
  connect(TEnt.port_a, port_a) annotation (Line(
      points={{-88,0},{-88,0},{-100,0}},
      color={0,140,72},
      thickness=0.5));
  connect(dam.port_b, TLea.port_a) annotation (Line(
      points={{8,0},{26,0}},
      color={0,140,72},
      thickness=0.5));
  connect(TLea.port_b, m_flow.port_a) annotation (Line(
      points={{46,0},{56,0}},
      color={0,140,72},
      thickness=0.5));
  connect(pLea.port, TLea.port_a) annotation (Line(
      points={{20,-20},{20,0},{26,0}},
      color={0,140,72},
      thickness=0.5));
  connect(pEnt.port, dam.port_a) annotation (Line(
      points={{-26,-20},{-26,0},{-12,0}},
      color={0,140,72},
      thickness=0.5));
  connect(m_flow.m_flow, gain.u) annotation (Line(
      points={{66,11},{66,19.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain.y,pI.mea)  annotation (Line(
      points={{66,28.4},{66,52},{0,52},{0,74},{8,74}},
      color={0,0,127}));
  connect(pI.set, airFloRatSet)
    annotation (Line(points={{8,80},{-110,80}}, color={0,0,127}));
  connect(rehVal.port_b, port_b_Wat) annotation (Line(
      points={{-20,52},{-20,100}},
      color={255,0,0},
      thickness=1));
  connect(heaCoil.port_a_Air, TEnt.port_b) annotation (Line(
      points={{-60,0},{-64,0},{-68,0}},
      color={0,140,72},
      thickness=0.5));
  connect(heaCoil.port_b_Air,dam. port_a)
    annotation (Line(points={{-40,0},{-26,0},{-12,0}},
                                               color={0,140,72},
      thickness=0.5));
  connect(rehVal.port_a, heaCoil.port_b_Wat) annotation (Line(
      points={{-20,32},{-22,32},{-22,28},{-60,28},{-60,12}},
      color={255,0,0},
      thickness=1));
  connect(heaCoil.port_a_Wat, port_a_Wat) annotation (Line(
      points={{-40,12},{-40,36},{-80,36},{-80,100}},
      color={255,0,0},
      thickness=1));
  connect(booleanExpression.y, pI.On) annotation (Line(
      points={{-39,86},{8,86}},
      color={255,0,255}));
  connect(TLea.T, TAirLea) annotation (Line(points={{36,-11},{36,-60},
          {110,-60}}, color={0,0,127}));
  connect(m_flow.port_b, port_b) annotation (Line(
      points={{76,0},{88,0},{88,0},{100,0}},
      color={0,140,72},
      thickness=0.5));
  connect(oveZonLoc.yReaHea_out, rehVal.y) annotation (Line(points={{-47,46},
          {-40,46},{-40,42},{-32,42}},         color={0,0,127}));
  connect(yVal, oveZonLoc.yReaHea_in) annotation (Line(points={{-110,40},
          {-90,40},{-90,46},{-70,46}},
                              color={0,0,127}));
  connect(pI.y, oveZonLoc.yDam_in) annotation (Line(points={{31,80},{34,
          80},{34,68},{-78,68},{-78,54},{-70,54}},
                                           color={0,0,127}));
  connect(oveZonLoc.yDam_out,dam. y)
    annotation (Line(points={{-47,54},{-2,54},{-2,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{102,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,0},{90,0}},
          color={255,255,255},
          pattern=LinePattern.Dash),
        Text(
          extent={{-60,58},{68,-66}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="VAV"),
        Text(
          extent={{-144,118},{156,158}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VAVTerminal;
