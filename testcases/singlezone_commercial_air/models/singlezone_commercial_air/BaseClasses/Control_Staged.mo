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
    annotation (Placement(transformation(extent={{-114,-24},{-106,-16}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-116,-54},{-108,-46}})));
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
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
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
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  Modelica.Blocks.Interfaces.RealInput TZon "Zone temperature measurement"
    annotation (Placement(transformation(extent={{-180,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealOutput yHea "Heating control signal"
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  Modelica.Blocks.Interfaces.RealOutput yDamOut
    "Outside air damper control signal"
    annotation (Placement(transformation(extent={{140,-50},{160,-30}})));
  Modelica.Blocks.Math.BooleanToInteger cooSta1Int(integerTrue=1)
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  Modelica.Blocks.Interfaces.IntegerOutput dxSta "Stage of cooling coil dx"
    annotation (Placement(transformation(extent={{140,30},{160,50}})));
  Modelica.Blocks.Math.BooleanToInteger cooSta2Int(integerTrue=1)
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis cooSta2(uLow=0.5, uHigh=0.66)
    "Hysteresis to switch on cooling stage 2"
    annotation (Placement(transformation(extent={{10,-20},{30,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis cooSta1(uLow=0.05, uHigh=0.5)
    "Hysteresis to switch on cooling stage 1"
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  Modelica.Blocks.MathInteger.Sum sumSta(nu=2)
    annotation (Placement(transformation(extent={{100,34},{112,46}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{140,70},{160,90}})));
  Buildings.Controls.Continuous.LimPID conCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=900,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Logical.Switch heaStaFan "Switch for heating fan speed"
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Sources.RealExpression yfanHea(y=1)
    "Fan speed during heating"
    annotation (Placement(transformation(extent={{-40,76},{-20,96}})));
  Modelica.Blocks.Math.BooleanToReal heaRea(realTrue=1)
    annotation (Placement(transformation(extent={{70,-120},{90,-100}})));
  Modelica.Blocks.Interfaces.BooleanInput occ "Occupied status"
    annotation (Placement(transformation(extent={{-180,40},{-140,80}})));
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
  Modelica.Blocks.Interfaces.RealInput TSup
    "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-180,-100},{-140,-60}})));
  Modelica.Blocks.Sources.RealExpression SATCH(y=12.78 + 273.15)
    "High cooling mode supply air temperature set point"
    annotation (Placement(transformation(extent={{-90,-36},{-70,-16}})));
  CoolHeatMode coolHeatMode
    annotation (Placement(transformation(extent={{-88,-60},{-66,-40}})));
  Modelica.Blocks.Routing.Extractor SATExt(
    nin=2,
    allowOutOfRange=true,
    outOfRangeValue=99 + 273.15)
    "Select correct supply air temperature set point"
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Modelica.Blocks.Sources.RealExpression SATCL(y=15.56 + 273.15)
    "Low cooling mode supply air temperature set point"
    annotation (Placement(transformation(extent={{-90,-22},{-70,-2}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=1)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
equation
  connect(TSetHea.y[1], from_degC1.u) annotation (Line(points={{-119,-50},{
          -116.8,-50}},                       color={0,0,127}));
  connect(TSetCoo.y[1], from_degC.u) annotation (Line(points={{-119,-20},{
          -114.8,-20}},                       color={0,0,127}));
  connect(sumSta.y, dxSta)
    annotation (Line(points={{112.9,40},{150,40}},color={255,127,0}));
  connect(cooSta1Int.y, sumSta.u[1]) annotation (Line(points={{91,-40},{96,-40},
          {96,42.1},{100,42.1}},color={255,127,0}));
  connect(cooSta2Int.y, sumSta.u[2]) annotation (Line(points={{91,-10},{94,-10},
          {94,37.9},{100,37.9}},color={255,127,0}));
  connect(conCoo.y, cooSta1.u) annotation (Line(points={{1,-50},{4,-50},{4,-40},
          {8,-40}},            color={0,0,127}));
  connect(yfanHea.y, heaStaFan.u1) annotation (Line(points={{-19,86},{4,86},{4,
          88},{28,88}}, color={0,0,127}));
  connect(heaRea.y, yHea) annotation (Line(points={{91,-110},{120,-110},{120,0},
          {150,0}},color={0,0,127}));
  connect(heaStaFan.y, yFan)
    annotation (Line(points={{51,80},{150,80}}, color={0,0,127}));
  connect(yOA.y, yOAOccSwi.u1)
    annotation (Line(points={{-79,96},{-72,96},{-72,88}}, color={0,0,127}));
  connect(occ, yOAOccSwi.u2) annotation (Line(points={{-160,60},{-80,60},{-80,
          80},{-72,80}}, color={255,0,255}));
  connect(yOAUnocc.y, yOAOccSwi.u3)
    annotation (Line(points={{-79,42},{-72,42},{-72,72}}, color={0,0,127}));
  connect(yOAOccSwi.y, yDamOut) annotation (Line(points={{-49,80},{-46,80},{-46,
          100},{118,100},{118,-40},{150,-40}},
                                             color={0,0,127}));
  connect(occ, minFanSpeCoo.u2) annotation (Line(points={{-160,60},{-50,60},{
          -50,14},{-42,14}}, color={255,0,255}));
  connect(yFanCooSta1.y, minFanSpeCoo.u1)
    annotation (Line(points={{-59,22},{-42,22}}, color={0,0,127}));
  connect(yFanCooUnocc.y, minFanSpeCoo.u3)
    annotation (Line(points={{-59,6},{-42,6}}, color={0,0,127}));
  connect(fanSpeCoo2.y, heaStaFan.u3) annotation (Line(points={{11,50},{20,50},
          {20,72},{28,72}}, color={0,0,127}));
  connect(yFanCooSta2.y, fanSpeCoo2.u1) annotation (Line(points={{-19,56},{-16,
          56},{-16,58},{-12,58}}, color={0,0,127}));
  connect(minFanSpeCoo.y, fanSpeCoo2.u3)
    annotation (Line(points={{-19,14},{-12,14},{-12,42}}, color={0,0,127}));
  connect(TZon, coolHeatMode.TZon) annotation (Line(points={{-160,0},{-100,0},{
          -100,-44},{-90.2,-44}}, color={0,0,127}));
  connect(coolHeatMode.TSetCoo, from_degC.y) annotation (Line(points={{-90.2,
          -50},{-104,-50},{-104,-20},{-105.6,-20}}, color={0,0,127}));
  connect(coolHeatMode.TSetHea, from_degC1.y) annotation (Line(points={{-90.2,
          -56},{-106,-56},{-106,-50},{-107.6,-50}}, color={0,0,127}));
  connect(cooSta2.u, cooSta1.u) annotation (Line(points={{8,-10},{4,-10},{4,-40},
          {8,-40}}, color={0,0,127}));
  connect(SATExt.y, conCoo.u_s)
    annotation (Line(points={{-29,-50},{-22,-50}}, color={0,0,127}));
  connect(SATCL.y, SATExt.u[1]) annotation (Line(points={{-69,-12},{-56,-12},{
          -56,-51},{-52,-51}}, color={0,0,127}));
  connect(SATCH.y, SATExt.u[2]) annotation (Line(points={{-69,-26},{-58,-26},{
          -58,-49},{-52,-49}}, color={0,0,127}));
  connect(coolHeatMode.cooDem, SATExt.index) annotation (Line(points={{-64.9,
          -46},{-60,-46},{-60,-70},{-40,-70},{-40,-62}}, color={255,127,0}));
  connect(TSup, conCoo.u_m) annotation (Line(points={{-160,-80},{-10,-80},{-10,
          -62}}, color={0,0,127}));
  connect(and1.y, cooSta1Int.u)
    annotation (Line(points={{61,-40},{68,-40}}, color={255,0,255}));
  connect(cooSta1.y, and1.u1)
    annotation (Line(points={{32,-40},{38,-40}}, color={255,0,255}));
  connect(cooSta2.y, and2.u1)
    annotation (Line(points={{32,-10},{38,-10}}, color={255,0,255}));
  connect(and2.y, cooSta2Int.u)
    annotation (Line(points={{61,-10},{68,-10}}, color={255,0,255}));
  connect(and1.y, and2.u2) annotation (Line(points={{61,-40},{64,-40},{64,-24},
          {32,-24},{32,-18},{38,-18}}, color={255,0,255}));
  connect(coolHeatMode.cooEna, and1.u2) annotation (Line(points={{-64.9,-50},{
          -62,-50},{-62,-72},{34,-72},{34,-48},{38,-48}}, color={255,0,255}));
  connect(heaStaFan.u2, coolHeatMode.heaEna) annotation (Line(points={{28,80},{
          18,80},{18,12},{6,12},{6,-74},{-64,-74},{-64,-54},{-64.9,-54}}, color
        ={255,0,255}));
  connect(heaRea.u, coolHeatMode.heaEna) annotation (Line(points={{68,-110},{34,
          -110},{34,-74},{-64,-74},{-64,-54},{-64.9,-54}}, color={255,0,255}));
  connect(integerToReal.y, greaterThreshold.u)
    annotation (Line(points={{-29,-20},{-22,-20}}, color={0,0,127}));
  connect(coolHeatMode.cooDem, integerToReal.u) annotation (Line(points={{-64.9,
          -46},{-60,-46},{-60,-20},{-52,-20}}, color={255,127,0}));
  connect(greaterThreshold.y, fanSpeCoo2.u2) annotation (Line(points={{1,-20},{
          2,-20},{2,34},{-20,34},{-20,50},{-12,50}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -140},{140,140}}), graphics={Rectangle(
          extent={{-140,140},{140,-140}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-100,180},{100,140}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,
            140}})));
end Control_Staged;
