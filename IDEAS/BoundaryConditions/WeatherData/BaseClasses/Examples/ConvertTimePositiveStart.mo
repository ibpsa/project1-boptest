within IDEAS.BoundaryConditions.WeatherData.BaseClasses.Examples;
model ConvertTimePositiveStart
  "Validation of time conversion for positive start time"
  extends IDEAS.BoundaryConditions.WeatherData.BaseClasses.Examples.ConvertTime;
  annotation (
  Documentation(info="<html>
<p>
This example tests the model that converts time for positive start time.
</p>
</html>",
revisions="<html>
<ul>
<li>
March 4, 2019, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
  experiment(Tolerance=1e-6, StartTime=47174400, StopTime=126144000),
__Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/BoundaryConditions/WeatherData/BaseClasses/Examples/ConvertTimePositiveStart.mos"
        "Simulate and plot"));
end ConvertTimePositiveStart;
