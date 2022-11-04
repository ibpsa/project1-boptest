within MultiZoneLargeOfficeEPlus.Testcases.BaseClasses;
model whoBui96 "EnergyPlus FMU for Model Exchange"
  import Buildings;
  parameter Real _Temp1_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp2_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp3_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp4_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp5_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp1_top_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp2_top_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp3_top_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp4_top_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp5_top_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp1_bot_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp2_bot_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp3_bot_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp4_bot_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  parameter Real _Temp5_bot_start = 23.9 + 273.15
  annotation (Dialog( group="Start values for inputs "));
  final parameter String ZonLisName[5]={"core zone","south zone","east zone","north zone","west zone"};

  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource("modelica://MultiZoneLargeOfficeEPlus/Testcases/Resources/idf/wholebuilding96_nogroheatra.idf"),
    epwName=Modelica.Utilities.Files.loadResource("modelica://MultiZoneLargeOfficeEPlus/Testcases/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource("modelica://MultiZoneLargeOfficeEPlus/Testcases/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    computeWetBulbTemperature=true,
    usePrecompiledFMU=false) "Building model"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

  Buildings.ThermalZones.EnergyPlus_9_6_0.BaseClasses.ThermalZoneAdapter
    fmuZonTopFlr[5](
    each final modelicaNameBuilding=building.modelicaNameBuilding,
    each final spawnExe=building.spawnExe,
    each final idfVersion=building.idfVersion,
    each final idfName=building.idfName,
    each final epwName=building.epwName,
    each final relativeSurfaceTolerance=building.relativeSurfaceTolerance,
    final zoneName={"Core_top","Perimeter_top_ZN_1","Perimeter_top_ZN_2","Perimeter_top_ZN_3",
        "Perimeter_top_ZN_4"},
    each usePrecompiledFMU=false,
    each logLevel=building.logLevel,
    each final nFluPor=2) "Adapter to EnergyPlus"
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.RealExpression X_w[5](
    each y=0)
    "Zone absolute humidity"
    annotation (Placement(transformation(extent={{-88,44},{-68,64}})));
  Modelica.Blocks.Sources.RealExpression mIn_flow[5](
    each y=0)
    "Inlet mass flow rate"
    annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
  Modelica.Blocks.Math.Gain mOut_flow[5](
    each k=-1)
    "Outlet mass flow rate"
    annotation (Placement(transformation(extent={{-34,10},{-14,30}})));
  Modelica.Blocks.Sources.RealExpression TIn[2](
    each y=293.15) "Inlet temperature"
    annotation (Placement(transformation(extent={{-64,-30},{-44,-10}})));
  Modelica.Blocks.Sources.RealExpression QGaiRad_flow[5](
    each y=0)
    "Radiative heat gain for the zone"
    annotation (Placement(transformation(extent={{-64,-46},{-44,-26}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.BaseClasses.ThermalZoneAdapter
    fmuZonMidFlr[5](
    each final modelicaNameBuilding=building.modelicaNameBuilding,
    each final spawnExe=building.spawnExe,
    each final idfVersion=building.idfVersion,
    each final idfName=building.idfName,
    each final epwName=building.epwName,
    each final relativeSurfaceTolerance=building.relativeSurfaceTolerance,
    final zoneName={"Core_mid","Perimeter_mid_ZN_1","Perimeter_mid_ZN_2","Perimeter_mid_ZN_3",
        "Perimeter_mid_ZN_4"},
    each usePrecompiledFMU=false,
    each logLevel=building.logLevel,
    each final nFluPor=2) "Adapter to EnergyPlus"
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.BaseClasses.ThermalZoneAdapter
    fmuZonBotFlr[5](
    each final modelicaNameBuilding=building.modelicaNameBuilding,
    each final spawnExe=building.spawnExe,
    each final idfVersion=building.idfVersion,
    each final idfName=building.idfName,
    each final epwName=building.epwName,
    each final relativeSurfaceTolerance=building.relativeSurfaceTolerance,
    final zoneName={"Core_bot","Perimeter_bot_ZN_1","Perimeter_bot_ZN_2","Perimeter_bot_ZN_3",
        "Perimeter_bot_ZN_4"},
    each usePrecompiledFMU=false,
    each logLevel=building.logLevel,
    each final nFluPor=2) "Adapter to EnergyPlus"
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));

  Modelica.Blocks.Interfaces.RealInput Temp1(start=_Temp1_start)   "IDF line 6256"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp2(start=_Temp2_start)   "IDF line 6262"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp3(start=_Temp3_start)   "IDF line 6268"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp4(start=_Temp4_start)   "IDF line 6274"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp5(start=_Temp5_start)   "IDF line 6280"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp1_top(start=_Temp1_top_start)   "IDF line 6286"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp2_top(start=_Temp2_top_start)   "IDF line 6292"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp3_top(start=_Temp3_top_start)   "IDF line 6298"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp4_top(start=_Temp4_top_start)   "IDF line 6304"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp5_top(start=_Temp5_top_start)   "IDF line 6310"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp1_bot(start=_Temp1_bot_start)   "IDF line 6316"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp2_bot(start=_Temp2_bot_start)   "IDF line 6322"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp3_bot(start=_Temp3_bot_start)   "IDF line 6328"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp4_bot(start=_Temp4_bot_start)   "IDF line 6334"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Temp5_bot(start=_Temp5_bot_start)   "IDF line 6340"
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealOutput Occ(unit="1") "IDF line 5933"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_Sensible_COOLING_LOAD(unit="W") "IDF line 5938"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_Latent_COOLING_LOAD(unit="W") "IDF line 5943"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_HEATING_LOAD(unit="W") "IDF line 5948"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_top_Sensible_COOLING_LOAD(unit="W") "IDF line 5953"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_top_Latent_COOLING_LOAD(unit="W") "IDF line 5958"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_top_HEATING_LOAD(unit="W") "IDF line 5963"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_bot_Sensible_COOLING_LOAD(unit="W") "IDF line 5968"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_bot_Latent_COOLING_LOAD(unit="W") "IDF line 5973"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_bot_HEATING_LOAD(unit="W") "IDF line 5978"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_Sensible_COOLING_LOAD(unit="W") "IDF line 5983"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_Latent_COOLING_LOAD(unit="W") "IDF line 5988"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_HEATING_LOAD(unit="W") "IDF line 5993"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_top_Sensible_COOLING_LOAD(unit="W") "IDF line 5998"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_top_Latent_COOLING_LOAD(unit="W") "IDF line 6003"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_top_HEATING_LOAD(unit="W") "IDF line 6008"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_bot_Sensible_COOLING_LOAD(unit="W") "IDF line 6013"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_bot_Latent_COOLING_LOAD(unit="W") "IDF line 6018"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_bot_HEATING_LOAD(unit="W") "IDF line 6023"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_Sensible_COOLING_LOAD(unit="W") "IDF line 6028"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_Latent_COOLING_LOAD(unit="W") "IDF line 6033"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_HEATING_LOAD(unit="W") "IDF line 6038"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_top_Sensible_COOLING_LOAD(unit="W") "IDF line 6043"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_top_Latent_COOLING_LOAD(unit="W") "IDF line 6048"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_top_HEATING_LOAD(unit="W") "IDF line 6053"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_bot_Sensible_COOLING_LOAD(unit="W") "IDF line 6058"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_bot_Latent_COOLING_LOAD(unit="W") "IDF line 6063"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_bot_HEATING_LOAD(unit="W") "IDF line 6068"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_Sensible_COOLING_LOAD(unit="W") "IDF line 6073"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_Latent_COOLING_LOAD(unit="W") "IDF line 6078"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_HEATING_LOAD(unit="W") "IDF line 6083"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_top_Sensible_COOLING_LOAD(unit="W") "IDF line 6088"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_top_Latent_COOLING_LOAD(unit="W") "IDF line 6093"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_top_HEATING_LOAD(unit="W") "IDF line 6098"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_bot_Sensible_COOLING_LOAD(unit="W") "IDF line 6103"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_bot_Latent_COOLING_LOAD(unit="W") "IDF line 6108"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_bot_HEATING_LOAD(unit="W") "IDF line 6113"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_Sensible_COOLING_LOAD(unit="W") "IDF line 6118"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_Latent_COOLING_LOAD(unit="W") "IDF line 6123"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_HEATING_LOAD(unit="W") "IDF line 6128"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_top_Sensible_COOLING_LOAD(unit="W") "IDF line 6133"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_top_Latent_COOLING_LOAD(unit="W") "IDF line 6138"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_top_HEATING_LOAD(unit="W") "IDF line 6143"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_bot_Sensible_COOLING_LOAD(unit="W") "IDF line 6148"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_bot_Latent_COOLING_LOAD(unit="W") "IDF line 6153"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_bot_HEATING_LOAD(unit="W") "IDF line 6158"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_People(unit="1") "IDF line 6163"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_People(unit="1") "IDF line 6168"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_People(unit="1") "IDF line 6173"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_People(unit="1") "IDF line 6178"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_People(unit="1") "IDF line 6183"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_top_People(unit="1") "IDF line 6188"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_top_People(unit="1") "IDF line 6193"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_top_People(unit="1") "IDF line 6198"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_top_People(unit="1") "IDF line 6203"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_top_People(unit="1") "IDF line 6208"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_bot_People(unit="1") "IDF line 6213"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_bot_People(unit="1") "IDF line 6218"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_bot_People(unit="1") "IDF line 6223"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_bot_People(unit="1") "IDF line 6228"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_bot_People(unit="1") "IDF line 6233"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Outdoor_Temperature(unit="K") "IDF line 6238"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Outdoor_Humidity(unit="1") "IDF line 6243"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Wetbulb(unit="K") "IDF line 6248"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));

  Modelica.Blocks.Math.Gain neg[15](each k=-1)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable OccSch(
    name="Schedule Value",
    key="HVACOperationSchd",
    y(final unit="1", displayUnit="1"))
    "Block that reads EnergyPlus Occ Schedule"
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable peoCou[15](
    each name="People Occupant Count",
    key={"Core_mid People","Perimeter_mid_ZN_1 People","Perimeter_mid_ZN_2 People","Perimeter_mid_ZN_3 People",
        "Perimeter_mid_ZN_4 People","Core_top People","Perimeter_top_ZN_1 People","Perimeter_top_ZN_2 People",
        "Perimeter_top_ZN_3 People","Perimeter_top_ZN_4 People","Core_bot People","Perimeter_bot_ZN_1 People",
        "Perimeter_bot_ZN_2 People","Perimeter_bot_ZN_3 People","Perimeter_bot_ZN_4 People"},
    each y(final unit="1", displayUnit="1"))
    "Block that reads EnergyPlus people count"
    annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));

  Modelica.Blocks.Routing.RealPassThrough TDryBul
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Blocks.Routing.RealPassThrough TWetBul
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Routing.RealPassThrough relHum
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Modelica.Icons.SignalBus weaBus
    annotation (Placement(transformation(extent={{-48,72},{-32,88}}),
        iconTransformation(extent={{-48,72},{-32,88}})));
  Modelica.Blocks.Sources.RealExpression temDryBul(y=TDryBul.y - 273.15)
    "Dry bulb temperature in C"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Blocks.Sources.RealExpression temWetBul(y=TWetBul.y - 273.15)
    "Wet bulb temperature in C"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonTopCor(
      description="Top floor air temperature of core zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonTopSou(
      description="Top floor air temperature of south zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonTopEas(
      description="Top floor air temperature of east zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonTopNor(
      description="Top floor air temperature of north zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonTopWes(
      description="Top floor air temperature of west zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonMidCor(
      description="Middle floor air temperature of core zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonMidSou(
      description="Middle floor air temperature of south zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonMidEas(
      description="Middle floor air temperature of east zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonMidNor(
      description="Middle floor air temperature of north zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonMidWes(
      description="Middle floor air temperature of west zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonBotCor(
      description="Bottom floor air temperature of core zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonBotSou(
      description="Bottom floor air temperature of south zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonBotEas(
      description="Bottom floor air temperature of east zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonBotNor(
      description="Bottom floor air temperature of north zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTZonBotWes(
      description="Bottom floor air temperature of west zone",
      u(unit="K", min=273.15 - 10, max=273.15 + 50))
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaTopCor(
      y(unit="W"),
      description="Sensible cooling load in core zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaTopSou(
      y(unit="W"),
      description="Sensible cooling load in south zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaTopEas(
      y(unit="W"),
      description="Sensible cooling load in east zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaTopNor(
      y(unit="W"),
      description="Sensible cooling load in north zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaTopWes(
      y(unit="W"),
      description="Sensible cooling load in west zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaMidCor(
      y(unit="W"),
      description="Sensible cooling load in core zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaMidSou(
      y(unit="W"),
      description="Sensible cooling load in south zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaMidEas(
      y(unit="W"),
      description="Sensible cooling load in east zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaMidNor(
      y(unit="W"),
      description="Sensible cooling load in north zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaMidWes(
      y(unit="W"),
      description="Sensible cooling load in west zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaBotCor(
      y(unit="W"),
      description="Sensible cooling load in core zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaBotSou(
      y(unit="W"),
      description="Sensible cooling load in south zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaBotEas(
      y(unit="W"),
      description="Sensible cooling load in east zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaBotNor(
      y(unit="W"),
      description="Sensible cooling load in north zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaSenCooLoaBotWes(
      y(unit="W"),
      description="Sensible cooling load in west zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaTopCor(
      y(unit="W"),
      description="Latent cooling load in core zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaTopSou(
      y(unit="W"),
      description="Latent cooling load in south zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaTopEas(
      y(unit="W"),
      description="Latent cooling load in east zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaTopNor(
      y(unit="W"),
      description="Latent cooling load in north zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaTopWes(
      y(unit="W"),
      description="Latent cooling load in west zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaMidCor(
      y(unit="W"),
      description="Latent cooling load in core zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaMidSou(
      y(unit="W"),
      description="Latent cooling load in south zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaMidEas(
      y(unit="W"),
      description="Latent cooling load in east zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaMidNor(
      y(unit="W"),
      description="Latent cooling load in north zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaMidWes(
      y(unit="W"),
      description="Latent cooling load in west zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaBotCor(
      y(unit="W"),
      description="Latent cooling load in core zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaBotSou(
      y(unit="W"),
      description="Latent cooling load in south zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaBotEas(
      y(unit="W"),
      description="Latent cooling load in east zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaBotNor(
      y(unit="W"),
      description="Latent cooling load in north zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaLatCooLoaBotWes(
      y(unit="W"),
      description="Latent cooling load in west zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaTopCor(
      y(unit="W"),
      description="Heating load in core zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaTopSou(
      y(unit="W"),
      description="Heating load in south zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaTopEas(
      y(unit="W"),
      description="Heating load in east zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaTopNor(
      y(unit="W"),
      description="Heating load in north zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaTopWes(
      y(unit="W"),
      description="Heating load in west zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaMidCor(
      y(unit="W"),
      description="Heating load in core zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaMidSou(
      y(unit="W"),
      description="Heating load in south zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaMidEas(
      y(unit="W"),
      description="Heating load in east zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaMidNor(
      y(unit="W"),
      description="Heating load in north zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaMidWes(
      y(unit="W"),
      description="Heating load in west zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaBotCor(
      y(unit="W"),
      description="Heating load in core zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaBotSou(
      y(unit="W"),
      description="Heating load in south zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaBotEas(
      y(unit="W"),
      description="Heating load in east zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaBotNor(
      y(unit="W"),
      description="Heating load in north zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaHeaLoaBotWes(
      y(unit="W"),
      description="Heating load in west zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouTopCor(
      y(unit="1"),
      description="Number of people in core zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouTopSou(
      y(unit="1"),
      description="Number of people in south zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouTopEas(
      y(unit="1"),
      description="Number of people in east zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouTopNor(
      y(unit="1"),
      description="Number of people in north zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouTopWes(
      y(unit="1"),
      description="Number of people in west zone on top floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouMidCor(
      y(unit="1"),
      description="Number of people in core zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouMidSou(
      y(unit="1"),
      description="Number of people in south zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouMidEas(
      y(unit="1"),
      description="Number of people in east zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouMidNor(
      y(unit="1"),
      description="Number of people in north zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouMidWes(
      y(unit="1"),
      description="Number of people in west zone on mid floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouBotCor(
      y(unit="1"),
      description="Number of people in core zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouBotSou(
      y(unit="1"),
      description="Number of people in south zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouBotEas(
      y(unit="1"),
      description="Number of people in east zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouBotNor(
      y(unit="1"),
      description="Number of people in north zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPeoCouBotWes(
      y(unit="1"),
      description="Number of people in west zone on bot floor",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaOccSch(
      y(unit="1"),
      description="Occupancy schedule", KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTDryBul(
      y(unit="K"),
      description="Drybulb temperature", KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTWetBul(
      y(unit="K"),
      description="Wetbulb temperature", KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaRelHum(
      y(unit="1"),
      description="Relative humidity", KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

equation
  connect(X_w.y, fmuZonTopFlr.X_w) annotation (Line(points={{-67,54},{-10,54},{-10,
          34},{18,34}}, color={0,0,127}));
  connect(fmuZonTopFlr.m_flow[1], mIn_flow.y) annotation (Line(points={{18,29},{
          -8,29},{-8,0},{-43,0}},   color={0,0,127}));
  connect(mOut_flow.u,mIn_flow.y)
    annotation (Line(points={{-36,20},{-40,20},{-40,0},{-43,0}},  color={0,0,127}));
  connect(mOut_flow.y, fmuZonTopFlr.m_flow[2]) annotation (Line(points={{-13,20},
          {-10,20},{-10,31},{18,31}}, color={0,0,127}));
  connect(fmuZonTopFlr.QGaiRad_flow, QGaiRad_flow.y) annotation (Line(points={{18,22},
          {-4,22},{-4,-36},{-43,-36}},     color={0,0,127}));
  connect(X_w.y, fmuZonMidFlr.X_w) annotation (Line(points={{-67,54},{-12,54},{-12,
          -6},{18,-6}}, color={0,0,127}));
  connect(fmuZonMidFlr.m_flow[1], mIn_flow.y) annotation (Line(points={{18,-11},
          {-8,-11},{-8,0},{-43,0}},   color={0,0,127}));
  connect(mOut_flow.y, fmuZonMidFlr.m_flow[2]) annotation (Line(points={{-13,20},
          {-10,20},{-10,-9},{18,-9}}, color={0,0,127}));
  connect(fmuZonMidFlr.QGaiRad_flow, QGaiRad_flow.y) annotation (Line(points={{18,-18},
          {-4,-18},{-4,-36},{-43,-36}},      color={0,0,127}));
  connect(X_w.y, fmuZonBotFlr.X_w) annotation (Line(points={{-67,54},{-12,54},{-12,
          -46},{18,-46}}, color={0,0,127}));
  connect(fmuZonBotFlr.m_flow[1], mIn_flow.y) annotation (Line(points={{18,-51},
          {-8,-51},{-8,0},{-43,0}},   color={0,0,127}));
  connect(mOut_flow.y, fmuZonBotFlr.m_flow[2]) annotation (Line(points={{-13,20},
          {-10,20},{-10,-49},{18,-49}}, color={0,0,127}));
  connect(fmuZonBotFlr.QGaiRad_flow, QGaiRad_flow.y) annotation (Line(points={{18,-58},
          {-4,-58},{-4,-36},{-43,-36}},      color={0,0,127}));
  for numZon in 1:5 loop
    connect(TIn.y, fmuZonTopFlr[numZon].TInlet) annotation (Line(points={{-43,-20},
            {-6,-20},{-6,26},{18,26}},
                                 color={0,0,127}));
    connect(TIn.y, fmuZonMidFlr[numZon].TInlet) annotation (Line(points={{-43,-20},
            {-6,-20},{-6,-14},{18,-14}},                                                      color={0,0,127}));
    connect(TIn.y, fmuZonBotFlr[numZon].TInlet) annotation (Line(points={{-43,-20},
            {-6,-20},{-6,-54},{18,-54}},
                                   color={0,0,127}));
    connect(neg[numZon].u, fmuZonMidFlr[numZon].QCon_flow);
    connect(neg[5+numZon].u, fmuZonTopFlr[numZon].QCon_flow);
    connect(neg[10+numZon].u, fmuZonBotFlr[numZon].QCon_flow);
  end for;

  connect(Zone1_Sensible_COOLING_LOAD, reaSenCooLoaMidCor.y);
  connect(Zone2_Sensible_COOLING_LOAD, reaSenCooLoaMidSou.y);
  connect(Zone3_Sensible_COOLING_LOAD, reaSenCooLoaMidEas.y);
  connect(Zone4_Sensible_COOLING_LOAD, reaSenCooLoaMidNor.y);
  connect(Zone5_Sensible_COOLING_LOAD, reaSenCooLoaMidWes.y);
  connect(Zone1_top_Sensible_COOLING_LOAD, reaSenCooLoaTopCor.y);
  connect(Zone2_top_Sensible_COOLING_LOAD, reaSenCooLoaTopSou.y);
  connect(Zone3_top_Sensible_COOLING_LOAD, reaSenCooLoaTopEas.y);
  connect(Zone4_top_Sensible_COOLING_LOAD, reaSenCooLoaTopNor.y);
  connect(Zone5_top_Sensible_COOLING_LOAD, reaSenCooLoaTopWes.y);
  connect(Zone1_bot_Sensible_COOLING_LOAD, reaSenCooLoaBotCor.y);
  connect(Zone2_bot_Sensible_COOLING_LOAD, reaSenCooLoaBotSou.y);
  connect(Zone3_bot_Sensible_COOLING_LOAD, reaSenCooLoaBotEas.y);
  connect(Zone4_bot_Sensible_COOLING_LOAD, reaSenCooLoaBotNor.y);
  connect(Zone5_bot_Sensible_COOLING_LOAD, reaSenCooLoaBotWes.y);

  connect(Zone1_Latent_COOLING_LOAD, reaLatCooLoaMidCor.y);
  connect(Zone2_Latent_COOLING_LOAD, reaLatCooLoaMidSou.y);
  connect(Zone3_Latent_COOLING_LOAD, reaLatCooLoaMidEas.y);
  connect(Zone4_Latent_COOLING_LOAD, reaLatCooLoaMidNor.y);
  connect(Zone5_Latent_COOLING_LOAD, reaLatCooLoaMidWes.y);
  connect(Zone1_top_Latent_COOLING_LOAD, reaLatCooLoaTopCor.y);
  connect(Zone2_top_Latent_COOLING_LOAD, reaLatCooLoaTopSou.y);
  connect(Zone3_top_Latent_COOLING_LOAD, reaLatCooLoaTopEas.y);
  connect(Zone4_top_Latent_COOLING_LOAD, reaLatCooLoaTopNor.y);
  connect(Zone5_top_Latent_COOLING_LOAD, reaLatCooLoaTopWes.y);
  connect(Zone1_bot_Latent_COOLING_LOAD, reaLatCooLoaBotCor.y);
  connect(Zone2_bot_Latent_COOLING_LOAD, reaLatCooLoaBotSou.y);
  connect(Zone3_bot_Latent_COOLING_LOAD, reaLatCooLoaBotEas.y);
  connect(Zone4_bot_Latent_COOLING_LOAD, reaLatCooLoaBotNor.y);
  connect(Zone5_bot_Latent_COOLING_LOAD, reaLatCooLoaBotWes.y);

  connect(Zone1_HEATING_LOAD, reaHeaLoaMidCor.y);
  connect(Zone2_HEATING_LOAD, reaHeaLoaMidSou.y);
  connect(Zone3_HEATING_LOAD, reaHeaLoaMidEas.y);
  connect(Zone4_HEATING_LOAD, reaHeaLoaMidNor.y);
  connect(Zone5_HEATING_LOAD, reaHeaLoaMidWes.y);
  connect(Zone1_top_HEATING_LOAD, reaHeaLoaTopCor.y);
  connect(Zone2_top_HEATING_LOAD, reaHeaLoaTopSou.y);
  connect(Zone3_top_HEATING_LOAD, reaHeaLoaTopEas.y);
  connect(Zone4_top_HEATING_LOAD, reaHeaLoaTopNor.y);
  connect(Zone5_top_HEATING_LOAD, reaHeaLoaTopWes.y);
  connect(Zone1_bot_HEATING_LOAD, reaHeaLoaBotCor.y);
  connect(Zone2_bot_HEATING_LOAD, reaHeaLoaBotSou.y);
  connect(Zone3_bot_HEATING_LOAD, reaHeaLoaBotEas.y);
  connect(Zone4_bot_HEATING_LOAD, reaHeaLoaBotNor.y);
  connect(Zone5_bot_HEATING_LOAD, reaHeaLoaBotWes.y);

  connect(reaHeaLoaMidCor.u, neg[1].y);
  connect(reaHeaLoaMidSou.u, neg[2].y);
  connect(reaHeaLoaMidEas.u, neg[3].y);
  connect(reaHeaLoaMidNor.u, neg[4].y);
  connect(reaHeaLoaMidWes.u, neg[5].y);
  connect(reaHeaLoaTopCor.u, neg[6].y);
  connect(reaHeaLoaTopSou.u, neg[7].y);
  connect(reaHeaLoaTopEas.u, neg[8].y);
  connect(reaHeaLoaTopNor.u, neg[9].y);
  connect(reaHeaLoaTopWes.u, neg[10].y);
  connect(reaHeaLoaBotCor.u, neg[11].y);
  connect(reaHeaLoaBotSou.u, neg[12].y);
  connect(reaHeaLoaBotEas.u, neg[13].y);
  connect(reaHeaLoaBotNor.u, neg[14].y);
  connect(reaHeaLoaBotWes.u, neg[15].y);

  connect(reaPeoCouMidCor.u, peoCou[1].y);
  connect(reaPeoCouMidSou.u, peoCou[2].y);
  connect(reaPeoCouMidEas.u, peoCou[3].y);
  connect(reaPeoCouMidNor.u, peoCou[4].y);
  connect(reaPeoCouMidWes.u, peoCou[5].y);
  connect(reaPeoCouTopCor.u, peoCou[6].y);
  connect(reaPeoCouTopSou.u, peoCou[7].y);
  connect(reaPeoCouTopEas.u, peoCou[8].y);
  connect(reaPeoCouTopNor.u, peoCou[9].y);
  connect(reaPeoCouTopWes.u, peoCou[10].y);
  connect(reaPeoCouBotCor.u, peoCou[11].y);
  connect(reaPeoCouBotSou.u, peoCou[12].y);
  connect(reaPeoCouBotEas.u, peoCou[13].y);
  connect(reaPeoCouBotNor.u, peoCou[14].y);
  connect(reaPeoCouBotWes.u, peoCou[15].y);

  connect(Zone1_People, reaPeoCouMidCor.y);
  connect(Zone2_People, reaPeoCouMidSou.y);
  connect(Zone3_People, reaPeoCouMidEas.y);
  connect(Zone4_People, reaPeoCouMidNor.y);
  connect(Zone5_People, reaPeoCouMidWes.y);
  connect(Zone1_top_People, reaPeoCouTopCor.y);
  connect(Zone2_top_People, reaPeoCouTopSou.y);
  connect(Zone3_top_People, reaPeoCouTopEas.y);
  connect(Zone4_top_People, reaPeoCouTopNor.y);
  connect(Zone5_top_People, reaPeoCouTopWes.y);
  connect(Zone1_bot_People, reaPeoCouBotCor.y);
  connect(Zone2_bot_People, reaPeoCouBotSou.y);
  connect(Zone3_bot_People, reaPeoCouBotEas.y);
  connect(Zone4_bot_People, reaPeoCouBotNor.y);
  connect(Zone5_bot_People, reaPeoCouBotWes.y);

  connect(oveTZonMidCor.y, fmuZonMidFlr[1].T) annotation (Line(points={{-69,-10},{-14,
          -10},{-14,-2},{18,-2}}, color={0,0,127}));
  connect(oveTZonMidSou.y, fmuZonMidFlr[2].T) annotation (Line(points={{-69,-10},{-14,
          -10},{-14,-2},{18,-2}}, color={0,0,127}));
  connect(oveTZonMidEas.y, fmuZonMidFlr[3].T) annotation (Line(points={{-69,-10},{-14,
          -10},{-14,-2},{18,-2}}, color={0,0,127}));
  connect(oveTZonMidNor.y, fmuZonMidFlr[4].T) annotation (Line(points={{-69,-10},{-14,
          -10},{-14,-2},{18,-2}}, color={0,0,127}));
  connect(oveTZonMidWes.y, fmuZonMidFlr[5].T) annotation (Line(points={{-69,-10},{-14,
          -10},{-14,-2},{18,-2}}, color={0,0,127}));

  connect(oveTZonBotCor.y, fmuZonBotFlr[1].T) annotation (Line(points={{-69,-50},{-20,
          -50},{-20,-42},{18,-42}}, color={0,0,127}));
  connect(oveTZonBotSou.y, fmuZonBotFlr[2].T) annotation (Line(points={{-69,-50},{-20,
          -50},{-20,-42},{18,-42}}, color={0,0,127}));
  connect(oveTZonBotEas.y, fmuZonBotFlr[3].T) annotation (Line(points={{-69,-50},{-20,
          -50},{-20,-42},{18,-42}}, color={0,0,127}));
  connect(oveTZonBotNor.y, fmuZonBotFlr[4].T) annotation (Line(points={{-69,-50},{-20,
          -50},{-20,-42},{18,-42}}, color={0,0,127}));
  connect(oveTZonBotWes.y, fmuZonBotFlr[5].T) annotation (Line(points={{-69,-50},{-20,
          -50},{-20,-42},{18,-42}}, color={0,0,127}));

  connect(oveTZonTopCor.u, Temp1_top) annotation (Line(points={{-92,30},{-96,
          30},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonTopSou.u, Temp2_top) annotation (Line(points={{-92,30},{-96,
          30},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonTopEas.u, Temp3_top) annotation (Line(points={{-92,30},{-96,
          30},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonTopNor.u, Temp4_top) annotation (Line(points={{-92,30},{-96,
          30},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonTopWes.u, Temp5_top) annotation (Line(points={{-92,30},{-96,
          30},{-96,0},{-120,0}}, color={0,0,127}));

  connect(oveTZonMidCor.u, Temp1) annotation (Line(points={{-92,-10},{-96,
          -10},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonMidSou.u, Temp2) annotation (Line(points={{-92,-10},{-96,
          -10},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonMidEas.u, Temp3) annotation (Line(points={{-92,-10},{-96,
          -10},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonMidNor.u, Temp4) annotation (Line(points={{-92,-10},{-96,
          -10},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonMidWes.u, Temp5) annotation (Line(points={{-92,-10},{-96,
          -10},{-96,0},{-120,0}}, color={0,0,127}));

  connect(oveTZonBotCor.u, Temp1_bot) annotation (Line(points={{-92,-50},{-96,
          -50},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonBotSou.u, Temp2_bot) annotation (Line(points={{-92,-50},{-96,
          -50},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonBotEas.u, Temp3_bot) annotation (Line(points={{-92,-50},{-96,
          -50},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonBotNor.u, Temp4_bot) annotation (Line(points={{-92,-50},{-96,
          -50},{-96,0},{-120,0}}, color={0,0,127}));
  connect(oveTZonBotWes.u, Temp5_bot) annotation (Line(points={{-92,-50},{-96,
          -50},{-96,0},{-120,0}}, color={0,0,127}));

  connect(fmuZonTopFlr[1].QCon_flow, reaSenCooLoaTopCor.u)
    annotation (Line(points={{41,32},{50,32},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonTopFlr[2].QCon_flow, reaSenCooLoaTopSou.u)
    annotation (Line(points={{41,32},{50,32},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonTopFlr[3].QCon_flow, reaSenCooLoaTopEas.u)
    annotation (Line(points={{41,32},{50,32},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonTopFlr[4].QCon_flow, reaSenCooLoaTopNor.u)
    annotation (Line(points={{41,32},{50,32},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonTopFlr[5].QCon_flow, reaSenCooLoaTopWes.u)
    annotation (Line(points={{41,32},{50,32},{50,0},{58,0}}, color={0,0,127}));

  connect(fmuZonMidFlr[1].QCon_flow, reaSenCooLoaMidCor.u)
    annotation (Line(points={{41,-8},{50,-8},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonMidFlr[2].QCon_flow, reaSenCooLoaMidSou.u)
    annotation (Line(points={{41,-8},{50,-8},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonMidFlr[3].QCon_flow, reaSenCooLoaMidEas.u)
    annotation (Line(points={{41,-8},{50,-8},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonMidFlr[4].QCon_flow, reaSenCooLoaMidNor.u)
    annotation (Line(points={{41,-8},{50,-8},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonMidFlr[5].QCon_flow, reaSenCooLoaMidWes.u)
    annotation (Line(points={{41,-8},{50,-8},{50,0},{58,0}}, color={0,0,127}));

  connect(fmuZonBotFlr[1].QCon_flow, reaSenCooLoaBotCor.u)
    annotation (Line(points={{41,-48},{50,-48},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonBotFlr[2].QCon_flow, reaSenCooLoaBotSou.u)
    annotation (Line(points={{41,-48},{50,-48},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonBotFlr[3].QCon_flow, reaSenCooLoaBotEas.u)
    annotation (Line(points={{41,-48},{50,-48},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonBotFlr[4].QCon_flow, reaSenCooLoaBotNor.u)
    annotation (Line(points={{41,-48},{50,-48},{50,0},{58,0}}, color={0,0,127}));
  connect(fmuZonBotFlr[5].QCon_flow, reaSenCooLoaBotWes.u)
    annotation (Line(points={{41,-48},{50,-48},{50,0},{58,0}}, color={0,0,127}));

  connect(oveTZonTopCor.y, fmuZonTopFlr[1].T) annotation (Line(points={{-69,30},{-40,
          30},{-40,38},{18,38}}, color={0,0,127}));
  connect(oveTZonTopSou.y, fmuZonTopFlr[2].T) annotation (Line(points={{-69,30},{-40,
          30},{-40,38},{18,38}}, color={0,0,127}));
  connect(oveTZonTopEas.y, fmuZonTopFlr[3].T) annotation (Line(points={{-69,30},{-40,
          30},{-40,38},{18,38}}, color={0,0,127}));
  connect(oveTZonTopNor.y, fmuZonTopFlr[4].T) annotation (Line(points={{-69,30},{-40,
          30},{-40,38},{18,38}}, color={0,0,127}));
  connect(oveTZonTopWes.y, fmuZonTopFlr[5].T) annotation (Line(points={{-69,30},{-40,
          30},{-40,38},{18,38}}, color={0,0,127}));

  connect(fmuZonTopFlr[1].QLat_flow, reaLatCooLoaTopCor.u)
    annotation (Line(points={{41,28},{46,28},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonTopFlr[2].QLat_flow, reaLatCooLoaTopSou.u)
    annotation (Line(points={{41,28},{46,28},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonTopFlr[3].QLat_flow, reaLatCooLoaTopEas.u)
    annotation (Line(points={{41,28},{46,28},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonTopFlr[4].QLat_flow, reaLatCooLoaTopNor.u)
    annotation (Line(points={{41,28},{46,28},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonTopFlr[5].QLat_flow, reaLatCooLoaTopWes.u)
    annotation (Line(points={{41,28},{46,28},{46,0},{58,0}}, color={0,0,127}));

  connect(fmuZonMidFlr[1].QLat_flow, reaLatCooLoaMidCor.u)
    annotation (Line(points={{41,-12},{46,-12},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonMidFlr[2].QLat_flow, reaLatCooLoaMidSou.u)
    annotation (Line(points={{41,-12},{46,-12},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonMidFlr[3].QLat_flow, reaLatCooLoaMidEas.u)
    annotation (Line(points={{41,-12},{46,-12},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonMidFlr[4].QLat_flow, reaLatCooLoaMidNor.u)
    annotation (Line(points={{41,-12},{46,-12},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonMidFlr[5].QLat_flow, reaLatCooLoaMidWes.u)
    annotation (Line(points={{41,-12},{46,-12},{46,0},{58,0}}, color={0,0,127}));

  connect(fmuZonBotFlr[1].QLat_flow, reaLatCooLoaBotCor.u)
    annotation (Line(points={{41,-52},{46,-52},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonBotFlr[2].QLat_flow, reaLatCooLoaBotSou.u)
    annotation (Line(points={{41,-52},{46,-52},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonBotFlr[3].QLat_flow, reaLatCooLoaBotEas.u)
    annotation (Line(points={{41,-52},{46,-52},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonBotFlr[4].QLat_flow, reaLatCooLoaBotNor.u)
    annotation (Line(points={{41,-52},{46,-52},{46,0},{58,0}}, color={0,0,127}));
  connect(fmuZonBotFlr[5].QLat_flow, reaLatCooLoaBotWes.u)
    annotation (Line(points={{41,-52},{46,-52},{46,0},{58,0}}, color={0,0,127}));

  connect(reaOccSch.y, Occ);
  connect(OccSch.y, reaOccSch.u);

  connect(weaBus.TDryBul, TDryBul.u);
  connect(weaBus.TWetBul, TWetBul.u);
  connect(weaBus.relHum, relHum.u);
  connect(building.weaBus, weaBus) annotation (Line(
      points={{-60,80},{-40,80}},
      color={255,204,51},
      thickness=0.5));

  connect(Outdoor_Temperature, reaTDryBul.y);
  connect(reaTDryBul.u, temDryBul.y);

  connect(Wetbulb, reaTWetBul.y);
  connect(reaTWetBul.u, TWetBul.y);

  connect(reaRelHum.u, relHum.y);
  connect(reaRelHum.y, Outdoor_Humidity)
    annotation (Line(points={{81,0},{120,0}}, color={0,0,127}));
    annotation (Line(points={{81,0},{120,0}}, color={0,0,127}),
    Documentation(
      info="<html>
<p>
Validation model that communicates with an FMU that emulates three simple thermal zones.
All thermal zones are identical.
</p>
<p>
This test is done to validate the FMI API, using an FMU 2.0 for Model Exchange, compiled
for Linux 64 bit by JModelica.
</p>
</html>",
      revisions="<html>
<ul>
<li>
March 23, 2022, by Michael Wetter:<br/>
Changed model to use the instance name of the <code>building</code> instance as is done for the other Spawn models.
</li>
<li>
March 19, 2018, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(
      file="modelica://LargeOffice/Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_9_6_0/BaseClasses/Validation/FMUZoneAdapterZones3.mos" "Simulate and plot"),
    experiment(
      StartTime=17107200,
      StopTime=18316800,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Diagram(
      coordinateSystem(
        extent={{-100,-100},{100,100}})),
    Icon(
      coordinateSystem(
        extent={{-100,-100},{100,100}}), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-154,150},{146,110}},
        textString="%name",
        lineColor={0,0,255})}));
end whoBui96;
