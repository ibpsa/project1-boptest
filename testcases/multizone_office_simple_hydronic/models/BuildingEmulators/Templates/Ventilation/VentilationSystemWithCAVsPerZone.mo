within BuildingEmulators.Templates.Ventilation;
model VentilationSystemWithCAVsPerZone "Model of AirHandlingUnits per zone, with lumped pressure drops"
  extends
    BuildingEmulators.Templates.Interfaces.BaseClasses.VentilationSystemWithCAVs(
    final nVen=nZones,
    ahu(
      m_flow_nominal_air_sup=m_flow_nominal_air_sup,
      each dp_nominal_air_sup=0,
      hp_nominal_air_sup=dp_nominal_air_sup,
      m_flow_nominal_air_ret=m_flow_nominal_air_ret,
      each dp_nominal_air_ret=0,
      hp_nominal_air_ret=dp_nominal_air_ret),
    m_flow_nominal_air_sup_zon=m_flow_nominal_air_sup,
    dp_nominal_air_sup_zon=dp_nominal_air_sup,
    m_flow_nominal_air_ret_zon=m_flow_nominal_air_ret,
    dp_nominal_air_ret_zon=dp_nominal_air_ret,
    vav_ret(m_flow_nominal=m_flow_nominal_air_ret, dpValve_nominal=dp_nominal_air_ret),
    vav_sup(m_flow_nominal=m_flow_nominal_air_sup, dpValve_nominal=dp_nominal_air_sup));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_air_sup[nZones]
    "Supply ventilation mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_air_ret[nZones]
    "Return ventilation mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_air_sup[nZones]
    "Supply nominal pressure drop";
  parameter Modelica.Units.SI.PressureDifference dp_nominal_air_ret[nZones]
    "Return nominal pressure drop";
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TExhAhu annotation(Placement(visible = true,transformation(origin = {138.8,110.0},extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 90.0),iconTransformation(origin = {190,110},extent = {{-10,-10},{10,10}},rotation = 90)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TRetAhu annotation(Placement(visible = true,transformation(origin = {-49.2,110.0},extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 90.0),iconTransformation(origin = {-180,110},extent = {{-10,-10},{10,10}},rotation = 90)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TSupAhu annotation(Placement(visible = true,transformation(origin = {-87.19999999999999,110.0},extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 90.0),iconTransformation(origin = {-180,-110},extent = {{-10,-10},{10,10}},rotation = 270)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TRecAhu annotation(Placement(visible = true,transformation(origin = {140.0,-110.0},extent = {{-10.0,10.0},{10.0,-10.0}},rotation = -90.0),iconTransformation(origin = {92,-110},extent = {{-10,-10},{10,10}},rotation = 270)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TAhuIn annotation(Placement(visible = true,transformation(origin = {180.0,-110.0},extent = {{10.0,-10.0},{-10.0,10.0}},rotation = 90.0),iconTransformation(origin = {188,-110},extent = {{-10,-10},{10,10}},rotation = 270)));
equation

  for i in 1:nZones loop
      connect(vav_ret[i].port_b, ahu[i].port_b) annotation (Line(points={{-90,20},{-20,20},
          {-20,8.94},{-13.34,8.94}}, color={0,127,255}));
      connect(vav_sup[i].port_a, ahu[i].port_a) annotation (Line(points={{-90,-20},{-20,-20},
          {-20,-2.94},{-14.66,-2.94}}, color={0,127,255}));
    end for;
    connect(ahu.TRetAhu,TRetAhu) annotation(Line(points = {{-7.400000000000006,39.3},{-7.400000000000006,74.65},{-49.2,74.65},{-49.2,110}},color = {0,0,127}));
    connect(ahu.TSupAhu,TSupAhu) annotation(Line(points = {{-7.400000000000006,-33.3},{-7.400000000000006,-40},{-60,-40},{-60,80},{-87.19999999999999,80},{-87.19999999999999,110}},color = {0,0,127}));
    connect(ahu.TExhAhu,TExhAhu) annotation(Line(points = {{114.7,39.3},{114.7,74.65},{138.8,74.65},{138.8,110}},color = {0,0,127}));
    connect(ahu.TInAhu,TAhuIn) annotation(Line(points = {{114.04,-33.3},{114.04,-71.65},{180,-71.65},{180,-110}},color = {0,0,127}));
    connect(ahu.TRecAhu,TRecAhu) annotation(Line(points = {{82.36,-33.3},{82.36,-82},{140,-82},{140,-110}},color = {0,0,127}));
end VentilationSystemWithCAVsPerZone;
