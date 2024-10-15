within IDEAS.Controls.Discrete;
block HysteresisRelease
  "Hysteresis for cooling mode WITH events, with Real in- and output, and inputs for uLow and uHigh"
  extends Modelica.Blocks.Interfaces.SISO(y(start=if y_start then 1 else 0, min=0, max=1));
  parameter Boolean revert = false
    "Set to true if the hysteresis returns true when u < uLow instead of u > uHigh (for example for heating put revert = true)";
  parameter Boolean use_input = true
    "If true, use realinput signals for uLow and uHigh instead of fixed parameters";
  parameter Boolean enableRelease=false
    "if true, an additional RealInput will be available for releasing the controller";
  Modelica.Blocks.Interfaces.RealInput uLow if use_input
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput uHigh if use_input
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  parameter Real uLow_val = 0
    "lower boundary value if the input uLow is not used"
    annotation(Dialog(enable=not use_input));
  parameter Real uHigh_val = 1
    "higher boundary value if the input uHigh is not used"
    annotation(Dialog(enable=not use_input));
  Modelica.Blocks.Interfaces.RealInput release(start=0) = rel_internal if enableRelease
    "if < 0.5, the controller is OFF"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  parameter Boolean y_start = false "Output of controller at initial time";
protected
  Modelica.Blocks.Interfaces.RealInput uLow_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput uHigh_internal
    "Needed to connect to conditional connector";
  Real rel_internal
    "release, either 1 ,either from RealInput release if enableRelease is true";
  Boolean y_boolean "Boolean control signal, will be converted to Real";
initial equation
  pre(y_boolean) = y_start;
equation
  if not enableRelease then
    rel_internal = 1;
  end if;
  connect(uLow,uLow_internal);
  connect(uHigh,uHigh_internal);
  // Needed to connect to conditional connector
  if not use_input then
    uLow_internal = uLow_val;
    uHigh_internal = uHigh_val;
  end if;
  if rel_internal > 0.5 then
    if not revert then
      y_boolean = u > uHigh_internal or pre(y_boolean) and u >= uLow_internal;
    else
      y_boolean = u < uLow_internal or pre(y_boolean) and u <= uHigh_internal;
    end if;
  else
    y_boolean = false;
  end if;
  y = if y_boolean then 1 else 0;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}}), graphics={Polygon(
          points={{-65,89},{-73,67},{-57,67},{-65,89}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),Line(points={{-65,67},{-65,-81}},
          color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,
          192}),Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),Text(
          extent={{70,-80},{94,-100}},
          lineColor={160,160,164},
          textString="u"),Text(
          extent={{-65,93},{-12,75}},
          lineColor={160,160,164},
          textString="y"),Line(
          points={{-80,-70},{30,-70}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-50,10},{80,10}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-50,10},{-50,-70}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{30,10},{30,-70}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-10,-65},{0,-70},{-10,-75}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-10,15},{-20,10},{-10,5}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{-55,-20},{-50,-30},{-44,-20}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{25,-30},{30,-19},{35,-30}},
          color={0,0,0},
          thickness=0.5),Text(
          extent={{-99,2},{-70,18}},
          lineColor={160,160,164},
          textString="true"),Text(
          extent={{-98,-87},{-66,-73}},
          lineColor={160,160,164},
          textString="false"),Text(
          extent={{19,-87},{44,-70}},
          lineColor={0,0,0},
          textString="uHigh"),Text(
          extent={{-63,-88},{-38,-71}},
          lineColor={0,0,0},
          textString="uLow"),Line(points={{-69,10},{-60,10}}, color={160,160,
          164})}),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-29}},
          color={192,192,192}),Polygon(
          points={{92,-29},{70,-21},{70,-37},{92,-29}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),Line(points={{-79,-29},{84,-29}},
          color={192,192,192}),Line(points={{-79,-29},{41,-29}}, color={0,0,0}),
          Line(points={{-15,-21},{1,-29},{-15,-36}}, color={0,0,0}),Line(points=
           {{41,51},{41,-29}}, color={0,0,0}),Line(points={{33,3},{41,22},{50,3}},
          color={0,0,0}),Line(points={{-49,51},{81,51}}, color={0,0,0}),Line(
          points={{-4,59},{-19,51},{-4,43}}, color={0,0,0}),Line(points={{-59,
          29},{-49,11},{-39,29}}, color={0,0,0}),Line(points={{-49,51},{-49,-29}},
          color={0,0,0}),Text(
          extent={{-92,-49},{-9,-92}},
          lineColor={192,192,192},
          textString="%uLow"),Text(
          extent={{2,-49},{91,-92}},
          lineColor={192,192,192},
          textString="%uHigh"),Rectangle(extent={{-91,-49},{-8,-92}}, lineColor=
           {192,192,192}),Line(points={{-49,-29},{-49,-49}}, color={192,192,192}),
          Rectangle(extent={{2,-49},{91,-92}}, lineColor={192,192,192}),Line(
          points={{41,-29},{41,-49}}, color={192,192,192})}),
    Documentation(info="<html>
<p>This block transforms a <b>Real</b> input signal into a <b>Real</b> output signal: </p>
<ul>
<li>When the output was false and the input becomes greater than parameter uHigh, the output switches to true.</li>
<li>When the output was true and the input becomes less than parameter uLow, the output switches to false.</li>
<li>As long as the input stays between uLow and uHigh, the output remains the same.</li>
</ul>
<p>This hysteresic block has several additional features:</p>
<ul>
<li>When the parameter revert is true, the switching logic changes.  This is typically used for heating-like situations, when the output has to be true when the input is below uLow. </li>
<li>uLow and uHigh can be realinputs instead of fixed parameters</li>
<li>a release input can be used to activate (release) or deactivate  the controller</li>
</ul>
<p>The initial value of the output is defined via parameter y_start. The default value of this parameter is false. </p>
</html>",
  revisions="<html>
<ul>
<li>November 2014, Roel De Coninck<br/>Switching to real inputs and output</li>
<li>May 13, 2014, by Damien Picard:<br/>Add possibility to use parameters as boundary values instead of inputs. </li>
</ul>
</html>"));
end HysteresisRelease;
