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
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Blocks.Interfaces.RealInput TWetBul
    "Entering air wet bulb temperature"
    annotation (Placement(transformation(extent={{-128,-82},{-100,-54}}),
        iconTransformation(extent={{-127,-83},{-100,-54}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTCHWSet
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Sources.RealExpression PHWPum(y=sum(boiWatPla.pumSecHW.P))
    "Hot water pump power consumption"
    annotation (Placement(transformation(extent={{140,-66},{160,-46}})));
  Modelica.Blocks.Sources.RealExpression PBoi(y=boiWatPla.multiBoiler.boi[1].boi.QFue_flow
         + boiWatPla.multiBoiler.boi[2].boi.QFue_flow) "Boiler gas consumption"
    annotation (Placement(transformation(extent={{110,-66},{130,-46}})));
equation
  connect(chiWatNet.ports_a[1], floor1.port_b_CooWat) annotation (Line(
      points={{56,-91.1333},{88,-91.1333},{88,6},{124,6},{124,20}},
      color={0,127,225},
      thickness=1));
  connect(floor1.port_a_CooWat, chiWatNet.ports_b[1]) annotation (Line(
      points={{130,20},{130,0},{92,0},{92,-102},{74,-102},{74,-101.933},{56,
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
  connect(chiWatPla.TCWSet, TCWSupSet.y) annotation (Line(points={{-1.6,-102},{-10,
          -102},{-10,-90},{-49,-90}}, color={0,0,127}));
  connect(chiWatPla.TWetBul, TWetBul) annotation (Line(points={{-1.6,-108},{-30,
          -108},{-30,-68},{-114,-68}}, color={0,0,127}));
  connect(boiWatPla.port_a, boiWatNet.port_b) annotation (Line(
      points={{140,-95},{140,-96},{156,-96}},
      color={238,46,47},
      thickness=1));
  connect(boiWatNet.port_a, boiWatPla.port_b) annotation (Line(
      points={{156,-106},{140,-106},{140,-106}},
      color={238,46,47},
      thickness=1));
  connect(boiWatNet.p, boiWatPla.dP) annotation (Line(points={{177,-102},{182,-102},
          {182,-120},{104,-120},{104,-100.2},{118,-100.2}}, color={0,0,127}));
  connect(TCHWSupSet.y, oveTCHWSet.u)
    annotation (Line(points={{-49,-40},{-42,-40}}, color={0,0,127}));
  connect(oveTCHWSet.y, chiWatPla.TCHWSet) annotation (Line(points={{-19,-40},{-8,
          -40},{-8,-98},{-1.6,-98}}, color={0,0,127}));

  annotation (experiment(
      StartTime=17280000,
      StopTime=17452800,
      __Dymola_NumberOfIntervals=2880,
      __Dymola_Algorithm="Cvode"),
    Diagram(coordinateSystem(extent={{-100,-120},{200,120}}), graphics={Text(
          extent={{126,-18},{198,-34}},
          lineColor={0,0,0},
          fontSize=10,
          textStyle={TextStyle.Bold},
          textString="Waterside"),     Line(
          points={{-100,-14},{200,-14}},
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
