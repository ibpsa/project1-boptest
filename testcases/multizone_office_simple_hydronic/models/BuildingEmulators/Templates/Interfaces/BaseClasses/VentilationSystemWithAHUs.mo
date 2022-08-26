within BuildingEmulators.Templates.Interfaces.BaseClasses;
partial model VentilationSystemWithAHUs "Ventilation system with nVen AHUs"
  extends
    BuildingEmulators.Templates.Interfaces.BaseClasses.VentilationSystemWithWaterCircuit(
    nLoads=0);

  BuildingEmulators.Components.AirHandlingUnit[nVen] ahu
    annotation (Placement(transformation(extent={{-14,-30},{118,36}})));
  IDEAS.Fluid.Actuators.Valves.TwoWayPressureIndependent[nZones] vav_sup(
      each allowFlowReversal=false,
      each use_inputFilter=false,
      redeclare final package Medium = Medium,
      m_flow_nominal = m_flow_nominal_air_sup_zon,
      dpValve_nominal = dp_nominal_air_sup_zon)
    annotation (Placement(transformation(extent={{-90,-30},{-110,-10}})));
  IDEAS.Fluid.Actuators.Valves.TwoWayPressureIndependent[nZones] vav_ret(
    each allowFlowReversal=false,
    each use_inputFilter=false,
    redeclare final package Medium = Medium,
    m_flow_nominal = m_flow_nominal_air_ret_zon,
    dpValve_nominal = dp_nominal_air_ret_zon)
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_air_sup_zon[nZones]
    "Supply ventilation mass flow rate per zone";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_air_ret_zon[nZones]
    "Return ventilation mass flow rate per zone";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_air_sup_zon[nZones]
    "Supply nominal pressure drop per zone";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_air_ret_zon[nZones]
    "Return nominal pressure drop per zone";
    .Modelica.Blocks.Interfaces.RealInput prfAhuSup[nVen] annotation(Placement(transformation(extent = {{-20.0,-20.0},{20.0,20.0}},origin = {-50.0,100.0},rotation = -90.0)));
    .Modelica.Blocks.Interfaces.RealInput TSupAhuSet[nVen] annotation(Placement(transformation(extent = {{-20.0,-20.0},{20.0,20.0}},origin = {48.0,100.0},rotation = -90.0)));
    .Modelica.Blocks.Interfaces.RealInput prfAhuRet[nVen] annotation(Placement(transformation(extent = {{-20.0,-20.0},{20.0,20.0}},origin = {0.0,100.0},rotation = -90.0)));
    .Modelica.Blocks.Interfaces.BooleanInput[nVen] oveByPass annotation(Placement(transformation(extent = {{-20.0,-20.0},{20.0,20.0}},origin = {180.0,100.0},rotation = -90.0)));


equation
  connect(portCoo_a, ahu.portCoo_a) annotation (Line(points={{0,-100},{0,-60},{
          9.1,-60},{9.1,-29.34}}, color={0,127,255}));
  connect(portCoo_b, ahu.portCoo_b) annotation (Line(points={{30,-100},{30,-60},
          {22.96,-60},{22.96,-29.34}}, color={0,127,255}));
  connect(portHea_b, ahu.portHea_b) annotation (Line(points={{100,-100},{100,
          -60},{55.96,-60},{55.96,-29.34}}, color={0,127,255}));
  connect(portHea_a, ahu.portHea_a) annotation (Line(points={{70,-100},{70,-70},
          {42.1,-70},{42.1,-29.34}}, color={0,127,255}));
    connect(ahu.TSupAhuSet,TSupAhuSet) annotation(Line(points = {{47.38,36},{47.38,100},{48,100}},color = {0,0,127}));
    connect(vav_sup.port_b,port_b) annotation(Line(points = {{-110,-20},{-200,-20}},color = {0,127,255}));
    connect(vav_ret.port_a,port_a) annotation(Line(points = {{-110,20},{-200,20}},color = {0,127,255}));
    connect(ahu.prfAhuSup,prfAhuSup) annotation(Line(points = {{47.38,36},{47.38,58},{-50,58},{-50,100}},color = {0,0,127}));
    connect(ahu.prfAhuRet,prfAhuRet) annotation(Line(points = {{47.38,36},{47.38,68},{0,68},{0,100}},color = {0,0,127}));
    connect(oveByPass,ahu.oveByPass) annotation(Line(points = {{180,100},{180,68},{116.02,68},{116.02,36}},color = {255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}})),           Icon(coordinateSystem(extent={{-200,
            -100},{200,100}})),
    Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end VentilationSystemWithAHUs;
