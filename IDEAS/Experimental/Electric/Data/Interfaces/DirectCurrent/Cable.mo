within IDEAS.Experimental.Electric.Data.Interfaces.DirectCurrent;
record Cable "Low Voltage DC Cable Type"
extends Modelica.Icons.MaterialProperty;
  parameter
    IDEAS.Experimental.Electric.BaseClasses.Types.CharacteristicResistance RCha
    "Characteristic Resistance of the Cable";

parameter Modelica.SIunits.ElectricCurrent In
    "Nominal Electrical Current Fused";
end Cable;
