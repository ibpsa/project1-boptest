within BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses.Examples;
model SetPoi
  extends Modelica.Icons.Example;
  BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses.OccCon occCon(
      start_time=5, end_time=18)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses.SetPoi setPoi(
    n=2,
    setpoint_on={1,2},
    setpoint_off={3,4})
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
equation
  connect(occCon.Occ, setPoi.Occ)
    annotation (Line(points={{-18,0},{8,0}}, color={255,0,255}));
  annotation (experiment(
      StartTime=17280000,
      StopTime=17366400,
      __Dymola_Algorithm="Dassl"));
end SetPoi;
