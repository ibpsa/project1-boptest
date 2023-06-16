within BuildingControlEmulator.Devices.Fault;
model TemSensorDev
  extends BaseClasses.TemperatureTwoPort;
  Modelica.Blocks.Interfaces.RealOutput T(final quantity="ThermodynamicTemperature",
                                          final unit="K",
                                          displayUnit = "degC",
                                          min = 0,
                                          start=T_start)
    "Temperature of the passing fluid"
       annotation (Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));

  parameter Modelica.Units.SI.TemperatureDifference dt=0
    "Constant deviation of temperature measurement";
  parameter Modelica.Units.SI.Time FauTime=0 "Time when faults start to occur";

equation

  T = noEvent(if time>FauTime then T_real + dt else T_real);
    annotation (Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));
end TemSensorDev;
