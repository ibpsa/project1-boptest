within IDEAS.Templates.Examples;
model TemplateExample
  extends IDEAS.Templates.Interfaces.Building(
    redeclare Structure.ThreeZone building,
    redeclare Templates.Ventilation.None ventilationSystem,
    redeclare BoundaryConditions.Occupants.Standards.None occupant,
    redeclare Templates.Heating.None heatingSystem,
    redeclare Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TemplateExample;
