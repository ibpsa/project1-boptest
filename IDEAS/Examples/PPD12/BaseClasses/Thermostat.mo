within IDEAS.Examples.PPD12.BaseClasses;
model Thermostat
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Temperature THigh=273.15+21 "Temperature set point during high temperature period";
  parameter Modelica.SIunits.Temperature TLow=273.15+16 "Temperature set point during low temperature period";

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  IDEAS.Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2016)
    "Calendar time block"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=-1, uHigh=0)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression THighExp(y=THigh)
    "Expression for THigh"
    annotation (Placement(transformation(extent={{-100,28},{-80,48}})));
  Modelica.Blocks.Math.Add add(k1=1, k2=-1)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.RealExpression TLowExp(y=TLow) "Expression for TLow"
    annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
  Modelica.Blocks.Sources.BooleanExpression onWeekDay(y=calTim.weekDay < 6 and
        not (calTim.hour < 6 or calTim.hour >= 23 or calTim.hour >= 9 and
        calTim.hour < 17))
                "Schedule during week days"
    annotation (Placement(transformation(extent={{-60,70},{20,90}})));
  Modelica.Blocks.Sources.BooleanExpression onWeekEnd(y=calTim.weekDay >= 6
         and calTim.hour >= 6 and calTim.hour < 23)  "Schedule during weekend"
    annotation (Placement(transformation(extent={{-60,58},{20,78}})));
  Modelica.Blocks.Logical.Or weekSched
    "Combined schedule of week day and weekend"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation
  connect(THighExp.y, switch1.u1)
    annotation (Line(points={{-79,38},{-72,38},{-62,38}}, color={0,0,127}));
  connect(TLowExp.y, switch1.u3)
    annotation (Line(points={{-79,22},{-70.5,22},{-62,22}}, color={0,0,127}));
  connect(switch1.y, add.u1) annotation (Line(points={{-39,30},{-30,30},{-30,6},
          {-22,6}}, color={0,0,127}));
  connect(add.u2, u) annotation (Line(points={{-22,-6},{-30,-6},{-30,0},{-106,0}},
        color={0,0,127}));
  connect(weekSched.u1, onWeekDay.y) annotation (Line(points={{38,70},{32,70},{
          32,80},{24,80}}, color={255,0,255}));
  connect(weekSched.u2, onWeekEnd.y) annotation (Line(points={{38,62},{32,62},{
          32,68},{24,68}}, color={255,0,255}));
  connect(weekSched.y, switch1.u2) annotation (Line(points={{61,70},{72,70},{72,
          48},{-72,48},{-72,30},{-62,30}}, color={255,0,255}));
  connect(add.y, hysteresis.u)
    annotation (Line(points={{1,0},{9.5,0},{18,0}}, color={0,0,127}));
  connect(hysteresis.y, y)
    annotation (Line(points={{41,0},{106,0},{106,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Thermostat;
