within IDEAS.Experimental.Electric.Photovoltaics.Components;
class PvArray

  parameter Real amount=2;
  parameter Real inc=34 "inclination";
  parameter Real azi=0 "azimuth";

  replaceable parameter IDEAS.Experimental.Electric.Data.Interfaces.PvPanel pvPanel
    "Choose a Photovoltaic panel to be used"
    annotation (choicesAllMatching=true);
  extends IDEAS.Experimental.Electric.Photovoltaics.Components.DCgen;

  IDEAS.BoundaryConditions.SolarIrradiation.RadSolData radSol(
    azi=azi,
    inc=inc,
    incAndAziInBus=sim.incAndAziInBus,
    numIncAndAziInBus=sim.numIncAndAziInBus,
    outputAngles=sim.outputAngles,
    lat=sim.lat) annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.Elements.refraction refDir
    annotation (Placement(transformation(extent={{-8,20},{12,40}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.Elements.refraction refDif
    annotation (Placement(transformation(extent={{-8,-4},{12,16}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.Elements.refraction refRef
    annotation (Placement(transformation(extent={{-8,-26},{12,-6}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.Elements.incidenceAngles
    incidenceAngles(azi=azi, inc=inc)
    annotation (Placement(transformation(extent={{-38,20},{-18,40}})));
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.Elements.absorption absorption
    annotation (Placement(transformation(extent={{22,20},{42,40}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.Elements.PV5 PV5(pvPanel=
        pvPanel)
    annotation (Placement(transformation(extent={{48,20},{68,40}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.Elements.PvSerie pvSerie(amount=
        amount) annotation (Placement(transformation(extent={{72,20},{92,40}})));
  Modelica.Blocks.Math.Cos cos
    annotation (Placement(transformation(extent={{-56,40},{-48,48}})));
  Modelica.Blocks.Math.Cos cos1
    annotation (Placement(transformation(extent={{-60,28},{-52,36}})));
  Modelica.Blocks.Math.Cos cos2
    annotation (Placement(transformation(extent={{-68,12},{-60,20}})));
protected
  Modelica.Blocks.Math.Add solDif(final k1=1, final k2=1)
    "Sum of ground and sky diffuse solar irradiation"
    annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
equation
  connect(incidenceAngles.angIncDir, refDir.angInc) annotation (Line(
      points={{-18,36},{-8,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incidenceAngles.angIncDif, refDif.angInc) annotation (Line(
      points={{-18,32},{-14,32},{-14,12},{-8,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incidenceAngles.angIncRef, refRef.angInc) annotation (Line(
      points={{-18,28},{-16,28},{-16,-10},{-8,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(refDir.IncAngMod, absorption.IamDir) annotation (Line(
      points={{12,36},{22,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(refDif.IncAngMod, absorption.IamDif) annotation (Line(
      points={{12,12},{16,12},{16,32},{22,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(refRef.IncAngMod, absorption.IamRef) annotation (Line(
      points={{12,-10},{18,-10},{18,28},{22,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSol.HDirTil, absorption.solDir) annotation (Line(
      points={{-79.4,58},{34,58},{34,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(absorption.solAbs, PV5.solAbs) annotation (Line(
      points={{42,36},{48,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(absorption.T, PV5.T) annotation (Line(
      points={{42,32},{48,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PV5.pin, pvSerie.pinCel) annotation (Line(
      points={{68,36},{72,36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pvSerie.pinSer, p) annotation (Line(
      points={{92,36},{94,36},{94,-38},{-48,-38},{-48,0},{-100,0}},
      color={0,0,255},
      smooth=Smooth.None));

  //Ground reflectantance is not used for now (see Absorption model => SolAbs equation!
  connect(radSol.weaBus, sim.weaBus) annotation (Line(
      points={{-80,62},{-76,62},{-76,92.8},{-84,92.8}},
      color={255,204,51},
      thickness=0.5));
  connect(solDif.u1, radSol.HSkyDifTil) annotation (Line(points={{-52.6,54.8},{
          -65.3,54.8},{-65.3,56},{-79.4,56}}, color={0,0,127}));
  connect(solDif.u2, radSol.HGroDifTil) annotation (Line(points={{-52.6,51.2},{
          -66,51.2},{-66,54},{-79.4,54}}, color={0,0,127}));
  connect(solDif.y, absorption.solDif)
    annotation (Line(points={{-45.7,53},{38,53},{38,40}}, color={0,0,127}));
  connect(radSol.angInc, cos.u) annotation (Line(points={{-79.4,50},{-64,50},{
          -64,44},{-56.8,44}}, color={0,0,127}));
  connect(cos.y, incidenceAngles.angInc) annotation (Line(points={{-47.6,44},{
          -42,44},{-42,36},{-38,36}}, color={0,0,127}));
  connect(radSol.angZen, cos1.u) annotation (Line(points={{-79.4,48},{-66,48},{
          -66,32},{-60.8,32}}, color={0,0,127}));
  connect(cos1.y, incidenceAngles.angZen)
    annotation (Line(points={{-51.6,32},{-38,32}}, color={0,0,127}));
  connect(radSol.angHou, cos2.u) annotation (Line(points={{-79.4,44},{-68,44},{
          -68,20},{-64.8,20}}, color={0,0,127}));
  connect(cos2.y, incidenceAngles.angHou) annotation (Line(points={{-55.6,20},{
          -46,20},{-46,28},{-38,28}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
            -100},{100,100}}),
                         graphics={
        Line(
          points={{-100,0},{100,0}},
          color={85,170,255},
          smooth=Smooth.None),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-4,20},{-4,-20}},
          color={85,170,255},
          smooth=Smooth.None),
        Rectangle(
          extent={{6,10},{4,-10}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-4,0},{-40,0}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{40,0},{4,0}},
          color={85,170,255},
          smooth=Smooth.None),
        Polygon(
          points={{28,40},{42,60},{48,54},{28,40}},
          lineColor={85,170,255},
          smooth=Smooth.None,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{28,40},{58,70}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{40,30},{70,60}},
          color={85,170,255},
          smooth=Smooth.None),
        Polygon(
          points={{40,30},{54,50},{60,44},{40,30}},
          lineColor={85,170,255},
          smooth=Smooth.None,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}));
end PvArray;
