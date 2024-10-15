within IDEAS.Buildings.Components.Interfaces;
model SetVolume "Block for setting volume of the zone"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Volume V "Zone volume";
  VolumePort volumePort "Port for setting volume"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
equation
  volumePort.V=V;
end SetVolume;
