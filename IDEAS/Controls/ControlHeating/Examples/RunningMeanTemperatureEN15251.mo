within IDEAS.Controls.ControlHeating.Examples;
model RunningMeanTemperatureEN15251
  extends Modelica.Icons.Example;

  IDEAS.Controls.ControlHeating.RunningMeanTemperatureEN15251
    runningMeanTemperature
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(
      StopTime=10000000,
      __Dymola_NumberOfIntervals=50000,
      Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Controls/ControlHeating/Examples/RunningMeanTemperatureEN15251.mos"
        "Simulate and Plot"));
end RunningMeanTemperatureEN15251;
