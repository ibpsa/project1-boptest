within IDEAS.Examples.TwinHouses.BaseClasses.Data;
model ValidationDataO5Exp1_Airflow
  "Model that reads mass flow results from similar CONTAM simulation"

final parameter String filNam = "CONTAMTwinHouseO5.txt";
final parameter String dirPath = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/measurements/")    annotation(Evaluate=true);
Modelica.Blocks.Sources.CombiTimeTable CONTAMdata(
    tableOnFile=true,
    columns=2:45,
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    final fileName=dirPath + filNam,
    tableName="CONTAMdata",
    startTime(displayUnit="s") = 14946900)
    "input for validation data from CONTAM model of Holzkirchen"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
    //When comparing to Modelica the sign might be inverse because of other conventions

Modelica.SIunits.MassFlowRate W1_FlowRate = CONTAMdata.y[ 1];
Modelica.SIunits.MassFlowRate W2_FlowRate = CONTAMdata.y[ 2];
Modelica.SIunits.MassFlowRate W3_FlowRate = CONTAMdata.y[ 3];
Modelica.SIunits.MassFlowRate W4_FlowRate = CONTAMdata.y[ 4];
Modelica.SIunits.MassFlowRate W5_FlowRate = CONTAMdata.y[ 5];
Modelica.SIunits.MassFlowRate W6_FlowRate = CONTAMdata.y[ 6];
Modelica.SIunits.MassFlowRate W7_FlowRate = CONTAMdata.y[ 7];
Modelica.SIunits.MassFlowRate W8_FlowRate = CONTAMdata.y[ 8];
Modelica.SIunits.MassFlowRate W9_FlowRate = CONTAMdata.y[ 9];
Modelica.SIunits.MassFlowRate W10_FlowRate = CONTAMdata.y[ 10];
Modelica.SIunits.MassFlowRate W11_FlowRate = CONTAMdata.y[ 11];
Modelica.SIunits.PressureDifference W1_dP = CONTAMdata.y[ 12];
Modelica.SIunits.PressureDifference W2_dP = CONTAMdata.y[ 13];
Modelica.SIunits.PressureDifference W3_dP = CONTAMdata.y[ 14];
Modelica.SIunits.MassFlowRate W27_FlowRate = CONTAMdata.y[ 15];
Modelica.SIunits.MassFlowRate W28_FlowRate = CONTAMdata.y[ 16];
Modelica.SIunits.MassFlowRate W29_FlowRate = CONTAMdata.y[ 17];
Modelica.SIunits.MassFlowRate W30_FlowRate = CONTAMdata.y[ 18];
Modelica.SIunits.MassFlowRate W31_FlowRate = CONTAMdata.y[ 19];
Modelica.SIunits.MassFlowRate W32_FlowRate = CONTAMdata.y[ 20];
Modelica.SIunits.MassFlowRate W33_FlowRate = CONTAMdata.y[ 21];
Modelica.SIunits.MassFlowRate W34_FlowRate = CONTAMdata.y[ 22];
Modelica.SIunits.MassFlowRate W35_FlowRate = CONTAMdata.y[ 23];
Modelica.SIunits.MassFlowRate W36_FlowRate = CONTAMdata.y[ 24];
Modelica.SIunits.MassFlowRate W37_FlowRate = CONTAMdata.y[ 25];
Modelica.SIunits.MassFlowRate W38_FlowRate = CONTAMdata.y[ 26];
Modelica.SIunits.MassFlowRate W39_FlowRate = CONTAMdata.y[ 27];
Modelica.SIunits.MassFlowRate W40_FlowRate = CONTAMdata.y[ 28];
Modelica.SIunits.MassFlowRate W41_FlowRate = CONTAMdata.y[ 29];
Modelica.SIunits.MassFlowRate W42_FlowRate = CONTAMdata.y[ 30];
Modelica.SIunits.MassFlowRate W43_FlowRate = CONTAMdata.y[ 31];
Modelica.SIunits.MassFlowRate W44_FlowRate = CONTAMdata.y[ 32];
Modelica.SIunits.MassFlowRate W45_FlowRate = CONTAMdata.y[ 33];
Modelica.SIunits.MassFlowRate W46_FlowRate = CONTAMdata.y[ 34];
Modelica.SIunits.MassFlowRate W47_FlowRate = CONTAMdata.y[ 35];
Modelica.SIunits.MassFlowRate W40_resDoor = CONTAMdata.y[ 36];
Modelica.SIunits.MassFlowRate W41_resDoor = CONTAMdata.y[ 37];
Modelica.SIunits.MassFlowRate W42_resDoor = CONTAMdata.y[ 38];
Modelica.SIunits.MassFlowRate Supply_FlowRate = CONTAMdata.y[ 42];
Modelica.SIunits.MassFlowRate Exhaust_Bath = CONTAMdata.y[ 43];
Modelica.SIunits.MassFlowRate Exhaust_bedr = CONTAMdata.y[ 44];






  annotation (experiment(
      StartTime=15000000,
      StopTime=31536000,
      Interval=900,
      __Dymola_Algorithm="Dassl"));
end ValidationDataO5Exp1_Airflow;
