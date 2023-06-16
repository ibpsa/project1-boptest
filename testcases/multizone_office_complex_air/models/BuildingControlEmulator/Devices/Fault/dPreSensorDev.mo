within BuildingControlEmulator.Devices.Fault;
model dPreSensorDev
  extends BaseClasses.RelativePressure;
  parameter Real dp = 0 "Constant deviation ratio of pressure measurement";
  parameter Modelica.Units.SI.Time FauTime=0 "Time when faults start to occur";
  Modelica.Blocks.Interfaces.RealOutput p_rel(final quantity="PressureDifference",
                                              final unit="Pa",
                                              displayUnit="Pa")
    "Relative pressure of port_a minus port_b" annotation (Placement(transformation(
        origin={0,-90},
        extent={{10,-10},{-10,10}},
        rotation=90)));


equation

  p_rel = noEvent(if time>FauTime then p_real*(1+dp) else p_real);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end dPreSensorDev;
