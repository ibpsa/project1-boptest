within IDEAS.LIDEAS.Validation;
model ZoneWithInputsValidationLinear "Model to validate the linearization method by simulating both the original model (with all flags set to linear) and the obtained state space model."
  extends ZoneWithInputsValidationNonLinear(
    firFlo(
          linearise=true),
    groFlo(
         linearise=true),
  sim(linIntCon=true,
      linExtCon=true,
      linIntRad=true,
      linExtRad=true),
    slabOnGround(linearise=true),
  commonWall(layMul(monLay(each monLayDyn(addRes_b=true),
    each energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial))));

equation
  assert(abs(err[1].y) <= 7e-6, "The error between zone 1 of SSM and linear model is bigger than it used to be (" + String(err[1].y) + "instead of 7 E-6 at time 10E5)");
  assert(abs(err[2].y) <= 0.00014, "The error between zone 2 of SSM and linear model is bigger than it used to be (" + String(err[2].y) + "instead of 0.000134 at time 10E5)");
  annotation (experiment(StopTime=100000, Tolerance=1e-06),
                                           __Dymola_Commands(file="Resources/Scripts/Dymola/LIDEAS/Validation/ZoneWithInputsValidationLinear.mos"
        "Linearize, simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
December 11, 2019, by Filip Jorissen:<br/>
Revised error bounds for
issue <a href=https://github.com/open-ideas/IDEAS/issues/1089>#1089</a>.
</li>
<li>
May 15, 2018 by Damien Picard: <br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>This example verified that the obtained state-space model gives the same results as the original modelica model with <i>all linearise flags</i> set to true. The remaining error is probably due to numerical error.</p>
</html>"));
end ZoneWithInputsValidationLinear;
