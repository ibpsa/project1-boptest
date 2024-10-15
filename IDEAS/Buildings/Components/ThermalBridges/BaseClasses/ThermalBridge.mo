within IDEAS.Buildings.Components.ThermalBridges.BaseClasses;
record ThermalBridge "Record data for thermal bridges"

  parameter Modelica.SIunits.ThermalConductance G "Effective thermal loss";
  parameter Boolean present = true
    annotation(Evaluate=true);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermalBridge;
