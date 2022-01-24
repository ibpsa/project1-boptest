within singlezone_commercial_air;
model Ideal "Ideal HVAC and controllers"
  extends Modelica.Icons.Example;

  Buildings.Controls.Continuous.LimPID         conHea(
    k=0.1,
    Ti=300,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI)
    "Controller for heating"
    annotation (Placement(transformation(extent={{-76,50},{-68,58}})));
  Buildings.Controls.Continuous.LimPID         conCoo(
    k=0.1,
    Ti=300,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    reverseActing=false)
    "Controller for cooling"
    annotation (Placement(transformation(extent={{-76,28},{-68,36}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gaiHea(k=1E6) "Gain for heating"
    annotation (Placement(transformation(extent={{-62,50},{-54,58}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gaiCoo(k=-1E6) "Gain for cooling"
    annotation (Placement(transformation(extent={{-62,28},{-54,36}})));
  Modelica.Blocks.Math.Sum sumHeaCoo(nin=2)
    "Sum of heating and cooling heat flow rate"
    annotation (Placement(transformation(extent={{-24,40},{-16,48}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex2
    annotation (Placement(transformation(extent={{-40,40},{-32,48}})));
  Modelica.Blocks.Continuous.Integrator EHea(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    u(unit="W"),
    y(unit="J")) "Heating energy in Joules"
    annotation (Placement(transformation(extent={{-24,56},{-16,64}})));
  Modelica.Blocks.Continuous.Integrator ECoo(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    u(unit="W"),
    y(unit="J")) "Cooling energy in Joules"
    annotation (Placement(transformation(extent={{-24,26},{-16,34}})));
  Buildings.Controls.OBC.CDL.Continuous.MovingMean
                                         PHea(delta=3600)
  "Hourly averaged heating power"
    annotation (Placement(transformation(extent={{-24,68},{-16,76}})));
  Buildings.Controls.OBC.CDL.Continuous.MovingMean
                                         PCoo(delta=3600)
  "Hourly averaged cooling power"
    annotation (Placement(transformation(extent={{-24,12},{-16,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow for heating and cooling"
    annotation (Placement(transformation(extent={{-10,38},{2,50}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-92,28},{-86,34}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-90,52},{-84,58}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam="./USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.mos",
      computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=0,
        origin={48,82})));
  BaseClasses.Envelope envelopeModel(lat=weaDat.lat)
    annotation (Placement(transformation(extent={{40,20},{82,62}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(
    table=[1,15.5555555556; 2,15.5555555556; 3,15.5555555556; 4,15.5555555556; 5,
        15.5555555556; 6,15.5555555556; 7,15.5555555556; 8,15.5555555556; 9,18.3333333333;
        10,21.1111111111; 11,21.1111111111; 12,21.1111111111; 13,21.1111111111;
        14,21.1111111111; 15,21.1111111111; 16,21.1111111111; 17,21.1111111111;
        18,21.1111111111; 19,21.1111111111; 20,21.1111111111; 21,21.1111111111;
        22,15.5555555556; 23,15.5555555556; 24,15.5555555556; 25,15.555555],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "setpoint heating [C]"
    annotation (Placement(transformation(extent={{-118,48},{-106,60}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetCoo(
    table=[1,29.4444444444; 2,29.4444444444; 3,29.4444444444; 4,29.4444444444; 5,
        29.4444444444; 6,29.4444444444; 7,29.4444444444; 8,29.4444444444; 9,26.6666666667;
        10,23.8888888889; 11,23.8888888889; 12,23.8888888889; 13,23.8888888889;
        14,23.8888888889; 15,23.8888888889; 16,23.8888888889; 17,23.8888888889;
        18,23.8888888889; 19,23.8888888889; 20,23.8888888889; 21,23.8888888889;
        22,29.4444444444; 23,29.4444444444; 24,29.4444444444; 25,29.4444444444],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "Setpoint cooling oC"
    annotation (Placement(transformation(extent={{-114,24},{-102,36}})));

equation
  connect(conHea.y,gaiHea. u) annotation (Line(
      points={{-67.6,54},{-62.8,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conCoo.y,gaiCoo. u)  annotation (Line(
      points={{-67.6,32},{-62.8,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gaiHea.y,multiplex2. u1[1]) annotation (Line(
      points={{-53.2,54},{-46,54},{-46,46.4},{-40.8,46.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gaiCoo.y,multiplex2. u2[1]) annotation (Line(
      points={{-53.2,32},{-46,32},{-46,41.6},{-40.8,41.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex2.y,sumHeaCoo. u) annotation (Line(
      points={{-31.6,44},{-24.8,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(EHea.u,gaiHea. y) annotation (Line(
      points={{-24.8,60},{-36,60},{-36,54},{-53.2,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ECoo.u,gaiCoo. y) annotation (Line(
      points={{-24.8,30},{-38,30},{-38,32},{-53.2,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PCoo.u,gaiCoo. y) annotation (Line(
      points={{-24.8,16},{-46,16},{-46,32},{-53.2,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PHea.u,gaiHea. y) annotation (Line(
      points={{-24.8,72},{-46,72},{-46,54},{-53.2,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sumHeaCoo.y, preHea.Q_flow)
    annotation (Line(points={{-15.6,44},{-10,44}}, color={0,0,127}));
  connect(from_degC.y, conCoo.u_s) annotation (Line(points={{-85.7,31},{-80.85,
          31},{-80.85,32},{-76.8,32}}, color={0,0,127}));
  connect(from_degC1.y, conHea.u_s) annotation (Line(points={{-83.7,55},{-79.85,
          55},{-79.85,54},{-76.8,54}}, color={0,0,127}));
  connect(weaDat.weaBus, envelopeModel.weaBus) annotation (Line(
      points={{42,82},{24,82},{24,61.16},{40.42,61.16}},
      color={255,204,51},
      thickness=0.5));
  connect(preHea.port, envelopeModel.HeatPort) annotation (Line(points={{2,44},{
          24,44},{24,42.26},{40.42,42.26}}, color={191,0,0}));
  connect(envelopeModel.Tz, conCoo.u_m) annotation (Line(points={{84.1,43.52},{98,
          43.52},{98,-38},{-72,-38},{-72,27.2}}, color={0,0,127}));
  connect(envelopeModel.Tz, conHea.u_m) annotation (Line(points={{84.1,43.52},{98,
          43.52},{98,-38},{-80,-38},{-80,44},{-72,44},{-72,49.2}}, color={0,0,127}));
  connect(TSetHea.y[1], from_degC1.u) annotation (Line(points={{-105.4,54},{-98,
          54},{-98,55},{-90.6,55}}, color={0,0,127}));
  connect(TSetCoo.y[1], from_degC.u) annotation (Line(points={{-101.4,30},{-98,30},
          {-98,31},{-92.6,31}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31000000,
      Interval=3600,
      Tolerance=1e-08,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="./singlezone_commercial_air.mos"));
end Ideal;
