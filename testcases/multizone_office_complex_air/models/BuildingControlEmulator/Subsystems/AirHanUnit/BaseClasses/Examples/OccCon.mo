within BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses.Examples;
model OccCon
  extends Modelica.Icons.Example;
  BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses.OccCon occCon(
      start_time=5, end_time=18)
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  annotation (experiment(
      StartTime=17280000,
      StopTime=17366400,
      __Dymola_Algorithm="Dassl"));
end OccCon;
