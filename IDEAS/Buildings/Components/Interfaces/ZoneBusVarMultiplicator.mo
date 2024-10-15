within IDEAS.Buildings.Components.Interfaces;
model ZoneBusVarMultiplicator "Component to scale all flows from the zone propsBus. This can be used to scale the surface to n identical surfaces"
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium
    "Medium in the component";
  parameter Real k = 1 "Scaling factor";

  ZoneBus propsBus_a(
    redeclare final package Medium = Medium,
    numIncAndAziInBus=sim.numIncAndAziInBus, outputAngles=sim.outputAngles,
    final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts)
    "Unscaled port"                                                         annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,0})));

  ZoneBus propsBus_b(
    redeclare final package Medium = Medium,
    numIncAndAziInBus=sim.numIncAndAziInBus, outputAngles=sim.outputAngles,
    final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts)
    "Scaled port"                                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0})));

  outer BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{72,122},{92,142}})));
  Modelica.Blocks.Routing.BooleanPassThrough use_custom_n50
    annotation (Placement(transformation(extent={{8,-324},{-12,-304}})));
protected
  IDEAS.Fluid.BaseClasses.MassFlowRateMultiplier massFlowRateMultiplier2(
      redeclare package Medium = Medium,                                 final k=k) if
       sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts
    "Mass flow rate multiplier for port 2"
    annotation (Placement(transformation(extent={{-10,-200},{10,-180}})));
  IDEAS.Fluid.BaseClasses.MassFlowRateMultiplier massFlowRateMultiplier1(
      redeclare package Medium = Medium,                                 final k=k) if
        sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None
    "Mass flow rate multiplier for port 1"
    annotation (Placement(transformation(extent={{-10,-170},{10,-150}})));
  Modelica.Blocks.Math.Gain QTra_desgin(k=k) "Design heat flow rate"
    annotation (Placement(transformation(extent={{-10,178},{10,198}})));
  Modelica.Blocks.Math.Gain area(k=k) "Heat exchange surface area"
    annotation (Placement(transformation(extent={{-10,150},{10,170}})));
  BaseClasses.Varia.HeatFlowMultiplicator surfCon(k=k)
    "Block for scaling convective heat transfer"
    annotation (Placement(transformation(extent={{-10,62},{10,82}})));
  BaseClasses.Varia.HeatFlowMultiplicator surfRad(k=k)
    "Block for scaling radiative heat transfer"
    annotation (Placement(transformation(extent={{-10,34},{10,54}})));
  BaseClasses.Varia.HeatFlowMultiplicator iSolDir(k=k)
    "Block for scaling direct solar irradiation"
    annotation (Placement(transformation(extent={{-10,2},{10,22}})));
  BaseClasses.Varia.HeatFlowMultiplicator iSolDif(k=k)
    "Black for scaling diffuse solar irradiation"
    annotation (Placement(transformation(extent={{-10,-26},{10,-6}})));
  BaseClasses.Varia.HeatFlowMultiplicator QGai(k=k)
    "Block for scaling internal gains"
    annotation (Placement(transformation(extent={{-10,-52},{10,-32}})));
  BaseClasses.Varia.EnergyFlowMultiplicator E(k=k)
    "Block for scaling internal energy"
    annotation (Placement(transformation(extent={{-10,-82},{10,-62}})));
  Modelica.Blocks.Routing.RealPassThrough inc "Inclination angle"
    annotation (Placement(transformation(extent={{-10,-114},{10,-94}})));
  Modelica.Blocks.Routing.RealPassThrough azi "Azimuth angle"
    annotation (Placement(transformation(extent={{-10,-144},{10,-124}})));
  Modelica.Blocks.Routing.RealPassThrough epsLw "Longwave emissivity"
    annotation (Placement(transformation(extent={{-10,118},{10,138}})));
  Modelica.Blocks.Routing.RealPassThrough epsSw "Shortwave emissivity"
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  Modelica.Blocks.Math.Gain v50(k=k)
    "v50 value if q50 of the surface is custome"
    annotation (Placement(transformation(extent={{-10,-232},{10,-212}})));
  Modelica.Blocks.Routing.RealPassThrough q50_zone
    "q50 for non costume surfaces"
    annotation (Placement(transformation(extent={{8,-268},{-12,-248}})));
  Modelica.Blocks.Routing.BooleanPassThrough use_custom_q50
    "0 if the surface has a custom q50"
    annotation (Placement(transformation(extent={{-12,-296},{8,-276}})));
equation
  connect(QTra_desgin.u, propsBus_a.QTra_design) annotation (Line(points={{-12,188},
          {-100.1,188},{-100.1,0.1}},         color={0,0,127}));
  connect(QTra_desgin.y, propsBus_b.QTra_design) annotation (Line(points={{11,188},
          {100.1,188},{100.1,-0.1}},color={0,0,127}));
  connect(area.u, propsBus_a.area) annotation (Line(points={{-12,160},{-100.1,
          160},{-100.1,0.1}},color={0,0,127}));
  connect(area.y, propsBus_b.area) annotation (Line(points={{11,160},{100.1,160},
          {100.1,-0.1}},     color={0,0,127}));
  connect(surfCon.port_a, propsBus_a.surfCon) annotation (Line(points={{-10,72},
          {-100.1,72},{-100.1,0.1}},          color={191,0,0}));
  connect(surfRad.port_a, propsBus_a.surfRad) annotation (Line(points={{-10,44},
          {-100.1,44},{-100.1,0.1}},          color={191,0,0}));
  connect(iSolDif.port_a, propsBus_a.iSolDif) annotation (Line(points={{-10,-16},
          {-100.1,-16},{-100.1,0.1}},
                                   color={191,0,0}));
  connect(iSolDir.port_a, propsBus_a.iSolDir) annotation (Line(points={{-10,12},
          {-100.1,12},{-100.1,0.1}},          color={191,0,0}));
  connect(surfCon.port_b, propsBus_b.surfCon) annotation (Line(points={{10,72},
          {100.1,72},{100.1,-0.1}},        color={191,0,0}));
  connect(surfRad.port_b, propsBus_b.surfRad) annotation (Line(points={{10,44},
          {100.1,44},{100.1,-0.1}},        color={191,0,0}));
  connect(iSolDir.port_b, propsBus_b.iSolDir) annotation (Line(points={{10,12},
          {100.1,12},{100.1,-0.1}},        color={191,0,0}));
  connect(iSolDif.port_b, propsBus_b.iSolDif)
    annotation (Line(points={{10,-16},{100.1,-16},{100.1,-0.1}},
                                                             color={191,0,0}));
  connect(QGai.port_b, propsBus_b.Qgai) annotation (Line(points={{10,-42},{
          100.1,-42},{100.1,-0.1}},
                              color={191,0,0}));
  connect(E.E_b, propsBus_b.E) annotation (Line(points={{10,-72},{100.1,-72},{
          100.1,-0.1}},
                  color={0,0,0}));
  connect(inc.y, propsBus_b.inc) annotation (Line(points={{11,-104},{100.1,-104},
          {100.1,-0.1}}, color={0,0,127}));
  connect(azi.y, propsBus_b.azi) annotation (Line(points={{11,-134},{100.1,-134},
          {100.1,-0.1}}, color={0,0,127}));
  connect(azi.u, propsBus_a.azi) annotation (Line(points={{-12,-134},{-100.1,
          -134},{-100.1,0.1}},
                         color={0,0,127}));
  connect(inc.u, propsBus_a.inc) annotation (Line(points={{-12,-104},{-100.1,
          -104},{-100.1,0.1}},
                         color={0,0,127}));
  connect(E.E_a, propsBus_a.E) annotation (Line(points={{-9.8,-72},{-100.1,-72},
          {-100.1,0.1}}, color={0,0,0}));
  connect(QGai.port_a, propsBus_a.Qgai) annotation (Line(points={{-10,-42},{
          -100.1,-42},{-100.1,0.1}},       color={191,0,0}));
  connect(epsLw.u, propsBus_a.epsLw) annotation (Line(points={{-12,128},{-100.1,
          128},{-100.1,0.1}}, color={0,0,127}));
  connect(epsSw.u, propsBus_a.epsSw) annotation (Line(points={{-12,98},{-100.1,
          98},{-100.1,0.1}},         color={0,0,127}));
  connect(epsLw.y, propsBus_b.epsLw) annotation (Line(points={{11,128},{100.1,
          128},{100.1,-0.1}},        color={0,0,127}));
  connect(epsSw.y, propsBus_b.epsSw) annotation (Line(points={{11,98},{100.1,98},
          {100.1,-0.1}}, color={0,0,127}));
  connect(massFlowRateMultiplier1.port_a, propsBus_a.port_1) annotation (Line(
        points={{-10,-160},{-100.1,-160},{-100.1,0.1}}, color={0,127,255}));
  connect(massFlowRateMultiplier2.port_a, propsBus_a.port_2) annotation (Line(
        points={{-10,-190},{-100.1,-190},{-100.1,0.1}}, color={0,127,255}));
  connect(massFlowRateMultiplier1.port_b, propsBus_b.port_1) annotation (Line(
        points={{10,-160},{100.1,-160},{100.1,-0.1}}, color={0,127,255}));
  connect(massFlowRateMultiplier2.port_b, propsBus_b.port_2) annotation (Line(
        points={{10,-190},{100,-190},{100,-0.1},{100.1,-0.1}}, color={0,127,255}));
  connect(v50.u, propsBus_a.v50) annotation (Line(points={{-12,-222},{-100,-222},
          {-100,0.1},{-100.1,0.1}}, color={0,0,127}));
  connect(v50.y, propsBus_b.v50) annotation (Line(points={{11,-222},{100,-222},
          {100,-0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(q50_zone.u, propsBus_b.q50_zone) annotation (Line(points={{10,-258},{
          100,-258},{100,-0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(q50_zone.y, propsBus_a.q50_zone) annotation (Line(points={{-13,-258},
          {-100,-258},{-100,0.1},{-100.1,0.1}}, color={0,0,127}));
  connect(use_custom_q50.u, propsBus_a.use_custom_q50) annotation (Line(points={{-14,
          -286},{-100,-286},{-100,0.1},{-100.1,0.1}},
                                               color={0,0,127}));
  connect(use_custom_q50.y, propsBus_b.use_custom_q50) annotation (Line(points={{9,-286},
          {100,-286},{100,-0.1},{100.1,-0.1}},
                                          color={0,0,127}));
  connect(use_custom_n50.u, propsBus_b.use_custom_n50) annotation (Line(points={{10,-314},
          {100.1,-314},{100.1,-0.1}},color={255,0,255}));
  connect(use_custom_n50.y, propsBus_a.use_custom_n50) annotation (Line(points={{-13,
          -314},{-100,-314},{-100,0.1},{-100.1,0.1}},
                                                color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},
            {100,200}}), graphics={
        Polygon(
          points={{-100,120},{102,-2},{-100,-120},{-100,120}},
          lineColor={255,215,136},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-76,-110},{72,-160}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="k = %k"),
        Text(
          extent={{-100,158},{100,98}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},{100,200}})),
    Documentation(revisions="<html>
<ul>
<li>
August 10, 2020, by Filip Jorissen:<br/>
Modifications for supporting interzonal airflow.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1066\">
#1066</a>
</li>
<li>
April 26, 2020, by Filip Jorissen:<br/>
Refactored <code>SolBus</code> to avoid many instances in <code>PropsBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1131\">
#1131</a>
</li>
<li>
August 10, 2018 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end ZoneBusVarMultiplicator;
