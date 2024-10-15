within IDEAS.Examples.PPD12.Data;
record FanCurvePP12 "Curve with constant efficiency for PPD12 fans"
  extends IDEAS.Fluid.Movers.Data.Generic(
    speed_rpm_nominal=2800,
    use_powerCharacteristic = false,
    motorEfficiency(V_flow={2},eta={0.95}),
    hydraulicEfficiency(V_flow={0, 150, 300}/3600*1.225,
          eta={0.25, 0.25, 0.25}),
    pressure(V_flow={0,150,300}/3600*1.225,
          dp={300,200,50}));

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
    Documentation(info="<html>
<p>
Curve with constant efficiency of 25 % for PPD12 model. 
The fan curve is not tuned to measurements since its value does not affect the electrical power use (constant efficiency).
</p>
</html>", revisions="<html>
<ul>
<li>
October 28, 2018, by Filip Jorissen:<br/>
First implementation for <a href=\"https://github.com/open-ideas/IDEAS/issues/942\">#942</a>.
</li>
</ul>
</html>"));
end FanCurvePP12;
