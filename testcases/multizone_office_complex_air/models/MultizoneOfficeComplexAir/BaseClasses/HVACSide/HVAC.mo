within MultizoneOfficeComplexAir.BaseClasses.HVACSide;
model HVAC "Full HVAC system that contains the air side and water side systems"
  extends MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Airside(
      alpha=1,
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
      final mWatFloRat=mFloRat1),
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
      final mWatFloRat=mFloRat2),
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
      final mWatFloRat=mFloRat3));

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

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.BoilerPlant
    boiWatPla(secPumCon(conPI(k=0.001)), redeclare package MediumHW =
        MediumHeaWat,
        alpha=alpha) "Boiler hot water plant"
    annotation (Placement(transformation(extent={{116,-110},{136,-90}})));

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Network.PipeNetwork
    boiWatNet(
    PreDroBra2(displayUnit="Pa") = 0,
    PreDroBra3(displayUnit="Pa") = 0,
    PreDroMai1(displayUnit="Pa") = (79712/4),
    PreDroMai2(displayUnit="Pa") = (79712/4/2),
    mFloRat1=boiWatPla.Cap[1]/4190/boiWatPla.dTHW_nominal*boiWatPla.n/12,
    mFloRat2=boiWatPla.Cap[1]/4190/boiWatPla.dTHW_nominal*boiWatPla.n/12*10,
    mFloRat3=boiWatPla.Cap[1]/4190/boiWatPla.dTHW_nominal*boiWatPla.n/12,
    redeclare package Medium = MediumHeaWat,
    PreDroBra1(displayUnit="Pa") = (79712/4))
    "Hot water plant distribution network"
    annotation (Placement(transformation(extent={{156,-92},{176,-112}})));
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.ChillerPlant
    chiWatPla(
    datChi=datChi,
    redeclare package MediumCHW = MediumCHW,
    redeclare package MediumCW = MediumCW,
    Cap={-datChi[1].QEva_flow_nominal,-datChi[2].QEva_flow_nominal,-datChi[3].QEva_flow_nominal},
    mCHW_flow_nominal=mCHW_flow_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    secPumCon(conPI(k=0.000001, Ti=240))) "Chilled water plant"
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Network.PipeNetwork
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
    annotation (Placement(transformation(extent={{20,-88},{40,-108}})));
  Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Trane_CVHE_1442kW_6_61COP_VSD
    datChi[3](each QEva_flow_nominal=-5500000/3*alpha)
                                               "Chiller data record"
                                               annotation (Placement(transformation(extent={{-52,
            -106},{-32,-86}})));

  Modelica.Blocks.Sources.Constant TCWSupSet(k=273.15 + 29.44)
    "Cooling water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.Constant TCHWSupSet(k=273.15 + 5.56)
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-82,-30},{-62,-10}})));
  Modelica.Blocks.Sources.RealExpression PHWPum(y=max(0, boiWatPla.pumSecHW.P[1])
         + max(0, boiWatPla.pumSecHW.P[2]))
    "Hot water pump power consumption"
    annotation (Placement(transformation(extent={{114,-54},{134,-34}})));
  Modelica.Blocks.Sources.RealExpression PBoi(y=boiWatPla.mulBoi.boi[1].boi.QFue_flow
         + boiWatPla.mulBoi.boi[2].boi.QFue_flow) "Boiler gas consumption"
    annotation (Placement(transformation(extent={{114,-70},{134,-50}})));

  Modelica.Blocks.Sources.Constant THWSupSet(k=273.15 + 80)
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));

  Modelica.Blocks.Sources.RealExpression PCHWPum(y=chiWatPla.PConSpePum.y +
        chiWatPla.PVarSpePum.y) "Chilled water plant pump power consumption"
    annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));

  Modelica.Blocks.Sources.RealExpression PChi(y=chiWatPla.PCh.y)
    "Multiple chiller power consumption"
    annotation (Placement(transformation(extent={{-16,-68},{4,-48}})));

  Modelica.Blocks.Sources.RealExpression PCooTow(y=chiWatPla.PCooTow.y)
    "Cooling tower power consumption"
    annotation (Placement(transformation(extent={{-16,-84},{4,-64}})));

  ReadOverwrite.ReadChilledWater reaChiWatSys
    annotation (Placement(transformation(extent={{18,-48},{38,-26}})));
  ReadOverwrite.ReadHotWater reaHotWatSys
    annotation (Placement(transformation(extent={{160,-48},{180,-26}})));
  Modelica.Blocks.Sources.Constant dpChiWatStaSet(k=478250*0.5)
    "Secondary chilled water loop static Pressure setpoint"
    annotation (Placement(transformation(extent={{-80,-96},{-60,-76}})));
  Modelica.Blocks.Sources.Constant dpHotWatStaSet(k=478250*0.25)
    "Secondary hot water loop static Pressure setpoint"
    annotation (Placement(transformation(extent={{40,-74},{60,-54}})));
  ReadOverwrite.WriteWaterPlant oveChiWatSys(TW_set(u(
        unit="K",
        min=278.15,
        max=288.15)), dp_set(u(
        unit="Pa",
        min=0,
        max=19130000)))
    annotation (Placement(transformation(extent={{-50,-36},{-30,-14}})));
  ReadOverwrite.WriteWaterPlant oveHotWatSys(TW_set(u(
        unit="K",
        min=291.15,
        max=353.15)), dp_set(u(
        unit="Pa",
        min=0,
        max=19130000)))
    annotation (Placement(transformation(extent={{70,-36},{90,-14}})));
  Modelica.Icons.SignalBus weaBus
    annotation (Placement(transformation(extent={{32,-128},{48,-112}}),
        iconTransformation(extent={{-8,-108},{8,-92}})));

equation
  connect(chiWatNet.ports_a[1], floor1.port_b_CooWat) annotation (Line(
      points={{40,-90.4667},{40,-94},{104,-94},{104,6},{129.625,6},{129.625,20}},
      color={0,127,225},
      thickness=1));
  connect(floor1.port_a_CooWat, chiWatNet.ports_b[1]) annotation (Line(
      points={{134.312,20},{134.312,2},{108,2},{108,-102},{72,-102},{72,
          -101.267},{40,-101.267}},
      color={0,127,225},
      thickness=1));

  connect(chiWatNet.ports_a[2], floor2.port_b_CooWat);
  connect(floor2.port_a_CooWat, chiWatNet.ports_b[2]);
  connect(chiWatNet.ports_a[3], floor3.port_b_CooWat);
  connect(floor3.port_a_CooWat, chiWatNet.ports_b[3]);
  connect(boiWatNet.ports_a[1], floor1.port_b_HeaWat) annotation (Line(
      points={{176,-94.4667},{196,-94.4667},{196,6},{154,6},{154,20},{149.938,
          20}},
      color={238,46,47},
      thickness=1));

  connect(boiWatNet.ports_b[1], floor1.port_a_HeaWat) annotation (Line(
      points={{176,-105.267},{192,-105.267},{192,0},{150,0},{150,20},{145.25,20}},
      color={238,46,47},
      thickness=1));

  connect(boiWatNet.ports_a[2], floor2.port_b_HeaWat);
  connect(boiWatNet.ports_b[2], floor2.port_a_HeaWat);
  connect(boiWatNet.ports_a[3], floor3.port_b_HeaWat);
  connect(boiWatNet.ports_b[3], floor3.port_a_HeaWat);

  connect(chiWatPla.port_a, chiWatNet.port_b) annotation (Line(
      points={{10,-92},{20,-92}},
      color={0,127,255},
      thickness=1));
  connect(chiWatNet.port_a, chiWatPla.port_b) annotation (Line(
      points={{20,-102},{10,-102}},
      color={0,127,255},
      thickness=1));
  connect(chiWatNet.p, chiWatPla.dpMea) annotation (Line(points={{41,-98},{52,
          -98},{52,-80},{-16,-80},{-16,-90},{-11.6,-90}},    color={0,0,127}));
  connect(chiWatPla.TCWSet, TCWSupSet.y) annotation (Line(points={{-11.6,-102},
          {-20,-102},{-20,-50},{-59,-50}},
                                      color={0,0,127}));
  connect(boiWatPla.port_a, boiWatNet.port_b) annotation (Line(
      points={{136,-96},{156,-96}},
      color={238,46,47},
      thickness=1));
  connect(boiWatNet.port_a, boiWatPla.port_b) annotation (Line(
      points={{156,-106},{136,-106}},
      color={238,46,47},
      thickness=1));
  connect(boiWatNet.p,boiWatPla.dp)  annotation (Line(points={{177,-102},{182,-102},
          {182,-118},{110,-118},{110,-100},{114,-100}},     color={0,0,127}));

  connect(PCHWPum.y, reaChiWatSys.PPum_in) annotation (Line(points={{5,-44},{8,
          -44},{8,-38},{16,-38}}, color={0,0,127}));
  connect(PChi.y, reaChiWatSys.PChi_in) annotation (Line(points={{5,-58},{10,
          -58},{10,-42},{16,-42}}, color={0,0,127}));
  connect(PCooTow.y, reaChiWatSys.PCooTow_in) annotation (Line(points={{5,-74},
          {12,-74},{12,-45},{16,-45}}, color={0,0,127}));
  connect(PBoi.y, reaHotWatSys.PBoi_in) annotation (Line(points={{135,-60},{150,
          -60},{150,-42},{158,-42}}, color={0,0,127}));
  connect(PHWPum.y, reaHotWatSys.PPum_in) annotation (Line(points={{135,-44},{150,
          -44},{150,-38},{158,-38}},     color={0,0,127}));
  connect(TCHWSupSet.y, oveChiWatSys.TW_set_in)
    annotation (Line(points={{-61,-20},{-52,-20}}, color={0,0,127}));
  connect(oveChiWatSys.TW_set_out, chiWatPla.TCHWSet) annotation (Line(points={{-29,-20},
          {-22,-20},{-22,-98},{-11.6,-98}},             color={0,0,127}));
  connect(oveChiWatSys.dp_set_out, chiWatPla.dpSet) annotation (Line(points={{-29,-30},
          {-24,-30},{-24,-93.8},{-11.6,-93.8}},      color={0,0,127}));
  connect(dpChiWatStaSet.y, oveChiWatSys.dp_set_in) annotation (Line(points={{
          -59,-86},{-56,-86},{-56,-30},{-52,-30}}, color={0,0,127}));
  connect(oveHotWatSys.TW_set_out, boiWatPla.THWSet) annotation (Line(points={{91,-20},
          {100,-20},{100,-94},{114,-94}},         color={0,0,127}));
  connect(dpHotWatStaSet.y, oveHotWatSys.dp_set_in) annotation (Line(points={{61,-64},
          {64,-64},{64,-30},{68,-30}},         color={0,0,127}));
  connect(oveHotWatSys.dp_set_out, boiWatPla.dpSet) annotation (Line(points={{91,-30},
          {96,-30},{96,-106},{114,-106}},         color={0,0,127}));
  connect(oveChiWatSys.dp_set_out, reaChiWatSys.dp_in)
    annotation (Line(points={{-29,-30},{16,-30}}, color={0,0,127}));
  connect(oveChiWatSys.TW_set_out, reaChiWatSys.TW_in) annotation (Line(points=
          {{-29,-20},{-22,-20},{-22,-34},{16,-34}}, color={0,0,127}));
  connect(oveHotWatSys.TW_set_out, reaHotWatSys.TW_in) annotation (Line(points=
          {{91,-20},{150,-20},{150,-34},{158,-34}}, color={0,0,127}));
  connect(oveHotWatSys.dp_set_out, reaHotWatSys.dp_in)
    annotation (Line(points={{91,-30},{158,-30}}, color={0,0,127}));
  connect(THWSupSet.y, oveHotWatSys.TW_set_in)
    annotation (Line(points={{61,-20},{68,-20}}, color={0,0,127}));

  connect(weaBus.TWetBul, chiWatPla.TWetBul) annotation (Line(
      points={{40,-120},{-18,-120},{-18,-106},{-11.6,-106}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, floor1.weaBus) annotation (Line(
      points={{40,-120},{139,-120},{139,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, floor2.weaBus) annotation (Line(
      points={{40,-120},{139,-120},{139,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, floor3.weaBus) annotation (Line(
      points={{40,-120},{139,-120},{139,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, sou[1].T_in) annotation (Line(
      points={{40,-120},{12,-120},{12,44},{38,44}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, sou[2].T_in) annotation (Line(
      points={{40,-120},{12,-120},{12,44},{38,44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, sou[3].T_in) annotation (Line(
      points={{40,-120},{12,-120},{12,44},{38,44}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(
      StartTime=17280000,
      StopTime=17452800,
      __Dymola_NumberOfIntervals=2880,
      __Dymola_Algorithm="Cvode"),
    Diagram(coordinateSystem(extent={{-100,-120},{200,120}}), graphics={Text(
          extent={{118,-4},{190,-20}},
          lineColor={0,0,0},
          fontSize=10,
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
          textColor={0,0,255}), Bitmap(extent={{-98,-98},{96,94}}, fileName=
              "modelica://MultizoneOfficeComplexAir/Resources/figure/hvac.png")}),
    Documentation(info="<html>
<p>This model consist of a full HVAC system that contains the air side and water side systems. The air side system is a variable air volume (VAV) flow system with economizer and a cooling coil in the air handler unit. 
There are two fans (i.e., one supply fan, and one return fan) in the AHU. A mixing box carries out the economizer function of providing cooling and ventilation. 
Each VAV terminals contain a modulating damper and a hot water reheat coil. 
See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.AirsideFloor\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.AirsideFloor</a> for a description of the air side systems and the thermal zones.</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/AirSide.png\"/> </p>
<p>The water side systems include one chilled water system and one hot water system. The chilled water systems composed of three chillers, three cooling towers, a primary chilled water loop with three constant speed pumps, 
a secondary chilled water loop with two variable speed pumps, and a condenser water loop with three constant speed pumps. The hot water system consists of two gas boilers and two variable speed pumps. 
See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.ChillerPlant\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.ChillerPlant</a> for a description of the chilled water system. 
See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.BoilerPlant\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.BoilerPlant</a> for a description of the hot water system. </p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/ChilledWater.png\"/> </p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/HotWater.png\"/> </p>
<p>The air side system controls include the VAV air flow rate control, VAV supply air temperature control, AHU duct static pressure control, AHU supply air temperature control, and mixing box damper and economizer control.</p>
<p>The water side system controls include the chiller plant staging control, chilled water supply temperature control, secondary chilled water pump staging control, secondary chilled water loop static pressure control, cooling tower supply water temperature control, minimum condenser supply water temperature control, boiler staging control, boiler water temperature control, and boiler hot water loop static pressure control.</p>
</html>", revisions = "<html>
<ul>
<li>August 8, 2024, by Guowen Li, Xing Lu, Yan Chen: </li>
<p>Added CO2 and air infiltration features; Adjusted system equipment sizing; Reduced nonlinear system warnings.</p>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang, Yan Chen:
<p> First implementation.</p>
</ul>
</html>"),
    __Dymola_Commands(file="Resources/script/Testcase.mos" "Simulate and Plot"));
end HVAC;
