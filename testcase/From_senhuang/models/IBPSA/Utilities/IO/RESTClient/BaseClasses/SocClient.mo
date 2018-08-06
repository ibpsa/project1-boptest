within IBPSA.Utilities.IO.RESTClient.BaseClasses;
function SocClient
  "Function that establishes a client for a TCP socker server and communicates witht the desired server"
  extends Modelica.Icons.Function;
  input Integer numOut "Number of points to be read by the created socket client";
  input Real out[numOut] "Array with points to be read by the created socket client";
  input String varName[numOut] "the variable name";
  input String hostAddress "Host id for the socket server";
  input Integer tcpPort "TCP port for the socket connection";
  output Real oveSig[numOut] "Array with points to be write by the created socket client";
  external "C" swap(numOut,out,varName,hostAddress,tcpPort,oveSig)
annotation(Include="#include <sockclient.c>",
  IncludeDirectory="modelica://IBPSA/Resources/C-Sources",
  Documentation(info="<html>
<p>
External function that sets up a socket client for receiving and sending data.
</p>
</html>", revisions="<html>
<ul>
<li>
June 18, 2018 by Sen Huang:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/926\">#926</a>.
</li>
</ul>
</html>"));
end SocClient;
