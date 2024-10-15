within IDEAS.Buildings.Components.ZoneAirModels.BaseClasses;
partial model PartialAirModel "Partial for air models"
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare replaceable package Medium = IDEAS.Media.Air);
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));

  parameter Integer nSurf "Number of connected surfaces";
  parameter Integer nSeg(min=1)=1 "Number of air segments";
  parameter Integer nPorts "Number of fluid port connections to zone air volume";
  parameter Modelica.SIunits.Volume Vtot "Total zone air volume";
  parameter Boolean allowFlowReversal=true
     "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal flow rate of the ventilation system";
  Modelica.Blocks.Interfaces.RealOutput E(unit="J") "Model internal energy";
  Modelica.Blocks.Interfaces.RealOutput QGai(unit="J/s") "Model internal energy";
  Modelica.Blocks.Interfaces.RealOutput TAir "Zone air temperature"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSurf] ports_surf
    "Heat convection ports for surfaces"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] inc
    "Inclination angle of surface"
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] A
    "Surface area of surfaces"
    annotation (Placement(transformation(extent={{-126,-80},{-86,-40}})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] azi
    "Azimuth of surface"
    annotation (Placement(transformation(extent={{-128,20},{-88,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium,
    m_flow(nominal=m_flow_nominal),
    h_outflow(nominal=Medium.h_default))
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium,
    m_flow(nominal=m_flow_nominal),
    h_outflow(nominal=Medium.h_default))
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Modelica.Fluid.Interfaces.FluidPorts_a[nPorts] ports(
    redeclare each package Medium = Medium,
    each m_flow(nominal=m_flow_nominal),
    each h_outflow(nominal=Medium.h_default))
    "Ports connector for multiple ports" annotation (Placement(
        transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={0,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSeg] ports_air
    "Heat convection ports for air volumes"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput mWat_flow
    "Moisture mass flow rate being added to the zone air"
    annotation (Placement(transformation(extent={{128,60},{88,100}})));
  Modelica.Blocks.Interfaces.RealInput C_flow[max(Medium.nC,1)]
    "Trace substance mass flow rate being added to the zone air"
    annotation (Placement(transformation(extent={{128,20},{88,60}})));
  Modelica.Blocks.Interfaces.RealOutput phi(unit="1")
    "Relative humidity in the zone"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput ppm(unit="1")
    "CO2 concentration in the zone" annotation (Placement(transformation(extent=
           {{100,-30},{120,-10}})));
protected
  final parameter Medium.ThermodynamicState state_default = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
  final parameter Modelica.SIunits.Density rho_default = Medium.density(
    state=state_default) "Medium default density";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default = Medium.specificHeatCapacityCp(state=state_default);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(revisions="<html>
<ul>
<li>
July 27, 2018 by Filip Jorissen:<br/>
Added output for the CO2 concentration.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/868\">#868</a>.
</li>
<li>
July 11, 2018, Filip Jorissen:<br/>
Added <code>m_flow_nominal</code> for setting nominal values 
of <code>h_outflow</code> and <code>m_flow</code>
in <code>FluidPorts</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/859\">#859</a>.
</li>
<li>
May 29, 2018, Filip Jorissen:<br/>
Removed conditional fluid ports for JModelica compatibility.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/834\">#834</a>.
</li>
<li>
April 27, 2018 by Filip Jorissen:<br/>
Modified model for supporting new interzonal air flow models.
Air leakage model and its parameters have been removed.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
<li>
November 15, 2016 by Filip Jorissen:<br/>
Revised documentation.
</li>
<li>
August 26, 2016 by Filip Jorissen:<br/>
Added support for conservation of energy.
</li>
<li>
April 30, 2016, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Zone air model partial containing main parameters and connectors.
</p>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{90,-80}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          lineColor={0,0,0}),
        Line(
          points={{-68,60},{68,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{68,60},{68,-60},{-68,-60},{-68,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Rectangle(
          extent={{68,60},{-68,-60}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(points={{-30,42},{38,42},{38,-12},{28,-2},{38,-12},{46,-2}}, color=
             {28,108,200}),
        Line(points={{40,-32},{-30,-32},{-30,22},{-20,12},{-30,22},{-38,12}},
            color={238,46,47})}));
end PartialAirModel;
