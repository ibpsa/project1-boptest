within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox;
model MixingBoxWithControl "The model of the mixing box"
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
  BaseClasses.MixingBox mixBox(
    redeclare package Medium = Medium,
    PreDro=PreDro,
    mFreAirFloRat=mFreAirFloRat,
    mTotAirFloRat=mTotAirFloRat)
    annotation (Placement(transformation(extent={{-10,-24},{26,0}})));
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
  Modelica.Blocks.Interfaces.RealInput TMix
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput TOut
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
equation
  connect(mixBox.port_Exh, port_Exh) annotation (Line(
      points={{-4.6,0},{-4.6,60},{-60,60},{-60,100}},
      color={0,140,72},
      thickness=0.5));
  connect(mixBox.port_Fre, port_Fre) annotation (Line(
      points={{18.8,0},{18.8,60},{60,60},{60,100}},
      color={0,140,72},
      thickness=0.5));
  connect(mixBox.port_Ret, port_Ret)
    annotation (Line(
      points={{-4.6,-24},{-4.6,-58},{-58,-58},{-58,-100}},
      color={0,140,72},
      thickness=0.5));
  connect(mixBox.port_Sup, port_Sup)
    annotation (Line(
      points={{18.8,-24},{20,-24},{20,-58},{60,-58},{60,-102}},
      color={0,140,72},
      thickness=0.5));
  connect(mixBox.T, ecoCon.Mea)
    annotation (Line(
      points={{27.8,-17.04},{38,-17.04},{38,22},{-78,22},{-78,32},{-72,32}},
      color={0,0,127}));
  connect(ecoCon.TMix, TMix) annotation (Line(
      points={{-72,40},{-92,40},{-92,0},{-120,0}},
      color={0,0,127}));
  connect(ecoCon.On, On) annotation (Line(
      points={{-72,48},{-90,48},{-90,80},{-120,80}},
      color={255,0,255}));
  connect(ecoCon.TOut,TOut)  annotation (Line(
      points={{-72,36},{-80,36},{-80,-60},{-120,-60}},
      color={0,0,127}));
  connect(ecoCon.y,mixBox.damPos)  annotation (Line(points={{-49,40},{-46,
          40},{-46,-12},{-13.6,-12}},
                                    color={0,0,127}));
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
          thickness=0.5),
        Text(
          extent={{-148,112},{152,152}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
end MixingBoxWithControl;
