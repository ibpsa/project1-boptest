within MultizoneOfficeComplexAir.BaseClasses.Component.WaterSide.Control;
model PlantStageCondition
  "Stage checking for N chillers or N boilers"

  parameter Real thehol[n-1]
    "Threshold";

  parameter Real Cap[n]
    "Normal Cooling Capacity";

  parameter Integer n=3
    "Number of chillers";

  Real PLR
    "Part load ratio";
  Real cap_avi
    "Available cooling capacity";

  Modelica.Blocks.Interfaces.RealInput Loa "Load signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Status[n] "Status signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput On[n] "Staging up signal"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput Off[n] "Staging down signal"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput OnSin "On signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

algorithm
    cap_avi :=0;
    for i in 1:n loop
     cap_avi :=cap_avi + Status[i]*Cap[i];
    end for;
    if cap_avi>0.01 then
    PLR:=Loa/cap_avi;
    else
    PLR:=0;
    end if;
    On[1] :=OnSin;
    Off[1] :=not OnSin;

    for i in 2:n loop
        On[i] :=PLR > thehol[i - 1] and Status[i - 1] > 0;
    end for;

    for i in 2:n loop
        Off[i] :=PLR*(sum(Status)/(sum(Status) - 1 + 0.0001)) < thehol[i - 1]
       and Status[i] > 0;
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
          textString="%name")}),
    Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end PlantStageCondition;
