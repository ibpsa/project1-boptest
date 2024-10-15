within IDEAS.Examples.Tutorial;
model Example2 "Adding closed screens"
  extends Example1(window(redeclare Buildings.Components.Shading.Screen shaType));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
equation
  connect(const.y, window.Ctrl)
    annotation (Line(points={{-79,-50},{-26,-50},{-26,-34}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This second example file extends the first example and adds a solar shading screen to the window model. 
Compare the simulation outputs to see the impact on the zone temperature.
</p>
</html>", revisions="<html>
<ul>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/Example2.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end Example2;
