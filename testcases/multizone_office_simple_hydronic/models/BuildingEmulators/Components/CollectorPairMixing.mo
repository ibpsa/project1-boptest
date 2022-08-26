within BuildingEmulators.Components;

model CollectorPairMixing

  parameter Integer nProd(min=1) = 1 "Number of production systems";
  parameter Integer nDist(min=2) = 2 "Number of distribution loops";
  parameter Boolean byPass = true "true if collector has a by-pass connection";

  parameter .Modelica.Units.SI.MassFlowRate[nDist] m_flow_nominal = 1 "Nominal mass flow rates at the outlet side";
  parameter .Modelica.Units.SI.PressureDifference dp_nominal = 1e5 "Nominal pressure drop, placed at supply collector";

  parameter .Modelica.Units.SI.MassFlowRate m_flow_nominal_byPass = 1 "Nominal mass flow rate in the bypass";
  parameter .Modelica.Units.SI.PressureDifference dp_nominal_byPass = dp_nominal "Nominal pressure drop in the bypass";

  replaceable package Medium = .IDEAS.Media.Water;

  .BuildingEmulators.Components.Collector colSup(nIn=nProd, nOut=nDist,m_flow_nominal = m_flow_nominal,dp_nominal = dp_nominal)
                   "Supply collector"
    annotation (Placement(transformation(extent={{-68.0,24.0},{-12.0,80.0}},rotation = 0.0,origin = {0.0,0.0})));
  .BuildingEmulators.Components.Collector colRet(nIn=nProd, nOut=nDist,m_flow_nominal = m_flow_nominal,dp_nominal = dp_nominal)
                   "Return collector"
    annotation (Placement(transformation(extent={{16,-76},{72,-20}})));
  .Modelica.Fluid.Interfaces.FluidPorts_a portsDistRet[nDist](redeclare package
      Medium = Medium) "Ports for distribution return" annotation (Placement(
        transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={44,100}), iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={62,100})));
  .Modelica.Fluid.Interfaces.FluidPorts_a portsDistSup[nDist](redeclare package
      Medium = Medium) "Ports for distribution supply connetions" annotation (
      Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-40,100})));
  .Modelica.Fluid.Interfaces.FluidPorts_a portsProdSup[nProd](redeclare package
      Medium = Medium) "Ports for production supply connetions" annotation (
      Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=180,
        origin={-100,52})));
  .Modelica.Fluid.Interfaces.FluidPorts_a portsProdRet[nProd](redeclare package
      Medium = Medium) "Ports for production return connetions" annotation (
      Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=180,
        origin={-100,-48})));
  .Modelica.Blocks.Sources.Constant byPassSignal(k=if byPass then 1 else 0)
    annotation (Placement(transformation(extent={{0.0,2.0},{20.0,22.0}},rotation = 0.0,origin = {0.0,0.0})));
equation
  for i in 1:nProd loop
    connect(portsProdSup[i], colSup.portsIn[i])
    annotation (Line(points={{-100,52},{-68,52}}, color={0,127,255}));
    connect(portsProdRet[i], colRet.portsIn[i])
    annotation (Line(points={{-100,-48},{16,-48}}, color={0,127,255}));
  end for;
  for i in 1:nDist loop
  connect(colRet.portsOut[i], portsDistRet[i])
    annotation (Line(points={{44,-20},{44,100}}, color={0,127,255}));
  connect(colSup.portsOut[i], portsDistSup[i])
    annotation (Line(points={{-40,80},{-40,100}}, color={0,127,255}));
  end for;
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
end CollectorPairMixing;
