within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses;
package Examples
  extends Modelica.Icons.ExamplesPackage;
  model AirsideFloor
    extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Buildings library air media package with CO2";
    package MediumCooWat = Buildings.Media.Water "Medium model for chilled water";
    package MediumHeaWat = Buildings.Media.Water "Medium model for heating water";

    parameter Modelica.Units.SI.Pressure PreDroCoiAir=50
      "Pressure drop in the air side";
    parameter Modelica.Units.SI.Pressure PreDroMixingBoxAir=50
      "Pressure drop in the air side";
    parameter Modelica.Units.SI.Pressure PreDroCooWat=79712
      "Pressure drop in the water side";

    parameter Modelica.Units.SI.Temperature TemEcoHig=273.15 + 15.58
      "the highest temeprature when the economizer is on";
    parameter Modelica.Units.SI.Temperature TemEcoLow=273.15 + 0
      "the lowest temeprature when the economizer is on";
    parameter Real MixingBoxDamMin = 0.3 "the minimum damper postion";

    parameter Modelica.Units.SI.Time waitTime(min=0) = 1800
      "Wait time before transition fires";
    parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]={(mAirFloRat1 +
        mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*0.5,(
        mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*
        0.7,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)
        /1.2,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)
        /1.2*2} "Volume flow rate curve";
    parameter Real HydEff[:] = {0.93*0.65,0.93*0.7,0.93,0.93*0.6} "Hydraulic efficiency";
    parameter Real MotEff[:] = {0.6045*0.65,0.6045*0.7,0.6045,0.6045*0.6} "Motor efficiency";

    parameter Modelica.Units.SI.Pressure SupPreCur[:]={1400,1000,700,700*0.5}
      "Pressure curve";
    parameter Modelica.Units.SI.Pressure RetPreCur[:]={600,400,200,100}
      "Pressure curve";

    parameter Modelica.Units.SI.Pressure PreAirDroMai1=140
      "Pressure drop 1 across the duct";

    parameter Modelica.Units.SI.Pressure PreAirDroMai2=140
      "Pressure drop 2 across the main duct";

    parameter Modelica.Units.SI.Pressure PreAirDroMai3=120
      "Pressure drop 3 across the main duct";

    parameter Modelica.Units.SI.Pressure PreAirDroMai4=152
      "Pressure drop 4 across the main duct";

    parameter Modelica.Units.SI.Pressure PreAirDroBra1=0
      "Pressure drop 1 across the duct branch 1";

    parameter Modelica.Units.SI.Pressure PreAirDroBra2=0
      "Pressure drop 1 across the duct branch 2";

    parameter Modelica.Units.SI.Pressure PreAirDroBra3=0
      "Pressure drop 1 across the duct branch 3";

    parameter Modelica.Units.SI.Pressure PreAirDroBra4=0
      "Pressure drop 1 across the duct branch 4";

    parameter Modelica.Units.SI.Pressure PreAirDroBra5=0
      "Pressure drop 1 across the duct branch 5";

    parameter Modelica.Units.SI.Pressure PreWatDroMai1=79712*0.2
      "Pressure drop 1 across the pipe";

    parameter Modelica.Units.SI.Pressure PreWatDroMai2=79712*0.2
      "Pressure drop 2 across the main pipe";

    parameter Modelica.Units.SI.Pressure PreWatDroMai3=79712*0.2
      "Pressure drop 3 across the main pipe";

    parameter Modelica.Units.SI.Pressure PreWatDroMai4=79712*0.2
      "Pressure drop 4 across the main pipe";

    parameter Modelica.Units.SI.Pressure PreWatDroBra1=0
      "Pressure drop 1 across the pipe branch 1";

    parameter Modelica.Units.SI.Pressure PreWatDroBra2=0
      "Pressure drop 1 across the pipe branch 2";

    parameter Modelica.Units.SI.Pressure PreWatDroBra3=0
      "Pressure drop 1 across the pipe branch 3";

    parameter Modelica.Units.SI.Pressure PreWatDroBra4=0
      "Pressure drop 1 across the pipe branch 4";

    parameter Modelica.Units.SI.Pressure PreWatDroBra5=0
      "Pressure drop 1 across the pipe branch 5";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat1=10.92*1.2
      "mass flow rate for vav 1";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat2=2.25*1.2
      "mass flow rate for vav 2";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat3=1.49*1.2
      "mass flow rate for vav 3";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat4=1.9*1.2
      "mass flow rate for vav 4";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat5=1.73*1.2
      "mass flow rate for vav 5";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat1=mAirFloRat1*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 1";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat2=mAirFloRat2*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 2";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat3=mAirFloRat3*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 3";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat4=mAirFloRat4*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 4";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat5=mAirFloRat5*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 5";

    parameter Modelica.Units.SI.Pressure PreDroAir1=200
      "Pressure drop in the air side of vav 1";
    parameter Modelica.Units.SI.Pressure PreDroWat1=79712
      "Pressure drop in the water side of vav 1";
    parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
      "Heat exchanger effectiveness of vav 1";

    parameter Modelica.Units.SI.Pressure PreDroAir2=124
      "Pressure drop in the air side of vav 2";
    parameter Modelica.Units.SI.Pressure PreDroWat2=79712
      "Pressure drop in the water side of vav 2";
    parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
      "Heat exchanger effectiveness of vav 2";

    parameter Modelica.Units.SI.Pressure PreDroAir3=124
      "Pressure drop in the air side of vav 3";
    parameter Modelica.Units.SI.Pressure PreDroWat3=79712
      "Pressure drop in the water side of vav 3";
    parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
      "Heat exchanger effectiveness of vav 3";

    parameter Modelica.Units.SI.Pressure PreDroAir4=124
      "Pressure drop in the air side of vav 4";
    parameter Modelica.Units.SI.Pressure PreDroWat4=79712
      "Pressure drop in the water side of vav 4";
    parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
      "Heat exchanger effectiveness of vav 4";

    parameter Modelica.Units.SI.Pressure PreDroAir5=124
      "Pressure drop in the air side of vav 1";
    parameter Modelica.Units.SI.Pressure PreDroWat5=79712
      "Pressure drop in the water side of vav 1";
    parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
      "Heat exchanger effectiveness of vav 5";

    MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.AirsideFloor
                                          airsideFloor(
      redeclare package MediumAir = MediumAir,
      redeclare package MediumHeaWat = MediumHeaWat,
      redeclare package MediumCooWat = MediumCooWat,
      PreDroCoiAir=PreDroCoiAir,
      PreDroMixingBoxAir=PreDroMixingBoxAir,
      PreDroCooWat=PreDroCooWat,
      TemEcoHig=TemEcoHig,
      TemEcoLow=TemEcoLow,
      MixingBoxDamMin=MixingBoxDamMin,
      waitTime=waitTime,
      HydEff=HydEff,
      MotEff=MotEff,
      VolFloCur=VolFloCur,
      SupPreCur=SupPreCur,
      RetPreCur=RetPreCur,
      PreAirDroMai1=PreAirDroMai1,
      PreAirDroMai2=PreAirDroMai2,
      PreAirDroMai3=PreAirDroMai3,
      PreAirDroMai4=PreAirDroMai4,
      PreAirDroBra1=PreAirDroBra1,
      PreAirDroBra2=PreAirDroBra2,
      PreAirDroBra3=PreAirDroBra3,
      PreAirDroBra4=PreAirDroBra4,
      PreAirDroBra5=PreAirDroBra5,
      PreWatDroMai1=PreWatDroMai1,
      PreWatDroMai2=PreWatDroMai2,
      PreWatDroMai3=PreWatDroMai3,
      PreWatDroMai4=PreWatDroMai4,
      PreWatDroBra1=PreWatDroBra1,
      PreWatDroBra2=PreWatDroBra2,
      PreWatDroBra3=PreWatDroBra3,
      PreWatDroBra4=PreWatDroBra4,
      PreWatDroBra5=PreWatDroBra5,
      mAirFloRat1=mAirFloRat1,
      mAirFloRat2=mAirFloRat2,
      mAirFloRat3=mAirFloRat3,
      mAirFloRat4=mAirFloRat4,
      mAirFloRat5=mAirFloRat5,
      mWatFloRat1=mWatFloRat1,
      mWatFloRat2=mWatFloRat2,
      mWatFloRat3=mWatFloRat3,
      mWatFloRat4=mWatFloRat4,
      mWatFloRat5=mWatFloRat5,
      PreDroAir1=PreDroAir1,
      PreDroWat1=PreDroWat1,
      eps1=eps1,
      PreDroAir2=PreDroAir2,
      PreDroWat2=PreDroWat2,
      eps2=eps2,
      PreDroAir3=PreDroAir3,
      PreDroWat3=PreDroWat3,
      eps3=eps3,
      PreDroAir4=PreDroAir4,
      PreDroWat4=PreDroWat4,
      eps4=eps4,
      PreDroAir5=PreDroAir5,
      PreDroWat5=PreDroWat5,
      eps5=eps5)
      annotation (Placement(transformation(extent={{-24,-20},{26,22}})));
    Buildings.Fluid.Sources.Boundary_pT sou(
      nPorts=2,
      redeclare package Medium = MediumAir,
      p(displayUnit="Pa") = 100000)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

    Buildings.Fluid.Sources.Boundary_pT souCooWat(
      redeclare package Medium = MediumCooWat,
      nPorts=1,
      p(displayUnit="Pa") = 100000 + PreDroCooWat)
                annotation (Placement(transformation(extent={{-22,60},{-42,80}})));

    Buildings.Fluid.Sources.Boundary_pT sinCooWat(
      nPorts=1,
      redeclare package Medium = MediumCooWat,
      p(displayUnit="Pa") = 100000,
      T=279.15)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Buildings.Fluid.Sources.Boundary_pT souHeaWat(
      nPorts=1,
      p(displayUnit="Pa") = 100000 + PreWatDroMai1 + PreWatDroMai2 +
        PreWatDroMai3 + PreWatDroMai4 + PreWatDroBra5 + PreDroWat5,
      redeclare package Medium = MediumHeaWat)
      annotation (Placement(transformation(extent={{0,60},{20,80}})));

    Buildings.Fluid.Sources.Boundary_pT sinHeaWat(
      nPorts=1,
      p(displayUnit="Pa") = 100000,
      redeclare package Medium = MediumHeaWat)
      annotation (Placement(transformation(extent={{60,60},{40,80}})));

    Modelica.Blocks.Sources.Ramp loa[5](duration=86400, height=1*1000*10)
      annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
    Modelica.Blocks.Sources.Constant zonCooTset[5](k=273.15 + 24)
      annotation (Placement(transformation(extent={{-98,44},{-82,60}})));
    Modelica.Blocks.Sources.Constant disTset(k=273.15 + 12.88)
      annotation (Placement(transformation(extent={{-98,20},{-82,36}})));
    Modelica.Blocks.Sources.Constant pSet(k=400)
      annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
      annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
    Modelica.Blocks.Sources.Constant zonHeaTset[5](k=273.15 + 20)
      annotation (Placement(transformation(extent={{0,-100},{-20,-80}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource(
          "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
        computeWetBulbTemperature=false) "Weather data reader"
      annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
    Modelica.Blocks.Routing.RealPassThrough TOut(y(
        final quantity="ThermodynamicTemperature",
        final unit="K",
        displayUnit="degC",
        min=0))
      annotation (Placement(transformation(extent={{72,-80},{92,-60}})));
    Buildings.BoundaryConditions.WeatherData.Bus
                                       weaBus
      "Weather data bus"
      annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
    Modelica.Blocks.Sources.Constant nPeo[5](k=20)
      annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  equation
    connect(airsideFloor.port_Fre_Air, sou.ports[1]) annotation (Line(points={{-24,
            4.5},{-56,4.5},{-56,-1},{-80,-1}}, color={0,127,255}));
    connect(airsideFloor.port_Exh_Air, sou.ports[2]) annotation (Line(points={{-24.625,
            -9.5},{-80,-9.5},{-80,1}}, color={0,127,255}));
    connect(sinCooWat.ports[1], airsideFloor.port_b_CooWat) annotation (Line(
          points={{-60,70},{-52,70},{-52,40},{-7.4375,40},{-7.4375,-20}}, color={0,
            127,255}));
    connect(airsideFloor.port_a_CooWat, souCooWat.ports[1]) annotation (Line(
          points={{-3.6875,-20},{-3.6875,46},{-48,46},{-48,70},{-42,70}}, color={0,
            127,255}));
    connect(airsideFloor.port_a_HeaWat, souHeaWat.ports[1]) annotation (Line(
          points={{7.25,-20},{7.25,-20},{7.25,46},{24,46},{24,70},{20,70}}, color
          ={0,127,255}));
    connect(airsideFloor.port_b_HeaWat, sinHeaWat.ports[1]) annotation (Line(
          points={{9.75,-20},{9.75,36},{34,36},{34,70},{40,70}}, color={0,127,255}));
    connect(loa.y, airsideFloor.Q_flow) annotation (Line(
        points={{21,-50},{24,-50},{24,-26},{4,-26},{4,-21.75},{3.5,-21.75}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(booleanExpression.y, airsideFloor.OnZon) annotation (Line(
        points={{-79,-96},{-34,-96},{-34,-18.25},{-25.5625,-18.25}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(airsideFloor.OnFan, airsideFloor.OnZon) annotation (Line(
        points={{-25.5625,-11.25},{-34,-11.25},{-34,-18.25},{-25.5625,-18.25}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(weaDat.weaBus, weaBus) annotation (Line(
        points={{50,-70},{54,-70},{54,-70},{60,-70}},
        color={255,204,51},
        thickness=0.5));
    connect(TOut.u, weaBus.TDryBul)
      annotation (Line(points={{70,-70},{60,-70}}, color={0,0,127}));
    connect(TOut.y, airsideFloor.TOut) annotation (Line(points={{93,-70},{96,-70},
            {96,-28},{-2,-28},{-2,-21.75},{-1.1875,-21.75}}, color={0,0,127}));
    connect(pSet.y, airsideFloor.pSet) annotation (Line(points={{-79,-70},{-40,
            -70},{-40,0},{-25.5625,0},{-25.5625,-0.75}}, color={0,0,127}));
    connect(zonCooTset.y, airsideFloor.zonCooTSet) annotation (Line(points={{
            -81.2,52},{-54,52},{-54,15},{-25.5625,15}}, color={0,0,127}));
    connect(zonHeaTset.y, airsideFloor.zonHeaTSet) annotation (Line(points={{-21,
            -90},{-48,-90},{-48,12},{-25.5625,12},{-25.5625,11.5}}, color={0,0,
            127}));
    connect(disTset.y, airsideFloor.disTSet) annotation (Line(points={{-81.2,28},
            {-56,28},{-56,8},{-25.5625,8}}, color={0,0,127}));
    connect(nPeo.y, airsideFloor.nPeo) annotation (Line(points={{-79,-30},{-36,
            -30},{-36,-4.25},{-25.5625,-4.25}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)),
      experiment(StopTime=86400));
  end AirsideFloor;
end Examples;
