within MultiZoneResidentialHydronic.Building.Ventilation;
model Ventil_5bis

  package MediumA = Buildings.Media.Air "Medium model";

  parameter Modelica.SIunits.MassFlowRate Q = 1
    "Dbit d'extraction";

  Modelica.Fluid.Interfaces.FluidPorts_b ports1[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,18},{46,44}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports3[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,48},{46,74}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-72,28},{-52,48}}), iconTransformation(extent={
            {-80,24},{-60,44}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    inputType=Buildings.Fluid.Types.InputType.Constant,
    redeclare package Medium = MediumA,
    m_flow_nominal=Q,
    use_inputFilter=false,
    nominalValuesDefineDefaultPressureCurve=true)
    annotation (Placement(transformation(extent={{20,24},{8,36}})));
  Buildings.Fluid.Sources.Outside out(
    redeclare package Medium = MediumA,
    use_C_in=false,
    nPorts=2) "Outside air conditions"
    annotation (Placement(transformation(extent={{-34,28},{-14,48}})));

equation
  connect(fan.port_a, ports1[1])
    annotation (Line(points={{20,30},{42,30},{42,31}}, color={0,127,255}));
  connect(weaBus, out.weaBus) annotation (Line(
      points={{-62,38},{-48,38},{-48,38.2},{-34,38.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(out.ports[1], fan.port_b) annotation (Line(points={{-14,40},{-4,40},{-4,
          30},{8,30}}, color={0,127,255}));
  connect(out.ports[2:2], ports3) annotation (Line(points={{-14,36},{-6,36},{-6,
          62},{42,62},{42,61}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,20},{40,
            100}})),
    Icon(coordinateSystem(extent={{-60,20},{40,100}}, preserveAspectRatio=false),
        graphics),
    Documentation(info="<html>
<h4>Ventilation</h4>
<p>Take into account the ventilation airflow in a thermal zone.</p>
<p>The ventilation system is defined by an extracted airflow with : </p>
<ul>
<li>mass airflow as input</li>
</ul>
</html>"));
end Ventil_5bis;
