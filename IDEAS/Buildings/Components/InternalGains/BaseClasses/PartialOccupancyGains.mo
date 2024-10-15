within IDEAS.Buildings.Components.InternalGains.BaseClasses;
partial model PartialOccupancyGains "Partial model for occupant internal gains"
  import IDEAS;
  extends Modelica.Blocks.Icons.Block;
  outer IDEAS.BoundaryConditions.SimInfoManager sim "Simulation information manager";
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true, Documentation(revisions="<html>
<ul>
<li>
January 26, 2018 by Filip Jorissen:<br/>
Changed replaceable record into parameter such that 
<code>IDEAS.Buildings.Components.OccupancyType.BaseClasses.PartialOccupancyType</code> 
can be a partial record.
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
</ul>
</html>"));
  parameter IDEAS.Buildings.Components.OccupancyType.OfficeWork occupancyType
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));

  Modelica.Blocks.Interfaces.RealOutput mWat_flow
    "Water vapor mass flow rate due to occupants"
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portCon
    "Port for convective sensible heat transfer due to occupants"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.RealOutput C_flow[max(Medium.nC,1)]
    "Trace substance mass flow rate due to occupants"
    annotation (Placement(transformation(extent={{96,10},{116,30}})));
  Modelica.Blocks.Interfaces.RealInput nOcc "Number of occupants"
    annotation (Placement(transformation(extent={{-130,-20},{-90,20}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo(final
      alpha=0) if sim.computeConservationOfEnergy
    "Prescribed energy heat flow for conservation of energy check";
  Modelica.Blocks.Sources.RealExpression Qgai(y=-portCon.Q_flow-portRad.Q_flow) if sim.computeConservationOfEnergy;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portRad
    "Port for radiative sensible heat transfer due to occupants"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
equation
  connect(preHeaFlo.port, sim.Qgai);
  connect(Qgai.y, preHeaFlo.Q_flow);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
July 26, 2018 by Filip Jorissen:<br/>
Revised implementation to add support for
<a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end PartialOccupancyGains;
