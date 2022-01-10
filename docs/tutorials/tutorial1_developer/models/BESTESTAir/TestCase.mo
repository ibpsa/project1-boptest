within BESTESTAir;
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
    annotation (Placement(transformation(extent={{-100,-42},{-80,-22}})));
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
equation
  connect(TSetHea.y[1], con.TSetHea) annotation (Line(points={{-79,-32},{-70,
          -32},{-70,4},{-52,4}},
                            color={0,0,127}));
  connect(TSetCoo.y[1], con.TSetCoo) annotation (Line(points={{-79,30},{-70,30},
          {-70,8},{-52,8}}, color={0,0,127}));
  connect(zon.TRooAir, con.TZon) annotation (Line(points={{81,0},{90,0},{90,-20},
          {-60,-20},{-60,0},{-52,0}}, color={0,0,127}));
  connect(con.yFan, fcu.yFan) annotation (Line(points={{-29,-2},{-26,-2},{-26,
          -6},{-2,-6}},
                     color={0,0,127}));
  connect(fcu.supplyAir, zon.supplyAir)
    annotation (Line(points={{20,6},{44,6},{44,2},{54,2}}, color={0,127,255}));
  connect(zon.returnAir, fcu.returnAir) annotation (Line(points={{54,-2},{44,-2},
          {44,-10},{20,-10}}, color={0,127,255}));
  connect(con.TSupSet, fcu.TSupSet) annotation (Line(points={{-29,2},{-26,2},{
          -26,6},{-2,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=604800,
      Interval=600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    __Dymola_Commands(file(inherit=true) = "TestCase.mos"));
end TestCase;
