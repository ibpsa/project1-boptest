within IDEAS.Templates.Ventilation;
model None "No ventilation"
  extends IDEAS.Templates.Interfaces.BaseClasses.VentilationSystem(
                                                         nLoads=0);

  IDEAS.Fluid.Sources.Boundary_pT[nZones] sink(
    each final nPorts=1,
    redeclare each package Medium = Medium)
    annotation (Placement(transformation(extent={{-160,10},{-180,30}})));
  IDEAS.Fluid.Sources.MassFlowSource_T[nZones] sou(
    each use_m_flow_in=true,
    each final nPorts=1,
    redeclare each package Medium = Medium,
    each use_T_in=true) "Source"
    annotation (Placement(transformation(extent={{-160,-30},{-180,-10}})));
  Modelica.Blocks.Sources.Constant m_flow_val[nZones](each final k=0)
    annotation (Placement(transformation(extent={{-120,-4},{-140,16}})));
  Modelica.Blocks.Sources.Constant TSet_val[nZones](each k=273.15+20)
    annotation (Placement(transformation(extent={{-120,-40},{-140,-20}})));
equation
  connect(port_b[:], sou[:].ports[1]) annotation (Line(
      points={{-200,-20},{-180,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(port_a[:], sink[:].ports[1]) annotation (Line(
      points={{-200,20},{-180,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sou.m_flow_in,m_flow_val. y) annotation (Line(
      points={{-158,-12},{-146,-12},{-146,6},{-141,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSet_val.y,sou. T_in) annotation (Line(
      points={{-141,-30},{-146,-30},{-146,-16},{-158,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics), Icon(coordinateSystem(extent={{-200,
            -100},{200,100}})),
    Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end None;
