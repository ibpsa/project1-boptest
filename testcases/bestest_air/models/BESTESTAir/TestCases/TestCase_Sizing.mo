within BESTESTAir.TestCases;
model TestCase_Sizing "Testcase model for sizing purposes"
  extends Modelica.Icons.Example;
  replaceable package Medium1 = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Air medium";
  parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal=0.55 "Nominal air flowrate" annotation (Dialog(group="Air"));
  final parameter Modelica.SIunits.Pressure dpAir_nominal=185 "Nominal supply air pressure";
  BaseClasses.Case900FF zon(mAir_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));

  Buildings.Fluid.Sources.Boundary_pT sin(redeclare package Medium = Medium1,
                             nPorts=1) "Airflow sink"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.Constant TSupCoo(k=273.15 + 12.78)
    "Cooling air temperature"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Constant TSupHea(k=273.15 + 40)
    "Heating air temperature"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Math.Gain fanGaiCoo(k=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-48,80},{-28,100}})));
  Modelica.Blocks.Math.Gain fanGaiHea(k=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-48,50},{-28,70}})));
  BaseClasses.Thermostat con "Controller"
    annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
  Buildings.Fluid.Sources.Boundary_pT souAirCoo(
    redeclare package Medium = Medium1,
    use_T_in=true,
    nPorts=1) "Cooling air source"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Buildings.Fluid.Sources.Boundary_pT souAirHea(
    redeclare package Medium = Medium1,
    use_T_in=true,
    nPorts=1) "Heating air source"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fanCoo(
    redeclare package Medium = Medium1,
    m_flow_nominal=mAir_flow_nominal,
    addPowerToMedium=false,
    dp_nominal=dpAir_nominal)
                    "Cooling fan"
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fanHea(
    redeclare package Medium = Medium1,
    m_flow_nominal=mAir_flow_nominal,
    addPowerToMedium=false,
    dp_nominal=dpAir_nominal)
                    "Heating fan"
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium1,
    m_flow_nominal=mAir_flow_nominal,
    dp_nominal=dpAir_nominal)
    annotation (Placement(transformation(extent={{40,-8},{60,12}})));
  Modelica.Blocks.Sources.RealExpression powCooThe(y=-fanCoo.port_a.m_flow*(
        inStream(fanCoo.port_a.h_outflow) - inStream(zon.returnAir.h_outflow)))
                                                   "Cooling thermal power"
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Sources.RealExpression powHeaThe(y=fanHea.port_a.m_flow*(
        inStream(fanHea.port_a.h_outflow) - inStream(zon.returnAir.h_outflow)))
                                                   "Heating thermal power"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
equation
  connect(zon.returnAir, sin.ports[1]) annotation (Line(points={{74,-2},{40,-2},
          {40,-50},{0,-50}}, color={0,127,255}));
  connect(zon.TRooAir, con.TZon) annotation (Line(points={{101,0},{110,0},{110,-80},
          {-100,-80},{-100,80},{-90,80}}, color={0,0,127}));
  connect(con.yCooVal, fanGaiCoo.u) annotation (Line(points={{-67,88},{-58,88},{
          -58,90},{-50,90}}, color={0,0,127}));
  connect(con.yHeaVal, fanGaiHea.u) annotation (Line(points={{-67,84},{-58,84},{
          -58,60},{-50,60}}, color={0,0,127}));
  connect(TSupCoo.y, souAirCoo.T_in) annotation (Line(points={{-39,20},{-26,20},
          {-26,14},{-22,14}}, color={0,0,127}));
  connect(TSupHea.y, souAirHea.T_in) annotation (Line(points={{-39,-40},{-26,-40},
          {-26,-16},{-22,-16}}, color={0,0,127}));
  connect(fanGaiCoo.y, fanCoo.m_flow_in)
    annotation (Line(points={{-27,90},{20,90},{20,22}}, color={0,0,127}));
  connect(fanGaiHea.y, fanHea.m_flow_in) annotation (Line(points={{-27,60},{10,60},
          {10,-2},{20,-2},{20,-8}}, color={0,0,127}));
  connect(souAirCoo.ports[1], fanCoo.port_a)
    annotation (Line(points={{0,10},{10,10}}, color={0,127,255}));
  connect(souAirHea.ports[1], fanHea.port_a)
    annotation (Line(points={{0,-20},{10,-20}}, color={0,127,255}));
  connect(res.port_b, zon.supplyAir)
    annotation (Line(points={{60,2},{74,2}}, color={0,127,255}));
  connect(fanCoo.port_b, res.port_a) annotation (Line(points={{30,10},{34,10},{34,
          2},{40,2}}, color={0,127,255}));
  connect(fanHea.port_b, res.port_a) annotation (Line(points={{30,-20},{34,-20},
          {34,2},{40,2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=300,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end TestCase_Sizing;
