within IDEAS.Templates.Examples;
model IdealFloorHeating "Model with idealised floor heating"
  extends IDEAS.Templates.Examples.BaseClasses.SimpleHeatingsystem(redeclare
      Heating.IdealFloorHeating heating, redeclare
      Structure.Case900FloorHeating structure);
equation
  connect(structure.heatPortEmb,
    heating.heatPortEmb) annotation (Line(points={{-20,17.6},{0,17.6},{0,17.6},
          {20,17.6}}, color={191,0,0}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
June 8, 2018 by Filip Jorissen:<br/>
First implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"),
         experiment(
      StopTime=100000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Templates/Examples/IdealFloorHeating.mos"
        "Simulate and plot"));
end IdealFloorHeating;
