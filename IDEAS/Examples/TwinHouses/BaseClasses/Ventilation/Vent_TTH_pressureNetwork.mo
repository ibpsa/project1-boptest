within IDEAS.Examples.TwinHouses.BaseClasses.Ventilation;
model Vent_TTH_pressureNetwork
  "Ventilation based on measured supply/exhaust rates and temperatures assuming a pressure network is present in the structure"
  extends IDEAS.Templates.Interfaces.BaseClasses.VentilationSystem(nLoads=0,nZones=7);
  final parameter String filename = if exp==1 and bui== 1 then "BCTwinHouseN2Exp1.txt" elseif exp==2 and bui==1 then "BCTwinHouseN2Exp2.txt" else "BCTwinHouseO5.txt"
    annotation(Evaluate=true);
  parameter Integer exp = 1 "Experiment number: 1 or 2";
  parameter Integer bui = 1 "Building number 1 (N2), 2 (O5)";

  final parameter String dirPath = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/measurements/")
    annotation(Evaluate=true);

  Modelica.Blocks.Sources.CombiTimeTable measuredInput(
    tableOnFile=true,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    columns={4,5},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    fileName=dirPath+filename,
    tableName="data")
    annotation (Placement(transformation(extent={{38,-38},{24,-24}})));

  IDEAS.Fluid.Sources.MassFlowSource_T Supply[1](
    redeclare package Medium = Medium,
    each use_m_flow_in=true,
    each final nPorts=1,
    each use_T_in=true)
    annotation (Placement(transformation(extent={{-80,-42},{-100,-22}})));
  Fluid.Sources.MassFlowSource_T bou[5](
    each m_flow=0,
    each final nPorts=1,
    redeclare each package Medium = Medium)
    annotation (Placement(transformation(extent={{-78,62},{-100,80}})));
  Modelica.Blocks.Math.Gain massflowInput(k=1.205/3600)
    annotation (Placement(transformation(extent={{-42,-32},{-58,-16}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-42,-58},{-58,-42}})));
  IDEAS.Fluid.Sources.MassFlowSource_T source1[6](
    redeclare package Medium = Medium,
    each final nPorts=1,
    each m_flow=0)
    annotation (Placement(transformation(extent={{-80,-98},{-100,-78}})));
  Fluid.Sources.MassFlowSource_T       Extract[2](
    redeclare package Medium = Medium,
    each use_m_flow_in=true,
    each final nPorts=1)
    annotation (Placement(transformation(extent={{-80,6},{-100,26}})));
  Modelica.Blocks.Math.Gain massflowInput1[2](each k=-(1.205/3600)/2)
    annotation (Placement(transformation(extent={{-42,16},{-58,32}})));
equation

  //Supply in living room
  connect(port_b[1],Supply[1].ports[1]) annotation (Line(points={{-200,-28.5714},
          {-200,-32},{-100,-32}},           color={0,127,255}));
  connect(port_a[1], bou[5].ports[1]) annotation (Line(points={{-200,11.4286},{
          -200,71},{-100,71}},                                                                      color={0,0,0}));
  connect(measuredInput.y[2], massflowInput.u) annotation (Line(points={{23.3,
          -31},{0,-31},{0,-24},{-40.4,-24}},      color={0,0,127}));
  connect(Supply[1].m_flow_in, massflowInput.y) annotation (Line(points={{-78,-24},
          {-58.8,-24}},                       color={0,0,127}));
  connect(measuredInput.y[1], from_degC.u) annotation (Line(points={{23.3,-31},
          {0,-31},{0,-50},{-40.4,-50}},color={0,0,127}));
  connect(from_degC.y,Supply [1].T_in) annotation (Line(points={{-58.8,-50},{
          -70,-50},{-70,-28},{-78,-28}},
                                     color={0,0,127}));

  //Extraction in bathroom and bedroom
  connect(measuredInput.y[2], massflowInput1[1].u) annotation (Line(points={{23.3,
          -31},{-0.35,-31},{-0.35,24},{-40.4,24}}, color={0,0,127}));
  connect(measuredInput.y[2], massflowInput1[2].u) annotation (Line(points={{23.3,
          -31},{-0.35,-31},{-0.35,24},{-40.4,24}}, color={0,0,127}));
  connect(massflowInput1.y, Extract.m_flow_in) annotation (Line(points={{-58.8,24},{-78,24}}, color={0,0,127}));
  connect(port_a[3:4],Extract[1:2].ports[1]) annotation (Line(points={{-200,20},
          {-150,20},{-150,20},{-100,20},{-100,16}},                                                                    color={0,127,255}));
  connect(port_b[3:4],source1[5:6].ports[1]) annotation (Line(points={{-200,-20},
          {-200,-88},{-100,-88}},                            color={0,127,255}));

  //Zones without ventilation supply/extraction (corridor,kitchen, entrance, bedroom 2)
  connect(port_a[5:7], bou[1:3].ports[1]) annotation (Line(points={{-200,
          28.5714},{-200,71},{-100,71}},
                                color={0,0,0}));
  connect(port_a[2], bou[4].ports[1]) annotation (Line(points={{-200,14.2857},{
          -200,71},{-100,71}},                                                                     color={0,0,0}));
  connect(port_b[5:7],source1[1:3].ports[1]) annotation (Line(points={{-200,
          -11.4286},{-200,-88},{-100,-88}},                  color={0,127,255}));
  connect(port_b[2],source1[4].ports[1]) annotation (Line(points={{-200,
          -25.7143},{-200,-88},{-100,-88}},                  color={0,127,255}));



  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Vent_TTH_pressureNetwork;
