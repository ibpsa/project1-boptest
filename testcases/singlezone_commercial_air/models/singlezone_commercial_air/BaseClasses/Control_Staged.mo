within singlezone_commercial_air.BaseClasses;
model Control_Staged "Control model for staged RTU"
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1.51 "Nominal flow through supply fan";
  parameter Real stage_ratio_airflow = 0.66 "No load or cooling speed 1 airflow ratio";
  /* control & auxiliaries */

  Modelica.Blocks.Sources.RealExpression yOA(y=0.5)
    "Outside air damper if occupied"
    annotation (Placement(transformation(extent={{-100,86},{-80,106}})));

  Modelica.Blocks.Sources.RealExpression yFanCooSta1(y=stage_ratio_airflow)
    "Fan speed of no load or cooling stage 1"
    annotation (Placement(transformation(extent={{-80,12},{-60,32}})));

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
  Modelica.Blocks.Interfaces.RealOutput yHea "Heating control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput yDamOut
    "Outside air damper control signal"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Math.BooleanToInteger cooSta1Int(integerTrue=1)
    annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
  Modelica.Blocks.Interfaces.IntegerOutput dxSta "Stage of cooling coil dx"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Math.BooleanToInteger cooSta2Int(integerTrue=1)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis cooSta2(uLow=0.5, uHigh=0.66)
    "Hysteresis to switch on cooling stage 2"
    annotation (Placement(transformation(extent={{-16,-20},{4,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis cooSta1(uLow=0.05, uHigh=0.5)
    "Hysteresis to switch on cooling stage 1"
    annotation (Placement(transformation(extent={{-16,-52},{4,-32}})));
  Modelica.Blocks.MathInteger.Sum sumSta(nu=2)
    annotation (Placement(transformation(extent={{64,34},{76,46}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Buildings.Controls.Continuous.LimPID conCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=1,
    Ti=120,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-54,-58},{-34,-38}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis heaSta(uLow=-0.5, uHigh=0.5)
    "Hysteresis to switch on heating stage 1"
    annotation (Placement(transformation(extent={{-16,-90},{4,-70}})));
  Modelica.Blocks.Logical.Switch heaStaFan "Switch for heating fan speed"
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Sources.RealExpression yfanHea(y=1)
    "Fan speed during heating"
    annotation (Placement(transformation(extent={{-40,76},{-20,96}})));
  Modelica.Blocks.Math.BooleanToReal heaRea(realTrue=1)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Modelica.Blocks.Math.Add conHea(k2=-1)
    annotation (Placement(transformation(extent={{-54,-90},{-34,-70}})));
  Modelica.Blocks.Interfaces.BooleanInput occ "Occupied status"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Logical.Switch yOAOccSwi
    "Switch of outside air damper minimum position for occupancy"
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.RealExpression yOAUnocc(y=0)
    "Outside air damper if unoccupied"
    annotation (Placement(transformation(extent={{-100,32},{-80,52}})));
  Modelica.Blocks.Logical.Switch minFanSpeCoo
    "Switch for minimum fan speed for cooling"
    annotation (Placement(transformation(extent={{-40,4},{-20,24}})));
  Modelica.Blocks.Sources.RealExpression yFanCooUnocc(y=0)
    "Fan speed if unoccupied"
    annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
  Modelica.Blocks.Logical.Switch fanSpeCoo2 "Fan speed switch to stage 2"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression yFanCooSta2(y=1)
    "Fan speed if cooling stage 2"
    annotation (Placement(transformation(extent={{-40,46},{-20,66}})));
equation
  connect(TSetHea.y[1], from_degC1.u) annotation (Line(points={{-81.4,-76},{-76,
          -76},{-76,-75},{-72.6,-75}},        color={0,0,127}));
  connect(TSetCoo.y[1], from_degC.u) annotation (Line(points={{-81.4,-48},{-78,
          -48},{-78,-47},{-74.6,-47}},        color={0,0,127}));
  connect(cooSta2.u, cooSta1.u) annotation (Line(points={{-18,-10},{-24,-10},{
          -24,-42},{-18,-42}}, color={0,0,127}));
  connect(cooSta2.y, cooSta2Int.u)
    annotation (Line(points={{6,-10},{18,-10}}, color={255,0,255}));
  connect(cooSta1.y, cooSta1Int.u)
    annotation (Line(points={{6,-42},{18,-42}}, color={255,0,255}));
  connect(sumSta.y, dxSta)
    annotation (Line(points={{76.9,40},{110,40}}, color={255,127,0}));
  connect(cooSta1Int.y, sumSta.u[1]) annotation (Line(points={{41,-42},{60,-42},
          {60,42.1},{64,42.1}}, color={255,127,0}));
  connect(cooSta2Int.y, sumSta.u[2]) annotation (Line(points={{41,-10},{58,-10},
          {58,37.9},{64,37.9}}, color={255,127,0}));
  connect(from_degC.y, conCoo.u_s) annotation (Line(points={{-67.7,-47},{-62.85,
          -47},{-62.85,-48},{-56,-48}}, color={0,0,127}));
  connect(conCoo.u_m, TZon) annotation (Line(points={{-44,-60},{-44,-64},{-60,
          -64},{-60,0},{-120,0}}, color={0,0,127}));
  connect(conCoo.y, cooSta1.u) annotation (Line(points={{-33,-48},{-24,-48},{
          -24,-42},{-18,-42}}, color={0,0,127}));
  connect(yfanHea.y, heaStaFan.u1) annotation (Line(points={{-19,86},{4,86},{4,
          88},{28,88}}, color={0,0,127}));
  connect(heaSta.y, heaStaFan.u2) annotation (Line(points={{6,-80},{14,-80},{14,
          80},{28,80}}, color={255,0,255}));
  connect(heaSta.y, heaRea.u)
    annotation (Line(points={{6,-80},{18,-80}}, color={255,0,255}));
  connect(heaRea.y, yHea) annotation (Line(points={{41,-80},{70,-80},{70,0},{
          110,0}}, color={0,0,127}));
  connect(conHea.y, heaSta.u)
    annotation (Line(points={{-33,-80},{-18,-80}}, color={0,0,127}));
  connect(from_degC1.y, conHea.u1) annotation (Line(points={{-65.7,-75},{-60.85,
          -75},{-60.85,-74},{-56,-74}}, color={0,0,127}));
  connect(conHea.u2, TZon) annotation (Line(points={{-56,-86},{-60,-86},{-60,0},
          {-120,0}}, color={0,0,127}));
  connect(heaStaFan.y, yFan)
    annotation (Line(points={{51,80},{110,80}}, color={0,0,127}));
  connect(yOA.y, yOAOccSwi.u1)
    annotation (Line(points={{-79,96},{-72,96},{-72,88}}, color={0,0,127}));
  connect(occ, yOAOccSwi.u2) annotation (Line(points={{-120,60},{-80,60},{-80,
          80},{-72,80}}, color={255,0,255}));
  connect(yOAUnocc.y, yOAOccSwi.u3)
    annotation (Line(points={{-79,42},{-72,42},{-72,72}}, color={0,0,127}));
  connect(yOAOccSwi.y, yDamOut) annotation (Line(points={{-49,80},{-46,80},{-46,
          100},{90,100},{90,-40},{110,-40}}, color={0,0,127}));
  connect(occ, minFanSpeCoo.u2) annotation (Line(points={{-120,60},{-50,60},{
          -50,14},{-42,14}}, color={255,0,255}));
  connect(yFanCooSta1.y, minFanSpeCoo.u1)
    annotation (Line(points={{-59,22},{-42,22}}, color={0,0,127}));
  connect(yFanCooUnocc.y, minFanSpeCoo.u3)
    annotation (Line(points={{-59,6},{-42,6}}, color={0,0,127}));
  connect(cooSta2.y, fanSpeCoo2.u2) annotation (Line(points={{6,-10},{10,-10},{
          10,34},{-20,34},{-20,50},{-12,50}}, color={255,0,255}));
  connect(fanSpeCoo2.y, heaStaFan.u3) annotation (Line(points={{11,50},{20,50},
          {20,72},{28,72}}, color={0,0,127}));
  connect(yFanCooSta2.y, fanSpeCoo2.u1) annotation (Line(points={{-19,56},{-16,
          56},{-16,58},{-12,58}}, color={0,0,127}));
  connect(minFanSpeCoo.y, fanSpeCoo2.u3)
    annotation (Line(points={{-19,14},{-12,14},{-12,42}}, color={0,0,127}));
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
            100}})));
end Control_Staged;
