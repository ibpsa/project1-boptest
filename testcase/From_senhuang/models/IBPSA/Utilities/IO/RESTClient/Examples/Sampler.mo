within IBPSA.Utilities.IO.RESTClient.Examples;
model Sampler "Sanpling the simulation data and sending it to external servers"
 extends Modelica.Icons.Example;
   inner IBPSA.Utilities.IO.RESTClient.Configuration config(
   samplePeriod=0.5,
   activation=IBPSA.Utilities.IO.RESTClient.Types.GlobalActivation.use_input)
     "Configuration for the sampler block"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  IBPSA.Utilities.IO.RESTClient.Send_Real sam(
    numVar=2,
    samplePeriod=1,
    hostAddress="127.0.0.1",
    tcpPort=8888,
    oveSig(fixed=true),
    varName={"sig1","sig2"})
     "Sampler block"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));

  Modelica.Blocks.Sources.Sine sinSig1(amplitude=2, freqHz=1/60)
     "Control signal 1 to be overwritten"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Sine sinSig2(freqHz=1/30)
     "Control signal 2 to be overwritten"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.BooleanExpression oveCon(y=time > 60)
     "Boolean command to enable/disenable the overwritten block"
    annotation (Placement(transformation(extent={{-20,68},{0,88}})));
equation
  connect(oveCon.y, config.activate)
    annotation (Line(points={{1,78},{29.5,78},{58,78}}, color={255,0,255}));
  connect(sinSig2.y, sam.u[2]) annotation (Line(points={{-59,20},{-20,20},{-20,1},
          {-2,1}}, color={0,0,127}));
  connect(sinSig1.y, sam.u[1]) annotation (Line(points={{-59,-40},{-20,-40},{-20,
          -1},{-2,-1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
   experiment(StopTime=120, Tolerance=1e-006),
__Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Utilities/IO/RESTClient/Examples/Sampler.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>This example demonstrates the use of a sampler that sends time series to a remoted server. Please start the socket server IBPSA/Resources/src/SocketServer/Utilities/IO/RESTClient/Examples/Server.py before starting this example. </p>
</html>", revisions="<html>
<ul>
<li>
June 18, 2018 by Sen Huang:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/926\">#926</a>.
</li>
</ul>
</html>"));
end Sampler;
