within MultizoneOfficeComplexAir.TestCases;
model TestCase
  extends Modelica.Icons.Example;

  BaseClasses.LoadSide.LoadWrapper loaEPlus
    "Load calculation in EnergyPlus using Spawn"
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC hvac(
    alpha=0.8,
  floor1(duaFanAirHanUnit(
      mixingBox(
        mixBox(
          valRet(riseTime=15, y_start=1),
          valExh(riseTime=15, y_start=0),
          valFre(riseTime=15, y_start=0))),
      retFan(VarSpeFloMov(use_inputFilter=true, y_start=0)),
      supFan(variableSpeed(variableSpeed(zerSpe(k=0)), booleanExpression(y=true)),
      withoutMotor(VarSpeFloMov(use_inputFilter=true, y_start=0))),
      cooCoil(val(use_inputFilter=true, y_start=0)))),
  floor2(duaFanAirHanUnit(
      mixingBox(
        mixBox(
          valRet(riseTime=15, y_start=1),
          valExh(riseTime=15, y_start=0),
          valFre(riseTime=15, y_start=0))),
      retFan(VarSpeFloMov(use_inputFilter=true, y_start=0)),
      supFan(variableSpeed(variableSpeed(zerSpe(k=0)), booleanExpression(y=true)),
      withoutMotor(VarSpeFloMov(use_inputFilter=true, y_start=0))),
      cooCoil(val(use_inputFilter=true, y_start=0)))),
  floor3(duaFanAirHanUnit(
      mixingBox(
        mixBox(
          valRet(riseTime=15, y_start=1),
          valExh(riseTime=15, y_start=0),
          valFre(riseTime=15, y_start=0))),
      retFan(VarSpeFloMov(use_inputFilter=true, y_start=0)),
      supFan(variableSpeed(variableSpeed(zerSpe(k=0)), booleanExpression(y=true)),
      withoutMotor(VarSpeFloMov(use_inputFilter=true, y_start=0))),
      cooCoil(val(use_inputFilter=true, y_start=0)))),
    zonCon(heaCon(k=0.01), cooCon(k=0.1)))
                                          "Full HVAC system that contains the plant side and air side"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression extConSet "External control setpoints"
    annotation (Placement(transformation(extent={{-80,-28},{-62,-12}})));
  Modelica.Blocks.Sources.BooleanExpression extConAct
    "External control activation signal"
    annotation (Placement(transformation(extent={{-80,-46},{-62,-30}})));
equation
  connect(loaEPlus.Temp, hvac.TZon) annotation (Line(points={{12,-40},{28,-40},{
          28,0},{11,0}}, color={0,0,127}));
  connect(hvac.Occ, loaEPlus.Occ) annotation (Line(points={{-11.4,8},{-20,8},{-20,
          -20},{0,-20},{0,-29}}, color={0,0,127}));
  connect(loaEPlus.Loa, hvac.Load) annotation (Line(points={{-11,-40},{-28,-40},
          {-28,4},{-11.4,4}}, color={0,0,127}));
  connect(loaEPlus.Drybulb, hvac.TDryBul) annotation (Line(points={{-11,-48},{-32,
          -48},{-32,1.80411e-16},{-11.4,1.80411e-16}},
                                   color={0,0,127}));
  connect(loaEPlus.Wetbulb, hvac.TWetBul) annotation (Line(points={{-11,-32},{-24,
          -32},{-24,-6.05},{-11.35,-6.05}}, color={0,0,127}));
  for i in 1:15 loop
    connect(hvac.TCooSetPoi[i], extConSet.y);
    connect(hvac.TCooSetPoi_activate[i], extConAct.y);
    connect(hvac.THeaSetPoi[i], extConSet.y);
    connect(hvac.THeaSetPoi_activate[i], extConAct.y);
    connect(hvac.mAirFlow[i], extConSet.y);
    connect(hvac.mAirFlow_activate[i], extConAct.y);
    connect(hvac.yPos[i], extConSet.y);
    connect(hvac.yPos_activate[i], extConAct.y);
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=172800,
      StopTime=259200,
      __Dymola_NumberOfIntervals=1440,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end TestCase;
