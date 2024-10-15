within IDEAS.Examples.TwinHouses;
model BuildingN2_Exp1
  "Model for simulation of experiment 1 for the N2 building"
  extends Modelica.Icons.Example;
  extends IDEAS.Examples.TwinHouses.Interfaces.PartialTwinHouse(
    bui=1,
    exp=1,
    redeclare replaceable BaseClasses.Structures.TwinhouseN2 struct);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=15000000,
      StopTime=23587200,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=true),
      Evaluate=true,
      OutputCPUtime=false,
      OutputFlatModelica=false),
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Examples/TwinHouses/BuildingN2_Exp1.mos"
        "Simulate and plot"));
end BuildingN2_Exp1;
