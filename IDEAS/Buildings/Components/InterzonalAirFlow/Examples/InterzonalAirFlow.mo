within IDEAS.Buildings.Components.InterzonalAirFlow.Examples;
model InterzonalAirFlow "Comparison of interzonal air flow models"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  IDEAS.Buildings.Validation.Cases.Case900Template zoneAirTight(
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.AirTight interzonalAirFlow)
    "Zone with air tight air flow model"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  IDEAS.Buildings.Validation.Cases.Case900Template zoneFixedPressure(
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.FixedPressure interzonalAirFlow)
    "Zone with fixed pressure air flow model"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  IDEAS.Buildings.Validation.Cases.Case900Template zoneFixedPressureN50(
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow)
    "Zone with fixed pressure air flow model and n50"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  IDEAS.Buildings.Validation.Cases.Case900Template zoneAirTightN50(
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50Tight interzonalAirFlow)
    "Zone with air tight air flow model and n50"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This model compares all interzonal air flow models for 
BESTEST Case 900. Since this is a simple example, 
the only observed differences are between the n50 and non-n50 cases.
</p>
</html>", revisions="<html>
<ul>
<li>
May 24, 2018 by Filip Jorissen:<br/>
First version.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/InterzonalAirFlow/Examples/InterzonalAirFlow.mos"
        "Simulate and plot"));
end InterzonalAirFlow;
