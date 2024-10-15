within IDEAS.Buildings.Examples;
model OpenDoorComparison
  "Comparison of two-zones models with and without an open door/cavity model"
  extends Modelica.Icons.Example;
  Validation.Cases.Case900Template zone1_a(bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall)
    "Zone with an internal wall without cavity"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Validation.Cases.Case900Template zone2_a(bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
      hasWinA=false) "Zone with a connection to internal wall of zone1_a"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Validation.Cases.Case900Template zone1_b(
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    hasCavityB=true,
    hB=2,
    wB=2) "Zone with an internal wall with cavity of 2x2 m"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Validation.Cases.Case900Template zone2_b(bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
      hasWinA=false) "Zone with a connection to internal wall of zone1_b"
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
equation
  connect(zone2_a.proBusD[1], zone1_a.proBusB[1]) annotation (Line(
      points={{20.4,43},{0,43},{0,56},{-21,56}},
      color={255,204,51},
      thickness=0.5));
  connect(zone2_b.proBusD[1], zone1_b.proBusB[1]) annotation (Line(
      points={{20.4,-57},{0,-57},{0,-44},{-21,-44}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Diagram(graphics={
        Rectangle(extent={{-60,20},{60,80}}, lineColor={28,108,200}),
        Text(
          extent={{-60,100},{60,74}},
          lineColor={28,108,200},
          textString="Two adjacent zones without cavity in wall B of zone1_a"),
        Text(
          extent={{-60,0},{60,-28}},
          lineColor={28,108,200},
          textString="Two adjacent zones with cavity in wall B of zone1_b
"),     Rectangle(extent={{-60,-80},{60,-20}}, lineColor={28,108,200})}),
    Documentation(revisions="<html>
<ul>
<li>
May 23, 2018 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
This example illustrates the temperature differences that can 
be used by using the open door/cavity option of the InternalWall model.
</p>
<p>
In this example two two-zones models are compared where 
only one of the two models has the open door option enabled.
</p>
</html>"),
    experiment(StopTime=1000000, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Examples/OpenDoorComparison.mos"
        "Simulate and plot"));
end OpenDoorComparison;
