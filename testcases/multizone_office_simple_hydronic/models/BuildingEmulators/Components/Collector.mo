within BuildingEmulators.Components;
model Collector

  parameter Integer nIn(min=1) = 1 "Number of inlet connections of the collector";
  parameter Integer nOut(min=2) = 2 "Number of outlet connections of the collector";

  parameter Boolean isSupply = true " =true is the supply collector, else is the return collector";
  
  parameter Modelica.Units.SI.MassFlowRate[nOut] m_flow_nominal "Nominal mass flow rates at the outlet side";
  parameter Modelica.Units.SI.PressureDifference dp_nominal "Nominal pressure drop, placed at supply collector";
    
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
  IDEAS.Fluid.FixedResistances.Junction jun[nOut](
    redeclare package Medium = Medium,
    each energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    each portFlowDirection_1=if isSupply then Modelica.Fluid.Types.PortFlowDirection.Entering else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    each portFlowDirection_2=if isSupply then Modelica.Fluid.Types.PortFlowDirection.Leaving else Modelica.Fluid.Types.PortFlowDirection.Entering,
    each portFlowDirection_3=if isSupply then Modelica.Fluid.Types.PortFlowDirection.Leaving else Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal= if isSupply then {{1,1,1} for i in 1:nOut} else {{1,1,1} for i in 1:nOut},
    each dp_nominal=if isSupply then {0,0,0} else {0,0,0})
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
 //   Modelica.Fluid.Interfaces.FluidPort_b port_byPass(redeclare package Medium = Medium) "Port connection if bypass" annotation(Placement(transformation(extent = {{90,-10},{110,10}})));

equation
  //Connect all inputs to the first junction
  for i in 1:nIn loop
    connect(jun[1].port_1, portsIn[nIn]) annotation (Line(points={{-10,0},{-100,0}}, color={0,127,255}));
  end for;
  //Connect outputs to respective function
  for i in 1:nOut loop
    connect(jun[i].port_3, portsOut[i]) annotation (Line(points={{0,10},{0,100}}, color={0,127,255}));
  end for;
  //Connect junctions in series
  for i in 1:nOut-1 loop
    connect(jun[i].port_2, jun[i+1].port_1) annotation (Line(points={{0,10},{0,100}}, color={0,127,255}));
  end for;
  //Connect by-pass
   // connect(jun[nOut].port_2,port_byPass) annotation(Line(points = {{10,0},{100,0}},color = {0,127,255}));


  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-74,16},{74,-16}},
          lineColor={0,0,0},
          lineThickness=1),
        Line(
          points={{-74,0},{-100,0}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{100,0},{74,0}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-26,16},{-26,100}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{0,16},{0,100}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{26,16},{26,100}},
          color={0,128,255},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Collector;
