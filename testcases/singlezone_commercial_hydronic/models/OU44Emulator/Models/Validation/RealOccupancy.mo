within OU44Emulator.Models.Validation;
model RealOccupancy
  extends BuildingControl(
    oveCO2ZonSet(u(
        min=400,
        max=1000,
        unit="ppm")),
    reaTZon(KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
        y(unit="K")),
    oveTSupSet(u(
        min=273.15 + 15,
        max=273.15 + 40,
        unit="K")),
    districtHeating(m_flow_nominal=2),
    infiltration(ach=0.2),
    scale_factor(k=4),
    rad(dp_nominal=0),
    conPIDcoil(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.05,
      Ti=800),
    conPIDfan(k=0.1, Ti=600),
    conPIDrad(k=0.05, Ti=800),
    Occupancy_schedule(occupancy=3600*{31,43,55,67,79,91,103,115,127,139}),
    valRad(use_inputFilter=false),
    valCoil(use_inputFilter=false),
    intWall(roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium),
    floor(roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium),
    const5(k=283.15),
    const4(k=283.15),
    insulation(k=0.04),
    insulationRoof(k=0.04),
    insulationFloor(k=0.04),
    metHeat(k=120/AFlo));

  Modelica.Blocks.Sources.CombiTimeTable occupancy(
    tableOnFile=true,
    tableName="occ",
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://OU44Emulator/occ.txt"))
    annotation (Placement(transformation(extent={{-188,130},{-168,150}})));
  Buildings.Controls.SetPoints.OccupancySchedule Occupancy_schedule1(
    occupancy=3600*{31,43,55,67,79,91,103,115,127,139},
    period=604800,
    firstEntryOccupied=false)
    annotation (Placement(transformation(extent={{136,68},{152,84}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{168,72},{182,86}})));
  Modelica.Blocks.Sources.Constant Tset_low(k=288.15) "temperature setpoint"
    annotation (Placement(transformation(extent={{206,32},{192,46}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{154,40},{138,56}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{122,12},{102,32}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonSet(description=
        "Zone temperature set point for heating", u(
      unit="K",
      min=273.15 + 10,
      max=273.15 + 30)) "Overwrite for zone temperature set point for heating"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={95,-1})));
  Buildings.Utilities.IO.SignalExchange.Overwrite ovePum(description=
        "Pump speed control signal for heating distribution system", u(
      min=0,
      max=1,
      unit="1")) "Overwrite pump speed serving heating distribution system"
    annotation (Placement(transformation(extent={{-192,-204},{-172,-184}})));

  Buildings.Utilities.IO.SignalExchange.Read reaCO2Zon(
    description="Zone CO2 concentration",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm")) "Read CO2 concentration"
    annotation (Placement(transformation(extent={{-104,72},{-118,86}})));

  Buildings.Utilities.IO.SignalExchange.Read reaQHea(
    description="District heating thermal power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.DistrictHeatingPower,
    y(unit="W")) "Read heating thermal power consumption "
    annotation (Placement(transformation(extent={{-28,-224},{-8,-204}})));

  Modelica.Blocks.Continuous.Integrator Qel_fan(k=2.7778E-7) "Output in kWh"
    annotation (Placement(transformation(extent={{126,-150},{144,-132}})));
  Modelica.Blocks.Continuous.Integrator Qel_pmp(k=2.7778E-7) "Output in kWh"
    annotation (Placement(transformation(extent={{126,-182},{144,-164}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{126,-106},{142,-90}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPEle(
    description=
        "Electrical power consumption for AHU fans and heating system pump",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Read fans and pump electrical power consumption "
    annotation (Placement(transformation(extent={{160,-106},{176,-90}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPFan(
    y(unit="W"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    description="Electrical power consumption of AHU supply and return fans")
    "Read electrical power consumption of AHU fans"
    annotation (Placement(transformation(extent={{80,-92},{96,-76}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPPum(
    y(unit="W"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    description="Electrical power consumption of pump")
    "Read electrical power consumption of distribution system pump"
    annotation (Placement(transformation(extent={{80,-118},{96,-102}})));

  Modelica.Blocks.Sources.Constant Pump_sp(k=1)
    "speed signal for pump in district heating"
    annotation (Placement(transformation(extent={{-220,-204},{-200,-184}})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta "Weather station"
    annotation (Placement(transformation(extent={{90,120},{110,140}})));

  Buildings.Utilities.IO.SignalExchange.Read reaOcc(
    description="Building occupancy count",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="people")) "Occupancy count for building"
    annotation (Placement(transformation(extent={{-148,132},{-132,148}})));

equation
  connect(booleanToReal1.u, Occupancy_schedule1.occupied) annotation (Line(
        points={{166.6,79},{174.3,79},{174.3,71.2},{152.8,71.2}}, color={255,0,
          255}));
  connect(booleanToReal1.y, product1.u1) annotation (Line(points={{182.7,79},{
          194,79},{194,52.8},{155.6,52.8}}, color={0,0,127}));
  connect(Tset_low.y, product1.u2) annotation (Line(points={{191.3,39},{155.6,
          39},{155.6,43.2}}, color={0,0,127}));
  connect(product1.y, add.u1) annotation (Line(points={{137.2,48},{132,48},{132,
          28},{124,28}}, color={0,0,127}));
  connect(product.y, add.u2) annotation (Line(points={{135.2,-46},{130,-46},{
          130,16},{124,16}}, color={0,0,127}));
  connect(add.y, oveTZonSet.u)
    annotation (Line(points={{101,22},{95,22},{95,7.4}}, color={0,0,127}));
  connect(senCO2.ppm, reaCO2Zon.u) annotation (Line(points={{-67,66},{-84,66},{
          -84,79},{-102.6,79}}, color={0,0,127}));
  connect(districtHeating.qdh, reaQHea.u) annotation (Line(points={{-121.4,-208},
          {-78,-208},{-78,-214},{-30,-214}}, color={0,0,127}));
  connect(reaQHea.y, Qh_tot.u) annotation (Line(points={{-7,-214},{36,-214},{36,
          -216},{78,-216}}, color={0,0,127}));
  connect(ahu.qel, reaPFan.u) annotation (Line(points={{-146,33.4},{-146,6},{-106,
          6},{-106,-48},{70,-48},{70,-84},{78.4,-84}}, color={0,0,127}));
  connect(districtHeating.qel, reaPPum.u) annotation (Line(points={{-121.4,-196},
          {70,-196},{70,-110},{78.4,-110}}, color={0,0,127}));
  connect(reaPFan.y, Qel_fan.u) annotation (Line(points={{96.8,-84},{106,-84},{
          106,-141},{124.2,-141}}, color={0,0,127}));
  connect(reaPPum.y, Qel_pmp.u) annotation (Line(points={{96.8,-110},{106,-110},
          {106,-173},{124.2,-173}}, color={0,0,127}));
  connect(reaPFan.y, add1.u1) annotation (Line(points={{96.8,-84},{106,-84},{
          106,-93.2},{124.4,-93.2}}, color={0,0,127}));
  connect(reaPPum.y, add1.u2) annotation (Line(points={{96.8,-110},{106,-110},{
          106,-102.8},{124.4,-102.8}}, color={0,0,127}));
  connect(add1.y, reaPEle.u)
    annotation (Line(points={{142.8,-98},{158.4,-98}}, color={0,0,127}));
  connect(Pump_sp.y, ovePum.u)
    annotation (Line(points={{-199,-194},{-194,-194}}, color={0,0,127}));
  connect(weaSta.weaBus, weaBus) annotation (Line(
      points={{90.1,129.9},{38,129.9},{38,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(occupancy.y[1], reaOcc.u)
    annotation (Line(points={{-167,140},{-149.6,140}}, color={0,0,127}));
  connect(reaOcc.y, metHeat.u) annotation (Line(points={{-131.2,140},{-118,140},
          {-118,144},{-105.6,144}}, color={0,0,127}));
  connect(reaOcc.y, gaiCO2.u) annotation (Line(points={{-131.2,140},{-118,140},
          {-118,112},{-105.6,112}}, color={0,0,127}));
  connect(oveTZonSet.y, conPIDrad.u_s) annotation (Line(points={{95,-8.7},{95,
          -20},{120,-20},{120,-44},{117.6,-44}}, color={0,0,127}));
  connect(ovePum.y, districtHeating.y) annotation (Line(points={{-171,-194},{
          -158,-194},{-158,-196},{-143,-196}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000),               Diagram(
        coordinateSystem(extent={{-260,-240},{240,220}}),          graphics={
        Rectangle(
          extent={{-192,168},{-44,100}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-74,-54},{56,-140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-196,164},{-112,160}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Occupancy model"),
        Text(
          extent={{134,-66},{228,-72}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Temperature set point"),
        Text(
          extent={{-38,-144},{60,-150}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Radiator water circuit"),
        Rectangle(extent={{-206,18},{-174,-12}}, pattern=LinePattern.None),
        Line(
          points={{-170,42},{-154,42}},
          color={28,108,200},
          thickness=0.5,
          arrow={Arrow.Open,Arrow.None}),
        Text(
          extent={{-162,-218},{-102,-222}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="District heating
"),     Text(
          extent={{-240,48},{-170,38}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Air handling unit"),
        Text(
          extent={{-136,20},{-76,16}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Infiltration"),
        Text(
          extent={{-28,102},{32,98}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Zone model"),
        Line(
          points={{0,96},{0,82}},
          color={28,108,200},
          thickness=0.5,
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-88,18},{-76,18}},
          color={28,108,200},
          thickness=0.5,
          arrow={Arrow.Open,Arrow.None})}),
    Icon(coordinateSystem(extent={{-260,-240},{240,220}})));
end RealOccupancy;
