within IDEAS.Templates.Heating;
model None "No heating or cooling system"
  extends IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    nConvPorts = nZones,
    nRadPorts = nZones,
    nTemSen = nZones,
    nEmbPorts=nZones,
    final nLoads=0,
    nZones=1);
protected
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow preHeaFloCon[nZones](
    each final Q_flow=0,
    each final alpha=0) if nConvPorts >=1
    annotation (Placement(transformation(extent={{-160,10},{-180,30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow preHeaFloRad[nZones](
    each final Q_flow=0,
    each final alpha=0) if nRadPorts >=1
    annotation (Placement(transformation(extent={{-160,-30},{-180,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow preHeaFloEmb[nEmbPorts](
    each final Q_flow=0,
    each final alpha=0) if nEmbPorts >=1
    annotation (Placement(transformation(extent={{-160,50},{-180,70}})));
equation
  connect(preHeaFloCon.port, heatPortCon) annotation (Line(
      points={{-180,20},{-200,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(preHeaFloEmb.port, heatPortEmb) annotation (Line(
      points={{-180,60},{-200,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(preHeaFloRad.port, heatPortRad) annotation (Line(
      points={{-180,-20},{-200,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics), Documentation(info="<html>
<p>
This example model implements a dummy heating system 
that injects no heat or cold into the building zones.
</p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>
January 23, 2017 by Filip Jorissen:<br/>
Revised implementation and documentation.
</li>
</ul>
</html>"));
end None;
