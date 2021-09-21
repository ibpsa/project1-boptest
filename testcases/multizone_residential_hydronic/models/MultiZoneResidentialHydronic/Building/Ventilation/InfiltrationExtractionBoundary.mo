within MultiZoneResidentialHydronic.Building.Ventilation;
model InfiltrationExtractionBoundary
  "Infiltraction or extraction model set at outside boundary condition data"
  extends InfiltrationExtraction(nPorts=3);
  Buildings.Fluid.Sources.Outside     bou(
    use_C_in=true,                        nPorts=1, redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_a bouPort(redeclare package Medium =
        MediumA) "Boundary condition port" annotation (Placement(transformation(
          extent={{50,-60},{70,-40}}), iconTransformation));
equation
  connect(bou.ports[1], bouPort)
    annotation (Line(points={{20,-50},{60,-50}}, color={0,127,255}));
  connect(bouPort, ports_b[3]) annotation (Line(points={{60,-50},{90,-50},{90,
          -26.6667}}, color={0,127,255}));
  connect(bou.weaBus, weaBus) annotation (Line(
      points={{0,-49.8},{-60,-49.8},{-60,0},{-100,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conCO2Out.y, bou.C_in[1]) annotation (Line(points={{-79,-30},{-40,-30},
          {-40,-58},{-2,-58}}, color={0,0,127}));
  annotation (Documentation(info="<html>
Models air infiltration or extraction and sets Medium to have boundary conditions.
</html>"));
end InfiltrationExtractionBoundary;
