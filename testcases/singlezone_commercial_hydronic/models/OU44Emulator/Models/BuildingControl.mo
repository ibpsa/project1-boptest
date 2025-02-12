within OU44Emulator.Models;
model BuildingControl
  extends BuildingBase;
  Buildings.Controls.Continuous.LimPID conPIDcoil(
    Ti=300,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01)
    annotation (Placement(transformation(extent={{-62,0},{-78,-16}})));
  Modelica.Blocks.Sources.Constant veAirSp(k=293.15)
    annotation (Placement(transformation(extent={{-2,-16},{-18,0}})));
  Modelica.Blocks.Math.MatrixGain splitFour(K=[1; 1; 1; 1])
    "Splits signal into four elevations"
    annotation (Placement(transformation(extent={{-74,194},{-54,214}})));
  Modelica.Blocks.Sources.Constant shades(k=0)
    annotation (Placement(transformation(extent={{-118,194},{-98,214}})));
  Modelica.Blocks.Sources.Constant stpCO2(k=970) "CO2 setpoint [ppm]"
    annotation (Placement(transformation(extent={{-238,132},{-218,152}})));
  Buildings.Controls.Continuous.LimPID conPIDfan(
    Td=300,
    Ti=600,
    k=0.005,
    yMin=0.3,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xi_start=0,
    xd_start=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-194,72},{-174,92}})));
  Buildings.Controls.Continuous.LimPID conPIDrad(
    Ti=300,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.04)
    annotation (Placement(transformation(extent={{116,-52},{100,-36}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSupSetAir(description="AHU supply air temperature set point for heating",
      u(
      max=273.15 + 40,
      unit="K",
      min=273.15 + 15))
    "Overwrite AHU supply air temperature set point for heating"
    annotation (Placement(transformation(extent={{-26,-14},{-38,-2}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveCO2ZonSet(description=
        "Zone CO2 concentration setpoint", u(
      min=400,
      max=1000,
      unit="ppm")) "Overwrite CO2 setpoint" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-208,112})));

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
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonSet(description=
        "Zone temperature set point for heating", u(
      unit="K",
      min=273.15 + 10,
      max=273.15 + 30)) "Overwrite for zone temperature set point for heating"
    annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={134,-44})));
  Buildings.Utilities.IO.SignalExchange.Overwrite ovePum(description="Pump dP control signal for heating distribution system",
      u(
      min=0,
      max=50000,
      unit="Pa")) "Overwrite pump speed serving heating distribution system"
    annotation (Placement(transformation(extent={{-186,-228},{-166,-208}})));
  Modelica.Blocks.Sources.Constant Pump_dp(k=50000)
    "dP signal for pump in district heating"
    annotation (Placement(transformation(extent={{-228,-230},{-208,-210}})));
  SubModels.RadiatorSetPoint radiatorSetPoint(TsetUnocc(k=292.15), TsetOcc(k=
          295.15))
    annotation (Placement(transformation(extent={{154,-54},{174,-32}})));
equation
  connect(ahu.Tsu, conPIDcoil.u_m) annotation (Line(points={{-119.4,36},{-116,
          36},{-116,10},{-70,10},{-70,1.6}},color={0,0,127}));
  connect(splitFour.y, ou44Bdg.uSha) annotation (Line(points={{-53,204},{-32,
          204},{-32,74},{-19.6,74}}, color={0,0,127}));
  connect(shades.y, splitFour.u[1])
    annotation (Line(points={{-97,204},{-76,204}}, color={0,0,127}));
  connect(senCO2.ppm,conPIDfan. u_m)
    annotation (Line(points={{-75,68},{-184,68},{-184,70}}, color={0,0,127}));
  connect(conPIDfan.y, ahu.y)
    annotation (Line(points={{-173,82},{-142,82},{-142,55}}, color={0,0,127}));
  connect(veAirSp.y, oveTSupSetAir.u)
    annotation (Line(points={{-18.8,-8},{-24.8,-8}}, color={0,0,127}));
  connect(stpCO2.y, oveCO2ZonSet.u) annotation (Line(points={{-217,142},{-208,
          142},{-208,121.6}}, color={0,0,127}));
  connect(oveCO2ZonSet.y, conPIDfan.u_s) annotation (Line(points={{-208,103.2},
          {-208,82},{-196,82}}, color={0,0,127}));
  connect(conPIDrad.y, oveValRad.u) annotation (Line(points={{99.2,-44},{80,-44},
          {80,-40},{39.2,-40}}, color={0,0,127}));
  connect(conPIDcoil.y, oveValCoi.u)
    annotation (Line(points={{-78.8,-8},{-80.8,-8}}, color={0,0,127}));
  connect(oveTSupSetAir.y, conPIDcoil.u_s)
    annotation (Line(points={{-38.6,-8},{-60.4,-8}}, color={0,0,127}));
  connect(oveValRad.y, valRad.y) annotation (Line(points={{25.4,-40},{-12,-40},
          {-12,-108}},color={0,0,127}));
  connect(oveValCoi.y, valCoil.y) annotation (Line(points={{-94.6,-8},{-108,-8},
          {-108,-2},{-122,-2},{-122,18},{-140,18}},
                                color={0,0,127}));
  connect(oveTZonSet.y, conPIDrad.u_s)
    annotation (Line(points={{125.2,-44},{117.6,-44}}, color={0,0,127}));
  connect(Pump_dp.y,ovePum. u)
    annotation (Line(points={{-207,-220},{-198,-220},{-198,-218},{-188,-218}},
                                                       color={0,0,127}));
  connect(ovePum.y, dh.y) annotation (Line(points={{-165,-218},{-152,-218},{-152,
          -196},{-143,-196}}, color={0,0,127}));
  connect(oveTSupSetAir.y, ahu.TsupSet) annotation (Line(points={{-38.6,-8},{-50,
          -8},{-50,12},{-106,12},{-106,60},{-138,60},{-138,55},{-136.4,55}},
        color={0,0,127}));
  connect(reaTZon.y, conPIDrad.u_m) annotation (Line(points={{78.6,56},{88,56},
          {88,-62},{108,-62},{108,-53.6}}, color={0,0,127}));
  connect(radiatorSetPoint.y1, oveTZonSet.u) annotation (Line(points={{153.6,
          -42.12},{151.6,-42.12},{151.6,-44},{143.6,-44}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2678400, Interval=600),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false),
    Diagram(graphics={
        Text(
          extent={{-170,-234},{-110,-238}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="District heating
")}));
end BuildingControl;
