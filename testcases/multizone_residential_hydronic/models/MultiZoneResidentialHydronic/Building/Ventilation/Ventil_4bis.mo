within MultiZoneResidentialHydronic.Building.Ventilation;
model Ventil_4bis

  parameter Modelica.SIunits.MassFlowRate Q = 1
    "Debit du a la permeabilite";

  Buildings.Fluid.Sources.MassFlowSource_T sinInf_ventilation(
    m_flow=1,
    use_m_flow_in=true,
    use_X_in=false,
    use_C_in=false,
    nPorts=1,
    use_T_in=true,
    redeclare package Medium = MediumA,
    T=293.15) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{8,64},{22,78}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports2[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,44},{46,70}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-72,28},{-52,48}}), iconTransformation(extent={
            {-80,24},{-60,44}})));
  Modelica.Blocks.Sources.Constant Ventil_permeabilite(k=Q)
                    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-16,80},{-12,84}})));
  Buildings.Fluid.Sources.Outside     bou(
    nPorts=1,
    redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{6,28},{18,40}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports1[1](redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{38,20},{46,46}})));
equation
  connect(sinInf_ventilation.ports[1:1], ports2) annotation (Line(
      points={{22,71},{32,71},{32,57},{42,57}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(weaBus.TDryBul, sinInf_ventilation.T_in) annotation (Line(
      points={{-62,38},{-20,38},{-20,73.8},{6.6,73.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(Ventil_permeabilite.y, sinInf_ventilation.m_flow_in) annotation (Line(
        points={{-11.8,82},{-4,82},{-4,76.6},{6.6,76.6}},
                                                        color={0,0,127}));
  connect(bou.ports[1:1], ports1)
    annotation (Line(points={{18,34},{42,34},{42,33}}, color={0,127,255}));
  connect(weaBus, bou.weaBus) annotation (Line(
      points={{-62,38},{-8,38},{-8,34.12},{6,34.12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,20},{40,
            100}})),
    Icon(coordinateSystem(extent={{-60,20},{40,100}}, preserveAspectRatio=false),
        graphics),
    Documentation(info="<html>
<h4>Ventilation</h4>
<p>Take into account the ventilation airflow in a thermal zone.</p>
<p>The ventilation system is defined by an airflow with : </p>
<ul>
<li>mass airflow as input</li>
<li>a temperature (in this case the outdoor temperature)</li>
</ul>
</html>"));
end Ventil_4bis;
