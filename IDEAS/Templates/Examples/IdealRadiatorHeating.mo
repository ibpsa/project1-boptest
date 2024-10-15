within IDEAS.Templates.Examples;
model IdealRadiatorHeating "Example and test for ideal heating with radiators"
  extends IDEAS.Templates.Examples.BaseClasses.SimpleHeatingsystem(redeclare
      Heating.IdealRadiatorHeating heating);

equation
  connect(structure.heatPortRad,
    heating.heatPortRad) annotation (Line(points={{-20,8.8},{0,8.8},{0,8.8},{
          20,8.8}}, color={191,0,0}));
  connect(structure.heatPortCon,
    heating.heatPortCon) annotation (Line(points={{-20,13.2},{0,13.2},{0,13.2},
          {20,13.2}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=100000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>
Model that demonstrates the use of the 
<a href=\"modelica://IDEAS.Templates.Heating.IdealRadiatorHeating\">
IDEAS.Templates.Heating.IdealRadiatorHeating</a>.
</p>
</html>",     revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>
January 23, 2017 by Glenn Reynders:<br/>
Revised
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Templates/Examples/IdealRadiatorHeating.mos"
        "Simulate and Plot"));
end IdealRadiatorHeating;
