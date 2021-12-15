within MultiZoneResidentialHydronic.Building.Equipement.Heating;
model Boiler

  replaceable package MediumW =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  // Boiler specifications
  parameter Modelica.SIunits.Power Q_flow_nominal "Nominal heating power";
  parameter Modelica.SIunits.Temperature T_nominal=353.15
    "Temperature used to compute nominal efficiency (only used if efficiency curve depends on temperature)";
  parameter Buildings.Fluid.Types.EfficiencyCurves effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant
    "Curve used to compute the efficiency";
  parameter Real a[:] = {0.9} "Coefficients for efficiency curve";
  parameter Buildings.Fluid.Data.Fuels.Generic fue "Fuel type"
   annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.ThermalConductance UA=0.05*Q_flow_nominal/30
    "Overall UA value";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.PressureDifference dp_nominal = 0
    "Pressure difference"
    annotation(Dialog(group = "Nominal condition"));
 parameter Modelica.SIunits.Power ConsoElec_Ventilateur = 25 "Boiler fan electic power " annotation(Dialog(group = "Boiler characteristics"));
 parameter Modelica.SIunits.Power ConsoElec_VannesGaz = 7 "Gas valvez electric power" annotation(Dialog(group = "Boiler characteristics"));
 parameter Modelica.SIunits.Power[5,2] ConsoElec_PompeCirculation = [0,0;7/60,0;9.65/60,63;11.35/60,105;12/60,105] "Heating pump electric power" annotation(Dialog(group = "Boiler characteristics"));
 parameter Modelica.SIunits.Power ConsoElec_PompeECS = 45 "DHW Pump electric power" annotation(Dialog(group = "Boiler characteristics"));
 parameter Modelica.SIunits.Power ConsoElec_Veille = 4 "Standby electric power" annotation(Dialog(group = "Boiler characteristics"));

parameter Modelica.SIunits.Volume VWat=1.5E-6*chaudiere.Q_flow_nominal
    "Water volume of boiler";

//  Modelica.SIunits.Power QFue_flow "Heat released by fuel";
//  Modelica.SIunits.Power QWat_flow "Heat transfer from gas into water";
  Modelica.SIunits.Efficiency eta "Boiler efficiency";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare final package Medium =
        MediumW) annotation (Placement(transformation(rotation=0, extent={{-94,-10},
            {-114,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare final package Medium =
        MediumW)
    annotation (Placement(transformation(rotation=0, extent={{92,-10},{112,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port, can be used to connect to ambient"
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,60},{10,80}})));
  Buildings.Fluid.Boilers.BoilerPolynomial chaudiere(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    T_nominal=T_nominal,
    effCur=effCur,
    a=a,
    fue=fue,
    UA=UA,
    VWat=VWat,
    Q_flow_nominal=Q_flow_nominal)
           annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Blocks.Interfaces.RealInput y "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{-140,36},{-100,76}}),
        iconTransformation(extent={{-140,36},{-100,76}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{-86,10},{-66,-10}})));

  Modelica.Blocks.Interfaces.RealOutput T annotation (Placement(
        transformation(extent={{100,38},{136,74}}),iconTransformation(
          extent={{100,38},{136,74}})));
  Modelica.Blocks.Interfaces.BooleanInput Mode_ECS
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-106},{-100,-66}})));
  Modelica.Blocks.Interfaces.RealInput m_PompeCirc
    "Connector of Real input signals"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal3(realTrue=ConsoElec_PompeECS,
      realFalse=0)
    annotation (Placement(transformation(extent={{4,-94},{24,-74}})));
  Modelica.Blocks.Logical.GreaterThreshold ONOFFChaudiere(threshold=0)
    annotation (Placement(transformation(extent={{-24,-42},{-4,-22}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal4(realFalse=0, realTrue=
        ConsoElec_Ventilateur + ConsoElec_VannesGaz)
    annotation (Placement(transformation(extent={{4,-42},{24,-22}})));
  Modelica.Blocks.Sources.RealExpression Tmeas4(y=ConsoElec_Veille)
    annotation (Placement(transformation(extent={{-24,-110},{-10,-94}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=
        ConsoElec_PompeCirculation, columns={2})
    annotation (Placement(transformation(extent={{4,-70},{24,-50}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{38,-68},{50,-56}})));
  Modelica.Blocks.Interfaces.RealOutput consoElec_ch
    annotation (Placement(transformation(extent={{100,-82},{140,-42}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPpum(KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    description="Boiler pump electrical power use",
    y(unit="W"))
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveBoi(description=
        "Boiler control signal for part load ratio",
      u(
      min=0,
      max=1,
      unit="1"))
    annotation (Placement(transformation(extent={{-60,46},{-40,66}})));
  Modelica.Blocks.Sources.RealExpression QWat_flow(y=chaudiere.QFue_flow)
    annotation (Placement(transformation(extent={{16,80},{62,100}})));
  Buildings.Utilities.IO.SignalExchange.Read reaGasBoi(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Boiler gas power use",
    y(unit="W"))
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  Buildings.Fluid.Sensors.TemperatureTwoPort T_depart(redeclare package Medium
      = MediumW, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,0})));
  Buildings.Fluid.Sensors.TemperatureTwoPort T_retour(redeclare package Medium
      = MediumW, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,0})));
equation

//  QFue_flow = chaudiere.QFue_flow;
//  QWat_flow = chaudiere.QWat_flow;
  eta = chaudiere.eta;

  connect(chaudiere.heatPort, heatPort)
    annotation (Line(points={{0,7.2},{0,100}},color={191,0,0}));
  connect(massFlowRate.port_a, port_a)
    annotation (Line(points={{-86,0},{-104,0}},          color={0,127,255}));
  connect(chaudiere.T, T) annotation (Line(points={{11,8},{20,8},{20,56},{118,
          56}},    color={0,0,127}));
  connect(ONOFFChaudiere.y,booleanToReal4. u) annotation (Line(points={{-3,-32},
          {2,-32}},               color={255,0,255}));
  connect(booleanToReal4.y,multiSum. u[1]) annotation (Line(points={{25,-32},{28,
          -32},{28,-58.85},{38,-58.85}},
                                      color={0,0,127}));
  connect(combiTable1D.y,multiSum. u[2:2])
    annotation (Line(points={{25,-60},{38,-60},{38,-60.95}},
                                                          color={0,0,127}));
  connect(booleanToReal3.y,multiSum. u[3]) annotation (Line(points={{25,-84},{30,
          -84},{30,-63.05},{38,-63.05}}, color={0,0,127}));
  connect(Tmeas4.y,multiSum. u[4]) annotation (Line(points={{-9.3,-102},{32,-102},
          {32,-65.15},{38,-65.15}}, color={0,0,127}));
  connect(multiSum.y, consoElec_ch)
    annotation (Line(points={{51.02,-62},{120,-62}},color={0,0,127}));
  connect(massFlowRate.m_flow, ONOFFChaudiere.u)
    annotation (Line(points={{-76,-11},{-76,-32},{-26,-32}}, color={0,0,127}));
  connect(m_PompeCirc, combiTable1D.u[1]) annotation (Line(points={{-120,-50},{-60,
          -50},{-60,-60},{2,-60}}, color={0,0,127}));
  connect(Mode_ECS, booleanToReal3.u) annotation (Line(points={{-120,-86},{-60,-86},
          {-60,-84},{2,-84}}, color={255,0,255}));
  connect(multiSum.y,reaPpum. u) annotation (Line(points={{51.02,-62},{58,-62},
          {58,-30},{78,-30}},  color={0,0,127}));
  connect(y, oveBoi.u)
    annotation (Line(points={{-120,56},{-62,56}},  color={0,0,127}));
  connect(QWat_flow.y,reaGasBoi. u)
    annotation (Line(points={{64.3,90},{78,90}}, color={0,0,127}));
  connect(oveBoi.y, chaudiere.y) annotation (Line(points={{-39,56},{-20,56},{
          -20,8},{-12,8}}, color={0,0,127}));
  connect(chaudiere.port_b, T_depart.port_a)
    annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
  connect(T_depart.port_b, port_b)
    annotation (Line(points={{60,0},{102,0}}, color={0,127,255}));
  connect(massFlowRate.port_b, T_retour.port_a)
    annotation (Line(points={{-66,0},{-50,0}}, color={0,127,255}));
  connect(T_retour.port_b, chaudiere.port_a)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-100,-120},{100,100}})),
                                                                     Icon(
        coordinateSystem(extent={{-100,-120},{100,100}}),
                                                        graphics={
        Rectangle(
          extent={{-70,58},{70,-62}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-101,4},{100,-6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-6},{100,4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,20},{20,-22}},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,-36},{-12,-54},{14,-54},{0,-36}},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Text(
          extent={{-147,-98},{153,-138}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<h4>Equipement</h4>
<p>Boiler model</p>
</html>"));
end Boiler;
