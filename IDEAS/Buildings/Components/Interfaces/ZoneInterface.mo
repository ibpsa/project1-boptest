within IDEAS.Buildings.Components.Interfaces;
partial model ZoneInterface "Partial model for thermal building zones"
  replaceable package Medium = IDEAS.Media.Air
  constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
      annotation (choicesAllMatching = true);
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  parameter Integer nSurf(min=2)
    "Number of surfaces adjacent to and heat exchanging with the zone";
  parameter Integer nPorts(min=0)=2
    "Number of ports for ventilation connections";
  parameter Modelica.SIunits.Volume V "Total zone air volume"
    annotation(Dialog(group="Building physics"));
  parameter Modelica.SIunits.Length hZone = 2.8
    "Zone height: distance between floor and ceiling"
    annotation(Dialog(group="Building physics"));
  parameter Modelica.SIunits.Area A = V/hZone "Total conditioned floor area"
    annotation(Dialog(group="Building physics"));
  parameter Boolean useOccNumInput
    "=false, to remove icon of yOcc"
    annotation(Dialog(tab="Advanced",group="Occupants"));
  parameter Boolean useLigCtrInput
    "=false, to remove icon of lightCtrl"
    annotation(Dialog(tab="Advanced",group="Lighting"));
  //default ACH=2 for ventilation
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = V * 1.2*2/3600
    "Nominal flow rate of the air flow system fluid ports"
    annotation(Dialog(tab="Airflow",group="Air model"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b gainRad
    "Internal zone node for radiative heat gains"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a gainCon
    "Internal zone node for convective heat gains"
    annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
  Modelica.Blocks.Interfaces.RealOutput TSensor(unit="K", displayUnit="degC")
    "Sensor temperature of the zone, i.e. operative temeprature" annotation (
      Placement(transformation(extent={{100,10},{120,30}}), iconTransformation(
          extent={{100,10},{120,30}})));

  // icons removed to discourage the use of these ports
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium,
    m_flow(nominal=m_flow_nominal),
    h_outflow(nominal=Medium.h_default))
    "Port for ventilation connections, deprecated, use 'ports' instead";
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium,
    m_flow(nominal=m_flow_nominal),
    h_outflow(nominal=Medium.h_default))
    "Port for ventilation connections, deprecated, use 'ports' instead";
  Modelica.Blocks.Interfaces.RealInput yOcc if useOccNumInput
    "Control input for number of occupants, used by Occupants.Input and Occupants.AreaWeightedInput"
    annotation (Placement(transformation(extent={{140,20},{100,60}})));
  Modelica.Blocks.Interfaces.RealInput uLig if useLigCtrInput
    "Lighting control input (1 corresponds to 100%), only used when using LightingControl.Input"
    annotation (Placement(transformation(extent={{140,50},{100,90}}),
        iconTransformation(extent={{-130,-40},{-90,0}})));
  Modelica.Blocks.Interfaces.RealOutput ppm(unit="1")
    "CO2 concentration in the zone" annotation (Placement(transformation(extent={{100,-10},
            {120,10}}),           iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports[nPorts](redeclare package Medium =
        Medium) "Ports for ventilation connetions" annotation (Placement(
        transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={0,100})));
  SetVolume setVolume(V=V)
    "Component for contributing zone volume to siminfomanager"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
protected
  Modelica.Blocks.Sources.RealExpression Eexpr "Internal energy model";
  BaseClasses.ConservationOfEnergy.PrescribedEnergy prescribedHeatFlowE
    "Dummy that allows computing total internal energy";
  Modelica.Blocks.Sources.RealExpression Qgai(
    y=(if sim.openSystemConservationOfEnergy or not sim.computeConservationOfEnergy
       then 0
    else gainCon.Q_flow + gainRad.Q_flow)) "Heat gains in model";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowQgai
    "Component for computing conservation of energy";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a dummy1
    "Dummy heat port for avoiding error by dymola translator";
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.EnergyPort dummy2
    "Dummy emergy port for avoiding error by dymola translator";
initial equation
  assert(nSurf>1, "In " + getInstanceName() +
    ": A minimum of 2 surfaces must be connected to the zone.");
  assert(cardinality(port_a)+cardinality(port_b)==2, "In " + getInstanceName() +
    ": You have made connections to port_a or port_b. These connectors will be 
    removed in a future release of IDEAS. Use the connector `ports' instead.",
    AssertionLevel.warning);
  for i in 1:nPorts loop
    assert(cardinality(ports[i])<=2,
      "Each element of ports should have zero or one external connections but " +
      getInstanceName() +".ports[" + String(i) + "] has " + String(cardinality(ports[i]) - 1) + "." +
      " This can cause air to mix at the fluid port, without entering the zone, which is usually unintended.
      Instead, increase nPorts and create a separate connection.",
      level=AssertionLevel.warning);
  end for;
equation
  connect(sim.Qgai, dummy1);
  connect(sim.E, dummy2);
  connect(Eexpr.y,prescribedHeatFlowE.E);
  connect(prescribedHeatFlowE.port, sim.E);
  connect(Qgai.y,prescribedHeatFlowQgai. Q_flow);
  connect(prescribedHeatFlowQgai.port, sim.Qgai);

  connect(setVolume.volumePort, sim.volumePort);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-90,90},{90,-90}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          lineColor={0,0,0}),
        Rectangle(
          extent={{68,70},{-68,-70}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-68,70},{68,70}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Rectangle(
          extent={{-40,-70},{40,-90}},
          lineThickness=0.5,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,-90},{68,22},{68,-42},{40,-70},{40,-90},{-40,-90},{-40,-90}},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-68,70},{-68,-70},{-40,-70},{-40,-80},{40,-80},{40,-70},{68,
              -70},{68,70}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=0.5),
        Text(
          extent={{-39,40},{39,-40}},
          lineColor={0,0,0},
          fontName="Calibri",
          origin={-2,3},
          rotation=0,
          textString="%name")}),
    Documentation(revisions="<html>
<ul>
<li>
September 17, 2020, Filip Jorissen:<br/>
Modified default Medium.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1169\">#1169</a>.
March 21, 2019 by Filip Jorissen:<br/>
</li>
<li>
March 17, 2020, Filip Jorissen:<br/>
Added support for vector fluidport.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1029\">#1029</a>.
March 21, 2019 by Filip Jorissen:<br/>
</li>
<li>
Revised implementation of icon for
<a href=\"https://github.com/open-ideas/IDEAS/issues/996\">#996</a>
and for <a href=\"https://github.com/open-ideas/IDEAS/pull/976\">#976</a>.
</li>
<li>
May 2, 2019 by Filip Jorissen:<br/>
Moved location of <code>ppm</code> in the icon layer such that it
does not overlap with <code>TSensor</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1026\">#1026</a>.
</li>
<li>
March 28, 2019 by Filip Jorissen:<br/>
Renamed <code>nOcc</code> to <code>yOcc</code>
See <a href=\"https://github.com/open-ideas/IDEAS/issues/998\">#998</a>.
</li>
<li>
September 5, 2018 by Iago Cupeiro:<br/>
Added uLig input for controlling lighting
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
<li>
July 27, 2018 by Filip Jorissen:<br/>
Added output for the CO2 concentration.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/868\">#868</a>.
</li>
<li>
July 11, 2018, Filip Jorissen:<br/>
Added nominal values for <code>h_outflow</code> and <code>m_flow</code>
in <code>FluidPorts</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/859\">#859</a>.
</li>
<li>
May 29, 2018, Filip Jorissen:<br/>
Removed conditional fluid ports for JModelica compatibility.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/834\">#834</a>.
</li>
<li>
April 28, 2016, Filip Jorissen:<br/>
Added assert for checking nSurf larger than 1.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
Adjusted implementation for computing conservation of energy.
</li>
<li>
February 10, 2015 by Filip Jorissen:<br/>
Adjusted implementation for grouping of solar calculations.
</li>
</ul>
</html>"));
end ZoneInterface;
