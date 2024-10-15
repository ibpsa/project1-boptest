within IDEAS.Examples.TwinHouses.BaseClasses.HeatingSystems;
model ElectricHeating_Twinhouse_Tset
  "Electric heating Twinhouse| measured temperature as setpoint"

  final parameter String dirPath = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/measurements/");
  final parameter String filename = if exp==1 and bui== 1 then "MeasurementTwinHouseN2Exp1.txt" elseif exp==2 and bui==1 then "MeasurementTwinHouseN2Exp2.txt" else "MeasurementTwinHouseO5.txt";


  extends IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    P={QHeaSys/COP},
    QHeaSys=sum(IDEAL_heating_rad.Q_flow)+sum(IDEAL_heating_con.Q_flow),
    nLoads=1,nZones=7,nEmbPorts=0);

  parameter Integer exp = 1 "Experiment number: 1 or 2";
  parameter Integer bui = 1 "Building number 1 (N2), 2 (O5)";
  parameter Real[nZones] Crad "thermal mass of radiator";
  parameter Real[nZones] Kemission "heat transfer coefficient";
  parameter Real COP=1;
  Modelica.SIunits.Power[nZones] Qhea;
  final parameter Real frad=0.3 "radiative fraction";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nZones] IDEAL_heating_con
    annotation (Placement(transformation(extent={{8,-12},{-12,8}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nZones] IDEAL_heating_rad
    annotation (Placement(transformation(extent={{6,-44},{-14,-24}})));
  Modelica.Blocks.Math.Add[nZones] add(
    each k1=+100000,
    each k2=-100000)
    annotation (Placement(transformation(extent={{80,12},{56,36}})));
  Modelica.Blocks.Sources.CombiTimeTable measuredInput(
    tableOnFile=true,
    tableName="data",
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    columns=2:15,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    fileName=dirPath + filename)
    annotation (Placement(transformation(extent={{-56,50},{-36,70}})));
  Modelica.Blocks.Math.UnitConversions.From_degC[7] TdegC
    annotation (Placement(transformation(extent={{16,56},{36,76}})));
  Modelica.Blocks.Math.Gain[7] fradGain(each k=frad)
    annotation (Placement(transformation(extent={{38,-30},{26,-18}})));
  Modelica.Blocks.Math.Gain[7] fconGain(each k=1 - frad)
    annotation (Placement(transformation(extent={{36,-2},{24,10}})));
initial equation
  assert(exp==1 or exp==2, "Only experiment numbers 1 or 2 are supported.");
  assert(not
            (exp==2 and bui==2), "Combination of exp=2 and bui=2 does not exist");

equation
  Qhea = IDEAL_heating_rad.Q_flow+IDEAL_heating_con.Q_flow;


  connect(IDEAL_heating_con.port, heatPortCon) annotation (Line(
      points={{-12,-2},{-106,-2},{-106,20},{-200,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(IDEAL_heating_rad.port, heatPortRad) annotation (Line(
      points={{-14,-34},{-108,-34},{-108,-20},{-200,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TSensor, add.u2) annotation (Line(points={{-204,-60},{-54,-60},{94,-60},
          {94,16.8},{82.4,16.8}}, color={0,0,127}));
  connect(measuredInput.y[1:7],TdegC [1:7].u) annotation (Line(points={{-35,60},
          {-10,60},{-10,66},{14,66}},
                             color={0,0,127}));
  connect(TdegC.y, add.u1) annotation (Line(points={{37,66},{94,66},{94,31.2},{82.4,
          31.2}}, color={0,0,127}));
  connect(add.y, fconGain.u) annotation (Line(points={{54.8,24},{48,24},{48,6},{
          37.2,6},{37.2,4}}, color={0,0,127}));
  connect(fconGain.y, IDEAL_heating_con.Q_flow) annotation (Line(points={{23.4,4},
          {18,4},{18,-2},{8,-2}}, color={0,0,127}));
  connect(add.y, fradGain.u) annotation (Line(points={{54.8,24},{54.8,-1},{39.2,
          -1},{39.2,-24}}, color={0,0,127}));
  connect(fradGain.y, IDEAL_heating_rad.Q_flow) annotation (Line(points={{25.4,-24},
          {16,-24},{16,-34},{6,-34}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-200,-100},
            {200,100}}), graphics={Text(
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
end ElectricHeating_Twinhouse_Tset;
