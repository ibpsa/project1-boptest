within BuildingControlEmulator.Devices.Fault;
model FloSensorDev
  extends BaseClasses.MassFlowRate;
  parameter Real dm = 0 "Constant deviation ratio of flow measurement";
  parameter Modelica.Units.SI.Time FauTime=0 "Time when faults start to occur";
  Modelica.Blocks.Interfaces.RealOutput m_flow(quantity="MassFlowRate",
                                               final unit="kg/s")
    "Mass flow rate from port_a to port_b" annotation (Placement(
        transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));
equation

  m_flow = noEvent(if time>FauTime then m_flow_real*(1+dm) else m_flow_real);

    annotation (Placement(transformation(extent={{100,-10},{120,10}})),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end FloSensorDev;
