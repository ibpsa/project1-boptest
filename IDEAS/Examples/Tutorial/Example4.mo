within IDEAS.Examples.Tutorial;
model Example4 "Including custom occupant schedule"
  extends Example3(zone(redeclare OccSched occNum(k=2)));

protected
  model OccSched "Simple occupancy schedule"
    extends IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants(final useInput=false);

    parameter Real k "Number of occupants";
    Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Sources.RealExpression occ(y=if calTim.weekDay < 6 and (
          calTim.hour > 7 and calTim.hour < 18) then k else 0)
      "Number of occupants present"
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    connect(occ.y, nOcc)
      annotation (Line(points={{1,0},{120,0}}, color={0,0,127}));
  end OccSched;
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
This example extends the third example by adding a
custom occupancy model that uses an occupancy schedule.
</p>
</html>"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Examples/Tutorial/Example4.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end Example4;
