within IDEAS.Buildings.Components.ThermalBridges;
record None "No thermal bridge included"

  extends IDEAS.Buildings.Components.ThermalBridges.BaseClasses.ThermalBridge(
    final G=0,
    final present=false);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end None;
