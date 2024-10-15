within IDEAS.Experimental.Electric.Photovoltaics.Examples;
model UsePVGeneral
extends Modelica.Icons.Example;
  PVSystemGeneral pVSystemGeneral(inc=20/180*3.1415, amount=20)
    annotation (Placement(transformation(extent={{-80,46},{-60,66}})));
  PvSystemGeneralFromFile pvSystemGeneralFromFile(PNom=20*230.153)
    annotation (Placement(transformation(extent={{-80,-14},{-60,6}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(f=50, V=230) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-24})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{20,-74},{40,-54}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor
    powerSensorPV
    annotation (Placement(transformation(extent={{-20,46},{0,66}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor
    powerSensorPVFile
    annotation (Placement(transformation(extent={{-20,-14},{0,6}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  inner
    IDEAS.Experimental.Electric.Photovoltaics.Components.ForInputFiles.PVProfileReader
    PV1(fileName="../Inputs/PV_Inc20_Azi0.txt")
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
equation
  connect(ground.pin, voltageSource.pin_n) annotation (Line(
      points={{30,-54},{30,-44},{30,-34},{30,-34}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(pVSystemGeneral.pin[1], powerSensorPV.currentP) annotation (Line(
      points={{-59.8,60},{-40,60},{-40,56},{-20,56}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(pvSystemGeneralFromFile.pin[1], powerSensorPVFile.currentP)
    annotation (Line(
      points={{-59.8,0},{-40,0},{-40,-4},{-20,-4}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(powerSensorPVFile.currentN, voltageSource.pin_p) annotation (Line(
      points={{0,-4},{30,-4},{30,-14}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(powerSensorPV.currentN, voltageSource.pin_p) annotation (Line(
      points={{0,56},{30,56},{30,-14}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(powerSensorPVFile.voltageP, powerSensorPVFile.currentP) annotation (
      Line(
      points={{-10,6},{-20,6},{-20,-4}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(powerSensorPV.voltageP, powerSensorPV.currentP) annotation (Line(
      points={{-10,66},{-20,66},{-20,56}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(powerSensorPV.voltageN, voltageSource.pin_n) annotation (Line(
      points={{-10,46},{10,46},{10,-34},{30,-34}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(powerSensorPVFile.voltageN, voltageSource.pin_n) annotation (Line(
      points={{-10,-14},{-10,-34},{30,-34}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=3.1536e+007, Interval=600),
    __Dymola_experimentSetupOutput);
end UsePVGeneral;
