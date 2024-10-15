within IDEAS.Templates.Heating;
model IdealRadiatorHeating
  "Radiator heating system using hysteresis controller, using idealised heat emission"
  extends IDEAS.Templates.Heating.BaseClasses.HysteresisHeating(
    final nEmbPorts=0,
    final nConvPorts = nZones,
    final nRadPorts = nZones);
  parameter Real fraRad(min=0,max=1) = 0.3
    "Fraction of heat that is dissipated using radiative heat transfer";

protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nZones] preHeaFloRad(
    each final alpha=0)
    "Prescribed heat flow rate for radiative gains"
    annotation (Placement(transformation(extent={{-160,-30},{-180,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nZones] preHeaFloCon(
    each final alpha=0)
    "Prescribed heat flow rate for convection gains"
    annotation (Placement(transformation(extent={{-160,10},{-180,30}})));
  Modelica.Blocks.Math.Gain[nZones] gain(final k=QNom) "Nominal heat gain"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));

  Modelica.Blocks.Math.Gain[nZones] fraRadGai(each k=fraRad)
    "Fraction of heat that is dissipated through radiative port"
    annotation (Placement(transformation(extent={{-130,10},{-150,30}})));
  Modelica.Blocks.Math.Gain[nZones] fraConGai(each k=1 - fraRad)
    "Fraction of heat that is dissipated through convective port"
    annotation (Placement(transformation(extent={{-130,-30},{-150,-10}})));
equation
  connect(fraConGai.y, preHeaFloRad.Q_flow)
    annotation (Line(points={{-151,-20},{-160,-20}}, color={0,0,127}));
  connect(fraRadGai.y, preHeaFloCon.Q_flow)
    annotation (Line(points={{-151,20},{-160,20}}, color={0,0,127}));
  connect(fraRadGai.u, gain.y) annotation (Line(points={{-128,20},{-122,20},{-122,
          0},{-121,0}}, color={0,0,127}));
  connect(fraConGai.u, gain.y) annotation (Line(points={{-128,-20},{-122,-20},{-122,
          0},{-121,0}}, color={0,0,127}));
  connect(preHeaFloRad.port, heatPortRad)
    annotation (Line(points={{-180,-20},{-200,-20}}, color={191,0,0}));
  connect(preHeaFloCon.port, heatPortCon)
    annotation (Line(points={{-180,20},{-200,20}}, color={191,0,0}));
  connect(booToRea.y, gain.u)
    annotation (Line(points={{-81,0},{-98,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This model represents an ideal heating system with a hysteresis controller.
It reacts instantly when the zone temperature input <code>TSensor</code> is 
below <code>TSet</code> by supplying the nominal
heat flow rate <code>QNom</code>.
This heat flow rate is maintained until <code>TSensor</code> is above <code>TSet+dTHys</code>.
</p>
<p>
The <code>COP</code> is used to compute the electric power that is drawn from 
the elecrical grid. It can be ignored if it is not of interest.
</p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>
January 23, 2017 by Filip Jorissen and Glenn Reynders:<br/>
Revised implementation and documentation.
</li>
<li>2013 June, Roel De Coninck: reworking interface and documentation</li>
<li>2011, Roel De Coninck: first version</li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,100}}),
        graphics));
end IdealRadiatorHeating;
