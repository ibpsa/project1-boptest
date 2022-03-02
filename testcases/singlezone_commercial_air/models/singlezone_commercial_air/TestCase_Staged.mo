within singlezone_commercial_air;
model TestCase_Staged "Test case model with single staged RTU"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Air medium model with CO2";

  /* weather */
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "Resources/USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.mos",
      computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,90})));

  /* Envelope */
  BaseClasses.Envelope zon(redeclare package MediumA = MediumA,
                           lat=weaDat.lat) "Zone envelope model"
    annotation (Placement(transformation(extent={{60,-20},{100,20}})));

  /* control & auxiliaries */

  Buildings.BoundaryConditions.WeatherData.Bus weaBus1
    annotation (Placement(transformation(extent={{-44,80},{-24,100}})));

  BaseClasses.RTU_Staged rtu(
    redeclare package MediumA = MediumA,
                             dpBuiStaSet(displayUnit="Pa"), dp_nominal(
        displayUnit="Pa"))   "Packaged RTU model"
    annotation (Placement(transformation(extent={{-14,-12},{14,12}})));
  BaseClasses.Control_Staged con "RTU control model"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Continuous.Integrator EEleInt "Electrical energy"
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Modelica.Blocks.Continuous.Integrator EGasInt "Gas energy"
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Blocks.Interfaces.RealOutput EEle "Electrical energy"
    annotation (Placement(transformation(extent={{120,70},{140,90}})));
  Modelica.Blocks.Interfaces.RealOutput EGas "Gas energy"
    annotation (Placement(transformation(extent={{120,40},{140,60}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta
    "Weather station for BOPTEST"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
equation
  connect(weaDat.weaBus, zon.weaBus) annotation (Line(
      points={{-100,90},{60,90},{60,19.2},{60.4,19.2}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus1, weaDat.weaBus) annotation (Line(
      points={{-34,90},{-100,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(rtu.port_ret, zon.b) annotation (Line(points={{14,6},{38,6},{38,12},{
          61,12}},    color={0,127,255}));
  connect(rtu.port_sup, zon.a) annotation (Line(points={{14,0},{38,0},{38,-8},{
          61.2,-8}},    color={0,127,255}));
  connect(weaBus1, rtu.weaBus) annotation (Line(
      points={{-34,90},{-34,12},{-14,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(con.yFan, rtu.uFan)
    annotation (Line(points={{-59.5,4},{-38,4},{-38,8},{-15.75,8}},
                                               color={0,0,127}));
  connect(con.yDamOut, rtu.yDamOut)
    annotation (Line(points={{-59.5,-2},{-36,-2},{-36,-4},{-15.75,-4}},
                                                 color={0,0,127}));
  connect(zon.Tz, con.TZon) annotation (Line(points={{102,0},{120,0},{120,-40},{
          -108,-40},{-108,4},{-81,4}}, color={0,0,127}));
  connect(con.dxSta, rtu.dxSta)
    annotation (Line(points={{-59.5,2},{-36,2},{-36,4},{-15.75,4}},
                                               color={255,127,0}));
  connect(zon.occ, con.occ) annotation (Line(points={{102,-16},{118,-16},{118,-38},
          {-106,-38},{-106,7},{-81,7}},      color={255,0,255}));
  connect(con.TSup, rtu.TSup) annotation (Line(points={{-81,1},{-88,1},{-88,-22},
          {22,-22},{22,-6},{14.875,-6}},                 color={0,0,127}));
  connect(rtu.TMix, con.TMix) annotation (Line(points={{14.875,-10},{18,-10},{18,
          -18},{-84,-18},{-84,-6},{-81,-6}},        color={0,0,127}));
  connect(rtu.TRet, con.TRet) annotation (Line(points={{14.875,-8},{20,-8},{20,-20},
          {-86,-20},{-86,-2},{-81,-2}},                  color={0,0,127}));
  connect(con.weaBus, weaDat.weaBus) annotation (Line(
      points={{-80,10},{-80,90},{-100,90}},
      color={255,204,51},
      thickness=0.5));
  connect(EEleInt.y, EEle)
    annotation (Line(points={{101,80},{130,80}}, color={0,0,127}));
  connect(EGasInt.y, EGas)
    annotation (Line(points={{101,50},{130,50}}, color={0,0,127}));
  connect(add.y, EEleInt.u) annotation (Line(points={{51,70},{68,70},{68,80},{78,
          80}}, color={0,0,127}));
  connect(add.u2, rtu.PFan) annotation (Line(points={{28,64},{20,64},{20,10},{14.875,
          10}}, color={0,0,127}));
  connect(add.u1, rtu.PDx) annotation (Line(points={{28,76},{18,76},{18,12},{14.875,
          12}}, color={0,0,127}));
  connect(rtu.PGas, EGasInt.u) annotation (Line(points={{14.875,8},{22,8},{22,50},
          {78,50}}, color={0,0,127}));
  connect(con.yHea, rtu.uHea)
    annotation (Line(points={{-59.5,0},{-15.75,0}}, color={255,0,255}));
  connect(weaSta.weaBus, weaDat.weaBus) annotation (Line(
      points={{-59.9,69.9},{-80,70},{-80,90},{-100,90}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},
            {120,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,100}}),
        graphics={Text(
          extent={{-34,-64},{40,-104}},
          lineColor={28,108,200},
          fontSize=18,
          textString="design air flow rate [m3/s]: 1.51 from E+ html
coil sizing (PSZ-AC_6): 18 kW cooling, 50 kW heating from E+ html

Current 180 Day Modelica Simulation:
EEle: 6.30924E9 J
EGas: 4.76994E10 J  ")}),
    experiment(
      StopTime=15552000,
      Interval=120.000096,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end TestCase_Staged;
