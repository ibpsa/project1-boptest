within BuildingEmulators.Components.Partials;
model Collector

  parameter Integer nIn(min=1) = 1 "Number of inlet connections of the collector";
  parameter Integer nOut(min=2) = 2 "Number of outlet connections of the collector";

  parameter Boolean byPass = true "true if collector has a by-pass connection";

  replaceable package Medium = IDEAS.Media.Water;

  Modelica.Fluid.Interfaces.FluidPorts_a portsIn[nIn](redeclare package Medium =
        Medium) "Ports for inlet connetions" annotation (Placement(
        transformation(
        extent={{-10,-40},{10,40}},
        rotation=180,
        origin={-100,0})));
  Modelica.Fluid.Interfaces.FluidPorts_a portsOut[nOut](redeclare package
      Medium = Medium) "Ports for inlet connetions" annotation (Placement(
        transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={0,100})));

  Modelica.Fluid.Interfaces.FluidPort_b port_byPass(
    redeclare package Medium = Medium) "Port connection if bypass"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  IDEAS.Fluid.FixedResistances.Junction jun[nOut](
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal={1,1,1},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));

equation
  //Connect all inputs to the first junction
  for i in nIn loop
    connect(jun[1].port_1, portsIn[nIn]) annotation (Line(points={{-10,0},{-100,0}}, color={0,127,255}));
  end for;
  //Connect outputs to respective function
  for i in nOut loop
    connect(jun[i].port_3, portsOut[i]) annotation (Line(points={{0,10},{0,100}}, color={0,127,255}));
  end for;
  //Connect bypass to last junction
  connect(jun[nOut].port_2, port_byPass) annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Collector;
