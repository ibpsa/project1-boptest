within IDEAS.Templates.Heating;
model RadiatorHeating
  "Radiator heating system using hysteresis controller, using hydronic network and simplified pressure drops"
  extends IDEAS.Templates.Heating.BaseClasses.HysteresisHeating(
    final nEmbPorts=0,
    final nConvPorts = nZones,
    final nRadPorts = nZones,
    booToRea(realTrue=rad.m_flow_nominal));

protected
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2[nZones] rad(
    each allowFlowReversal=false,
    each T_a_nominal=273.15 + 75,
    each T_b_nominal=273.15 + 65,
    each dp_nominal=1000,
    Q_flow_nominal=QNom,
    redeclare package Medium = Medium,
    each energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                          annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-160,0})));
  Fluid.HeatExchangers.Heater_T hea1(
    m_flow_nominal=sum(rad.m_flow_nominal),
    dp_nominal=10000,
    allowFlowReversal=false,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant THea(k=273.15 + 75)
    "Temperature of hot water produced by heater"
    annotation (Placement(transformation(extent={{-20,40},{-40,60}})));
  Fluid.Movers.FlowControlled_m_flow[nZones] pum(
    each energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    each use_inputFilter=false,
    m_flow_nominal=rad.m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));

  Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium)
    "Boundary for setting the absolute pressure"
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
equation

  connect(add.u2, TSet)
    annotation (Line(points={{18,-42},{18,-104},{20,-104}}, color={0,0,127}));
  connect(add.u1, TSensor)
    annotation (Line(points={{6,-42},{6,-60},{-204,-60}}, color={0,0,127}));
  connect(add.y, hys.u)
    annotation (Line(points={{12,-19},{12,0},{-18,0}}, color={0,0,127}));
  connect(THea.y, hea1.TSet) annotation (Line(points={{-41,50},{-48,50},{-48,58},
          {-58,58}}, color={0,0,127}));
  connect(pum.port_a, rad.port_b) annotation (Line(points={{-120,-30},{-160,-30},
          {-160,-20}}, color={0,127,255}));
  connect(hys.y, booToRea.u)
    annotation (Line(points={{-41,0},{-50,0},{-50,0},{-58,0}},
                                               color={255,0,255}));
  connect(booToRea.y, pum.m_flow_in)
    annotation (Line(points={{-81,0},{-110,0},{-110,-18}}, color={0,0,127}));
  for i in 1:nZones loop
    connect(pum[i].port_b, hea1.port_a) annotation (Line(points={{-100,-30},{-50,-30},
          {-50,50},{-60,50}}, color={0,127,255}));
    connect(hea1.port_b, rad[i].port_a) annotation (Line(points={{-80,50},{-160,50},
          {-160,20}}, color={0,127,255}));
  end for;
  connect(rad.heatPortCon, heatPortCon) annotation (Line(points={{-174.4,4},{-186,
          4},{-186,20},{-200,20}}, color={191,0,0}));
  connect(rad.heatPortRad, heatPortRad) annotation (Line(points={{-174.4,-4},{-186,
          -4},{-186,-20},{-200,-20}}, color={191,0,0}));
  connect(bou.ports[1], hea1.port_b)
    annotation (Line(points={{-100,70},{-80,70},{-80,50}}, color={0,127,255}));
  annotation (Documentation(info="<html>
<p>
This model represents an ideal heating system with a hysteresis controller.
It reacts instantly when the zone temperature input <code>TSensor</code> is 
below <code>TSet</code> by supplying the nominal
heat flow rate <code>QNom</code>.
This heat flow rate is maintained until <code>TSensor</code> is above <code>TSet+dTHys</code>.
</p>
<p>
The <code>COP</code> is used to compute the electric power that is drawn from 
the elecrical grid. It can be ignored if it is not of interest.
</p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>
January 23, 2017 by Filip Jorissen and Glenn Reynders:<br/>
Revised implementation and documentation.
</li>
<li>2013 June, Roel De Coninck: reworking interface and documentation</li>
<li>2011, Roel De Coninck: first version</li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics={Text(
          extent={{-160,100},{36,78}},
          lineColor={28,108,200},
          textString="1 heater with nZones radiators, controllers and pumps")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,100}}),
        graphics));
end RadiatorHeating;
