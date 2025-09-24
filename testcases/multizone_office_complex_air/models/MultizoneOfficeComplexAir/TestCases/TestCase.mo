within MultizoneOfficeComplexAir.TestCases;
model TestCase "Large office testcase"
  extends Modelica.Icons.Example;
  extends MultizoneOfficeComplexAir.BaseClasses.AirSide                  (
      alpha=1.25,
      sou(nPorts=3),
      floor1(
      reaZonCor(zone="bot_floor_cor"),
      reaZonSou(zone="bot_floor_sou"),
      reaZonEas(zone="bot_floor_eas"),
      reaZonWes(zone="bot_floor_wes"),
      reaZonNor(zone="bot_floor_nor"),
      oveZonCor(zone="bot_floor_cor"),
      oveZonSou(zone="bot_floor_sou"),
      oveZonEas(zone="bot_floor_eas"),
      oveZonNor(zone="bot_floor_nor"),
      oveZonWes(zone="bot_floor_wes"),
      final mWatFloRat=mFloRat1,
      duaFanAirHanUni(mixingBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=1),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(withoutMotor(varSpeFloMov(use_inputFilter=true, y_start=0))),
        cooCoi(PreDroAir(displayUnit="Pa") = 600,
        val(use_inputFilter=true, y_start=0)),
        booleanExpression(y=if (chiWatPla.TDryBul < 283.15 and
              not reaToBooOcc.y) then false else true)),
      fivZonVAV(ReheatWatNet(
          PreDroMai1=0,
          PreDroMai2=0,
          PreDroMai3=0,
          PreDroMai4=0,
          PreDroBra1=0,
          PreDroBra2=0,
          PreDroBra3=0,
          PreDroBra4=0,
          PreDroBra5=0),
          AirNetWor(
          PreDroMai1=0,
          PreDroMai2=0,
          PreDroMai3=0,
          PreDroMai4=0,
          PreDroBra1=0,
          PreDroBra2=0,
          PreDroBra3=0,
          PreDroBra4=0,
          PreDroBra5=0))),
      floor2(
      reaZonCor(zone="mid_floor_cor"),
      reaZonSou(zone="mid_floor_sou"),
      reaZonEas(zone="mid_floor_eas"),
      reaZonWes(zone="mid_floor_wes"),
      reaZonNor(zone="mid_floor_nor"),
      oveZonCor(zone="mid_floor_cor"),
      oveZonSou(zone="mid_floor_sou"),
      oveZonEas(zone="mid_floor_eas"),
      oveZonNor(zone="mid_floor_nor"),
      oveZonWes(zone="mid_floor_wes"),
      final mWatFloRat=mFloRat2,
      duaFanAirHanUni(
              mixingBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=0),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(withoutMotor(varSpeFloMov(use_inputFilter=true, y_start=0))),
        cooCoi(PreDroAir(displayUnit="Pa") = 600,
               val(use_inputFilter=true, y_start=0)),
      booleanExpression(y=if (chiWatPla.TDryBul < 283.15 and
              not reaToBooOcc.y) then false else true)),
      fivZonVAV(ReheatWatNet(
          PreDroMai1=0,
          PreDroMai2=0,
          PreDroMai3=0,
          PreDroMai4=0,
          PreDroBra1=0,
          PreDroBra2=0,
          PreDroBra3=0,
          PreDroBra4=0,
          PreDroBra5=0),
          AirNetWor(
          PreDroMai1=0,
          PreDroMai2=0,
          PreDroMai3=0,
          PreDroMai4=0,
          PreDroBra1=0,
          PreDroBra2=0,
          PreDroBra3=0,
          PreDroBra4=0,
          PreDroBra5=0))),
      floor3(
      reaZonCor(zone="top_floor_cor"),
      reaZonSou(zone="top_floor_sou"),
      reaZonEas(zone="top_floor_eas"),
      reaZonWes(zone="top_floor_wes"),
      reaZonNor(zone="top_floor_nor"),
      oveZonCor(zone="top_floor_cor"),
      oveZonSou(zone="top_floor_sou"),
      oveZonEas(zone="top_floor_eas"),
      oveZonNor(zone="top_floor_nor"),
      oveZonWes(zone="top_floor_wes"),
      final mWatFloRat=mFloRat3,
      duaFanAirHanUni(
       mixingBox(mixBox(
            valRet(riseTime=15, y_start=1),
            valExh(riseTime=15, y_start=0),
            valFre(riseTime=15, y_start=0))),
        retFan(varSpeFloMov(use_inputFilter=true, y_start=0)),
        supFan(withoutMotor(varSpeFloMov(use_inputFilter=true, y_start=0))),
        cooCoi(PreDroAir(displayUnit="Pa") = 600,
        val(use_inputFilter=true, y_start=0)),
        booleanExpression(y=if (chiWatPla.TDryBul < 283.15 and
              not reaToBooOcc.y) then false else true)),
               fivZonVAV(ReheatWatNet(
          PreDroMai1=0,
          PreDroMai2=0,
          PreDroMai3=0,
          PreDroMai4=0,
          PreDroBra1=0,
          PreDroBra2=0,
          PreDroBra3=0,
          PreDroBra4=0,
          PreDroBra5=0),
          AirNetWor(
          PreDroMai1=0,
          PreDroMai2=0,
          PreDroMai3=0,
          PreDroMai4=0,
          PreDroBra1=0,
          PreDroBra2=0,
          PreDroBra3=0,
          PreDroBra4=0,
          PreDroBra5=0))));

  parameter Modelica.Units.SI.MassFlowRate mFloRat1=-datChi[1].QEva_flow_nominal
      /4200/chiWatPla.dTCHW_nominal*chiWatPla.n/12
    "CHW mass flow rate for floor 1 (bottom floor)";
  parameter Modelica.Units.SI.MassFlowRate mFloRat2=-datChi[1].QEva_flow_nominal
      /4200/chiWatPla.dTCHW_nominal*chiWatPla.n/12*10
    "CHW mass flow rate for floor 2 (middle floor)";
  parameter Modelica.Units.SI.MassFlowRate mFloRat3=-datChi[1].QEva_flow_nominal
      /4200/chiWatPla.dTCHW_nominal*chiWatPla.n/12
    "CHW mass flow rate for floor 3 (top floor)";

  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[:]={-datChi[1].QEva_flow_nominal
      /4200/chiWatPla.dTCHW_nominal for i in linspace(
      1,
      3,
      3)} "Nominal mass flow rate at chilled water side";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]={
      mCHW_flow_nominal[1]*(datChi[1].COP_nominal + 1)/datChi[1].COP_nominal
      for i in linspace(
      1,
      3,
      3)} "Nominal mass flow rate at condenser water wide";
  parameter Modelica.Units.SI.Pressure dP_nominal=478250
    "Nominal pressure drop";

  package MediumCW = Buildings.Media.Water
    "Medium model";

  MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.WriteWaterPlant
    oveChiWatSys(TWSet(u(
        unit="K",
        min=278.15,
        max=288.15)), dpSet(u(
        unit="Pa",
        min=0,
        max=19130000)))
    annotation (Placement(transformation(extent={{-54,-36},{-34,-14}})));
  MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.WriteWaterPlant
    oveHotWatSys(TWSet(u(
        unit="K",
        min=291.15,
        max=353.15)), dpSet(u(
        unit="Pa",
        min=0,
        max=19130000)))
    annotation (Placement(transformation(extent={{66,-36},{86,-14}})));
  MultizoneOfficeComplexAir.BaseClasses.BoilerPlant boiWatPla(
    secPumCon(conPI(k=0.001)),
    redeclare package MediumHW = MediumHeaWat,
    alpha=alpha) "Boiler hot water plant"
    annotation (Placement(transformation(extent={{112,-110},{132,-90}})));

  MultizoneOfficeComplexAir.BaseClasses.Component.WaterSide.Network.PipeNetwork
    boiWatNet(
    PreDroBra2(displayUnit="Pa") = 0,
    PreDroBra3(displayUnit="Pa") = 0,
    PreDroMai1(displayUnit="Pa") = 0,
    PreDroMai2(displayUnit="Pa") = 0,
    mFloRat1=floor1.mWatFloRat1 + floor1.mWatFloRat2 + floor1.mWatFloRat3 +
        floor1.mWatFloRat4 + floor1.mWatFloRat5,
    mFloRat2=floor2.mWatFloRat1 + floor2.mWatFloRat2 + floor2.mWatFloRat3 +
        floor2.mWatFloRat4 + floor2.mWatFloRat5,
    mFloRat3=floor3.mWatFloRat1 + floor3.mWatFloRat2 + floor3.mWatFloRat3 +
        floor3.mWatFloRat4 + floor3.mWatFloRat5,
    redeclare package Medium = MediumHeaWat,
    PreDroBra1(displayUnit="Pa") = 0) "Hot water plant distribution network"
    annotation (Placement(transformation(extent={{152,-92},{172,-112}})));
  MultizoneOfficeComplexAir.BaseClasses.ChillerPlant chiWatPla(
    datChi=datChi,
    redeclare package MediumCHW = MediumCHW,
    redeclare package MediumCW = MediumCW,
    Cap={-datChi[1].QEva_flow_nominal,-datChi[2].QEva_flow_nominal,-datChi[3].QEva_flow_nominal},
    mCHW_flow_nominal=mCHW_flow_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    secPumCon(conPI(k=0.000001, Ti=240)),
    On(y=if (chiWatPla.TDryBul < 283.15 and not reaToBooOcc.y) then false else
          true),
    On1(y=if (chiWatPla.TDryBul < 283.15 and not reaToBooOcc.y) then false
           else true)) "Chilled water plant"
    annotation (Placement(transformation(extent={{-14,-108},{6,-88}})));
  MultizoneOfficeComplexAir.BaseClasses.Component.WaterSide.Network.PipeNetwork
    chiWatNet(
    redeclare package Medium = MediumCHW,
    mFloRat1=mFloRat1,
    mFloRat2=mFloRat2,
    mFloRat3=mFloRat3,
    PreDroBra1(displayUnit="Pa") = PreDroCooWat,
    PreDroBra2(displayUnit="Pa") = 0,
    PreDroBra3(displayUnit="Pa") = 0,
    PreDroMai1=PreDroCooWat,
    PreDroMai2(displayUnit="Pa") = PreDroCooWat/2)
    "Chilled water plant distribution network"
    annotation (Placement(transformation(extent={{16,-88},{36,-108}})));
  MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadChilledWater
    reaChiWatSys
    annotation (Placement(transformation(extent={{14,-48},{34,-26}})));
  MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadHotWater reaHotWatSys
    annotation (Placement(transformation(extent={{156,-48},{176,-26}})));

  Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Trane_CVHE_1442kW_6_61COP_VSD
    datChi[3](each QEva_flow_nominal=-5740000/3*alpha, each COP_nominal=5.06) "Chiller data record"
  annotation (Placement(transformation(extent={{-90,
            -118},{-70,-98}})));

  Modelica.Icons.SignalBus weaBus
    annotation (Placement(transformation(extent={{64,-128},{80,-112}}),
        iconTransformation(extent={{-8,-108},{8,-92}}),
        iconVisible=false));

  Modelica.Blocks.Sources.Constant TCWSupSet(k=273.15 + 29.44)
    "Cooling water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  Modelica.Blocks.Sources.Constant TCHWSupSet(k=273.15 + 5.56)
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Modelica.Blocks.Sources.RealExpression PHWPum(y=max(0, boiWatPla.pumSecHW.P[1])
         + max(0, boiWatPla.pumSecHW.P[2]))
    "Hot water pump power consumption"
    annotation (Placement(transformation(extent={{110,-54},{130,-34}})));
  Modelica.Blocks.Sources.RealExpression PBoi(y=boiWatPla.mulBoi.boi[1].boi.QFue_flow
         + boiWatPla.mulBoi.boi[2].boi.QFue_flow) "Boiler gas consumption"
    annotation (Placement(transformation(extent={{110,-70},{130,-50}})));

  Modelica.Blocks.Sources.Constant THWSupSet(k=273.15 + 80)
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{36,-30},{56,-10}})));

  Modelica.Blocks.Sources.RealExpression PCHWPum(y=chiWatPla.PConSpePum.y +
        chiWatPla.PVarSpePum.y) "Chilled water plant pump power consumption"
    annotation (Placement(transformation(extent={{-20,-54},{0,-34}})));

  Modelica.Blocks.Sources.RealExpression PChi(y=chiWatPla.PCh.y)
    "Multiple chiller power consumption"
    annotation (Placement(transformation(extent={{-20,-68},{0,-48}})));

  Modelica.Blocks.Sources.RealExpression PCooTow(y=chiWatPla.PCooTow.y)
    "Cooling tower power consumption"
    annotation (Placement(transformation(extent={{-20,-84},{0,-64}})));
  Modelica.Blocks.Sources.Constant dpChiWatStaSet(k=478250*0.5)
    "Secondary chilled water loop static Pressure setpoint"
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  Modelica.Blocks.Sources.Constant dpHotWatStaSet(k=478250*0.25)
    "Secondary hot water loop static Pressure setpoint"
    annotation (Placement(transformation(extent={{36,-74},{56,-54}})));

equation
  connect(chiWatNet.ports_a[1], floor1.port_b_CooWat) annotation (Line(
      points={{36,-90.4667},{36,-94},{100,-94},{100,6},{129.625,6},{129.625,20}},
      color={0,127,225},
      thickness=1));
  connect(floor1.port_a_CooWat, chiWatNet.ports_b[1]) annotation (Line(
      points={{134.312,20},{134.312,4},{102,4},{102,-101.267},{36,-101.267}},
      color={0,127,225},
      thickness=1));

  connect(chiWatNet.ports_a[2], floor2.port_b_CooWat);
  connect(floor2.port_a_CooWat, chiWatNet.ports_b[2]);
  connect(chiWatNet.ports_a[3], floor3.port_b_CooWat);
  connect(floor3.port_a_CooWat, chiWatNet.ports_b[3]);
  connect(boiWatNet.ports_a[1], floor1.port_b_HeaWat) annotation (Line(
      points={{172,-94.4667},{192,-94.4667},{192,6},{150,6},{150,20},{149.938,
          20}},
      color={238,46,47},
      thickness=1));

  connect(boiWatNet.ports_b[1], floor1.port_a_HeaWat) annotation (Line(
      points={{172,-105.267},{188,-105.267},{188,0},{146,0},{146,20},{145.25,20}},
      color={238,46,47},
      thickness=1));

  connect(boiWatNet.ports_a[2], floor2.port_b_HeaWat);
  connect(boiWatNet.ports_b[2], floor2.port_a_HeaWat);
  connect(boiWatNet.ports_a[3], floor3.port_b_HeaWat);
  connect(boiWatNet.ports_b[3], floor3.port_a_HeaWat);

  connect(chiWatPla.port_a, chiWatNet.port_b) annotation (Line(
      points={{6,-92},{16,-92}},
      color={0,127,255},
      thickness=1));
  connect(chiWatNet.port_a, chiWatPla.port_b) annotation (Line(
      points={{16,-102},{6,-102}},
      color={0,127,255},
      thickness=1));
  connect(chiWatNet.p, chiWatPla.dpMea) annotation (Line(points={{37,-98},{48,-98},
          {48,-80},{-20,-80},{-20,-90},{-15.6,-90}},         color={0,0,127}));
  connect(chiWatPla.TCWSet, TCWSupSet.y) annotation (Line(points={{-15.6,-102},{
          -24,-102},{-24,-50},{-69,-50}},
                                      color={0,0,127}));
  connect(boiWatPla.port_a, boiWatNet.port_b) annotation (Line(
      points={{132,-96},{152,-96}},
      color={238,46,47},
      thickness=1));
  connect(boiWatNet.port_a, boiWatPla.port_b) annotation (Line(
      points={{152,-106},{132,-106}},
      color={238,46,47},
      thickness=1));
  connect(boiWatNet.p,boiWatPla.dp)  annotation (Line(points={{173,-102},{178,-102},
          {178,-118},{106,-118},{106,-100},{110,-100}},     color={0,0,127}));

  connect(PCHWPum.y, reaChiWatSys.PPum_in) annotation (Line(points={{1,-44},{4,
          -44},{4,-40.3846},{12,-40.3846}},
                                  color={0,0,127}));
  connect(PChi.y, reaChiWatSys.PChi_in) annotation (Line(points={{1,-58},{6,-58},
          {6,-43.7692},{12,-43.7692}},
                                   color={0,0,127}));
  connect(PCooTow.y, reaChiWatSys.PCooTow_in) annotation (Line(points={{1,-74},{
          8,-74},{8,-46.3077},{12,-46.3077}},
                                       color={0,0,127}));
  connect(PBoi.y, reaHotWatSys.PBoi_in) annotation (Line(points={{131,-60},{146,
          -60},{146,-46.1667},{154,-46.1667}},
                                     color={0,0,127}));
  connect(PHWPum.y, reaHotWatSys.PPum_in) annotation (Line(points={{131,-44},{146,
          -44},{146,-42.5},{154,-42.5}}, color={0,0,127}));
  connect(TCHWSupSet.y, oveChiWatSys.TWSet_in)
    annotation (Line(points={{-69,-20},{-56,-20}}, color={0,0,127}));
  connect(oveChiWatSys.TW_set_out, chiWatPla.TCHWSet) annotation (Line(points={{-33,-20},
          {-26,-20},{-26,-98},{-15.6,-98}},             color={0,0,127}));
  connect(oveChiWatSys.dp_set_out, chiWatPla.dpSet) annotation (Line(points={{-33,-30},
          {-28,-30},{-28,-93.8},{-15.6,-93.8}},      color={0,0,127}));
  connect(dpChiWatStaSet.y, oveChiWatSys.dpSet_in) annotation (Line(points={{-69,-80},
          {-60,-80},{-60,-30},{-56,-30}},      color={0,0,127}));
  connect(oveHotWatSys.TW_set_out, boiWatPla.THWSet) annotation (Line(points={{87,-20},
          {96,-20},{96,-94},{110,-94}},           color={0,0,127}));
  connect(dpHotWatStaSet.y, oveHotWatSys.dpSet_in) annotation (Line(points={{57,-64},
          {60,-64},{60,-30},{64,-30}},      color={0,0,127}));
  connect(oveHotWatSys.dp_set_out, boiWatPla.dpSet) annotation (Line(points={{87,-30},
          {92,-30},{92,-106},{110,-106}},         color={0,0,127}));
  connect(THWSupSet.y, oveHotWatSys.TWSet_in)
    annotation (Line(points={{57,-20},{64,-20}}, color={0,0,127}));

  connect(weaBus.TWetBul, chiWatPla.TWetBul) annotation (Line(
      points={{72,-120},{72,-112},{-24,-112},{-24,-106},{-15.6,-106}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, floor1.weaBus) annotation (Line(
      points={{72,-120},{72,-92},{98,-92},{98,10},{139,10},{139,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, floor2.weaBus) annotation (Line(
      points={{72,-120},{72,-92},{98,-92},{98,10},{139,10},{139,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, floor3.weaBus) annotation (Line(
      points={{72,-120},{72,-92},{98,-92},{98,10},{139,10},{139,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, sou[1].T_in) annotation (Line(
      points={{72,-120},{72,-112},{-30,-112},{-30,44},{38,44}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, sou[2].T_in) annotation (Line(
      points={{72,-120},{72,-112},{-30,-112},{-30,44},{38,44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, sou[3].T_in) annotation (Line(
      points={{72,-120},{72,-112},{-30,-112},{-30,42},{4,42},{4,44},{38,44}},
      color={255,204,51},
      thickness=0.5));
  connect(chiWatNet.p, reaChiWatSys.dp_in) annotation (Line(points={{37,-98},{
          48,-98},{48,-80},{-22,-80},{-22,-31.0769},{12,-31.0769}}, color={0,0,
          127}));
  connect(boiWatNet.p, reaHotWatSys.dp_in) annotation (Line(points={{173,-102},{
          178,-102},{178,-60},{150,-60},{150,-31.5},{154,-31.5}},  color={0,0,
          127}));
  connect(chiWatPla.TCHW_ret, reaChiWatSys.TCHWRet_in) annotation (Line(points={{7,-96},
          {12,-96},{12,-62},{2,-62},{2,-33.6154},{12,-33.6154}},
        color={0,0,127}));
  connect(chiWatPla.TCHW_sup, reaChiWatSys.TCHWSup_in) annotation (Line(points={{7,-99},
          {14,-99},{14,-60},{4,-60},{4,-37},{12,-37}},           color={0,0,127}));
  connect(boiWatPla.THW_ret, reaHotWatSys.THWRet_in) annotation (Line(points={{133,
          -100},{140,-100},{140,-35.1667},{154,-35.1667}},     color={0,0,127}));
  connect(boiWatPla.THW_sup, reaHotWatSys.THWSup_in) annotation (Line(points={{133,
          -103},{142,-103},{142,-38.8333},{154,-38.8333}},     color={0,0,127}));
  connect(boiWatPla.mHW_tot, reaHotWatSys.mHWTot_in) annotation (Line(points={{133,-93},
          {138,-93},{138,-27.8333},{154,-27.8333}},          color={0,0,127}));
  connect(chiWatPla.mCHW_tot, reaChiWatSys.mCHWTot_in) annotation (Line(points={{7,-105},
          {8,-105},{8,-28},{10,-28},{10,-27.6923},{12,-27.6923}},
        color={0,0,127}));
  connect(weaBus.TDryBul, chiWatPla.TDryBul) annotation (Line(
      points={{72,-120},{72,-112},{-24,-112},{-24,-106},{-15.6,-106}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(building.weaBus, weaBus) annotation (Line(
      points={{120,110},{124,110},{124,82},{92,82},{92,-18},{98,-18},{98,-92},{72,
          -92},{72,-120}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-120},{200,120}}), graphics={Text(
          extent={{130,-4},{202,-20}},
          lineColor={0,0,0},
          fontSize=16,
          textStyle={TextStyle.Bold},
          textString="Waterside"),     Line(
          points={{-100,-2},{200,-2}},
          color={194,194,194},
          thickness=1,
          pattern=LinePattern.DashDotDot)}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This testcase represents a large office building that includes building thermal load calculation from EnergyPlus and HVAC system (i.e., air side systems, water side systems) from Modelica.</span></p>
<h4>Building Thermal Load Calculation</h4>
<p>The test case building is located in Chicago, IL and based on the DOE Reference Large Office Building Model (Constructed In or After 1980). The original model has 12 floors with a basement. For simplicity, the middle 10 floors are modeled as a single representative floor using floor multiplier (i.e., mass flow rate multiplier in Modelica), resulting in three modeled floors (ground, middle, and top), each served by a dedicated AHU. The ground floor is assumed to be adiabatic with the basement. EnergyPlus (V9.6) calculates the building&rsquo;s thermal loads and please see detailed input file wholebuilding96_spawn.idf for building geometry, constructions, occupancy and internal schedules, internal mass, etc. The infiltration is modeled in Modelica. </p>
<p>The represented floor has five zones, with four perimeter zones and one core zone. Each perimeter zone has a window-to-wall ratio of about 0.38. The height of each zone is 2.74 m and the areas are as follows: </p>
<ul>
<li>North and South: 313.42 m<sup>2</sup> </li>
<li>East and West: 201.98 m<sup>2</sup> </li>
<li>Core: 2532.32 m<sup>2</sup> </li>
</ul>
<p>The geometry of the floor is shown as the following figure: </p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/Zones.png\" width=\"400\"/> </p>
<h5>Constructions</h5>
<p>Opaque constructions: Mass walls; built-up flat roof (insulation above deck); slab-on-grade floor. </p>
<p>Windows: Window-to-wall ratio = 38.0&percnt;, equal distribution of windows. </p>
<p>Infiltration: The infiltration fraction of the Energyplus model is 0.25 during occupied hours and 1 during unoccupied hours. </p>
<h5>Occupancy and internal loads schedules</h5>
<p>The design occupancy density is 0.05 people/m<sup>2</sup>. The people internal gain is calucalted based on the activity level of 120 W. The number of occupants present in each zone at any time coincides with the internal gain schedule. The occupied time for the HVAC system is between 6:00 and 22:00 each day. The unoccupied time is outside of this period. </p>
<p>The design internal gains include lighting, plug loads, and people. The lighting load is with a radiant-convective-visible split of 70&percnt;-10&percnt;-20&percnt;. The plug load is with a radiant-convective-latent split of 50&percnt;-50&percnt;-0&percnt;. The people load is with a radiant-convective split of 30&percnt;-70&percnt;. The occupancy and the internal gains are activated according to the schedule in the figure below. </p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/Schedules.png\" width=\"350\"/> </p>
<p>The power densities of the internal gains are listed in the following table. </p>
<h5>Internal Gains</h5>
<table cellspacing=\"2\" cellpadding=\"2\" border=\"0\"><tr>
<td></td>
<td><p><br>Power Density (W/m&sup2;)</p></td>
</tr>
<tr>
<td><p>Lighting</p></td>
<td><p>16.14</p></td>
</tr>
<tr>
<td><p>Plug</p></td>
<td><p>10.76</p></td>
</tr>
</table>
<p><br><h5>Internal mass</h5></p>
<p>Building internal mass is modeled in EnergyPlus using two approaches: the InternalMass object and the Zone Air Capacitance Multiplier. Internal mass surface area values are taken from the DOE Reference Buildings, and a zone air capacitance multiplier of 8 is applied to represent typical internal-mass levels. </p>
<h5>Infiltration</h5>
<p>Air infiltration features have been incorporated into the exterior zones on all the floors. The specified infiltration rate (m_flow_infAir) is based on an air leakage rate of 1 cfm/ft&sup2; of exterior surface area, measured at a constant building pressure differential of 75 Pa. This value is then converted to a wind-driven infiltration rate at a reference wind speed of 4.47 m/s, following the methodology outlined in ASHRAE Standard 90.1-2022, Section G3.2.1.7. During the occupied hours, the infiltration schedule uses a fraction of 0.25 to approximate the reduced infiltration rate resulting from mechanical ventilation being active. This assumption aligns with the modeling rules in Appendix C of ASHRAE Standard 90.1-2022. Additionally, the infiltration rate is dynamically adjusted to account for variations in wind speed. </p>
<h5>Climate data</h5>
<p>The weather data is from TMY3 for Chicago O&apos;Hare International Airport. </p>
<h4>HVAC System</h4>
<p>The HVAC system contains the air side and water side systems for the three floors. </p>
<p><br>The air side system is a variable air volume (VAV) flow system with economizer and a cooling coil in the air handler unit. There are two fans (i.e., one supply fan, and one return fan) in the AHU. A mixing box carries out the economizer function of providing cooling and ventilation. Each VAV terminals contain a modulating damper and a hot water reheat coil. See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.Floor\">MultizoneOfficeComplexAir.BaseClasses.Floor</a> for a description of the air side systems and the thermal zones.</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/AirSide.png\" width=\"550\"/> </p>
<p><br>The water side systems include one chilled water system and one hot water system. The chilled water systems composed of three chillers, three cooling towers, a primary chilled water loop with three constant speed pumps, a secondary chilled water loop with two variable speed pumps, and a condenser water loop with three constant speed pumps. The hot water system consists of two gas boilers and two variable speed pumps. See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.ChillerPlant\">MultizoneOfficeComplexAir.BaseClasses.ChillerPlant</a> for a description of the chilled water system. See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.BoilerPlant\">MultizoneOfficeComplexAir.BaseClasses.BoilerPlant</a> for a description of the hot water system. </p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/ChilledWater.png\" width=\"550\"/> </p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/HotWater.png\" width=\"300\"/> </p>
<p>The air side system controls include the VAV air flow rate control, VAV supply air temperature control, AHU duct static pressure control, AHU supply air temperature control, and mixing box damper and economizer control.</p>
<p>The water side system controls include the chiller plant staging control, chilled water supply temperature control, secondary chilled water pump staging control, secondary chilled water loop static pressure control, cooling tower supply water temperature control, minimum condenser supply water temperature control, boiler staging control, boiler water temperature control, and boiler hot water loop static pressure control.</p>
</html>", revisions="<html>
<ul>
<li>August 17, 2023, by Xing Lu, Sen Huang: </li>
<p>First implementation.</p>
</ul>
</html>"),
    __Dymola_Commands(file="Resources/script/Testcase.mos" "Simulate and Plot"),
    experiment(
      StopTime=14860800,
      __Dymola_NumberOfIntervals=1440,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end TestCase;
