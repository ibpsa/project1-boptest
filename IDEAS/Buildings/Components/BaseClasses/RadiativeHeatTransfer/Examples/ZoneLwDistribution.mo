within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.Examples;
model ZoneLwDistribution
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Length l = 2;
  parameter Modelica.SIunits.Length b = 2;
  parameter Modelica.SIunits.Length h = 2;
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution
    zonLwDist(nSurf=6, linearise=false)
    "Longwave distribution model using radiant star node"
    annotation (Placement(transformation(extent={{10,60},{-10,80}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-20,
    duration=1e6,
    offset=305.15) "Input signal"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature block"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem(T=295.15)
    "Fixed temperature boundary condition corresponding to zone temperature"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.Constant epsLw(k=1) "Longwave emissivity"
    annotation (Placement(transformation(extent={{100,50},{80,70}})));
  Modelica.Blocks.Sources.Constant A[6](k={l*b,l*b,b*h,l*h,b*h,l*h})
                                              "Heat exchange surface area"
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  HeatRadiation intHeaRad(             linearise=false, R=(1/epsLw.k + 1/epsLw.k
         - 1)/(Modelica.Constants.sigma*A[1].k))
                  "Interior longwave heat radiation model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,30})));
  ZoneLwDistributionViewFactor zonLwVieFac(                 nSurf=6,
    linearise=false,
    hZone=h)
    "Longwave distribution model using view factors"
    annotation (Placement(transformation(extent={{10,20},{-10,40}})));
  Modelica.Blocks.Sources.Constant inc[6](k={IDEAS.Types.Tilt.Floor,IDEAS.Types.Tilt.Ceiling,
        IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall})
    "Inclinations"
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Modelica.Blocks.Sources.Constant azi[6](k={IDEAS.Types.Azimuth.S,IDEAS.Types.Azimuth.S,
        IDEAS.Types.Azimuth.S,IDEAS.Types.Azimuth.N,IDEAS.Types.Azimuth.W,
        IDEAS.Types.Azimuth.E}) "Azimuth angles"
    annotation (Placement(transformation(extent={{100,-20},{80,0}})));
equation
  assert(abs(zonLwVieFac.port_a[1].Q_flow-intHeaRad.port_a.Q_flow)<1e-4, "Model verification results are not identical!");
  assert(abs(zonLwVieFac.port_a[1].Q_flow-zonLwDist.port_a[1].Q_flow)<1e-4, "Model verification results are not identical!");
  connect(ramp.y,preTem. T)
    annotation (Line(points={{-79,0},{-62,0}}, color={0,0,127}));
  connect(preTem.port, zonLwDist.port_a[1]) annotation (Line(points={{-40,0},{
          -20,0},{-20,69.1667},{-10,69.1667}},
                                           color={191,0,0}));
  for i in 2:6 loop
    connect(fixTem.port, zonLwDist.port_a[i]) annotation (Line(points={{-40,70},
            {-10,70}},        color={191,0,0}));
  end for;
  for i in 1:6 loop
    connect(epsLw.y, zonLwDist.epsLw[i]) annotation (Line(points={{79,60},{79,60},
            {60,60},{60,88},{0,88},{0,80}},    color={0,0,127}));
  end for;
  connect(intHeaRad.port_a, preTem.port) annotation (Line(points={{-30,20},{-30,
          20},{-30,0},{-40,0}}, color={191,0,0}));
  connect(intHeaRad.port_b, fixTem.port) annotation (Line(points={{-30,40},{-30,
          40},{-30,64},{-30,70},{-40,70}}, color={191,0,0}));
  connect(zonLwVieFac.port_a, zonLwDist.port_a)
    annotation (Line(points={{-10,30},{-10,30},{-10,70}}, color={191,0,0}));
  connect(zonLwVieFac.A, zonLwDist.A)
    annotation (Line(points={{-4,40},{-4,40},{-4,80}}, color={0,0,127}));
  connect(zonLwVieFac.epsLw, zonLwDist.epsLw)
    annotation (Line(points={{0,40},{0,40},{0,80}}, color={0,0,127}));
  connect(zonLwVieFac.azi, azi.y) annotation (Line(points={{10,26},{60,26},{60,-10},
          {79,-10}},      color={0,0,127}));
  connect(inc.y, zonLwVieFac.inc) annotation (Line(points={{79,30},{46,30},{46,34},
          {10,34}},     color={0,0,127}));
  connect(A.y, zonLwDist.A)
    annotation (Line(points={{79,90},{-4,90},{-4,80}}, color={0,0,127}));
    annotation (
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Components/BaseClasses/RadiativeHeatTransfer/Examples/ZoneLwDistribution.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
January 20, 2017 by Filip Jorissen:<br/>
Changed implementation to support more generic dimensions.
</li>
<li>
January 19, 2017 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
This model is a verification test for model
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution>
IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution</a>.
</p>
<p>
Three different approaches are used to model
a black cube with face surface areas of 4 m2.
The emissivity of each surface is one.
The first surface has a time-varying temperature,
whereas the five others have a fixed temperature.
In <code>intHeaRad</code> the five other surfaces are lumped into one surface.
In <a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution>zonLwDist</a>
an equivalent radiant star point is used.
In <a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistributionViewFactor>zonLwVieFac</a>
view factors are computed. 
All three approaches should give exactly the same result for the given
geometry and emissivities.
</p>
</html>"));
end ZoneLwDistribution;
