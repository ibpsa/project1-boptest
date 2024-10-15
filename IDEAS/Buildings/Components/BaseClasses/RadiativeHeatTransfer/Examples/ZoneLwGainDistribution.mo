within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.Examples;
model ZoneLwGainDistribution
  import IDEAS;
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp ramDir(
    duration=1,
    height=1000,
    offset=0) "Input signal for direct heat gains"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem(T=295.15)
    "Fixed temperature boundary condition corresponding to zone temperature"
    annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
  Modelica.Blocks.Sources.Constant epsSw(k=0.6) "Shortwave emissivity"
    annotation (Placement(transformation(extent={{98,58},{82,74}})));
  Modelica.Blocks.Sources.Constant A(k=10) "Heat exchange surface area"
    annotation (Placement(transformation(extent={{98,84},{82,100}})));
  Modelica.Blocks.Sources.Constant inc[6](k={IDEAS.Types.Tilt.Floor,IDEAS.Types.Tilt.Ceiling,
        IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall})
    "Inclinations"
    annotation (Placement(transformation(extent={{98,6},{82,22}})));
  Modelica.Blocks.Sources.Constant azi[6](k={IDEAS.Types.Azimuth.S,IDEAS.Types.Azimuth.S,
        IDEAS.Types.Azimuth.S,IDEAS.Types.Azimuth.N,IDEAS.Types.Azimuth.W,
        IDEAS.Types.Azimuth.E}) "Azimuth angles"
    annotation (Placement(transformation(extent={{98,-20},{82,-4}})));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwGainDistribution
    zonLwGaiDist(nSurf=6) "Radiative heat gain distribution model"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaDir
    "Prescribed heat flow rate for direct solar irradiation"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaDif
    "Prescribed heat flow rate for diffuse solar irradiation"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaGai
    "Prescribed heat flow rate for radiative internal heat gains"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Sources.Ramp ramDif(
    duration=1,
    startTime=1,
    height=1000,
    offset=0) "Input signal for diffuse heat gains"
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Ramp ramGai(
    duration=1,
    height=1000,
    offset=0,
    startTime=2)
              "Input signal for radiative heat gains"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.Constant epsLw(k=0.9) "Longwave emissivity"
    annotation (Placement(transformation(extent={{98,32},{82,48}})));
equation

  for i in 1:6 loop
    connect(fixTem.port, zonLwGaiDist.radSurfTot[i]) annotation (Line(points={{40,-30},
            {10,-30},{10,-30}},         color={191,0,0}));
    connect(epsSw.y, zonLwGaiDist.epsSw[i]) annotation (Line(points={{81.2,66},
            {81.2,66},{-4,66},{-4,-20}},
                                      color={0,0,127}));
    connect(zonLwGaiDist.area[i], A.y) annotation (Line(points={{-8,-20},{-8,92},
            {81.2,92}},   color={0,0,127}));
    connect(epsLw.y, zonLwGaiDist.epsLw[i])
    annotation (Line(points={{81.2,40},{0,40},{0,-20}},      color={0,0,127}));

  end for;
  connect(zonLwGaiDist.inc, inc.y) annotation (Line(points={{4,-20},{4,-20},{4,2},
          {4,14},{81.2,14}}, color={0,0,127}));
  connect(zonLwGaiDist.azi, azi.y)
    annotation (Line(points={{8,-20},{8,-12},{81.2,-12}}, color={0,0,127}));
  connect(preHeaDir.port, zonLwGaiDist.iSolDir) annotation (Line(points={{-40,0},
          {-20,0},{-20,-26},{-10,-26}}, color={191,0,0}));
  connect(preHeaDif.port, zonLwGaiDist.iSolDif) annotation (Line(points={{-40,-20},
          {-26,-20},{-26,-30},{-10,-30}}, color={191,0,0}));
  connect(preHeaGai.port, zonLwGaiDist.radGain) annotation (Line(points={{-40,-40},
          {-20,-40},{-20,-33.8},{-10,-33.8}}, color={191,0,0}));
  connect(ramGai.y, preHeaGai.Q_flow) annotation (Line(points={{-79,-50},{-70,-50},
          {-70,-40},{-60,-40}}, color={0,0,127}));
  connect(ramDif.y, preHeaDif.Q_flow)
    annotation (Line(points={{-79,-20},{-70,-20},{-60,-20}}, color={0,0,127}));
  connect(ramDir.y, preHeaDir.Q_flow) annotation (Line(points={{-79,10},{-70,10},
          {-70,0},{-60,0}}, color={0,0,127}));
    annotation (
    experiment(
      StopTime=3,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/BaseClasses/RadiativeHeatTransfer/Examples/ZoneLwGainDistribution.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
January 19, 2017 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
This model is a unit test for the radiative gain distribution model. 
</p>
</html>"));
end ZoneLwGainDistribution;
