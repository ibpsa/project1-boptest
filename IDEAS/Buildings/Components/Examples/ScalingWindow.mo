within IDEAS.Buildings.Components.Examples;
model ScalingWindow "Model to test the scaling factor of windows"
    package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;

  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  Window window(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S)
    "Window model with one state for frame and one for glass"
    annotation (Placement(transformation(extent={{-64,40},{-54,60}})));

  Window window1(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S)
    "Window model with one state for frame and one for glass"
    annotation (Placement(transformation(extent={{-48,40},{-38,60}})));
  Window window2(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    nWin=const.k)
    "Window model with one state for frame and one for glass"
    annotation (Placement(transformation(extent={{-62,0},{-52,20}})));
  Window window3(
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    nWin=1,
    A=const.k*1)
    "Window model with one state for frame and one for glass"
    annotation (Placement(transformation(extent={{-62,-38},{-52,-18}})));
  Modelica.Blocks.Sources.Constant const(k=3)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Window window4(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S)
    "Window model with one state for frame and one for glass"
    annotation (Placement(transformation(extent={{-34,40},{-24,60}})));
  BaseClasses.SimpleZone zoneWith3Win(nSurfExt=3) "Zone with three windows "
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  BaseClasses.SimpleZone zoneWithWinNFactor(nSurfExt=1)
    "Zone with a windows whose nWin factor is used"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  BaseClasses.SimpleZone zoneWithScaledAWin(nSurfExt=1)
    "Zone with a windows whose area is scaled"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
equation
  connect(window.propsBus_a, zoneWith3Win.proBusExt[1]) annotation (Line(
      points={{-54.8333,52},{-52,52},{-52,66},{-12,66},{-12,58.6667}},
      color={255,204,51},
      thickness=0.5));
  connect(window1.propsBus_a, zoneWith3Win.proBusExt[2]) annotation (Line(
      points={{-38.8333,52},{-38,52},{-38,66},{-12,66},{-12,60}},
      color={255,204,51},
      thickness=0.5));
  connect(window4.propsBus_a, zoneWith3Win.proBusExt[3]) annotation (Line(
      points={{-24.8333,52},{-24,52},{-24,66},{-12,66},{-12,61.3333}},
      color={255,204,51},
      thickness=0.5));
  connect(window2.propsBus_a, zoneWithWinNFactor.proBusExt[1]) annotation (Line(
      points={{-52.8333,12},{-50,12},{-50,26},{-12,26},{-12,20}},
      color={255,204,51},
      thickness=0.5));
  connect(window3.propsBus_a, zoneWithScaledAWin.proBusExt[1]) annotation (Line(
      points={{-52.8333,-26},{-50,-26},{-50,-12},{-12,-12},{-12,-20}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file(inherit=true)= "Resources/Scripts/Dymola/Buildings/Components/Examples/ScalingWindow.mos"
        "Simulate and Plot"),
    Documentation(revisions="<html>
<ul>
<li>
August 10, 2018 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model allows comparing the three options for the window dynamics.
Using two states should give the overall best performance (speed) vs accuracy.
</p>
</html>"),
    experiment(
      StartTime=2000000,
      StopTime=3000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end ScalingWindow;
