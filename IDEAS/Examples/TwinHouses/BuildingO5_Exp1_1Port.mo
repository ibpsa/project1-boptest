within IDEAS.Examples.TwinHouses;
model BuildingO5_Exp1_1Port
  "Model for simulation of experiment 1 for the O5 building with 1-port pressure drive airflow"
 extends BuildingN2_Exp1(
   bui=2,
   exp=1,
   redeclare BaseClasses.Structures.TwinhouseO5 struct,
   redeclare BaseClasses.Ventilation.Vent_TTH_pressureNetwork vent,
    sim(
      interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort,
      unify_n50=true,
        n50=1.64,
      A0=1,
      a=0.15));

  Real comparison_W40[2] = {struct.W40.resDoor.m_flow, validationDataO5Exp1_Airflow.W40_resDoor};
  Real comparison_W1[2] = {struct.W1.propsBus_a.port_1.m_flow, -validationDataO5Exp1_Airflow.W1_FlowRate};
  Real comparison_W7[2] = {struct.W7.propsBus_a.port_1.m_flow, -validationDataO5Exp1_Airflow.W7_FlowRate};
  Real comparison_W10[2] = {struct.W10.propsBus_a.port_1.m_flow, -validationDataO5Exp1_Airflow.W10_FlowRate};
  Real comparison_W37[2] = {struct.W37.propsBus_a.port_1.m_flow, validationDataO5Exp1_Airflow.W37_FlowRate};




  IDEAS.Examples.TwinHouses.BaseClasses.Data.ValidationDataO5Exp1_Airflow validationDataO5Exp1_Airflow
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=1.5e+007,
      StopTime=2.35872e+007,
      Interval=900,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
      __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Examples/TwinHouses/BuildingO5_Exp1_1Port.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>Similar to IDEAS.Examples.TwinHouses.BuildingO5_Exp1 but using the 1-port pressure driven interzonal airflow implementation.</p>
</html>"));
end BuildingO5_Exp1_1Port;
