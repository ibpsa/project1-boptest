within BuildingEmulators.Templates.Heating;
model FanCoilUnits

  extends BuildingEmulators.Templates.Interfaces.BaseClasses.HeatingSystem(
    P=fill(QHeaSys,nLoads_min),
    Q=zeros(nLoads_min),
    final isDH=false,
    final nTemSen = nZones,
    final nLoads=0,
    final nVen=nZones,
    final nEmb = 0,
    nZones=2);

  parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal = sum(QHeaEmi_flow_nominal) + sum(QHeaAhu_flow_nominal) "Nominal heat transfer of the heating production system" annotation (
    Dialog(group = "Nominal power"));
  parameter Modelica.Units.SI.HeatFlowRate QCoo_flow_nominal = sum(QCooEmi_flow_nominal) + sum(QCooAhu_flow_nominal) "Nominal heat transfer of the cooling production system" annotation (
    Dialog(group = "Nominal power"));
  parameter Modelica.Units.SI.HeatFlowRate QHeaEmi_flow_nominal[nZones]  "Nominal heat transfer of the FCU heating coil" annotation (
    Dialog(group = "Nominal power"));
  parameter Modelica.Units.SI.HeatFlowRate QCooEmi_flow_nominal[nZones]  "Nominal heat transfer of the FCU cooling coil" annotation (
    Dialog(group = "Nominal power"));
  parameter Modelica.Units.SI.HeatFlowRate QHeaAhu_flow_nominal[nVen] "Nominal heat transfer of the FCU heating coil" annotation (
    Dialog(group = "Nominal power"));
  parameter Modelica.Units.SI.HeatFlowRate QCooAhu_flow_nominal[nVen] "Nominal heat transfer of the FCU cooling coil" annotation (
    Dialog(group = "Nominal power"));

  replaceable package MediumAir = IDEAS.Media.Air;
  replaceable package MediumHeating = IDEAS.Media.Water;
  replaceable package MediumCooling = IDEAS.Media.Water;
  parameter Boolean allowFlowReversal = false "";

  parameter .Modelica.Units.SI.PressureDifference dp_nominal_wat_emi(min=0) = 12 * 10000
    "Emission nominal pressure drop" annotation (Dialog(group="Nominal condition"));
  parameter .Modelica.Units.SI.PressureDifference hp_nominal_wat_emi(min=0) = 12 * 10000
    "Emission nominal pressure head" annotation (Dialog(group="Nominal condition"));
  parameter .Modelica.Units.SI.PressureDifference dp_nominal_wat_ahu(min=0) = 9 * 10000
    "AHU system nominal pressure drop" annotation (Dialog(group="Nominal condition"));
  parameter .Modelica.Units.SI.PressureDifference hp_nominal_wat_ahu(min=0) = 9 * 10000
    "AHU system nominal pressure head" annotation (Dialog(group="Nominal condition"));
  parameter .Modelica.Units.SI.PressureDifference dp_nominal_wat_pro(min=0) = 6 * 10000
    "Production nominal pressure drop" annotation (Dialog(group="Nominal condition"));
  parameter .Modelica.Units.SI.PressureDifference hp_nominal_wat_pro(min=0) = 6 * 10000
    "Production nominal pressure head" annotation (Dialog(group="Nominal condition"));

  parameter .Modelica.Units.SI.MassFlowRate[nZones] mAir_flow_nominal = {max(QHeaEmi_flow_nominal[i], -QCooEmi_flow_nominal[i])/1004/10 for i in 1:nZones} "Nominal mass flow rate of air";

  parameter Modelica.Units.SI.TemperatureDifference deltaTCoo_nominal = 5 "Nominal temperature difference in water side in the cooling coil" annotation (
    Dialog(group = "Cooling coil parameters"));
  parameter Modelica.Units.SI.TemperatureDifference deltaTHea_nominal = 5 "Nominal temperature difference in water side in the heating coil" annotation (
    Dialog(group = "Heating coil parameters"));
  parameter Modelica.Units.SI.MassFlowRate[nZones] mWatEmiHea_flow_nominal = QHeaEmi_flow_nominal / 4180 / deltaTHea_nominal "Nominal mass flow of the heating coil";
  parameter Modelica.Units.SI.MassFlowRate[nZones] mWatEmiCoo_flow_nominal = -QCooEmi_flow_nominal / 4180 / deltaTCoo_nominal "Nominal mass flow of the cooling coil";
  parameter Modelica.Units.SI.MassFlowRate[nVen] mWatAhuHea_flow_nominal "Nominal mass flow of the AHU heating coil";
  parameter Modelica.Units.SI.MassFlowRate[nVen] mWatAhuCoo_flow_nominal "Nominal mass flow of the AHU cooling coil";


  parameter Modelica.Units.SI.MassFlowRate mWatProHea_flow_nominal = sum(mWatEmiHea_flow_nominal) + sum(mWatAhuHea_flow_nominal)  "Nominal mass flow of the heating production";
  parameter Modelica.Units.SI.MassFlowRate mWatProCoo_flow_nominal = sum(mWatEmiCoo_flow_nominal) + sum(mWatAhuCoo_flow_nominal) "Nominal mass flow of the cooling production";

  Components.FanCoilUnit_prf fanCoilUnit[nZones](
    mAir_flow_nominal = mAir_flow_nominal,
    QCoo_flow_nominal = QCooEmi_flow_nominal,
    each TCoo_a1_nominal = 273.15 + 7,
    each TCoo_a2_nominal = 273.15 + 31,
    QHea_flow_nominal = QHeaEmi_flow_nominal,
    each THea_a1_nominal = 273.15 + 50,
    each THea_a2_nominal = 273.15 + 16,deltaTHea_nominal = {20,20})
    annotation (Placement(transformation(extent={{-79.0,68.0},{-53.0,96.0}},rotation = 0.0,origin = {0.0,0.0})));
  Components.CollectorPair cooCol(nDist = nZones + nVen, m_flow_nominal = {mWatProCoo_flow_nominal},dp_nominal = 0) "Cooling collector"
    annotation (Placement(transformation(extent={{-54.26212590299278,-80.0},{-102.26212590299278,-42.0}},rotation = 0.0,origin = {0.0,0.0})));
  Components.CollectorPair heaCol(nDist = nZones + nVen, m_flow_nominal = {mWatProHea_flow_nominal},dp_nominal = 0) "Heating collector"
    annotation (Placement(transformation(extent={{14.0,-31.0},{-34.0,7.0}},rotation = 0.0,origin = {0.0,0.0})));
  Modelica.Fluid.Sources.Boundary_pT zon[nZones](
    redeclare package Medium = MediumAir,
    each use_T_in=true,
    each nPorts=2,
    each use_X_in = true)
    annotation (Placement(transformation(extent={{-148.0,20.0},{-128.0,40.0}},rotation = 0.0,origin = {0.0,0.0})));
  BuildingEmulators.Components.IdealProduction  heapro(
    boiler=false,
    heating=true,
    redeclare package Medium = MediumHeating,
    use_X_wSet=false,
    allowFlowReversal=false,
    m_flow_nominal=mWatProHea_flow_nominal,QMax_flow = QHea_flow_nominal,QMin_flow = 0)
                                     "Ideal heater" annotation(Placement(transformation(extent = {{-10.0,10.0},{10.0,-10.0}},origin={64.0,-2.0},     rotation = 180.0)));
  IDEAS.Fluid.Movers.FlowControlled_dp pumHea(
    redeclare package Medium = MediumHeating,
    m_flow_nominal=mWatProHea_flow_nominal,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,allowFlowReversal = false,addPowerToMedium = false,dp_nominal = dp_nominal_wat_pro,inputType = IDEAS.Fluid.Types.InputType.Stages)
    "Pump for boiler circuit" annotation (Placement(transformation(extent={{5.719147562944727,-5.719147562944727},{-5.719147562944727,5.719147562944727}}, origin={90.0,-30.0},
        rotation=-180.0)));

  IDEAS.Fluid.Sources.Boundary_pT bouHea(
                                redeclare package Medium =
        MediumHeating,
    nPorts=1)
    "Fixed boundary condition, needed to provide a pressure in the system"
    annotation (Placement(transformation(extent={{5.413781666484795,-5.413781666484795},{-5.413781666484795,5.413781666484795}},
        rotation=-90.0,
        origin={118.0,-42.0})));

  IDEAS.Fluid.Movers.FlowControlled_dp pumCoo(
    redeclare package Medium = MediumCooling,
    m_flow_nominal=mWatProCoo_flow_nominal,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,allowFlowReversal = false,addPowerToMedium = false,dp_nominal = dp_nominal_wat_pro,inputType = IDEAS.Fluid.Types.InputType.Stages)
    "Pump for boiler circuit" annotation (Placement(transformation(
        extent={{-13.333370829771411,-64.66662917022859},{-2.666629170228588,-75.33337082977141}},
        origin={0.0,0.0},
        rotation=0.0)));
  IDEAS.Fluid.Sources.Boundary_pT bouCoo(
    redeclare package Medium = MediumCooling,
    nPorts=1)
    "Fixed boundary condition, needed to provide a pressure in the system"
    annotation (Placement(transformation(extent={{5.573121517930822,-5.573121517930829},{-5.573121517930822,5.573121517930829}},
        rotation=-90.0,
        origin={50.0,-92.0})));

    .Modelica.Blocks.Interfaces.IntegerInput prfProHea  annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},rotation = -90.0,origin = {90.0,-100.0})));
    .Modelica.Blocks.Interfaces.IntegerInput prfProCoo  annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},rotation = -90.0,origin = {-54.0,-104.0})));
    Modelica.Blocks.Interfaces.IntegerInput[nTemSen] prfEmiCoo(each max=1, each min=0) "Activation cooling emission" annotation (Placement(transformation(
        extent={{10.0,-10.0},{-10.0,10.0}},
        rotation=-90.0,
        origin={-106.0,-100.0})));
    .BuildingEmulators.Components.MixingStage[nZones] mixingEmiHea(m_flow_nominal_emi = mWatEmiHea_flow_nominal, each dp_nominal = dp_nominal_wat_emi) annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {-12.0,30.0},rotation = -90.0)));
    .BuildingEmulators.Components.MixingStage[nZones] mixingEmiCoo(m_flow_nominal_emi = mWatEmiCoo_flow_nominal, each dp_nominal = dp_nominal_wat_emi) annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {-74.0,10.0},rotation = -90.0)));
    Modelica.Blocks.Interfaces.RealInput[nTemSen] valPosEmiCoo(each quantity = "ThermodynamicTemperature",each unit = "K",each displayUnit = "degC",each min = 0) "Valve position emission cooling" annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},rotation = -90.0,origin = {-120.0,-100.0})));
    .Modelica.Blocks.Interfaces.RealInput[nTemSen] valPosEmiHea(each min = 0, each displayUnit = "degC",each unit = "K",each quantity = "ThermodynamicTemperature") "Valve position emission heating" annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},rotation = 90.0,origin = {26.0,100.0})));
    .Modelica.Blocks.Interfaces.IntegerInput[nTemSen] prfEmiHea(each max = 0, each min = 0) "Activation heating emission" annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},rotation = 90.0,origin = {10.0,100.0})));
    .Modelica.Blocks.Math.Add[nZones] add annotation(Placement(transformation(extent = {{-93.40888846177197,90.59111153822803},{-102.59111153822803,81.40888846177197}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nZones] prescribedHeatFlow annotation(Placement(transformation(extent = {{-126.0,96.0},{-146.0,76.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.Sensors.TemperatureTwoPort senTSupProCoo(tau = 0,redeclare
      package                                                                       Medium =
        MediumCooling,                                                                                     m_flow_nominal = 1,allowFlowReversal = false) annotation(Placement(transformation(extent = {{-22.567980396864016,-42.567980396864016},{-33.432019603135984,-53.432019603135984}},origin = {0.0,0.0},rotation = 0.0)));
    .BuildingEmulators.Components.MixingStage[nVen] mixingAhuHea(each dp_nominal = dp_nominal_wat_ahu,m_flow_nominal_emi = mWatAhuHea_flow_nominal) annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {143.55261249999992,60.65324852941174},rotation = -90.0)));
    .BuildingEmulators.Components.MixingStage[nVen] mixingAhuCoo(each dp_nominal = dp_nominal_wat_ahu,m_flow_nominal_emi = mWatAhuCoo_flow_nominal) annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {59.13477794117637,53.03643333333331},rotation = -90.0)));
    .Modelica.Blocks.Interfaces.IntegerInput[nTemSen] prfAhuHea(each max= 1, each min = 0) "Activation AHU heating circuit" annotation(Placement(transformation(extent = {{216.0,50.0},{196.0,70.0}},rotation = 0.0,origin = {0.0,0.0})));
    .Modelica.Blocks.Interfaces.RealInput[nTemSen] valPosAhuHea(each max= 1,each min = 0) "Valve position AHU heating circuit" annotation(Placement(transformation(extent = {{216.0,36.0},{196.0,56.0}},rotation = 0.0,origin = {0.0,0.0})));
    .Modelica.Blocks.Interfaces.IntegerInput[nTemSen] prfAhuCoo(each min = 0,each max =1) "Activation AHU cooling circuit" annotation(Placement(transformation(extent = {{216.0,22.0},{196.0,42.0}},rotation = 0.0,origin = {0.0,0.0})));
    .Modelica.Blocks.Interfaces.RealInput[nTemSen] valPosAhuCoo(each min=0, each max=1) "Valve position AHU cooling circuit" annotation(Placement(transformation(extent = {{216.0,10.0},{196.0,30.0}},rotation = 0.0,origin = {0.0,0.0})));

    .Modelica.Blocks.Interfaces.RealInput TSupProHea(quantity = "ThermodynamicTemperature",unit = "K",displayUnit = "degC",min = 0) "Heating production temperature" annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 180.0,origin = {200.0,-30.0})));
    .Modelica.Blocks.Interfaces.RealInput TSupProCoo(quantity = "ThermodynamicTemperature",unit = "K",displayUnit = "degC",min = 0) "Cooling production temperature" annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 180.0,origin = {200.0,-50.0})));
    .IDEAS.Fluid.Sensors.TemperatureTwoPort senTSupProHea(allowFlowReversal = false,m_flow_nominal = 1,redeclare
      package                                                                                                            Medium =
        MediumHeating,                                                                                                                          tau = 0) annotation(Placement(transformation(extent = {{38.821359009711834,2.821359009711837},{29.178640990288162,-6.821359009711837}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.FixedResistances.PressureDrop preDroProHea(redeclare package Medium =
        MediumHeating,                                                                               allowFlowReversal = false,m_flow_nominal = mWatProHea_flow_nominal,dp_nominal = dp_nominal_wat_pro) "Flow resistance to decouple pressure state from boundary" annotation(Placement(transformation(extent = {{95.19929311378094,-7.6303412349598805},{84.80070688621906,3.6303412349598805}},rotation = 0.0,origin = {0.0,0.0})));
    .IDEAS.Fluid.FixedResistances.PressureDrop preDroProCoo(dp_nominal = dp_nominal_wat_pro,m_flow_nominal = mWatProCoo_flow_nominal,allowFlowReversal = false,redeclare
      package                                                                                                                                                                    Medium =
        MediumCooling)                                                                                                                                                                                   "Flow resistance to decouple pressure state from boundary" annotation(Placement(transformation(extent = {{28.80070688621906,-75.63034123495989},{39.19929311378094,-64.36965876504011}},rotation = 0.0,origin = {0.0,0.0})));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TSupAhuHea(each min = 0,each displayUnit = "degC",each unit = "K",each quantity = "ThermodynamicTemperature") annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {188.0,110.0},rotation = 90.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TSupAhuCoo(each min = 0,each displayUnit = "degC",each unit = "K",each quantity = "ThermodynamicTemperature") annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {100.0,110.0},rotation = 90.0)));
    .BuildingEmulators.Components.IdealProduction coopro(
        QMin_flow = QCoo_flow_nominal,
        QMax_flow = 0,
        m_flow_nominal = mWatProCoo_flow_nominal,
        allowFlowReversal = false,
        use_X_wSet = false,
        redeclare package Medium = MediumCooling,
        boiler=false,
        heating=false) "Ideal heater" annotation(Placement(transformation(extent = {{-10.0,10.0},{10.0,-10.0}},origin = {10.0,-48.0},rotation = 180.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TSupEmiHea(each min = 0,each displayUnit = "degC",each unit = "K",each quantity = "ThermodynamicTemperature") annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {-10.0,110.0},rotation = 90.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TSupEmiCoo(each min = 0,each displayUnit = "degC",each unit = "K",each quantity = "ThermodynamicTemperature") annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {-38.0,110.0},rotation = 90.0)));
    .Modelica.Blocks.Interfaces.RealInput[nZones] TZonSetMin(each quantity = "ThermodynamicTemperature",each unit = "K",each displayUnit = "degC",each min = 0) "Setpoint temperature for the zones" annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 90.0,origin = {40.0,-104.0}),iconTransformation(extent = {{-10,-10},{10,10}},rotation = 90,origin = {0,-102})));
    .Modelica.Blocks.Interfaces.RealInput[nZones] TZonSetMax(each min = 0,each displayUnit = "degC",each unit = "K",each quantity = "ThermodynamicTemperature") "Setpoint temperature for the zones" annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 90.0,origin = {6.0,-104.0}),iconTransformation(extent = {{-10,-10},{10,10}},rotation = 90,origin = {0,-102})));
    .IDEAS.Fluid.Sensors.TemperatureTwoPort senTRetProCoo(allowFlowReversal = false,m_flow_nominal = 1,redeclare
      package                                                                                                            Medium =
        MediumCooling,                                                                                                                          tau = 0) annotation(Placement(transformation(extent = {{-39.432019603135984,-64.56798039686402},{-28.567980396864016,-75.43201960313598}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.Sensors.TemperatureTwoPort senTRetProHea(tau = 0,redeclare
      package                                                                       Medium =
        MediumHeating,                                                                                     m_flow_nominal = 1,allowFlowReversal = false) annotation(Placement(transformation(extent = {{46.567980396864016,-24.567980396864016},{57.432019603135984,-35.432019603135984}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput[nTemSen, MediumAir.nX] humAir(each min = 0) "Air humidity" annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},rotation = 180.0,origin = {-204.0,-74.0})));
    .Modelica.Blocks.Interfaces.BooleanInput[nVen] Occ annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {-144.0,-100.0},rotation = 90.0)));
equation
    fanCoilUnit.TMax = TZonSetMax;
    fanCoilUnit.TMin = TZonSetMin;
  for i in 1:nZones loop
    connect(zon[i].T_in, TSensor[i]) annotation (Line(points={{-150,34},{-176,34},{-176,
          -60},{-204,-60}}, color={0,0,127}));
    connect(zon[i].ports[1], fanCoilUnit[i].port_air_a) annotation (Line(points={{-128,29},
            {-130,29},{-130,34},{-114,34},{-114,102},{-73.8,102},{-73.8,96}},
                                                             color={0,127,255}));
    connect(fanCoilUnit[i].port_air_b, zon[i].ports[2]) annotation (Line(points={{-56.9,
            96},{-56,96},{-56,100},{-114,100},{-114,31},{-128,31}},
        color={0,127,255}));

    heatPortRad[i].Q_flow = 0;


    connect(mixingAhuCoo[i].port_b1,portCoo_b[i]) annotation(Line(points = {{65.13477794117637,63.03643333333331},{65.13477794117637,81.51821666666666},{80,81.51821666666666},{80,100}},color = {0,127,255}));
    connect(mixingAhuCoo[i].port_a2,portCoo_a[i]) annotation(Line(points = {{53.13477794117637,63.03643333333331},{53.13477794117637,81.51821666666666},{40,81.51821666666666},{40,100}},color = {0,127,255}));

    connect(portHea_a[i],mixingAhuHea[i].port_a2) annotation(Line(points = {{124,100},{124,85.32662426470587},{137.55261249999992,85.32662426470587},{137.55261249999992,70.65324852941174}},color = {0,127,255}));
    connect(mixingAhuHea[i].port_b1,portHea_b[i]) annotation(Line(points = {{149.55261249999992,70.65324852941174},{149.55261249999992,85.32662426470587},{164,85.32662426470587},{164,100}},color = {0,127,255}));
  end for;

  for i in 1:nZones loop
    connect(heaCol.portsDistRet[i],mixingEmiHea[i].port_b2) annotation(Line(points={{
            -21.3455,7},{-21.3455,13},{-18,13},{-18,20}},                                                                                                 color = {0,127,255}));
    connect(heaCol.portsDistSup[i],mixingEmiHea[i].port_a1) annotation(Line(points={{
            0.909091,7},{0.909091,13},{-6,13},{-6,20}},                                                                                                                               color = {0,127,255}));
    connect(cooCol.portsDistSup[i],mixingEmiCoo[i].port_a1) annotation(Line(points={{-67.353,
            -42},{-67.353,-21},{-68,-21},{-68,0}},                                                                                                                            color = {0,127,255}));
    connect(cooCol.portsDistRet[i],mixingEmiCoo[i].port_b2) annotation(Line(points={{
            -89.6076,-42},{-89.6076,-21},{-80,-21},{-80,0}},                                                                                                                     color = {0,127,255}));
  end for;

  for i in 1:nVen loop
    connect(cooCol.portsDistSup[nZones+i],mixingAhuCoo[i].port_a1) annotation(Line(points = {{-67.35303499390187,-42},{-53.46036213528475,-42},{-53.46036213528475,22.798918421052644},{65.13477794117637,22.798918421052644},{65.13477794117637,43.03643333333331}},color = {0,127,255}));
    connect(cooCol.portsDistRet[nZones+i],mixingAhuCoo[i].port_b2) annotation(Line(points = {{-89.60758044844732,-42},{-89.60758044844732,26},{53.13477794117637,26},{53.13477794117637,43.03643333333331}},color = {0,127,255}));

    connect(heaCol.portsDistSup[nZones+i],mixingAhuHea[i].port_a1) annotation(Line(points={{
            0.909091,7},{26.5295,7},{26.5295,14.3927},{149.553,14.3927},{
            149.553,50.6532}},                                                                                                                                                                                                color = {0,127,255}));
    connect(heaCol.portsDistRet[nZones+i],mixingAhuHea[i].port_b2) annotation(Line(points={{
            -21.3455,7},{-11.0074,7},{-11.0074,17.7638},{137.553,17.7638},{
            137.553,50.6532}},                                                                                                                                                                                                color = {0,127,255}));
end for;
    connect(add.u2,fanCoilUnit.QHea) annotation(Line(points = {{-92.49066615412636,88.75466692293682},{-86.89533307706319,88.75466692293682},{-86.89533307706319,92.36},{-80.3,92.36}},color = {0,0,127}));
    connect(fanCoilUnit.QCoo,add.u1) annotation(Line(points = {{-80.3,89.84},{-86.89533307706319,89.84},{-86.89533307706319,83.24533307706318},{-92.49066615412636,83.24533307706318}},color = {0,0,127}));
    connect(add.y,prescribedHeatFlow.Q_flow) annotation(Line(points = {{-103.05022269205084,86},{-126,86}},color = {0,0,127}));
    connect(prescribedHeatFlow.port,heatPortCon) annotation(Line(points = {{-146,86},{-160,86},{-160,38},{-182,38},{-182,20},{-200,20}},color = {191,0,0}));
    connect(fanCoilUnit.port_coo_b,mixingEmiCoo.port_a2) annotation(Line(points = {{-69.9,68},{-69.9,36},{-80,36},{-80,20}},color = {0,127,255}));
    connect(mixingEmiCoo.port_b1,fanCoilUnit.port_coo_a) annotation(Line(points = {{-68,20},{-68,32},{-64.7,32},{-64.7,68}},color = {0,127,255}));
    connect(mixingEmiCoo.valPos,valPosEmiCoo) annotation(Line(points = {{-64,5.000000000000002},{-64,-16},{-120,-16},{-120,-100}},color = {0,0,127}));
    connect(fanCoilUnit.port_hea_b,mixingEmiHea.port_a2) annotation(Line(points = {{-60.8,68},{-60.8,50},{-18,50},{-18,40}},color = {0,127,255}));
    connect(fanCoilUnit.port_hea_a,mixingEmiHea.port_b1) annotation(Line(points = {{-55.6,68},{-55.6,56},{-6.000000000000002,56},{-6.000000000000002,40}},color = {0,127,255}));
    connect(mixingEmiHea.valPos,valPosEmiHea) annotation(Line(points = {{-1.9999999999999982,25},{26,25},{26,100}},color = {0,0,127}));
    connect(mixingAhuCoo.valPos,valPosAhuCoo) annotation(Line(points = {{69.13477794117637,48.03643333333331},{114,48.03643333333331},{114,20},{206,20}},color = {0,0,127}));
    connect(mixingAhuHea.valPos,valPosAhuHea) annotation(Line(points = {{153.55261249999992,55.65324852941174},{176,55.65324852941174},{176,46},{206,46}},color = {0,0,127}));
    connect(senTSupProCoo.port_b,cooCol.portsProdSup[1]) annotation(Line(points = {{-33.432019603135984,-48},{-46.13106295149639,-48},{-46.13106295149639,-51.12},{-54.26212590299278,-51.12}},color = {0,127,255}));
    connect(senTSupProHea.port_b,heaCol.portsProdSup[1]) annotation(Line(points = {{29.178640990288162,-2},{19,-2},{19,-2.119999999999999},{14,-2.119999999999999}},color = {0,127,255}));
    connect(pumHea.port_b,preDroProHea.port_a) annotation(Line(points = {{95.71914756294473,-30},{132,-30},{132,-2},{95.19929311378094,-2}},color = {0,127,255}));
    connect(pumCoo.port_b,preDroProCoo.port_a) annotation(Line(points = {{-2.666629170228588,-70},{28.80070688621906,-70}},color = {0,127,255}));
    connect(mixingAhuHea.TSup,TSupAhuHea) annotation(Line(points = {{154.55261249999992,67.65324852941174},{188,67.65324852941174},{188,110}},color = {0,0,127}));
    connect(mixingAhuCoo.TSup,TSupAhuCoo) annotation(Line(points = {{70.13477794117637,60.03643333333331},{100,60.03643333333331},{100,110}},color = {0,0,127}));
    connect(bouHea.ports[1],pumHea.port_b) annotation(Line(points = {{118,-36.586218333515205},{118,-30},{95.71914756294473,-30}},color = {0,127,255}));
    connect(bouCoo.ports[1],pumCoo.port_b) annotation(Line(points = {{50,-86.42687848206917},{50,-82},{16,-82},{16,-70},{-2.666629170228588,-70}},color = {0,127,255}));
    connect(mixingEmiCoo.TSup,TSupEmiCoo) annotation(Line(points = {{-63,17.000000000000004},{-38,17.000000000000004},{-38,110}},color = {0,0,127}));
    connect(mixingEmiHea.TSup,TSupEmiHea) annotation(Line(points = {{-1.0000000000000018,37},{-1.0000000000000018,80},{-10,80},{-10,110}},color = {0,0,127}));
    connect(prfEmiHea,mixingEmiHea.prfPum) annotation(Line(points = {{10,100},{10,29.000000000000004},{-2,29.000000000000004}},color = {255,127,0}));
    connect(prfAhuHea,mixingAhuHea.prfPum) annotation(Line(points = {{206,60},{179.77630624999995,60},{179.77630624999995,59.65324852941174},{153.55261249999992,59.65324852941174}},color = {255,127,0}));
    connect(prfAhuCoo,mixingAhuCoo.prfPum) annotation(Line(points = {{206,32},{120,32},{120,52.03643333333331},{69.13477794117637,52.03643333333331}},color = {255,127,0}));
    connect(prfProHea,pumHea.stage) annotation(Line(points = {{90,-100},{90,-36.86297707553367}},color = {255,127,0}));
    connect(prfProCoo,pumCoo.stage) annotation(Line(points = {{-54,-104},{-54,-90.20002249786285},{-8,-90.20002249786285},{-8,-76.4000449957257}},color = {255,127,0}));
    connect(prfEmiCoo,mixingEmiCoo.prfPum) annotation(Line(points = {{-106,-100},{-106,-24},{-58,-24},{-58,9.000000000000002},{-64,9.000000000000002}},color = {255,127,0}));
    connect(senTRetProCoo.port_a,cooCol.portsProdRet[1]) annotation(Line(points = {{-39.432019603135984,-70},{-46.84707275306438,-70},{-46.84707275306438,-70.12},{-54.26212590299278,-70.12}},color = {0,127,255}));
    connect(senTRetProCoo.port_b,pumCoo.port_a) annotation(Line(points = {{-28.567980396864016,-70},{-13.333370829771411,-70}},color = {0,127,255}));
    connect(heaCol.portsProdRet[1],senTRetProHea.port_a) annotation(Line(points = {{14,-21.119999999999997},{28.283990198432008,-21.119999999999997},{28.283990198432008,-30},{46.567980396864016,-30}},color = {0,127,255}));
    connect(senTRetProHea.port_b,pumHea.port_a) annotation(Line(points = {{57.432019603135984,-30},{84.28085243705527,-30}},color = {0,127,255}));
    connect(humAir[1, :],zon[1].X_in) annotation(Line(points = {{-204,-74},{-170,-74},{-170,26},{-150,26}},color = {0,0,127}));
    connect(humAir[2, :],zon[2].X_in);
    connect(prfEmiCoo,fanCoilUnit.prfEmiCoo) annotation(Line(points = {{-106,-100},{-92.5,-100},{-92.5,76.96},{-79,76.96}},color = {255,127,0}));
    connect(prfEmiHea,fanCoilUnit.prfEmiHea) annotation(Line(points = {{10,100},{10,106},{-85,106},{-85,79.76},{-79,79.76}},color = {255,127,0}));
    connect(Occ,fanCoilUnit.Occ) annotation(Line(points = {{-144,-100},{-144,82.56},{-79,82.56}},color = {255,0,255}));
    connect(TSupProHea,heapro.TSet) annotation(Line(points = {{200,-30},{136,-30},{136,5.999999999999998},{75,5.999999999999998}},color = {0,0,127}));
    connect(heapro.port_b,senTSupProHea.port_a) annotation(Line(points = {{54,-1.9999999999999987},{38.821359009711834,-1.9999999999999987},{38.821359009711834,-2}},color = {0,127,255}));
    connect(preDroProHea.port_b,heapro.port_a) annotation(Line(points = {{84.80070688621906,-2},{74,-2.0000000000000013}},color = {0,127,255}));
    connect(coopro.port_b,senTSupProCoo.port_a) annotation(Line(points = {{0,-48},{-22.567980396864016,-48}},color = {0,127,255}));
    connect(coopro.port_a,preDroProCoo.port_b) annotation(Line(points = {{20,-48},{58,-48},{58,-70},{39.19929311378094,-70}},color = {0,127,255}));
    connect(TSupProCoo,coopro.TSet) annotation(Line(points = {{200,-50},{172,-50},{172,-64},{78,-64},{78,-40},{21,-40}},color = {0,0,127}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnits;
