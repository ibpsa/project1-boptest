within IBPSA.Utilities.IO.RESTClient.Examples;
model OverWritten "Overwriting the control signals based on external source"
 extends Modelica.Icons.Example;
  inner IBPSA.Utilities.IO.RESTClient.Configuration config(
    samplePeriod=0.5, activation=IBPSA.Utilities.IO.RESTClient.Types.GlobalActivation.use_input)
     "Configuration for the overwritten block"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  IBPSA.Utilities.IO.RESTClient.Read_Real oveWri(
    numVar=2,
    samplePeriod=1,
    oveSig(fixed=true, start={0,0}),
    hostAddress="127.0.01",
    tcpPort=8888,
    threshold=0.5,
    tSta=1,
    activation=IBPSA.Utilities.IO.RESTClient.Types.LocalActivation.use_activation,
    varName={"sig1","sig2"})
     "Overwritten block"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));

  Modelica.Blocks.Sources.Sine sinSig1(             freqHz=1/60, amplitude=40)
     "Control signal 1 to be overwritten"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Sine sinSig2(freqHz=1/30, amplitude=2)
     "Control signal 2 to be overwritten"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.BooleanExpression oveCon(y=time > 120)
     "Boolean command to enable/disenable the overwritten block"
    annotation (Placement(transformation(extent={{-20,68},{0,88}})));
equation
  connect(oveCon.y, config.activate)
    annotation (Line(points={{1,78},{30,78},{58,78}}, color={255,0,255}));
  connect(sinSig1.y, oveWri.u[1]) annotation (Line(points={{-59,-40},{-38,-40},
          {-16,-40},{-16,-1},{-2,-1}}, color={0,0,127}));
  connect(sinSig2.y, oveWri.u[2]) annotation (Line(points={{-59,20},{-38,20},{
          -16,20},{-16,1},{-2,1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
   experiment(Tolerance=1e-6, StartTime=0, StopTime=120),
__Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Utilities/IO/RESTClient/Examples/OverWritten.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>This example demonstrates the use of an overwritten block that overwrites control signals in the simulation based on a remoted server. Please start the socket server IBPSA/Resources/src/SocketServer/Utilities/IO/RESTClient/Examples/Server.py before simulating this model. </p>
</html>", revisions="<html>
<ul>
<li>
June 18, 2018 by Sen Huang:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/926\">#926</a>.
</li>
</ul>
</html>"));
end OverWritten;
