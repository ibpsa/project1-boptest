within IDEAS.Templates.Examples;
model RadiatorHeating "Model with radiator heating"
  extends IDEAS.Templates.Examples.IdealRadiatorHeating(redeclare
      IDEAS.Templates.Heating.RadiatorHeating heating);
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
          "Resources/Scripts/Dymola/Templates/Examples/RadiatorHeating.mos"
        "Simulate and plot"));
end RadiatorHeating;
