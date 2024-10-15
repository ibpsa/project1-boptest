within IDEAS.Buildings.Components.Examples;
model BuildingShadeExample
  extends Modelica.Icons.Example;
  Shading.BuildingShade buildingShade(
    azi=azi.k,
    hWin=hWin.k,
    L=16,
    dh=9)
    annotation (Placement(transformation(extent={{-24,20},{-14,40}})));
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
protected
  Interfaces.WeaBus                  weaBus(numSolBus=sim.numIncAndAziInBus)
    annotation (Placement(transformation(extent={{-64,24},{-44,44}})));
public
  Shading.None none(azi=azi.k)
    annotation (Placement(transformation(extent={{-24,60},{-14,80}})));
  Shading.Overhang overhang(
    azi=azi.k,
    hWin=hWin.k,
    wWin=wWin.k,
    wLeft=0.5,
    wRight=0.5,
    dep=1,
    gap=0.3) annotation (Placement(transformation(extent={{-24,-20},{-14,0}})));
  Modelica.Blocks.Sources.Constant azi(k=IDEAS.Types.Azimuth.W)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant hWin(k=1) "Window height"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant wWin(k=2) "Window Width"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Shading.Screen screen(azi=azi.k)
    annotation (Placement(transformation(extent={{-24,-60},{-14,-40}})));
  Modelica.Blocks.Sources.Cosine ctrl(
    amplitude=0.5,
    offset=0.5,
    freqHz=1/3600/3) "Dummy control signal"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Shading.SideFins sideFins(
    azi=azi.k,
    hWin=hWin.k,
    wWin=wWin.k,
    hFin=0.5,
    dep=0.5,
    gap=0.3)
    annotation (Placement(transformation(extent={{-24,-100},{-14,-80}})));
  Shading.HorizontalFins horizontalFins(
    s=0.2,
    w=0.1,
    use_betaInput=false,
    beta=45*3.14/180,
    azi=azi.k,
    t=0.02) "Horizontal fin model"
    annotation (Placement(transformation(extent={{14,20},{24,40}})));
equation
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{-84,0.8},{-84,34},{-54,34}},
      color={255,204,51},
      thickness=0.5));
  connect(buildingShade.HDirTil, weaBus.solBus[3].HDirTil) annotation (Line(points={{-24,36},
          {-53.95,36},{-53.95,34.05}},          color={0,0,127}));
  connect(buildingShade.HSkyDifTil, weaBus.solBus[3].HSkyDifTil) annotation (Line(points={{-24,34},
          {-53.95,34},{-53.95,34.05}},          color={0,0,127}));
  connect(buildingShade.angInc, weaBus.solBus[3].angInc) annotation (Line(points={{-24,26},
          {-53.95,26},{-53.95,34.05}},           color={0,0,127}));
  connect(buildingShade.angAzi, weaBus.solBus[3].angAzi) annotation (Line(points={{-24,22},
          {-53.95,22},{-53.95,34.05}},           color={0,0,127}));
  connect(buildingShade.angZen, weaBus.solBus[3].angZen) annotation (Line(points={{-24,24},
          {-24,24},{-53.95,24},{-53.95,34.05}},            color={0,0,127}));
  connect(none.HDirTil, buildingShade.HDirTil) annotation (Line(points={{-24,76},
          {-40,76},{-40,36},{-24,36}},color={0,0,127}));
  connect(none.HSkyDifTil, buildingShade.HSkyDifTil) annotation (Line(points={{-24,74},
          {-38,74},{-38,34},{-24,34}},color={0,0,127}));
  connect(none.angInc, buildingShade.angInc) annotation (Line(points={{-24,66},
          {-24,66},{-34,66},{-34,26},{-24,26}},  color={0,0,127}));
  connect(none.angAzi, buildingShade.angAzi) annotation (Line(points={{-24,62},
          {-30,62},{-30,22},{-24,22}},
                                   color={0,0,127}));
  connect(none.angZen, buildingShade.angZen) annotation (Line(points={{-24,64},
          {-32,64},{-32,24},{-24,24}},  color={0,0,127}));
  connect(overhang.angAzi, none.angAzi) annotation (Line(points={{-24,-18},{-30,
          -18},{-30,62},{-24,62}}, color={0,0,127}));
  connect(overhang.angZen, none.angZen) annotation (Line(points={{-24,-16},{-32,
          -16},{-32,64},{-24,64}}, color={0,0,127}));
  connect(overhang.angInc, none.angInc) annotation (Line(points={{-24,-14},{-34,
          -14},{-34,66},{-24,66}}, color={0,0,127}));
  connect(overhang.HSkyDifTil, none.HSkyDifTil) annotation (Line(points={{-24,-6},
          {-38,-6},{-38,74},{-24,74}},
                                  color={0,0,127}));
  connect(overhang.HDirTil, none.HDirTil) annotation (Line(points={{-24,-4},{-40,
          -4},{-40,76},{-24,76}}, color={0,0,127}));
  connect(screen.HDirTil, overhang.HDirTil) annotation (Line(points={{-24,-44},{
          -40,-44},{-40,-4},{-24,-4}}, color={0,0,127}));
  connect(screen.HSkyDifTil, overhang.HSkyDifTil) annotation (Line(points={{-24,-46},
          {-38,-46},{-38,-6},{-24,-6}},color={0,0,127}));
  connect(screen.angInc, overhang.angInc) annotation (Line(points={{-24,-54},{
          -34,-54},{-34,-14},{-24,-14}}, color={0,0,127}));
  connect(screen.angAzi, overhang.angAzi) annotation (Line(points={{-24,-58},{
          -30,-58},{-30,-18},{-24,-18}}, color={0,0,127}));
  connect(screen.angZen, overhang.angZen) annotation (Line(points={{-24,-56},{
          -30,-56},{-32,-56},{-32,-16},{-24,-16}}, color={0,0,127}));
  connect(ctrl.y, screen.Ctrl)
    annotation (Line(points={{-59,-70},{-19,-70},{-19,-60}}, color={0,0,127}));
  connect(sideFins.angAzi, screen.angAzi) annotation (Line(points={{-24,-98},{
          -30,-98},{-30,-96},{-30,-58},{-24,-58}}, color={0,0,127}));
  connect(sideFins.angZen, screen.angZen) annotation (Line(points={{-24,-96},{
          -30,-96},{-32,-96},{-32,-56},{-24,-56}}, color={0,0,127}));
  connect(sideFins.angInc, screen.angInc) annotation (Line(points={{-24,-94},{
          -34,-94},{-34,-92},{-34,-66},{-34,-54},{-24,-54}}, color={0,0,127}));
  connect(sideFins.HSkyDifTil, screen.HSkyDifTil) annotation (Line(points={{-24,-86},
          {-24,-86},{-38,-86},{-38,-46},{-24,-46}},color={0,0,127}));
  connect(sideFins.HDirTil, screen.HDirTil) annotation (Line(points={{-24,-84},{
          -24,-84},{-40,-84},{-40,-44},{-24,-44}}, color={0,0,127}));
  connect(buildingShade.HGroDifTil, weaBus.solBus[2].HGroDifTil) annotation (Line(
        points={{-24,32},{-53.95,32},{-53.95,34.05}}, color={0,0,127}));
  connect(none.HGroDifTil, buildingShade.HGroDifTil) annotation (Line(points={{-24,
          72},{-30,72},{-36,72},{-36,32},{-24,32}}, color={0,0,127}));
  connect(overhang.HGroDifTil, buildingShade.HGroDifTil) annotation (Line(
        points={{-24,-8},{-36,-8},{-36,32},{-24,32}}, color={0,0,127}));
  connect(screen.HGroDifTil, overhang.HGroDifTil) annotation (Line(points={{-24,
          -48},{-30,-48},{-36,-48},{-36,-8},{-24,-8}}, color={0,0,127}));
  connect(sideFins.HGroDifTil, screen.HGroDifTil) annotation (Line(points={{-24,
          -88},{-36,-88},{-36,-48},{-24,-48}}, color={0,0,127}));
  connect(horizontalFins.HDirTil, buildingShade.HDirTil)
    annotation (Line(points={{14,36},{-24,36}}, color={0,0,127}));
  connect(horizontalFins.HGroDifTil, buildingShade.HGroDifTil)
    annotation (Line(points={{14,32},{-24,32}}, color={0,0,127}));
  connect(horizontalFins.HSkyDifTil, buildingShade.HSkyDifTil) annotation (Line(
        points={{14,34},{-6,34},{-6,34},{-24,34}}, color={0,0,127}));
  connect(horizontalFins.angInc, buildingShade.angInc)
    annotation (Line(points={{14,26},{-24,26}}, color={0,0,127}));
  connect(horizontalFins.angAzi, buildingShade.angAzi) annotation (Line(points=
          {{14,22},{-6,22},{-6,22},{-24,22}}, color={0,0,127}));
  connect(buildingShade.angZen, horizontalFins.angZen)
    annotation (Line(points={{-24,24},{14,24}}, color={0,0,127}));
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
          "Resources/Scripts/Dymola/Buildings/Components/Examples/BuildingShadeExample.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
March 23, 2018 by Filip Jorissen:<br/>
Added test for horizontal fin model.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/697\">
#697</a>.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
July 18, 2016, by Filip Jorissen:<br/>
Using west oriented data since this orientation
is more likeley to catch a bug.
</li>
<li>
July 18, 2016, by Filip Jorissen:<br/>
Extended implementation.
</li>
<li>
June 12, 2015, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model demonstrates the impact of the BuildingShade component on the solar radiation.
</p>
</html>"));
end BuildingShadeExample;
