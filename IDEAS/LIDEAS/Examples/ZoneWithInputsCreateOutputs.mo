within IDEAS.LIDEAS.Examples;
model ZoneWithInputsCreateOutputs "Model to create an input file for running the linearized model zoneLineariseWithInputs in a non-modelica environment environment"
  extends ZoneWithInputsLinearise(sim(lineariseDymola=false, createOutputs=true));
  Modelica.Blocks.Sources.Sine occQRad[2](
    freqHz=1/12/3600,
    startTime=7200,
    amplitude=20,
    offset=20) "Fake occupancy gains"
    annotation (Placement(transformation(extent={{40,-144},{60,-124}})));
  Modelica.Blocks.Sources.Sine occQCon[2](
    freqHz=1/6/3600,
    amplitude=60,
    offset=60) "fake occupancy gains"
    annotation (Placement(transformation(extent={{40,-114},{60,-94}})));
  output Components.BaseClasses.Prescribed prescribedOut
    "Prescribed inputs which do not depend on the model states value (e.g. heat flow from occupancy)"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,-120})));
equation
  connect(occQCon.y, prescribedOut.QCon) annotation (Line(points={{61,-104},{80,
          -104},{100.1,-104},{100.1,-120.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(occQRad.y, prescribedOut.QRad) annotation (Line(points={{61,-134},{82,
          -134},{100.1,-134},{100.1,-120.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Diagram(coordinateSystem(extent={{-100,-160},{100,100}})), Icon(
        coordinateSystem(extent={{-100,-160},{100,100}})),          __Dymola_Commands(file=
          "Scripts/createOutputs_zoneWithInputsCreateOutputs.mos" "Create outputs"),
    Documentation(revisions="<html>
<ul>
<li>
April 5, 2018 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end ZoneWithInputsCreateOutputs;
