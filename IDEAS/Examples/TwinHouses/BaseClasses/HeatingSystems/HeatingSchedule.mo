within IDEAS.Examples.TwinHouses.BaseClasses.HeatingSystems;
model HeatingSchedule "Heating schedule for twin house experiments"
  parameter Integer exp = 1 "Experiment number: 1 or 2";
  parameter Integer bui = 1 "Building number 1 (N2), 2 (O5)";
  final parameter String dirPath = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/measurements/")
    annotation(Evaluate=true);

  Modelica.Blocks.Interfaces.RealInput[7] TSensor
    annotation (Placement(transformation(extent={{-130,-20},{-90,20}})));
  Modelica.Blocks.Interfaces.RealOutput[7] y
    annotation (Placement(transformation(extent={{86,58},{130,102}})));
  Modelica.Blocks.Sources.CombiTimeTable
                                       measuredInput(
    tableOnFile=true,
    tableName="data",
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    columns=2:15,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    fileName=dirPath + filename)
    annotation (Placement(transformation(extent={{-56,50},{-36,70}})));
  Modelica.Blocks.Math.UnitConversions.From_degC[7] TdegC
    annotation (Placement(transformation(extent={{16,56},{36,76}})));
  Modelica.Blocks.Interfaces.RealOutput[7] TSet_IDEAL
    annotation (Placement(transformation(extent={{90,-62},{134,-18}})));
  Modelica.Blocks.Interfaces.RealOutput[7] Pel_IDEAL
    annotation (Placement(transformation(extent={{92,-102},{136,-58}})));
protected
  final parameter Real[6] Schedule= if exp == 1 then {20044800,20800000,22119000,22637400,3.1536e7,3.16e7} else {8467200,9.187e6,9.7352e6,10198800,11494800,12013200};
  final parameter Modelica.SIunits.Temperature Tinit1=303.15;
  final parameter Modelica.SIunits.Temperature Tinit1N = (if exp== 1 then Tinit1 else 295.15);
  final parameter Modelica.SIunits.Temperature Tinit2=if exp == 1 then 298.15 else 303.15;
  final parameter Modelica.SIunits.Temperature Tinit2N = (if exp== 1 then Tinit2 else 295.15);
  final parameter String filename = if exp==1 and bui== 1 then "MeasurementTwinHouseN2Exp1.txt" elseif exp==2 and bui==1 then "MeasurementTwinHouseN2Exp2.txt" else "MeasurementTwinHouseO5.txt";

equation
  TSet_IDEAL= TdegC.y;
  Pel_IDEAL[1] = measuredInput.y[8];
  Pel_IDEAL[2]=0;
  Pel_IDEAL[3]=measuredInput.y[9];
  Pel_IDEAL[4]=measuredInput.y[10];
  Pel_IDEAL[5]=measuredInput.y[11]+measuredInput.y[12];//measuremedInput.y[12] is the extra heatloss due to uninsulated duct
  Pel_IDEAL[6]=measuredInput.y[13];
  Pel_IDEAL[7]=measuredInput.y[14];
if time <Schedule[2] then
  y[1]=max(0,100000*(Tinit1-TSensor[1]));
  y[2]=0;
  y[3]=max(0,100000*(Tinit1-TSensor[3]));
  y[4]=max(0,100000*(Tinit1-TSensor[4]));
  y[5]=max(0,100000*(Tinit1N-TSensor[5]))+measuredInput.y[12];
  y[6]=max(0,100000*(Tinit1N-TSensor[6]));
  y[7]=max(0,100000*(Tinit1N-TSensor[7]));
elseif (time>=Schedule[2] and time < Schedule[3]) or time >= Schedule[4] and time < Schedule[5] then
  y=Pel_IDEAL;
elseif time>=Schedule[3] and time < Schedule[4] or time >= Schedule[5] and time < Schedule[6] then
  y[1]=max(0,100000*(Tinit2-TSensor[1]));
  y[2]=0;
  y[3]=max(0,100000*(Tinit2-TSensor[3]));
  y[4]=max(0,100000*(Tinit2-TSensor[4]));
  y[5]=max(0,100000*(Tinit2N-TSensor[5]))+measuredInput.y[12];
  y[6]=max(0,100000*(Tinit2N-TSensor[6]));
  y[7]=max(0,100000*(Tinit2N-TSensor[7]));
else
  y=Pel_IDEAL;

end if;
  connect(measuredInput.y[1:7],TdegC [1:7].u) annotation (Line(points={{-35,60},
          {-10,60},{-10,66},{14,66}},
                             color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
                                   Text(
          extent={{-28,60},{-14,54}},
          lineColor={28,108,200},
          textString="Order of outputs: 
1: living T 125cm
2: corridor T
3: bath T
4: child T
5: Kit T
6: hall T
7: bedT
8: heat elp living
9: heat elp bath
10: heat elp bed1
11: heat elp kit
12: heat gainvent kit 
13: heat elp hall
14: heat elp bed 2")}));
end HeatingSchedule;
