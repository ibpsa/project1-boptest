within IDEAS.Buildings.Components.InterzonalAirFlow;
model n50Tight
  "n50Tight: n50 air leakage into and from airtight zone"
  extends IDEAS.Buildings.Components.InterzonalAirFlow.BaseClasses.PartialInterzonalAirFlown50(
    prescribesPressure=false);
  Fluid.Interfaces.IdealSource airExfiltration(
    redeclare package Medium = Medium,
    control_m_flow=true,
    allowFlowReversal=false,
    control_dp=false) "Fixed air exfiltration rate" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-50})));
equation
  assert(sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    "n50Tight should not be used in combination with sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None. Use AirTight instead.");
  connect(airExfiltration.m_flow_in, airInfiltration.m_flow_in)
    annotation (Line(points={{2,-56},{-18,-56},{-18,-44}},  color={0,0,127}));
  connect(airExfiltration.port_b, bou.ports[2])
    annotation (Line(points={{10,-40},{10,0},{-1.77636e-15,0}},
                                                      color={0,127,255}));
  connect(airExfiltration.port_a, ports[2]) annotation (Line(points={{10,-60},{
          10,-100},{2,-100},{2,-100}},
                                    color={0,127,255}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
March 17, 2020, Filip Jorissen:<br/>
Added support for vector fluidport.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1029\">#1029</a>.
</li>
<li>
January 25, 2019, Filip Jorissen:<br/>
Added constant <code>prescribesPressure</code> that indicates
whether this model prescribes the zone air pressure or not.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/971\">#971</a>.
</li>
<li>
April 27, 2018 by Filip Jorissen:<br/>
First version.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
</ul>
</html>", info="<html>
<p>
This model represents an air tight zone.  
A fixed mass flow rate, 
corresponding to air infiltration, is injected into and extracted from the zone.
The mass flow rate is computed from the zone <code>n50</code> value.
No other air leakage is modelled.
</p>
</html>"), Icon(graphics={
        Rectangle(
          extent={{-70,40},{-100,0}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None)}));
end n50Tight;
