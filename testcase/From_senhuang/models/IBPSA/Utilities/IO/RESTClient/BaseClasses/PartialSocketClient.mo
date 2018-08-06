within IBPSA.Utilities.IO.RESTClient.BaseClasses;
partial block PartialSocketClient "The socket client "
  extends Modelica.Blocks.Icons.Block;
  outer IBPSA.Utilities.IO.RESTClient.Configuration config
    "Default configuration";
  parameter Integer numVar(min=1)
    "Number of inputs";
  parameter String hostAddress(start="127.0.0.1")
    "Host address";
  parameter Integer tcpPort(start=8888)
    "TCP port";
  parameter Modelica.SIunits.Time samplePeriod(min=1E-3)= config.samplePeriod
    "Sample period"
    annotation(Dialog(group="Activation"));
  parameter IBPSA.Utilities.IO.RESTClient.Types.LocalActivation activation=IBPSA.Utilities.IO.RESTClient.Types.LocalActivation.use_activation
    "Set to true to enable an input that allows activating and deactivating the block"
    annotation (Dialog(group="Activation"));
  parameter String varName[numVar]
    "Variable Name";
  Modelica.Blocks.Interfaces.BooleanInput activate if (activation == IBPSA.Utilities.IO.RESTClient.Types.LocalActivation.use_input)
    "Set to true to enable block of time series after activationDelay elapsed"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput u[numVar]
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Real oveSig[numVar](each start=0)
    "Overwritten signals";
  parameter Modelica.SIunits.Time t0(start=0)
    "Start time of component";

protected
    Modelica.Blocks.Interfaces.BooleanInput activate_internal
    "Internal connector to activate the block";

equation
  if (activation == IBPSA.Utilities.IO.RESTClient.Types.LocalActivation.use_input) then
    connect(activate, activate_internal);
  elseif (activation == IBPSA.Utilities.IO.RESTClient.Types.LocalActivation.use_activation) then
    activate_internal = config.active;
  elseif (activation == IBPSA.Utilities.IO.RESTClient.Types.LocalActivation.always) then
    activate_internal = true;
  end if;
  when (sample(t0,samplePeriod) and activate_internal) then
    oveSig = IBPSA.Utilities.IO.RESTClient.BaseClasses.SocClient(
      numVar,
      u,
      varName,
      hostAddress,
      tcpPort);
  end when;
  annotation (Documentation(info="<html>
<p>Partial block that implements the basic functionality used by Sampler_Real and OverWritten_Real. </p>
</html>", revisions="<html>
<ul>
<li>
June 18, 2018 by Sen Huang:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/926\">#926</a>.
</li>
</ul>
</html>"));
end PartialSocketClient;
