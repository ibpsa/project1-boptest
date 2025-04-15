within MultizoneOfficeComplexAir.BaseClasses.LoadSide.Examples;
model LoadWrapper
  extends Modelica.Icons.Example;
  MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper loadWrapper(building(
        spawnExe="spawn-0.3.0-0fa49be497"))
    "Load calculation in EnergyPlus using Spawn, note this version spawn-0.3.0-8d93151657 is specified for BOPTEST environment; Use spawn-0.3.0-0fa49be497 for Buildings library version"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Sources.Step Tzon[15](
    height=2,
    offset=273.15 + 20,
    startTime=3600*12)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(Tzon.y, loadWrapper.TZonAir)
    annotation (Line(points={{-59,0},{-24,0}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, __Dymola_Algorithm="Cvode"));
end LoadWrapper;
