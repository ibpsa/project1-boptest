within IDEAS.Buildings.Components;
model BoundaryWall "Opaque wall with optional prescribed heat flow rate or temperature boundary conditions"
  extends IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface(
    final custom_q50=0,
    final use_custom_q50=true,
    final nWin=1,
    QTra_design=U_value*A*(273.15 + 21 - TRef_a),
    dT_nominal_a=-1,
    add_cracks=false,
    layMul(disableInitPortB=use_T_in or use_T_fixed, monLay(monLayDyn(each
            addRes_b=(sim.lineariseDymola and (use_T_in or use_T_fixed))))));

  parameter Boolean use_T_fixed = false
    "Get the boundary temperature from the input connector"
    annotation(Dialog(group="Boundary conditions"));
  parameter Modelica.SIunits.Temperature T_fixed=294.15
    "Fixed boundary temperature"
    annotation(Dialog(group="Boundary conditions",enable=use_T_fixed));
  parameter Boolean use_T_in = false
    "Get the boundary temperature from the input connector"
    annotation(Dialog(group="Boundary conditions"));
  parameter Boolean use_Q_in = false
    "Get the boundary heat flux from the input connector"
    annotation(Dialog(group="Boundary conditions"));

  Modelica.Blocks.Interfaces.RealInput T if use_T_in
    "Input for boundary temperature"                 annotation (Placement(
        transformation(extent={{-120,10},{-100,30}}),iconTransformation(extent={{-120,10},
            {-100,30}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow if use_Q_in
    "Input for boundary heat flow rate entering the wall" annotation (Placement(
        transformation(extent={{-120,-30},{-100,-10}}),
                                                    iconTransformation(extent={{-120,
            -30},{-100,-10}})));
  Modelica.Blocks.Math.Product proPreT if  use_T_in or use_T_fixed "Product for linearisation"
    annotation (Placement(transformation(extent={{-86,26},{-74,14}})));
  Modelica.Blocks.Math.Product proPreQ if use_Q_in "Product for linearisation"
    annotation (Placement(transformation(extent={{-86,-14},{-74,-26}})));
  Modelica.Blocks.Sources.Constant TConst(k=T_fixed) if use_T_fixed
    "Constant block for temperature"
    annotation (Placement(transformation(extent={{-110,32},{-100,42}})));

  Fluid.Sources.MassFlowSource_T       boundary1(
    redeclare package Medium = Medium,
    nPorts=1,
    final m_flow=1e-10) if
       sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None
    annotation (Placement(transformation(extent={{-28,-40},{-8,-20}})));
  Fluid.Sources.MassFlowSource_T       boundary2(
    redeclare package Medium = Medium,
    nPorts=1,
    final m_flow=0) if
       sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts
    annotation (Placement(transformation(extent={{-28,-76},{-8,-56}})));
protected
  final parameter Real U_value=1/(1/8 + sum(constructionType.mats.R) + 1/8)
    "Wall U-value";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preFlo(final alpha=0) if
                       use_Q_in "Prescribed heat flow rate"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem if
                             use_T_in or use_T_fixed "Prescribed temperature"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(final numSolBus=sim.numIncAndAziInBus,
      outputAngles=sim.outputAngles)                  "Weather bus"
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
equation
  assert(not (use_T_in and use_Q_in or use_T_in and use_T_fixed or use_Q_in and use_T_fixed),
    "In "+getInstanceName()+": Only one of the following options can be used simultaneously: use_T_in, use_Q_in, use_T_fixed");
  connect(Q_flow, proPreQ.u1)
    annotation (Line(points={{-110,-20},{-100,-20},{-100,-23.6},{-87.2,-23.6}},
                                                    color={0,0,127}));
  connect(proPreQ.y, preFlo.Q_flow)
    annotation (Line(points={{-73.4,-20},{-60,-20}}, color={0,0,127}));
  connect(proPreQ.u2, weaBus.dummy) annotation (Line(points={{-87.2,-16.4},{-92,
          -16.4},{-92,40},{50.05,40},{50.05,-69.95}},       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(proPreT.y, preTem.T)
      annotation (Line(points={{-73.4,20},{-62,20}}, color={0,0,127}));
  connect(proPreT.u2, weaBus.dummy) annotation (Line(points={{-87.2,23.6},{-92,
          23.6},{-92,40},{50.05,40},{50.05,-69.95}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T, proPreT.u1)
    annotation (Line(points={{-110,20},{-100,20},{-100,16.4},{-87.2,16.4}},
                                                           color={0,0,127}));
  connect(layMul.port_b, preFlo.port) annotation (Line(points={{-10,0},{-10,0},{
          -20,0},{-20,-20},{-40,-20}}, color={191,0,0}));
  connect(preTem.port, layMul.port_b) annotation (Line(points={{-40,20},{-20,20},
          {-20,0},{-10,0}}, color={191,0,0}));
  connect(TConst.y, proPreT.u1) annotation (Line(points={{-99.5,37},{-96,37},{-96,
          16.4},{-87.2,16.4}},
                         color={0,0,127}));
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{49,-87},{50,-87},{50,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boundary1.ports[1], propsBusInt.port_1) annotation (Line(points={{-8,-30},
          {42,-30},{42,19.91},{56.09,19.91}}, color={0,127,255}));
  connect(boundary2.ports[1], propsBusInt.port_2) annotation (Line(points={{-8,-66},
          {44,-66},{44,19.91},{56.09,19.91}},                   color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-60,-100},{60,100}}),
        graphics={
        Rectangle(
          extent={{-50,-90},{50,-70}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,80},{50,100}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-50,80},{50,80}},
          color={175,175,175}),
        Line(
          points={{-50,-70},{50,-70}},
          color={175,175,175}),
        Line(
          points={{-50,-90},{50,-90}},
          color={175,175,175}),
        Line(
          points={{-50,100},{50,100}},
          color={175,175,175}),
        Rectangle(
          extent={{-10,80},{10,-70}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{-10,80},{-10,-70}},
          smooth=Smooth.None,
          color={175,175,175}),
        Line(
          points={{10,80},{10,-70}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=0.5)}),
    Documentation(info="<html>
<p>
This is a wall model that should be used
to simulate a wall between a zone and a prescribed temperature or prescribed heat flow rate boundary condition.
See <a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface>IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface</a> 
for equations, options, parameters, validation and dynamics that are common for all surfaces.
</p>
<h4>Main equations</h4>
<p>
Specific to this model is that the model does not contain a convection or radiative heat exchange model at the outside of the wall.
Instead a prescribed temperature or heat flow rate may be set.
</p>
<h4>Typical use and important parameters</h4>
<p>
Parameters <code>use_T_in</code> and <code>use_Q_in</code> may be used
to enable an input for a prescribed boundary condition temperature or heat flow rate.
Alternatively, parameters <code>use_T_fixed</code> and <code>T_fixed</code> can be used
to specify a fixed boundary condition temperature.
It is not allowed to enabled multiple of these three options. 
If all are disabled then an adiabatic boundary (<code>Q_flow=0</code>) is used.
</p>
</html>", revisions="<html>
<ul>
<li>
April 26, 2020, by Filip Jorissen:<br/>
Refactored <code>SolBus</code> to avoid many instances in <code>PropsBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1131\">
#1131</a>
</li>
<li>
January 25, 2019, by Filip Jorissen:<br/>
Revised initial equation implementation.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/971>#971</a>.
</li>
<li>
December 2, 2018 by Filip Jorissen:<br/>
Added option for setting fixed boundary condition temperature.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/961\">
#961</a>. 
</li>
<li>
August 10, 2018 by Damien Picard:<br/>
Set nWin final to 1 as this should only be used for windows.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/888\">
#888</a>. 
</li>
<li>
March 22, 2017, by Filip Jorissen:<br/>
Changes for JModelica compatibility.
</li>
<li>
January 2, 2017, by Filip Jorissen:<br/>
Updated icon layer.
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
December 7, 2016, by Damien Picard:<br/>
Set placeCapacityAtSurf_b to false for last layer of layMul when T_in is used and the sim.lineariseDymola is true.
Having a capacity connected directly to the prescribed temperature would require to have the derivative of T_in
when linearized.
The dynamics of the last layer is further set to dynamicFreeInitial when T_in is used to avoid an initialization problem.
</li>
<li>
March 8, 2016, by Filip Jorissen:<br/>
Fixed energyDynamics when using fixed temperature boundary condition input.
This is discussed in issue 462.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: cleaned up connections and partials.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
Adjusted implementation for computing conservation of energy.
</li>
</ul>
</html>"));
end BoundaryWall;
