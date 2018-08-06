within IBPSA.Utilities.IO.RESTClient.Types;
type LocalActivation = enumeration(
    use_activation "Use activation from global configuration",
    always "Always on",
    use_input "On based on input")
  "Enumeration for local activation of the socket connection"
 annotation (Documentation(info="<html>
<p>Enumeration that is used to locally configure the socket connection. </p>
</html>",revisions="<html>
<ul>
<li>
June 18, 2018 by Sen Huang:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/926\">#926</a>.
</li>
</ul>
</html>"));
