within IDEAS.LIDEAS.Examples;
model ZoneCreateOutputs
  "Model to create an input file for running the linearized model zoneLinearise in a non-modelica environment environment"
  extends ZoneLinearise(       sim(lineariseDymola=false, createOutputs=true));
  annotation (experiment(StopTime=1e+06), __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      inputs=false,
      auxiliaries=false),
    __Dymola_Commands(file="Scripts/createOutputs_ZoneCreateOutputs.mos"
        "Create outputs"),
    Documentation(info="<html>
<p>LIDEAS.Examples.zoneExampleCreateOutputs is an extension of LIDEAS.Examples.zoneExample. This model contains a command <i>Create outputs</i>; to generate an input file which can be used to simulate the linearized model in a non-modelica environment. The command points at LIDEAS/LIDEAS/Resources/Scripts/createOutputs.mos, which contains the following simulation command:</p>
<p><br/>experimentSetupOutput(inputs=false,outputs=true,auxiliaries=false,equidistant=true,events=false);</p>
<p>simulateModel(\"LIDEAS.Examples.ZoneExampleCreateOutputs\", startTime=0, stopTime=3.14e7, method=\"Euler\", numberOfIntervals=0, outputInterval=1200, fixedstepsize=10, resultFile=\"outputs\");</p>
<p><br/>The second command simulates the model for a full year and produces a sample for the inputs every 1200 seconds and saves the resulting outputs to <i>outputs.mat</i>. This example uses Euler integration with a fixed step size of 10 seconds. The output interval, step size and integrator can be changed by the used, these settings are not specific to the linearisation approach. The second command simulates the model for a full year and produces a sample for the inputs every 1200 seconds and saves the resulting outputs to <i>outputs.mat</i>. This example uses Euler integration with a fixed step size of 10 seconds. The output interval, step size and integrator can be changed by the used, these settings are not specific to the linearisation approach. The first command defines the settings which ensure that only the <i>outputs</i> of the example model are saved to file at equidistant time interval. This setting is not absolutely required, but it avoids the generation of excessively large input files, which may occur when saving outputs at regular intervals. E.g. saving a sample every 1200 s will lead to a result file containing 26250 time intervals, which is much more than the Dymola default of 500.</p>
</html>", revisions="<html>
<ul>
<li>
April 5, 2018 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end ZoneCreateOutputs;
