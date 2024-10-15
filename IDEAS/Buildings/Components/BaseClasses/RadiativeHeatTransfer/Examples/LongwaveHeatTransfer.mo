within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.Examples;
model LongwaveHeatTransfer
  extends Modelica.Icons.Example;
  ExteriorHeatRadiation extHeaRad(A=A.k)
                                       "Exterior longwave heat radiation model"
    annotation (Placement(transformation(extent={{10,50},{-10,70}})));
  HeatRadiation intHeaRadLin(linearise=true, R=intHeaRad.R)
                  "Linearised interior heat radiation model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution
    zonLwDist(nSurf=2, linearise=false)
    "Model for longwave radiative heat exchange within a zone"
    annotation (Placement(transformation(extent={{10,-80},{-10,-60}})));
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
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant epsLw(k=0.9) "Longwave emissivity"
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  HeatRadiation intHeaRad(linearise=false, R=(1/epsLw.k + 1/epsLw.k - 1)/(
        Modelica.Constants.sigma*A.k))
                  "Interior longwave heat radiation model"
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.Constant A(k=10) "Heat exchange surface area"
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution
    zonLwDistLin(nSurf=2)
    "Linearised model for longwave radiative heat exchange within a zone"
    annotation (Placement(transformation(extent={{10,-100},{-10,-80}})));
equation
  connect(ramp.y,preTem. T)
    annotation (Line(points={{-79,0},{-62,0}}, color={0,0,127}));
  connect(preTem.port, intHeaRadLin.port_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={191,0,0}));
  connect(intHeaRadLin.port_b, fixTem.port)
    annotation (Line(points={{10,0},{25,0},{40,0}}, color={191,0,0}));
  connect(zonLwDist.port_a[1], preTem.port) annotation (Line(points={{-10,-70.5},
          {-20,-70.5},{-20,0},{-40,0}}, color={191,0,0}));
  connect(zonLwDist.port_a[2], fixTem.port) annotation (Line(points={{-10,-69.5},
          {-10,-69.5},{-10,-52},{-10,-40},{20,-40},{20,0},{40,0}}, color={191,0,
          0}));
  connect(extHeaRad.port_a, fixTem.port)
    annotation (Line(points={{10,60},{20,60},{20,0},{40,0}}, color={191,0,0}));
  connect(extHeaRad.Tenv, ramp.y) annotation (Line(points={{10,66},{20,66},{20,80},
          {-79,80},{-79,0}}, color={0,0,127}));
  connect(epsLw.y, extHeaRad.epsLw) annotation (Line(points={{79,30},{40,30},{
          40,63.4},{10,63.4}},
                            color={0,0,127}));
  connect(intHeaRad.port_b, intHeaRadLin.port_b)
    annotation (Line(points={{10,20},{10,0}}, color={191,0,0}));
  connect(intHeaRad.port_a, intHeaRadLin.port_a)
    annotation (Line(points={{-10,20},{-10,0}}, color={191,0,0}));
  connect(zonLwDist.epsLw[1], epsLw.y) annotation (Line(points={{0,-59},{0,-50},
          {70,-50},{70,30},{79,30}}, color={0,0,127}));
  connect(zonLwDist.epsLw[2], epsLw.y) annotation (Line(points={{0,-61},{0,-50},
          {70,-50},{70,30},{79,30}}, color={0,0,127}));
  connect(zonLwDist.A[1], A.y) annotation (Line(points={{-4,-59},{-4,-44},{64,
          -44},{64,-30},{79,-30}}, color={0,0,127}));
  connect(zonLwDist.A[2], A.y) annotation (Line(points={{-4,-61},{-4,-61},{-4,
          -46},{-4,-44},{64,-44},{64,-30},{79,-30}}, color={0,0,127}));
  connect(zonLwDistLin.port_a, zonLwDist.port_a) annotation (Line(points={{-10,
          -90},{-20,-90},{-20,-70},{-10,-70}}, color={191,0,0}));
  connect(zonLwDistLin.A, zonLwDist.A)
    annotation (Line(points={{-4,-80},{-4,-80},{-4,-60}}, color={0,0,127}));
  connect(zonLwDist.epsLw, zonLwDistLin.epsLw)
    annotation (Line(points={{0,-60},{0,-60},{0,-80}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/BaseClasses/RadiativeHeatTransfer/Examples/LongwaveHeatTransfer.mos"
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
This model is a unit test for the longwave heat transfer models. 
</p>
</html>"));
end LongwaveHeatTransfer;
