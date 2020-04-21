within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Emetteurs;
model Cooler

  replaceable package MediumA = Buildings.Media.Air "Medium for air";
   replaceable package MediumW =
      Modelica.Media.Interfaces.PartialMedium "Fluid in the component"
      annotation (choicesAllMatching = true);
protected
  parameter Modelica.SIunits.Volume V=6*10*3 "Room volume";
  //////////////////////////////////////////////////////////
  // Heat recovery effectiveness
  parameter Real eps = 0.8 "Heat recovery effectiveness";

  /////////////////////////////////////////////////////////
  // Air temperatures at design conditions
  parameter Modelica.SIunits.Temperature TASup_nominal = 273.15+18
    "Nominal air temperature supplied to room";
  parameter Modelica.SIunits.Temperature TRooSet = 273.15+24
    "Nominal room air temperature";
  parameter Modelica.SIunits.Temperature TOut_nominal = 273.15+30
    "Design outlet air temperature";
  parameter Modelica.SIunits.Temperature THeaRecLvg=
    TOut_nominal - eps*(TOut_nominal-TRooSet)
    "Air temperature leaving the heat recovery";

  /////////////////////////////////////////////////////////
  // Cooling loads and air mass flow rates
  parameter Modelica.SIunits.HeatFlowRate QRooInt_flow=
     1000 "Internal heat gains of the room";
  parameter Modelica.SIunits.HeatFlowRate QRooC_flow_nominal=
    -QRooInt_flow-10E3/30*(TOut_nominal-TRooSet)
    "Nominal cooling load of the room";
  parameter Modelica.SIunits.MassFlowRate mA_flow_nominal=
    1.3*QRooC_flow_nominal/1006/(TASup_nominal-TRooSet)
    "Nominal air mass flow rate, increased by factor 1.3 to allow for recovery after temperature setback";
  parameter Modelica.SIunits.TemperatureDifference dTFan = 2
    "Estimated temperature raise across fan that needs to be made up by the cooling coil";
  parameter Modelica.SIunits.HeatFlowRate QCoiC_flow_nominal=4*
    (QRooC_flow_nominal + mA_flow_nominal*(TASup_nominal-THeaRecLvg-dTFan)*1006)
    "Cooling load of coil, taking into account economizer, and increased due to latent heat removal";

  /////////////////////////////////////////////////////////
  // Water temperatures and mass flow rates
  parameter Modelica.SIunits.Temperature TWSup_nominal = 273.15+16
    "Water supply temperature";
  parameter Modelica.SIunits.Temperature TWRet_nominal = 273.15+12
    "Water return temperature";
  parameter Modelica.SIunits.MassFlowRate mW_flow_nominal=
    QCoiC_flow_nominal/(TWRet_nominal-TWSup_nominal)/4200
    "Nominal water mass flow rate";
public
  parameter Modelica.SIunits.MassFlowRate mW_flow_max = 86*1053/3600/6
    "Maximal water mass flow rate";

  parameter Real k=1e-2 "Gain of controller";
  parameter Modelica.SIunits.Time Ti=1 "Time constant of Integrator block";
public
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    constantMassFlowRate=mA_flow_nominal*10,
    dp_nominal=6000,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    m_flow_nominal=mA_flow_nominal,
    use_inputFilter=false)   "Supply air fan"
    annotation (Placement(transformation(extent={{58,-36},{78,-16}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness
                                                    cooCoi(
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=mW_flow_nominal,
    m2_flow_nominal=mA_flow_nominal,
    dp1_nominal=6000,
    dp2_nominal=200,
    show_T=true,
    redeclare package Medium1 = MediumW,
    eps=0.7)                  "Cooling coil"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={12,-32})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-138,52},{-94,96}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemHXOut(redeclare package
      Medium = MediumA, m_flow_nominal=mA_flow_nominal)
    "Temperature sensor for heat recovery outlet on supply side"
    annotation (Placement(transformation(extent={{-16,-32},{-4,-20}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemSupAir(redeclare package
      Medium = MediumA, m_flow_nominal=mA_flow_nominal)
    "Temperature sensor for supply air"
    annotation (Placement(transformation(extent={{38,-32},{50,-20}})));
  Regulation.Regul_Clim_1_bis Regul_Clim(
    k=k,
    Ti=Ti,
    yMax=mW_flow_max,
    yMin=0.001)
    annotation (Placement(transformation(extent={{-104,26},{-68,40}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_bw(redeclare package Medium =
        MediumW) "Fluid connector b eau"
    annotation (Placement(transformation(extent={{114,-16},{134,4}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-126,-16},{-106,4}})));
  Modelica.Blocks.Interfaces.RealInput T
    annotation (Placement(transformation(extent={{-160,28},{-120,68}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_ba(redeclare package Medium =
        MediumA) "Fluid connector b air"
    annotation (Placement(transformation(extent={{114,32},{134,52}})));
  Buildings.Fluid.Sources.Outside out(          redeclare package Medium =
        MediumA, nPorts=1)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Fluid.Machines.ControlledPump
                          pump1(
    N_nominal=1500,
    use_m_flow_set=true,
    redeclare package Medium = MediumW,
    m_flow_start=mW_flow_max,
    m_flow_nominal=mW_flow_max,
    p_a_start=110000,
    p_b_start=130000,
    T_start=285.15,
    p_a_nominal=110000,
    p_b_nominal=130000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0,
        origin={64,-74})));
  Buildings.Fluid.Sensors.Temperature senTem(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{14,-66},{24,-56}})));
  Buildings.Fluid.Sensors.Temperature senTem1(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{84,-66},{94,-56}})));
  Modelica.Blocks.Math.Gain gain(k=1.3)
    annotation (Placement(transformation(extent={{12,22},{32,42}})));
  Modelica.Blocks.Interfaces.RealInput ConsigneClim
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-160,-8},{-120,32}})));
equation

  connect(senTemHXOut.port_b,cooCoi. port_a2) annotation (Line(
      points={{-4,-26},{2,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cooCoi.port_b2,senTemSupAir. port_a) annotation (Line(
      points={{22,-26},{38,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemSupAir.port_b,fan. port_a) annotation (Line(
      points={{50,-26},{58,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fan.port_b,port_ba)  annotation (Line(points={{78,-26},{84,-26},{
          92,-26},{92,42},{124,42}}, color={0,127,255}));
  connect(cooCoi.port_a1,port_a)  annotation (Line(points={{22,-38},{34,-38},
          {34,-42},{34,-90},{-100,-90},{-100,-6},{-116,-6}},
                                                           color={0,127,255}));
  connect(out.weaBus,weaBus)  annotation (Line(
      points={{-80,-29.8},{-92,-29.8},{-92,-28},{-92,74},{-116,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(cooCoi.port_b1,pump1. port_a) annotation (Line(points={{2,-38},{
          -6,-38},{-12,-38},{-12,-74},{54,-74}},  color={0,127,255}));
  connect(pump1.port_b,port_bw)  annotation (Line(points={{74,-74},{112,-74},
          {112,-6},{124,-6}},
                            color={0,127,255}));
  connect(out.ports[1],senTemHXOut. port_a) annotation (Line(points={{-60,-30},
          {-44,-30},{-44,-26},{-16,-26}},      color={0,127,255}));
  connect(senTem.port,pump1. port_a) annotation (Line(points={{19,-66},{20,
          -66},{20,-74},{54,-74}}, color={0,127,255}));
  connect(senTem1.port,port_bw)  annotation (Line(points={{89,-66},{90,-66},
          {90,-74},{112,-74},{112,-6},{124,-6}},
                                               color={0,127,255}));
  connect(Regul_Clim.yCoo, pump1.m_flow_set) annotation (Line(points={{-64.4,
          33},{-20,33},{-20,0},{59,0},{59,-65.8}}, color={0,0,127}));
  connect(Regul_Clim.yCoo, gain.u) annotation (Line(points={{-64.4,33},{-26.2,
          33},{-26.2,32},{10,32}}, color={0,0,127}));
  connect(gain.y, fan.m_flow_in) annotation (Line(points={{33,32},{67.8,32},
          {67.8,-14}}, color={0,0,127}));
  connect(T, Regul_Clim.T) annotation (Line(points={{-140,48},{-114,48},{-114,33},
          {-106.88,33}}, color={0,0,127}));
  connect(ConsigneClim, Regul_Clim.ConsigneClim) annotation (Line(points={{-140,12},
          {-114,12},{-114,28.3333},{-106.88,28.3333}},     color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This part of the system model modifies
<a href=\"modelica://Buildings.Examples.Tutorial.SpaceCooling.System2\">
Buildings.Examples.Tutorial.SpaceCooling.System2</a>
to use the actual outside temperature for a summer day,
and it adds closed loop control.
The closed loop control measures the room temperature and switches
the chilled water flow rate on or off.
</p>
<h4>Implementation</h4>
<p>
This section describes how we modified
<a href=\"modelica://Buildings.Examples.Tutorial.SpaceCooling.System2\">
Buildings.Examples.Tutorial.SpaceCooling.System2</a>
to build this model.
</p>
<ol>
<li>
<p>
The first step was to copy the model
<a href=\"modelica://Buildings.Examples.Tutorial.SpaceCooling.System2\">
Buildings.Examples.Tutorial.SpaceCooling.System2</a>.
</p>
</li>
<li>
<p>
Next, we changed in <code>weaDat</code> the parameter that determines
whether the outside dry bulb temperature is used from the weather data file
or set to a constant value. This can be accomplished in the GUI of the weather data reader
as follows:
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/SpaceCooling/System3TOutChange.png\" border=\"1\"/>
</p>
</li>
</ol>
<p>
If the model is now simulated, the following plot could be generated that shows that the
room is cooled too much due to the open loop control:
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/SpaceCooling/System3TemperaturesOpenLoop.png\" border=\"1\"/>
</p>
<p>
To add closed loop control, we proceeded as follows.
</p>
<ol start=\"3\">
<li>
<p>
First, we made an instance of the on/off controller
<a href=\"modelica://Modelica.Blocks.Logical.OnOffController\">
Modelica.Blocks.Logical.OnOffController</a> and set its name to <code>con</code>.
We set the parameter for the bandwidth to <i>1</i> Kelvin.
This model requires as an input the measured temperature and the set point.
</p>
</li>
<li>
<p>
For the set point, we made the instance <code>TRooSetPoi</code> to feed a constant
set point into the controller.
</p>
</li>
<li>
<p>
The instance <code>senTemRoo</code> has been added to measure the room air temperature.
Note that we decided to measure directly the room air temperature. If we would have used
a temperature sensor in the return air stream, then its temperature would never change when
the mass flow rate is zero, and hence it would not measure how the room temperature changes
when the fan is off.
</p>
</li>
<li>
<p>
Since the controller output is a boolean signal, but the instance
<code>souWat</code> needs a real signal as an input for the water mass flow rate,
we needed to add a conversion block. We therefore replaced the instance
<code>mWat_flow</code> from a constant block to the block
<a href=\"modelica://Modelica.Blocks.Math.BooleanToReal\">
Modelica.Blocks.Math.BooleanToReal</a>.
Because the cooling control has a reverse action, i.e.,
if the measured value exceeds the set point, the system should switch
on instead of off, we configured the parameters of the conversion block
as follow:
</p>
<pre>
  realTrue=0
  realFalse=mW_flow_nominal
</pre>
<p>
This will output <code>mW_flow_nominal</code> when the room temperature
is above the set point, and <i>0</i> otherwise.
</p>
</li>
</ol>
<p>
This completes building the model shown in the figure on
<a href=\"modelica://Buildings.Examples.Tutorial.SpaceCooling\">
Buildings.Examples.Tutorial.SpaceCooling</a>.
When simulating the model, the response shown below should be seen.
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/SpaceCooling/System3TemperaturesClosedLoop.png\" border=\"1\"/>
<br/>
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/SpaceCooling/System3FlowRateClosedLoop.png\" border=\"1\"/>
</p>
<!-- Notes -->
<h4>Notes</h4>
<p>
To add a continuous controller for the coil water flow rate, we could have used the model
<a href=\"modelica://Buildings.Controls.Continuous.LimPID\">
Buildings.Controls.Continuous.LimPID</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
January 28, 2015 by Michael Wetter:<br/>
Added thermal mass of furniture directly to air volume.
This avoids an index reduction.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
January 11, 2012, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-120,-100},
            {120,80}})),
    __Dymola_Commands(file=
     "modelica://Buildings/Resources/Scripts/Dymola/Examples/Tutorial/SpaceCooling/System3.mos"
        "Simulate and plot"),
    experiment(StartTime=1.5552e+07, StopTime=15638400),
    Icon(coordinateSystem(extent={{-120,-100},{120,80}})));
end Cooler;
