within IDEAS.Airflow.AHU.BaseClasses;
model SimpleCompressorInterface "Interface for a simple compressor"
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b "Latent heat"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloEva(final
      alpha=0) "Prescribed heat flow rate at evaporator side"
    annotation (Placement(transformation(extent={{-62,-10},{-82,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloCon(final
      alpha=0) "Prescribed heat flow at condensor side"
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  Modelica.Blocks.Sources.RealExpression Qh_exp
                           "Real expression for heating power"
    annotation (Placement(transformation(extent={{0,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression Qc_exp
    "Realexpression for cooling power"
    annotation (Placement(transformation(extent={{0,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealOutput P "Electricity consumption" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,102}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,98})));
  Modelica.Blocks.Sources.RealExpression P_exp
                                    "Real expression for power consumption"
    annotation (Placement(transformation(extent={{-60,14},{-2,34}})));
  Modelica.Blocks.Interfaces.BooleanInput on "True if compressor is on"
    annotation (Placement(transformation(extent={{-126,30},{-86,70}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-32,90})));
  Modelica.Blocks.Interfaces.RealInput mod annotation (Placement(transformation(
          extent={{-126,-80},{-86,-40}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-84,90})));
  Modelica.Blocks.Interfaces.RealInput TinEva
    "Evaporator air inlet temperature" annotation (Placement(transformation(
          extent={{-126,-110},{-86,-70}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={20,88})));
  Modelica.Blocks.Interfaces.RealOutput Teva
    "Evaporator refrigerant temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,102}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,98})));

equation
  connect(port_a, preHeaFloEva.port) annotation (Line(
      points={{-100,0},{-82,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_b, preHeaFloCon.port) annotation (Line(
      points={{100,0},{82,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(P_exp.y, P)
    annotation (Line(points={{0.9,24},{0,24},{0,102}},  color={0,0,127}));
  connect(Qh_exp.y, preHeaFloCon.Q_flow)
    annotation (Line(points={{42,0},{48,0},{62,0}}, color={0,0,127}));
  connect(Qc_exp.y, preHeaFloEva.Q_flow)
    annotation (Line(points={{-42,0},{-42,0},{-62,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-38,46},{-38,-46},{60,0},{-38,46}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li>
April 27, 2017, by Filip Jorissen:<br/>
First implementation.
See <a href=https://github.com/open-ideas/IDEAS/issues/719>#719</a>.
</li>
</ul>
</html>"));
end SimpleCompressorInterface;
