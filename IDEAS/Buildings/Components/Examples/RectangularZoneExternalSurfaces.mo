within IDEAS.Buildings.Components.Examples;
model RectangularZoneExternalSurfaces
  "Example which illustrates how to use external propBus of zone template"
  extends RectangularZone(zoneIntWal(
      hasInt=false,
      nExtA=2,
      bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
      nExtB=2), zone(bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.None,
        nSurfExt=2));
  IDEAS.Buildings.Components.OuterWall outerWall[2](
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=zone.aziA,
    A=zone.h*zone.l/2)
    annotation (Placement(transformation(extent={{-64,48},{-52,68}})));
  IDEAS.Buildings.Components.OuterWall outerWall1[2](
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=zone.aziA,
    A=zone.h*zone.l/2)
    annotation (Placement(transformation(extent={{-60,-34},{-48,-14}})));
equation
  connect(outerWall[1].propsBus_a, zone.proBusExt[1]) annotation (Line(
      points={{-53,60},{-24,60}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall[2].propsBus_a, zone.proBusExt[2]) annotation (Line(
      points={{-53,60},{-24,60}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall1[1].propsBus_a, zoneIntWal.proBusA[1]) annotation (Line(
      points={{-49,-22},{-12,-22}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall1[2].propsBus_a, zoneIntWal.proBusA[2]) annotation (Line(
      points={{-49,-22},{-12,-22}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=604800,
      Tolerance=1e-006,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This example illustrates the two options for external surfaces: 
they can either be connected to the general external propsBus or
to a face related propsBus.
</p>
</html>", revisions="<html>
<ul>
<li>
August 28, 2018 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file(inherit=true) = "Resources/Scripts/Dymola/Buildings/Components/Examples/RectangularZoneExternalSurfaces.mos"
        "Simulate and Plot"));
end RectangularZoneExternalSurfaces;
