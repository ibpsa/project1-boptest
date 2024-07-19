within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Control;
model PumpStageCondition "Stage checking for N pumps"

  parameter Real thehol_up "Threshold for staging up";

    parameter Real thehol_down "Threshold for staging down";

  parameter Integer n=3
    "the number of chillers";

  Modelica.Blocks.Interfaces.RealInput Status[n] "On signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput On[n]
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput Off[n]
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput OnSin "On signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
equation

    On[1] =  OnSin;
    Off[1] =  not OnSin;
    for i in 2:n loop
     On[i] = Status[i-1]>thehol_up and Status[i-1]>0;
    end for;

    for i in 2:n loop
     Off[i] = Status[i]<thehol_down*0.9 and Status[i]>0;
    end for;

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
          textString="StageCheck"),
        Text(
          extent={{-44,-144},{50,-112}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-152,104},{148,144}},
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
end PumpStageCondition;
