within IDEAS.Templates.Examples.BaseClasses;
partial model SimpleHeatingsystem
  "Example model of a structure coupled to a heating system"
  extends Modelica.Icons.Example;
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  final parameter Integer nZones=structure.nZones "Number of zones";
  replaceable IDEAS.Templates.Heating.BaseClasses.HysteresisHeating heating
    constrainedby IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    final nZones=nZones,
    QNom={2000 for i in 1:nZones},
    Q_design=structure.Q_design) annotation (choicesAllMatching=true, Placement(
        transformation(extent={{20,0},{60,22}})));
  replaceable IDEAS.Templates.Structure.Case900 structure constrainedby
    IDEAS.Templates.Interfaces.BaseClasses.Structure "Building structure"
    annotation (Placement(transformation(extent={{-54,0},{-20,22}})),
      __Dymola_choicesAllMatching=true);

  Modelica.Blocks.Sources.Constant TSet(k=273.15 + 22)
    "Temperature set point for zone"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(structure.TSensor, heating.TSensor) annotation (Line(
      points={{-19.32,4.4},{19.6,4.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSet.y, heating.TSet[1])
    annotation (Line(points={{21,-30},{40,-30},{40,-0.22}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=200000,
      Interval=900,
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
May 2, 2019 by Filip Jorissen:<br/>
Revised <code>constrainedby</code> for OpenModelica compatibility.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1024\">#1024</a>.
</li>
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
    __Dymola_Commands);
end SimpleHeatingsystem;
