within IDEAS.LIDEAS.Components;
model LinRectangularZoneTemplate
  extends IDEAS.Buildings.Components.Interfaces.RectangularZoneTemplateInterface(
    redeclare IDEAS.Buildings.Components.ZoneAirModels.WellMixedAir
      airModel(stateSelectTVol=StateSelect.prefer),
    redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow);

  parameter Boolean linearise=sim.linearise
    "Linearises equations"
     annotation(Dialog(tab="Linearization"));
  parameter Integer firstWindowIndex
    "Index for the first window of the zone. All window indices are computed from this index" annotation(Dialog(tab="Linearization"));
  parameter Integer indexWinA = firstWindowIndex
    "Index of window A" annotation(Dialog(tab="Linearization",enable=hasWinA));
  parameter Integer indexWinB = indexWinA + (if hasWinA then 1 else 0)
    "Index of window B" annotation(Dialog(tab="Linearization",enable=hasWinB));
  parameter Integer indexWinC = indexWinB + (if hasWinB then 1 else 0)
    "Index of window C" annotation(Dialog(tab="Linearization",enable=hasWinC));
  parameter Integer indexWinD = indexWinC + (if hasWinC then 1 else 0)
    "Index of window D" annotation(Dialog(tab="Linearization",enable=hasWinD));
  parameter Integer indexWinCei = indexWinD + (if hasWinD then 1 else 0)
    "Index of window Cei" annotation(Dialog(tab="Linearization",enable=hasWinCei));
  final parameter Integer lastWindowIndex = indexWinCei + (if hasWinCei then 1 else 0)
    "Index of the last window of the zone";

  Modelica.Blocks.Interfaces.RealInput ctrlA if
                                               shaTypA.controlled
    "Control input for windows in face A, if controlled"
    annotation (Placement(transformation(extent={{11,-11},{-11,11}},
        rotation=-90,
        origin={-171,-111}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={84,112})));
  Modelica.Blocks.Interfaces.RealInput ctrlB if
                                               shaTypB.controlled
    "Control input for windows in face B, if controlled" annotation (Placement(
        transformation(
        extent={{11,-11},{-11,11}},
        rotation=-90,
        origin={-155,-111}), iconTransformation(extent={{123,-99},{101,-77}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput ctrlC if
                                               shaTypC.controlled
    "Control input for windows in face C, if controlled" annotation (Placement(
        transformation(
        extent={{11,-11},{-11,11}},
        rotation=-90,
        origin={-139,-111}), iconTransformation(
        extent={{11,-11},{-11,11}},
        rotation=-90,
        origin={-88,-112})));
  Modelica.Blocks.Interfaces.RealInput ctrlD if
                                               shaTypD.controlled
    "Control input for windows in face D, if controlled" annotation (Placement(
        transformation(
        extent={{11,-11},{-11,11}},
        rotation=-90,
        origin={-123,-111}), iconTransformation(
        extent={{11,-11},{-11,11}},
        rotation=180,
        origin={-112,72})));
  Modelica.Blocks.Interfaces.RealInput ctrlCei if
                                               shaTypCei.controlled
    "Control input for windows in ceiling, if controlled" annotation (Placement(
        transformation(
        extent={{11,-11},{-11,11}},
        rotation=-90,
        origin={-107,-111}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={50,82})));


replaceable
  IDEAS.LIDEAS.Components.LinWindow winA(azi=aziAInt, inc=IDEAS.Types.Tilt.Wall,
    glazing(
      checkLowPerformanceGlazing=glazingA.checkLowPerformanceGlazing,
      nLay=glazingA.nLay,
      mats=glazingA.mats,
      SwAbs=glazingA.SwAbs,
      SwTrans=glazingA.SwTrans,
      SwAbsDif=glazingA.SwAbsDif,
      SwTransDif=glazingA.SwTransDif,
      U_value=glazingA.U_value,
      g_value=glazingA.g_value),
    A=A_winA,
    frac=fracA,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_win,
    linExtCon=linExtCon,
    windowDynamicsType=windowDynamicsType,
    redeclare IDEAS.Buildings.Components.Shading.Shading shaType(shaPro(
  controlled=shaTypA.controlled,
  shaType=shaTypA.shaType,
  hWin=shaTypA.hWin,
  wWin=shaTypA.wWin,
  wLeft=shaTypA.wLeft,
  wRight=shaTypA.wRight,
  ovDep=shaTypA.ovDep,
  ovGap=shaTypA.ovGap,
  hFin=shaTypA.hFin,
  finDep=shaTypA.finDep,
  finGap=shaTypA.finGap,
  L=shaTypA.L,
  dh=shaTypA.dh,
  shaCorr=shaTypA.shaCorr)),
    fraType(present=fraTypA.present,
            U_value=fraTypA.U_value),
    linExtRad=linExtRadWin,
    nWin=nWinA,
    indexWindow=indexWinA) if
       hasWinA constrainedby IDEAS.LIDEAS.Components.LinWindow(
       azi=aziAInt,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinA,
       indexWindow=indexWinA)
    "Window for face A of this zone"
    annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinA,
      choicesAllMatching=true,
      Placement(transformation(extent={{-100,0},{-90,20}})));
  replaceable
  IDEAS.LIDEAS.Components.LinWindow winB(
      inc=IDEAS.Types.Tilt.Wall,
    glazing(
      checkLowPerformanceGlazing=glazingB.checkLowPerformanceGlazing,
      nLay=glazingB.nLay,
      mats=glazingB.mats,
      SwAbs=glazingB.SwAbs,
      SwTrans=glazingB.SwTrans,
      SwAbsDif=glazingB.SwAbsDif,
      SwTransDif=glazingB.SwTransDif,
      U_value=glazingB.U_value,
      g_value=glazingB.g_value),
    A=A_winB,
    frac=fraB,
    azi=aziB,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_win,
    linExtCon=linExtCon,
    windowDynamicsType=windowDynamicsType,
    redeclare IDEAS.Buildings.Components.Shading.Shading shaType(shaPro(
  controlled=shaTypB.controlled,
  shaType=shaTypB.shaType,
  hWin=shaTypB.hWin,
  wWin=shaTypB.wWin,
  wLeft=shaTypB.wLeft,
  wRight=shaTypB.wRight,
  ovDep=shaTypB.ovDep,
  ovGap=shaTypB.ovGap,
  hFin=shaTypB.hFin,
  finDep=shaTypB.finDep,
  finGap=shaTypB.finGap,
  L=shaTypB.L,
  dh=shaTypB.dh,
  shaCorr=shaTypB.shaCorr)),
    fraType(present=fraTypB.present, U_value=fraTypB.U_value),
    linExtRad=linExtRadWin,
    nWin=nWinB,
    indexWindow=indexWinB) if
       hasWinB constrainedby IDEAS.LIDEAS.Components.LinWindow(
       azi=aziB,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinB,
       indexWindow=indexWinB)
    "Window for face B of this zone" annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinB,
      choicesAllMatching=true,
      Placement(
        transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-95,-10})));
  replaceable
  IDEAS.LIDEAS.Components.LinWindow winC(inc=IDEAS.Types.Tilt.Wall,
    glazing(
      checkLowPerformanceGlazing=glazingC.checkLowPerformanceGlazing,
      nLay=glazingC.nLay,
      mats=glazingC.mats,
      SwAbs=glazingC.SwAbs,
      SwTrans=glazingC.SwTrans,
      SwAbsDif=glazingC.SwAbsDif,
      SwTransDif=glazingC.SwTransDif,
      U_value=glazingC.U_value,
      g_value=glazingC.g_value),
    A=A_winC,
    frac=fracC,
    azi=aziC,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_win,
    linExtCon=linExtCon,
    windowDynamicsType=windowDynamicsType,
    redeclare IDEAS.Buildings.Components.Shading.Shading shaType(shaPro(
  controlled=shaTypC.controlled,
  shaType=shaTypC.shaType,
  hWin=shaTypC.hWin,
  wWin=shaTypC.wWin,
  wLeft=shaTypC.wLeft,
  wRight=shaTypC.wRight,
  ovDep=shaTypC.ovDep,
  ovGap=shaTypC.ovGap,
  hFin=shaTypC.hFin,
  finDep=shaTypC.finDep,
  finGap=shaTypC.finGap,
  L=shaTypC.L,
  dh=shaTypC.dh,
  shaCorr=shaTypC.shaCorr)),
    fraType(present=fraTypC.present, U_value=fraTypC.U_value),
    linExtRad=linExtRadWin,
    nWin=nWinC,
    indexWindow=indexWinC) if
       hasWinC constrainedby IDEAS.LIDEAS.Components.LinWindow(
       azi=aziC,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinC,
       indexWindow=indexWinC)
    "Window for face C of this zone" annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinC,
      choicesAllMatching=true,
      Placement(
        transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-95,-30})));
  replaceable
  IDEAS.LIDEAS.Components.LinWindow winD(inc=IDEAS.Types.Tilt.Wall, azi=aziD,
    glazing(
      checkLowPerformanceGlazing=glazingD.checkLowPerformanceGlazing,
      nLay=glazingD.nLay,
      mats=glazingD.mats,
      SwAbs=glazingD.SwAbs,
      SwTrans=glazingD.SwTrans,
      SwAbsDif=glazingD.SwAbsDif,
      SwTransDif=glazingD.SwTransDif,
      U_value=glazingD.U_value,
      g_value=glazingD.g_value),
    A=A_winD,
    frac=fracD,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_win,
    linExtCon=linExtCon,
    windowDynamicsType=windowDynamicsType,
    redeclare IDEAS.Buildings.Components.Shading.Shading shaType(shaPro(
      controlled=shaTypD.controlled,
  shaType=shaTypD.shaType,
  hWin=shaTypD.hWin,
  wWin=shaTypD.wWin,
  wLeft=shaTypD.wLeft,
  wRight=shaTypD.wRight,
  ovDep=shaTypD.ovDep,
  ovGap=shaTypD.ovGap,
  hFin=shaTypD.hFin,
  finDep=shaTypD.finDep,
  finGap=shaTypD.finGap,
  L=shaTypD.L,
  dh=shaTypD.dh,
  shaCorr=shaTypD.shaCorr)),
    fraType(present=fraTypD.present, U_value=fraTypD.U_value),
    linExtRad=linExtRadWin,
    nWin=nWinD,
    indexWindow=indexWinD) if
       hasWinD constrainedby IDEAS.LIDEAS.Components.LinWindow(
       azi=aziD,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinD,
       indexWindow=indexWinD)
    "Window for face D of this zone" annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinD,
      choicesAllMatching=true,
      Placement(
        transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-95,-50})));
  replaceable
  IDEAS.LIDEAS.Components.LinWindow winCei(inc=IDEAS.Types.Tilt.Ceiling, azi=aziAInt,
    glazing(
      checkLowPerformanceGlazing=glazingCei.checkLowPerformanceGlazing,
      nLay=glazingCei.nLay,
      mats=glazingCei.mats,
      SwAbs=glazingCei.SwAbs,
      SwTrans=glazingCei.SwTrans,
      SwAbsDif=glazingCei.SwAbsDif,
      SwTransDif=glazingCei.SwTransDif,
      U_value=glazingCei.U_value,
      g_value=glazingCei.g_value),
    A=A_winCei,
    frac=fracCei,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_win,
    linExtCon=linExtCon,
    windowDynamicsType=windowDynamicsType,
    redeclare IDEAS.Buildings.Components.Shading.Shading shaType(shaPro(
      controlled=shaTypCei.controlled,
  shaType=shaTypCei.shaType,
  hWin=shaTypCei.hWin,
  wWin=shaTypCei.wWin,
  wLeft=shaTypCei.wLeft,
  wRight=shaTypCei.wRight,
  ovDep=shaTypCei.ovDep,
  ovGap=shaTypCei.ovGap,
  hFin=shaTypCei.hFin,
  finDep=shaTypCei.finDep,
  finGap=shaTypCei.finGap,
  L=shaTypCei.L,
  dh=shaTypCei.dh,
  shaCorr=shaTypCei.shaCorr)),
    fraType(present=fraTypCei.present, U_value=fraTypCei.U_value),
    linExtRad=linExtRadWin,
    nWin=nWinCei,
    indexWindow=indexWinCei) if
       hasWinCei constrainedby IDEAS.LIDEAS.Components.LinWindow(
       azi=aziCei,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinCei,
       indexWindow=indexWinCei)
    "Window for ceiling of this zone" annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinCei,
      choicesAllMatching=true,
      Placement(
        transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-95,-90})));
equation
  assert(Medium.nX ==1,
    "LinZone model does not allow moist air or air with CO2 medium. 
    Use the IDEAS.Media.Specialized.DryAir medium.");

  connect(winA.propsBus_a, propsBusInt[indWinA]) annotation (Line(
      points={{-90.8333,12},{-88,12},{-88,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(winB.propsBus_a, propsBusInt[indWinB]) annotation (Line(
      points={{-90.8333,-8},{-88,-8},{-88,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(winC.propsBus_a, propsBusInt[indWinC]) annotation (Line(
      points={{-90.8333,-28},{-88,-28},{-88,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(winD.propsBus_a, propsBusInt[indWinD]) annotation (Line(
      points={{-90.8333,-48},{-88,-48},{-88,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(winCei.propsBus_a, propsBusInt[indWinCei]) annotation (Line(
      points={{-90.8333,-88},{-88,-88},{-88,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));

  connect(ctrlCei, winCei.Ctrl) annotation (Line(points={{-107,-111},{-106.5,
          -111},{-106.5,-100},{-98.3333,-100}},
                                          color={0,0,127}));
  connect(ctrlD, winD.Ctrl) annotation (Line(points={{-123,-111},{-123,-106},{
          -124,-106},{-124,-100},{-98.3333,-100},{-98.3333,-60}},
                                                             color={0,0,127}));
  connect(ctrlC, winC.Ctrl) annotation (Line(points={{-139,-111},{-139,-104},{
          -140,-104},{-140,-100},{-98,-100},{-98,-40},{-98.3333,-40}},
                                                                  color={0,0,127}));
  connect(ctrlB, winB.Ctrl) annotation (Line(points={{-155,-111},{-155,-100},{
          -156,-100},{-98,-100},{-98,-20},{-98.3333,-20}},        color={0,0,127}));
  connect(ctrlA, winA.Ctrl) annotation (Line(points={{-171,-111},{-171,-106},{
          -172,-106},{-172,-100},{-98.3333,-100},{-98.3333,0}},
                                                           color={0,0,127}));

   annotation (Documentation(info="<html>
<p>
Extension of 
<a href=\"IDEAS.Buildings.Components.RectangularZoneTemplate\">
IDEAS.Buildings.Components.RectangularZoneTemplate</a> that supports zone linearisation.
The model is therefore configured to used the well-mixed air model with the temperature as preferred state of the
mixing volume and using 
<a href=\"IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure\">
IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure</a> for the air infiltration.
</p>
<p>
An assert statement is added to ensure that the user only uses the medium <code>IDEAS.Media.Specialized.DryAir</code> since
the linearization does not support other type of media.
</p>
</html>", revisions="<html>
<ul>
<li>
October 13, 2019, by Filip Jorissen:<br/>
Refactored the parameter definition of <code>inc</code> 
and <code>azi</code> by adding the option to use radio buttons.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1067\">
#1067</a>
</li>
<li>
August 30, 2018, by Damien Picard:<br/>
Computing window indices automatically
See <a href=\"https://github.com/open-ideas/IDEAS/issues/907\">#907</a>.
</li>
<li>
August 26, 2018, by Damien Picard:<br/>
Extends from new interface model 
<code>RectangularZoneTemplateInterface</code>
such that LinWin is used without requiring
a redeclaration.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/891\">#891</a>.
</li>
<li>
August 21, 2018 by Damien Picard: <br/>
Remove custom air model and use 
<code>IDEAS.Buildings.Components.ZoneAirModels.WellMixedAir</code> 
with correct parametrization instead.
</li>
</ul>
</html>"));
end LinRectangularZoneTemplate;
