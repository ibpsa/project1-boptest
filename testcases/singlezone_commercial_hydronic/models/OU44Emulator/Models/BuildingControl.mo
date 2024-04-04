within OU44Emulator.Models;
model BuildingControl
  extends BuildingBase(scale_factor(k=5));
  Buildings.Controls.Continuous.LimPID conPIDcoil(
    Ti=600,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.005)
    annotation (Placement(transformation(extent={{-60,0},{-76,-16}})));
  Modelica.Blocks.Sources.Constant veAirSp(k=294.15)
    annotation (Placement(transformation(extent={{-4,-16},{-20,0}})));
  Modelica.Blocks.Math.MatrixGain splitFour(K=[1; 1; 1; 1])
    "Splits signal into four elevations"
    annotation (Placement(transformation(extent={{-70,172},{-50,192}})));
  Modelica.Blocks.Sources.Constant shades(k=0)
    annotation (Placement(transformation(extent={{-120,172},{-100,192}})));
  Modelica.Blocks.Sources.Constant stpCO2(k=800) "CO2 setpoint [ppm]"
    annotation (Placement(transformation(extent={{-238,132},{-218,152}})));
  Buildings.Controls.Continuous.LimPID conPIDfan(
    Td=300,
    Ti=600,
    k=0.005,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xi_start=0,
    xd_start=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-194,72},{-174,92}})));
  Buildings.Controls.Continuous.LimPID conPIDrad(
    Ti=600,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.005)
    annotation (Placement(transformation(extent={{116,-52},{100,-36}})));
  Buildings.Controls.SetPoints.OccupancySchedule Occupancy_schedule(period=
        604800, occupancy=3600*{31,43,55,67,79,91,103,115,127,139})
    annotation (Placement(transformation(extent={{136,-20},{152,-4}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{172,-18},{186,-4}})));
  Modelica.Blocks.Sources.Constant Tset(k=294.15) "temperature setpoint"
    annotation (Placement(transformation(extent={{190,-60},{176,-46}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{152,-54},{136,-38}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSupSet(description=
        "AHU supply air temperature set point for heating",
                                                        u(
      max=273.15 + 40,
      unit="K",
      min=273.15 + 15))
    "Overwrite AHU supply air temperature set point for heating"
    annotation (Placement(transformation(extent={{-26,-14},{-38,-2}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTZon(
    description="Zone air temperature",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K")) "Read zone air temperature"
    annotation (Placement(transformation(extent={{62,50},{74,62}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveCO2ZonSet(description=
        "Zone CO2 concentration setpoint", u(
      min=400,
      max=1000,
      unit="ppm")) "Overwrite CO2 setpoint" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-208,112})));
  Buildings.Utilities.IO.SignalExchange.Read reaTCoiRet(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="AHU heating coil return water temperature")
    "Read heating coil return water temperature" annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-114,-32})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveValRad(u(
      min=0,
      max=1,
      unit="1"), description="Radiator valve control signal")
    "Overwrite radiator valve control signal"
    annotation (Placement(transformation(extent={{38,-46},{26,-34}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveValCoi(u(
      min=0,
      max=1,
      unit="1"), description="AHU heating coil valve control signal")
    "Overwrite AHU heating coil control valve signal"
    annotation (Placement(transformation(extent={{-82,-14},{-94,-2}})));
equation
  connect(ahu.Tsu, conPIDcoil.u_m) annotation (Line(points={{-119.4,36},{-116,
          36},{-116,10},{-68,10},{-68,1.6}},color={0,0,127}));
  connect(splitFour.y, ou44Bdg.uSha) annotation (Line(points={{-49,182},{-28,
          182},{-28,74},{-19.6,74}}, color={0,0,127}));
  connect(shades.y, splitFour.u[1])
    annotation (Line(points={{-99,182},{-72,182}}, color={0,0,127}));
  connect(senCO2.ppm,conPIDfan. u_m)
    annotation (Line(points={{-67,66},{-184,66},{-184,70}}, color={0,0,127}));
  connect(conPIDfan.y, ahu.y)
    annotation (Line(points={{-173,82},{-142,82},{-142,55}}, color={0,0,127}));
  connect(Occupancy_schedule.occupied, booleanToReal.u) annotation (Line(points=
         {{152.8,-16.8},{164,-16.8},{164,-11},{170.6,-11}}, color={255,0,255}));
  connect(booleanToReal.y, product.u1) annotation (Line(points={{186.7,-11},{
          190,-11},{190,-41.2},{153.6,-41.2}}, color={0,0,127}));
  connect(product.u2, Tset.y) annotation (Line(points={{153.6,-50.8},{170,-50.8},
          {170,-53},{175.3,-53}}, color={0,0,127}));
  connect(veAirSp.y, oveTSupSet.u)
    annotation (Line(points={{-20.8,-8},{-24.8,-8}}, color={0,0,127}));
  connect(Ti.T, reaTZon.u)
    annotation (Line(points={{54,56},{60.8,56}}, color={0,0,127}));
  connect(reaTZon.y, conPIDrad.u_m) annotation (Line(points={{74.6,56},{78,56},
          {78,-56},{108,-56},{108,-53.6}}, color={0,0,127}));
  connect(stpCO2.y, oveCO2ZonSet.u) annotation (Line(points={{-217,142},{-208,
          142},{-208,121.6}}, color={0,0,127}));
  connect(oveCO2ZonSet.y, conPIDfan.u_s) annotation (Line(points={{-208,103.2},
          {-208,82},{-196,82}}, color={0,0,127}));
  connect(senTemCoiRet.T, reaTCoiRet.u)
    annotation (Line(points={{-141,-32},{-121.2,-32}}, color={0,0,127}));
  connect(conPIDrad.y, oveValRad.u) annotation (Line(points={{99.2,-44},{80,-44},
          {80,-40},{39.2,-40}}, color={0,0,127}));
  connect(conPIDcoil.y, oveValCoi.u)
    annotation (Line(points={{-76.8,-8},{-80.8,-8}}, color={0,0,127}));
  connect(oveTSupSet.y, conPIDcoil.u_s)
    annotation (Line(points={{-38.6,-8},{-58.4,-8}}, color={0,0,127}));
  connect(oveValCoi.y, valCoil.y)
    annotation (Line(points={{-94.6,-8},{-114,-8}}, color={0,0,127}));
  connect(oveValRad.y, valRad.y) annotation (Line(points={{25.4,-40},{-58,-40},
          {-58,-70}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2678400, Interval=600),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end BuildingControl;
