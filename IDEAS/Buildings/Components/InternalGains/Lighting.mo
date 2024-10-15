within IDEAS.Buildings.Components.InternalGains;
model Lighting
  "Computes heat gains due to lighting requirements"
  extends IDEAS.Buildings.Components.InternalGains.BaseClasses.PartialLightingGains;


  Modelica.Blocks.Math.Gain gaiHea(final k=PNom)
    "Gain for computing heat lighting gains based on zone lighting requirements"
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));

protected
  final parameter Modelica.SIunits.Power PNom = rooTyp.Ev*A/ligTyp.K
    "Nominal power, avoids parameter division";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloCon(final
      alpha=0) "Prescribed heat flow rate for convective sensible heat"
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Blocks.Math.Gain gainRad(final k=ligTyp.radFra) "Radiative fraction"
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
  Modelica.Blocks.Math.Gain gainCon(final k=1 - ligTyp.radFra)
    "Convective fraction"
    annotation (Placement(transformation(extent={{-8,10},{12,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloRad(
    final alpha=0) "Prescribed heat flow rate for radiative sensible heat"
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
equation
  connect(preHeaFloCon.port, portCon)
    annotation (Line(points={{60,20},{100,20}},            color={191,0,0}));
  connect(preHeaFloRad.port, portRad)
    annotation (Line(points={{60,-20},{100,-20}},           color={191,0,0}));
  connect(gainRad.y, preHeaFloRad.Q_flow)
    annotation (Line(points={{13,-20},{40,-20}}, color={0,0,127}));
  connect(gainCon.y, preHeaFloCon.Q_flow) annotation (Line(points={{13,20},{40,20}},
                                   color={0,0,127}));
  connect(gainCon.u, gaiHea.y)
    annotation (Line(points={{-10,20},{-20,20},{-20,0},{-31,0}},
                                                             color={0,0,127}));
  connect(gainRad.u, gaiHea.y) annotation (Line(points={{-10,-20},{-20,-20},{-20,
          0},{-31,0}}, color={0,0,127}));
  connect(ctrl, gaiHea.u) annotation (Line(points=
         {{-110,0},{-54,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This lighting model uses a light control input signal, 
which should have a value between 0 and 1,
which is multiplied by the lighting requirements of the zone (<i>lx=lm/m<sup>2</sup></i>), 
the floor area (<i>m<sup>2</sup></i>) and the inverse of the luminous efficacy (<i>lm/W</i>). 
The total lighting gains are then split into a radiative and a convective part. 
</p>
</html>",
        revisions="<html>
<ul>
<li>
September 26, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>"));
end Lighting;
