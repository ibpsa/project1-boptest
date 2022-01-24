within singlezone_commercial_air.BaseClasses;
model Control_Staged "Control model for staged RTU"

  /* control & auxiliaries */

  Modelica.Blocks.Sources.RealExpression yOA(y=0.2)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));

  Modelica.Blocks.Sources.RealExpression yfan(y=1)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));

  Modelica.Blocks.Logical.Hysteresis cooCoiCon(uLow=0, uHigh=0.555)
    annotation (Placement(transformation(extent={{-16,-52},{4,-32}})));
  Modelica.Blocks.Math.Add varTz(k2=-1) "Absolute temperature as output signal"
    annotation (Placement(transformation(extent={{-50,-52},{-30,-32}})));

  Modelica.Blocks.Math.BooleanToReal boo2Rea
    annotation (Placement(transformation(extent={{14,-90},{34,-70}})));
  Modelica.Blocks.Logical.Hysteresis heaCoiCon(uLow=0, uHigh=0.555)
    annotation (Placement(transformation(extent={{-26,-90},{-6,-70}})));
  Modelica.Blocks.Math.Add varTz1(k2=-1)
    "Absolute temperature as output signal"
    annotation (Placement(transformation(extent={{-54,-90},{-34,-70}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-74,-50},{-68,-44}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-72,-78},{-66,-72}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(
    table=[1,15.5555555556; 2,15.5555555556; 3,15.5555555556; 4,15.5555555556;
        5,15.5555555556; 6,15.5555555556; 7,15.5555555556; 8,15.5555555556; 9,
        18.3333333333; 10,21.1111111111; 11,21.1111111111; 12,21.1111111111; 13,
        21.1111111111; 14,21.1111111111; 15,21.1111111111; 16,21.1111111111; 17,
        21.1111111111; 18,21.1111111111; 19,21.1111111111; 20,21.1111111111; 21,
        21.1111111111; 22,15.5555555556; 23,15.5555555556; 24,15.5555555556; 25,
        15.555555],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "setpoint heating [C]"
    annotation (Placement(transformation(extent={{-94,-82},{-82,-70}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetCoo(
    table=[1,29.4444444444; 2,29.4444444444; 3,29.4444444444; 4,29.4444444444;
        5,29.4444444444; 6,29.4444444444; 7,29.4444444444; 8,29.4444444444; 9,
        26.6666666667; 10,23.8888888889; 11,23.8888888889; 12,23.8888888889; 13,
        23.8888888889; 14,23.8888888889; 15,23.8888888889; 16,23.8888888889; 17,
        23.8888888889; 18,23.8888888889; 19,23.8888888889; 20,23.8888888889; 21,
        23.8888888889; 22,29.4444444444; 23,29.4444444444; 24,29.4444444444; 25,
        29.4444444444],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "Setpoint cooling oC"
    annotation (Placement(transformation(extent={{-94,-54},{-82,-42}})));
  Modelica.Blocks.Interfaces.RealInput TZon "Zone temperature measurement"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput enaDx
    "Enable DX unit control signal"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput yHea "Heating control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput yDamOut
    "Outside air damper control signal"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(varTz.y, cooCoiCon.u)
    annotation (Line(points={{-29,-42},{-18,-42}}, color={0,0,127}));
  connect(varTz1.y, heaCoiCon.u)
    annotation (Line(points={{-33,-80},{-28,-80}}, color={0,0,127}));
  connect(heaCoiCon.y, boo2Rea.u)
    annotation (Line(points={{-5,-80},{12,-80}},   color={255,0,255}));
  connect(from_degC.y, varTz.u2) annotation (Line(points={{-67.7,-47},{-60.85,
          -47},{-60.85,-48},{-52,-48}},   color={0,0,127}));
  connect(from_degC1.y, varTz1.u1) annotation (Line(points={{-65.7,-75},{-60.85,
          -75},{-60.85,-74},{-56,-74}},           color={0,0,127}));
  connect(TSetHea.y[1], from_degC1.u) annotation (Line(points={{-81.4,-76},{-76,
          -76},{-76,-75},{-72.6,-75}},        color={0,0,127}));
  connect(TSetCoo.y[1], from_degC.u) annotation (Line(points={{-81.4,-48},{-78,
          -48},{-78,-47},{-74.6,-47}},        color={0,0,127}));
  connect(varTz.u1, TZon) annotation (Line(points={{-52,-36},{-60,-36},{-60,0},
          {-120,0}}, color={0,0,127}));
  connect(varTz1.u2, TZon) annotation (Line(points={{-56,-86},{-60,-86},{-60,0},
          {-120,0}},    color={0,0,127}));
  connect(cooCoiCon.y, enaDx) annotation (Line(points={{5,-42},{22,-42},{22,-40},
          {60,-40},{60,40},{110,40}},      color={255,0,255}));
  connect(yfan.y, yFan)
    annotation (Line(points={{-79,80},{110,80}},  color={0,0,127}));
  connect(boo2Rea.y, yHea) annotation (Line(points={{35,-80},{62,-80},{62,0},{
          110,0}},
               color={0,0,127}));
  connect(yOA.y, yDamOut) annotation (Line(points={{-79,60},{80,60},{80,-40},{
          110,-40}},                  color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-100,140},{100,100}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
        graphics={      Rectangle(
          extent={{-96,-20},{56,-94}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}));
end Control_Staged;
