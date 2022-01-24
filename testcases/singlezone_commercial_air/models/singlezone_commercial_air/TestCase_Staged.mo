within singlezone_commercial_air;
model TestCase_Staged "Test case model with single staged RTU"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air "Air medium model";

  /* weather */
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://singlezone_commercial_air/USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.mos"),
      computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,90})));

  /* Envelope */
  BaseClasses.Envelope zon(lat=weaDat.lat) "Zone envelope model"
    annotation (Placement(transformation(extent={{60,-20},{100,20}})));

  /* control & auxiliaries */

  Buildings.BoundaryConditions.WeatherData.Bus weaBus1
    annotation (Placement(transformation(extent={{-44,80},{-24,100}})));

  BaseClasses.RTU_Staged rtu "Packaged RTU model"
    annotation (Placement(transformation(extent={{-12,-10},{16,10}})));
  BaseClasses.Control_Staged con "RTU control model"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
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
  connect(rtu.port_ret, zon.b) annotation (Line(points={{16,6},{38,6},{38,11.6},
          {61,11.6}}, color={0,127,255}));
  connect(rtu.port_sup, zon.a) annotation (Line(points={{16,0},{38,0},{38,-8.8},
          {61.2,-8.8}}, color={0,127,255}));
  connect(weaBus1, rtu.weaBus) annotation (Line(
      points={{-34,90},{-34,10},{-12,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(con.yFan, rtu.uFan)
    annotation (Line(points={{-59,8},{-14,8}}, color={0,0,127}));
  connect(con.enaDx, rtu.enaDx)
    annotation (Line(points={{-59,4},{-14,4}}, color={255,0,255}));
  connect(con.yHea, rtu.uHea)
    annotation (Line(points={{-59,0},{-14,0}}, color={0,0,127}));
  connect(con.yDamOut, rtu.yDamOut)
    annotation (Line(points={{-59,-4},{-14,-4}}, color={0,0,127}));
  connect(zon.Tz, con.TZon) annotation (Line(points={{102,0},{120,0},{120,-40},{
          -108,-40},{-108,0},{-82,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},
            {120,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,100}}),
        graphics={Text(
          extent={{-34,-86},{40,-126}},
          lineColor={28,108,200},
          textString="design air flow rate [m3/s]: 1.51 from htm
coil sizing (PSZ-AC_6): 18 kW cooling, 50 kW heating from htm ",
          fontSize=18)}));
end TestCase_Staged;
