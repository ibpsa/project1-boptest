within IDEAS.Buildings.Validation.BaseClasses.VentilationSystem;
model NightVentilation "BESTEST nightventilation system"
  extends IDEAS.Templates.Interfaces.BaseClasses.VentilationSystem(final nLoads=1);

  IDEAS.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = IDEAS.Media.Air,
    use_m_flow_in=true, final nPorts=nZones,
    use_T_in=true)
    annotation (Placement(transformation(extent={{-68,10},{-88,30}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = IDEAS.Media.Air,
    final nPorts=nZones)
    annotation (Placement(transformation(extent={{-68,-30},{-88,-10}})));
  Modelica.Blocks.Sources.RealExpression m_flow_in(y=if ventilate then m_flow else 0)
    annotation (Placement(transformation(extent={{-12,38},{-32,58}})));
  Modelica.Blocks.Sources.RealExpression T_in(y=sim.Te)
    annotation (Placement(transformation(extent={{-10,-8},{-30,12}})));

protected
  parameter Modelica.SIunits.Pressure pAmb= 83200 "Ambient pressure is 83kPa";
  parameter Modelica.SIunits.SpecificHeatCapacity r= 287 "Gas constant";
  parameter Modelica.SIunits.VolumeFlowRate dotV = 1703.16/3600 "Volumetric flow rate";
  Modelica.SIunits.Density rho = pAmb/sim.Te/r "Density";
  Modelica.SIunits.MassFlowRate m_flow = dotV*rho "Mass flow rate that enters the building";

  Boolean ventilate = not occ.occupied;

  IDEAS.BoundaryConditions.Occupants.Components.Schedule occ(occupancy=3600*{7,18},
      firstEntryOccupied=true) "Occupancy shedule";
  final parameter Real mSenFac=0.822
    "Air density correction for BESTEST at high altitude";


equation
  for i in 1:nZones loop
    connect(port_b[i], boundary.ports[i]);
    connect(port_a[i], bou.ports[i]);
  end for;

  connect(boundary.T_in, T_in.y) annotation (Line(
      points={{-66,24},{-50,24},{-50,2},{-31,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary.m_flow_in, m_flow_in.y) annotation (Line(
      points={{-66,28},{-50,28},{-50,48},{-33,48}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>
January 14, 2017 by Filip Jorissen:<br/>
Corrected error in computation of air density.
</li>
</ul>
</html>"));
end NightVentilation;
