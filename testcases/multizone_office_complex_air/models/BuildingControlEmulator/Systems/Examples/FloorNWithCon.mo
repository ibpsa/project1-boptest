within BuildingControlEmulator.Systems.Examples;
model FloorNWithCon
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air "Medium model for air";
  package MediumCooWat = Buildings.Media.Water "Medium model for chilled water";
  package MediumHeaWat = Buildings.Media.Water "Medium model for heating water";

  parameter Integer n =  3  "Number of floors";

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
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[n,:]={{(mAirFloRat1 +
      mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*0.5,(
      mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*
      0.7,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)
      /1.2,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)
      /1.2*2} for i in linspace(
      1,
      n,
      n)} "Volume flow rate curve";
  parameter Real HydEff[n,:] = {{0.93*0.65,0.93*0.7,0.93,0.93*0.6} for i in linspace(1,n,n)} "Hydraulic efficiency";
  parameter Real MotEff[n,:] = {{0.6045*0.65,0.6045*0.7,0.6045,0.6045*0.6} for i in linspace(1,n,n)} "Motor efficiency";

  parameter Modelica.Units.SI.Pressure SupPreCur[n,:]={{1400,1000,700,700*0.5}
      for i in linspace(
      1,
      n,
      n)} "Pressure curve";
  parameter Modelica.Units.SI.Pressure RetPreCur[n,:]={{600,400,200,100} for i in
          linspace(
      1,
      n,
      n)} "Pressure curve";

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

  parameter Modelica.Units.SI.Pressure PreWatDroBra1=79712*0.6
    "Pressure drop 1 across the pipe branch 1";

  parameter Modelica.Units.SI.Pressure PreWatDroBra2=79712*0.4
    "Pressure drop 1 across the pipe branch 2";

  parameter Modelica.Units.SI.Pressure PreWatDroBra3=79712*0.2
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
    "Heat exchanger effectiveness of vav 1";

  parameter Modelica.Units.SI.Pressure PreDroAir4=124
    "Pressure drop in the air side of vav 4";
  parameter Modelica.Units.SI.Pressure PreDroWat4=79712
    "Pressure drop in the water side of vav 4";
  parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";


  parameter Modelica.Units.SI.Pressure PreDroAir5=124
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat5=79712
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";

  BuildingControlEmulator.Systems.Floor floor[n](
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
    eps5=eps5,
    duaFanAirHanUnit(Fan_k=0.01),
    fivZonVAV(vol(V=100)))
    annotation (Placement(transformation(extent={{-26,-20},{24,22}})));
  Buildings.Fluid.Sources.Boundary_pT sou[n](
    nPorts=3,
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 100000)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Buildings.Fluid.Sources.Boundary_pT souCooWat[n](
    redeclare package Medium = MediumCooWat,
    nPorts=1,
    p(displayUnit="Pa") = 100000 + PreDroCooWat,
    T=279.15) annotation (Placement(transformation(extent={{-22,60},{-42,80}})));
  Buildings.Fluid.Sources.Boundary_pT sinCooWat[n](
    nPorts=1,
    redeclare package Medium = MediumCooWat,
    p(displayUnit="Pa") = 100000,
    T=279.15) annotation (Placement(transformation(extent={{-80,62},{-60,82}})));
  Buildings.Fluid.Sources.Boundary_pT souHeaWat[n](
    nPorts=1,
    p(displayUnit="Pa") = 100000 + PreWatDroMai1 + PreWatDroMai2 +
      PreWatDroMai3 + PreWatDroMai4 + PreWatDroBra5 + PreDroWat5,
    redeclare package Medium = MediumHeaWat,
    T=353.15) annotation (Placement(transformation(extent={{0,60},{20,80}})));

  Buildings.Fluid.Sources.Boundary_pT sinHeaWat[n](
    nPorts=1,
    p(displayUnit="Pa") = 100000,
    redeclare package Medium = MediumHeaWat)
    annotation (Placement(transformation(extent={{60,60},{40,80}})));
  Modelica.Blocks.Sources.Ramp loa[5*n](
    duration=86400,
    height={mAirFloRat1*1000*(22 - 12.88),mAirFloRat2*1000*(22 - 12.88),
        mAirFloRat3*1000*(22 - 12.88),mAirFloRat4*1000*(22 - 12.88),mAirFloRat5*
        1000*(22 - 12.88),mAirFloRat1*1000*(22 - 12.88),mAirFloRat2*1000*(22 - 12.88),
        mAirFloRat3*1000*(22 - 12.88),mAirFloRat4*1000*(22 - 12.88),mAirFloRat5*
        1000*(22 - 12.88),mAirFloRat1*1000*(22 - 12.88),mAirFloRat2*1000*(22 - 12.88),
        mAirFloRat3*1000*(22 - 12.88),mAirFloRat4*1000*(22 - 12.88),mAirFloRat5*
        1000*(22 - 12.88)},
    offset={mAirFloRat1*1000*0.5*(20 - 25),mAirFloRat2*1000*0.5*(20 - 25),
        mAirFloRat3*1000*0.5*(20 - 25),mAirFloRat4*1000*0.5*(20 - 25),
        mAirFloRat5*1000*0.5*(20 - 25),mAirFloRat1*1000*0.5*(20 - 25),mAirFloRat2*1000*0.5*(20 - 25),
        mAirFloRat3*1000*0.5*(20 - 25),mAirFloRat4*1000*0.5*(20 - 25),
        mAirFloRat5*1000*0.5*(20 - 25),mAirFloRat1*1000*0.5*(20 - 25),mAirFloRat2*1000*0.5*(20 - 25),
        mAirFloRat3*1000*0.5*(20 - 25),mAirFloRat4*1000*0.5*(20 - 25),
        mAirFloRat5*1000*0.5*(20 - 25)})
    annotation (Placement(transformation(extent={{-4,-60},{16,-40}})));
  Modelica.Blocks.Sources.Constant const1[n](k=273.15 + 12.88)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant const2[n](k=400)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression[n](y=true)
    annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  BuildingControlEmulator.Devices.AirSide.Terminal.Controls.ZonCon
                                                           zonCon[15](
    MinFlowRateSetPoi=0.3,
    HeatingFlowRateSetPoi=0.5,
    heaCon(Ti=60, k=0.001),
    cooCon(k=0.01))
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Constant TCooSetPoi[15](k=273.15 + 24)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Blocks.Sources.Constant THeaSetPoi[15](k=273.15 + 20)
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=false) "Weather data reader"
    annotation (Placement(transformation(extent={{-2,-90},{18,-70}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{18,-90},{38,-70}})));
  Modelica.Blocks.Routing.RealPassThrough TOut(y(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC",
      min=0))
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Modelica.Blocks.Routing.Replicator rep(nout=n)
    annotation (Placement(transformation(extent={{72,-90},{92,-70}})));
equation
  for i in 1:n loop
   connect(floor[i].port_Exh_Air, sou[i].ports[1]);
   connect(floor[i].port_Fre_Air, sou[i].ports[2]);
   connect(sinCooWat[i].ports[1], floor[i].port_b_CooWat);
   connect(floor[i].port_a_CooWat, souCooWat[i].ports[1]);
   connect(floor[i].port_a_HeaWat, souHeaWat[i].ports[1]);
   connect(floor[i].port_b_HeaWat, sinHeaWat[i].ports[1]);
   connect(const2[i].y, floor[i].PreSetPoi);
    connect(const1[i].y, floor[i].DisTemPSetPoi);
   connect(booleanExpression[i].y, floor[i].OnFan);
   connect(floor[i].OnZon, booleanExpression[i].y);
   for j in 1:5 loop
    connect(loa[(i-1)*5+j].y, floor[i].Q_flow[j]);
      connect(floor[i].TZon[j], zonCon[(i - 1)*5 + j].T);
    connect(zonCon[(i-1)*5+j].yAirFlowSetPoi, floor[i].AirFlowRatSetPoi[j]);
    connect(zonCon[(i-1)*5+j].yValPos, floor[i].yVal[j]);
    connect(TCooSetPoi[(i-1)*5+j].y, floor[i].ZonCooTempSetPoi[j]);
    connect(THeaSetPoi[(i-1)*5+j].y, floor[i].ZonHeaTempSetPoi[j]);
   end for;
  end for;
  connect(THeaSetPoi.y, zonCon.THeaSetPoi);
  connect(TCooSetPoi.y, zonCon.TCooSetPoi);


  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{18,-80},{28,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(TOut.u, weaBus.TDryBul)
    annotation (Line(points={{38,-80},{28,-80}}, color={0,0,127}));
  connect(TOut.y, rep.u)
    annotation (Line(points={{61,-80},{70,-80}}, color={0,0,127}));
  connect(rep.y, floor.TOut) annotation (Line(points={{93,-80},{96,-80},{96,-52},
          {30,-52},{30,-30},{-1,-30},{-1,-22.94}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=86400));
end FloorNWithCon;
