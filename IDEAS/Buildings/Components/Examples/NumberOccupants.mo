within IDEAS.Buildings.Components.Examples;
model NumberOccupants
  "Example model that demonstrates the use of the number of occupants in a zone"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zoneFixed(
    redeclare Occupants.Fixed occNum(nOccFix=2),
    useOccNumInput=false) "Zone with fixed number of occupants"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zoneInput(
    redeclare Occupants.Input occNum)
    "Zone with input for number of occupants"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zoneBlock(
    useOccNumInput=false,
    redeclare Occupants.CustomBlock occNum(
        redeclare Modelica.Blocks.Sources.Sine
        singleOutput(
        amplitude=2,
        freqHz=0.001,
        offset=2)),
    redeclare IDEAS.Buildings.Components.LightingType.LED ligTyp,
    redeclare IDEAS.Buildings.Components.LightingControl.CustomBlock ligCtr(
        redeclare Modelica.Blocks.Sources.Sine singleOutput(
        amplitude=2,
        freqHz=0.001,
        offset=2))) "Zone with block replaceable for number of occupants"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=4,
    duration=1000,
    offset=0) annotation (Placement(transformation(extent={{40,0},{20,20}})));

  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zoneAreaWeightedInput(
    redeclare  Occupants.AreaWeightedInput occNum)
    "Zone with area weighted input for number of occupants"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Sources.Ramp occDen(
    duration=1000,
    offset=0,
    height=1/15) "Occupancy density of 15m2 per person"
    annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
equation
  connect(ramp.y, zoneInput.yOcc) annotation (Line(points={{19,10},{0,10},{0,14},
          {-18,14}},     color={0,0,127}));
  connect(occDen.y, zoneAreaWeightedInput.yOcc) annotation (Line(points={{19,-70},
          {2,-70},{2,-66},{-18,-66}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This example demonstrates how the number of 
occupants can be defined in a zone model. 
</p>
</html>", revisions="<html>
<ul>
<li>
March 28, 2019 by Filip Jorissen:<br/>
Revised implementation
for <a href=\"https://github.com/open-ideas/IDEAS/issues/998\">#998</a>.
</li>
<li>
January 26, 2018 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
</ul>
</html>"),
    experiment(
      StopTime=2000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/NumberOccupants.mos"
        "Simulate and plot"));
end NumberOccupants;
