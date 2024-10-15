within IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.Examples;
model MultiLayerRamp "Unit test for multi layer model"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Area A=10 "total multilayer area";
  parameter Modelica.SIunits.TemperatureDifference dT=20 "Temperature difference of the ramp";
  Modelica.SIunits.Temperature dT_Avg;
  Modelica.SIunits.Energy Etot;
  Modelica.SIunits.Energy Enet_layMul;
  parameter IDEAS.Buildings.Data.Constructions.ConcreteSlab concreteFloor
    "Record containing tabs construction data"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=dT,
    duration=12*3600,
    offset=293.15)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer layMul(
    A=A,
    inc=IDEAS.Types.Tilt.Floor,
    nLay=concreteFloor.nLay,
    mats=concreteFloor.mats,
    nGain=concreteFloor.nGain,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Multi layer model"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
protected
  parameter Modelica.SIunits.Energy E0_layMul(fixed=false);

public
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G=10000)
    "For being able to use fixedInitial without addRes_b = true"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
initial equation
  Etot=0;
  E0_layMul=layMul.E;

equation
  assert((Enet_layMul-Etot)<1e-3, "Implementation error in computation of total energy in layMul.");
  der(Etot) = -preTem.port.Q_flow;
  Enet_layMul =layMul.E - E0_layMul;

  dT_Avg = Etot/A/2/concreteFloor.mats[1].c/concreteFloor.mats[1].rho/concreteFloor.mats[1].d;

  // check if total energy adds up
  when (time>4e5) then
    assert(abs(dT_Avg-dT)<1e-3, "Implementation error in computation of total energy in layMul");
  end when;
  connect(ramp.y, preTem.T)
    annotation (Line(points={{-79,0},{-70.5,0},{-62,0}}, color={0,0,127}));
  connect(theCon.port_a, preTem.port)
    annotation (Line(points={{-10,0},{-40,0}}, color={191,0,0}));
  connect(theCon.port_b, layMul.port_a)
    annotation (Line(points={{10,0},{25,0},{40,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=500000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Components/BaseClasses/ConductiveHeatTransfer/Examples/MultiLayerRamp.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
March 7, 2017 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
This model is a unit test for the 
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer>
IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer</a> 
model.
It verifies whether the total energy contained by a multi layer model is correct.
</p>
</html>"));
end MultiLayerRamp;
