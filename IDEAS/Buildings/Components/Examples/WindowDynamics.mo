within IDEAS.Buildings.Components.Examples;
model WindowDynamics "Comparison of three window dynamics options"
  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;
  Fluid.Sources.Boundary_pT bou(          redeclare package Medium = Medium,
      nPorts=1) "Absolute pressure bound"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));

  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  Window windowTwo(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S)
    "Window model with one state for frame and one for glass"
    annotation (Placement(transformation(extent={{-54,20},{-44,40}})));

  Zone zone1(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    V=20,
    nSurf=3)
         annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Window windowNone(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
                               "Window model with no dynamics"
    annotation (Placement(transformation(extent={{-54,-20},{-44,0}})));

  Window windowNormal(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Normal)
    "Window model with states for each glass sheet"
    annotation (Placement(transformation(extent={{-54,-60},{-44,-40}})));

equation
  connect(windowNone.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-44.8333,-8},{-44.8333,-8},{20,-8},{20,-56}},
      color={255,204,51},
      thickness=0.5));
  connect(windowNormal.propsBus_a, zone1.propsBus[3]) annotation (Line(
      points={{-44.8333,-48},{-44.8333,-48},{20,-48},{20,-57.3333}},
      color={255,204,51},
      thickness=0.5));
  connect(zone1.port_a, bou.ports[1])
    annotation (Line(points={{32,-50},{32,90},{-40,90}}, color={0,0,0}));
  connect(windowTwo.propsBus_a, zone1.propsBus[1]) annotation (Line(
      points={{-44.8333,32},{20,32},{20,-54.6667}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/WindowDynamics.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
March 6, 2017, by Filip Jorissen:<br/>
Updated model according to changed options for selecting states.
Removed wall model that should not have been in this example.
</li>
<li>
July 18, 2016, by Filip Jorissen:<br/>
Cleaned up implementation.
</li>
<li>
February 10, 2016, by Filip Jorissen:<br/>
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
end WindowDynamics;
