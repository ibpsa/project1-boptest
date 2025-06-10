within MultizoneOfficeComplexAir.TestCases;
model TestCase "Complex office building model that includes air side systems, water side systems from Modelica, and building thermal load calucation from EnergyPlus."
  extends Modelica.Icons.Example;

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC hva
    "Full HVAC system that contains the airside and waterside systems and controls"
    annotation (Placement(transformation(extent={{20,20},{-20,60}})));

  MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper loaEnePlu(building(
        spawnExe="spawn-0.3.0-0fa49be497"))
    "Load calculation in EnergyPlus using Spawn, note this version spawn-0.3.0-8d93151657 is specified for BOPTEST environment; Use spawn-0.3.0-0fa49be497 for Buildings library version"
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));

equation
  connect(loaEnePlu.yHvaOpe, hva.occ) annotation (Line(points={{22,-56.8},{22,-56},
          {46,-56},{46,56},{22.8,56}}, color={0,0,127}));
  connect(loaEnePlu.QLoa, hva.QLoa) annotation (Line(points={{22,-44},{40,-44},
          {40,50},{22.8,50}}, color={0,0,127}));
  connect(hva.TZon, loaEnePlu.TZonAir) annotation (Line(points={{-22,40},{-40,
          40},{-40,-40},{-24,-40}}, color={0,0,127}));
  connect(loaEnePlu.numOcc, hva.numOcc) annotation (Line(points={{22,-36},{34,
          -36},{34,44},{22.8,44}},   color={0,0,127}));
  connect(loaEnePlu.weaBus, hva.weaBus) annotation (Line(
      points={{0,-20},{0,20}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=604800,
      Interval=599.999616,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This testcase represents a large office building that includes HVAC system (i.e., air side systems, water side systems) from Modelica, and building thermal load calculation module from EnergyPlus.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC</a> for a description of the HVAC system, and see the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper\">MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper</a> for a description of the building thermal load calculated by EnergyPlus. </span></p>
<h4>Spawn Version</h4>
<p>Please use version <i>spawn-0.3.0-8d93151657</i> for BOPTEST environment; and use version <i>spawn-0.3.0-0fa49be497</i> for running testcases with Modlelica Buildings library.</p>
</html>", revisions="<html>
<ul>
<li>August 8, 2024, by Guowen Li, Xing Lu, Yan Chen: </li>
<p>Added CO2 and air infiltration features; Adjusted system equipment sizing; Reduced nonlinear system warnings.</p>
<li>August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang, Yan Chen: </li>
<p>First implementation.</p>
</ul>
</html>"),
    __Dymola_Commands(file="Resources/script/Testcase.mos"
        "Simulate and Plot"));
end TestCase;
