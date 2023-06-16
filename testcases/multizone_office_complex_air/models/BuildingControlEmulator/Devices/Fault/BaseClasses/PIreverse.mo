within BuildingControlEmulator.Devices.Fault.BaseClasses;
model PIreverse

    parameter Boolean reverseAction = false
    "Set to true for throttling the water flow rate through a cooling coil controller";

  final parameter Real revAct = if reverseAction then -1 else 1
    "Switch for sign for reverse action";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PIreverse;
