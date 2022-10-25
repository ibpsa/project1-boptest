within EPlusLargeOffice.Testcases;
model LargeOffice
  extends Modelica.Icons.Example;

  BaseClasses.whoBui96 EPlus96(building(spawnExe="spawn-0.3.0-8d93151657"))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Pulse pulse [15](
    each amplitude=-4,
    each width=62.5,
    each period(displayUnit="h") = 86400,
    each offset=28 + 273.15,
    each startTime(displayUnit="h") = 21600)  annotation (Placement(transformation(
          extent={{-60,-10},{-40,10}})));

equation
  connect(pulse[1].y, EPlus96.Temp1)
    annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
  connect(EPlus96.Temp2, pulse[2].y);
  connect(EPlus96.Temp3, pulse[3].y);
  connect(EPlus96.Temp4, pulse[4].y);
  connect(EPlus96.Temp5, pulse[5].y);
  connect(EPlus96.Temp1_top, pulse[6].y);
  connect(EPlus96.Temp2_top, pulse[7].y);
  connect(EPlus96.Temp3_top, pulse[8].y);
  connect(EPlus96.Temp4_top, pulse[9].y);
  connect(EPlus96.Temp5_top, pulse[10].y);
  connect(EPlus96.Temp1_bot, pulse[11].y);
  connect(EPlus96.Temp2_bot, pulse[12].y);
  connect(EPlus96.Temp3_bot, pulse[13].y);
  connect(EPlus96.Temp4_bot, pulse[14].y);
  connect(EPlus96.Temp5_bot, pulse[15].y);

 annotation (
    experiment(
      StartTime=17107200,
      StopTime=18316800,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end LargeOffice;
