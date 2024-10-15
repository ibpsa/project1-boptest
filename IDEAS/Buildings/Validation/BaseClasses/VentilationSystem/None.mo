within IDEAS.Buildings.Validation.BaseClasses.VentilationSystem;
model None "NoneVentilation with constant air flow at constant temperature and no power calculations"
  extends IDEAS.Templates.Interfaces.BaseClasses.VentilationSystem(
                                                         nLoads=1);
  parameter Modelica.SIunits.MassFlowRate m_flow[nZones] = zeros(nZones)
    "Ventilation mass flow rate per zones";
  parameter Modelica.SIunits.Temperature TSet[nZones] = 22*.ones(nZones) .+ 273.15
    "Ventilation set point temperature per zone";

  IDEAS.Fluid.Sources.MassFlowSource_T sou[nZones](
    each use_m_flow_in=true,
    each final nPorts=1,
    redeclare each package Medium = Medium,
    each use_T_in=true) "Source"
    annotation (Placement(transformation(extent={{-162,12},{-182,32}})));
  IDEAS.Fluid.Sources.Boundary_pT sink[nZones](
    each final nPorts=1,
    redeclare each package Medium = Medium)
    annotation (Placement(transformation(extent={{-162,-28},{-182,-8}})));
  Modelica.Blocks.Sources.Constant m_flow_val[nZones](k=m_flow)
    annotation (Placement(transformation(extent={{-122,38},{-142,58}})));
  Modelica.Blocks.Sources.Constant TSet_val[nZones](k=TSet)
    annotation (Placement(transformation(extent={{-122,2},{-142,22}})));
equation

  connect(port_b[:], sou[:].ports[1]);
  connect(port_a[:], sink[:].ports[1]);

  connect(sou.m_flow_in, m_flow_val.y) annotation (Line(
      points={{-160,30},{-148,30},{-148,48},{-143,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSet_val.y, sou.T_in) annotation (Line(
      points={{-143,12},{-148,12},{-148,26},{-160,26}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end None;
