within IBPSA.Utilities.IO.RESTClient;
block Send_Real "Block that sends the model output to the external server"
  extends IBPSA.Utilities.IO.RESTClient.BaseClasses.PartialSocketClient;
equation
  annotation (Icon(graphics={
        Rectangle(
          extent={{-88,54},{92,-6}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(points={{-80,22},{-76,32},{-70,42},{-62,48},{-50,48},{-42,42},{-36,
              34},{-32,22},{-28,12},{-22,6},{-14,-2},{-4,-4},{4,-2},{10,6},{14,
              16},{16,22},{18,30},{20,40},{24,46},{30,50},{42,48},{48,42},{52,
              34},{56,24},{58,16},{62,8},{64,4},{72,-2},{78,-4},{84,-2},{90,2},
              {92,6}}, color={28,108,200}),
        Text(
          extent={{-62,-22},{70,-60}},
          lineColor={28,108,200},
          textString="Sampler")}), Documentation(info="<html>
<p>Block that samples time series, and sends them to the remoted server. Please noted that the message received by the remoted server will be a string with delimiter as &QUOT;,&QUOT;.</p>
<p> In addition, there will be a pair of a variable name and a variable value in the message, i.e., &QUOT;variable name 1, variable value 1,variable name 2, variable value2,...&QUOT;</p>
</html>", revisions="<html>
<ul>
<li>
June 18, 2018 by Sen Huang:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/926\">#926</a>.
</li>
</ul>
</html>"));
end Send_Real;
