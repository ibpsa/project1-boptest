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

  model FreezeProtection "Control logic to implement freeze protection"
    parameter Real lockoutTime(
      final quantity="Time",
      final unit="s",
      displayUnit="min",
      min=60) = 900
      "Minimum on time for freeze protection enable";
    parameter Real TSet(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") = 276.15 "Temperature below which the freeze protection starts";
    parameter Real minFanSpe=0.1 "Minimum fan speed needed to turn on freeze protection";
    Buildings.Examples.VAVReheat.BaseClasses.Controls.FreezeStat
                        freSta(lockoutTime=lockoutTime, TSet=TSet)
                               "Freeze stat for heating coil"
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
      annotation (Placement(transformation(extent={{40,-20},{60,0}})));
    Buildings.Controls.OBC.CDL.Logical.And and2
      annotation (Placement(transformation(extent={{0,-20},{20,0}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput yHea
      "Control signal for freeze protection heating coil"
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThr(t=minFanSpe, h=0.05
          *minFanSpe)
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));

    Buildings.Controls.OBC.CDL.Interfaces.RealInput TMea
      "Measured temperature for which to base freeze protection on"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpe
      "Measured fan speed on which to base freeze protection on"
      annotation (Placement(transformation(extent={{-140,-62},{-100,-22}})));
  equation
    connect(freSta.y, and2.u1) annotation (Line(points={{-18,30},{-10,30},{-10,-10},
            {-2,-10}}, color={255,0,255}));
    connect(booToRea.y, yHea) annotation (Line(points={{62,-10},{80,-10},{80,0},{120,
            0}}, color={0,0,127}));
    connect(and2.y, booToRea.u)
      annotation (Line(points={{22,-10},{38,-10}}, color={255,0,255}));
    connect(greThr.y, and2.u2) annotation (Line(points={{-18,-30},{-10,-30},{-10,-18},
            {-2,-18}}, color={255,0,255}));
    connect(freSta.u, TMea) annotation (Line(points={{-42,30},{-94,30},{-94,40},{-120,
            40}}, color={0,0,127}));
    connect(fanSpe, greThr.u) annotation (Line(points={{-120,-42},{-82,-42},{
            -82,-30},{-42,-30}},
                        color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-44,46},{42,-38}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.None,
            textString="FreezePro")}),        Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end FreezeProtection;
end BaseClasses;
