within OU44Emulator.Models.Validation;
model RealOccupancy
  extends BuildingControl(
    districtHeating(m_flow_nominal=2),
    infiltration(ach=0.2),
    scale_factor(k=4),
    rad(dp_nominal=15000),
    conPIDcoil(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=600,
      k=0.01),
    conPIDfan(k=0.05, Ti=200),
    conPIDrad(k=0.1, Ti=600),
    Occupancy_schedule(occupancy=3600*{31,43,55,67,79,91,103,115,127,139}),
    valRad(use_inputFilter=false),
    valCoil(use_inputFilter=false));
  Modelica.Blocks.Sources.CombiTimeTable occupancy(
    tableOnFile=true,
    tableName="occ",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://OU44Emulator/occ.txt"))
    annotation (Placement(transformation(extent={{-188,122},{-168,142}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=conPIDrad.y)
    annotation (Placement(transformation(extent={{-212,-206},{-192,-186}})));
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
  IBPSA.Utilities.IO.SignalExchange.Overwrite OverTzone(description=
        "Zone temperature setpoint for heating", u(
      unit="K",
      min=273.15 + 10,
      max=273.15 + 30))
                 "zone temperature setpoint for heating" annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={95,1})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite over_pump_DH(description=
        "District heating pump speed control signal", u(
      min=0,
      max=1,
      unit="1")) "overwrite pump speed for district heating"
    annotation (Placement(transformation(extent={{-180,-206},{-160,-186}})));
  IBPSA.Utilities.IO.SignalExchange.Read read_T_zone_read(
    description="Zone air temperature setpoint for heating",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Read zone air temperature setpoint"
    annotation (Placement(transformation(extent={{104,-26},{116,-14}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{114,-104},{134,-84}})));
  IBPSA.Utilities.IO.SignalExchange.Read read_Q_el(
    description="Electrical power consumption for fan and pump",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="kW")) "Read electrical power consumption "
    annotation (Placement(transformation(extent={{150,-106},{170,-86}})));

  IBPSA.Utilities.IO.SignalExchange.Read read_Q_h(
    y(unit="kW"),
    description="Heating thermal power consumption",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.DistrictHeatingPower)
    "Read heating power consumption "
    annotation (Placement(transformation(extent={{134,-216},{158,-192}})));
  IBPSA.Utilities.IO.SignalExchange.Read read_CO2(description=
        "Indoor CO2 concentration", KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration)
    "Read CO2 concentration"
    annotation (Placement(transformation(extent={{-104,68},{-118,82}})));
equation
  connect(occupancy.y[1], gaiCO2.u) annotation (Line(points={{-167,132},{-140,
          132},{-140,112},{-105.6,112}},
                                       color={0,0,127}));
  connect(occupancy.y[1], metHeat.u) annotation (Line(points={{-167,132},{-140,
          132},{-140,144},{-105.6,144}}, color={0,0,127}));
  connect(booleanToReal1.u, Occupancy_schedule1.occupied) annotation (Line(
        points={{166.6,79},{174.3,79},{174.3,71.2},{152.8,71.2}}, color={255,0,
          255}));
  connect(booleanToReal1.y, product1.u1) annotation (Line(points={{182.7,79},{
          194,79},{194,52.8},{155.6,52.8}}, color={0,0,127}));
  connect(Tset_low.y, product1.u2) annotation (Line(points={{191.3,39},{155.6,
          39},{155.6,43.2}}, color={0,0,127}));
  connect(product1.y, add.u1) annotation (Line(points={{137.2,48},{132,48},{132,
          28},{124,28}}, color={0,0,127}));
  connect(product.y, add.u2) annotation (Line(points={{135.2,-44},{130,-44},{
          130,16},{124,16}}, color={0,0,127}));
  connect(add.y, OverTzone.u)
    annotation (Line(points={{101,22},{95,22},{95,9.4}}, color={0,0,127}));
  connect(realExpression.y, over_pump_DH.u)
    annotation (Line(points={{-191,-196},{-182,-196}}, color={0,0,127}));
  connect(over_pump_DH.y, districtHeating.y)
    annotation (Line(points={{-159,-196},{-143,-196}}, color={0,0,127}));
  connect(OverTzone.y, read_T_zone_read.u) annotation (Line(points={{95,-6.7},{
          95,-20},{102.8,-20}}, color={0,0,127}));
  connect(read_T_zone_read.y, conPIDrad.u_s) annotation (Line(points={{116.6,
          -20},{126,-20},{126,-44},{117.6,-44}}, color={0,0,127}));
  connect(Qel_fan.y, add1.u1) annotation (Line(points={{101,-76},{106,-76},{106,
          -88},{112,-88}}, color={0,0,127}));
  connect(Qel_pmp.y, add1.u2) annotation (Line(points={{101,-108},{106,-108},{
          106,-100},{112,-100}}, color={0,0,127}));
  connect(add1.y, read_Q_el.u) annotation (Line(points={{135,-94},{140,-94},{
          140,-96},{148,-96}}, color={0,0,127}));
  connect(Qh_tot.y, read_Q_h.u) annotation (Line(points={{101,-204},{131.6,-204}},
                                    color={0,0,127}));
  connect(senCO2.ppm, read_CO2.u) annotation (Line(points={{-67,66},{-84,66},{
          -84,75},{-102.6,75}}, color={0,0,127}));
  annotation (experiment(StopTime=2678400, Interval=3600), Diagram(
        coordinateSystem(extent={{-260,-220},{240,220}}),          graphics={
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
          textString="Infltration"),
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
    Icon(coordinateSystem(extent={{-260,-220},{240,220}})));
end RealOccupancy;
