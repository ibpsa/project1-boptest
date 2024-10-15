within IDEAS.LIDEAS.Validation;
model Case900ValidationNonLinear "Model to validate the linearization method by simulating both the original model and the obtained state space model."
  extends IDEAS.LIDEAS.Validation.Case900Linearise(sim(lineariseDymola=false,
        createOutputs=true));
  Buildings.Components.RectangularZoneTemplate recZon(
    h=2.7,
    redeclare package Medium = IDEAS.Media.Air,
    n50=0.822*0.5*20,
    redeclare Buildings.Components.ZoneAirModels.WellMixedAir airModel,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    hasWinCei=false,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightRoof conTypCei,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyFloor conTypFlo,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypA,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypB,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypC,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypD,
    hasWinA=true,
    fracA=0,
    redeclare IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazingA,
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties
      shaTypA,
    hasWinB=false,
    hasWinC=false,
    hasWinD=false,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    aziA=IDEAS.Types.Azimuth.S,
    mSenFac=0.822,
    l=8,
    w=6,
    A_winA=12,
    T_start=293.15) "Zone model representing Case900"
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));

     Modelica.Blocks.Sources.RealExpression preInp[nInp](y={winBusOut[1].AbsQFlow[1], winBusOut[1].AbsQFlow[2], winBusOut[1].AbsQFlow[3],
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
  weaBusOut.solDirPer, weaBusOut.phi})
                   "Precomputed input values"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/LIDEAS/ssm_Case900Linearise.mat");
  final parameter Integer nSta = Bsize[1] "Number of states";
  final parameter Integer nInp = Bsize[2] "Number of inputs";
  final parameter Integer nPreInp = size(preInp,1) "Number of precomputed inputs";
  final parameter Integer nOut = Csize[1] "Number of precomputed outputs";
   Modelica.Blocks.Continuous.StateSpace stateSpace(
     A=readMatrix(fileName=fileName, matrixName="A", rows=nSta, columns = nSta),
     B=readMatrix(fileName=fileName, matrixName="B", rows=nSta, columns = nInp),
     C=readMatrix(fileName=fileName, matrixName="C", rows=nOut, columns=nSta),
     D=readMatrix(fileName=fileName, matrixName="D", rows=nOut, columns=nInp),
     x_start=x_start,
    initType=Modelica.Blocks.Types.Init.InitialState) "State space model"
     annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
protected
  parameter Real x_start[nSta](each fixed=false) "Initial state values";
  final parameter Integer[2] Bsize = readMatrixSize(fileName=fileName, matrixName="B") "Size of B matrix of state space model";
  final parameter Integer[2] Csize = readMatrixSize(fileName=fileName, matrixName="C") "Size of C matrix of state space model";

public
  Modelica.Blocks.Math.UnitConversions.To_degC TRecZon
    "Temperature of the rectangular zone model"
    annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  Modelica.Blocks.Math.UnitConversions.To_degC TLinRecZon
    "Zone temperature of linear rectangular zone model"
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Blocks.Math.Add err_linRecZon_ssm(k2=-1)
    "Difference between the temperature of the zone models and the state space model outputs"
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Modelica.Blocks.Math.UnitConversions.To_degC TSsm
    "Zone temperature of the state space model"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Math.Add err_linRecZon_recZon(k2=-1)
    "Difference between the temperature of the zone models and the state space model outputs"
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
initial algorithm
  x_start :={linRecZon.airModel.vol.T,
linRecZon.winA.heaCapGlaInt.T,
linRecZon.winA.heaCapGlaExt.T,
linRecZon.bouFlo.layMul.monLay[1].monLayDyn.T[1],
linRecZon.bouFlo.layMul.monLay[1].monLayDyn.T[2],
linRecZon.bouFlo.layMul.monLay[2].monLayDyn.T[1],
linRecZon.outA.layMul.monLay[1].monLayDyn.T[1],
linRecZon.outA.layMul.monLay[1].monLayDyn.T[2],
linRecZon.outA.layMul.monLay[2].monLayDyn.T[1],
linRecZon.outA.layMul.monLay[3].monLayDyn.T[1],
linRecZon.outA.layMul.monLay[3].monLayDyn.T[2],
linRecZon.outB.layMul.monLay[1].monLayDyn.T[1],
linRecZon.outB.layMul.monLay[1].monLayDyn.T[2],
linRecZon.outB.layMul.monLay[2].monLayDyn.T[1],
linRecZon.outB.layMul.monLay[3].monLayDyn.T[1],
linRecZon.outB.layMul.monLay[3].monLayDyn.T[2],
linRecZon.outC.layMul.monLay[1].monLayDyn.T[1],
linRecZon.outC.layMul.monLay[1].monLayDyn.T[2],
linRecZon.outC.layMul.monLay[2].monLayDyn.T[1],
linRecZon.outC.layMul.monLay[3].monLayDyn.T[1],
linRecZon.outC.layMul.monLay[3].monLayDyn.T[2],
linRecZon.outD.layMul.monLay[1].monLayDyn.T[1],
linRecZon.outD.layMul.monLay[1].monLayDyn.T[2],
linRecZon.outD.layMul.monLay[2].monLayDyn.T[1],
linRecZon.outD.layMul.monLay[3].monLayDyn.T[1],
linRecZon.outD.layMul.monLay[3].monLayDyn.T[2],
linRecZon.outCei.layMul.monLay[1].monLayDyn.T[1],
linRecZon.outCei.layMul.monLay[1].monLayDyn.T[2],
linRecZon.outCei.layMul.monLay[2].monLayDyn.T[1],
linRecZon.outCei.layMul.monLay[3].monLayDyn.T[1]};




equation
  connect(preInp.y, stateSpace.u)
    annotation (Line(points={{-19,0},{-12,0}}, color={0,0,127}));
  connect(recZon.TSensor, TRecZon.u)
    annotation (Line(points={{11,-68},{20,-68},{20,-70},{28,-70}},
                                                   color={0,0,127}));
  connect(stateSpace.y[1], TSsm.u)
    annotation (Line(points={{11,0},{28,0}}, color={0,0,127}));
  connect(TSsm.y, err_linRecZon_ssm.u2) annotation (Line(points={{51,0},{51,0},{
          74,0},{74,34},{78,34}}, color={0,0,127}));
  connect(TRecZon.y, err_linRecZon_recZon.u2) annotation (Line(points={{51,-70},
          {60,-70},{60,-46},{78,-46}}, color={0,0,127}));
  connect(linRecZon.TSensor, TLinRecZon.u)
    annotation (Line(points={{11,72},{19.3,70},{28,70}},   color={0,0,127}));
  connect(TLinRecZon.y, err_linRecZon_ssm.u1) annotation (Line(points={{51,70},{
          60,70},{60,46},{78,46}}, color={0,0,127}));
  connect(TLinRecZon.y, err_linRecZon_recZon.u1) annotation (Line(points={{51,70},
          {60,70},{60,-34},{78,-34}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100000, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/LIDEAS/Validation/Case900ValidationNonLinear.mos"
        "Linearise, simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
December 11, 2019, by Filip Jorissen:<br/>
Revised input list for
issue <a href=https://github.com/open-ideas/IDEAS/issues/1089>#1089</a>.
</li>
<li>August 21, 2018 by Damien Picard: <br/>Adapt the name of the states which have 
changed due to the change of medium to <code>IDEAS.Media.Specialized.DryAir</code>.</li>
<li>May 15, 2018 by Damien Picard: <br/>First implementation</li>
</ul>
</html>", info="<html>
<p>Notice that this model has the commando Linearise, simulate and plot. The model being linearised is IDEAS.LIDEAS.Examples.ZoneLinearise. The linearisation creates 3 text files and 1 mat file in the simulation folder: uNames_ZoneLinearise.txt (inputs name), xNames_ZoneLinearise.txt (state names), yNames_ZoneLinearise.txt (output names) and ssm_ZoneLinearise.mat (state space model). The name of the states were manually copied into the model to retrieve the initial state values (x_start). Also the input names were manually copied to feed their value to the SSM model included in this example. However, the input names winBusIn and weaBus were renamed to winBusOut and weaBusOut to coincide with the variables created in the model.</p>
</html>"));
end Case900ValidationNonLinear;
