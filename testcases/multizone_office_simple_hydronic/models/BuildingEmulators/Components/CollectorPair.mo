within BuildingEmulators.Components;
model CollectorPair

  parameter Integer nProd(min=1) = 1 "Number of production systems";
  parameter Integer nDist(min=2) = 2 "Number of distribution loops";

  parameter Modelica.Units.SI.MassFlowRate[nProd] m_flow_nominal "Nominal mass flow rates at the outlet side";
  parameter Modelica.Units.SI.PressureDifference dp_nominal = 1e5 "Nominal pressure drop, placed at supply collector";


  replaceable package Medium = IDEAS.Media.Water;
  Modelica.Fluid.Interfaces.FluidPorts_a portsDistRet[nDist](redeclare package
      Medium = Medium) "Ports for distribution return" annotation (Placement(
        transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={44,100}), iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={62,100})));
  Modelica.Fluid.Interfaces.FluidPorts_a portsDistSup[nDist](redeclare package
      Medium = Medium) "Ports for distribution supply connetions" annotation (
      Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-40,100})));
  Modelica.Fluid.Interfaces.FluidPorts_a portsProdSup[nProd](redeclare package
      Medium = Medium) "Ports for production supply connetions" annotation (
      Placement(transformation(
        extent={{-10.0,-40.0},{10.0,40.0}},
        rotation=180.0,
        origin={-100.0,52.0})));
  Modelica.Fluid.Interfaces.FluidPorts_a portsProdRet[nProd](redeclare package
      Medium = Medium) "Ports for production return connetions" annotation (
      Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=180,
        origin={-100,-48})));
    .IDEAS.Fluid.MixingVolumes.MixingVolume colSup(
      redeclare package Medium=Medium,
      energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal = sum(m_flow_nominal),
      V = sum(m_flow_nominal) / 1000 * 300,
      nPorts=2*nProd+nDist,allowFlowReversal = true) annotation(Placement(transformation(extent = {{-50.0,52.0},{-30.0,72.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.MixingVolumes.MixingVolume colRet(
      redeclare package Medium=Medium,
      energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal = sum(m_flow_nominal),
      V = sum(m_flow_nominal) / 1000 * 300,
      nPorts=2*nProd+nDist,allowFlowReversal = true) annotation(Placement(transformation(extent = {{34.0,-48.0},{54.0,-28.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.FixedResistances.PressureDrop byPass(
      redeclare package Medium = Medium,
      m_flow_nominal = sum(m_flow_nominal),
      dp_nominal = dp_nominal,allowFlowReversal = false) annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {-20.0,-2.0},rotation = -90.0)));
equation
  for i in 1:nProd loop
    connect(portsProdSup[i], colSup.ports[i])
    annotation (Line(points={{-100,52},{-68,52}}, color={0,127,255}));
    connect(portsProdRet[i], colRet.ports[i])
    annotation (Line(points={{-100,-48},{16,-48}}, color={0,127,255}));

  end for;
  for i in 1:nDist loop
  connect(colRet.ports[nProd+i], portsDistRet[i])
    annotation (Line(points={{44,-20},{44,100}}, color={0,127,255}));
  connect(colSup.ports[nProd+i], portsDistSup[i])
    annotation (Line(points={{-40,80},{-40,100}}, color={0,127,255}));
  end for;
    connect(colSup.ports[nProd+nDist+1],byPass.port_a) annotation(Line(points = {{-40,52},{-40,36},{-20.000000000000004,36},{-20.000000000000004,8}},color = {0,127,255}));
    connect(byPass.port_b,colRet.ports[nProd+nDist+1]) annotation(Line(points = {{-19.999999999999996,-12},{-19.999999999999996,-54},{44,-54},{44,-48}},color = {0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {120,100}}), graphics={
        Line(
          points={{-76,52},{-102,52}},
          color={0,128,255},
          thickness=0.5),
        Rectangle(
          extent={{-76,58},{-6,46}},
          lineColor={0,0,0},
          lineThickness=1),
        Line(
          points={{48,-42},{48,98}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{76,-42},{76,100}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-28,58},{-28,102}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-54,58},{-54,100}},
          color={0,128,255},
          thickness=0.5),
        Rectangle(
          extent={{24,-42},{94,-54}},
          lineColor={0,0,0},
          lineThickness=1),
        Line(
          points={{24,-48},{-100,-48}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-6,52},{108,52},{108,-48},{94,-48}},
          color={0,128,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-8,-4},{-8,4},{8,-4},{8,4},{-8,-4}},
          color={0,0,0},
          rotation=90,
          origin={108,24})}),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end CollectorPair;
