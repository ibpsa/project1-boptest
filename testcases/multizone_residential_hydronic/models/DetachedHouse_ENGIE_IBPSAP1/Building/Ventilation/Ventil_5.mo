within DetachedHouse_ENGIE_IBPSAP1.Building.Ventilation;
model Ventil_5

  package MediumA = Buildings.Media.Air "Medium model";

    parameter Modelica.SIunits.MassFlowRate Q = 1
    "Dbit d'extraction";

  Modelica.Fluid.Interfaces.FluidPorts_b ports1[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,18},{46,44}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-72,28},{-52,48}}), iconTransformation(extent={
            {-80,24},{-60,44}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    inputType=Buildings.Fluid.Types.InputType.Constant,
    redeclare package Medium = MediumA,
    m_flow_nominal=Q,
    use_inputFilter=false,
    nominalValuesDefineDefaultPressureCurve=true)
    annotation (Placement(transformation(extent={{26,26},{14,38}})));
  Buildings.Fluid.Sources.Outside out(
    redeclare package Medium = MediumA,
    use_C_in=false,
    nPorts=1) "Outside air conditions"
    annotation (Placement(transformation(extent={{-28,28},{-8,48}})));
equation
  connect(fan.port_a, ports1[1])
    annotation (Line(points={{26,32},{42,32},{42,31}}, color={0,127,255}));
  connect(out.ports[1], fan.port_b) annotation (Line(points={{-8,38},{2,38},{2,32},
          {14,32}}, color={0,127,255}));
  connect(out.weaBus, weaBus) annotation (Line(
      points={{-28,38.2},{-42,38.2},{-42,38},{-62,38}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,20},{40,
            100}})),
    Icon(coordinateSystem(extent={{-60,20},{40,100}}, preserveAspectRatio=false),
        graphics),
    Documentation(info="<html>
<h4>Ventilation</h4>
<p>Take into account the ventilation airflow in a thermal zone.</p>
<p>The ventilation system is defined by an extracted airflow with : </p>
<p>mass airflow as input</p>
</html>"));
end Ventil_5;
