within OU44Emulator.Models.SubModels;
model DistrictHeating
    replaceable package Water = Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium;
    Buildings.Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU
                                                         dhHX(
      redeclare package Medium1 = Water,
      redeclare package Medium2 = Water,
      m1_flow_nominal=m_flow_nominal,
    dp1_nominal=15000,
    dp2_nominal=20000,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    linearizeFlowResistance1=true,
    linearizeFlowResistance2=true,
    m2_flow_nominal=m_flow_nominal_dh,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    Q_flow_nominal=-m_flow_nominal*4.2*20*1000,
    T_a1_nominal=308.15,
    T_a2_nominal=338.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    Modelica.Blocks.Interfaces.RealOutput qdh "District heating power [W]"
      annotation (Placement(transformation(extent={{98,-60},{118,-40}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort tDHRe(redeclare package Medium =
          Water,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal_dh)
      annotation (Placement(transformation(extent={{-26,-16},{-46,4}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort tSu(redeclare package Medium =
          Water, m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)
      annotation (Placement(transformation(extent={{34,-4},{54,16}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Water)
      annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Water)
      annotation (Placement(transformation(extent={{50,90},{70,110}})));
    Buildings.Fluid.Movers.FlowControlled_dp pmp2(
      redeclare package Medium = Water,
    m_flow_nominal=m_flow_nominal,
      addPowerToMedium=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    allowFlowReversal=false,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per(
        pressure(V_flow={0,0.00209948320413,0.00303617571059,0.00389750215332,
            0.0046188630491,0.00546942291128,0.00621231696813,
            0.00695521102498,0.00755813953488}, dp={74298.6885246,
            74154.3248189,73404.0823485,70722.2584827,66879.2916508,
            59372.6282882,49547.6683187,37985.8558902,27964.6709874}), power(
          V_flow={0,0.00209948320413,0.00303617571059,0.00389750215332,
            0.0046188630491,0.00546942291128,0.00621231696813,
            0.00695521102498,0.00755813953488}, P={205.291823945,
            337.504763698,400.584905585,453.68913657,488.040727585,
            515.872422868,528.307902115,531.276246541,523.90128749})),
    dp_nominal=50000,
    prescribeSystemPressure=true)
                                annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-42,38})));
    Modelica.Blocks.Interfaces.RealInput y "Normalized pump speed (indoor loop)"
      annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
    Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSu(redeclare package Medium =
          Water, m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)                    annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={60,38})));
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
    Buildings.Fluid.Sensors.MassFlowRate senMasFloSu(redeclare package Medium =
          Water, allowFlowReversal=false)
                 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={60,62})));
    Modelica.Blocks.Interfaces.RealOutput qel
      "Circulation pump electricity consumption [W]"
      annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Buildings.Fluid.Storage.ExpansionVessel expSec(redeclare package Medium =
        Water, V_start=0.025)
    annotation (Placement(transformation(extent={{-94,18},{-74,38}})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium =
        Buildings.Media.Water)
    annotation (Placement(transformation(extent={{10,72},{-10,92}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Buildings.Media.Water,
    use_m_flow_in=true,
    use_T_in=false,
    T=338.15,
    nPorts=1) annotation (Placement(transformation(extent={{32,-98},{12,-78}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Buildings.Media.Water,
    p=480000,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-98},{-76,-78}})));
  EnergyMeter energyMeter annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  Buildings.Controls.SetPoints.Table dhTsupCur(table=[273.15 - 20,273.15 + 55;
        273.15 + 10,273.15 + 35]) "District heating temperature supply curve"
    annotation (Placement(transformation(extent={{118,-82},{98,-62}})));
  Buildings.Controls.Continuous.LimPID conPIDdh(
    Ti=600,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    yMax=1) annotation (Placement(transformation(extent={{76,-64},{60,-80}})));
  Modelica.Blocks.Math.Gain gain(k=m_flow_nominal_dh)
    annotation (Placement(transformation(extent={{52,-86},{40,-74}})));
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
equation
    connect(dhHX.port_b2, tDHRe.port_a)
      annotation (Line(points={{-10,-6},{-26,-6}}, color={0,127,255}));
    connect(tSu.port_a, dhHX.port_b1)
      annotation (Line(points={{34,6},{10,6}}, color={0,127,255}));
    connect(pmp2.port_b, dhHX.port_a1) annotation (Line(points={{-32,38},{-24,38},
            {-24,6},{-10,6}}, color={0,127,255}));
    connect(tSu.port_b, senVolFloSu.port_a)
      annotation (Line(points={{54,6},{60,6},{60,28}}, color={0,127,255}));
    connect(port_a, tRe.port_a)
      annotation (Line(points={{-60,100},{-60,74}}, color={0,127,255}));
    connect(tRe.port_b, pmp2.port_a)
      annotation (Line(points={{-60,54},{-60,38},{-52,38}}, color={0,127,255}));
    connect(senVolFloSu.port_b, senMasFloSu.port_a)
      annotation (Line(points={{60,48},{60,52}}, color={0,127,255}));
    connect(senMasFloSu.port_b, port_b)
      annotation (Line(points={{60,72},{60,100}}, color={0,127,255}));
    connect(pmp2.P, qel) annotation (Line(points={{-31,47},{-11.5,47},{-11.5,60},
            {106,60}}, color={0,0,127}));
  connect(expSec.port_a, pmp2.port_a) annotation (Line(points={{-84,18},{-84,12},
          {-62,12},{-62,38},{-52,38}}, color={0,127,255}));
  connect(pmp2.dp_in, y) annotation (Line(points={{-42,50},{-42,58},{-84,58},
          {-84,60},{-110,60}}, color={0,0,127}));
  connect(senRelPre.p_rel, pmp2.dpMea) annotation (Line(points={{0,73},{0,68},
          {-20,68},{-20,58},{-50,58},{-50,50}}, color={0,0,127}));
  connect(senRelPre.port_a, senMasFloSu.port_b)
    annotation (Line(points={{10,82},{60,82},{60,72}}, color={0,127,255}));
  connect(senRelPre.port_b, tRe.port_a) annotation (Line(points={{-10,82},{
          -60,82},{-60,74}}, color={0,127,255}));
  connect(boundary.ports[1], energyMeter.port_a)
    annotation (Line(points={{12,-88},{6,-88},{6,-60}}, color={0,127,255}));
  connect(energyMeter.port_b, dhHX.port_a2) annotation (Line(points={{6,-40},{
          60,-40},{60,-6},{10,-6}}, color={0,127,255}));
  connect(tDHRe.port_b, energyMeter.port_a2) annotation (Line(points={{-46,-6},
          {-60,-6},{-60,-40},{-6,-40}}, color={0,127,255}));
  connect(energyMeter.port_b2, bou1.ports[1]) annotation (Line(points={{-6,-60},
          {-60,-60},{-60,-88},{-76,-88}}, color={0,127,255}));
  connect(energyMeter.q, qdh)
    annotation (Line(points={{-10.6,-50},{108,-50}}, color={0,0,127}));
  connect(tSu.T, conPIDdh.u_m) annotation (Line(points={{44,17},{44,22},{68,22},
          {68,-62.4}},            color={0,0,127}));
  connect(conPIDdh.y, gain.u)
    annotation (Line(points={{59.2,-72},{56,-72},{56,-80},{53.2,-80}},
                                                   color={0,0,127}));
  connect(gain.y, boundary.m_flow_in)
    annotation (Line(points={{39.4,-80},{34,-80}},        color={0,0,127}));
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
  connect(oveTSupSetHea.y, conPIDdh.u_s) annotation (Line(points={{81.5,-73},{79.55,
          -73},{79.55,-72},{77.6,-72}}, color={0,0,127}));
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
end DistrictHeating;
