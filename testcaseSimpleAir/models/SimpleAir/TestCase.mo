within SimpleAir;
model TestCase "Testcase model"
  extends Modelica.Icons.Example;
  BaseClasses.Case900FF zon
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,15 + 273.15; 8*3600,21 + 273.15; 18*3600,15 + 273.15; 24*3600,15
         + 273.15])
    "Heating temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetCoo(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,30 + 273.15; 8*3600,24 + 273.15; 18*3600,30 + 273.15; 24*3600,30
         + 273.15])
    "Cooling temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  BaseClasses.Thermostat con
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  BaseClasses.FanCoilUnit fcu(mAir_flow_nominal=0.75)
    annotation (Placement(transformation(extent={{-10,-14},{10,14}})));
equation
  connect(TSetHea.y[1], con.TSetHea) annotation (Line(points={{-79,10},{-76,10},
          {-76,4},{-52,4}}, color={0,0,127}));
  connect(TSetCoo.y[1], con.TSetCoo) annotation (Line(points={{-79,50},{-70,50},
          {-70,8},{-52,8}}, color={0,0,127}));
  connect(zon.TRooAir, con.TZon) annotation (Line(points={{73,0},{90,0},{90,-20},
          {-70,-20},{-70,0},{-52,0}}, color={0,0,127}));
  connect(con.yCoo, fcu.yCooVal) annotation (Line(points={{-29,8},{-22,8},{-22,
          6},{-12,6}}, color={0,0,127}));
  connect(con.yHea, fcu.yHeaVal) annotation (Line(points={{-29,4},{-24,4},{-24,
          0},{-12,0}}, color={0,0,127}));
  connect(con.yFan, fcu.yFan) annotation (Line(points={{-29,0},{-26,0},{-26,-6},
          {-12,-6}}, color={0,0,127}));
  connect(fcu.supplyAir, zon.supplyAir)
    annotation (Line(points={{10,6},{16,6},{16,2},{46,2}}, color={0,127,255}));
  connect(zon.returnAir, fcu.returnAir) annotation (Line(points={{46,-2},{16,-2},
          {16,-10},{10,-10}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      Interval=300,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end TestCase;
