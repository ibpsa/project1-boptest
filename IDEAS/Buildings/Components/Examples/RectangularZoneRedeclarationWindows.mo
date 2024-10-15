within IDEAS.Buildings.Components.Examples;
model RectangularZoneRedeclarationWindows
  "Example that illustrates the redeclaration of windows using the RectangularZoneTemplate model"
  extends IDEAS.Buildings.Components.Examples.RectangularZone(
    zoneIntWal(hasInt=false,
    redeclare BaseClasses.Window winA));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=604800,
      Tolerance=1e-006,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This example illustrates the redeclaration of windows using the rectangular zone template.

</p>
</html>", revisions="<html>
<ul>
<li>
August 10, 2018 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file(inherit=true) = "Resources/Scripts/Dymola/Buildings/Components/Examples/RectangularZoneRedeclarationWindows.mos"
        "Simulate and Plot"));
end RectangularZoneRedeclarationWindows;
