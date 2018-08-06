within IBPSA.Experimental.Benchmarks.AirFlow.Examples;
model ZoneStepResponse
  "Example to test the thermal step response of a SimpleZone"
  extends Modelica.Icons.Example;

  replaceable package Medium = IBPSA.Media.Air "Medium in the component";

  output Modelica.SIunits.Temperature TRoom = simpleZone.volRoom.heatPort.T
    "Room temperature at volume's therm port";

  Components.SimpleZone simpleZone(redeclare package Medium = Medium)
    "Simple zone element for step response test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.Sources.MassFlowSource_T boundary(nPorts=1, m_flow=0.05,
    redeclare package Medium = Medium,
    use_T_in=true) "Mass flow source for air exchange in the zone"
    annotation (Placement(transformation(extent={{-60,-2},{-40,18}})));
  Fluid.Sources.FixedBoundary bou(nPorts=2, redeclare package Medium = Medium)
    "Boundary condition for air exchange in the zone"
                                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,0})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      TDryBulSou=IBPSA.BoundaryConditions.Types.DataSource.Input, filNam=
        Modelica.Utilities.Files.loadResource("modelica://IBPSA/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader for input data"
    annotation (Placement(transformation(extent={{-62,-52},{-42,-32}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather bus for temperature input"
                                      annotation (Placement(
        transformation(extent={{-104,14},{-64,54}}), iconTransformation(extent=
            {{-116,30},{-96,50}})));
  Modelica.Blocks.Sources.Step step(
    height=5,
    startTime=4000000,
    offset=5 + 273.15)
    annotation (Placement(transformation(extent={{-98,-42},{-80,-24}})));
equation
  connect(boundary.ports[1], simpleZone.port_a_vent) annotation (Line(
      points={{-40,8},{-10,8}},
      color={0,127,255}));
  connect(simpleZone.port_b, bou.ports[1]) annotation (Line(
      points={{10,-6},{26,-6},{26,-2},{40,-2}},
      color={0,127,255}));
  connect(simpleZone.port_a, bou.ports[2]) annotation (Line(
      points={{10,6},{26,6},{26,2},{40,2}},
      color={0,127,255}));
  connect(weaDat.weaBus, simpleZone.weaBus) annotation (Line(
      points={{-42,-42},{-26,-42},{-26,4},{-11.8,4}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary.T_in, weaBus.TDryBul) annotation (Line(
      points={{-62,12},{-70,12},{-70,34},{-84,34}},
      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-42,-42},{-26,-42},{-26,-16},{-84,-16},{-84,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(step.y, weaDat.TDryBul_in) annotation (Line(
      points={{-79.1,-33},{-63,-33}},
      color={0,0,127}));
  annotation (    experiment(Tolerance=1e-6, StopTime=6e+006, Interval=200),
    __Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Experimental/Benchmarks/AirFlow/Examples/ZoneStepResponse.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>This example tests the step response of the SimpleZone model for the airflow benchmark. It uses
the weather file <code>STEP_TMY.mos</code>, that implements a <i>5 </i> Kelvin step at <i>t=400 000</i>
seconds. In the Buildings library, the room model of BESTEST 600 FF needs around <i>4-5</i> hours in
order to reach <i>2/3</i> of the maximum step response to this weather file. This time constant is
approximated with a value of <code>mSenFac = 75</code> for the mixing volume of the zone.</p>
<p>The mass flow rate of air to the zone is <i>0.05</i> kg/s, which approximates an air exchange
rate of <i>3</i> times the air volume per hour. </p>
</html>", revisions="<html>
<ul>
<li>
May 28, 2015, by Marcus Fuchs:<br/>
First implementation.
</li>
</ul>
</html>"));
end ZoneStepResponse;
