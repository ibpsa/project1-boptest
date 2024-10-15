within IDEAS.Buildings.Components;
model Window "Multipane window"
  replaceable IDEAS.Buildings.Data.Interfaces.Glazing glazing
    constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type"
    annotation (choicesAllMatching=true,
        Dialog(group=
          "Construction details"));

  extends IDEAS.Buildings.Components.Interfaces.PartialSurface(
    dT_nominal_a=-3,
    intCon_a(final A=
           A*(1 - frac),
           linearise=linIntCon_a or sim.linearise,
           dT_nominal=dT_nominal_a),
    QTra_design(fixed=false),
    Qgai(y=if sim.computeConservationOfEnergy then
                                                  (gain.propsBus_a.surfCon.Q_flow +
        gain.propsBus_a.surfRad.Q_flow + gain.propsBus_a.iSolDif.Q_flow + gain.propsBus_a.iSolDir.Q_flow) else 0),
    E(y=0),
    layMul(
      A=A_glass,
      nLay=glazing.nLay,
      mats=glazing.mats,
      energyDynamics=if windowDynamicsType == IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Normal then energyDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,
      dT_nom_air=5,
      linIntCon=true,
      checkCoatings=glazing.checkLowPerformanceGlazing),
    setArea(A=A_glass*nWin),
    q50_zone(v50_surf=q50_internal*A_glass),
    res1(A=if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts then A_glass/2 else A_glass),
    res2(A=A_glass/2));
  parameter Boolean linExtCon=sim.linExtCon
    "= true, if exterior convective heat transfer should be linearised (uses average wind speed)"
    annotation(Dialog(tab="Convection"));
  parameter Boolean linExtRad=sim.linExtRadWin
    "= true, if exterior radiative heat transfer should be linearised"
    annotation(Dialog(tab="Radiation"));

  parameter Real frac(
    min=0,
    max=1) = 0.15 "Area fraction of the window frame";
  parameter IDEAS.Buildings.Components.Interfaces.WindowDynamicsType
    windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two
    "Type of dynamics for glazing and frame: using zero, one combined or two states"
    annotation (Dialog(tab="Dynamics", group="Equations", enable = not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState));
  parameter Real fraC = frac
    "Ratio of frame and glazing thermal masses"
    annotation(Dialog(tab="Dynamics", group="Equations", enable= not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState and windowDynamicsType == IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two));
  parameter Boolean controlled = shaType.controlled
    " = true if shaType has a control input (see e.g. screen). Can be set to false manually to force removal of input icon."
    annotation(Dialog(tab="Advanced",group="Icon"));

  replaceable parameter IDEAS.Buildings.Data.Frames.None fraType
    constrainedby IDEAS.Buildings.Data.Interfaces.Frame "Window frame type"
    annotation (choicesAllMatching=true, Dialog(group=
          "Construction details"));
  replaceable IDEAS.Buildings.Components.Shading.None shaType constrainedby
    Shading.Interfaces.PartialShading(
                            final azi=aziInt) "First shading type"  annotation (Placement(transformation(extent={{-70,-60},
            {-60,-40}})),
      __Dymola_choicesAllMatching=true, Dialog(group="Construction details"));

  Modelica.Blocks.Interfaces.RealInput Ctrl if controlled
    "Control signal between 0 and 1, i.e. 1 is fully closed" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-50,-110}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-40,-100})));



  parameter Real coeffsCp[:,:]=[0,0.4; 45,0.1; 90,-0.3; 135,-0.35; 180,-0.2; 225,
      -0.35; 270,-0.3; 315,0.1; 360,0.4]
      "Cp at different angles of attack"
      annotation(Dialog(tab="Airflow",group="Wind"));
  parameter Real Cs=sim.Cs
                       "Wind speed modifier"
    annotation (Dialog(tab="Airflow", group="Wind"));

  parameter Real Habs=1
    "Absolute height of boundary for correcting the wind speed"
    annotation (Dialog(tab="Airflow", group="Wind"));

protected
  final parameter Real U_value=glazing.U_value*(1-frac)+fraType.U_value*frac
    "Average window U-value";
  final parameter Boolean addCapGla =  windowDynamicsType == IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two and not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState
    "Add lumped thermal capacitor for window glazing";
  final parameter Boolean addCapFra =  fraType.present and not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState
    "Added lumped thermal capacitor for window frame";
  final parameter Modelica.SIunits.HeatCapacity Cgla = layMul.C
    "Heat capacity of glazing state";
  final parameter Modelica.SIunits.HeatCapacity Cfra = layMul.C*fraC
    "Heat capacity of frame state";
  final parameter Modelica.SIunits.Area A_glass = A*(1 - frac);

  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExteriorConvection
    eCon(
    final A=A*(1 - frac),
    linearise=linExtCon or sim.linearise,
    final inc=incInt,
    final azi=aziInt)
    "Convective surface heat transimission on the exterior side of the wall"
    annotation (Placement(transformation(extent={{-20,-38},{-40,-18}})));

  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorHeatRadiation
    skyRad(final A=A*(1 - frac), Tenv_nom=sim.Tenv_nom,
    linearise=linExtRad or sim.linearise)
    "determination of radiant heat exchange with the environment and sky"
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  replaceable
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.SwWindowResponse
    solWin(
    final nLay=glazing.nLay,
    final SwAbs=glazing.SwAbs,
    final SwTrans=glazing.SwTrans,
    final SwTransDif=glazing.SwTransDif,
    final SwAbsDif=glazing.SwAbsDif)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));

  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.InteriorConvection
    iConFra(final A=A*frac, final inc=incInt,
    linearise=linIntCon_a or sim.linearise) if
                        fraType.present
    "convective surface heat transimission on the interior side of the wall"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorHeatRadiation
    skyRadFra(final A=A*frac, Tenv_nom=sim.Tenv_nom,
    linearise=linExtRad or sim.linearise) if
                         fraType.present
    "determination of radiant heat exchange with the environment and sky"
    annotation (Placement(transformation(extent={{-20,80},{-40,100}})));
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExteriorConvection
    eConFra(final A=A*frac, linearise=linExtCon or sim.linearise,
    inc=incInt,
    azi=aziInt) if
                 fraType.present
    "convective surface heat transimission on the exterior side of the wall"
    annotation (Placement(transformation(extent={{-20,60},{-40,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor layFra(final G=(if
        fraType.briTyp.present then fraType.briTyp.G else 0) + (fraType.U_value)
        *A*frac) if                fraType.present  annotation (Placement(transformation(extent={{10,60},
            {-10,80}})));

  BoundaryConditions.SolarIrradiation.RadSolData radSolData(
    inc=incInt,
    azi=aziInt)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Math.Gain gainDir(k=A*(1 - frac))
    "Gain for direct solar irradiation"
    annotation (Placement(transformation(extent={{-42,-46},{-38,-42}})));
  Modelica.Blocks.Math.Gain gainDif(k=A*(1 - frac))
    "Gain for diffuse solar irradiation"
    annotation (Placement(transformation(extent={{-36,-50},{-32,-46}})));
  Modelica.Blocks.Routing.RealPassThrough Tdes
    "Design temperature passthrough since propsBus variables cannot be addressed directly";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCapGlaInt(C=Cgla/2,
      T(fixed=energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial,
        start=T_start)) if                                                                             addCapGla
    "Heat capacitor for glazing at interior"
    annotation (Placement(transformation(extent={{6,-12},{26,-32}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCapFraIn(C=Cfra/2,
      T(fixed=energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial,
        start=T_start)) if                                                                             addCapFra
    "Heat capacitor for frame at interior"
    annotation (Placement(transformation(extent={{4,100},{24,120}})));
  Modelica.Blocks.Sources.Constant constEpsLwFra(final k=fraType.mat.epsLw)
    "Shortwave emissivity of frame"
    annotation (Placement(transformation(extent={{4,86},{-6,96}})));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorSolarAbsorption
    solAbs(A=A*frac, epsSw=fraType.mat.epsSw) if
                        fraType.present
    "Solar absorption model for shortwave radiation"
    annotation (Placement(transformation(extent={{-20,40},{-40,60}})));
  Modelica.Blocks.Math.Add solDif(final k1=1, final k2=1)
    "Sum of ground and sky diffuse solar irradiation"
    annotation (Placement(transformation(extent={{-56,-50},{-50,-44}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCapFraExt(C=Cfra/2,
      T(fixed=energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial,
        start=T_start)) if                                                                             addCapFra
    "Heat capacitor for frame at exterior"
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCapGlaExt(C=Cgla/2,
      T(fixed=energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial,
        start=T_start)) if                                                                             addCapGla
    "Heat capacitor for glazing at exterior"
    annotation (Placement(transformation(extent={{-20,-12},{0,-32}})));
  Fluid.Sources.OutsideAir       outsideAir(
    redeclare package Medium = Medium,
    final table=coeffsCp,
    final azi=aziInt,
    Cs=Cs,
    Habs=Habs,
    nPorts=if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort
         then 1 else 2) if
    sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None
    "Outside air model"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
initial equation
  QTra_design = (U_value*A + (if fraType.briTyp.present then fraType.briTyp.G else 0)) *(273.15 + 21 - Tdes.y);





equation
  connect(eCon.port_a, layMul.port_b) annotation (Line(
      points={{-20,-28},{-14,-28},{-14,0},{-10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(skyRad.port_a, layMul.port_b) annotation (Line(
      points={{-20,0},{-10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solWin.iSolDir, propsBusInt.iSolDir) annotation (Line(
      points={{-2,-60},{-2,-70},{56.09,-70},{56.09,19.91}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solWin.iSolDif, propsBusInt.iSolDif) annotation (Line(
      points={{2,-60},{2,-70},{56.09,-70},{56.09,19.91}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solWin.iSolAbs, layMul.port_gain) annotation (Line(
      points={{0,-40},{0,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.iEpsLw_b, skyRad.epsLw) annotation (Line(
      points={{-10,8},{-14,8},{-14,3.4},{-20,3.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shaType.Ctrl, Ctrl) annotation (Line(
      points={{-65,-60},{-50,-60},{-50,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iConFra.port_b, propsBusInt.surfCon) annotation (Line(
      points={{40,70},{46,70},{46,19.91},{56.09,19.91}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layFra.port_a, iConFra.port_a) annotation (Line(
      points={{10,70},{20,70}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(skyRadFra.port_a, layFra.port_b) annotation (Line(
      points={{-20,90},{-16,90},{-16,70},{-10,70}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(eConFra.port_a, layFra.port_b) annotation (Line(
      points={{-20,70},{-10,70}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radSolData.angInc, shaType.angInc) annotation (Line(
      points={{-79.4,-54},{-76,-54},{-76,-54},{-70,-54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSolData.angAzi, shaType.angAzi) annotation (Line(
      points={{-79.4,-58},{-76,-58},{-76,-58},{-70,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSolData.angZen, shaType.angZen) annotation (Line(
      points={{-79.4,-56},{-76,-56},{-76,-56},{-70,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSolData.Tenv, skyRad.Tenv) annotation (Line(
      points={{-79.4,-52},{-72,-52},{-72,10},{-20,10},{-20,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyRadFra.Tenv, skyRad.Tenv) annotation (Line(
      points={{-20,96},{-12,96},{-12,6},{-20,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(eConFra.Te, eCon.Te) annotation (Line(
      points={{-20,65.2},{-20,66},{-16,66},{-16,-32.8},{-20,-32.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(eCon.hForcedConExt, eConFra.hForcedConExt) annotation (Line(
      points={{-20,-37},{-20,-36},{-14,-36},{-14,61},{-20,61}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(eCon.Te, radSolData.Te) annotation (Line(
      points={{-20,-32.8},{-79.4,-32.8},{-79.4,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tdes.u,radSolData.Tdes);
  connect(shaType.iAngInc, solWin.angInc) annotation (Line(points={{-60,-54},{
          -60,-54},{-10,-54}},           color={0,0,127}));
  connect(heaCapGlaInt.port, layMul.port_a)
    annotation (Line(points={{16,-12},{16,0},{10,0}}, color={191,0,0}));
  connect(heaCapFraIn.port, layFra.port_a)
    annotation (Line(points={{14,100},{14,70},{10,70}}, color={191,0,0}));
  connect(skyRadFra.epsLw, constEpsLwFra.y) annotation (Line(points={{-20,93.4},
          {-14,93.4},{-14,91},{-6.5,91}}, color={0,0,127}));
  connect(solAbs.port_a, layFra.port_b) annotation (Line(points={{-20,50},{-16,
          50},{-16,70},{-10,70}},
                              color={191,0,0}));
  connect(gainDir.y, solWin.solDir)
    annotation (Line(points={{-37.8,-44},{-10,-44}}, color={0,0,127}));
  connect(gainDif.y, solWin.solDif) annotation (Line(points={{-31.8,-48},{-22,
          -48},{-10,-48}}, color={0,0,127}));
  connect(radSolData.HDirTil, shaType.HDirTil) annotation (Line(points={{-79.4,
          -46},{-78,-46},{-78,-44},{-70,-44}}, color={0,0,127}));
  connect(radSolData.HSkyDifTil, shaType.HSkyDifTil) annotation (Line(points={{-79.4,
          -48},{-76,-48},{-76,-46},{-70,-46}},       color={0,0,127}));
  connect(radSolData.HGroDifTil, shaType.HGroDifTil) annotation (Line(points={{-79.4,
          -50},{-74,-50},{-74,-48},{-70,-48}},       color={0,0,127}));
  connect(shaType.HShaGroDifTil, solDif.u2) annotation (Line(points={{-60,-48},
          {-56.6,-48},{-56.6,-48.8}}, color={0,0,127}));
  connect(solDif.u1, shaType.HShaSkyDifTil) annotation (Line(points={{-56.6,
          -45.2},{-56.3,-45.2},{-56.3,-46},{-60,-46}}, color={0,0,127}));
  connect(gainDif.u, solDif.y) annotation (Line(points={{-36.4,-48},{-49.7,-48},
          {-49.7,-47}}, color={0,0,127}));
  connect(solDif.y, solAbs.solDif) annotation (Line(points={{-49.7,-47},{-48,
          -47},{-48,52},{-40,52}}, color={0,0,127}));
  connect(shaType.HShaDirTil, solAbs.solDir) annotation (Line(points={{-60,-44},
          {-60,-44},{-60,56},{-40,56}}, color={0,0,127}));
  connect(gainDir.u, shaType.HShaDirTil) annotation (Line(points={{-42.4,-44},{
          -51.2,-44},{-60,-44}}, color={0,0,127}));
  connect(eCon.hForcedConExt, radSolData.hForcedConExt) annotation (Line(points=
         {{-20,-37},{-50,-37},{-50,-62.2},{-79.4,-62.2}}, color={0,0,127}));
  connect(layFra.port_b, heaCapFraExt.port)
    annotation (Line(points={{-10,70},{-10,100}}, color={191,0,0}));
  connect(heaCapGlaExt.port, layMul.port_b)
    annotation (Line(points={{-10,-12},{-10,0}}, color={191,0,0}));
  connect(res1.port_a,outsideAir. ports[1]) annotation (Line(points={{20,-40},{16,
          -40},{16,-90},{-20,-90}}, color={0,127,255}));
  connect(res2.port_a,outsideAir. ports[2]) annotation (Line(points={{20,-60},{16,
          -60},{16,-90},{-20,-90}}, color={0,127,255}));
    annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-60,-100},{60,100}}),
        graphics={
        Rectangle(
          extent={{-50,-90},{50,100}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,60},{50,24},{50,-50},{-30,-20},{-46,-20},{-46,60}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Line(
          points={{-50,60},{-30,60},{-30,80},{50,80}},
          color={175,175,175}),
        Line(
          points={{-50,-20},{-30,-20},{-30,-70},{-30,-70},{52,-70}},
          color={175,175,175}),
        Line(
          points={{-50,60},{-50,66},{-50,100},{50,100}},
          color={175,175,175}),
        Line(
          points={{-50,-20},{-50,-90},{50,-90}},
          color={175,175,175}),
        Line(
          points={{-46,60},{-46,-20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None)}),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>
This model should be used to model windows or other transparant surfaces.
See <a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialSurface>IDEAS.Buildings.Components.Interfaces.PartialSurface</a> 
for equations, options, parameters, validation and dynamics that are common for all surfaces and windows.
</p>
<h4>Typical use and important parameters</h4>
<p>
Parameter <code>A</code> is the total window surface area, i.e. the
sum of the frame surface area and the glazing surface area.
</p>
<p>
Parameter <code>frac</code> may be used to define the surface
area of the frame as a fraction of <code>A</code>. 
</p>
<p>
Parameter <code>glazing</code>  must be used to define the glass properties.
It contains information about the number of glass layers,
their thickness, thermal properties and emissivity.
</p>
<p>
Optional parameter <code>briType</code> may be used to compute additional line losses
along the edges of the glazing.
</p>
<p>
Optional parameter <code>fraType</code> may be used to define the frame thermal properties.
If <code>fraType = None</code> then the frame is assumed to be perfectly insulating.
</p>
<p>
Optional parameter <code>shaType</code> may be used to define the window shading properties.
</p>
<p>
The parameter <code>n</code> may be used to scale the window to <code>n</code> identical windows.
For example, if a wall has 10 identical windows with identical shading, this parameter
can be used to simulate 10 windows by scaling the model of a single window.
</p>
<h4>Validation</h4>
<p>
To verify the U-value of your glazing system implementation,
see <a href=\"modelica://IDEAS.Buildings.Components.Validations.WindowEN673\">
IDEAS.Buildings.Components.Validations.WindowEN673</a>
</p>
</html>", revisions="<html>
<ul>
<li>
August 12, 2020 by Filip Jorissen:<br/>
No longer using connector and initial equation for <code>epsSw</code>.
<a href=\"https://github.com/open-ideas/IDEAS/issues/1162\">#1162</a>.
</li>
<li>
July 2020, 2020, by Filip Jorissen:<br/>
Added a list of default glazing systems.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1114\">
#1114</a>
</li>
<li>
April 26, 2020, by Filip Jorissen:<br/>
Refactored <code>SolBus</code> to avoid many instances in <code>PropsBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1131\">
#1131</a>
</li>
<li>
November 28, 2019, by Ian Beausoleil-Morrison:<br/>
<code>inc</code> and <code>azi</code> of surface now passed as parameters to ExteriorConvection.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
December 2, 2019, by Filip Jorissen:<br/>
Split heat capacitor to interior and exterior part 
to avoid non-linear algebraic loops.
<a href=\"https://github.com/open-ideas/IDEAS/issues/1092\">#1092</a>.
</li>
<li>
October 13, 2019, by Filip Jorissen:<br/>
Refactored the parameter definition of <code>inc</code> 
and <code>azi</code> by adding the option to use radio buttons.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1067\">
#1067</a>
</li>
<li>
September 9, 2019, by Filip Jorissen:<br/>
Added <code>checkCoatings</code> for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/1038\">#1038</a>.
</li>
<li>
August 10, 2018 by Damien Picard:<br/>
Add scaling to propsBus_a to allow simulation of n windows instead of 1
See <a href=\"https://github.com/open-ideas/IDEAS/issues/888\">
#888</a>.
</li>
<li>
January 21, 2018 by Filip Jorissen:<br/>
Changed implementation such that control input is visible.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/761\">
#761</a>.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
March 6, 2017, by Filip Jorissen:<br/>
Added option for using 'normal' dynamics for the window glazing.
Removed the option for having a combined state for 
window and frame this this is non-physical.
This is for 
<a href=https://github.com/open-ideas/IDEAS/issues/678>#678</a>.
</li>
<li>
January 10, 2017, by Filip Jorissen:<br/>
Removed declaration of 
<code>A</code> since this is now declared in 
<a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialSurface>
IDEAS.Buildings.Components.Interfaces.PartialSurface</a>.
This is for 
<a href=https://github.com/open-ideas/IDEAS/issues/609>#609</a>.
</li>
<li>
January 10, 2017 by Filip Jorissen:<br/>
Set <code>linExtRad = sim.linExtRadWin</code>.
See <a href=https://github.com/open-ideas/IDEAS/issues/615>#615</a>.
</li>
<li>
December 19, 2016, by Filip Jorissen:<br/>
Added solar irradiation on window frame.
</li>
<li>
December 19, 2016, by Filip Jorissen:<br/>
Removed briType, which had default value LineLoss.
briType is now part of the Frame model and has default
value None.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: cleaned up connections and partials.
</li>
<li>
December 17, 2015, Filip Jorissen:<br/>
Added thermal connection between frame and glazing state. 
This is required for decoupling steady state thermal dynamics
without adding a second state for the window.
</li>
<li>
July 14, 2015, Filip Jorissen:<br/>
Removed second shading device since a new partial was created
for handling this.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
Adjusted implementation for computing conservation of energy.
</li>
<li>
February 10, 2015 by Filip Jorissen:<br/>
Adjusted implementation for grouping of solar calculations.
</li>
</ul>
</html>"));
end Window;
