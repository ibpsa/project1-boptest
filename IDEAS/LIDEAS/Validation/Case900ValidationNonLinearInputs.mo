within IDEAS.LIDEAS.Validation;
model Case900ValidationNonLinearInputs "Model to validate the linearization method by simulating both the original model and the obtained state space model."
  extends Case900ValidationNonLinear(preInp(y={winBusOut[1].AbsQFlow[1], winBusOut[1].AbsQFlow[2], winBusOut[1].AbsQFlow[3],
   winBusOut[1].iSolDir, winBusOut[1].iSolDif, weaBusOut.solTim,
  weaBusOut.solBus[1].HDirTil, weaBusOut.solBus[1].HSkyDifTil, weaBusOut.solBus[1].HGroDifTil,
   weaBusOut.solBus[1].hForcedConExt, weaBusOut.solBus[1].Tenv, weaBusOut.solBus[2].HDirTil,
   weaBusOut.solBus[2].HSkyDifTil, weaBusOut.solBus[2].HGroDifTil,
  weaBusOut.solBus[2].hForcedConExt, weaBusOut.solBus[2].Tenv, weaBusOut.solBus[3].HDirTil,
   weaBusOut.solBus[3].HSkyDifTil, weaBusOut.solBus[3].HGroDifTil,
  weaBusOut.solBus[3].hForcedConExt, weaBusOut.solBus[3].Tenv, weaBusOut.solBus[4].HDirTil,
   weaBusOut.solBus[4].HSkyDifTil, weaBusOut.solBus[4].HGroDifTil,
  weaBusOut.solBus[4].hForcedConExt, weaBusOut.solBus[4].Tenv, weaBusOut.solBus[5].HDirTil,
   weaBusOut.solBus[5].HSkyDifTil, weaBusOut.solBus[5].HGroDifTil,
  weaBusOut.solBus[5].hForcedConExt, weaBusOut.solBus[5].Tenv, weaBusOut.solBus[6].HDirTil,
   weaBusOut.solBus[6].HSkyDifTil, weaBusOut.solBus[6].HGroDifTil,
  weaBusOut.solBus[6].hForcedConExt, weaBusOut.solBus[6].Tenv, weaBusOut.Te,
  weaBusOut.Tdes, weaBusOut.TGroundDes, weaBusOut.Va, weaBusOut.Vdir,
  weaBusOut.X_wEnv, weaBusOut.CEnv, weaBusOut.dummy, weaBusOut.TskyPow4,
  weaBusOut.TePow4, weaBusOut.solGloHor, weaBusOut.solDifHor, weaBusOut.F1,
  weaBusOut.F2, weaBusOut.angZen, weaBusOut.angHou, weaBusOut.angDec,
  weaBusOut.solDirPer, weaBusOut.phi,
          gainCon.y,gainRad.y}),
      fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/LIDEAS/ssm_Case900LineariseInputs.mat"));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedQCon "Prescribed convective heat flow for linRect zone"
    annotation (Placement(transformation(extent={{-68,10},{-48,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedQRad "Prescribed radiative heat flow for linRect zone"
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
public
  Modelica.Blocks.Sources.Sine QCon(
    freqHz=1/1/3600,
    amplitude=1,
    offset=1)  "Fake convective gains"
    annotation (Placement(transformation(extent={{-100,14},{-88,26}})));
public
  Modelica.Blocks.Sources.Sine QRad(
    freqHz=1/6/3600,
    amplitude=1,
    offset=1)        "Fake radiative gains"
    annotation (Placement(transformation(extent={{-100,-6},{-88,6}})));
  Modelica.Blocks.Math.Gain gainCon(k=500) "Gain to scale convective gain"
    annotation (Placement(transformation(extent={{-82,16},{-74,24}})));
  Modelica.Blocks.Math.Gain gainRad(k=500) "Gain to scale radiative gain"
    annotation (Placement(transformation(extent={{-82,-4},{-74,4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedQCon1 "Prescribed convective heat flow for rect zone"
    annotation (Placement(transformation(extent={{-68,-30},{-48,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedQRad1 "Prescribed radiative heat flow for rect zone"
    annotation (Placement(transformation(extent={{-68,-50},{-48,-30}})));
equation
  connect(prescribedQCon.port, linRecZon.gainCon) annotation (Line(points={{-48,
          20},{-48,20},{-44,20},{-44,54},{12,54},{12,67},{10,67}}, color={191,0,
          0}));
  connect(prescribedQRad.port, linRecZon.gainRad) annotation (Line(points={{-48,0},
          {-42,0},{-42,52},{14,52},{14,64},{10,64}},        color={191,0,0}));
  connect(QCon.y, gainCon.u) annotation (Line(points={{-87.4,20},{-86,20},{-82.8,
          20}}, color={0,0,127}));
  connect(gainCon.y, prescribedQCon.Q_flow)
    annotation (Line(points={{-73.6,20},{-70,20},{-68,20}}, color={0,0,127}));
  connect(QRad.y, gainRad.u)
    annotation (Line(points={{-87.4,0},{-82.8,0}}, color={0,0,127}));
  connect(gainRad.y, prescribedQRad.Q_flow)
    annotation (Line(points={{-73.6,0},{-70,0},{-68,0}}, color={0,0,127}));
  connect(prescribedQCon1.Q_flow, prescribedQCon.Q_flow) annotation (Line(
        points={{-68,-20},{-72,-20},{-72,20},{-68,20}}, color={0,0,127}));
  connect(prescribedQRad1.Q_flow, gainRad.y) annotation (Line(points={{-68,-40},
          {-73.6,-40},{-73.6,0}}, color={0,0,127}));
  connect(prescribedQCon1.port, recZon.gainCon) annotation (Line(points={{-48,-20},
          {-40,-20},{-40,-84},{14,-84},{14,-73},{10,-73}}, color={191,0,0}));
  connect(prescribedQRad1.port, recZon.gainRad) annotation (Line(points={{-48,-40},
          {-46,-40},{-42,-40},{-42,-86},{16,-86},{16,-76},{10,-76}}, color={191,
          0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100000, Tolerance=1e-06),
    __Dymola_Commands(file="Resources/Scripts/Dymola/LIDEAS/Validation/Case900ValidationNonLinearInputs.mos"
        "Linearise, simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
December 11, 2019, by Filip Jorissen:<br/>
Revised input list for
issue <a href=https://github.com/open-ideas/IDEAS/issues/1089>#1089</a>.
</li>
<li>May 15, 2018 by Damien Picard: <br/>First implementation</li>
</ul>
</html>", info="<html>
<p>Notice that this model has the commando Linearise, simulate and plot. The model being linearised is IDEAS.LIDEAS.Examples.ZoneLinearise. The linearisation creates 3 text files and 1 mat file in the simulation folder: uNames_ZoneLinearise.txt (inputs name), xNames_ZoneLinearise.txt (state names), yNames_ZoneLinearise.txt (output names) and ssm_ZoneLinearise.mat (state space model). The name of the states were manually copied into the model to retrieve the initial state values (x_start). Also the input names were manually copied to feed their value to the SSM model included in this example. However, the input names winBusIn, weaBus, QCon and QRad were renamed to winBusOut, weaBusOut, gainCon and gainRad to coincide with the variables created in the model.</p>
</html>"));
end Case900ValidationNonLinearInputs;
