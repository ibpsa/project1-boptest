within IDEAS.Templates.Examples;
model NoVentilation
  "Example of model without ventilation system"
  extends IDEAS.Templates.Examples.ConstantAirFlowRecup(redeclare
      IDEAS.Templates.Ventilation.None constantAirFlowRecup);
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    Documentation(info="<html>
<p>
Model demonstrating the use of the ventilation system template 
by redeclaring the ventilation model of 
<a href=modelica://IDEAS.Templates.Ventilation.Examples.ConstantAirFlowRecup>ConstantAirFlowRecup</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 23, 2017 by Glenn Reynders:<br/>
Revised implementation
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Templates/Examples/NoVentilation.mos"
        "Simulate and Plot"),
    experiment(
      StopTime=2000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end NoVentilation;
