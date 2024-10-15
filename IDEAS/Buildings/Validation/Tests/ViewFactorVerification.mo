within IDEAS.Buildings.Validation.Tests;
model ViewFactorVerification
  "View factor implementation verification based on case 900"

  extends Modelica.Icons.Example;

  inner IDEAS.BoundaryConditions.SimInfoManager sim    annotation (Placement(transformation(extent={{-92,68},{-82,78}})));

  IDEAS.Buildings.Validation.Cases.Case900 CaseVf(building(gF(calculateViewFactor=true)))
    annotation (Placement(transformation(extent={{-76,4},{-64,16}})));
  IDEAS.Buildings.Validation.Cases.Case900 CaseNoVf(building(gF(calculateViewFactor=false)))
    annotation (Placement(transformation(extent={{-76,-16},{-64,-4}})));
initial equation
  assert(abs(CaseVf.building.gF.radDistr.iSolDir.Q_flow + CaseVf.building.gF.radDistr.iSolDif.Q_flow + CaseVf.building.gF.radDistr.radGain.Q_flow+ sum(CaseVf.building.gF.radDistr.radSurfTot.Q_flow))<1e-4, "Energy is not conserved in zone model!");
 for i in 1:6 loop
     assert( abs(sum(CaseVf.building.gF.zoneLwDistributionViewFactor.vieFacTot[i,:])-1) < Modelica.Constants.eps*1000, "View factors do not sum up to one for row " + String(i) +  "!: "+ String(abs(sum(CaseVf.building.gF.zoneLwDistributionViewFactor.vieFacTot[i,:])-1)));
 end for;

  annotation (
    experiment(
      StopTime=31536000,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={         Text(
          extent={{-78,28},{-40,20}},
          lineColor={85,0,0},
          fontName="Calibri",
          textStyle={TextStyle.Bold},
          textString="BESTEST 900 Series")}),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Validation/Tests/ViewFactorVerification.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
March, 2015, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model simulates Bestest case 900 two times. Once with and once without explicit view factor implementation. Use the added command to plot the difference in results between the two implementations.</p>
</html>"));
end ViewFactorVerification;
