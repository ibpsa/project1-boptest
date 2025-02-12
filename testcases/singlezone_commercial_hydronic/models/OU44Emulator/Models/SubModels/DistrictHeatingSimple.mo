within OU44Emulator.Models.SubModels;
model DistrictHeatingSimple
    replaceable package Water = Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium;

    Modelica.Blocks.Interfaces.RealOutput qdh "District heating power [W]"
      annotation (Placement(transformation(extent={{98,-60},{118,-40}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Water)
      annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Water)
      annotation (Placement(transformation(extent={{50,90},{70,110}})));
    Modelica.Blocks.Interfaces.RealInput y "Normalized pump speed (indoor loop)"
      annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=2
      "Nominal mass flow rate";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_dh=5
      "Nominal mass flow rate";
    Buildings.Fluid.Sensors.TemperatureTwoPort tRe(redeclare package Medium =
          Water, m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)                    annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-60,64})));
    Modelica.Blocks.Interfaces.RealOutput qel
      "Circulation pump electricity consumption [W]"
      annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Buildings.Fluid.Sources.Boundary_pT      boundary(
    redeclare package Medium = Buildings.Media.Water,
    use_p_in=true,
    use_T_in=true,
    T=338.15,
    nPorts=1) annotation (Placement(transformation(extent={{44,-68},{24,-48}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Buildings.Media.Water,
    p=300000,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-88,-68},{-68,-48}})));
  EnergyMeter energyMeter annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={4,0})));
  Buildings.Controls.SetPoints.Table dhTsupCur(table=[273.15 - 20,273.15 + 55;
        273.15 + 10,273.15 + 35]) "District heating temperature supply curve"
    annotation (Placement(transformation(extent={{118,-82},{98,-62}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{70,68},{110,108}}), iconTransformation(extent={
            {76,80},{96,100}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSupSetHea(description="Supply temperature set point for heating",
      u(
      unit="K",
      min=273.15 + 10,
      max=273.15 + 60))
    "Overwrite for supply temperature set point for heating" annotation (
      Placement(transformation(
        extent={{-5,5},{5,-5}},
        rotation=180,
        origin={87,-73})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{58,50},{78,70}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Modelica.Blocks.Sources.Constant const1(k=300000)
    annotation (Placement(transformation(extent={{22,14},{42,34}})));
equation
    connect(port_a, tRe.port_a)
      annotation (Line(points={{-60,100},{-60,74}}, color={0,127,255}));
  connect(boundary.ports[1], energyMeter.port_a)
    annotation (Line(points={{24,-58},{10,-58},{10,-10}},
                                                        color={0,127,255}));
  connect(energyMeter.port_b2, bou1.ports[1]) annotation (Line(points={{-2,-10},
          {-2,-58},{-68,-58}},            color={0,127,255}));
  connect(energyMeter.q, qdh)
    annotation (Line(points={{-6.6,6.66134e-16},{-10,6.66134e-16},{-10,14},{28,
          14},{28,-10},{94,-10},{94,-50},{108,-50}}, color={0,0,127}));
  connect(weaBus.TDryBul, dhTsupCur.u) annotation (Line(
      points={{90,88},{120,88},{120,-72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(dhTsupCur.y, oveTSupSetHea.u) annotation (Line(points={{97,-72},{95,-72},
          {95,-73},{93,-73}}, color={0,0,127}));
  connect(oveTSupSetHea.y, boundary.T_in) annotation (Line(points={{81.5,-73},{
          54,-73},{54,-54},{46,-54}}, color={0,0,127}));
  connect(const.y, qel)
    annotation (Line(points={{79,60},{106,60}}, color={0,0,127}));
  connect(energyMeter.port_b, port_b) annotation (Line(points={{10,10},{10,86},
          {60,86},{60,100}}, color={0,127,255}));
  connect(energyMeter.port_a2, tRe.port_b) annotation (Line(points={{-2,10},{0,
          10},{0,48},{-60,48},{-60,54}}, color={0,127,255}));
  connect(y, add.u1) annotation (Line(points={{-110,60},{-76,60},{-76,50},{50,
          50},{50,36},{58,36}}, color={0,0,127}));
  connect(add.y, boundary.p_in) annotation (Line(points={{81,30},{86,30},{86,
          -50},{46,-50}}, color={0,0,127}));
  connect(add.u2, const1.y)
    annotation (Line(points={{58,24},{43,24}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-20,20},{20,-20}},
            lineColor={238,46,47},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Line(points={{18,-4}}, color={28,108,200}),
          Line(points={{20,0},{60,0},{60,90}}, color={238,46,47}),
          Ellipse(extent={{-74,74},{-46,46}}, lineColor={28,108,200}),
          Line(points={{-60,46},{-72,68},{-48,68},{-60,46}}, color={28,108,200}),
          Line(points={{-60,90},{-60,74}}, color={28,108,200}),
          Line(points={{-60,46},{-60,0},{-20,0}}, color={28,108,200}),
          Line(
            points={{0,-20},{0,-60},{96,-60}},
            color={238,46,47},
            pattern=LinePattern.Dash),
          Line(points={{-90,60},{-74,60}}, color={0,0,0})}),       Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=259200),
      __Dymola_experimentSetupOutput);
end DistrictHeatingSimple;
