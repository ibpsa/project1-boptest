within MultizoneOfficeComplexAir.BaseClasses.Component.WaterSide.Control;
model PumpStageN "Combined stage controller for N pumps"
  parameter Real tWai "Waiting time";

  parameter Real thehol_up = 0.9 "Threshold for staging up";

  parameter Real thehol_down = 0.6 "Threshold for staging down";

  parameter Integer n=3
    "the number of pumps";

  Modelica.Blocks.Interfaces.RealOutput y[n]
    "Output of stage control"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput
                                       On "On signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput sta[n] "Compressor speed ratio"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  PumpStageCondition pumNStaCon(
    n=n,
    thehol_up=thehol_up,
    thehol_down=thehol_down)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  BaseClasses.StageN pumNSta(tWai=tWai, n=n)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation

    for i in 1:n loop
    y[i]=if i > pumNSta.y then 0 else 1;

    end for;

  connect(pumNStaCon.OnSin, On) annotation (Line(points={{-62,6},{-80,6},
          {-80,80},{-120,80}}, color={255,0,255}));
  connect(pumNStaCon.Status, sta) annotation (Line(points={{-62,-6},{-80,
          -6},{-80,-80},{-120,-80}}, color={0,0,127}));
  connect(pumNStaCon.Off, pumNSta.Off) annotation (Line(points={{-39,-4},
          {-20,-4},{-20,-6},{-10,-6}}, color={255,0,255}));
  connect(pumNStaCon.On, pumNSta.On) annotation (Line(points={{-39,4},{
          -20,4},{-20,6},{-10,6}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-54,42},{60,-42}},
          lineColor={0,0,255},
          textString="PumSta"),
        Text(
          extent={{-154,102},{146,142}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end PumpStageN;
