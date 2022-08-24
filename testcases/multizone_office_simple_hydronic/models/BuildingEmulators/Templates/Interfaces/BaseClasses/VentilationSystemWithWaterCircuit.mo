within BuildingEmulators.Templates.Interfaces.BaseClasses;
partial model VentilationSystemWithWaterCircuit
  extends BuildingEmulators.Templates.Interfaces.BaseClasses.VentilationSystem;

  parameter Integer nVen(min=1) = 1 "Number of ventilation units";

  replaceable package MediumWater = IDEAS.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Water medium in the component";


  Modelica.Fluid.Interfaces.FluidPort_a[nVen] portHea_a(redeclare each package
      Medium =         MediumWater)
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b[nVen] portHea_b(redeclare each package
      Medium =         MediumWater)
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b[nVen] portCoo_b(redeclare each package
      Medium =         MediumWater)
    annotation (Placement(transformation(extent={{20,-110},{40,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a[nVen] portCoo_a(redeclare each package
      Medium =         MediumWater)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
end VentilationSystemWithWaterCircuit;
