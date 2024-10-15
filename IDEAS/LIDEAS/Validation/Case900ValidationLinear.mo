within IDEAS.LIDEAS.Validation;
model Case900ValidationLinear "Model to validate the linearization method by simulating both the original model (with all flags set to linear) and the obtained state space model."
  extends Case900ValidationNonLinear(sim(linIntCon=true,
      linExtCon=true,
      linIntRad=true,
      linExtRad=true));

equation
  assert(abs(err_linRecZon_ssm.y) <= 5*10^(-5), "The error between zone 1 of SSM and linear model is bigger than it used to be (" + String(err_linRecZon_ssm.y) + "instead of 6 E-6 at time 10E5)");
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100000, Tolerance=1e-06),
    __Dymola_Commands(file="Resources/Scripts/Dymola/LIDEAS/Validation/Case900ValidationLinear.mos"
        "Linearise, simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>May 15, 2018 by Damien Picard: <br/>First implementation</li>
</ul>
</html>", info="<html>
<p>Notice that contrary to IDEAS.LIDEAS.Validation.ZoneWithInputsValidationLinear, not all flags were set to linear. This examples the rather large error between the zone model and the state space model.</p>
</html>"));
end Case900ValidationLinear;
