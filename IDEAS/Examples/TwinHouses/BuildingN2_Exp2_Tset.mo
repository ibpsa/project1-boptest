within IDEAS.Examples.TwinHouses;
model BuildingN2_Exp2_Tset
  "Model for simulation of experiment2 for the N2 building|Tset"
  extends BuildingN2_Exp1(
    bui=1,
    exp=2,loadVal=true,
    redeclare BaseClasses.HeatingSystems.ElectricHeating_Twinhouse_Tset heaSys);

  annotation (
    experiment(
      StartTime=8e+006,
      StopTime=1.23e+007,
      Interval=900,
      Tolerance=1e-006,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Examples/TwinHouses/BuildingN2_Exp2_Tset.mos"
        "Simulate and plot"));
end BuildingN2_Exp2_Tset;
