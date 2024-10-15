within IDEAS.Buildings.Components.InternalGains.BaseClasses;
partial model PartialLightingGains "Partial model for lighting internal gains"
  extends Modelica.Blocks.Icons.Block;
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager";
  parameter IDEAS.Buildings.Components.LightingType.None ligTyp
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  parameter IDEAS.Buildings.Components.RoomType.Generic rooTyp
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter  Modelica.SIunits.Area A "Area of the zone";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portCon
    "Port for convective sensible heat transfer due to occupants"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Interfaces.RealInput ctrl
    "Number of occupants"
    annotation (Placement(transformation(extent={{-130,-20},{-90,20}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo(
    final alpha=0) if sim.computeConservationOfEnergy
    "Prescribed energy heat flow for conservation of energy check";
  Modelica.Blocks.Sources.RealExpression Qgai(y=-portCon.Q_flow-portRad.Q_flow) if
       sim.computeConservationOfEnergy;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portRad
    "Port for radiative sensible heat transfer due to occupants"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));

equation
  connect(preHeaFlo.port, sim.Qgai);
  connect(Qgai.y, preHeaFlo.Q_flow);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
September 26, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>"));
end PartialLightingGains;
