within MultizoneOfficeComplexAir.TestCases;
model TestCase "Complex office building model that includes air side systems, water side systems from Modelica, and building thermal load calucation from EnergyPlus."
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
    "Full HVAC system that contains the airside and waterside systems and controls"
    annotation (Placement(transformation(extent={{20,20},{-20,60}})));

  MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper loaEnePlu(building(
        spawnExe="spawn-0.3.0-0fa49be497"))
    "Load calculation in EnergyPlus using Spawn, note this version spawn-0.3.0-8d93151657 is specified for BOPTEST environment; Use spawn-0.3.0-0fa49be497 for Buildings library version"
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));

equation
  connect(loaEnePlu.occ, hva.occ) annotation (Line(points={{22,-56.8},{22,-56},
          {46,-56},{46,56},{22.8,56}},
                              color={0,0,127}));
  connect(loaEnePlu.loa, hva.loa) annotation (Line(points={{22,-44},{42,-44},{
          42,50},{22.8,50}},
                           color={0,0,127}));
  connect(loaEnePlu.dryBul, hva.TDryBul) annotation (Line(points={{22,-28},{34,
          -28},{34,36},{22.8,36}}, color={0,0,127}));
  connect(loaEnePlu.wetBul, hva.TWetBul) annotation (Line(points={{22,-22},{30,
          -22},{30,26.3},{22.7,26.3}},    color={0,0,127}));
  connect(hva.TZon, loaEnePlu.T) annotation (Line(points={{-22,40},{-34,40},{
          -34,-40},{-24,-40}},
                           color={0,0,127}));
  connect(loaEnePlu.numOcc, hva.numOcc) annotation (Line(points={{22,-36},{38,
          -36},{38,44},{22.8,44}},   color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=604800,
      __Dymola_NumberOfIntervals=1440,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This testcase represents a large office building that includes HVAC system (i.e., air side systems, water side systems) from Modelica, and building thermal load calculation module from EnergyPlus.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC</a> for a description of the HVAC system, and see the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper\">MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper</a> for a description of the building thermal load calculated by EnergyPlus. </span></p>
<h4>Spawn Version</h4>
<p>Please use version <i>spawn-0.3.0-8d93151657</i> for BOPTEST environment; and use version <i>spawn-0.3.0-0fa49be497</i> for running testcases with Modlelica Buildings library.</p>
</html>", revisions = "<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang, Yan Chen:
<p> First implementation.</p>
</ul>
</html>"),
    __Dymola_Commands(file="Resources/script/Testcase.mos"
        "Simulate and Plot"));
end TestCase;
