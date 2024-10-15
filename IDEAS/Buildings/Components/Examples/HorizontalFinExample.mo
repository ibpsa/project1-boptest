within IDEAS.Buildings.Components.Examples;
model HorizontalFinExample "Examples of horizontal fin model"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
protected
  Interfaces.WeaBus                  weaBus(numSolBus=sim.numIncAndAziInBus)
    annotation (Placement(transformation(extent={{-64,24},{-44,44}})));
public
  Modelica.Blocks.Sources.Constant azi(k=IDEAS.Types.Azimuth.W)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant hWin(k=1) "Window height"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant wWin(k=2) "Window Width"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Shading.HorizontalFins horizontalFins(
    s=0.2,
    w=0.1,
    use_betaInput=false,
    beta=45*3.14/180,
    azi=azi.k,
    t=0.02) "Horizontal fin model with fins at 45 degrees"
    annotation (Placement(transformation(extent={{-16,20},{-6,40}})));
  Shading.HorizontalFins horizontalFinsBeta(
    s=0.2,
    w=0.1,
    beta=45*3.14/180,
    azi=azi.k,
    t=0.02,
    use_betaInput=true) "Horizontal fin model with control input for beta"
    annotation (Placement(transformation(extent={{24,20},{34,40}})));
  Shading.HorizontalFins horizontalFinsDisp(
    s=0.2,
    w=0.1,
    beta=45*3.14/180,
    azi=azi.k,
    t=0.02,
    use_displacementInput=true)
    "Horizontal fin model with control input for displacement"
    annotation (Placement(transformation(extent={{64,20},{74,40}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=Modelica.Constants.pi/4,
    offset=Modelica.Constants.pi/4,
    freqHz=1/30000)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Sources.Pulse pulse(period=3600*4)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Shading.HorizontalFins horizontalFinsOpen(
    s=0.2,
    w=0.1,
    use_betaInput=false,
    azi=azi.k,
    t=0.02,
    beta=0) "Horizontal fin model with opened fins"
    annotation (Placement(transformation(extent={{4,20},{14,40}})));
equation
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{-81,1},{-81,34},{-54,34}},
      color={255,204,51},
      thickness=0.5));
  connect(horizontalFinsBeta.HDirTil, horizontalFins.HDirTil)
    annotation (Line(points={{24,36},{-16,36}}, color={0,0,127}));
  connect(horizontalFins.HGroDifTil, horizontalFinsBeta.HGroDifTil)
    annotation (Line(points={{-16,32},{24,32}}, color={0,0,127}));
  connect(horizontalFinsBeta.HSkyDifTil, horizontalFins.HSkyDifTil)
    annotation (Line(points={{24,34},{-16,34}}, color={0,0,127}));
  connect(horizontalFinsBeta.angInc, horizontalFins.angInc)
    annotation (Line(points={{24,26},{-16,26}}, color={0,0,127}));
  connect(horizontalFinsBeta.angZen, horizontalFins.angZen)
    annotation (Line(points={{24,24},{-16,24}}, color={0,0,127}));
  connect(horizontalFinsBeta.angAzi, horizontalFins.angAzi)
    annotation (Line(points={{24,22},{-16,22}}, color={0,0,127}));
  connect(horizontalFinsDisp.HDirTil, horizontalFinsBeta.HDirTil)
    annotation (Line(points={{64,36},{24,36}}, color={0,0,127}));
  connect(horizontalFinsDisp.HSkyDifTil, horizontalFinsBeta.HSkyDifTil)
    annotation (Line(points={{64,34},{24,34}}, color={0,0,127}));
  connect(horizontalFinsDisp.HGroDifTil, horizontalFinsBeta.HGroDifTil)
    annotation (Line(points={{64,32},{24,32}}, color={0,0,127}));
  connect(horizontalFinsDisp.angInc, horizontalFinsBeta.angInc)
    annotation (Line(points={{64,26},{24,26}}, color={0,0,127}));
  connect(horizontalFinsDisp.angZen, horizontalFinsBeta.angZen)
    annotation (Line(points={{64,24},{24,24}}, color={0,0,127}));
  connect(horizontalFinsDisp.angAzi, horizontalFinsBeta.angAzi)
    annotation (Line(points={{64,22},{24,22}}, color={0,0,127}));
  connect(sine.y, horizontalFinsBeta.Ctrl)
    annotation (Line(points={{21,-10},{29,-10},{29,20}}, color={0,0,127}));
  connect(pulse.y, horizontalFinsDisp.Ctrl)
    annotation (Line(points={{61,-10},{69,-10},{69,20}}, color={0,0,127}));
  connect(horizontalFins.angAzi, weaBus.solBus[3].angAzi) annotation (Line(points={
          {-16,22},{-53.95,22},{-53.95,34.05}}, color={0,0,127}));
  connect(horizontalFins.angZen, weaBus.solBus[3].angZen) annotation (Line(points={
          {-16,24},{-53.95,24},{-53.95,34.05}}, color={0,0,127}));
  connect(horizontalFins.angInc, weaBus.solBus[3].angInc) annotation (Line(points={
          {-16,26},{-53.95,26},{-53.95,34.05}}, color={0,0,127}));
  connect(horizontalFins.HGroDifTil, weaBus.solBus[3].HGroDifTil) annotation (Line(
        points={{-16,32},{-53.95,32},{-53.95,34.05}}, color={0,0,127}));
  connect(horizontalFins.HSkyDifTil, weaBus.solBus[3].HSkyDifTil) annotation (Line(
        points={{-16,34},{-54,34},{-54,34.05},{-53.95,34.05}}, color={0,0,127}));
  connect(horizontalFins.HDirTil, weaBus.solBus[3].HDirTil) annotation (Line(
        points={{-16,36},{-53.95,36},{-53.95,34.05}}, color={0,0,127}));
  connect(horizontalFinsOpen.HDirTil, horizontalFins.HDirTil)
    annotation (Line(points={{4,36},{-16,36}}, color={0,0,127}));
  connect(horizontalFinsOpen.HSkyDifTil, horizontalFins.HSkyDifTil)
    annotation (Line(points={{4,34},{-16,34}}, color={0,0,127}));
  connect(horizontalFinsOpen.HGroDifTil, horizontalFins.HGroDifTil)
    annotation (Line(points={{4,32},{-16,32}}, color={0,0,127}));
  connect(horizontalFinsOpen.angInc, horizontalFins.angInc)
    annotation (Line(points={{4,26},{-16,26}}, color={0,0,127}));
  connect(horizontalFinsOpen.angAzi, horizontalFins.angAzi)
    annotation (Line(points={{4,22},{-16,22}}, color={0,0,127}));
  connect(horizontalFinsOpen.angZen, horizontalFins.angZen)
    annotation (Line(points={{4,24},{-16,24}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StartTime=2000000,
      StopTime=3000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/HorizontalFinExample.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
March 18, 2019, by Filip Jorissen:<br/>
First implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/992\">#992</a>.
</li>
</ul>
</html>", info="<html>
<p>
This model demonstrates the impact of the BuildingShade component on the solar radiation.
</p>
</html>"));
end HorizontalFinExample;
