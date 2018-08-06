within IBPSA.Utilities.IO.RESTClient;
model Configuration "Configuration"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Time samplePeriod(min=1E-3)=60
    "Sample period of component";
  parameter IBPSA.Utilities.IO.RESTClient.Types.GlobalActivation activation = IBPSA.Utilities.IO.RESTClient.Types.GlobalActivation.always
    "Set to true to enable an input that allows activating and deactivating the socket connections"
    annotation (Dialog(group="Activation"));

  Modelica.Blocks.Interfaces.BooleanInput activate if (activation == IBPSA.Utilities.IO.RESTClient.Types.GlobalActivation.use_input)
    "Set to true to enable pocket connections"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Boolean active "Flag, true if the block is enabled";
protected
  Modelica.Blocks.Interfaces.BooleanInput activate_internal
    "Internal connector to activate the block";

equation
  if (activation == IBPSA.Utilities.IO.RESTClient.Types.GlobalActivation.use_input) then
    connect(activate, activate_internal);
  else
    activate_internal = true;
  end if;
  active = activate_internal;
  annotation (
Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,56},{56,-60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-44,42},{42,-48}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,70},{8,54}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,-58},{10,-74}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,8},{-54,-8}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,6},{72,-10}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-9,8},{9,-8}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={-41,44},
          rotation=305),
        Rectangle(
          extent={{-9,8},{9,-8}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={43,-50},
          rotation=305),
        Rectangle(
          extent={{-9,8},{9,-8}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={39,48},
          rotation=235),
        Rectangle(
          extent={{-9,8},{9,-8}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={-47,-44},
          rotation=395)}),                                                                         Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This block can be used to globally configure the parameters for the blocks from the package
<a href=\"IBPSA.Utilities.IO.RESTClient\">IBPSA.Utilities.IO.RESTClient</a>.
Use this block for example to set the sampling time.
</p>
<p>
To use this block, simply drag it at the top-most level, or higher, where your model is.
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
end Configuration;
