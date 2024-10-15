within IDEAS.Buildings.Components.Validations;
model CeilingOrientationConsistency
  "Check whether the azimuth angle dependency of incident solar irradiation is zero for ceiling orientations."
  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;

  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  Window winSou(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two,
    azi=IDEAS.Types.Azimuth.S,
    inc=IDEAS.Types.Tilt.Ceiling)
                               "Window with wall orientation"
    annotation (Placement(transformation(extent={{-54,20},{-44,40}})));

  Zone zone1(
    redeclare package Medium = Medium,
    V=20,
    nSurf=3)
         annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Window winEas(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=IDEAS.Types.Azimuth.E)  "Window with floor orientation"
    annotation (Placement(transformation(extent={{-54,-20},{-44,0}})));

  Window winNor(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Normal,
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=IDEAS.Types.Azimuth.N)    "Window with ceiling orientation"
    annotation (Placement(transformation(extent={{-54,-60},{-44,-40}})));

equation
  assert(abs(winSou.shaType.HSkyDifTil-winNor.shaType.HSkyDifTil)<1e-6, "Solar irradiation on ceilings depends on azimuth angle, this is unexpected!");
  assert(abs(winSou.shaType.HSkyDifTil-winEas.shaType.HSkyDifTil)<1e-6, "Solar irradiation on ceilings depends on azimuth angle, this is unexpected!");
  assert(abs(winSou.shaType.HGroDifTil-winNor.shaType.HGroDifTil)<1e-6, "Solar irradiation on ceilings depends on azimuth angle, this is unexpected!");
  assert(abs(winSou.shaType.HGroDifTil-winEas.shaType.HGroDifTil)<1e-6, "Solar irradiation on ceilings depends on azimuth angle, this is unexpected!");
  assert(abs(winSou.shaType.HDirTil-winNor.shaType.HDirTil)<1e-6, "Solar irradiation on ceilings depends on azimuth angle, this is unexpected!");
  assert(abs(winSou.shaType.HDirTil-winEas.shaType.HDirTil)<1e-6, "Solar irradiation on ceilings depends on azimuth angle, this is unexpected!");
  connect(winEas.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-44.8333,-8},{-44.8333,-8},{20,-8},{20,-56}},
      color={255,204,51},
      thickness=0.5));
  connect(winNor.propsBus_a, zone1.propsBus[3]) annotation (Line(
      points={{-44.8333,-48},{-44.8333,-48},{20,-48},{20,-57.3333}},
      color={255,204,51},
      thickness=0.5));
  connect(winSou.propsBus_a, zone1.propsBus[1]) annotation (Line(
      points={{-44.8333,32},{20,32},{20,-54.6667}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Validations/CeilingOrientationConsistency.mos"
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
This model verifies whether horizontal window orientations always lead 
to the same values for the solar irradiation, 
regardless of the value of the azimuth angle.
</p>
</html>"),
    experiment(
      StartTime=2000000,
      StopTime=3000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end CeilingOrientationConsistency;
