within IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.Examples;
model MultiLayer "Unit test for multi layer model"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Area A = 10 "total multilayer area";
  parameter IDEAS.Buildings.Data.Constructions.CavityWallPartialFill cavityWallData
    "Record containing data for cavity wall"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  parameter IDEAS.Buildings.Data.Constructions.TABS tabsData
    "Record containing tabs construction data"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer cavityWall(
    A=A,
    nLay=cavityWallData.nLay,
    mats=cavityWallData.mats,
    nGain=cavityWallData.nGain,
    inc=IDEAS.Types.Tilt.Wall,
    disableInitPortA=true,
    disableInitPortB=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Test model containing an air layer"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem(T=283.15)
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=20,
    offset=273.15,
    duration=24*3600)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer TABS(
    A=A,
    inc=IDEAS.Types.Tilt.Floor,
    nLay=tabsData.nLay,
    mats=tabsData.mats,
    nGain=tabsData.nGain,
    disableInitPortA=true,
    disableInitPortB=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Test model containing only solid layers"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(ramp.y, prescribedTemperature.T)
    annotation (Line(points={{-79,0},{-70.5,0},{-62,0}}, color={0,0,127}));
  connect(prescribedTemperature.port, TABS.port_a)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={191,0,0}));
  connect(prescribedTemperature.port, cavityWall.port_a) annotation (Line(
        points={{-40,0},{-20,0},{-20,50},{-10,50}}, color={191,0,0}));
  connect(cavityWall.port_b, fixTem.port)
    annotation (Line(points={{10,50},{20,50},{20,0},{40,0}}, color={191,0,0}));
  connect(TABS.port_b, fixTem.port)
    annotation (Line(points={{10,0},{40,0}},        color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/BaseClasses/ConductiveHeatTransfer/Examples/MultiLayer.mos"
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
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer>
IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer</a> 
model.
</p>
</html>"));
end MultiLayer;
