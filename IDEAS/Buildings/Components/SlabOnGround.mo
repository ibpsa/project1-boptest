within IDEAS.Buildings.Components;
model SlabOnGround "opaque floor on ground slab"
  extends IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface(
    custom_q50=0,
    final use_custom_q50=true,
    final nWin=1,
    QTra_design=UEqui*A*(273.15 + 21 - sim.Tdes),
    add_cracks=false,
    dT_nominal_a=-3,
    inc=IDEAS.Types.Tilt.Floor,
    azi=0,
    redeclare replaceable Data.Constructions.FloorOnGround constructionType,
    layMul(disableInitPortB=true),
    q50_zone(v50_surf=0));

  parameter Modelica.SIunits.Length PWall=4*sqrt(A)
    "Total floor slab perimeter";
  parameter Modelica.SIunits.Temperature TeAvg=273.15 + 10.8
    "Annual average outdoor temperature";
  parameter Modelica.SIunits.Temperature TiAvg=273.15 + 22
    "Annual average indoor temperature";
  parameter Modelica.SIunits.TemperatureDifference dTeAvg = 4
    "Amplitude of variation of monthly average outdoor temperature";
  parameter Modelica.SIunits.TemperatureDifference dTiAvg = 2
    "Amplitude of variation of monthly average indoor temperature";
  parameter Boolean linearise=sim.lineariseDymola
    "= true, if heat flow to ground should be linearized"
    annotation(Dialog(tab="Convection"));
  Modelica.SIunits.HeatFlowRate Qm = if not linearise then UEqui*A*(TiAvg - TeAvg) - Lpi*dTiAvg*cos(2*3.1415/12*(m- 1 + alfa)) + Lpe*dTeAvg*cos(2*3.1415/12*(m - 1 - beta)) else
    sum({UEqui*A*(TiAvg - TeAvg) - Lpi*dTiAvg*cos(2*3.1415/12*(i- 1 + alfa)) + Lpe*dTeAvg*cos(2*3.1415/12*(i - 1 - beta)) for i in 1:12})/12
    "Two-dimensional correction for edge flow";

//Calculation of heat loss based on ISO 13370
  IDEAS.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Medium,
    nPorts=1,
    final m_flow=1e-10) if
       sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None
    annotation (Placement(transformation(extent={{-28,-40},{-8,-20}})));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = Medium,
    nPorts=1,
    final m_flow=0) if
       sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts
    annotation (Placement(transformation(extent={{-28,-76},{-8,-56}})));
protected
  final parameter IDEAS.Buildings.Data.Materials.Ground ground1(final d=0.50);
  final parameter IDEAS.Buildings.Data.Materials.Ground ground2(final d=0.33);
  final parameter IDEAS.Buildings.Data.Materials.Ground ground3(final d=0.17);
  final parameter Real U_value=1/(1/6 + sum(constructionType.mats.R) + 0)
    "Floor theoretical U-value";

  final parameter Modelica.SIunits.Length B=A/(0.5*PWall + 1E-10)
    "Characteristic dimension of the slab on ground";
  final parameter Modelica.SIunits.Length dt=sum(constructionType.mats.d) + ground1.k*1/U_value
    "Equivalent thickness";//Thickness of basement walls assumed to be as the thickness of the slab
  final parameter Real UEqui=if (dt<B) then (2*ground1.k/(Modelica.Constants.pi*B+dt)*Modelica.Math.log(Modelica.Constants.pi*B/dt+1)) else (ground1.k/(0.457*B + dt))
    "Equivalent thermal transmittance coefficient";
  final parameter Real alfa=1.5 - 12/(2*3.14)*atan(dt/(dt + delta));
  final parameter Real beta=1.5 - 0.42*log(delta/(dt + 1));
  final parameter Real delta=sqrt(3.15*10^7*ground1.k/3.14/ground1.rho/ground1.c);
  final parameter Real Lpi=A    *ground1.k/dt*sqrt(1/((1 + delta/dt)^2 + 1));
  final parameter Real Lpe=0.37*PWall*ground1.k*log(delta/dt + 1);
  Real m = sim.solTim.y/3.1536e7*12 "time in months";

  BaseClasses.ConductiveHeatTransfer.MultiLayer layGro(
    final inc=incInt,
    final nLay=3,
    final mats={ground1,ground2,ground3},
    final T_start={TeAvg,TeAvg,TeAvg},
    monLay(each energyDynamics=energyDynamics),
    final A=A)
    "Declaration of array of resistances and capacitances for ground simulation"
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow periodicFlow(T_ref=284.15)
                annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,22})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow adiabaticBoundary(Q_flow=0,
      T_ref=285.15)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-30,36},{-38,44}})));
  Modelica.Blocks.Sources.RealExpression Qm_val(y=-Qm)
    annotation (Placement(transformation(extent={{0,50},{-20,70}})));
  IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(numSolBus=sim.numIncAndAziInBus,
      outputAngles=sim.outputAngles)
    "Weather data bus connectable to weaBus connector from Buildings Library"
    annotation (Placement(transformation(extent={{46,-90},{66,-70}})));
equation

  connect(periodicFlow.port, layMul.port_b) annotation (Line(points={{-20,22},{
          -14,22},{-14,0},{-10,0}}, color={191,0,0}));
  connect(layGro.port_a, layMul.port_b)
    annotation (Line(points={{-20,0},{-15,0},{-10,0}}, color={191,0,0}));
  connect(layGro.port_b, adiabaticBoundary.port)
    annotation (Line(points={{-40,0},{-45,0},{-50,0}}, color={191,0,0}));
  connect(Qm_val.y, product.u1) annotation (Line(points={{-21,60},{-26,60},{-26,
          42.4},{-29.2,42.4}}, color={0,0,127}));
  connect(product.u2, weaBus.dummy) annotation (Line(points={{-29.2,37.6},{
          56.05,37.6},{56.05,-79.95}},color={0,0,127}));
  connect(product.y, periodicFlow.Q_flow) annotation (Line(points={{-38.4,40},{-50,
          40},{-50,22},{-40,22}}, color={0,0,127}));
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{49,-87},{56,-87},{56,-80}},
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
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-60,-100},{60,100}}),
        graphics={
        Rectangle(
          extent={{-50,-70},{50,100}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,-90},{50,-70}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-50,-20},{-30,-20},{-30,-70},{-30,-70},{-30,-70}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,-20},{-50,-90},{-50,-90}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,60},{-30,60},{-30,80},{50,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,60},{-50,66},{-50,100},{50,100}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-44,60},{-44,-20}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,-70},{50,-70}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None)}),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-60,-100},{60,100}})),
    Documentation(info="<html>
<p>
This is a floor model that should be used to
simulate floors on solid ground.
See <a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface>IDEAS.Buildings.Components.Interfaces.PartialOpaqueSurface</a> 
for equations, options, parameters, validation and dynamics that are common for all surfaces.
</p>
<h4>Typical use and important parameters</h4>
<p>
The model contains several parameters that are used
to set up a simplified model of the influence of the 
environment on the ground themperature.
The model assumes that the floor plate is connected to a (heated)
zone that is surrounded by air at the ambient temperature.
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
October 13, 2019, by Filip Jorissen:<br/>
Refactored the parameter definition of <code>inc</code> 
and <code>azi</code> by adding the option to use radio buttons.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1067\">
#1067</a>
</li>
<li>
January 25, 2019, by Filip Jorissen:<br/>
Revised initial equation implementation.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/971>#971</a>.
</li>
<li>
August 10, 2018 by Damien Picard:<br/>
Set nWin final to 1 as this should only be used for windows.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/888\">
#888</a>. 
</li>
<li>
May 14, 2018, by Filip Jorissen:<br/>
Revised value of <code>energyDynamics</code>
for ground layers such that unique initial conditions
can be defined.
</li>
<li>
January 2, 2017, by Filip Jorissen:<br/>
Added default values for parameters <code>inc</code> and 
<code>azi</code>.
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
December 7, 2016 by Damien Picard:<br/>
Set placeCapacityAtSurf_b to false for the last layMul layer. 
This is necessary due to the initialization which is overspecified when two capacities are
connected to each other without resistances between. 
Using dynamicFreeInitial for both the first layer of layGro and 
the last one of LayMul did not solve the problem.
</li>
<li>
September 27, 2016 by Filip Jorissen:<br/>
Different initialisation for state between layMul 
and layGround for avoiding conflicting initial equations.
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
end SlabOnGround;
