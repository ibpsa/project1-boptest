within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump;
model SimPumpSystem
  "This model is used to simulate the primary chilled water pump and condenser water pump system"
    replaceable package Medium =
         Modelica.Media.Interfaces.PartialMedium "Medium water";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal[n]
    "Rated mass flow rate";

    parameter Integer n= 2
    "the number of pumps";
    parameter Real Motor_eta[n,:] "Motor efficiency";
    parameter Real Hydra_eta[n,:] "Hydraulic efficiency";
  parameter Modelica.Units.SI.PressureDifference dp_nominal
    "Nominal pressure raise";

  Buildings.Fluid.Movers.FlowControlled_m_flow
                                       pumConSpe[n](redeclare package
      Medium =                                                                 Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=m_flow_nominal,
    per(
      use_powerCharacteristic=false,
      motorEfficiency(eta=Motor_eta),
      hydraulicEfficiency(eta=Hydra_eta)),
    use_inputFilter=false,
    dp_nominal=dp_nominal)                                                           "Constant Speed pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput On[n] "On signal"    annotation (Placement(transformation(extent={{-118,51},
            {-100,69}})));

  Modelica.Blocks.Interfaces.RealOutput P[n]
    "Electric power consumed by compressor"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Math.Gain gain[n](k=m_flow_nominal)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));

equation

  for i in 1:n loop
    connect(pumConSpe[i].port_a, port_a);
    connect(pumConSpe[i].port_b, port_b);
    connect(pumConSpe[i].P, P[i]);

  end for;

  connect(gain.u, On)
    annotation (Line(
      points={{-82,60},{-109,60}},
      color={0,0,127}));
  connect(gain.y, pumConSpe.m_flow_in) annotation (Line(points={{-59,60},{-28,60},{0,60},{0,12}}, color={0,0,127}));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                                                                               Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-40,-102},{46,-156}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-20,80},{20,40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{16,60},{-8,48},{-8,70},{16,60}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,0},{-40,0},{-40,60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-40,60},{-20,60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-40,0},{-16,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-40,0},{-40,-60},{-16,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{20,60},{40,60},{40,-60},{14,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{40,0},{14,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{40,0},{90,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-40},{20,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{16,0},{-8,-12},{-8,10},{16,0}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{16,-60},{-8,-72},{-8,-50},{16,-60}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li>
March 30, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end SimPumpSystem;
