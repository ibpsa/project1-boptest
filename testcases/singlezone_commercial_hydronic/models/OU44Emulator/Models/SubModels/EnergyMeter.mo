within OU44Emulator.Models.SubModels;
model EnergyMeter
    replaceable package Water = Buildings.Media.Water;
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemRe(m_flow_nominal=
          m_flow_nominal, redeclare package Medium = Water,
    allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-60,50},{-80,70}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemSu(redeclare package
      Medium =   Water, m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloSu(redeclare package Medium =
          Water, allowFlowReversal=false)
      annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Water) "Supply fluid inlet port"
      annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Water) "Supply fluid outlet port"
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
          Water) "Return fluid inlet port"
      annotation (Placement(transformation(extent={{90,50},{110,70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
          Water) "Return fluid outlet port"
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.1
      "Nominal mass flow rate, used for regularization near zero flow";
    Modelica.Blocks.Math.Add add(k1=-1, k2=1)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=Water.cp_const)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
      annotation (Placement(transformation(extent={{10,-6},{22,6}})));
    Modelica.Blocks.Interfaces.RealOutput q
      "Heat flow [W] (positive for supply fluid hotter than return)"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,106})));
equation
    connect(port_a, senTemSu.port_a)
      annotation (Line(points={{-100,-60},{-80,-60}}, color={0,127,255}));
    connect(senTemSu.port_b, senMasFloSu.port_a)
      annotation (Line(points={{-60,-60},{40,-60}}, color={0,127,255}));
    connect(senMasFloSu.port_b, port_b)
      annotation (Line(points={{60,-60},{100,-60}}, color={0,127,255}));
    connect(senTemRe.port_a, port_a2)
      annotation (Line(points={{-60,60},{100,60}}, color={0,127,255}));
    connect(senTemRe.port_b, port_b2)
      annotation (Line(points={{-80,60},{-100,60}}, color={0,127,255}));
    connect(senTemRe.T, add.u1) annotation (Line(points={{-70,71},{-48,71},{-48,
            6},{-42,6}}, color={0,0,127}));
    connect(senTemSu.T, add.u2)
      annotation (Line(points={{-70,-49},{-70,-6},{-42,-6}}, color={0,0,127}));
    connect(realExpression.y, multiProduct.u[1]) annotation (Line(points={{-19,30},
          {-4,30},{-4,-1.4},{10,-1.4}},     color={0,0,127}));
    connect(add.y, multiProduct.u[2]) annotation (Line(points={{-19,0},{6,0},{6,
            2.22045e-16},{10,2.22045e-16}}, color={0,0,127}));
    connect(senMasFloSu.m_flow, multiProduct.u[3]) annotation (Line(points={{50,-49},
          {-4,-49},{-4,1.4},{10,1.4}},          color={0,0,127}));
    connect(multiProduct.y, q) annotation (Line(points={{23.02,0},{40,0},{40,80},
            {0,80},{0,106}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-90,-60},{90,-60}},
            color={238,46,47},
            thickness=0.5),
          Line(
            points={{90,60},{-90,60}},
            color={28,108,200},
            thickness=0.5),
          Line(points={{0,-60},{0,96}}, color={0,0,0}),
          Ellipse(
            extent={{-20,20},{20,-20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{10,10},{-10,-12}}, color={0,0,0}),
          Line(points={{10,10},{8,4}}, color={0,0,0}),
          Line(points={{10,10},{4,8}}, color={0,0,0})}),           Diagram(
          coordinateSystem(preserveAspectRatio=false)));
end EnergyMeter;
