within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover;
model VariableSpeedMover
  "The component contains both the variable speed fan/pump and the controller"
  import BuildingControlEmulator =
         MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component;
  extends BaseClasses.FlowMover(withoutMotor(varSpeFloMov(riseTime=240)));
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";

  BuildingControlEmulator.conPI variableSpeed
    annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput Mea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
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
      color={0,0,127}));
  connect(variableSpeed.y, withoutMotor.u) annotation (Line(
      points={{-39,54},{-30,54},{-30,6},{-19,6}},
      color={0,0,127}));
  connect(On, variableSpeed.On) annotation (Line(
      points={{-120,60},{-62,60}},
      color={255,0,255}));
  connect(variableSpeed.set, SetPoi) annotation (Line(
      points={{-62,54},{-78,54},{-78,20},{-120,20}},
      color={0,0,127}));
  connect(variableSpeed.mea, Mea) annotation (Line(
      points={{-62,48},{-66,48},{-66,16},{-56,16},{-56,-60},{-120,-60}},
      color={0,0,127}));
  annotation (Icon(graphics={
        Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
              200}),
        Text(
          extent={{-30,24},{28,-28}},
          lineColor={28,108,200},
          textString="V")}));
end VariableSpeedMover;
