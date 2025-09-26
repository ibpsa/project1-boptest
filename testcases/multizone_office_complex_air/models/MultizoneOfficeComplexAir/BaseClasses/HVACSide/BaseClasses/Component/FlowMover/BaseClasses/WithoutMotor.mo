within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses;
model WithoutMotor
  "Model for fans or pumps where motors are not explicitly modelled"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the fluid";
  parameter Real HydEff[:] "Hydraulic efficiency";
  parameter Real MotEff[:] "Motor efficiency";
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]
    "Volume flow rate curve";
  parameter Modelica.Units.SI.Pressure PreCur[:] "Pressure curve";
  parameter Modelica.Units.SI.Time TimCon "Time constant for the fluid";
  Buildings.Fluid.Movers.SpeedControlled_y varSpeFloMov(
    redeclare package Medium = Medium,
    per(
      pressure(V_flow=VolFloCur, dp=PreCur),
      hydraulicEfficiency(eta=HydEff, V_flow=VolFloCur),
      motorEfficiency(eta=MotEff, V_flow=VolFloCur)),
    tau=TimCon,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
                annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealInput u "control signal"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealOutput P "Electrical power consumed"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput Rat
    "Actual normalised pump speed that is used for computations"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  connect(varSpeFloMov.port_a, port_a)
    annotation (Line(
      points={{-10,0},{-10,0},{-100,0}},
      color={0,140,72},
      thickness=0.5));
  connect(varSpeFloMov.port_b, port_b)
    annotation (Line(
      points={{10,0},{56,0},{100,0}},
      color={0,140,72},
      thickness=0.5));
  connect(varSpeFloMov.P, P) annotation (Line(
      points={{11,9},{40,9},{40,60},{110,60}},
      color={0,0,127}));
  connect(varSpeFloMov.y_actual, Rat) annotation (Line(
      points={{11,7},{40,7},{40,-60},{110,-60}},
      color={0,0,127}));
  connect(u,varSpeFloMov. y) annotation (Line(points={{-110,60},{0,60},
          {0,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
              200}),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200}),
        Text(
          extent={{-30,24},{28,-28}},
          lineColor={28,108,200},
          textString="NoMotor"),
        Text(
          extent={{-150,108},{150,148}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WithoutMotor;
