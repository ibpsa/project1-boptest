within MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.AirHandlingUnit;
package BaseClasses

  model OccupancyMode "Occupied mdoe controller"

    parameter Real start_time;
    parameter Real end_time;

    Modelica.Blocks.Sources.BooleanExpression
                                           booleanExpression(y=(mod(time,86400) > start_time*3600) and (mod(time,86400) < end_time*3600))
      annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput Occ annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  equation
    connect(booleanExpression.y, Occ) annotation (Line(points={{9,0},{120,0}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-42,38},{44,-46}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.None,
            textString="Occ"),
          Text(
            extent={{-152,104},{148,144}},
            textString="%name",
            textColor={0,0,255})}),
                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
  end OccupancyMode;

  model ZoneSetpoint
    "Zone air temperature setPoint controller based on the occupancy signal"
    parameter Integer n=2 "dimenison of the setpoint vector";
    parameter Real setpoint_on[n] "the values of setpoint during 'on' period";
    parameter Real setpoint_off[n] "the values of setpoint during 'off' period";

    Modelica.Blocks.Sources.RealExpression realExpression[n](y=noEvent(if Occ then setpoint_on else setpoint_off))
      annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
    Modelica.Blocks.Interfaces.BooleanInput  Occ
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput SetPoi[n]
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  equation
    connect(realExpression.y, SetPoi) annotation (Line(points={{9,0},{120,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-42,38},{44,-46}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.None,
            textString="SetPo"),
          Text(
            extent={{-154,102},{146,142}},
            textString="%name",
            textColor={0,0,255})}),
                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
  end ZoneSetpoint;
end BaseClasses;
