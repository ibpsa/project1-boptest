within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover;
model VAVSupFan
  "The AHU supply fan and the controller"
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
  Control.VAVDualFanControl varSpe(
    k=k,
    Ti=Ti,
    waitTime=waitTime)
    annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
  Modelica.Blocks.Interfaces.RealInput pSet
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput pMea
    "Connector of measurement input signal" annotation (Placement(
        transformation(extent={{-140,-120},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput yRet "Output signal connector"
    annotation (Placement(transformation(extent={{100,-92},{120,-72}})));
  Control.TemperatureCheck onFanUnocc(numTemp=numTemp)
    "Circulation fan ON signal based on zonal temperature and setpoints during unoccupied period"
    annotation (Placement(transformation(extent={{-92,-50},{-72,-30}})));
  Modelica.Blocks.Interfaces.RealInput T[numTemp]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput cooTSet[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput heaTSet[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveSpeSupFan(
      description="AHU supply fan speed control signal", u(
      min=0,
      max=1,
      unit="1"))
    annotation (Placement(transformation(extent={{-26,44},{-6,64}})));
  Modelica.Blocks.Math.Gain gain(k=SpeRat)
    annotation (Placement(transformation(extent={{16,50},{24,58}})));
equation
  connect(withoutMotor.port_a, temEnt.port_b) annotation (Line(
      points={{-18,0},{-60,0}},
      color={0,140,72},
      thickness=0.5));
  connect(temEnt.port_a, port_a) annotation (Line(
      points={{-80,0},{-100,0}},
      color={0,140,72},
      thickness=0.5));
  connect(withoutMotor.port_b, temLea.port_a) annotation (Line(
      points={{2,0},{30,0}},
      color={0,140,72},
      thickness=0.5));
  connect(temLea.port_b, masFloRat.port_a) annotation (Line(
      points={{50,0},{60,0}},
      color={0,140,72},
      thickness=0.5));
  connect(masFloRat.port_b, port_b) annotation (Line(
      points={{80,0},{100,0}},
      color={0,140,72},
      thickness=0.5));
  connect(preEnt.port, temEnt.port_b) annotation (Line(
      points={{-42,-20},{-42,0},{-60,0}},
      color={0,140,72},
      thickness=0.5));
  connect(preLea.port, temLea.port_a) annotation (Line(
      points={{20,-20},{20,0},{30,0}},
      color={0,140,72},
      thickness=0.5));
  connect(withoutMotor.P, P) annotation (Line(
      points={{3,6},{12,6},{20,6},{20,40},{110,40}},
      color={0,0,127}));
  connect(onFanOcc, varSpe.onFanOcc)
    annotation (Line(points={{-120,60},{-62,60}}, color={255,0,255}));
  connect(varSpe.SetPoi, pSet) annotation (Line(points={{-62,56},{-80,56},
          {-80,20},{-120,20}}, color={0,0,127}));
  connect(varSpe.Mea, pMea) annotation (Line(points={{-62,52},{-66,52},{-66,
          16},{-56,16},{-56,-100},{-120,-100}}, color={0,0,127}));
  connect(onFanUnocc.Temp, T) annotation (Line(points={{-94,-40},{-100,-40},{-100,
          -60},{-120,-60}}, color={0,0,127}));
  connect(onFanUnocc.On, varSpe.onFanUnocc) annotation (Line(points={{-71,-40},
          {-68,-40},{-68,48},{-62,48}}, color={255,0,255}));
  connect(onFanUnocc.CooSetPoi, cooTSet) annotation (Line(points={{-94,-34},{-98,
          -34},{-98,-20},{-120,-20}}, color={0,0,127}));
  connect(onFanUnocc.HeaSetPoi, heaTSet) annotation (Line(points={{-94,-46},{-98,
          -46},{-98,-60},{-60,-60},{-60,34},{-88,34},{-88,100},{-120,100}},
        color={0,0,127}));
  connect(varSpe.ySup, oveSpeSupFan.u)
    annotation (Line(points={{-39,54},{-28,54}}, color={0,0,127}));
  connect(oveSpeSupFan.y, withoutMotor.u) annotation (Line(points={{-5,54},
          {2,54},{2,26},{-30,26},{-30,6},{-19,6}},     color={0,0,127}));
  connect(oveSpeSupFan.y, gain.u)
    annotation (Line(points={{-5,54},{15.2,54}}, color={0,0,127}));
  connect(gain.y, yRet) annotation (Line(points={{24.4,54},{32,54},{32,
          -82},{110,-82}}, color={0,0,127}));
  annotation (Icon(graphics={
        Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
              200}),
        Text(
          extent={{-30,24},{28,-28}},
          lineColor={28,108,200},
          textString="V"),
        Text(
          extent={{-152,106},{148,146}},
          textString="%name",
          textColor={0,0,255})}));
end VAVSupFan;
