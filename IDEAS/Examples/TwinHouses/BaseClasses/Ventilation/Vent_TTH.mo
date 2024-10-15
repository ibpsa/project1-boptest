within IDEAS.Examples.TwinHouses.BaseClasses.Ventilation;
model Vent_TTH
  "Ventilation based on measured supply/exhaust rates and temperatures"
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
    annotation (Placement(transformation(extent={{28,-64},{14,-50}})));

  IDEAS.Fluid.Sources.MassFlowSource_T source[1](
    redeclare package Medium = Medium,
    each use_m_flow_in=true,
    each final nPorts=1,
    each use_T_in=true)
    annotation (Placement(transformation(extent={{-80,-56},{-100,-36}})));
  IDEAS.Fluid.FixedResistances.Junction                         spl(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    tau=300,
    from_dp=false,
    m_flow_nominal={120,-60,-60}*1.204/3600,
    dp_nominal={50,50,50},
    linearized=true,
    redeclare package Medium = Medium,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-144,12},{-124,32}})));
  IDEAS.Fluid.Sources.Boundary_pT bou[5](
    each final nPorts=1,
    redeclare each package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,44},{-112,62}})));
  Modelica.Blocks.Math.Gain massflowInput(k=1.205/3600)
    annotation (Placement(transformation(extent={{-44,-46},{-60,-30}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-38,-76},{-54,-60}})));
  IDEAS.Fluid.Sources.MassFlowSource_T source1[3](
    redeclare package Medium = Medium,
    each final nPorts=1,
    each m_flow=0)
    annotation (Placement(transformation(extent={{-80,-98},{-100,-78}})));
equation
  connect(port_b[1], source[1].ports[1]);

  connect(port_a[2], spl.port_1) annotation (Line(points={{-200,14.2857},{-172,
          14.2857},{-172,22},{-144,22}},
                                color={0,0,0}));
  connect(spl.port_3, port_b[3]) annotation (Line(points={{-134,12},{-134,
          -22.8571},{-200,-22.8571}}, color={0,127,255}));
  connect(spl.port_2, port_b[4]) annotation (Line(points={{-124,22},{-110,
          22},{-110,-20},{-200,-20}}, color={0,127,255}));
  connect(port_a[3], bou[1].ports[1]) annotation (Line(points={{-200,17.1429},{
          -200,53},{-112,53}},      color={0,0,0}));
  connect(port_a[4], bou[2].ports[1]) annotation (Line(points={{-200,20},{-200,
          53},{-112,53}},           color={0,0,0}));
  connect(measuredInput.y[2], massflowInput.u) annotation (Line(points={{13.3,-57},
          {0,-57},{0,-38},{-22,-38},{-42.4,-38}}, color={0,0,127}));
  connect(source[1].m_flow_in, massflowInput.y) annotation (Line(points={{-78,-38},
          {-78,-38},{-60.8,-38}},             color={0,0,127}));
  connect(measuredInput.y[1], from_degC.u) annotation (Line(points={{13.3,-57},{
          0,-57},{0,-68},{-36.4,-68}}, color={0,0,127}));
  connect(from_degC.y, source[1].T_in) annotation (Line(points={{-54.8,-68},{-70,
          -68},{-70,-42},{-78,-42}}, color={0,0,127}));
  connect(port_a[5:7], bou[3:5].ports[1]) annotation (Line(points={{-200,
          28.5714},{-190,28.5714},{-190,53},{-112,53}},
                                                  color={0,0,0}));
  connect(source1[1:3].ports[1], port_b[5:7]) annotation (Line(points={{-100,
          -88},{-200,-88},{-200,-11.4286}},                  color={0,127,255}));
  connect(port_b[2], port_a[1]) annotation (Line(points={{-200,-25.7143},{-200,
          11.4286}},                 color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Line(points={{-194,
              -20},{-152,-20},{-152,-44},{-100,-44}}, color={28,108,200})}));
end Vent_TTH;
