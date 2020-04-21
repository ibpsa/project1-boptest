within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Emetteurs;
model Radiateurs_1

 package MediumW = Buildings.Media.Water "Medium model";
  parameter Real P_nominal = 4000 "Puissance nominale (en W)";
  parameter Real T_depart = 60+273.15 "Temprature de dpart (en K)";
  parameter Real T_retour = 50+273.15 "Temprature de retour (en K)";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCon annotation (
      Placement(transformation(rotation=0, extent={{-45,72},{-15,104}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRad annotation (
      Placement(transformation(rotation=0, extent={{15,72},{45,104}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = MediumW,
    Q_flow_nominal=P_nominal,
    T_a_nominal=T_depart,
    T_b_nominal=T_retour,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=333.15,
    VWat=5.8E-6*abs(rad.Q_flow_nominal),
    mDry=0.0236*abs(rad.Q_flow_nominal))
    annotation (Placement(transformation(extent={{-8,10},{12,30}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage
                                               val1(
    redeclare package Medium = MediumW,
    from_dp=true,
    m_flow_nominal=rad.m_flow_nominal,
    use_inputFilter=false,
    dpValve_nominal(displayUnit="Pa") = 1000,
    dpFixed_nominal=6000)  "Radiator valve"
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Regulation.Regul_Ch_1_bis regul_chauffage(Khea=1,
    k=k,
    Ti=Ti)
    annotation (Placement(transformation(extent={{-78,54},{-48,72}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-114,10},{-94,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{94,10},{114,30}})));
  Modelica.Blocks.Interfaces.RealInput T
    annotation (Placement(transformation(extent={{-140,16},{-100,56}}),
        iconTransformation(extent={{-132,24},{-100,56}})));
  Modelica.Blocks.Interfaces.RealInput ConsigneCh annotation (Placement(
        transformation(extent={{-140,50},{-100,90}}), iconTransformation(
          extent={{-132,58},{-100,90}})));

  Buildings.Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = MediumW,
    m_flow_nominal=rad.m_flow_nominal,
    dp_nominal=3000)
    annotation (Placement(transformation(extent={{22,10},{42,30}})));
  parameter Real k=1e-2 "Gain of controller";
  parameter Modelica.SIunits.Time Ti=1e2
    "Time constant of Integrator block";
equation
  connect(heatPortCon, rad.heatPortCon) annotation (Line(points={{-30,88},{-30,68},
          {0,68},{0,46},{0,27.2}},
                               color={191,0,0}));
  connect(rad.heatPortRad, heatPortRad) annotation (Line(points={{4,27.2},{4,27.2},
          {4,68},{30,68},{30,88}},
                               color={191,0,0}));
  connect(val1.port_b, rad.port_a) annotation (Line(points={{-30,20},{-18,20},{-8,
          20}},         color={0,127,255}));
  connect(val1.port_a, port_a)
    annotation (Line(points={{-50,20},{-76,20},{-104,20}}, color={0,127,255}));
  connect(regul_chauffage.T, T) annotation (Line(points={{-80.4,63},{-90.2,63},
          {-90.2,36},{-120,36}},       color={0,0,127}));
  connect(ConsigneCh, regul_chauffage.ConsigneCh) annotation (Line(points={{
          -120,70},{-80.4,70},{-80.4,69}}, color={0,0,127}));
  connect(regul_chauffage.yHea, val1.y) annotation (Line(points={{-45,63},
          {-40,63},{-40,32}}, color={0,0,127}));
  connect(rad.port_b, res1.port_a)
    annotation (Line(points={{12,20},{22,20}}, color={0,127,255}));
  connect(res1.port_b, port_b)
    annotation (Line(points={{42,20},{104,20}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,0},{100,80}})),
    Icon(coordinateSystem(extent={{-100,0},{100,80}})),
    Documentation(info="<html>
<p>Ce bloc mod&eacute;lise un radiateur qui &agrave; partir d&apos;une circulation d&apos;un fluide permet de frounir de la chaleur (radiative heatPortCon et convective <i>heatPortCon</i>).</p>
<p>On utilise une vanne en entr&eacute;e du radiateur pour r&eacute;guler la temp&eacute;rature de la pi&egrave;ce (<i>T</i>) sur une consigne voulue (<i>ConsigneCh</i>).</p>
</html>"));
end Radiateurs_1;
