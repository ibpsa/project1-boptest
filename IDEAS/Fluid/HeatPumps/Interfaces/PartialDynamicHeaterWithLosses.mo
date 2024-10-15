within IDEAS.Fluid.HeatPumps.Interfaces;
partial model PartialDynamicHeaterWithLosses
  "Partial heater model incl dynamics and environmental losses"
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true, dp_nominal = 0);

  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations(
    T_start=293.15,
    redeclare replaceable package Medium = IDEAS.Media.Water);

  parameter Modelica.SIunits.Power QNom "Nominal power";
  parameter Modelica.SIunits.Time tauHeatLoss=7200
    "Time constant of environmental heat losses";
  parameter Modelica.SIunits.Mass mWater=5 "Mass of water in the condensor";
  parameter Modelica.SIunits.HeatCapacity cDry=4800
    "Capacity of dry material lumped to condensor";
  parameter SI.MassFlowRate m_flow_nominal "Nominal mass flow rate";
  parameter SI.Pressure dp_nominal=0 "Pressure";
  parameter Boolean dynamicBalance=true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Dialog(tab="Flow resistance"));
  constant Boolean homotopyInitialization=true "= true, use homotopy method"
    annotation (Dialog(tab="Flow resistance"));
  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal. Used only if model has two ports."
    annotation (Dialog(tab="Flow resistance"));

  Modelica.Blocks.Interfaces.RealInput TSet "Temperature setpoint"
                           annotation (Placement(
        transformation(extent={{-126,-20},{-86,20}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,120})));
  Modelica.Blocks.Interfaces.RealOutput PEl "Electrical consumption"
    annotation (Placement(transformation(extent={{-94,46},{-114,66}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort for thermal losses to environment"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium) "Fluid inlet"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium) "Fluid outlet"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));

  final parameter Modelica.SIunits.ThermalConductance UALoss=mWater*vol.mSenFac/tauHeatLoss
      "Thermal conductance, computed based on time constant and thermal mass";

protected
  final parameter Modelica.SIunits.Density rho_default=
    Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default) "Default medium density";
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLosses(G=
        UALoss) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-70})));

  IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    nPorts=2,
    mSenFac=mSenFac*(1 + cDry/Medium.specificHeatCapacityCp(Medium.setState_pTX(
        Medium.p_default,
        Medium.T_default,
        Medium.X_default))/mWater),
    V=mWater/rho_default,
    allowFlowReversal=allowFlowReversal)
              "Mixing volume for heat injection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-10})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort Tin(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=allowFlowReversal)
                                     "Inlet temperature"
    annotation (Placement(transformation(extent={{80,-70},{60,-50}})));

  IDEAS.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium,
      allowFlowReversal=allowFlowReversal)
    "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));

equation
  assert(port_a.m_flow>-m_flow_nominal/1000, "Flow reversal in " + getInstanceName() + ". This is not supported.");

  connect(port_a, Tin.port_a) annotation (Line(
      points={{100,-60},{80,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.heatPort, thermalLosses.port_a) annotation (Line(
      points={{10,-20},{1.77636e-15,-20},{1.77636e-15,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Tin.port_b, senMasFlo.port_a) annotation (Line(
      points={{60,-60},{50,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(thermalLosses.port_b, heatPort) annotation (Line(
      points={{-1.77636e-015,-80},{-1.77636e-015,-100},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(vol.ports[1], senMasFlo.port_b)
    annotation (Line(points={{20,-12},{20,-60},{30,-60}},
                                                 color={0,127,255}));
  connect(vol.ports[2], port_b)
    annotation (Line(points={{20,-8},{20,60},{100,60}}, color={0,127,255}));
                             annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>This is a partial model from which most heaters (boilers, heat pumps) will extend. This model is <u>dynamic</u> (there is a water content in the heater and a dry mass lumped to it) and it has <u>thermal losses to the environment</u>. To complete this model and turn it into a heater, a <u>heatSource</u> has to be added, specifying how much heat is injected in the heatedFluid pipe, at which efficiency, if there is a maximum power, etc. HeatSource models are grouped in <a href=\"modelica://IDEAS.Thermal.Components.Production.BaseClasses\">IDEAS.Thermal.Components.Production.BaseClasses.</a></p>
<p>The set temperature of the model is passed as a realInput.The model has a realOutput PEl for the electricity consumption.</p>
<p>See the extensions of this model for more details.</p>
<h4>Assumptions and limitations </h4>
<ol>
<li>the temperature of the dry mass is identical as the outlet temperature of the heater </li>
<li>no pressure drop</li>
</ol>
<h4>Model use</h4>
<p>Depending on the extended model, different parameters will have to be set. Common to all these extensions are the following:</p>
<ol>
<li>the environmental heat losses are specified by a <u>time constant</u>. Based on the water content, dry capacity and this time constant, the UA value of the heat transfer to the environment will be set</li>
<li>set the heaterType (useful in post-processing)</li>
<li>connect the set temperature to the TSet realInput connector</li>
<li>connect the flowPorts (flowPort_b is the outlet) </li>
<li>if heat losses to environment are to be considered, connect heatPort to the environment.  If this port is not connected, the dry capacity and water content will still make this a dynamic model, but without heat losses to environment,.  IN that case, the time constant is not used.</li>
</ol>
<h4>Validation </h4>
<p>This partial model is based on physical principles and is not validated. Extensions may be validated.</p>
<h4>Examples</h4>
<p>See the extensions, like the <a href=\"modelica://IDEAS.Thermal.Components.Production.IdealHeater\">IdealHeater</a>, the <a href=\"modelica://IDEAS.Thermal.Components.Production.Boiler\">Boiler</a> or <a href=\"modelica://IDEAS.Thermal.Components.Production.HP_AWMod_Losses\">air-water heat pump</a></p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>2014 March, Filip Jorissen, Annex60 compatibility</li>
</ul>
</html>"));
end PartialDynamicHeaterWithLosses;
