within IDEAS.Buildings.Components.Validations;
model WindowOrientations
  "Comparison incident solar irradiation for three window orientations"
  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;

  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  Window winWal(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S) "Window with wall orientation"
    annotation (Placement(transformation(extent={{-54,20},{-44,40}})));

  Zone zone1(
    redeclare package Medium = Medium,
    V=20,
    nSurf=3)
         annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Window winFlo(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    inc=IDEAS.Types.Tilt.Floor,
    azi=IDEAS.Types.Azimuth.S)  "Window with floor orientation"
    annotation (Placement(transformation(extent={{-54,-20},{-44,0}})));

  Window winCei(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    azi=IDEAS.Types.Azimuth.S,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Normal,
    inc=IDEAS.Types.Tilt.Ceiling) "Window with ceiling orientation"
    annotation (Placement(transformation(extent={{-54,-60},{-44,-40}})));

equation
  connect(winFlo.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-44.8333,-8},{-44.8333,-8},{20,-8},{20,-56}},
      color={255,204,51},
      thickness=0.5));
  connect(winCei.propsBus_a, zone1.propsBus[3]) annotation (Line(
      points={{-44.8333,-48},{-44.8333,-48},{20,-48},{20,-57.3333}},
      color={255,204,51},
      thickness=0.5));
  connect(winWal.propsBus_a, zone1.propsBus[1]) annotation (Line(
      points={{-44.8333,32},{20,32},{20,-54.6667}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Validations/WindowOrientations.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
January 26, 2018, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model verifies whether upward, downward and vertical orientations lead to 
correct values for the diffuse and direct solar irradiations.
I.e. the diffuse ground component for upward directions should be zero.
The diffuse sky component for downward directions should be zero.
</p>
</html>"),
    experiment(
      StartTime=2000000,
      StopTime=3000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end WindowOrientations;
