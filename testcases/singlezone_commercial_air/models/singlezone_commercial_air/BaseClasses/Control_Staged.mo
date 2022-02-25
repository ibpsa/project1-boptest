within singlezone_commercial_air.BaseClasses;
model Control_Staged "Control model for staged RTU"
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1.51 "Nominal flow through supply fan";
  parameter Real stage_ratio_airflow = 0.66 "No load or cooling speed 1 airflow ratio";
  /* control & auxiliaries */

  Modelica.Blocks.Sources.RealExpression yFanCooSta1(y=stage_ratio_airflow)
    "Fan speed of no load or cooling stage 1"
    annotation (Placement(transformation(extent={{-80,32},{-60,52}})));

  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-174,-154},{-166,-146}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-174,-184},{-166,-176}})));
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
    annotation (Placement(transformation(extent={{-200,-190},{-180,-170}})));
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
    annotation (Placement(transformation(extent={{-200,-160},{-180,-140}})));
  Modelica.Blocks.Interfaces.RealInput TZon "Zone temperature measurement"
    annotation (Placement(transformation(extent={{-240,60},{-200,100}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        yHea "Heating control signal"
    annotation (Placement(transformation(extent={{200,-10},{220,10}})));
  Modelica.Blocks.Interfaces.RealOutput yDamOut
    "Outside air damper control signal"
    annotation (Placement(transformation(extent={{200,-50},{220,-30}})));
  Modelica.Blocks.Math.BooleanToReal    cooSta1Int
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  Modelica.Blocks.Interfaces.IntegerOutput dxSta "Stage of cooling coil dx"
    annotation (Placement(transformation(extent={{200,30},{220,50}})));
  Modelica.Blocks.Math.BooleanToReal    cooSta2Int
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis cooSta2(uLow=0.5, uHigh=0.66)
    "Hysteresis to switch on cooling stage 2"
    annotation (Placement(transformation(extent={{10,-2},{30,18}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis cooSta1(uLow=0.1, uHigh=0.2)
    "Hysteresis to switch on cooling stage 1"
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.MathInteger.Sum sumSta(nu=2)
    annotation (Placement(transformation(extent={{174,34},{186,46}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{200,70},{220,90}})));
  Buildings.Controls.Continuous.LimPID conCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=300,
    reverseActing=false,
    reset=Buildings.Types.Reset.Parameter)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Logical.Switch heaStaFan "Switch for heating fan speed"
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Sources.RealExpression yfanHea(y=1)
    "Fan speed during heating"
    annotation (Placement(transformation(extent={{-40,78},{-20,98}})));
  Modelica.Blocks.Math.BooleanToReal heaRea(realTrue=1)
    annotation (Placement(transformation(extent={{70,-100},{90,-80}})));
  Modelica.Blocks.Interfaces.BooleanInput occ "Occupied status"
    annotation (Placement(transformation(extent={{-240,120},{-200,160}})));
  Modelica.Blocks.Logical.Switch yOAOccSwi
    "Switch of outside air damper minimum position for occupancy"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Logical.Switch minFanSpeCoo
    "Switch for minimum fan speed for cooling"
    annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
  Modelica.Blocks.Sources.RealExpression yFanCooUnocc(y=0)
    "Fan speed if unoccupied"
    annotation (Placement(transformation(extent={{-80,16},{-60,36}})));
  Modelica.Blocks.Logical.Switch fanSpeCoo2 "Fan speed switch to stage 2"
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Sources.RealExpression yFanCooSta2(y=1)
    "Fan speed if cooling stage 2"
    annotation (Placement(transformation(extent={{-40,64},{-20,84}})));
  Modelica.Blocks.Interfaces.RealInput TSup
    "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-240,0},{-200,40}})));
  Modelica.Blocks.Sources.RealExpression SATCH(y=12.78 + 273.15)
    "High cooling mode supply air temperature set point"
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
  CoolHeatMode cooHeaMod
    annotation (Placement(transformation(extent={{-88,-40},{-66,-20}})));
  Modelica.Blocks.Routing.Extractor SATExt(nin=3, allowOutOfRange=false)
    "Select correct supply air temperature set point"
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Blocks.Sources.RealExpression SATCL(y=15.56 + 273.15)
    "Low cooling mode supply air temperature set point"
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=2)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  ControllerEconomizerOffset conEco(TiEco=300)
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Modelica.Blocks.Sources.RealExpression minOADamOcc(y=0.5)
    "Minimum outside air damper position when occupied"
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.RealExpression minOADamUnocc(y=0.0)
    "Minimum outside air damper position when unoccupied"
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  Modelica.Blocks.Interfaces.RealInput TRet
    "Return air temperature measurement"
    annotation (Placement(transformation(extent={{-240,-60},{-200,-20}})));
  Modelica.Blocks.Interfaces.RealInput TMix "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{-240,-140},{-200,-100}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-210,190},{-190,210}})));
  Modelica.Blocks.Math.RealToInteger rea2Int2
    annotation (Placement(transformation(extent={{138,0},{158,20}})));
  Modelica.Blocks.Math.RealToInteger rea2Int1
    annotation (Placement(transformation(extent={{138,-30},{158,-10}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveOADam(description="Control signal for outside air damper position",
      u(
      unit="1",
      min=0,
      max=1)) "Overwrite control signal for outside air damper"
    annotation (Placement(transformation(extent={{100,100},{120,120}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveFan(description="Control signal for supply fan speed",
      u(
      unit="1",
      min=0,
      max=1)) "Overwrite control signal for supply fan speed"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveHea(description="Control signal for gas furnace heating rate",
      u(
      unit="1",
      min=0,
      max=1)) "Overwrite control signal for gas furnace heating rate"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveDXSta1(description="Control signal for DX stage 1",
      u(
      unit="1",
      min=0,
      max=1)) "Overwrite control signal for DX stage 1"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveDXSta2(description="Control signal for DX stage 2",
      u(
      unit="1",
      min=0,
      max=1)) "Overwrite control signal for DX stage 2"
    annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo(description="Zone air temperature set point for cooling",
      u(
      unit="K",
      min=273.15 + 15,
      max=273.15 + 30)) "Overwrite control signal for zone cooling set point"
    annotation (Placement(transformation(extent={{-140,-160},{-120,-140}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea(description="Zone air temperature set point for heating",
      u(
      unit="K",
      min=273.15 + 15,
      max=273.15 + 30)) "Overwrite control signal for zone heating set point"
    annotation (Placement(transformation(extent={{-140,-190},{-120,-170}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetSupCooLow(description="Supply air temperature set point for low cooling",
      u(
      unit="K",
      min=273.15 + 11,
      max=273.15 + 16))
    "Overwrite control signal for supply air temperature set point for low cooling"
    annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetSupCooHig(description="Supply air temperature set point for high cooling",
      u(
      unit="K",
      min=273.15 + 11,
      max=273.15 + 16))
    "Overwrite control signal for supply air temperature set point for high cooling"
    annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveOADamMinOcc(description="Control signal for outside air damper position minimum position when occupied",
      u(
      unit="1",
      min=0,
      max=1))
    "Overwrite control signal for outside air damper minimum position for occupancy"
    annotation (Placement(transformation(extent={{-134,80},{-114,100}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
equation
  connect(TSetHea.y[1], from_degC1.u) annotation (Line(points={{-179,-180},{-174.8,
          -180}},                             color={0,0,127}));
  connect(TSetCoo.y[1], from_degC.u) annotation (Line(points={{-179,-150},{-174.8,
          -150}},                             color={0,0,127}));
  connect(sumSta.y, dxSta)
    annotation (Line(points={{186.9,40},{210,40}},color={255,127,0}));
  connect(conCoo.y, cooSta1.u) annotation (Line(points={{1,-30},{4,-30},{4,-20},
          {8,-20}},            color={0,0,127}));
  connect(yfanHea.y, heaStaFan.u1) annotation (Line(points={{-19,88},{28,88}},
                        color={0,0,127}));
  connect(occ, minFanSpeCoo.u2) annotation (Line(points={{-220,140},{-180,140},{
          -180,34},{-42,34}},color={255,0,255}));
  connect(yFanCooSta1.y, minFanSpeCoo.u1)
    annotation (Line(points={{-59,42},{-42,42}}, color={0,0,127}));
  connect(yFanCooUnocc.y, minFanSpeCoo.u3)
    annotation (Line(points={{-59,26},{-42,26}},
                                               color={0,0,127}));
  connect(fanSpeCoo2.y, heaStaFan.u3) annotation (Line(points={{11,70},{20,70},
          {20,72},{28,72}}, color={0,0,127}));
  connect(yFanCooSta2.y, fanSpeCoo2.u1) annotation (Line(points={{-19,74},{-16,
          74},{-16,78},{-12,78}}, color={0,0,127}));
  connect(minFanSpeCoo.y, fanSpeCoo2.u3)
    annotation (Line(points={{-19,34},{-12,34},{-12,62}}, color={0,0,127}));
  connect(TZon, cooHeaMod.TZon) annotation (Line(points={{-220,80},{-184,80},{-184,
          -24},{-90.2,-24}}, color={0,0,127}));
  connect(cooSta2.u, cooSta1.u) annotation (Line(points={{8,8},{4,8},{4,-20},{8,
          -20}},    color={0,0,127}));
  connect(SATExt.y, conCoo.u_s)
    annotation (Line(points={{-29,-30},{-22,-30}}, color={0,0,127}));
  connect(cooHeaMod.cooDem, SATExt.index) annotation (Line(points={{-64.9,-26},
          {-60,-26},{-60,-50},{-40,-50},{-40,-42}}, color={255,127,0}));
  connect(and1.y, cooSta1Int.u)
    annotation (Line(points={{61,-20},{68,-20}}, color={255,0,255}));
  connect(cooSta1.y, and1.u1)
    annotation (Line(points={{32,-20},{38,-20}}, color={255,0,255}));
  connect(cooSta2.y, and2.u1)
    annotation (Line(points={{32,8},{36,8},{36,10},{38,10}},
                                                 color={255,0,255}));
  connect(and2.y, cooSta2Int.u)
    annotation (Line(points={{61,10},{68,10}},   color={255,0,255}));
  connect(and1.y, and2.u2) annotation (Line(points={{61,-20},{64,-20},{64,-4},{
          32,-4},{32,2},{38,2}},       color={255,0,255}));
  connect(cooHeaMod.cooEna, and1.u2) annotation (Line(points={{-64.9,-30},{-62,
          -30},{-62,-52},{34,-52},{34,-28},{38,-28}}, color={255,0,255}));
  connect(heaStaFan.u2, cooHeaMod.heaEna) annotation (Line(points={{28,80},{18,
          80},{18,32},{6,32},{6,-54},{-64,-54},{-64,-34},{-64.9,-34}}, color={
          255,0,255}));
  connect(heaRea.u, cooHeaMod.heaEna) annotation (Line(points={{68,-90},{34,-90},
          {34,-54},{-64,-54},{-64,-34},{-64.9,-34}}, color={255,0,255}));
  connect(integerToReal.y, greaterThreshold.u)
    annotation (Line(points={{-29,0},{-22,0}},     color={0,0,127}));
  connect(cooHeaMod.cooDem, integerToReal.u) annotation (Line(points={{-64.9,
          -26},{-60,-26},{-60,0},{-52,0}},color={255,127,0}));
  connect(greaterThreshold.y, fanSpeCoo2.u2) annotation (Line(points={{1,0},{2,
          0},{2,54},{-16,54},{-16,70},{-12,70}},     color={255,0,255}));
  connect(TSup, SATExt.u[1]) annotation (Line(points={{-220,20},{-188,20},{-188,
          -60},{-56,-60},{-56,-31.3333},{-52,-31.3333}},
                                     color={0,0,127}));
  connect(minOADamUnocc.y, yOAOccSwi.u3) annotation (Line(points={{-139,60},{-110,
          60},{-110,82},{-102,82}},      color={0,0,127}));
  connect(occ, yOAOccSwi.u2) annotation (Line(points={{-220,140},{-106,140},{-106,
          90},{-102,90}}, color={255,0,255}));
  connect(yOAOccSwi.y, conEco.minOADamPos) annotation (Line(points={{-79,90},{
          -60,90},{-60,108},{-41,108}}, color={0,0,127}));
  connect(conEco.cooSta, and1.u2) annotation (Line(points={{-41,102},{-62,102},
          {-62,-52},{34,-52},{34,-28},{38,-28}}, color={255,0,255}));
  connect(conEco.TSupSet, SATExt.y) annotation (Line(points={{-41,118},{-46,118},
          {-46,52},{-16,52},{-16,20},{-26,20},{-26,-30},{-29,-30}}, color={0,0,
          127}));
  connect(conEco.TMix, TMix) annotation (Line(points={{-41,115},{-166,115},{-166,
          -120},{-220,-120}},      color={0,0,127}));
  connect(conEco.TRet, TRet) annotation (Line(points={{-41,112},{-168,112},{-168,
          -40},{-220,-40}},        color={0,0,127}));
  connect(weaBus.TDryBul, conEco.TOut) annotation (Line(
      points={{-200,200},{-70,200},{-70,105},{-41,105}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conCoo.trigger, and1.u2) annotation (Line(points={{-18,-42},{-18,-52},
          {34,-52},{34,-28},{38,-28}}, color={255,0,255}));
  connect(TSup, conCoo.u_m) annotation (Line(points={{-220,20},{-188,20},{-188,-60},
          {-10,-60},{-10,-42}}, color={0,0,127}));
  connect(rea2Int1.y, sumSta.u[1]) annotation (Line(points={{159,-20},{170,-20},
          {170,42.1},{174,42.1}}, color={255,127,0}));
  connect(rea2Int2.y, sumSta.u[2]) annotation (Line(points={{159,10},{166,10},{166,
          37.9},{174,37.9}}, color={255,127,0}));
  connect(conEco.yOADam, oveOADam.u)
    annotation (Line(points={{-19,110},{98,110}}, color={0,0,127}));
  connect(oveOADam.y, yDamOut) annotation (Line(points={{121,110},{192,110},{192,
          -40},{210,-40}}, color={0,0,127}));
  connect(heaStaFan.y, oveFan.u)
    annotation (Line(points={{51,80},{98,80}}, color={0,0,127}));
  connect(oveFan.y, yFan)
    annotation (Line(points={{121,80},{210,80}}, color={0,0,127}));
  connect(heaRea.y, oveHea.u)
    annotation (Line(points={{91,-90},{98,-90}}, color={0,0,127}));
  connect(cooSta1Int.y, oveDXSta1.u)
    annotation (Line(points={{91,-20},{98,-20}}, color={0,0,127}));
  connect(oveDXSta1.y, rea2Int1.u)
    annotation (Line(points={{121,-20},{136,-20}}, color={0,0,127}));
  connect(cooSta2Int.y, oveDXSta2.u)
    annotation (Line(points={{91,10},{98,10}}, color={0,0,127}));
  connect(oveDXSta2.y, rea2Int2.u)
    annotation (Line(points={{121,10},{136,10}}, color={0,0,127}));
  connect(cooHeaMod.TSetCoo, oveTSetCoo.y) annotation (Line(points={{-90.2,-30},
          {-104,-30},{-104,-150},{-119,-150}}, color={0,0,127}));
  connect(oveTSetCoo.u, from_degC.y)
    annotation (Line(points={{-142,-150},{-165.6,-150}}, color={0,0,127}));
  connect(cooHeaMod.TSetHea, oveTSetHea.y) annotation (Line(points={{-90.2,-36},
          {-106,-36},{-106,-180},{-119,-180}}, color={0,0,127}));
  connect(oveTSetHea.u, from_degC1.y)
    annotation (Line(points={{-142,-180},{-165.6,-180}}, color={0,0,127}));
  connect(SATCL.y, oveTSetSupCooLow.u)
    annotation (Line(points={{-119,10},{-112,10}}, color={0,0,127}));
  connect(oveTSetSupCooLow.y, SATExt.u[2]) annotation (Line(points={{-89,10},{-58,
          10},{-58,-30},{-52,-30}}, color={0,0,127}));
  connect(SATCH.y, oveTSetSupCooHig.u)
    annotation (Line(points={{-119,-10},{-112,-10}}, color={0,0,127}));
  connect(oveTSetSupCooHig.y, SATExt.u[3]) annotation (Line(points={{-89,-10},{
          -56,-10},{-56,-28.6667},{-52,-28.6667}},
                                               color={0,0,127}));
  connect(minOADamOcc.y, oveOADamMinOcc.u)
    annotation (Line(points={{-139,90},{-136,90}}, color={0,0,127}));
  connect(oveOADamMinOcc.y, yOAOccSwi.u1) annotation (Line(points={{-113,90},{-108,
          90},{-108,98},{-102,98}}, color={0,0,127}));
  connect(oveHea.y, realToBoolean.u)
    annotation (Line(points={{121,-90},{138,-90}}, color={0,0,127}));
  connect(realToBoolean.y, yHea) annotation (Line(points={{161,-90},{180,-90},{180,
          0},{210,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},
            {200,200}}),       graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-100,240},{100,200}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})));
end Control_Staged;
