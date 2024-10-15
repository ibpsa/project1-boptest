within IDEAS.BoundaryConditions.SolarIrradiation;
model RadSolData "Selects or generates correct solar data for this surface"
  parameter Modelica.SIunits.Angle inc "inclination";
  parameter Modelica.SIunits.Angle azi "azimuth";
  parameter Boolean useLinearisation = false
    "Set to true if used for linearisation";
  outer SimInfoManager                          sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
protected
  input IDEAS.Buildings.Components.Interfaces.WeaBus
    weaBus(numSolBus=sim.numIncAndAziInBus, outputAngles=sim.outputAngles)
    annotation (HideResults=true,Placement(transformation(extent={{90,70},{110,90}})));

public
  Modelica.Blocks.Interfaces.RealOutput HDirTil
    "Direct solar irradiation on a tilted surface"
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  Modelica.Blocks.Interfaces.RealOutput HGroDifTil
    "Diffuse sky solar irradiance on a tilted surface"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Modelica.Blocks.Interfaces.RealOutput HSkyDifTil
    "Diffuse sky solar irradiance on a tilted surface"
    annotation (Placement(transformation(extent={{96,10},{116,30}})));
  Modelica.Blocks.Interfaces.RealOutput angInc
    annotation (Placement(transformation(extent={{96,-50},{116,-30}})));
  Modelica.Blocks.Interfaces.RealOutput angZen
    annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
  Modelica.Blocks.Interfaces.RealOutput angAzi
    annotation (Placement(transformation(extent={{96,-90},{116,-70}})));
  Modelica.Blocks.Interfaces.RealOutput angHou "Hour angle"
    annotation (Placement(transformation(extent={{96,-110},{116,-90}})));
  Modelica.Blocks.Interfaces.RealOutput Tenv "Environment temperature"
    annotation (Placement(transformation(extent={{96,-30},{116,-10}})));
  Modelica.Blocks.Interfaces.RealOutput hForcedConExt
    "Forced flow convection coefficient at an external surface"
    annotation (Placement(transformation(extent={{96,-132},{116,-112}})));

  Modelica.Blocks.Interfaces.RealOutput Te "Dry bulb temperature"
    annotation (Placement(transformation(extent={{96,-150},{116,-130}})));
  Modelica.Blocks.Interfaces.RealOutput Tdes "Design tempearture"
    annotation (Placement(transformation(extent={{96,-170},{116,-150}})));
protected
  final parameter Integer numMatches=
    sum( {if     IDEAS.Utilities.Math.Functions.isAngle(sim.incAndAziInBus[i,1],inc)
             and (IDEAS.Utilities.Math.Functions.isAngle(sim.incAndAziInBus[i,2],azi)
                  or IDEAS.Utilities.Math.Functions.isAngle(IDEAS.Types.Tilt.Ceiling,inc)
                  or IDEAS.Utilities.Math.Functions.isAngle(IDEAS.Types.Tilt.Floor,inc))
          then 1
          else 0 for i in 1:sim.numIncAndAziInBus})
    annotation(Evaluate=true);
  final parameter Boolean solDataInBus = numMatches==1
    "True if the {inc,azi} combination is found in incAndAziInBus" annotation(Evaluate=true);
  final parameter Integer solDataIndex=
    sum( {if     IDEAS.Utilities.Math.Functions.isAngle(sim.incAndAziInBus[i,1],inc)
             and (IDEAS.Utilities.Math.Functions.isAngle(sim.incAndAziInBus[i,2],azi)
                  or IDEAS.Utilities.Math.Functions.isAngle(IDEAS.Types.Tilt.Ceiling,inc)
                  or IDEAS.Utilities.Math.Functions.isAngle(IDEAS.Types.Tilt.Floor,inc))
          then i
          else 0 for i in 1:sim.numIncAndAziInBus})
    "Index of the {inc,azi} combination in incAndAziInBus"
    annotation(Evaluate=true);
  IDEAS.BoundaryConditions.SolarIrradiation.ShadedRadSol radSol(
    final inc=inc,
    final azi=azi,
    final lat=sim.lat,
    final outputAngles=sim.outputAngles) if
                      not solDataInBus
    "determination of incident solar radiation on wall based on inclination and azimuth"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

  output Buildings.Components.Interfaces.SolBus
     solBusDummy(outputAngles=sim.outputAngles)
    "Required for avoiding warnings?"
                                     annotation (HideResults=true, Placement(
        transformation(extent={{-60,10},{-20,50}})));

  Modelica.Blocks.Sources.Constant constAngLin(k=1) if
                                                 solDataInBus and not sim.outputAngles
    "Dummy inputs when linearising. This avoids unnecessary state space inputs."
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
equation
    assert(numMatches<=1, "In "+getInstanceName()+
      ": The parameter sim.incAndAziInBus contains duplicates. 
      This is not allowed. Remove the duplicate entry.");
    assert( not useLinearisation or (useLinearisation and solDataInBus), "The solar data must come
      from the weabus when the model is linearised. Add the combination {inc,azi} = {"+String(inc)+","+String(azi)+"}
      to the parameter incAndAziInBus of the SimInfoManager.");
  connect(radSol.solBus, solBusDummy) annotation (Line(
      points={{-60,30},{-40,30}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  if solDataInBus then
    connect(weaBus.solBus[solDataIndex], solBusDummy) annotation (Line(
      points={{100.05,80.05},{-40,80.05},{-40,30}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  end if;
  connect(HDirTil, solBusDummy.HDirTil) annotation (Line(
      points={{106,40},{-39.9,40},{-39.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tenv, solBusDummy.Tenv) annotation (Line(
      points={{106,-20},{-39.9,-20},{-39.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  if not (solDataInBus and not sim.outputAngles) then
  connect(angInc, solBusDummy.angInc) annotation (Line(
      points={{106,-40},{-40,-40},{-40,-42},{-39.9,-42},{-39.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(angZen, solBusDummy.angZen) annotation (Line(
      points={{106,-60},{-39.9,-60},{-39.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(angAzi, solBusDummy.angAzi) annotation (Line(
      points={{106,-80},{-39.9,-80},{-39.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;
  connect(radSol.TePow4, weaBus.TePow4) annotation (Line(points={{-64,41.8},{
          -64,54},{100.05,54},{100.05,80.05}},
                                  color={0,0,127}));
  connect(radSol.TskyPow4, weaBus.TskyPow4) annotation (Line(points={{-68,42},{
          -68,56},{100.05,56},{100.05,80.05}},
                                       color={0,0,127}));
  connect(radSol.solDirPer, weaBus.solDirPer) annotation (Line(points={{-80.4,40},
          {-80.4,58},{100.05,58},{100.05,80.05}},
                                         color={0,0,127}));
  connect(radSol.solGloHor, weaBus.solGloHor) annotation (Line(points={{-80.4,38},
          {-82,38},{-82,60},{100.05,60},{100.05,80.05}}, color={0,0,127}));
  connect(radSol.solDifHor, weaBus.solDifHor) annotation (Line(points={{-80.4,36},
          {-84,36},{-84,62},{100.05,62},{100.05,80.05}},
                                                color={0,0,127}));
  connect(radSol.angDec, weaBus.angDec) annotation (Line(points={{-80.4,30},{-88,
          30},{-88,66},{100.05,66},{100.05,80.05}},
                                           color={0,0,127}));
  connect(radSol.angHou, weaBus.angHou) annotation (Line(points={{-80.4,28},{-90,
          28},{-90,68},{100.05,68},{100.05,80.05}},
                                           color={0,0,127}));
  connect(radSol.angZen, weaBus.angZen) annotation (Line(points={{-80.4,26},{-92,
          26},{-92,70},{100.05,70},{100.05,80.05}},
                                           color={0,0,127}));
  connect(radSol.F1, weaBus.F1) annotation (Line(points={{-80.4,22},{-94,22},{-94,
          72},{100.05,72},{100.05,80.05}},
                                  color={0,0,127}));
  connect(radSol.F2, weaBus.F2) annotation (Line(points={{-80.4,20},{-96,20},{-96,
          74},{100.05,74},{100.05,80.05}},
                                  color={0,0,127}));
    connect(constAngLin.y, angInc) annotation (Line(points={{-79,-60},{-78,-60},{-78,
          -40},{106,-40}}, color={0,0,127}));
  connect(constAngLin.y, angZen)
    annotation (Line(points={{-79,-60},{-78,-60},{106,-60}}, color={0,0,127}));
  connect(constAngLin.y, angAzi)
                                annotation (Line(points={{-79,-60},{-78,-60},{-78,
          -80},{106,-80}}, color={0,0,127}));
  connect(HSkyDifTil, solBusDummy.HSkyDifTil) annotation (Line(points={{106,20},
          {-39.9,20},{-39.9,30.1}}, color={0,0,127}));
  connect(HGroDifTil, solBusDummy.HGroDifTil) annotation (Line(points={{106,0},
          {-39.9,0},{-39.9,30.1}}, color={0,0,127}));
  connect(angHou, weaBus.angHou) annotation (Line(points={{106,-100},{80,-100},
          {80,80.05},{100.05,80.05}}, color={0,0,127}));
  connect(radSol.solTim, weaBus.solTim) annotation (Line(points={{-80.4,33},{-86,
          33},{-86,64},{100.05,64},{100.05,80.05}},
                                                color={0,0,127}));
  connect(hForcedConExt, solBusDummy.hForcedConExt) annotation (Line(points={{106,
          -122},{-39.9,-122},{-39.9,30.1}},
                                     color={0,0,127}));
  connect(radSol.winDir, weaBus.Vdir) annotation (Line(points={{-72,42},{-72,
          80.05},{100.05,80.05}},                          color={0,0,127}));
  connect(radSol.winSpe, weaBus.Va) annotation (Line(points={{-76,42},{-76,76},
          {100,76},{100,80.05},{100.05,80.05}},                          color=
          {0,0,127}));
  connect(weaBus, sim.weaBus) annotation (Line(
      points={{100,80},{100,93},{-81,93}},
      color={255,204,51},
      thickness=0.5));
  connect(Te, weaBus.Te) annotation (Line(points={{106,-140},{80,-140},{80,
          80.05},{100.05,80.05}}, color={0,0,127}));
  connect(Tdes, weaBus.Tdes) annotation (Line(points={{106,-160},{82,-160},{82,
          80.05},{100.05,80.05}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -140},{120,100}})),           Documentation(info="<html>
<p>
This model usually takes the appropriate solar data from the bus. 
If the correct data is not contained by the bus, custom solar data is calculated.
</p>
</html>", revisions="<html>
<ul>
<li>
August 12, 2020, by Filip Jorissen:<br/>
Using precomputed data for ceilings/floors even if azimuth angle mismatches.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1160\">
#1160</a>
</li>
<li>
April 26, 2020, by Filip Jorissen:<br/>
Refactored <code>SolBus</code> to avoid many instances in <code>PropsBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1131\">
#1131</a>
</li>
<li>
November 28, 2019 by Ian Beausoleil-Morrison:<br/>
Add RealOutput for coefficient for forced convection and get this from SolBus.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
August 9, 2018 by Filip Jorissen:<br/>
Revised implementation for checking solData index and added 
assert to avoid duplicate entries in <code>incAndAziInBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/881\">
#881</a>.
</li>
<li>
March 26, 2018 by Iago Cupeiro &amp; Damien Picard:<br/>
Solved bug in linearisation
</li>
<li>
January 21, 2018 by Filip Jorissen:<br/>
Added <code>solTim</code> connection for revised azimuth computations.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/753\">
#753</a>.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
March 25, 2016 by Filip Jorissen:<br/>
Reworked radSol implementation to use RealInputs instead of weaBus.
This simplifies translation and interpretation.
</li>
<li>
February 10, 2015 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end RadSolData;
