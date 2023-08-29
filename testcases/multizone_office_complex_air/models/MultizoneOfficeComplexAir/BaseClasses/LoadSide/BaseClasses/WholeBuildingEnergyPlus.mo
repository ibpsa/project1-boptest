within MultizoneOfficeComplexAir.BaseClasses.LoadSide.BaseClasses;
model WholeBuildingEnergyPlus "EnergyPlusFMU"

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
  outer Buildings.ThermalZones.EnergyPlus_9_6_0.Building building
    "Building-level declarations";

  Buildings.ThermalZones.EnergyPlus_9_6_0.BaseClasses.ThermalZoneAdapter
    fmuZonTopFlr[5](
    each final modelicaNameBuilding=building.modelicaNameBuilding,
    each final spawnExe=building.spawnExe,
    each final idfVersion=building.idfVersion,
    each final idfName=building.idfName,
    each final epwName=building.epwName,
    each final relativeSurfaceTolerance=building.relativeSurfaceTolerance,
    final zoneName={"Core_top","Perimeter_top_ZN_1","Perimeter_top_ZN_2",
        "Perimeter_top_ZN_3","Perimeter_top_ZN_4"},
    each usePrecompiledFMU=false,
    each logLevel=building.logLevel,
    each final nFluPor=2) "Adapter to EnergyPlus"
    annotation (Placement(transformation(extent={{20,-58},{40,-38}})));
  Modelica.Blocks.Sources.RealExpression X_w[5](
    each y=0)
    "Zone absolute humidity"
    annotation (Placement(transformation(extent={{-88,44},{-68,64}})));
  Modelica.Blocks.Sources.RealExpression mIn_flow[5](
    each y=0)
    "Inlet mass flow rate"
    annotation (Placement(transformation(extent={{-88,0},{-68,20}})));
  Modelica.Blocks.Math.Gain mOut_flow[5](
    each k=-1)
    "Outlet mass flow rate"
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Blocks.Sources.RealExpression TIn[2](
    each y=293.15) "Inlet temperature"
    annotation (Placement(transformation(extent={{-88,-24},{-68,-4}})));
  Modelica.Blocks.Sources.RealExpression QGaiRad_flow[5](
    each y=0)
    "Radiative heat gain for the zone"
    annotation (Placement(transformation(extent={{-88,-46},{-68,-26}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.BaseClasses.ThermalZoneAdapter
    fmuZonMidFlr[5](
    each final modelicaNameBuilding=building.modelicaNameBuilding,
    each final spawnExe=building.spawnExe,
    each final idfVersion=building.idfVersion,
    each final idfName=building.idfName,
    each final epwName=building.epwName,
    each final relativeSurfaceTolerance=building.relativeSurfaceTolerance,
    final zoneName={"Core_mid","Perimeter_mid_ZN_1","Perimeter_mid_ZN_2",
        "Perimeter_mid_ZN_3","Perimeter_mid_ZN_4"},
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
    final zoneName={"Core_bot","Perimeter_bot_ZN_1","Perimeter_bot_ZN_2",
        "Perimeter_bot_ZN_3","Perimeter_bot_ZN_4"},
    each usePrecompiledFMU=false,
    each logLevel=building.logLevel,
    each final nFluPor=2) "Adapter to EnergyPlus"
    annotation (Placement(transformation(extent={{20,22},{40,42}})));

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

  Modelica.Blocks.Interfaces.RealOutput Occ "IDF line 5933"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_Sensible_COOLING_LOAD "IDF line 5938"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_Latent_COOLING_LOAD "IDF line 5943"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_HEATING_LOAD "IDF line 5948"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_top_Sensible_COOLING_LOAD "IDF line 5953"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_top_Latent_COOLING_LOAD "IDF line 5958"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_top_HEATING_LOAD "IDF line 5963"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_bot_Sensible_COOLING_LOAD "IDF line 5968"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_bot_Latent_COOLING_LOAD "IDF line 5973"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_bot_HEATING_LOAD "IDF line 5978"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_Sensible_COOLING_LOAD "IDF line 5983"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_Latent_COOLING_LOAD "IDF line 5988"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_HEATING_LOAD "IDF line 5993"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_top_Sensible_COOLING_LOAD "IDF line 5998"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_top_Latent_COOLING_LOAD "IDF line 6003"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_top_HEATING_LOAD "IDF line 6008"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_bot_Sensible_COOLING_LOAD "IDF line 6013"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_bot_Latent_COOLING_LOAD "IDF line 6018"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_bot_HEATING_LOAD "IDF line 6023"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_Sensible_COOLING_LOAD "IDF line 6028"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_Latent_COOLING_LOAD "IDF line 6033"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_HEATING_LOAD "IDF line 6038"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_top_Sensible_COOLING_LOAD "IDF line 6043"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_top_Latent_COOLING_LOAD "IDF line 6048"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_top_HEATING_LOAD "IDF line 6053"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_bot_Sensible_COOLING_LOAD "IDF line 6058"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_bot_Latent_COOLING_LOAD "IDF line 6063"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_bot_HEATING_LOAD "IDF line 6068"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_Sensible_COOLING_LOAD "IDF line 6073"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_Latent_COOLING_LOAD "IDF line 6078"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_HEATING_LOAD "IDF line 6083"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_top_Sensible_COOLING_LOAD "IDF line 6088"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_top_Latent_COOLING_LOAD "IDF line 6093"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_top_HEATING_LOAD "IDF line 6098"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_bot_Sensible_COOLING_LOAD "IDF line 6103"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_bot_Latent_COOLING_LOAD "IDF line 6108"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_bot_HEATING_LOAD "IDF line 6113"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_Sensible_COOLING_LOAD "IDF line 6118"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_Latent_COOLING_LOAD "IDF line 6123"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_HEATING_LOAD "IDF line 6128"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_top_Sensible_COOLING_LOAD "IDF line 6133"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_top_Latent_COOLING_LOAD "IDF line 6138"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_top_HEATING_LOAD "IDF line 6143"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_bot_Sensible_COOLING_LOAD "IDF line 6148"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_bot_Latent_COOLING_LOAD "IDF line 6153"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_bot_HEATING_LOAD "IDF line 6158"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_People "IDF line 6163"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_People "IDF line 6168"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_People "IDF line 6173"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_People "IDF line 6178"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_People "IDF line 6183"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_top_People "IDF line 6188"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_top_People "IDF line 6193"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_top_People "IDF line 6198"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_top_People "IDF line 6203"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_top_People "IDF line 6208"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone1_bot_People "IDF line 6213"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone2_bot_People "IDF line 6218"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone3_bot_People "IDF line 6223"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone4_bot_People "IDF line 6228"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Zone5_bot_People "IDF line 6233"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Outdoor_Temperature "IDF line 6238"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Outdoor_Humidity(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature") "IDF line 6243"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealOutput Wetbulb(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature") "IDF line 6248"
  annotation (Placement(transformation(extent={{100,-20},{140,20}})));

  Modelica.Blocks.Math.Gain neg[15](each k=-1)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable OccSch(
    name="Schedule Value",
    key="HVACOperationSchd",
    y(final unit="1", displayUnit="1"))
    "Block that reads EnergyPlus Occ Schedule"
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable peoCou[15](
    each name="People Occupant Count",
    key={"Core_mid People","Perimeter_mid_ZN_1 People","Perimeter_mid_ZN_2 People","Perimeter_mid_ZN_3 People",
        "Perimeter_mid_ZN_4 People","Core_top People","Perimeter_top_ZN_1 People","Perimeter_top_ZN_2 People",
        "Perimeter_top_ZN_3 People","Perimeter_top_ZN_4 People","Core_bot People","Perimeter_bot_ZN_1 People",
        "Perimeter_bot_ZN_2 People","Perimeter_bot_ZN_3 People","Perimeter_bot_ZN_4 People"},
    each y(final unit="1", displayUnit="1"))
    "Block that reads EnergyPlus people count"
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));

  Modelica.Blocks.Routing.RealPassThrough TDryBul
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Blocks.Routing.RealPassThrough TWetBul
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Routing.RealPassThrough relHum
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Modelica.Icons.SignalBus weaBus
    annotation (Placement(transformation(extent={{-8,92},{8,108}}),
        iconTransformation(extent={{-8,92},{8,108}})));
  Modelica.Blocks.Sources.RealExpression temDryBul(y=TDryBul.y)
    "Dry bulb temperature in K"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Sources.RealExpression temWetBul(y=TWetBul.y)
    "Wet bulb temperature in K"
    annotation (Placement(transformation(extent={{60,32},{80,52}})));
equation
  connect(X_w.y, fmuZonTopFlr.X_w) annotation (Line(points={{-67,54},{-14,54},{
          -14,-44},{18,-44}},
                        color={0,0,127}));
  connect(fmuZonTopFlr.m_flow[1], mIn_flow.y) annotation (Line(points={{18,-49},
          {-8,-49},{-8,10},{-67,10}},
                                    color={0,0,127}));
  connect(mOut_flow.u,mIn_flow.y)
    annotation (Line(points={{-52,30},{-60,30},{-60,10},{-67,10}},color={0,0,127}));
  connect(mOut_flow.y, fmuZonTopFlr.m_flow[2]) annotation (Line(points={{-29,30},
          {-10,30},{-10,-47},{18,-47}},
                                      color={0,0,127}));
  connect(fmuZonTopFlr.QGaiRad_flow, QGaiRad_flow.y) annotation (Line(points={{18,-56},
          {-4,-56},{-4,-36},{-67,-36}},    color={0,0,127}));
  connect(X_w.y, fmuZonMidFlr.X_w) annotation (Line(points={{-67,54},{-14,54},{-14,
          -6},{18,-6}}, color={0,0,127}));
  connect(fmuZonMidFlr.m_flow[1], mIn_flow.y) annotation (Line(points={{18,-11},
          {-8,-11},{-8,10},{-67,10}}, color={0,0,127}));
  connect(mOut_flow.y, fmuZonMidFlr.m_flow[2]) annotation (Line(points={{-29,30},
          {-10,30},{-10,-9},{18,-9}}, color={0,0,127}));
  connect(fmuZonMidFlr.QGaiRad_flow, QGaiRad_flow.y) annotation (Line(points={{18,
          -18},{-4,-18},{-4,-36},{-67,-36}}, color={0,0,127}));
  connect(X_w.y, fmuZonBotFlr.X_w) annotation (Line(points={{-67,54},{-14,54},{
          -14,36},{18,36}},
                          color={0,0,127}));
  connect(fmuZonBotFlr.m_flow[1], mIn_flow.y) annotation (Line(points={{18,31},
          {-8,31},{-8,10},{-67,10}},  color={0,0,127}));
  connect(mOut_flow.y, fmuZonBotFlr.m_flow[2]) annotation (Line(points={{-29,30},
          {-10,30},{-10,33},{18,33}},   color={0,0,127}));
  connect(fmuZonBotFlr.QGaiRad_flow, QGaiRad_flow.y) annotation (Line(points={{18,24},
          {-4,24},{-4,-36},{-67,-36}},       color={0,0,127}));
  for numZon in 1:5 loop
    connect(TIn.y, fmuZonTopFlr[numZon].TInlet) annotation (Line(points={{-67,-14},
            {-6,-14},{-6,-52},{18,-52}},color={0,0,127}));
    connect(TIn.y, fmuZonMidFlr[numZon].TInlet) annotation (Line(points={{-67,-14},{18,-14}}, color={0,0,127}));
    connect(TIn.y, fmuZonBotFlr[numZon].TInlet) annotation (Line(points={{-67,-14},
            {-6,-14},{-6,28},{18,28}},
                                   color={0,0,127}));
    connect(neg[numZon].u, fmuZonMidFlr[numZon].QCon_flow)
      annotation (Line(points={{58,-30},{50,-30},{50,-8},{41,-8}},
                                        color={0,0,127}));
    connect(neg[5+numZon].u, fmuZonTopFlr[numZon].QCon_flow)
      annotation (Line(points={{58,-30},{50,-30},{50,-46},{41,-46}},
                                        color={0,0,127}));
    connect(neg[10+numZon].u, fmuZonBotFlr[numZon].QCon_flow)
      annotation (Line(points={{58,-30},{50,-30},{50,34},{41,34}},
                                        color={0,0,127}));
  end for;

  connect(Temp1, fmuZonMidFlr[1].T)
  annotation (Line(points={{-120,0},{-16,0},{-16,-2},{18,-2}},
                                        color={0,0,127}));
  connect(Temp2, fmuZonMidFlr[2].T);
  connect(Temp3, fmuZonMidFlr[3].T);
  connect(Temp4, fmuZonMidFlr[4].T);
  connect(Temp5, fmuZonMidFlr[5].T);
  connect(Temp1_top, fmuZonTopFlr[1].T)
  annotation (Line(points={{-120,0},{-16,0},{-16,-40},{18,-40}},
                                        color={0,0,127}));
  connect(Temp2_top, fmuZonTopFlr[2].T);
  connect(Temp3_top, fmuZonTopFlr[3].T);
  connect(Temp4_top, fmuZonTopFlr[4].T);
  connect(Temp5_top, fmuZonTopFlr[5].T);
  connect(Temp1_bot, fmuZonBotFlr[1].T)
  annotation (Line(points={{-120,0},{-16,0},{-16,40},{18,40}},
                                        color={0,0,127}));
  connect(Temp2_bot, fmuZonBotFlr[2].T);
  connect(Temp3_bot, fmuZonBotFlr[3].T);
  connect(Temp4_bot, fmuZonBotFlr[4].T);
  connect(Temp5_bot, fmuZonBotFlr[5].T);

  connect(Zone1_Sensible_COOLING_LOAD, fmuZonMidFlr[1].QCon_flow)
  annotation (Line(points={{120,0},{50,0},{50,-8},{41,-8}},
                                        color={0,0,127}));
  connect(Zone2_Sensible_COOLING_LOAD, fmuZonMidFlr[2].QCon_flow);
  connect(Zone3_Sensible_COOLING_LOAD, fmuZonMidFlr[3].QCon_flow);
  connect(Zone4_Sensible_COOLING_LOAD, fmuZonMidFlr[4].QCon_flow);
  connect(Zone5_Sensible_COOLING_LOAD, fmuZonMidFlr[5].QCon_flow);
  connect(Zone1_top_Sensible_COOLING_LOAD, fmuZonTopFlr[1].QCon_flow)
  annotation (Line(points={{120,0},{50,0},{50,-46},{41,-46}},
                                        color={0,0,127}));
  connect(Zone2_top_Sensible_COOLING_LOAD, fmuZonTopFlr[2].QCon_flow);
  connect(Zone3_top_Sensible_COOLING_LOAD, fmuZonTopFlr[3].QCon_flow);
  connect(Zone4_top_Sensible_COOLING_LOAD, fmuZonTopFlr[4].QCon_flow);
  connect(Zone5_top_Sensible_COOLING_LOAD, fmuZonTopFlr[5].QCon_flow);
  connect(Zone1_bot_Sensible_COOLING_LOAD, fmuZonBotFlr[1].QCon_flow)
  annotation (Line(points={{120,0},{50,0},{50,34},{41,34}},
                                        color={0,0,127}));
  connect(Zone2_bot_Sensible_COOLING_LOAD, fmuZonBotFlr[2].QCon_flow);
  connect(Zone3_bot_Sensible_COOLING_LOAD, fmuZonBotFlr[3].QCon_flow);
  connect(Zone4_bot_Sensible_COOLING_LOAD, fmuZonBotFlr[4].QCon_flow);
  connect(Zone5_bot_Sensible_COOLING_LOAD, fmuZonBotFlr[5].QCon_flow);

  connect(Zone1_Latent_COOLING_LOAD, fmuZonMidFlr[1].QLat_flow)
  annotation (Line(points={{120,0},{96,0},{96,-12},{41,-12}},
                                        color={0,0,127}));
  connect(Zone2_Latent_COOLING_LOAD, fmuZonMidFlr[2].QLat_flow);
  connect(Zone3_Latent_COOLING_LOAD, fmuZonMidFlr[3].QLat_flow);
  connect(Zone4_Latent_COOLING_LOAD, fmuZonMidFlr[4].QLat_flow);
  connect(Zone5_Latent_COOLING_LOAD, fmuZonMidFlr[5].QLat_flow);
  connect(Zone1_top_Latent_COOLING_LOAD, fmuZonTopFlr[1].QLat_flow)
  annotation (Line(points={{120,0},{96,0},{96,-50},{41,-50}},
                                        color={0,0,127}));
  connect(Zone2_top_Latent_COOLING_LOAD, fmuZonTopFlr[2].QLat_flow);
  connect(Zone3_top_Latent_COOLING_LOAD, fmuZonTopFlr[3].QLat_flow);
  connect(Zone4_top_Latent_COOLING_LOAD, fmuZonTopFlr[4].QLat_flow);
  connect(Zone5_top_Latent_COOLING_LOAD, fmuZonTopFlr[5].QLat_flow);

  connect(Zone1_bot_Latent_COOLING_LOAD, fmuZonBotFlr[1].QLat_flow)
  annotation (Line(points={{120,0},{96,0},{96,30},{41,30}},
                                       color={0,0,127}));
  connect(Zone2_bot_Latent_COOLING_LOAD, fmuZonBotFlr[2].QLat_flow);
  connect(Zone3_bot_Latent_COOLING_LOAD, fmuZonBotFlr[3].QLat_flow);
  connect(Zone4_bot_Latent_COOLING_LOAD, fmuZonBotFlr[4].QLat_flow);
  connect(Zone5_bot_Latent_COOLING_LOAD, fmuZonBotFlr[5].QLat_flow);

  connect(Zone1_HEATING_LOAD, neg[1].y);
  connect(Zone2_HEATING_LOAD, neg[2].y);
  connect(Zone3_HEATING_LOAD, neg[3].y);
  connect(Zone4_HEATING_LOAD, neg[4].y);
  connect(Zone5_HEATING_LOAD, neg[5].y);
  connect(Zone1_top_HEATING_LOAD, neg[6].y);
  connect(Zone2_top_HEATING_LOAD, neg[7].y);
  connect(Zone3_top_HEATING_LOAD, neg[8].y)
  annotation (Line(points={{120,0},{92,0},{92,-30},{81,-30}},
                                        color={0,0,127}));
  connect(Zone4_top_HEATING_LOAD, neg[9].y);
  connect(Zone5_top_HEATING_LOAD, neg[10].y);
  connect(Zone1_bot_HEATING_LOAD, neg[11].y);
  connect(Zone2_bot_HEATING_LOAD, neg[12].y);
  connect(Zone3_bot_HEATING_LOAD, neg[13].y);
  connect(Zone4_bot_HEATING_LOAD, neg[14].y);
  connect(Zone5_bot_HEATING_LOAD, neg[15].y);

  connect(Zone1_People, peoCou[1].y);
  connect(Zone2_People, peoCou[2].y);
  connect(Zone3_People, peoCou[3].y);
  connect(Zone4_People, peoCou[4].y);
  connect(Zone5_People, peoCou[5].y);
  connect(Zone1_top_People, peoCou[6].y);
  connect(Zone2_top_People, peoCou[7].y);
  connect(Zone3_top_People, peoCou[8].y)
  annotation (Line(points={{120,0},{50,0},{50,-60},{-39,-60}},
                                        color={0,0,127}));
  connect(Zone4_top_People, peoCou[9].y);
  connect(Zone5_top_People, peoCou[10].y);
  connect(Zone1_bot_People, peoCou[11].y);
  connect(Zone2_bot_People, peoCou[12].y);
  connect(Zone3_bot_People, peoCou[13].y);
  connect(Zone4_bot_People, peoCou[14].y);
  connect(Zone5_bot_People, peoCou[15].y);

  connect(weaBus.TDryBul, TDryBul.u)
  annotation (Line(points={{0,100},{-14,100},{-14,80},{-2,80}},
                                        color={255,204,51}));
  connect(weaBus.TWetBul, TWetBul.u)
  annotation (Line(points={{0,100},{30,100},{30,80},{38,80}},
                                        color={255,204,51}));
  connect(weaBus.relHum, relHum.u)
  annotation (Line(points={{0,100},{68,100},{68,80},{78,80}},
                                        color={255,204,51}));
  connect(Outdoor_Temperature, temDryBul.y)
  annotation (Line(points={{120,0},{86,0},{86,60},{81,60}},
                                        color={0,0,127}));
  connect(Wetbulb, temWetBul.y)
  annotation (Line(points={{120,0},{86,0},{86,42},{81,42}},
                                        color={0,0,127}));
  connect(Outdoor_Humidity, relHum.y);
  connect(OccSch.y, Occ)
    annotation (Line(points={{-39,-90},{50,-90},{50,0},{120,0}},
                                        color={0,0,127}));

  annotation (
    Documentation(
      info="<html>
<p>Model that calcualte the building thermal loads of three floors for in toal fifteen thermal zones by calling EnergyPlus using <a href=\"modelica://Buildings.ThermalZones.EnergyPlus_9_6_0.BaseClasses.ThermalZoneAdapter\">Buildings.ThermalZones.EnergyPlus_9_6_0.BaseClasses.ThermalZoneAdapter</a>.</p>
</html>",
      revisions="<html>
<ul>
<li>
March 19, 2023, by Xing Lu:<br/>
First implementation.
</li>
</ul>
</html>"),
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
        extent={{-156,164},{144,124}},
        textString="%name",
        textColor={0,0,255}),
        Bitmap(extent={{-96,-82},{92,86}}, fileName=
              "modelica://MultizoneOfficeComplexAir/Resources/figure/spawn_icon.png")}));
end WholeBuildingEnergyPlus;
