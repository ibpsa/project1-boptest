within IDEAS.Buildings.Examples;
model Structure "Example building structure model"
  extends Modelica.Icons.Example;
  Templates.Structure.ThreeZone structure(redeclare package Medium =
        IDEAS.Media.Air)
    annotation (Placement(transformation(extent={{-36,-20},{-6,0}})));
  Templates.Ventilation.None none(
    nLoads=0,
    nZones=structure.nZones,
    VZones=structure.VZones,
    redeclare package Medium = IDEAS.Media.Air)
    annotation (Placement(transformation(extent={{20,0},{60,20}})));
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo[3]
    annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
  Modelica.Blocks.Sources.Cosine cosine[3](
    each amplitude=300,
    each offset = 100,
    each freqHz=1/864000,
    phase={0,261.79938779915,523.5987755983})
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation
  connect(structure.port_b, none.port_a) annotation (Line(
      points={{-23,0},{-24,0},{-24,12},{20,12}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(structure.port_a, none.port_b) annotation (Line(
      points={{-19,0},{-20,0},{-20,8},{20,8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(structure.TSensor, none.TSensor) annotation (Line(
      points={{-5.4,-16},{8,-16},{8,4},{19.6,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cosine.y, preHeaFlo.Q_flow) annotation (Line(points={{-19,-40},{-13.5,
          -40},{-8,-40}}, color={0,0,127}));
  connect(preHeaFlo.port, structure.heatPortEmb) annotation (Line(points={{12,-40},
          {14,-40},{14,-4},{-6,-4}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=8640000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Examples/Structure.mos"
        "Simulate and plot"));
end Structure;
