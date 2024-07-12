within MultizoneOfficeComplexAir.BaseClasses.HVACSide;
package Examples
  extends Modelica.Icons.ExamplesPackage;
  model HVAC
    extends Modelica.Icons.Example;
    //package MediumAir = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Buildings library air media package with CO2";
    //package MediumHeaWat = Buildings.Media.Water "Medium model for heating water";

    MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC hVAC(
      floor1(duaFanAirHanUni(
          mixBox(mixBox(
              valRet(riseTime=15, y_start=1),
              valExh(riseTime=15, y_start=0),
              valFre(riseTime=15, y_start=0))),
          retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
          supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                  use_inputFilter=true, y_start=0))),
          cooCoi(val(use_inputFilter=true, y_start=0)))),
      floor2(duaFanAirHanUni(
          mixBox(mixBox(
              valRet(riseTime=15, y_start=1),
              valExh(riseTime=15, y_start=0),
              valFre(riseTime=15, y_start=0))),
          retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
          supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                  use_inputFilter=true, y_start=0))),
          cooCoi(val(use_inputFilter=true, y_start=0)))),
      floor3(duaFanAirHanUni(
          mixBox(mixBox(
              valRet(riseTime=15, y_start=1),
              valExh(riseTime=15, y_start=0),
              valFre(riseTime=15, y_start=0))),
          retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
          supFan(varSpe(variableSpeed(zerSpe(k=0))), withoutMotor(varSpeFloMov(
                  use_inputFilter=true, y_start=0))),
          cooCoi(val(use_inputFilter=true, y_start=0)))))
      annotation (Placement(transformation(extent={{0,-20},{40,20}})));

    Modelica.Blocks.Sources.Ramp loa[15](duration=86400, height=1000)
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    Modelica.Blocks.Sources.Step occ(startTime=3600*6)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource(
          "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
        computeWetBulbTemperature=false) "Weather data reader"
      annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    Modelica.Blocks.Routing.RealPassThrough TDryBul(y(
        final quantity="ThermodynamicTemperature",
        final unit="K",
        displayUnit="degC",
        min=0))
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Buildings.BoundaryConditions.WeatherData.Bus
                                       weaBus
      "Weather data bus"
      annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
    Buildings.Utilities.Psychrometrics.TWetBul_TDryBulPhi TWetBul
      annotation (Placement(transformation(extent={{-40,-88},{-20,-68}})));
  equation
    connect(weaDat.weaBus, weaBus) annotation (Line(
        points={{-80,-50},{-70,-50}},
        color={255,204,51},
        thickness=0.5));
    connect(loa.y, hVAC.loa) annotation (Line(points={{-59,10},{-36,10},{-36,6},
            {-2.8,6}},    color={0,0,127}));
    connect(TDryBul.y, hVAC.TDryBul) annotation (Line(points={{-19,-50},{-18,
            -50},{-18,-4},{-2.8,-4}}, color={0,0,127}));
    connect(occ.y, hVAC.occ) annotation (Line(points={{-59,50},{-36,50},{-36,16},
            {-2.8,16}},    color={0,0,127}));
    connect(weaBus.TDryBul, TWetBul.TDryBul) annotation (Line(
        points={{-70,-50},{-70,-70},{-41,-70}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(weaBus.relHum, TWetBul.phi) annotation (Line(
        points={{-70,-50},{-70,-78},{-41,-78}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(weaBus.pAtm, TWetBul.p) annotation (Line(
        points={{-70,-50},{-70,-86},{-41,-86}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(TWetBul.TWetBul, hVAC.TWetBul) annotation (Line(points={{-19,-78},{
            -10,-78},{-10,-12},{-6,-12},{-6,-13.7},{-2.7,-13.7}},       color={
            0,0,127}));
    connect(weaBus.TDryBul, TDryBul.u) annotation (Line(
        points={{-70,-50},{-42,-50}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)),
      experiment(StopTime=86400));
  end HVAC;
end Examples;
