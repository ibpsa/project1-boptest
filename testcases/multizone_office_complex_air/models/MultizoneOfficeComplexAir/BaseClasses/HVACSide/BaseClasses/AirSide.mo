within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses;
model AirSide "Air side system"
  Modelica.Blocks.Interfaces.RealInput loa[15] "Load from external calculator"
    annotation (Placement(transformation(extent={{-128,46},{-100,74}}),
        iconTransformation(extent={{-128,16},{-100,44}})));
  Modelica.Blocks.Interfaces.RealOutput TZon[15] "Zone air temperature"
   annotation (Placement(transformation(extent={{200,-10},{220,10}}),
                        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput TDryBul "Zone air dry bulb temperature"
   annotation (Placement(transformation(extent={{-128,-14},{-100,14}}),
                              iconTransformation(extent={{-128,-34},{-100,-6}})));

  final parameter Real alpha =  0.8  "Sizing factor";
  package MediumAir = Buildings.Media.Air "Medium model for air";
  package MediumCHW = Buildings.Media.Water "Medium model for chilled water";
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
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[n,:]={{(mAirFloRat1[1]
       + mAirFloRat2[1] + mAirFloRat3[1] + mAirFloRat4[1] + mAirFloRat5[1])/1.2
      *0.5,(mAirFloRat1[1] + mAirFloRat2[1] + mAirFloRat3[1] + mAirFloRat4[1]
       + mAirFloRat5[1])/1.2*0.7,(mAirFloRat1[1] + mAirFloRat2[1] + mAirFloRat3
      [1] + mAirFloRat4[1] + mAirFloRat5[1])/1.2,(mAirFloRat1[1] + mAirFloRat2[
      1] + mAirFloRat3[1] + mAirFloRat4[1] + mAirFloRat5[1])/1.2*2},{(
      mAirFloRat1[2] + mAirFloRat2[2] + mAirFloRat3[2] + mAirFloRat4[2] +
      mAirFloRat5[2])/1.2*0.5,(mAirFloRat1[2] + mAirFloRat2[2] + mAirFloRat3[2]
       + mAirFloRat4[2] + mAirFloRat5[2])/1.2*0.7,(mAirFloRat1[2] + mAirFloRat2
      [2] + mAirFloRat3[2] + mAirFloRat4[2] + mAirFloRat5[2])/1.2,(mAirFloRat1[
      2] + mAirFloRat2[2] + mAirFloRat3[2] + mAirFloRat4[2] + mAirFloRat5[2])/
      1.2*2},{(mAirFloRat1[3] + mAirFloRat2[3] + mAirFloRat3[3] + mAirFloRat4[3]
       + mAirFloRat5[3])/1.2*0.5,(mAirFloRat1[3] + mAirFloRat2[3] + mAirFloRat3
      [3] + mAirFloRat4[3] + mAirFloRat5[3])/1.2*0.7,(mAirFloRat1[3] +
      mAirFloRat2[3] + mAirFloRat3[3] + mAirFloRat4[3] + mAirFloRat5[3])/1.2,(
      mAirFloRat1[3] + mAirFloRat2[3] + mAirFloRat3[3] + mAirFloRat4[3] +
      mAirFloRat5[3])/1.2*2}} "Volume flow rate curve";
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
  parameter Modelica.Units.SI.Pressure PreWatDroMai2=79712*0.1
    "Pressure drop 2 across the main pipe";
  parameter Modelica.Units.SI.Pressure PreWatDroMai3=79712*0.1
    "Pressure drop 3 across the main pipe";
  parameter Modelica.Units.SI.Pressure PreWatDroMai4=79712*0.1
    "Pressure drop 4 across the main pipe";
  parameter Modelica.Units.SI.Pressure PreWatDroBra1=79712*0.3
    "Pressure drop 1 across the pipe branch 1";
  parameter Modelica.Units.SI.Pressure PreWatDroBra2=79712*0.2
    "Pressure drop 1 across the pipe branch 2";
  parameter Modelica.Units.SI.Pressure PreWatDroBra3=79712*0.1
    "Pressure drop 1 across the pipe branch 3";
  parameter Modelica.Units.SI.Pressure PreWatDroBra4=0
    "Pressure drop 1 across the pipe branch 4";
  parameter Modelica.Units.SI.Pressure PreWatDroBra5=0
    "Pressure drop 1 across the pipe branch 5";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat1[n]={10.92*1.2*alpha,
      10.92*1.2*10*alpha,10.92*1.2*alpha}*3 "mass flow rate for vav 1";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat2[n]={2.25*1.2*alpha,2.25*
      1.2*10*alpha,2.25*1.2*alpha}*3 "mass flow rate for vav 2";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat3[n]={1.49*1.2*alpha,1.49*
      1.2*10*alpha,1.49*1.2*alpha}*3 "mass flow rate for vav 3";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat4[n]={1.9*1.2*alpha,1.9*
      1.2*10*alpha,1.9*1.2*alpha}*3 "mass flow rate for vav 4";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat5[n]={1.73*1.2*alpha,1.73*
      1.2*10*alpha,1.73*1.2*alpha}*3 "mass flow rate for vav 5";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat1[n]={mAirFloRat1[1]*0.3*(
      35 - 12.88)/4.2/20,mAirFloRat1[2]*0.3*(35 - 12.88)/4.2/20,mAirFloRat1[3]*
      0.3*(35 - 12.88)/4.2/20} "mass flow rate for vav 1";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat2[n]={mAirFloRat2[1]*0.3*(
      35 - 12.88)/4.2/20,mAirFloRat2[2]*0.3*(35 - 12.88)/4.2/20,mAirFloRat2[3]*
      0.3*(35 - 12.88)/4.2/20} "mass flow rate for vav 2";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat3[n]={mAirFloRat3[1]*0.3*(
      35 - 12.88)/4.2/20,mAirFloRat3[2]*0.3*(35 - 12.88)/4.2/20,mAirFloRat3[3]*
      0.3*(35 - 12.88)/4.2/20} "mass flow rate for vav 3";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat4[n]={mAirFloRat4[1]*0.3*(
      35 - 12.88)/4.2/20,mAirFloRat4[2]*0.3*(35 - 12.88)/4.2/20,mAirFloRat4[3]*
      0.3*(35 - 12.88)/4.2/20} "mass flow rate for vav 4";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat5[n]={mAirFloRat5[1]*0.3*(
      35 - 12.88)/4.2/20,mAirFloRat5[2]*0.3*(35 - 12.88)/4.2/20,mAirFloRat5[3]*
      0.3*(35 - 12.88)/4.2/20} "mass flow rate for vav 5";
  parameter Modelica.Units.SI.Pressure PreDroAir1=200
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat1=79712/2
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroAir2=124
    "Pressure drop in the air side of vav 2";
  parameter Modelica.Units.SI.Pressure PreDroWat2=79712/2
    "Pressure drop in the water side of vav 2";
  parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
    "Heat exchanger effectiveness of vav 2";
  parameter Modelica.Units.SI.Pressure PreDroAir3=124
    "Pressure drop in the air side of vav 3";
  parameter Modelica.Units.SI.Pressure PreDroWat3=79712/2
    "Pressure drop in the water side of vav 3";
  parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroAir4=124
    "Pressure drop in the air side of vav 4";
  parameter Modelica.Units.SI.Pressure PreDroWat4=79712/2
    "Pressure drop in the water side of vav 4";
  parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroAir5=124
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat5=79712/2
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";
  MultizoneOfficeComplexAir.BaseClasses.BuildingControlEmulator.Systems.Floor
    floor1(
    duaFanAirHanUni(
      Coi_k=0.1,
      MixingBox_k=0.1,
      MixingBox_Ti=600,
      Fan_k=0.001,
      Fan_Ti=600,
      booleanExpression(y=if floor1.duaFanAirHanUni.TOut < 283.15 then floor1.duaFanAirHanUni.On
             else true)),
    fivZonVAV(vol(V=200000)),
    redeclare package MediumAir = MediumAir,
    redeclare package MediumHeaWat = MediumHeaWat,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
    PreDroCooWat=PreDroCooWat,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    waitTime=3600,
    HydEff=HydEff[1, :],
    MotEff=MotEff[1, :],
    VolFloCur=VolFloCur[1, :],
    SupPreCur=SupPreCur[1, :],
    RetPreCur=RetPreCur[1, :],
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
    mAirFloRat1=mAirFloRat1[1],
    mAirFloRat2=mAirFloRat2[1],
    mAirFloRat3=mAirFloRat3[1],
    mAirFloRat4=mAirFloRat4[1],
    mAirFloRat5=mAirFloRat5[1],
    mWatFloRat1=mWatFloRat1[1],
    mWatFloRat2=mWatFloRat2[1],
    mWatFloRat3=mWatFloRat3[1],
    mWatFloRat4=mWatFloRat4[1],
    mWatFloRat5=mWatFloRat5[1],
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
    redeclare package MediumCooWat = MediumCHW)
    annotation (Placement(transformation(extent={{114,20},{164,62}})));

  MultizoneOfficeComplexAir.BaseClasses.BuildingControlEmulator.Systems.Floor
    floor2(
    duaFanAirHanUni(
      Coi_k=0.1,
      MixingBox_k=0.1,
      MixingBox_Ti=600,
      Fan_k=0.001,
      Fan_Ti=600,
      booleanExpression(y=if floor2.duaFanAirHanUni.TOut < 283.15 then floor2.duaFanAirHanUni.On
             else true)),
    fivZonVAV(vol(V=200000)),
    redeclare package MediumAir = MediumAir,
    redeclare package MediumHeaWat = MediumHeaWat,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
    PreDroCooWat=PreDroCooWat,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    waitTime=3600,
    HydEff=HydEff[2, :],
    MotEff=MotEff[2, :],
    VolFloCur=VolFloCur[2, :],
    SupPreCur=SupPreCur[2, :],
    RetPreCur=RetPreCur[2, :],
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
    mAirFloRat1=mAirFloRat1[2],
    mAirFloRat2=mAirFloRat2[2],
    mAirFloRat3=mAirFloRat3[2],
    mAirFloRat4=mAirFloRat4[2],
    mAirFloRat5=mAirFloRat5[2],
    mWatFloRat1=mWatFloRat1[2],
    mWatFloRat2=mWatFloRat2[2],
    mWatFloRat3=mWatFloRat3[2],
    mWatFloRat4=mWatFloRat4[2],
    mWatFloRat5=mWatFloRat5[2],
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
    redeclare package MediumCooWat = MediumCHW)
    annotation (Placement(transformation(extent={{114,20},{164,62}})));

  MultizoneOfficeComplexAir.BaseClasses.BuildingControlEmulator.Systems.Floor
    floor3(
    duaFanAirHanUni(
      Coi_k=0.1,
      MixingBox_k=0.1,
      MixingBox_Ti=600,
      Fan_k=0.001,
      Fan_Ti=600,
      booleanExpression(y=if floor3.duaFanAirHanUni.TOut < 283.15 then floor3.duaFanAirHanUni.On
             else true)),
    fivZonVAV(vol(V=200000)),
    redeclare package MediumAir = MediumAir,
    redeclare package MediumHeaWat = MediumHeaWat,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
    PreDroCooWat=PreDroCooWat,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    waitTime=3600,
    HydEff=HydEff[3, :],
    MotEff=MotEff[3, :],
    VolFloCur=VolFloCur[3, :],
    SupPreCur=SupPreCur[3, :],
    RetPreCur=RetPreCur[3, :],
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
    mAirFloRat1=mAirFloRat1[3],
    mAirFloRat2=mAirFloRat2[3],
    mAirFloRat3=mAirFloRat3[3],
    mAirFloRat4=mAirFloRat4[3],
    mAirFloRat5=mAirFloRat5[3],
    mWatFloRat1=mWatFloRat1[3],
    mWatFloRat2=mWatFloRat2[3],
    mWatFloRat3=mWatFloRat3[3],
    mWatFloRat4=mWatFloRat4[3],
    mWatFloRat5=mWatFloRat5[3],
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
    redeclare package MediumCooWat = MediumCHW) "Top Floor"
    annotation (Placement(transformation(extent={{114,20},{164,62}})));

  Buildings.Fluid.Sources.Boundary_pT   sou[n](
    nPorts=3,
    redeclare package Medium = MediumAir,
    each p(displayUnit="Pa") = 100000,
    use_T_in=true) "Source"
    annotation (Placement(transformation(extent={{40,30},{60,50}})));

  Modelica.Blocks.Sources.Constant TSupAirSet[n](k=273.15 + 12.88)
    "AHU supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-70,46},{-50,66}})));
  Modelica.Blocks.Sources.Constant dpStaSet[n](k=400)
    "AHU static ressure setpoint"
    annotation (Placement(transformation(extent={{-70,16},{-50,36}})));
  Modelica.Blocks.Sources.BooleanExpression onZon[n](each y=true)
    "Zone VAV terminal on signal"
    annotation (Placement(transformation(extent={{40,62},{60,82}})));

  MultizoneOfficeComplexAir.BaseClasses.BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses.SetPoi TZonAirSet[15](
    n=2,
    setpoint_on={{273.15 + 24,273.15 + 20} for i in linspace(
        1,
        15,
        15)},
    setpoint_off={{273.15 + 26.7,273.15 + 15.6} for i in linspace(1, 15, 15)})
    "Zone air temperature setpoint controllers based on the occupancy signal"
    annotation (Placement(transformation(extent={{-2,90},{18,110}})));
  Modelica.Blocks.Routing.BooleanReplicator booRep(nout=15)
    "Replicate the Occ signal to 15 zones"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  Modelica.Blocks.Interfaces.RealInput occ "Occupancy signal"
    annotation (Placement(transformation(extent={{-128,86},{-100,114}}),
        iconTransformation(extent={{-128,66},{-100,94}})));
  Modelica.Blocks.Math.RealToBoolean reaToBooOcc
    "Convert real signal to boolean signal for occupancy signal"
    annotation (Placement(transformation(extent={{-60,90},{-40,110}})));
  Modelica.Blocks.Continuous.FirstOrder firOrd(T=1)
    "First order to smooth the occupancy signal"
    annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
  Modelica.Blocks.Math.Gain loaMulMidFlo[5](k=10) "Load multiplier"
    annotation (Placement(transformation(extent={{-94,54},{-82,66}})));
equation

   connect(sou[1].T_in, TDryBul)
   annotation (Line(points={{38,44},{-38,44},{-38,1.77636e-15},{-114,
          1.77636e-15}},  color={0,0,127}));
   connect(floor1.port_Exh_Air, sou[1].ports[1]) annotation (Line(
      points={{113.375,30.5},{90,30.5},{90,42.6667},{60,42.6667}},
      color={0,140,72},
      thickness=0.5));
   connect(floor1.port_Fre_Air, sou[1].ports[2]) annotation (Line(
      points={{114,44.5},{90,44.5},{90,40},{60,40}},
      color={0,140,72},
      thickness=0.5));
  connect(dpStaSet[1].y, floor1.pSet) annotation (Line(points={{-49,26},{102,26},
          {102,39.25},{112.438,39.25}}, color={0,0,127}));
  connect(TSupAirSet[1].y, floor1.disTSet) annotation (Line(points={{-49,56},{
          102,56},{102,48},{112.438,48}}, color={0,0,127}));
  connect(reaToBooOcc.y, floor1.OnFan) annotation (Line(points={{-39,100},{-36,
          100},{-36,86},{106,86},{106,28.75},{112.438,28.75}},
                                                      color={255,0,255}));
  connect(floor1.OnZon, onZon[1].y) annotation (Line(points={{112.438,21.75},{
          108,21.75},{108,22},{104,22},{104,72},{61,72}},
                                                      color={255,0,255}));
   for j in 1:5 loop
    connect(loa[(1 - 1)*5 + j], floor1.Q_flow[j]);
    connect(floor1.TZon[j], TZon[(1-1)*5+j]);
    connect(TZonAirSet[(1 - 1)*5 + j].SetPoi[1], floor1.zonCooTSet[j])
      annotation (Line(points={{20,99},{96,99},{96,55},{112.438,55}}, color={0,
            0,127}));
    connect(TZonAirSet[(1 - 1)*5 + j].SetPoi[2], floor1.zonHeaTSet[j])
      annotation (Line(points={{20,101},{96,101},{96,51.5},{112.438,51.5}},
          color={0,0,127}));
   end for;

   for i in 1:5 loop
    connect(loa[(2 - 1)*5 + i], loaMulMidFlo[i].u)
      annotation (Line(points={{-114,60},{-95.2,60}}, color={0,0,127}));
   end for;
   connect(sou[2].T_in, TDryBul);
   connect(floor2.port_Exh_Air, sou[2].ports[1]);
   connect(floor2.port_Fre_Air, sou[2].ports[2]);
  connect(dpStaSet[2].y, floor2.pSet);
  connect(TSupAirSet[2].y, floor2.disTSet);
  connect(reaToBooOcc.y, floor2.OnFan);
  connect(floor2.OnZon, onZon[2].y);
   for j in 1:5 loop
    connect(loaMulMidFlo[j].y, floor2.Q_flow[j]) annotation (Line(points={{-81.4,
            60},{-78,60},{-78,-4},{142,-4},{142,18.25},{141.5,18.25}},
                                                                   color={0,0,127}));
    connect(floor2.TZon[j], TZon[(2-1)*5+j]);
    connect(TZonAirSet[(2 - 1)*5 + j].SetPoi[1], floor2.zonCooTSet[j]);
    connect(TZonAirSet[(2 - 1)*5 + j].SetPoi[2], floor2.zonHeaTSet[j]);
   end for;

   connect(sou[3].T_in, TDryBul);
   connect(floor3.port_Exh_Air, sou[3].ports[1]);
   connect(floor3.port_Fre_Air, sou[3].ports[2]);
  connect(dpStaSet[3].y, floor3.pSet);
  connect(TSupAirSet[3].y, floor3.disTSet);
  connect(reaToBooOcc.y, floor3.OnFan);
  connect(floor3.OnZon, onZon[3].y);
   for j in 1:5 loop
    connect(loa[(3 - 1)*5 + j], floor3.Q_flow[j]);
    connect(floor3.TZon[j], TZon[(3-1)*5+j]);
    connect(TZonAirSet[(3 - 1)*5 + j].SetPoi[1], floor3.zonCooTSet[j]);
    connect(TZonAirSet[(3 - 1)*5 + j].SetPoi[2], floor3.zonHeaTSet[j]);
   end for;
  connect(booRep.y, TZonAirSet.Occ)
    annotation (Line(points={{-9,100},{-4,100}}, color={255,0,255}));
  connect(floor1.TOut, TDryBul) annotation (Line(points={{136.813,18.25},{
          136.813,0},{-84,0},{-84,1.77636e-15},{-114,1.77636e-15}},
                                color={0,0,127}));
  connect(floor2.TOut, TDryBul);
  connect(floor3.TOut, TDryBul);
  connect(firOrd.y, reaToBooOcc.u)
    annotation (Line(points={{-69,100},{-62,100}}, color={0,0,127}));
  connect(firOrd.u,occ)
    annotation (Line(points={{-92,100},{-114,100}}, color={0,0,127}));

  connect(reaToBooOcc.y, booRep.u)
    annotation (Line(points={{-39,100},{-32,100}}, color={255,0,255}));


  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                        graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-20},{200,140}}), graphics={
          Text(
          extent={{130,108},{180,94}},
          lineColor={0,0,0},
          fontSize=10,
          textStyle={TextStyle.Bold},
          textString="Airside")}),
    experiment(
      StartTime=14515200,
      StopTime=14860800,
      __Dymola_NumberOfIntervals=1440,
      __Dymola_Algorithm="Cvode"));
end AirSide;
