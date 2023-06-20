within MultizoneOfficeComplexAir.BaseClasses.HVACSide;
model HVAC
  extends MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.AirSide(
      sou(nPorts=3));
  package MediumCW = Buildings.Media.Water
    "Medium model";
  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[:]={-datChi[1].QEva_flow_nominal
      /4200/5.56 for i in linspace(
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
  MultizoneOfficeComplexAir.BaseClasses.BuildingControlEmulator.Systems.BoilerPlant boiWatPla(secPumCon(conPI(k=0.001)),
      redeclare package MediumHW = MediumHeaWat) "Boiler hot water plant"
    annotation (Placement(transformation(extent={{120,-110},{140,-90}})));

  MultizoneOfficeComplexAir.BaseClasses.BuildingControlEmulator.Subsystems.HydDisturbution.ThreZonNetWor boiWatNet(
    PreDroBra2(displayUnit="Pa") = 0,
    PreDroBra3(displayUnit="Pa") = 0,
    PreDroMai1(displayUnit="Pa") = (79712/4),
    PreDroMai2(displayUnit="Pa") = (79712/4),
    mFloRat1=mWatFloRat1[1] + mWatFloRat2[1] + mWatFloRat3[1] + mWatFloRat4[1] +
        mWatFloRat5[1],
    mFloRat2=mWatFloRat1[2] + mWatFloRat2[2] + mWatFloRat3[2] + mWatFloRat4[2] +
        mWatFloRat5[2],
    mFloRat3=mWatFloRat1[3] + mWatFloRat2[3] + mWatFloRat3[3] + mWatFloRat4[3] +
        mWatFloRat5[3],
    redeclare package Medium = MediumHeaWat,
    PreDroBra1(displayUnit="Pa") = (79712/4))
    "Hot water plant distribution network"
    annotation (Placement(transformation(extent={{156,-92},{176,-112}})));
  MultizoneOfficeComplexAir.BaseClasses.BuildingControlEmulator.Systems.ChillerPlant chiWatPla(
    datChi=datChi,
    redeclare package MediumCHW = MediumCHW,
    redeclare package MediumCW = MediumCW,
    Cap={-datChi[1].QEva_flow_nominal,-datChi[2].QEva_flow_nominal,-datChi[3].QEva_flow_nominal},
    mCHW_flow_nominal=mCHW_flow_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    secPumCon(conPI(k=0.000001, Ti=240))) "Chilled water plant"
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));

  MultizoneOfficeComplexAir.BaseClasses.BuildingControlEmulator.Subsystems.HydDisturbution.ThreZonNetWor chiWatNet(
    redeclare package Medium = MediumCHW,
    mFloRat1=-datChi[1].QEva_flow_nominal/4200/5.56,
    mFloRat2=-datChi[1].QEva_flow_nominal/4200/5.56,
    mFloRat3=-datChi[1].QEva_flow_nominal/4200/5.56,
    PreDroBra1(displayUnit="Pa") = PreDroCooWat,
    PreDroBra2(displayUnit="Pa") = 0,
    PreDroBra3(displayUnit="Pa") = 0,
    PreDroMai1=PreDroCooWat,
    PreDroMai2=PreDroCooWat) "Chilled water plant distribution network"
    annotation (Placement(transformation(extent={{36,-90},{56,-110}})));
  Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Trane_CVHE_1442kW_6_61COP_VSD
    datChi[3](each QEva_flow_nominal=-2500000) "Chiller data record"
                                               annotation (Placement(transformation(extent={{-100,
            -48},{-80,-28}})));

  Modelica.Blocks.Sources.Constant TCWSupSet(k=273.15 + 29.44)
    "Cooling water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
  Modelica.Blocks.Sources.Constant TCHWSupSet(k=273.15 + 5.56)
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Blocks.Interfaces.RealInput TWetBul
    "Entering air wet bulb temperature"
    annotation (Placement(transformation(extent={{-128,-82},{-100,-54}}),
        iconTransformation(extent={{-127,-83},{-100,-54}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTCHWSet(description=
        "Chilled water supply temperature setpoint", u(
      max=273.15 + 13,
      unit="K",
      min=273.15 + 4))
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.RealExpression PHWPum(y=sum(boiWatPla.pumSecHW.P))
    "Hot water pump power consumption"
    annotation (Placement(transformation(extent={{122,-70},{142,-50}})));
  Modelica.Blocks.Sources.RealExpression PBoi(y=boiWatPla.multiBoiler.boi[1].boi.QFue_flow
         + boiWatPla.multiBoiler.boi[2].boi.QFue_flow) "Boiler gas consumption"
    annotation (Placement(transformation(extent={{122,-44},{142,-24}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPBoi(
    description="Boiler gas consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    y(unit="W")) "Block for outputting the boiler gas power"
    annotation (Placement(transformation(extent={{160,-44},{180,-24}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPHWPum(
    description="Hot water pump power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Block for outputting the hot water pump"
    annotation (Placement(transformation(extent={{160,-70},{180,-50}})));

  Modelica.Blocks.Sources.Constant THWSupSet(k=273.15 + 80)
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTHWSet(description=
        "Hot water supply temperature setpoint", u(
      max=273.15 + 90,
      unit="K",
      min=273.15 + 40))
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPCHWPum(
    description="Chilled water plant pump power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Block for outputting the chilled water plant"
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));

  Modelica.Blocks.Sources.RealExpression PCHWPum(y=chiWatPla.PConSpePum.y +
        chiWatPla.PVarSpePum.y) "Chilled water plant pump power consumption"
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPChi(
    description="Multiple chiller power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Block for outputting the multiple chillers"
    annotation (Placement(transformation(extent={{40,-54},{60,-34}})));

  Modelica.Blocks.Sources.RealExpression PChi(y=chiWatPla.PCh.y)
    "Multiple chiller power consumption"
    annotation (Placement(transformation(extent={{0,-54},{20,-34}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPCooTow(
    description="Multiple cooling tower power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Block for outputting the multiple cooling towers"
    annotation (Placement(transformation(extent={{40,-78},{60,-58}})));

  Modelica.Blocks.Sources.RealExpression PCooTow(y=chiWatPla.PCooTow.y)
    "Cooling tower power consumption"
    annotation (Placement(transformation(extent={{0,-78},{20,-58}})));
  Modelica.Blocks.Sources.RealExpression PFan(y=floor1.duaFanAirHanUnit.supFan.P
         + floor2.duaFanAirHanUnit.supFan.P + floor3.duaFanAirHanUnit.supFan.P
         + floor1.duaFanAirHanUnit.retFan.P + floor2.duaFanAirHanUnit.retFan.P
         + floor3.duaFanAirHanUnit.retFan.P) "AHU fan power consumption"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPFan(
    description="AHU fan power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,

    y(unit="W")) "Block for outputting the AHU fan power consumption"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
equation
  connect(chiWatNet.ports_a[1], floor1.port_b_CooWat) annotation (Line(
      points={{56,-91.1333},{56,-94},{100,-94},{100,6},{124,6},{124,20}},
      color={0,127,225},
      thickness=1));
  connect(floor1.port_a_CooWat, chiWatNet.ports_b[1]) annotation (Line(
      points={{130,20},{130,0},{106,0},{106,-102},{74,-102},{74,-101.933},{56,
          -101.933}},
      color={0,127,225},
      thickness=1));

  connect(chiWatNet.ports_a[2], floor2.port_b_CooWat);
  connect(floor2.port_a_CooWat, chiWatNet.ports_b[2]);
  connect(chiWatNet.ports_a[3], floor3.port_b_CooWat);
  connect(floor3.port_a_CooWat, chiWatNet.ports_b[3]);
  connect(boiWatNet.ports_a[1], floor1.port_b_HeaWat) annotation (Line(
      points={{176,-93.1333},{196,-93.1333},{196,6},{154,6},{154,20},{153,20}},
      color={238,46,47},
      thickness=1));

  connect(boiWatNet.ports_b[1], floor1.port_a_HeaWat) annotation (Line(
      points={{176,-103.933},{192,-103.933},{192,0},{150,0},{150,20},{147.5,20}},
      color={238,46,47},
      thickness=1));

  connect(boiWatNet.ports_a[2], floor2.port_b_HeaWat);
  connect(boiWatNet.ports_b[2], floor2.port_a_HeaWat);
  connect(boiWatNet.ports_a[3], floor3.port_b_HeaWat);
  connect(boiWatNet.ports_b[3], floor3.port_a_HeaWat);

  connect(chiWatPla.port_a, chiWatNet.port_b) annotation (Line(
      points={{20,-94},{36,-94}},
      color={0,127,255},
      thickness=1));
  connect(chiWatNet.port_a, chiWatPla.port_b) annotation (Line(
      points={{36,-104},{20,-104}},
      color={0,127,255},
      thickness=1));
  connect(chiWatNet.p, chiWatPla.dP) annotation (Line(points={{57,-100},{64,-100},
          {64,-120},{-6,-120},{-6,-92},{-1.6,-92}}, color={0,0,127}));
  connect(chiWatPla.TCWSet, TCWSupSet.y) annotation (Line(points={{-1.6,-102.8},
          {-10,-102.8},{-10,-90},{-49,-90}},
                                      color={0,0,127}));
  connect(chiWatPla.TWetBul, TWetBul) annotation (Line(points={{-1.6,-108},{-80,
          -108},{-80,-68},{-114,-68}}, color={0,0,127}));
  connect(boiWatPla.port_a, boiWatNet.port_b) annotation (Line(
      points={{140,-96},{140,-96},{156,-96}},
      color={238,46,47},
      thickness=1));
  connect(boiWatNet.port_a, boiWatPla.port_b) annotation (Line(
      points={{156,-106},{140,-106},{140,-106}},
      color={238,46,47},
      thickness=1));
  connect(boiWatNet.p, boiWatPla.dP) annotation (Line(points={{177,-102},{182,
          -102},{182,-120},{110,-120},{110,-100},{118,-100}},
                                                            color={0,0,127}));
  connect(TCHWSupSet.y, oveTCHWSet.u)
    annotation (Line(points={{-49,-30},{-42,-30}}, color={0,0,127}));
  connect(oveTCHWSet.y, chiWatPla.TCHWSet) annotation (Line(points={{-19,-30},{
          -8,-30},{-8,-98},{-1.6,-98}},
                                     color={0,0,127}));

  connect(PBoi.y, reaPBoi.u)
    annotation (Line(points={{143,-34},{158,-34}}, color={0,0,127}));
  connect(reaPHWPum.u, PHWPum.y)
    annotation (Line(points={{158,-60},{143,-60}}, color={0,0,127}));
  connect(THWSupSet.y, oveTHWSet.u)
    annotation (Line(points={{-49,-60},{-42,-60}}, color={0,0,127}));
  connect(oveTHWSet.y, boiWatPla.THWSet) annotation (Line(points={{-19,-60},{
          -10,-60},{-10,-80},{80,-80},{80,-94},{118,-94}}, color={0,0,127}));
  connect(reaPCHWPum.u, PCHWPum.y)
    annotation (Line(points={{38,-20},{21,-20}}, color={0,0,127}));
  connect(reaPChi.u, PChi.y)
    annotation (Line(points={{38,-44},{21,-44}}, color={0,0,127}));
  connect(reaPCooTow.u, PCooTow.y)
    annotation (Line(points={{38,-68},{21,-68}}, color={0,0,127}));
  connect(reaPFan.u, PFan.y)
    annotation (Line(points={{38,10},{21,10}}, color={0,0,127}));
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
          extent={{-152,112},{148,152}},
          textString="%name",
          textColor={0,0,255}), Bitmap(extent={{-98,-98},{96,94}}, fileName=
              "modelica://MultizoneOfficeComplexAir/Resources/figure/hvac.png")}));
end HVAC;
