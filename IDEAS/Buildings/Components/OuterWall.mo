within IDEAS.Buildings.Components;
model OuterWall "Opaque building envelope construction"
   extends IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface(
     setArea(A=A),
     final nWin=1,
     dT_nominal_a=-3,
     QTra_design(fixed=false));

  parameter Boolean linExtCon=sim.linExtCon
    "= true, if exterior convective heat transfer should be linearised (uses average wind speed)"
    annotation(Dialog(tab="Convection"));
  parameter Boolean linExtRad=sim.linExtRad
    "= true, if exterior radiative heat transfer should be linearised"
    annotation(Dialog(tab="Radiation"));
  parameter Boolean hasBuildingShade = false
    "=true, to enable computation of shade cast by opposite building or object"
    annotation(Dialog(group="Building shade"));
  parameter Modelica.SIunits.Length L(min=0)=0
    "Distance between object and wall, perpendicular to wall"
    annotation(Dialog(group="Building shade",enable=hasBuildingShade));
  parameter Modelica.SIunits.Length dh(min=-hWal)=0
    "Height difference between top of object and top of wall"
    annotation(Dialog(group="Building shade",enable=hasBuildingShade));
  parameter Modelica.SIunits.Length hWal(min=0)=0 "Wall height"
    annotation(Dialog(group="Building shade",enable=hasBuildingShade));
  final parameter Real U_value=1/(1/8 + sum(constructionType.mats.R) + 1/25)
    "Wall U-value";

  parameter Real coeffsCp[:,:]=[0,0.4; 45,0.1; 90,-0.3; 135,-0.35; 180,-0.2; 225,
      -0.35; 270,-0.3; 315,0.1; 360,0.4]
      "Cp at different angles of attack"
      annotation(Dialog(tab="Airflow", group="Wind Pressure"));

  replaceable IDEAS.Buildings.Components.Shading.BuildingShade shaType(
    final L=L,
    final dh=dh,
    final hWin=hWal) if hasBuildingShade
  constrainedby IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
    final azi=aziInt)
    "Building shade model"
    annotation (Placement(transformation(extent={{-72,-8},{-62,12}})),
      __Dymola_choicesAllMatching=true,
      Dialog(tab="Advanced",group="Shading"));



  parameter Real Cs=sim.Cs
                       "Wind speed modifier"
    annotation (Dialog(tab="Airflow", group="Wind Pressure"));
  parameter Real Habs=1
    "Absolute height of boundary for correcting the wind speed"
    annotation (Dialog(tab="Airflow", group="Wind Pressure"));
protected
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExteriorConvection
    extCon(
      linearise=linExtCon or sim.linearise,
      final A=A,
      final inc=incInt,
      final azi=aziInt)
    "convective surface heat transimission on the exterior side of the wall"
    annotation (Placement(transformation(extent={{-22,-28},{-42,-8}})));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorSolarAbsorption
    solAbs(A=A, epsSw=layMul.mats[1].epsSw_b)
    "determination of absorbed solar radiation by wall based on incident radiation"
    annotation (Placement(transformation(extent={{-22,-8},{-42,12}})));
  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorHeatRadiation
    extRad(               linearise=linExtRad or sim.linearise, final A=A)
    "determination of radiant heat exchange with the environment and sky"
    annotation (Placement(transformation(extent={{-22,12},{-42,32}})));
  BoundaryConditions.SolarIrradiation.RadSolData radSolData(
    inc=incInt,
    azi=aziInt,
    useLinearisation=sim.lineariseDymola)
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  Modelica.Blocks.Routing.RealPassThrough Tdes "Design temperature passthrough";
  Modelica.Blocks.Math.Add solDif(final k1=1, final k2=1)
    "Sum of ground and sky diffuse solar irradiation"
    annotation (Placement(transformation(extent={{-54,0},{-46,8}})));
  IDEAS.Fluid.Sources.OutsideAir outsideAir(
    redeclare package Medium = Medium,
    final table=coeffsCp,
    final azi=aziInt,
    Cs=Cs,
    Habs=Habs,
    nPorts=if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort
         then 1 else 2) if
    sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None
    "Outside air model"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
initial equation
  QTra_design =U_value*A*(273.15 + 21 - Tdes.y);

equation
  if hasBuildingShade then
    assert(L>0, "Shading is enabled in " + getInstanceName() +
    ": Provide a value for L, the distance to the shading object, that is larger than 0.");
    assert(not sim.lineariseDymola, "Shading is enabled in " + getInstanceName() +
    " but this is not supported when linearising a model.");
    assert(hWal>0, "Shading is enabled in " + getInstanceName() +
    ": Provide a value for hWal, the wall height, that is larger than 0.");
  end if;

  connect(extCon.port_a, layMul.port_b) annotation (Line(
      points={{-22,-18},{-18,-18},{-18,0},{-10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solAbs.port_a, layMul.port_b) annotation (Line(
      points={{-22,2},{-12,2},{-12,0},{-10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(extRad.port_a, layMul.port_b) annotation (Line(
      points={{-22,22},{-18,22},{-18,0},{-10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.iEpsLw_b,extRad. epsLw) annotation (Line(
      points={{-10,8},{-16,8},{-16,25.4},{-22,25.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSolData.Tenv,extRad. Tenv) annotation (Line(
      points={{-79.4,2},{-70,2},{-70,38},{-22,38},{-22,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(extCon.Te, radSolData.Te) annotation (Line(
      points={{-22,-22.8},{-79.4,-22.8},{-79.4,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tdes.u, radSolData.Tdes);
  connect(solDif.y, solAbs.solDif) annotation (Line(points={{-45.6,4},{-42,4}},
                               color={0,0,127}));
  connect(radSolData.angInc, shaType.angInc) annotation (Line(
      points={{-79.4,0},{-76,0},{-76,-2},{-72,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSolData.angAzi, shaType.angAzi) annotation (Line(
      points={{-79.4,-4},{-78,-4},{-78,-6},{-72,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSolData.angZen, shaType.angZen) annotation (Line(
      points={{-79.4,-2},{-76,-2},{-76,-4},{-72,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSolData.HDirTil, shaType.HDirTil) annotation (Line(points={{-79.4,8},
          {-76,8},{-76,8},{-72,8}},            color={0,0,127}));
  connect(radSolData.HSkyDifTil, shaType.HSkyDifTil) annotation (Line(points={{-79.4,6},
          {-76,6},{-76,6},{-72,6}},                  color={0,0,127}));
  connect(radSolData.HGroDifTil, shaType.HGroDifTil) annotation (Line(points={{-79.4,4},
          {-76,4},{-76,4},{-72,4}},                  color={0,0,127}));
  if not hasBuildingShade then
    connect(solDif.u1, radSolData.HSkyDifTil) annotation (Line(points={{-54.8,6.4},
            {-55.3,6.4},{-55.3,6},{-79.4,6}},
                                            color={0,0,127}));
    connect(solDif.u2, radSolData.HGroDifTil) annotation (Line(points={{-54.8,1.6},
            {-55.3,1.6},{-55.3,4},{-79.4,4}},
                                            color={0,0,127}));
    connect(solAbs.solDir, radSolData.HDirTil)
      annotation (Line(points={{-42,8},{-62,8},{-62,8},{-79.4,8}},
                                                   color={0,0,127}));
  end if;
  connect(shaType.HShaDirTil, solAbs.solDir)
    annotation (Line(points={{-62,8},{-42,8}},           color={0,0,127}));
  connect(shaType.HShaSkyDifTil, solDif.u1) annotation (Line(points={{-62,6},{
          -54.8,6},{-54.8,6.4}},   color={0,0,127}));
  connect(shaType.HShaGroDifTil, solDif.u2) annotation (Line(points={{-62,4},{
          -56,4},{-56,1.6},{-54.8,1.6}},   color={0,0,127}));
  connect(radSolData.hForcedConExt, extCon.hForcedConExt) annotation (Line(points={{-79.4,
          -8.2},{-46,-8.2},{-46,-34},{-16,-34},{-16,-27},{-22,-27}},
                                                           color={0,0,127}));
  connect(res1.port_a, outsideAir.ports[1]) annotation (Line(points={{20,-40},{16,
          -40},{16,-50},{-80,-50}}, color={0,127,255}));
  connect(res2.port_a, outsideAir.ports[2]) annotation (Line(points={{20,-60},{16,
          -60},{16,-50},{-80,-50}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-60,-100},{60,100}}),
        graphics={
        Rectangle(
          extent={{-50,-90},{50,80}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,60},{-30,60},{-30,80},{50,80},{50,100},{-50,100},{-50,60}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-30,-70},{-50,-20}},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{-50,60},{-50,66},{-50,100},{50,100}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,60},{-30,60},{-30,80},{50,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,-20},{-30,-20},{-30,-70},{-30,-70},{52,-70}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,-20},{-50,-90},{50,-90}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-44,60},{-30,60},{-30,80},{-28,80},{50,80}},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-44,-20},{-30,-20},{-30,-70}},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-44,60},{-44,-20}},
          smooth=Smooth.None,
          color={175,175,175}),
        Line(
          points={{-44,-20},{-30,-20},{-30,-70}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-44,60},{-30,60},{-30,80},{50,80}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>
This is the main wall model that should be used to
simulate a wall or roof between a zone and the outside environment.
</p>
<h4>Typical use and important parameters</h4>
<p>
See <a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface>
IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface</a> 
for equations, options, parameters, validation and dynamics that are common for all surfaces.
</p>
<p>
In addition to these parameters, this model computes the shade cast by an outside
object such as a building using 
<a href=\"IDEAS.Buildings.Components.Shading.BuildingShade\">IDEAS.Buildings.Components.Shading.BuildingShade</a>
if parameter <code>hasBuildingShade=true</code>.
Values for parameters <code>L</code>, <code>dh</code> and <code>hWal</code> then have to be specified.
</p>
<h4>Options</h4>
<p>
The model <a href=\"IDEAS.Buildings.Components.Shading.BuildingShade\">IDEAS.Buildings.Components.Shading.BuildingShade</a> 
is implemented by default but it can be redeclared in the advanced tab. 
In this case the user still has to provide values for <code>L</code>, <code>dh</code> and <code>hWal</code>
to avoid failing an assert that verifies the parameter consistency. The values are however not used in this case.
The correct shading parameter values should then be passed through the redeclaration.
</p>
</html>", revisions="<html>
<ul>
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
October 13, 2019, by Filip Jorissen:<br/>
Refactored the parameter definition of <code>inc</code> 
and <code>azi</code> by adding the option to use radio buttons.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1067\">
#1067</a>
</li>
<li>
August 10, 2018 by Damien Picard:<br/>
Set nWin final to 1 as this should only be used for windows.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/888\">
#888</a>. 
</li>
<li>
May 29, 2018 by Filip Jorissen:<br/>
Added building shade implementation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/576\">
#576</a>.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
January 2, 2017, by Filip Jorissen:<br/>
Updated icon layer.
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: cleaned up connections and partials.
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
end OuterWall;
