within BuildingControlEmulator.Devices.WaterSide.Control;
model ChillerStageNWithRotation
  "Combined stage controller for N chillers"
  parameter Real tWai "Waiting time";

  parameter Real thehol[n-1] "Threshold";

  parameter Real Cap[n] "Rated Plant Capacity";

  parameter Integer n=3
    "the number of chillers";

  Modelica.Blocks.Interfaces.RealOutput y[n]
    "Output of stage control"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput
                                       On "On signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Status[n] "Compressor speed ratio"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput Loa
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  PlantStageCondition plantNStageCondition(
    thehol=thehol,
    n=n,
    Cap=Cap)
         annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  BaseClasses.StageN NStage(tWai=tWai, n=n)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Continuous.Integrator counter[n]
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Discrete.Sampler sampler[n](                   startTime=0,
      samplePeriod=1800)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.RealExpression record_status[n](y=y_with_no_order)
    annotation (Placement(transformation(extent={{-98,-30},{-78,-10}})));
  Modelica.Blocks.Interfaces.RealInput sort_index[n] "Compressor speed ratio"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
protected
  Boolean change;

  Real last_value;

  Real y_with_no_order[n];

public
  Modelica.Blocks.Interfaces.RealOutput runTim[n] "Continuous output signal"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
initial algorithm

  last_value :=NStage.y;

  y_with_no_order :=y;

equation

algorithm
  when pre(change) then

    for i in 1:n loop

         y_with_no_order[i] := if i <= integer(NStage.y) then 1 else 0;
         y[i] := if integer(sort_index[i]) <= integer(NStage.y) then 1 else 0;

    end for;
    last_value := NStage.y;
  end when;

  change := abs(NStage.y - last_value) >= 0.1;






equation
  connect(plantNStageCondition.OnSin, On) annotation (Line(points={{-62,0},{-80,
          0},{-80,80},{-120,80}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(plantNStageCondition.Loa, Loa) annotation (Line(
      points={{-62,6},{-78,6},{-94,6},{-94,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(plantNStageCondition.Off, NStage.Off) annotation (Line(
      points={{-39,-4},{-20,-4},{-20,-6},{-10,-6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(plantNStageCondition.On, NStage.On) annotation (Line(
      points={{-39,4},{-20,4},{-20,6},{-10,6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(record_status.y, plantNStageCondition.Status) annotation (Line(
      points={{-77,-20},{-68,-20},{-68,-6},{-62,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(counter.u, Status) annotation (Line(points={{-62,-50},{-80,-50},{-80,-80},
          {-120,-80}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sampler.u, counter.y)
    annotation (Line(points={{-2,-50},{-39,-50}},           color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sampler.y, runTim) annotation (Line(
      points={{21,-50},{60,-50},{60,-80},{110,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-56,42},{58,-42}},
          lineColor={0,0,255},
          textString="CompressorStage"),
        Text(
          extent={{-44,-144},{50,-112}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end ChillerStageNWithRotation;
