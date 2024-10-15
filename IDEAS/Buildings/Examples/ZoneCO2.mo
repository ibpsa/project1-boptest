within IDEAS.Buildings.Examples;
model ZoneCO2 "Zone with CO2 concentration model"
  extends Modelica.Icons.Example;
  replaceable package Medium = IDEAS.Media.Air(extraPropertiesNames={"test", "CO2"});
  inner BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  IDEAS.Buildings.Components.Examples.BaseClasses.SimpleZone zone(
    redeclare Components.Occupants.Input occNum,
    redeclare package Medium = Medium)
    "Zone model"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Pulse pulse(
    offset=0,
    period=7200,
    amplitude=5)
              annotation (Placement(transformation(extent={{40,0},{20,20}})));

  IDEAS.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium, nPorts=1)
    "Ideal pressure source"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    use_T_in=true,
    use_Xi_in=true,
    use_C_in=true,
    use_m_flow_in=true,
    nPorts=1)           "Ideal flow rate source" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-28,70})));
  Modelica.Blocks.Logical.Hysteresis hys(uLow=750, uHigh=850)
    "Hysteresis controller using CO2 concentration" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,40})));
  Modelica.Blocks.Math.BooleanToReal m_flow(              realFalse=0, realTrue=
       0.04)
    "Flow rate when ventilation is enabled" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={10,70})));
protected
  BoundaryConditions.WeatherData.Bus weaDatBus1
                            "Weather data bus connectable to weaBus connector from Buildings Library"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Sources.RealExpression CEnv[max(Medium.nC,1)](y=sim.CEnv.y*
        s_co2)
    annotation (Placement(transformation(extent={{-62,78},{-44,94}})));
protected
  final parameter Real s_co2[max(Medium.nC,1)] = {if Modelica.Utilities.Strings.isEqual(string1=if Medium.nC>0 then Medium.extraPropertiesNames[i] else "",
                                             string2="CO2",
                                             caseSensitive=false)
                                             then 1 else 0 for i in 1:max(Medium.nC,1)};

equation
  connect(pulse.y, zone.yOcc) annotation (Line(points={{19,10},{0,10},{0,14},{-18,
          14}}, color={0,0,127}));
  connect(sim.weaDatBus, weaDatBus1) annotation (Line(
      points={{-80.1,90},{-70,90}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary.T_in, weaDatBus1.TDryBul)
    annotation (Line(points={{-24,82},{-24,90},{-70,90}}, color={0,0,127}));
  connect(boundary.Xi_in[1], weaDatBus1.X_wEnv)
    annotation (Line(points={{-32,82},{-32,90},{-70,90}}, color={0,0,127}));
  connect(hys.u, zone.ppm)
    annotation (Line(points={{10,28},{10,10},{-19,10}}, color={0,0,127}));
  connect(m_flow.y, boundary.m_flow_in)
    annotation (Line(points={{10,81},{-20,81},{-20,82}}, color={0,0,127}));
  connect(m_flow.u, hys.y)
    annotation (Line(points={{10,58},{10,51}}, color={255,0,255}));
  connect(CEnv.y, boundary.C_in)
    annotation (Line(points={{-43.1,86},{-36,86},{-36,82}}, color={0,0,127}));
  connect(boundary.ports[1], zone.ports[2])
    annotation (Line(points={{-28,60},{-30,60},{-30,20}}, color={0,127,255}));
  connect(bou.ports[1], zone.ports[1])
    annotation (Line(points={{-60,50},{-30,50},{-30,20}}, color={0,127,255}));
  annotation (experiment(
      StopTime=100000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"), Documentation(info="<html>
<p>
This model demonstrates how to use the zone model for
simulating the CO2 generation caused by occupants.
</p>
</html>", revisions="<html>
<ul>
<li>
March 17, 2020 by Filip Jorissen:<br/>
Revised fluid port connections to use <code>ports</code> instead 
of <code>port_a</code> and <code>port_b</code>.
This is for 
<a href=https://github.com/open-ideas/IDEAS/issues/1029>#1029</a>.
</li>
<li>
September 24, 2018 by Filip Jorissen:<br/>
Fix for supporting multiple trace substances.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/920\">#920</a>.
</li>
<li>
July 27, 2018 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/868\">#868</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Examples/ZoneCO2.mos"
        "Simulate and plot"));
end ZoneCO2;
