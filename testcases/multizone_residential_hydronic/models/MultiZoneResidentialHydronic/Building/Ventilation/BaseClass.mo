within MultiZoneResidentialHydronic.Building.Ventilation;
model BaseClass "Base class for ventilation"
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),
                                                    iconTransformation(extent={{-110,
            -10},{-90,10}})));
  parameter Integer nPorts=1 "Number of ports";
  parameter Modelica.SIunits.MassFlowRate m_flow_vent = 1
    "Ventilation airflow that is infiltrated or extracted";
  package MediumA = Buildings.Media.Air "Medium model";

  Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts]
    annotation (Placement(transformation(extent={{80,-40},{100,40}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseClass;
