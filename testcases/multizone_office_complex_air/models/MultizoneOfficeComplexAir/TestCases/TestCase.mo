within MultizoneOfficeComplexAir.TestCases;
model TestCase "Complex office building model that includes air side systems, water side systems from Modelica, and building thermal load calucation from EnergyPlus."
  extends Modelica.Icons.Example;

  MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper loaEnePlu
    "Load calculation in EnergyPlus using Spawn, note this version spawn-0.3.0-8d93151657 is specified for BOPTEST environment; Use spawn-0.3.0-0fa49be497 for Buildings library version"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC hva(
    floor1(duaFanAirHanUni(
        mixingBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=0),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                use_inputFilter=true, y_start=0))),
        cooCoi(val(use_inputFilter=true, y_start=0)))),
    floor2(duaFanAirHanUni(
        mixingBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=0),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                use_inputFilter=true, y_start=0))),
        cooCoi(val(use_inputFilter=true, y_start=0)))),
    floor3(duaFanAirHanUni(
        mixingBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=0),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                use_inputFilter=true, y_start=0))),
        cooCoi(val(use_inputFilter=true, y_start=0)))))
    "Full HVAC system that contains the airside and waterside systems and controls"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));

equation
  connect(hva.Occ, loaEnePlu.occ) annotation (Line(points={{11.4,8},{24,8},{24,
          -48.4},{11,-48.4}}, color={0,0,127}));
  connect(loaEnePlu.loa, hva.loa) annotation (Line(points={{11,-42},{22,-42},{
          22,3},{11.4,3}}, color={0,0,127}));
  connect(loaEnePlu.dryBul, hva.TDryBul) annotation (Line(points={{11,-34},{20,
          -34},{20,-2},{11.4,-2}}, color={0,0,127}));
  connect(loaEnePlu.wetBul, hva.TWetBul) annotation (Line(points={{11,-31},{18,
          -31},{18,-6.85},{11.35,-6.85}}, color={0,0,127}));

  connect(hva.TZon, loaEnePlu.Tem) annotation (Line(points={{-11,0},{-20,0},{-20,
          -40},{-12,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      __Dymola_NumberOfIntervals=1440,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This testcase represents a large office building model that includes HVAC system (i.e., air side systems, water side systems) from Modelica, and building thermal load calculation module from EnergyPlus.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC\">Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC</a> for a description of the HVAC system, 
and see the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper\"> MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper</a> for a description of the building thermal load calculated by EnergyPlus. </span></p>
</html>", revisions = "<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang:
<p> First implementation.</p>
</ul>
</html>"));
end TestCase;
