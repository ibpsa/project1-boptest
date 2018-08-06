within IBPSA.Utilities.IO.RESTClient;
package UsersGuide "User's Guide"
extends Modelica.Icons.Information;

annotation (preferredView="info", Documentation(info="<html>
<p>The package <code>IBPSA.Utilities.IO.RESTClient</code> consists of models that send/receive information to/from an external socket server in run time. Those models allow for example to sample the simulation data as the inputs for external control deployment, or overwrite the control signals. </p>
<h4>Usage</h4>
<p>First, a socket server should be started and one python script (see IBPSA/Resources/src/SocketServer/Utilities/IO/RESTClient/Examples/Server.py) is provided as an example to show how to do so. </p>
<p>Then, drag at the top-level of the model an instance of <a href=\"modelica://IBPSA.Utilities.IO.RESTClient.Configuration\">IBPSA.Utilities.IO.RESTClient.Configuration</a> and enter a value for its <code>samplePeriod</code>, which is the frequency with which data will be sampled or overwritten. This global configuration block is required for the blocks to work. This global configuration block also allows to specify other optional global configurations that are by default. </p>
<p>Next, to create an sampler for providing simulation data to external software, drag as many instances of <a href=\"modelica://IBPSA.Utilities.IO.RESTClient.Send_Real\">/IBPSA.Utilities.IO.RESTClient.Send_Real </a>and specify the host and TCP port number for the external socket server. </p>
<p>Likewise, one can also create an overwritten block using <a href=\"modelica://IBPSA.Utilities.IO.RESTClient.Read_Real\">IBPSA.Utilities.IO.RESTClient.Read_Real</a>. </p>
<h4>Activating and deactivating plotters</h4>
<p>As with the other parameters, the socket inherit from the global configuration, but this value can locally be overwritten. </p>
</html>", revisions="<html>
<ul>
<li>
June 18, 2018 by Sen Huang:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/926\">#926</a>.
</li>
</ul>
</html>"));

end UsersGuide;
