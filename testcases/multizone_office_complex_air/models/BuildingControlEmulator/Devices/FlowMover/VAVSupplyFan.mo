within BuildingControlEmulator.Devices.FlowMover;
model VAVSupplyFan
  "the component contains both the variable speed fan/pump and the controller"
  extends BaseClasses.FlowMover;
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time waitTime(min=0) = 0
    "Wait time before transition fires";
  parameter Real SpeRat
      "Speed ratio";
  parameter Integer numTemp(min=1) = 1
      "The size of the temeprature vector";
  Control.VAVDualFanControl variableSpeed(k=k, Ti=Ti,
    waitTime=waitTime,
    SpeRat=SpeRat)
    annotation (Placement(transformation(extent={{-62,40},{-42,60}})));
  Modelica.Blocks.Interfaces.RealInput PreSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput PreMea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput yRet "Output signal connector"
    annotation (Placement(transformation(extent={{100,-92},{120,-72}})));
  Control.TempCheck tempCheck(numTemp=numTemp)
    annotation (Placement(transformation(extent={{-92,-50},{-72,-30}})));
  Modelica.Blocks.Interfaces.RealInput Temp[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput CooTempSetPoi[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput HeaTempSetPoi[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
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
  connect(On, variableSpeed.On) annotation (Line(
      points={{-120,60},{-68,60},{-68,56},{-64,56}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(variableSpeed.SetPoi, PreSetPoi) annotation (Line(
      points={{-64,52},{-64,52},{-78,52},{-78,20},{-120,20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(variableSpeed.Mea, PreMea) annotation (Line(
      points={{-64,48},{-66,48},{-66,16},{-56,16},{-56,-100},{-120,-100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(variableSpeed.ySup, withoutMotor.u) annotation (Line(
      points={{-41,54},{-26,54},{-26,6},{-19,6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(variableSpeed.yRet, yRet) annotation (Line(
      points={{-41,46},{8,46},{8,-82},{110,-82}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(tempCheck.Temp, Temp) annotation (Line(
      points={{-94,-40},{-100,-40},{-100,-60},{-120,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(tempCheck.On, variableSpeed.CyclingOn) annotation (Line(
      points={{-71,-40},{-66,-40},{-66,42},{-66,44},{-64,44}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(tempCheck.CooSetPoi, CooTempSetPoi) annotation (Line(
      points={{-94,-34},{-98,-34},{-98,-20},{-120,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(tempCheck.HeaSetPoi, HeaTempSetPoi) annotation (Line(
      points={{-94,-46},{-98,-46},{-98,-60},{-60,-60},{-60,34},{-88,34},{-88,
          100},{-120,100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(graphics={
        Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
              200}),
        Ellipse(
          extent={{-66,74},{60,-74}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-30,24},{28,-28}},
          lineColor={28,108,200},
          textString="V")}));
end VAVSupplyFan;
