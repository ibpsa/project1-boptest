within IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.Examples;
model MonoLayer "Unit test for mono layer model"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Area A=10 "total multilayer area";
  parameter IDEAS.Buildings.Data.Constructions.CavityWallPartialFill cavityWallData
    "Record containing data for cavity wall"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

   Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem(T=283.15)
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature block"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=20,
    offset=273.15,
    duration=24*3600)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayer monoLayerSolid(
    A=A,
    mat=IDEAS.Buildings.Data.Materials.BrickHe(d=0.3),
    inc=IDEAS.Types.Tilt.Wall,
    epsLw_a=0.9,
    epsLw_b=0.9,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Mono layer of solid material"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayer monoLayerAir(
    A=A,
    inc=IDEAS.Types.Tilt.Wall,
    epsLw_a=0.9,
    epsLw_b=0.9,
    mat=cavityWallData.mats[2]) "Mono layer of gas layer"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayer monoLayerAirLin(
    A=A,
    inc=IDEAS.Types.Tilt.Wall,
    epsLw_a=0.9,
    epsLw_b=0.9,
    mat=cavityWallData.mats[2],
    linIntCon=true) "Mono layer of gas layer with linear convection"
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayer monoLayerSolidStatic(
    A=A,
    mat=IDEAS.Buildings.Data.Materials.BrickHe(d=0.3),
    inc=IDEAS.Types.Tilt.Wall,
    epsLw_a=0.9,
    epsLw_b=0.9,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Mono layer of solid material"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
equation
  connect(ramp.y, preTem.T)
    annotation (Line(points={{-79,0},{-70.5,0},{-62,0}}, color={0,0,127}));
  connect(monoLayerSolidStatic.port_a, preTem.port) annotation (Line(points={{-10,
          40},{-16,40},{-20,40},{-20,0},{-40,0}}, color={191,0,0}));
  connect(monoLayerSolid.port_a, preTem.port) annotation (Line(points={{-10,10},
          {-20,10},{-20,0},{-40,0}}, color={191,0,0}));
  connect(monoLayerAir.port_a, preTem.port) annotation (Line(points={{-10,-20},{
          -20,-20},{-20,0},{-40,0}}, color={191,0,0}));
  connect(monoLayerAirLin.port_a, preTem.port) annotation (Line(points={{-10,-50},
          {-20,-50},{-20,0},{-40,0}}, color={191,0,0}));
  connect(monoLayerSolidStatic.port_b, fixTem.port)
    annotation (Line(points={{10,40},{20,40},{20,0},{40,0}}, color={191,0,0}));
  connect(monoLayerSolid.port_b, fixTem.port)
    annotation (Line(points={{10,10},{20,10},{20,0},{40,0}}, color={191,0,0}));
  connect(monoLayerAir.port_b, fixTem.port) annotation (Line(points={{10,-20},{20,
          -20},{20,0},{40,0}}, color={191,0,0}));
  connect(monoLayerAirLin.port_b, fixTem.port) annotation (Line(points={{10,-50},
          {20,-50},{20,0},{40,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Components/BaseClasses/ConductiveHeatTransfer/Examples/MonoLayer.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
January 30, 2019 by Filip Jorissen:<br/>
Revised initial conditions according to new implementation of <code>MultiLayer</code>.
</li>
<li>
May 15, 2018 by Filip Jorissen:<br/>
Fixed initial conditions.
</li>
<li>
January 18, 2017 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
This model is a unit test for the 
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayer>
IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayer</a> 
model.
</p>
</html>"));
end MonoLayer;
