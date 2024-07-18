within MultizoneOfficeComplexAir.BaseClasses.HVACSide;
package Examples
  extends Modelica.Icons.ExamplesPackage;
  model HVAC
    extends Modelica.Icons.Example;
    //package MediumAir = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Buildings library air media package with CO2";
    //package MediumHeaWat = Buildings.Media.Water "Medium model for heating water";

    MultizoneOfficeComplexAir.BaseClasses.HVACSide.HVAC hva(
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
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.Step occ(startTime=3600*6)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource(
          "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
        computeWetBulbTemperature=true)  "Weather data reader"
      annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    Modelica.Blocks.Sources.Constant numOcc[15](k=10)
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(loa.y, hva.loa) annotation (Line(points={{-59,30},{-20,30},{-20,10},
            {-2.8,10}}, color={0,0,127}));
    connect(occ.y, hva.occ) annotation (Line(points={{-59,70},{-14,70},{-14,16},
            {-2.8,16}}, color={0,0,127}));
    connect(numOcc.y, hva.numOcc) annotation (Line(points={{-59,-10},{-20,-10},
            {-20,4},{-2.8,4}}, color={0,0,127}));
    connect(weaDat.weaBus, hva.weaBus) annotation (Line(
        points={{-80,-50},{20,-50},{20,-20}},
        color={255,204,51},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)),
      experiment(StopTime=86400));
  end HVAC;
end Examples;
