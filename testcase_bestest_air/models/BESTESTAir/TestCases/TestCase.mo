within BESTESTAir.TestCases;
model TestCase "Testcase model"
  extends Modelica.Icons.Example;
  BaseClasses.Case900FF zon
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,15 + 273.15; 8*3600,21 + 273.15; 18*3600,15 + 273.15; 24*3600,15
         + 273.15])
    "Heating temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,-52},{-80,-32}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetCoo(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,30 + 273.15; 8*3600,24 + 273.15; 18*3600,30 + 273.15; 24*3600,30
         + 273.15])
    "Cooling temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  BaseClasses.Thermostat con
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  BaseClasses.FanCoilUnit fcu(dpAir_nominal(displayUnit="Pa"))
    annotation (Placement(transformation(extent={{0,-14},{20,14}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSetHea(description=
        "Zone temperature setpoint for heating", u(
      max=273.15 + 23,
      unit="K",
      min=273.15 + 15)) "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(
      unit="K",
      min=273.15 + 23,
      max=273.15 + 30), description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTRooAir(
    description="Zone air temperature",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K")) "Read room air temperature"
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPCoo(
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    description="Cooling electrical power consumption")
    "Read power for cooling"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPHea(
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heating thermal power consumption") "Read power for heating"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPFan(
    y(unit="W"),
    description="Supply fan electrical power consumption",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
    "Read power for supply fan"
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
equation
  connect(con.yFan, fcu.yFan) annotation (Line(points={{-29,-2},{-26,-2},{-26,
          -6},{-2,-6}},
                     color={0,0,127}));
  connect(fcu.supplyAir, zon.supplyAir)
    annotation (Line(points={{20,6},{44,6},{44,2},{54,2}}, color={0,127,255}));
  connect(zon.returnAir, fcu.returnAir) annotation (Line(points={{54,-2},{44,-2},
          {44,-10},{20,-10}}, color={0,127,255}));
  connect(con.TSupSet, fcu.TSupSet) annotation (Line(points={{-29,2},{-26,2},{
          -26,6},{-2,6}}, color={0,0,127}));
  connect(TSetHea.y[1], oveTSetHea.u) annotation (Line(points={{-79,-42},{-76,
          -42},{-76,-50},{-72,-50}}, color={0,0,127}));
  connect(oveTSetHea.y, con.TSetHea) annotation (Line(points={{-49,-50},{-40,
          -50},{-40,-32},{-70,-32},{-70,4},{-52,4}}, color={0,0,127}));
  connect(TSetCoo.y[1], oveTSetCoo.u) annotation (Line(points={{-79,30},{-76,30},
          {-76,40},{-72,40}}, color={0,0,127}));
  connect(oveTSetCoo.y, con.TSetCoo) annotation (Line(points={{-49,40},{-40,40},
          {-40,20},{-70,20},{-70,8},{-52,8}}, color={0,0,127}));
  connect(zon.TRooAir, reaTRooAir.u) annotation (Line(points={{81,0},{100,0},{
          100,-30},{82,-30}}, color={0,0,127}));
  connect(reaTRooAir.y, con.TZon) annotation (Line(points={{59,-30},{-60,-30},{
          -60,0},{-52,0}}, color={0,0,127}));
  connect(fcu.PCoo, reaPCoo.u) annotation (Line(points={{21,14},{32,14},{32,80},
          {58,80}}, color={0,0,127}));
  connect(fcu.PHea, reaPHea.u) annotation (Line(points={{21,12},{36,12},{36,60},
          {58,60}}, color={0,0,127}));
  connect(reaPFan.u, fcu.PFan) annotation (Line(points={{58,40},{40,40},{40,10},
          {21,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end TestCase;
