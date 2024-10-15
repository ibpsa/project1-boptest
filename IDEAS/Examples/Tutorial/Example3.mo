within IDEAS.Examples.Tutorial;
model Example3 "Adding occupant and lighting"
  extends Example2(zone(
      redeclare replaceable Buildings.Components.Occupants.Fixed occNum(nOccFix=1),
      redeclare Buildings.Components.OccupancyType.OfficeWork occTyp,
      redeclare Buildings.Components.RoomType.Office rooTyp,
      redeclare Buildings.Components.LightingType.LED ligTyp,
      redeclare Buildings.Components.LightingControl.OccupancyBased ligCtr));
  annotation (
    Documentation(revisions="<html>
<ul>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>", info="<html>
<p>
This example extends the second example by adding an occupant and lighting model.
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/Example3.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end Example3;
