within MultizoneOfficeComplexAir.TestCases;
model TestSuccess
  extends Modelica.Icons.Example;
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC hva(
    floor1(duaFanAirHanUni(
        mixBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=0),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                use_inputFilter=true, y_start=0))),
        cooCoi(val(use_inputFilter=true, y_start=0)))),
    floor2(duaFanAirHanUni(
        mixBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=0),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                use_inputFilter=true, y_start=0))),
        cooCoi(val(use_inputFilter=true, y_start=0)))),
    floor3(duaFanAirHanUni(
        mixBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=0),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                use_inputFilter=true, y_start=0))),
        cooCoi(val(use_inputFilter=true, y_start=0)))))
    annotation (Placement(transformation(extent={{20,-50},{-20,-10}})));

  BaseClasses.LoadSide.LoadWrapper loaEnePlu(building(spawnExe=
          "spawn-0.3.0-0fa49be497"))
    "Load calculation in EnergyPlus using Spawn, note this version spawn-0.3.0-8d93151657 is specified for BOPTEST environment; Use spawn-0.3.0-0fa49be497 for Buildings library version"
    annotation (Placement(transformation(extent={{-20,10},{20,50}})));
equation
  connect(hva.TZon, loaEnePlu.T) annotation (Line(points={{-22,-30},{-34,-30},{
          -34,30},{-24,30}}, color={0,0,127}));
  connect(loaEnePlu.wetBul, hva.TWetBul) annotation (Line(points={{22,48},{54,
          48},{54,-43.7},{22.7,-43.7}}, color={0,0,127}));
  connect(loaEnePlu.dryBul, hva.TDryBul) annotation (Line(points={{22,42},{50,
          42},{50,-34},{22.8,-34}}, color={0,0,127}));
  connect(loaEnePlu.loa, hva.loa) annotation (Line(points={{22,26},{46,26},{46,
          -24},{22.8,-24}}, color={0,0,127}));
  connect(loaEnePlu.occ, hva.occ) annotation (Line(points={{22,13.2},{36,13.2},
          {36,-14},{22.8,-14}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      __Dymola_NumberOfIntervals=1440,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end TestSuccess;
