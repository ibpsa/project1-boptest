within IDEAS.Buildings.Examples;
model InternalGainExample
  "Example model with and without internal gains model"
  extends Modelica.Icons.Example;
  package MediumAir = IDEAS.Media.Air(extraPropertiesNames={"CO2"});
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));


  IDEAS.Buildings.Validation.Cases.Case900 case900_default(redeclare package
      MediumAir =                                                                        MediumAir)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  IDEAS.Buildings.Validation.Cases.Case900 case900_gains(
    redeclare package MediumAir = MediumAir, building(gF(
        redeclare IDEAS.Buildings.Components.InternalGains.Occupants intGaiOcc,
        redeclare IDEAS.Buildings.Components.Occupants.Input occNum,
        redeclare IDEAS.Buildings.Components.OccupancyType.OfficeWork occTyp)))
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Sources.Pulse occ(
    amplitude=1,
    period=3600*24,
    startTime=6*3600) "Occupancy: outut used in code"
    annotation (Placement(transformation(extent={{80,0},{60,20}})));
  Modelica.Blocks.Sources.RealExpression ppms[2](y={case900_gains.building.gF.ppm,
        case900_default.building.gF.ppm})
    annotation (Placement(transformation(extent={{-4,-54},{16,-34}})));
equation
  // equation for setting number of zone occupants
  case900_gains.building.gF.yOcc =occ.y;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model demonstrating the use of the comfort evaluation model and CO2 modelling.</p>
</html>", revisions="<html>
<ul>
<li>
April 10, 2019 by Filip Jorissen:<br/>
Corrected molar mass fraction for consistency.
See <a href=https://github.com/open-ideas/IDEAS/issues/1004>#1004</a>.
</li>
<li>
July 26, 2018 by Filip Jorissen:<br/>
Updated example for <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
<li>
August 24, 2016 by Filip Jorissen:<br/>
Added demonstration of how to model CO2.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Examples/InternalGainExample.mos"
        "Simulate and plot"),
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end InternalGainExample;
