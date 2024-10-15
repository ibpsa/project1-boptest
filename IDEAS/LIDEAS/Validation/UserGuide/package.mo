within IDEAS.LIDEAS.Validation;
package UserGuide
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>This package is used to validate the linearization method by comparing the simulation results of the non-linear modelica model, the linear modelica model, and the linearized model. Note that if the number of states or inputs changes, the parameter <i>x_start</i> and <i>preInp</i> of <i>ZoneWithInputsValidationNonLinear</i> will need to be adapted manually using <i>states_ZoneWithInputsLinearise.txt</i> en <i>uNames_ZoneWithInputsLinearise.txt</i>.</p>
</html>", revisions="<html>
<ul>
<li>April 12, 2018, Damien Picard,<br/>First implementation.<br/></li>
</ul>
</html>"));
end UserGuide;
