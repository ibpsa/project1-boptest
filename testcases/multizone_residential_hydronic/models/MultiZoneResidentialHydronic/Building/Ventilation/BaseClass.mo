within MultiZoneResidentialHydronic.Building.Ventilation;
model BaseClass "Base class for ventilation"
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),
                                                    iconTransformation(extent={{-110,
            -10},{-90,10}})));
  parameter Integer nPorts=2 "Number of ports";
  parameter Modelica.SIunits.MassFlowRate m_flow_vent = 1
    "Ventilation airflow that is infiltrated or extracted";

  Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts](redeclare package
      Medium = MediumA)
    annotation (Placement(transformation(extent={{80,40},{100,-40}})));
  Modelica.Fluid.Sensors.TraceSubstances senCO2(redeclare package Medium =
        MediumA, substanceName="CO2") "CO2 sensor for room 1"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a venPort(redeclare package Medium =
        MediumA) "Ventilation port to plug any infiltration or extraction"
    annotation (Placement(transformation(extent={{50,-30},{70,-10}}),
        iconTransformation));
equation
  connect(ports_b[1], senCO2.port) annotation (Line(points={{90,20},{23,20},{23,
          60},{-10,60}},
                       color={0,127,255}));
  connect(venPort, ports_b[2])
    annotation (Line(points={{60,-20},{90,-20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseClass;
