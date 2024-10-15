within IDEAS.Buildings.Validation.Tests;
model EnergyConservationValidation
  "This example shows how conservation of energy can be checked."
  extends IDEAS.Buildings.Examples.ZoneExample(
    sim(computeConservationOfEnergy=true,
        strictConservationOfEnergy=true,
        Emax=1,
      interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None),
    zone(airModel(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)),
    zone1(airModel(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial),
      redeclare Components.OccupancyType.OfficeWork occTyp,
      redeclare IDEAS.Buildings.Components.InternalGains.Occupants intGaiOcc,
      redeclare IDEAS.Buildings.Components.InternalGains.Lighting intGaiLig,
      redeclare Components.LightingControl.Fixed ligCtr(ctrFix=1),
      redeclare Components.LightingType.LED ligTyp));

  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{82,-68},{62,-48}})));
equation
  connect(const.y,zone1.yOcc);

  annotation (
    experiment(
      StopTime=5000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Validation/Tests/EnergyConservationValidation.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
August 26, 2016 by Filip Jorissen:<br/>
Included occupancy in the check.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end EnergyConservationValidation;
