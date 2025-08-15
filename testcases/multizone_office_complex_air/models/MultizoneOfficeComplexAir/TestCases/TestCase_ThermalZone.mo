within MultizoneOfficeComplexAir.TestCases;
model TestCase_ThermalZone
  "Complex office building model that includes air side systems, water side systems from Modelica, and building thermal load calucation from EnergyPlus."
  extends Modelica.Icons.Example;

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC_ThermalZone hva
    "Full HVAC system that contains the airside and waterside systems and controls"
    annotation (Placement(transformation(extent={{20,20},{-20,60}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      Interval=600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This testcase represents a large office building that includes HVAC system (i.e., air side systems, water side systems) from Modelica, and building thermal load calculation module from EnergyPlus.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC</a> for a description of the HVAC system, and see the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper\">MultizoneOfficeComplexAir.BaseClasses.LoadSide.LoadWrapper</a> for a description of the building thermal load calculated by EnergyPlus. </span></p>
<h4>Spawn Version</h4>
<p>Please use version <i>spawn-0.3.0-8d93151657</i> for BOPTEST environment; and use version <i>spawn-0.3.0-0fa49be497</i> for running testcases with Modlelica Buildings library.</p>
</html>", revisions="<html>
<ul>
<li>August 17, 2023, by Xing Lu, Sen Huang: </li>
<p>First implementation.</p>
</ul>
</html>"),
    __Dymola_Commands(file="Resources/script/Testcase.mos"
        "Simulate and Plot"));
end TestCase_ThermalZone;
