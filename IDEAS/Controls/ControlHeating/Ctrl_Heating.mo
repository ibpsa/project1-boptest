within IDEAS.Controls.ControlHeating;
model Ctrl_Heating "Basic heating curve control for heater and mixing valve"
  extends Interfaces.Partial_Ctrl_Heating;

  parameter Modelica.SIunits.TemperatureDifference corFac_val = 0
    "correction term for TSet of the heating curve";
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{62,32},{78,48}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={72,0})));
equation
  connect(heatingCurve.TSup, add1.u1) annotation (Line(
      points={{1,56},{40,56},{40,44},{50,44},{50,44.8},{60.4,44.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.y, THeaCur) annotation (Line(
      points={{78.8,40},{100,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression2.y, add2.u2) annotation (Line(
      points={{2.2,10},{33.1,10},{33.1,-4.8},{62.4,-4.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add2.y, THeaterSet) annotation (Line(
      points={{80.8,0},{86,0},{86,10},{90,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(corHeaCur.y, add1.u2) annotation (Line(
      points={{1,30},{40,30},{40,35.2},{60.4,35.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(corHeaCur.y, add2.u1) annotation (Line(
      points={{1,30},{40,30},{40,4.8},{62.4,4.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
            {100,80}}),      graphics), Documentation(info="<html>
<p><b>Description</b> </p>
<p>Heating curve based control of a heater. This component is nothing more than a wrapper around the <a href=\"modelica://IDEAS.Thermal.Control.HeatingCurve\">IDEAS.Thermal.Control.HeatingCurve</a>. The set point temperature for the heater is <i>dTHeaterSet</i> Kelvin higher than the heating curve output in order to make sure that the heating curve temperature is met also when thermal losses are present in the circuit. </p>
<h4>Model use</h4>
<ol>
<li>Use this controller in a heating system without DHW where you want to follow a heating curve.</li>
</ol>
<h4>Validation </h4>
<p>No validation performed.</p>
<h4>Example </h4>
<p>
This controller is used in<a href=\"modelica://IDEAS.Thermal.HeatingSystems.Heating_Radiators\">
IDEAS.Thermal.HeatingSystems.Heating_Radiators</a> and <a href=\"modelica://IDEAS.Thermal.HeatingSystems.Heating_Embedded\">IDEAS.Thermal.HeatingSystems.Heating_Embedded</a>.
</p>
</html>", revisions="<html>
<ul>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011, Roel De Coninck: first version and validation</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end Ctrl_Heating;
