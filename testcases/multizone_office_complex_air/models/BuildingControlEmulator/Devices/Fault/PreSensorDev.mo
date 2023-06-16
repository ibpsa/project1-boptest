within BuildingControlEmulator.Devices.Fault;
model PreSensorDev
  extends BaseClasses.Pressure;
  parameter Real dp = 0 "Constant deviation ratio of pressure measurement";
  parameter Modelica.Units.SI.Time FauTime=0 "Time when faults start to occur";
  Modelica.Blocks.Interfaces.RealOutput p(final quantity="AbsolutePressure",
                                          final unit="Pa",
                                          min=0) "Pressure at port"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  p = noEvent(if time>FauTime then p_real*(1+dp) else p_real);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PreSensorDev;
