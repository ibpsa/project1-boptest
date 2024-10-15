within IDEAS.Examples.PPD12;
model VentilationMPC
  "PPD12 model using off-line computed model predictive controller results"
  extends BaseClasses.VentilationNoControl(pump(inputType=IDEAS.Fluid.Types.InputType.Constant), sim(
        filNam=Modelica.Utilities.Files.loadResource(
          "modelica://IDEAS/Resources/weatherdata/Uccle.TMY")));
  Modelica.Blocks.Sources.CombiTimeTable MPCResults(
    tableOnFile=true,
    tableName="csv",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://IDEAS/Resources/Data/PPD12_MPC.csv"),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2,3,4,5,6,7,8,9}) "Table reader for off-line computed mpc results"
    annotation (Placement(transformation(extent={{-100,180},{-60,220}})));

  Modelica.SIunits.Energy EGas "Total gas energy use";
  Modelica.Blocks.Continuous.Integrator EHea(k=1/3600000) "Heater energy"
    annotation (Placement(transformation(extent={{360,-60},{380,-40}})));
initial equation
  EGas=0;
equation
  der(EGas)=QGas/3600000;

  connect(MPCResults.y[1], hea.TSet) annotation (Line(points={{-58,200},{372,
          200},{372,-102}}, color={0,0,127}));
  connect(MPCResults.y[2], fanRet.m_flow_in) annotation (Line(points={{-58,200},
          {22,200},{22,224},{350,224},{350,202}}, color={0,0,127}));
  connect(MPCResults.y[3], fanSup.m_flow_in) annotation (Line(points={{-58,200},
          {24,200},{24,222},{350,222},{350,140}}, color={0,0,127}));
  connect(MPCResults.y[4], bypassRet.ctrl) annotation (Line(points={{-58,200},{
          38,200},{38,200.8},{310,200.8}}, color={0,0,127}));
  connect(bypassSup.ctrl, bypassRet.ctrl) annotation (Line(points={{310,119.2},
          {310,116},{320,116},{320,200.8},{310,200.8}}, color={0,0,127}));
  connect(EHea.u, hea.Q_flow) annotation (Line(points={{358,-50},{349,-50},{349,
          -102}}, color={0,0,127}));
  annotation (experiment(
      StopTime=31500000,
      __Dymola_NumberOfIntervals=15000,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"), __Dymola_Commands(executeCall={simulateModel(
          "IDEAS.Examples.PPD12.VentilationMPC",
          stopTime=31500000,
          numberOfIntervals=15000,
          method="Euler",
          fixedstepsize=15,
          resultFile="VentilationMPC"),simulateModel(
          "IDEAS.Examples.PPD12.VentilationRBC",
          stopTime=31500000,
          numberOfIntervals=15000,
          method="Euler",
          tolerance=1e-06,
          fixedstepsize=15,
          resultFile="VentilationRBC"),createPlot(
          id=1,
          position={0,0,1301,713},
          y={"living.TSensor"},
          range={0.0,32000000.0,15.0,40.0},
          legends={"Living temperature MPC"},
          grid=true,
          filename="VentilationMPC.mat",
          colors={{238,46,47}},
          displayUnits={"degC"}) == 0,createPlot(
          id=1,
          position={0,0,1301,713},
          y={"living.TSensor"},
          range={0.0,32000000.0,15.0,40.0},
          legends={"Living temperature RBC"},
          erase=false,
          grid=true,
          filename="VentilationRBC.mat",
          colors={{28,108,200}},
          displayUnits={"degC"}) == 0,createPlot(
          id=1,
          position={0,0,1301,354},
          y={"EGas"},
          range={0.0,32000000.0,-1000.0,8000.0},
          legends={"Gas use MPC"},
          grid=true,
          filename="VentilationMPC.mat",
          subPlot=2,
          colors={{238,46,47}}) == 0,createPlot(
          id=1,
          position={0,0,1301,354},
          y={"EGas"},
          range={0.0,32000000.0,-1000.0,8000.0},
          legends={"Gas use RBC"},
          erase=false,
          grid=true,
          filename="VentilationRBC.mat",
          subPlot=2,
          colors={{28,108,200}}) == 0} "Simulate and compare (long simulation)"),
    Documentation(info="<html>
<p>This model uses the weather file Uccle.TMY since it was used when the reference results were generated.</p>
</html>", revisions="<html>
<ul>
<li>
April 19, 2021 by Filip Jorissen:<br/>
Updated weather file
</li>
</ul>
</html>"));
end VentilationMPC;
