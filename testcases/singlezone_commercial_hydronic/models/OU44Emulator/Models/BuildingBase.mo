within OU44Emulator.Models;
partial model BuildingBase "Single-zone whole building model"
package Water = Buildings.Media.Water;
package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"});
final parameter Modelica.Units.SI.Area AFlo=8500 "Floor area";
final parameter Modelica.Units.SI.Length hRoo=3.2 "Average room height";
final parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_water_coil=3
  "Nominal mass flow rate for water in coil";
final parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_water_rad=4
  "Nominal mass flow rate for water radiator";
final parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_air=31
  "Nominal mass flow rate for air system";

  SubModels.AirHandlingUnit ahu(
    coil(dp2_nominal=0),
    redeclare package Air = Air,
    m_flow_nominal=m_flow_nominal_air,
    m2_flow_nominal=m_flow_nominal_water_coil,
    redeclare package Water = Water)
                         "Air handling unit"
    annotation (Placement(transformation(extent={{-152,34},{-120,54}})));
  Buildings.ThermalZones.Detailed.MixedAir ou44Bdg(
    nConPar=1,
    nSurBou=0,
    nConBou=2,
    datConPar(
      layers={intWall},
      A={AFlo/20*(4+4+5)*hRoo},
      til={Buildings.Types.Tilt.Wall}),
    datConBou(
      layers={floor,extWall},
      A={87*29,3.97*87*2 + 3.97*29*2},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall},
      each azi=Buildings.Types.Azimuth.S,
      each stateAtSurface_a=false),
    datConExt(
      layers={roof},
      A={87*29},
      til={Buildings.Types.Tilt.Ceiling},
      azi={Buildings.Types.Azimuth.W}),
    nConExt=1,
    nConExtWin=4,
    redeclare package Medium = Air,
    AFlo=AFlo,
    hRoo=hRoo,
    datConExtWin(
      each layers=extWall,
      A={29*13,87*13,29*13,87*13},
      each glaSys=glaSys,
      hWin={11.9,2.4*3,11.9,2.4*3},
      wWin={16.8,70,16.8,70},
      each til=Buildings.Types.Tilt.Wall,
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.S,
          Buildings.Types.Azimuth.E}),
    use_C_flow=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    mSenFac=5,
    nPorts=5,
    C_start={0.00064},
    linearizeRadiation=true)
    annotation (Placement(transformation(extent={{-18,36},{22,76}})));
parameter Buildings.HeatTransfer.Data.GlazingSystems.TripleClearAir13ClearAir13Clear
  glaSys(haveExteriorShade=true, shade=blinds)
         annotation (Placement(transformation(extent={{204,166},{224,186}})));
parameter Buildings.HeatTransfer.Data.Solids.Generic insulation(
  x=0.27,
  k=0.04,
  c=1000,
  d=50)
  annotation (Placement(transformation(extent={{90,166},{110,186}})));
final parameter Buildings.HeatTransfer.Data.Solids.Concrete concrete(x=0.2)
  annotation (Placement(transformation(extent={{120,166},{140,186}})));
parameter Buildings.HeatTransfer.Data.Solids.Generic lightPartition(
  c=1000,
  k=0.5,
  x=0.15,
  d=250)
  annotation (Placement(transformation(extent={{64,166},{84,186}})));
parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic extWall(
  nLay=2,
  material={insulation,concrete},
  roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium)
  annotation (Placement(transformation(extent={{148,192},{168,212}})));
parameter Buildings.HeatTransfer.Data.Solids.Generic insulationRoof(
  k=0.04,
  c=1000,
  x=0.52,
  d=50)
  annotation (Placement(transformation(extent={{92,192},{112,212}})));
parameter Buildings.HeatTransfer.Data.Solids.Concrete concreteRoof(x=0.27)
  annotation (Placement(transformation(extent={{120,192},{140,212}})));
parameter Buildings.HeatTransfer.Data.Solids.Concrete concreteFloor(x=0.2)
  annotation (Placement(transformation(extent={{64,192},{84,212}})));
parameter Buildings.HeatTransfer.Data.Shades.Generic blinds(
  tauSol_a=0.05,
  tauSol_b=0.05,
  rhoSol_a=0.5,
  rhoSol_b=0.5,
  absIR_a=0.5,
  absIR_b=0.5,
  tauIR_a=0,
  tauIR_b=0)
  annotation (Placement(transformation(extent={{204,192},{224,212}})));
Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://OU44Emulator/Resources/Climate/DNK_Copenhagen.061800_IWEC.mos"))
  annotation (Placement(transformation(extent={{238,138},{218,158}})));
Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
      transformation(extent={{18,70},{58,110}}),iconTransformation(extent={{-160,
          110},{-140,130}})));
Modelica.Blocks.Math.MatrixGain matrixGain(K=[0.4; 0.4; 0.2])
  "Splits heat gains into radiant, convective and latent"
  annotation (Placement(transformation(extent={{-66,136},{-50,152}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tFloorGround
  annotation (Placement(transformation(extent={{42,8},{22,28}})));
Modelica.Blocks.Sources.Constant groundTemp(k=283.15)
    annotation (Placement(transformation(extent={{76,8},{56,28}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tWallGround
  annotation (Placement(transformation(extent={{40,-28},{20,-8}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Ti
  annotation (Placement(transformation(extent={{34,46},{54,66}})));
SubModels.DistrictHeating2 dh(
                             m_flow_nominal=m_flow_nominal_water_coil +
        m_flow_nominal_water_rad, m_flow_nominal_dh=m_flow_nominal_water_coil
         + m_flow_nominal_water_rad)
    annotation (Placement(transformation(extent={{-142,-212},{-122,-192}})));
Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
  redeclare package Medium = Water,
    allowFlowReversal=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    Q_flow_nominal=40*AFlo,
    dp_nominal=0,
    T_start=293.15,
    T_a_nominal=328.15,
    T_b_nominal=308.15)
  annotation (Placement(transformation(extent={{8,-90},{28,-70}})));
Buildings.Fluid.Actuators.Valves.TwoWayLinear   valRad(
  redeclare package Medium = Water,
    allowFlowReversal=false,
  CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=m_flow_nominal_water_rad,
    dpValve_nominal=5000,
    y_start=0,
    dpFixed_nominal=34000)
  annotation (Placement(transformation(extent={{-2,-130},{-22,-110}})));
Buildings.Fluid.Sensors.TemperatureTwoPort tRadIn(redeclare package Medium =
      Water,
    m_flow_nominal=m_flow_nominal_water_rad,
    allowFlowReversal=false)
  annotation (Placement(transformation(extent={{-20,-92},{0,-72}})));
Buildings.Fluid.Sensors.TemperatureTwoPort tRadOut(redeclare package Medium =
      Water,
    m_flow_nominal=m_flow_nominal_water_rad,
    allowFlowReversal=false)
  annotation (Placement(transformation(extent={{30,-130},{10,-110}})));
SubModels.Infiltration
             infiltration(
  redeclare package Air = Air,
  Vi=AFlo*hRoo,
    ach=0.2)
            annotation (Placement(transformation(extent={{-80,14},{-60,34}})));
Buildings.Fluid.FixedResistances.Junction jun2(
  redeclare package Medium = Water,
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal={m_flow_nominal_water_coil + m_flow_nominal_water_rad,-
        m_flow_nominal_water_coil,-m_flow_nominal_water_rad},
    dp_nominal={0,0,0})
                      annotation (Placement(transformation(
      extent={{10,10},{-10,-10}},
      rotation=-90,
      origin={-126,-96})));
Buildings.Fluid.FixedResistances.Junction jun3(
  redeclare package Medium = Water,
    dp_nominal={0,0,0},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal={m_flow_nominal_water_coil,-(m_flow_nominal_water_coil +
        m_flow_nominal_water_rad),m_flow_nominal_water_rad})
  annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=-90,
      origin={-148,-108})));
SubModels.EnergyMeter
            energyMeterAhu(m_flow_nominal=m_flow_nominal_water_coil,
                                                                redeclare
      package Water=Water) annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-134,-66})));
SubModels.EnergyMeter
            energyMeterRad(m_flow_nominal=m_flow_nominal_water_rad,
                                                                redeclare
      package Water=Water) annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=0,
      origin={-96,-102})));
Buildings.Fluid.Actuators.Valves.TwoWayLinear   valCoil(
  redeclare package Medium = Water,
    allowFlowReversal=false,
  CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=m_flow_nominal_water_coil,
    dpValve_nominal=5000,
    y_start=0,
    dpFixed_nominal=29000)
                     annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=270,
      origin={-152,18})));
Modelica.Blocks.Math.Gain metHeat(k=120/AFlo)
  "Metabolic heat generation per person (sensible and latent)"
  annotation (Placement(transformation(extent={{-104,136},{-88,152}})));
  parameter Buildings.HeatTransfer.Data.Solids.Generic insulationFloor(
  k=0.04,
  c=1000,
  x=0.15,
  d=50) annotation (Placement(transformation(extent={{36,192},{56,212}})));
  Modelica.Blocks.Math.Gain scale_factor(k=4)
    "scale factor for CO2 concentration "
    annotation (Placement(transformation(extent={{-64,104},{-48,120}})));
  Buildings.Fluid.Sensors.PPM senCO2(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{-54,58},{-74,78}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemOut(redeclare package Medium
      = Air, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-48,8},{-28,28}})));
  Modelica.Blocks.Math.Gain gaiCO2(k=8.18E-6) "CO2 emission per person"
    annotation (Placement(transformation(extent={{-106,104},{-90,120}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic floor(nLay=2,
      material={insulationFloor,concreteFloor},
    roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium)
    annotation (Placement(transformation(extent={{148,164},{168,184}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic roof(
    nLay=2,
    material={insulationRoof,concreteRoof},
    roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium)
    annotation (Placement(transformation(extent={{176,192},{196,212}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic intWall(
      material={lightPartition}, nLay=1,
    roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium)
    annotation (Placement(transformation(extent={{178,166},{198,186}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemCoiRet(redeclare package
      Medium = Buildings.Media.Water,
    allowFlowReversal=false,          m_flow_nominal=m_flow_nominal_water_coil)
    "Sensor for AHU heating coil return water temperature" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-152,-18})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal_water_coil/1000,
    dp_nominal=20000)
    annotation (Placement(transformation(extent={{-140,-10},{-148,8}})));
  Buildings.Fluid.FixedResistances.Pipe pipSupCoil(
    redeclare package Medium = Buildings.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=m_flow_nominal_water_coil,
    dp_nominal=0,
    nSeg=3,
    thicknessIns=0.03,
    lambdaIns=0.04,
    length=50,
    v_nominal=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-126,-42})));
  Buildings.Fluid.FixedResistances.Pipe pipRetCoil(
    redeclare package Medium = Buildings.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=m_flow_nominal_water_coil,
    dp_nominal=0,
    nSeg=3,
    thicknessIns=0.03,
    lambdaIns=0.04,
    length=50,
    v_nominal=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-152,-42})));
  Buildings.Fluid.FixedResistances.Pipe pipSupRad(
    redeclare package Medium = Buildings.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=m_flow_nominal_water_rad,
    dp_nominal=0,
    nSeg=3,
    thicknessIns=0.03,
    lambdaIns=0.04,
    length=100,
    v_nominal=0.7) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-48,-96})));
  Buildings.Fluid.FixedResistances.Pipe pipRetRad(
    redeclare package Medium = Buildings.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=m_flow_nominal_water_rad,
    dp_nominal=0,
    nSeg=3,
    thicknessIns=0.03,
    lambdaIns=0.04,
    length=100,
    v_nominal=0.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-48,-120})));
Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tPipHeaLoss(T(
        displayUnit="K") = 293.15) "Temperature exposed to pipes"
    annotation (Placement(transformation(extent={{-58,-52},{-78,-32}})));
  Buildings.Utilities.IO.SignalExchange.Read reaQHea(
    description="District heating thermal power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.DistrictHeatingPower,
    y(unit="W")) "Read heating thermal power consumption "
    annotation (Placement(transformation(extent={{-194,-160},{-212,-142}})));

  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta "Weather station"
    annotation (Placement(transformation(extent={{80,122},{100,142}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPPum(
    y(unit="W"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    description="Electrical power consumption of pump")
    "Read electrical power consumption of distribution system pump"
    annotation (Placement(transformation(extent={{-200,-184},{-216,-168}})));

  Buildings.Utilities.IO.SignalExchange.Read reaCO2Zon(
    description="Zone CO2 concentration",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm")) "Read CO2 concentration"
    annotation (Placement(transformation(extent={{-202,52},{-216,66}})));

  Modelica.Blocks.Sources.CombiTimeTable occupancy(
    tableOnFile=false,
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-182,120},{-162,140}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTZon(
    description="Zone air temperature",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K")) "Read zone air temperature"
    annotation (Placement(transformation(extent={{66,50},{78,62}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTCoiRet(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="AHU heating coil return water temperature")
    "Read heating coil return water temperature" annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-234,-18})));

Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Water,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal={m_flow_nominal_water_coil,-m_flow_nominal_water_coil,-
        m_flow_nominal_water_coil/1000},
    dp_nominal={0,0,0})
                      annotation (Placement(transformation(
      extent={{8,-8},{-8,8}},
      rotation=-90,
      origin={-126,0})));
Buildings.Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = Water,
    dp_nominal={0,0,0},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal={m_flow_nominal_water_coil,-m_flow_nominal_water_coil,
        m_flow_nominal_water_coil/1000})
  annotation (Placement(transformation(
      extent={{-8,8},{8,-8}},
      rotation=-90,
      origin={-162,-2})));
  Modelica.Blocks.Math.Gain gaiOcc(k=0.8)
    "Gain factor for occupancy measurements"
    annotation (Placement(transformation(extent={{-146,122},{-130,138}})));
equation
connect(weaBus, ou44Bdg.weaBus) annotation (Line(
    points={{38,90},{38,73.9},{19.9,73.9}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
connect(matrixGain.y, ou44Bdg.qGai_flow) annotation (Line(points={{-49.2,144},{
          -36,144},{-36,64},{-19.6,64}},
                                   color={0,0,127}));
connect(weaBus, weaDat.weaBus) annotation (Line(
    points={{38,90},{38,148},{218,148}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
connect(tFloorGround.port, ou44Bdg.surf_conBou[1])
  annotation (Line(points={{22,18},{8,18},{8,39.75}},     color={191,0,0}));
  connect(groundTemp.y, tFloorGround.T)
    annotation (Line(points={{55,18},{44,18}}, color={0,0,127}));
connect(tWallGround.port, ou44Bdg.surf_conBou[2]) annotation (Line(points={{20,-18},
          {8,-18},{8,40.25}},           color={191,0,0}));
connect(Ti.port, ou44Bdg.heaPorAir) annotation (Line(points={{34,56},{1,56}},
                            color={191,0,0}));
connect(rad.heatPortRad, ou44Bdg.heaPorRad) annotation (Line(points={{20,-72.8},
          {20,-30},{1,-30},{1,52.2}},        color={191,0,0}));
connect(rad.heatPortCon, ou44Bdg.heaPorAir)
  annotation (Line(points={{16,-72.8},{16,34},{34,34},{34,56},{1,56}},
                                                       color={191,0,0}));
connect(tRadIn.port_b, rad.port_a)
  annotation (Line(points={{0,-82},{4,-82},{4,-80},{8,-80}},
                                                 color={0,127,255}));
connect(weaBus, infiltration.weaBus) annotation (Line(
    points={{38,90},{-162,90},{-162,30},{-81.6,30}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(ahu.weaBus, weaBus) annotation (Line(
      points={{-155,55.4},{-162,55.4},{-162,90},{38,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
connect(jun2.port_2, energyMeterAhu.port_a)
  annotation (Line(points={{-126,-86},{-126,-76},{-128,-76}},
                                                   color={0,127,255}));
connect(energyMeterAhu.port_b2, jun3.port_1) annotation (Line(points={{-140,-76},
          {-140,-80},{-148,-80},{-148,-98}},
                                           color={0,127,255}));
connect(jun2.port_3, energyMeterRad.port_a) annotation (Line(points={{-116,-96},
          {-106,-96}},                     color={0,127,255}));
connect(energyMeterRad.port_b2, jun3.port_3)
  annotation (Line(points={{-106,-108},{-138,-108}}, color={0,127,255}));
connect(matrixGain.u[1], metHeat.y)
  annotation (Line(points={{-67.6,144},{-87.2,144}},
                                                 color={0,0,127}));
  connect(scale_factor.y, ou44Bdg.C_flow[1]) annotation (Line(points={{-47.2,
          112},{-42,112},{-42,58.8},{-19.6,58.8}},
                                              color={0,0,127}));
  connect(infiltration.port_a, ou44Bdg.ports[1]) annotation (Line(points={{-60,30},
          {-16,30},{-16,44.4},{-13,44.4}}, color={0,127,255}));
  connect(ahu.port_b1, ou44Bdg.ports[2]) annotation (Line(points={{-120,40},{
          -66,40},{-66,45.2},{-13,45.2}},
                                      color={0,127,255}));
  connect(ahu.port_a1, ou44Bdg.ports[3]) annotation (Line(points={{-120,48},{
          -66,48},{-66,46},{-13,46}},
                                  color={0,127,255}));
  connect(senCO2.port, ou44Bdg.ports[4]) annotation (Line(points={{-64,58},{-64,
          46.8},{-13,46.8}}, color={0,127,255}));
  connect(infiltration.port_b, senTemOut.port_a) annotation (Line(points={{-60,18},
          {-48,18}},                       color={0,127,255}));
  connect(senTemOut.port_b, ou44Bdg.ports[5]) annotation (Line(points={{-28,18},
          {-26,18},{-26,47.6},{-13,47.6}}, color={0,127,255}));
  connect(gaiCO2.y, scale_factor.u)
    annotation (Line(points={{-89.2,112},{-65.6,112}},
                                                   color={0,0,127}));
  connect(rad.port_b, tRadOut.port_a) annotation (Line(points={{28,-80},{38,-80},
          {38,-120},{30,-120}},  color={0,127,255}));
  connect(ahu.port_b2, valCoil.port_a) annotation (Line(points={{-132,34},{-132,
          32},{-142,32},{-142,28},{-152,28}}, color={0,127,255}));
  connect(valRad.port_a, tRadOut.port_b)
    annotation (Line(points={{-2,-120},{10,-120}},   color={0,127,255}));
  connect(energyMeterAhu.port_b, pipSupCoil.port_a)
    annotation (Line(points={{-128,-56},{-128,-52},{-126,-52}},
                                                     color={0,127,255}));
  connect(senTemCoiRet.port_b, pipRetCoil.port_a)
    annotation (Line(points={{-152,-28},{-152,-32}}, color={0,127,255}));
  connect(pipRetCoil.port_b, energyMeterAhu.port_a2) annotation (Line(points={{
          -152,-52},{-148,-52},{-148,-56},{-140,-56}}, color={0,127,255}));
  connect(energyMeterRad.port_b, pipSupRad.port_a)
    annotation (Line(points={{-86,-96},{-58,-96}}, color={0,127,255}));
  connect(pipSupRad.port_b, tRadIn.port_a) annotation (Line(points={{-38,-96},{
          -26,-96},{-26,-82},{-20,-82}}, color={0,127,255}));
  connect(valRad.port_b, pipRetRad.port_a)
    annotation (Line(points={{-22,-120},{-38,-120}}, color={0,127,255}));
  connect(pipRetRad.port_b, energyMeterRad.port_a2) annotation (Line(points={{
          -58,-120},{-78,-120},{-78,-108},{-86,-108}}, color={0,127,255}));
  connect(tPipHeaLoss.port, pipSupCoil.heatPort)
    annotation (Line(points={{-78,-42},{-131,-42}}, color={191,0,0}));
  connect(tPipHeaLoss.port, pipRetCoil.heatPort)
    annotation (Line(points={{-78,-42},{-147,-42}}, color={191,0,0}));
  connect(tPipHeaLoss.port, pipSupRad.heatPort) annotation (Line(points={{-78,
          -42},{-82,-42},{-82,-66},{-48,-66},{-48,-101}}, color={191,0,0}));
  connect(tPipHeaLoss.port, pipRetRad.heatPort) annotation (Line(points={{-78,
          -42},{-82,-42},{-82,-66},{-48,-66},{-48,-125}}, color={191,0,0}));
  connect(dh.weaBus, weaBus) annotation (Line(
      points={{-123.4,-193},{222,-193},{222,90},{38,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dh.qdh, reaQHea.u) annotation (Line(points={{-121.2,-207},{-84,-207},
          {-84,-151},{-192.2,-151}}, color={0,0,127}));
  connect(dh.port_b, jun2.port_1)
    annotation (Line(points={{-126,-192},{-126,-106}}, color={0,127,255}));
  connect(jun3.port_2, dh.port_a) annotation (Line(points={{-148,-118},{-148,-186},
          {-138,-186},{-138,-192}}, color={0,127,255}));
  connect(groundTemp.y, tWallGround.T) annotation (Line(points={{55,18},{50,18},
          {50,-18},{42,-18}}, color={0,0,127}));
  connect(weaSta.weaBus, weaBus) annotation (Line(
      points={{80.1,131.9},{80.1,130},{38,130},{38,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dh.qel, reaPPum.u) annotation (Line(points={{-121.4,-196},{-108,-196},
          {-108,-176},{-198.4,-176}}, color={0,0,127}));
  connect(senCO2.ppm,reaCO2Zon. u) annotation (Line(points={{-75,68},{-182,68},
          {-182,59},{-200.6,59}},
                                color={0,0,127}));
  connect(reaTZon.u, Ti.T)
    annotation (Line(points={{64.8,56},{55,56}}, color={0,0,127}));
  connect(senTemCoiRet.T,reaTCoiRet. u)
    annotation (Line(points={{-163,-18},{-226.8,-18}}, color={0,0,127}));
  connect(jun1.port_3, res.port_a) annotation (Line(points={{-134,0},{-140,0},{
          -140,-1}},                     color={0,127,255}));
  connect(jun1.port_1, pipSupCoil.port_b)
    annotation (Line(points={{-126,-8},{-126,-32}}, color={0,127,255}));
  connect(jun1.port_2, ahu.port_a2)
    annotation (Line(points={{-126,8},{-126,34}}, color={0,127,255}));
  connect(jun4.port_1, valCoil.port_b) annotation (Line(points={{-162,6},{-158,
          6},{-158,8},{-152,8}}, color={0,127,255}));
  connect(jun4.port_2, senTemCoiRet.port_a) annotation (Line(points={{-162,-10},
          {-158,-10},{-158,-8},{-152,-8}}, color={0,127,255}));
  connect(jun4.port_3, res.port_b) annotation (Line(points={{-154,-2},{-152,-2},
          {-152,-1},{-148,-1}}, color={0,127,255}));
  connect(occupancy.y[1], gaiOcc.u)
    annotation (Line(points={{-161,130},{-147.6,130}}, color={0,0,127}));
  connect(gaiOcc.y, metHeat.u) annotation (Line(points={{-129.2,130},{-110,130},
          {-110,144},{-105.6,144}}, color={0,0,127}));
  connect(gaiOcc.y, gaiCO2.u) annotation (Line(points={{-129.2,130},{-112,130},
          {-112,112},{-107.6,112}}, color={0,0,127}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-240},
            {240,220}}),     graphics={Bitmap(
        extent={{-160,-162},{178,180}}, fileName=
              "modelica://OU44Emulator/Resources/Images/ou44.jpg")}),
                                                               Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-240,-240},{240,220}})),
  experiment(StopTime=259200),
    Documentation(revisions="<html>
<ul>
<li>
May 30, 2025, by Ettore Zanetti:<br/>
Updated model to use Modelica 4.0 and Buildings 12.1.0.
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/422>
BOPTEST issue #422</a>.
</li>
</ul>
</html>"));
end BuildingBase;
