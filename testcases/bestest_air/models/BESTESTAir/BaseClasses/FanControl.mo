within BESTESTAir.BaseClasses;
model FanControl "Internal fan controller to limit minimum speed"
    parameter Modelica.SIunits.DimensionlessRatio minSpe = 0.2 "Minimum fan speed";
  Modelica.Blocks.Nonlinear.Limiter lim(uMax=1, uMin=minSpe)
    "Fan speed limiter"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Logical.Switch swiFan "Fan enable switch"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant off(k=0) "Off signal"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput uFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.BooleanInput uFanSta "Fan status control signal"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
equation
  connect(lim.y, swiFan.u1)
    annotation (Line(points={{1,30},{10,30},{10,8},{18,8}}, color={0,0,127}));
  connect(swiFan.y, yFan)
    annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  connect(off.y, swiFan.u3) annotation (Line(points={{1,-30},{10,-30},{10,-8},{18,
          -8}}, color={0,0,127}));
  connect(lim.u, uFan) annotation (Line(points={{-22,30},{-60,30},{-60,40},{-120,
          40}}, color={0,0,127}));
  connect(swiFan.u2, uFanSta) annotation (Line(points={{18,0},{-60,0},{-60,-20},
          {-120,-20}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanControl;
