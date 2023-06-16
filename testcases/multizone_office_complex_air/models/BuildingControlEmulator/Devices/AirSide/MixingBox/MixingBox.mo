within BuildingControlEmulator.Devices.AirSide.MixingBox;
model MixingBox
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "medium for the fluid";
  parameter Modelica.Units.SI.Pressure PreDro "pressure drop in the air side";
  parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat
    "mass flow rate for fresh air";
  parameter Modelica.Units.SI.MassFlowRate mTotAirFloRat
    "mass flow rate for water";
  parameter Modelica.Units.SI.Temperature TemHig
    "highest temeprature when the economizer is on";
  parameter Modelica.Units.SI.Temperature TemLow
    "lowest temeprature when the economizer is on";
  parameter Real DamMin "minimum damper postion";
  parameter Real k(min=0, unit="1") = 1 "gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "time constant of Integrator block";
  BaseClasses.MixBox mixBox(
    redeclare package Medium = Medium,
    PreDro=PreDro,
    mFreAirFloRat=mFreAirFloRat,
    mTotAirFloRat=mTotAirFloRat)
                            annotation (Placement(transformation(extent={{-28,-28},{32,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium = Medium)
                                                 "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,90},{-50,110}}),
        iconTransformation(extent={{-70,90},{-50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Fre(redeclare package Medium = Medium)
                                                 "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package Medium = Medium)
                                                 "First port, typically inlet" annotation (Placement(transformation(extent={{-68,
            -110},{-48,-90}}), iconTransformation(extent={{-68,-110},{-48,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package Medium = Medium)
                                                 "Second port, typically outlet" annotation (Placement(transformation(extent={{50,-112},{70,-92}})));
  Control.ecoCon ecoCon(
    TemHig=TemHig,
    TemLow=TemLow,
    DamMin=DamMin,
    k=k,
    Ti=Ti)              annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Tout
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveEcoDam
    annotation (Placement(transformation(extent={{-62,-6},{-48,8}})));
equation
  connect(mixBox.port_Exh, port_Exh) annotation (Line(
      points={{-19,30},{-19,60},{-60,60},{-60,100}},
      color={0,127,255},
      thickness=1));
  connect(mixBox.port_Fre, port_Fre) annotation (Line(
      points={{20,30},{20,62},{60,62},{60,100}},
      color={0,127,255},
      thickness=1));
  connect(mixBox.port_Ret, port_Ret)
    annotation (Line(
      points={{-19,-28},{-19,-58},{-58,-58},{-58,-100}},
      color={0,127,255},
      thickness=1));
  connect(mixBox.port_Sup, port_Sup)
    annotation (Line(
      points={{20,-28},{20,-28},{20,-58},{60,-58},{60,-102}},
      color={0,127,255},
      thickness=1));
  connect(mixBox.T, ecoCon.Mea)
    annotation (Line(
      points={{35,-11.18},{64,-11.18},{64,20},{-88,20},{-88,32},{-72,32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ecoCon.SetPoi, SetPoi)
    annotation (Line(
      points={{-72,40},{-92,40},{-92,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ecoCon.On, On) annotation (Line(
      points={{-72,48},{-90,48},{-90,80},{-120,80}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(ecoCon.Tout, Tout) annotation (Line(
      points={{-72,36},{-80,36},{-80,-60},{-120,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveEcoDam.y, mixBox.DamPos)
    annotation (Line(points={{-47.3,1},{-34,1}}, color={0,0,127}));
  connect(ecoCon.y, oveEcoDam.u) annotation (Line(points={{-49,40},{-36,40},{
          -36,24},{-78,24},{-78,1},{-63.4,1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-60,90},{-60,-94}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{60,92},{60,-92}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{60,0},{-60,0}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-60,72},{-60,32}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-68,64},{-52,64}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-70,38},{-50,38}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-68,64},{-50,38}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-70,38},{-52,64}},
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
end MixingBox;
