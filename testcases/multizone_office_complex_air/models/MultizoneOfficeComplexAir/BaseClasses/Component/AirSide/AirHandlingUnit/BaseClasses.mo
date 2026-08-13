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
    parameter Modelica.Units.SI.VolumeFlowRate minAirFlow "Minimum volumetric air flow needed to turn on freeze protection";
    Buildings.Examples.VAVReheat.BaseClasses.Controls.FreezeStat
                        freSta(lockoutTime=lockoutTime, TSet=TSet)
                               "Freeze stat for heating coil"
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput yHea
      "Control signal for freeze protection heating coil"
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThr(t=minAirFlow, h
        =0.05*minAirFlow)
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));

    Buildings.Controls.OBC.CDL.Interfaces.RealInput TMea(final quantity="ThermodynamicTemperature",
                                                 final unit="K")
      "Measured temperature for which to base freeze protection on"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput V_flow(final quantity="VolumeFlowRate",
                                                 final unit="m3/s")
      "Measured volumetric air flow for which to base freeze protection on"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
    Buildings.Controls.OBC.CDL.Continuous.Switch swi
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zero(k=0)
      "Zero constant"
      annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
    Buildings.Utilities.IO.SignalExchange.Overwrite oveFrePro(description=
          "Control signal for freeze protection coil", u(
        min=0,
        max=1,
        unit="1")) "Overwrite freeze protection signal"
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
  equation
    connect(freSta.u, TMea) annotation (Line(points={{-82,30},{-94,30},{-94,40},
            {-120,40}},
                  color={0,0,127}));
    connect(freSta.y, booToRea.u)
      annotation (Line(points={{-58,30},{-42,30}}, color={255,0,255}));
    connect(greThr.y, swi.u2) annotation (Line(points={{-18,-30},{-10,-30},{-10,
            0},{38,0}}, color={255,0,255}));
    connect(zero.y, swi.u3) annotation (Line(points={{22,-30},{32,-30},{32,-8},
            {38,-8}}, color={0,0,127}));
    connect(swi.y, yHea)
      annotation (Line(points={{62,0},{120,0}}, color={0,0,127}));
    connect(booToRea.y, oveFrePro.u)
      annotation (Line(points={{-18,30},{-2,30}}, color={0,0,127}));
    connect(oveFrePro.y, swi.u1) annotation (Line(points={{21,30},{32,30},{32,8},
            {38,8}}, color={0,0,127}));
    connect(V_flow, greThr.u) annotation (Line(points={{-120,-40},{-80,-40},{
            -80,-30},{-42,-30}}, color={0,0,127}));
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
