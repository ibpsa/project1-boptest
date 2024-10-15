within IDEAS.Buildings.Components.Examples;
model LightingControl
  "Example model that demonstrates the use of the lighting control in a zone"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zoneFixed(redeclare
      IDEAS.Buildings.Components.LightingType.LED ligTyp,
      redeclare IDEAS.Buildings.Components.LightingControl.Fixed ligCtr(ctrFix=1))
                                   "Zone with fixed lighting control (always on)"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zoneInput(redeclare
      IDEAS.Buildings.Components.LightingType.LED ligTyp,           redeclare
      IDEAS.Buildings.Components.LightingControl.Input ligCtr)
    "Zone with input for lighting control"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zoneBlock(redeclare
      IDEAS.Buildings.Components.LightingType.LED ligTyp,           redeclare
      IDEAS.Buildings.Components.LightingControl.CustomBlock ligCtr(redeclare
        Modelica.Blocks.Sources.Sine singleOutput(
        freqHz=0.001,
        amplitude=1,
        offset=1)))                "Zone with block replaceable for lighting control"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1000,
    offset=0,
    height=1) annotation (Placement(transformation(extent={{40,0},{20,20}})));

  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zoneOcc(
    useOccNumInput=false,
    redeclare IDEAS.Buildings.Components.LightingType.LED ligTyp,
    redeclare IDEAS.Buildings.Components.LightingControl.OccupancyBased ligCtr,
    redeclare IDEAS.Buildings.Components.Occupants.CustomBlock occNum(
        redeclare Modelica.Blocks.Sources.Step singleOutput(height=2, startTime=
           1000))) "Zone with lighting control based on occupancy"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));

equation
  connect(ramp.y, zoneInput.uLig) annotation (Line(points={{19,10},{0,10},{0,17},
          {-18,17}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This example demonstrates the use of the lighting control options of the zone model. 
</p>
</html>", revisions="<html>
<ul>
<li>
September 17, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>"),
    experiment(
      StopTime=2000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/LightingControl.mos"
        "Simulate and plot"));
end LightingControl;
