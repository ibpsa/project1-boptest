within IDEAS.Buildings.Components;
model RectangularZoneTemplate
  "Rectangular zone including walls, floor and ceiling"
  extends IDEAS.Buildings.Components.Interfaces.RectangularZoneTemplateInterface;

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
  IDEAS.Buildings.Components.Window winA(azi=aziAInt, inc=IDEAS.Types.Tilt.Wall,
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
    redeclare package Medium = Medium,
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
    nWin=nWinA) if
       hasWinA constrainedby Window(
       azi=aziAInt,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinA)
    "Window for face A of this zone"
    annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinA,
      choicesAllMatching=true,
      Placement(transformation(extent={{-100,0},{-90,20}})));
  replaceable
  IDEAS.Buildings.Components.Window winB(
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
    redeclare package Medium = Medium,
    frac=fracB,
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
    nWin=nWinB) if
       hasWinB constrainedby Window(
       azi=aziB,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinB)
    "Window for face B of this zone" annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinB,
      choicesAllMatching=true,
      Placement(
        transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-95,-10})));
  replaceable
  IDEAS.Buildings.Components.Window winC(inc=IDEAS.Types.Tilt.Wall,
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
    redeclare package Medium = Medium,
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
    nWin=nWinC) if
       hasWinC constrainedby Window(
       azi=aziC,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinC)
    "Window for face C of this zone" annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinC,
      choicesAllMatching=true,
      Placement(
        transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-95,-30})));
  replaceable
  IDEAS.Buildings.Components.Window winD(inc=IDEAS.Types.Tilt.Wall, azi=aziD,
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
    redeclare package Medium = Medium,
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
    nWin=nWinD) if
       hasWinD constrainedby Window(
       azi=aziD,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinD)
    "Window for face D of this zone" annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinD,
      choicesAllMatching=true,
      Placement(
        transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-95,-50})));
  replaceable
  IDEAS.Buildings.Components.Window winCei(inc=IDEAS.Types.Tilt.Ceiling, azi=aziAInt,
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
    redeclare package Medium = Medium,
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
    nWin=nWinCei) if
       hasWinCei constrainedby Window(
       azi=aziAInt,
       inc=IDEAS.Types.Tilt.Wall,
       T_start=T_start,
       linIntCon_a=linIntCon,
       dT_nominal_a=dT_nominal_win,
       linExtCon=linExtCon,
       windowDynamicsType=windowDynamicsType,
       linExtRad=linExtRadWin,
       nWin=nWinCei)
    "Window for ceiling of this zone" annotation (Dialog(tab="Advanced",group="Windows"),
      enable=hasWinCei,
      choicesAllMatching=true,
      Placement(
        transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-95,-90})));
equation
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



    annotation (Icon(coordinateSystem(preserveAspectRatio=false, initialScale=0.1),
        graphics={
        Text(
          extent={{-60,-72},{-30,-38}},
          lineColor={28,108,200},
          textString="Flo"),
        Text(
          extent={{120,-14},{140,20}},
          lineColor={28,108,200},
          textString="B"),
        Text(
          extent={{-10,-122},{10,-94}},
          lineColor={28,108,200},
          textString="C"),
        Text(
          extent={{-122,-14},{-102,20}},
          lineColor={28,108,200},
          textString="D"),
        Text(
          extent={{18,44},{46,80}},
          lineColor={28,108,200},
          textString="Cei"),
        Text(
          extent={{-10,114},{10,148}},
          lineColor={28,108,200},
          textString="A")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{100,100}}),
                    graphics={
        Text(
          extent={{-220,-60},{-200,-80}},
          lineColor={28,108,200},
          textString="Floor"),
        Text(
          extent={{-220,-80},{-200,-100}},
          lineColor={28,108,200},
          textString="Ceiling"),
        Text(
          extent={{-220,-40},{-200,-60}},
          lineColor={28,108,200},
          textString="D"),
        Text(
          extent={{-220,-20},{-200,-40}},
          lineColor={28,108,200},
          textString="C"),
        Text(
          extent={{-220,0},{-200,-20}},
          lineColor={28,108,200},
          textString="B"),
        Text(
          extent={{-220,20},{-200,0}},
          lineColor={28,108,200},
          textString="A")}),
    Documentation(info="<html>
<p>
This model can be used to set up
zones with a rectangular geometry more quickly.
This template consists of a zone, four walls, a horizontal roof and a floor
and five optional windows.
Additional surfaces may also be connected through external bus connector.
For the documentation of the regular zone parameters, see the documentation of 
<a href=\"modelica://IDEAS.Buildings.Components.Zone\">IDEAS.Buildings.Components.Zone</a>.
</p>
<h4>Main equations</h4>
<p>
This model incorporates IDEAS components such as
<a href=modelica://IDEAS.Buildings.Components.OuterWall>
IDEAS.Buildings.Components.OuterWall</a> and reproduces
the same results as a model that would be constructed without 
the use of this template.
</p>
<h4>Assumption and limitations</h4>
<p>
This model assumes that the zone has a rectangular
geometry with width <code>w</code>, length <code>l</code>
and height <code>h</code>.
All walls are vertical and perpendicular to each other and both the roof and
the floor are horizontal.
</p>
<p>
The surface area of each wall is calculated by default using
the parameters <code>w</code> and <code>l</code>. If you want to split a wall
and add external walls using the external bus connector, use the overwrite
length parameters <code>lA, lB, lC, lD</code> from the <code>Face</code> tabs
such that the surface area of the wall is correct. 
Be also aware that the model
<code>slabOnGround</code> has a parameter <code>PWall</code> which specifies the
perimeter of slab on ground. The model cannot detect external walls connected
using the external bus connector. When splitting outer walls by using the external bus connector
you should update this parameter
manually using the parameter <code>PWall</code> from the <code>Advanced</code> tab.
</p>
<h4>Typical use and important parameters</h4>
<p>
Parameters width <code>w</code>, length <code>l</code>
and height <code>h</code> need to be defined
and are used to compute the dimensions of each of the surfaces.
Parameter <code>aziA</code> represents the azimuth angle
of surface A (see icon). Other surfaces are rotated (clockwise) by multiples
of ninety degrees with respect to <code>aziA</code>.
Parameter <code>nSurfExt</code> may be used
to connect additional surfaces to the template. 
When doing this, you may need to change the surface areas of
the surfaces in the template as these are not updated automatically.
</p>
<p>
Seven parameter tabs allow to specify further parameters
that are specific for each of the seven surfaces: six surfaces 
for the walls, floor and ceiling and one for an internal wall 
contained within the zone.
For each surface the surface type may be specified
using parameters <code>bouTyp*</code>.
The construction type should be defined
using <code>conTyp*</code>.
Parameter <code>hasWin*</code> may be used
for all orientations except for the floor to add
a window.
In this case the window surface area, shading and glazing 
types need to be provided.
For non-default shading a record needs to be created that specifies
the shading properties.
The surface area of the window is deducted from the surface area
of the wall such that the total surface areas add up.
</p>
<h4>Options</h4>
<p>
Advanced options are found under the <code>Advanced</code> 
parameter tab. 
The model may also be adapted further by
overriding the default parameter assignments in the template.
</p>
<p>
You can also use this model for non-rectangular zones by, for example,
using the <code>None</code> type for a wall and by adding additional walls
corresponding to a different geometry through
the external bus connector. 
This model however then does not guarantee that all parameters are consistent.
Therefore, some internal parameters of this model will need to be
updated manually.
</p>
<p>
In the parameter group <code>Windows</code>, you can redeclare the window. 
This is useful when using a window model that has a pre-configured surface area,
glazing type, frame fraction and shading. 
The parameters 
<code>azi=aziA</code>,
<code>inc=IDEAS.Types.Tilt.Wall</code>,
<code>T_start=T_start</code>,
<code>linIntCon_a=linIntCon</code>,
<code>dT_nominal_a=dT_nominal_win</code>,
<code>linExtCon=linExtCon</code>,
<code>windowDynamicsType=windowDynamicsType</code>,
<code>linExtRad=linExtRadWin</code>,
<code>nWin=nWinA</code>,
are still computed from the zone model parameters but, the
other windows parameters are those configured in the
used window model, including the window surface area.
</p>
<h4>Dynamics</h4>
<p>
This model contains wall dynamics
and a state for the zone air temperature.
The zone temperature may be set to steady state using
parameter <code>energyDynamicsAir</code>, which should
in general not be done.
The mass dynamics of the air volume
may be set to steady state by overriding the default parameter
assignment in the <code>airModel</code> submodel.
This removes small time constants
when the zone model is connected to an air flow circuit. 
</p>
<h4>Shading</h4>
<p>
In order to choose the shading of the glazing,
instead of selecting one shading type from the
dropdown menu, click on the
button right of the dropdown menu (edit). 
A menu will appear where the type of 
shading and corresponding parameters
have to be defined.
Alternatively, the shading template can be extended.
</p>
<h4>Validation</h4>
<p>
This implementation is compared with a manual implementation
in <a href=modelica://IDEAS.Buildings.Validation.Tests.ZoneTemplateVerification2>
IDEAS.Buildings.Validation.Tests.ZoneTemplateVerification2</a>.
This gives identical results.
</p>
<h4>Example</h4>
<p>
An example of how this template may be used
can be found in 
<a href=modelica://IDEAS.Examples.PPD12>IDEAS.Examples.PPD12</a>.
</p>
<h4>Implementation</h4>
<p>
Shading types need to be declared using a record instead of
by redeclaring the shading components.
This is a workaround because redeclared 
components cannot be propagated.
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
February 5, 2019, by Damien Picard:<br/>
Correct typo in winB declaration (fraB should be fracB). 
</li>
<li>
October 26, 2018, by Filip Jorissen:<br/>
Removed use of non-existent parameter <code>aziCei</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/946\">#946</a>. 
</li>
<li>
August 26, 2018, by Damien Picard:<br/>
Move all equations except those of windows to 
<code>RectangularZoneTemplateInterface</code>
for LIDEAS.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/891\">#891</a>.
</li>
<li>
August 16, 2018, by Damien Picard:<br/>
Make windows replaceable.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/891\">#891</a>.
And correct wall surface computation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/890\">#890</a>. 
</li>
<li>
August 10, 2018, by Damien Picard:<br/>
Added parameters for scaling factors for windows.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/888\">#888</a>.
</li>
<li>
Adapted model to make it possible to remove walls from the template.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/880\">#880</a>.
</li>
<li>
June 13, 2018, by Filip Jorissen:<br/>
Added parameters for shade cast by external building.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/576\">#576</a>.
</li>
<li>
May 21, 2018, by Filip Jorissen:<br/>
Added parameters for air flow through cavity.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/822\">#822</a>.
</li>
<li>
April 30, 2018 by Iago Cupeiro:<br/>
Propagated boolean input connections for controlled shading.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/809\">#809</a>.
Shading documentation added.
</li>
<li>
July 26, 2017 by Filip Jorissen:<br/>
Added replaceable block that allows to define
the number of occupants.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
<li>
April 26, 2017, by Filip Jorissen:<br/>
Added asserts that check for illegal combinations of internal wall with exterior window.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/714>#714</a>.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed bus parameters for JModelica compatibility.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
Also removed obsolete each.
</li>
<li>
January 20, 2017 by Filip Jorissen:<br/>
Removed propagation of <code>nLay</code> and <code>nGain</code>
since this lead to warnings.
</li>
<li>
January 11, 2017 by Filip Jorissen:<br/>
Added documentation
</li>
<li>
January 10, 2017, by Filip Jorissen:<br/>
Added <code>linExtRadWin</code> for windows.
</li>
<li>
November 14, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end RectangularZoneTemplate;
