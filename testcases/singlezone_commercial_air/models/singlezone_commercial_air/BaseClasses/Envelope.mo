within singlezone_commercial_air.BaseClasses;
model Envelope "Base envelope model"

  replaceable package MediumA = Buildings.Media.Air "Medium model";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1.51 "Nominal supply air flow rate";
  parameter Real lat " latitude of the building";
  parameter Real occ_nominal = 30 "Design number of occupants";
  parameter Modelica.SIunits.Angle S_=
    Buildings.Types.Azimuth.S "Azimuth for south walls";
  parameter Modelica.SIunits.Angle E_=
    Buildings.Types.Azimuth.E "Azimuth for east walls";
  parameter Modelica.SIunits.Angle W_=
    Buildings.Types.Azimuth.W "Azimuth for west walls";
  parameter Modelica.SIunits.Angle N_=
    Buildings.Types.Azimuth.N "Azimuth for north walls";
  parameter Modelica.SIunits.Angle C_=
    Buildings.Types.Tilt.Ceiling "Tilt for ceiling";
  parameter Modelica.SIunits.Angle F_=
    Buildings.Types.Tilt.Floor "Tilt for floor";
  parameter Modelica.SIunits.Angle Z_=
    Buildings.Types.Tilt.Wall "Tilt for wall";
  parameter Integer nConExtWin = 1 "Number of constructions with a window";
  parameter Integer nStaRef=5;
  parameter Real hRoo=5.1816 "Height (floor to ceiling)";
  parameter Real AFlo=348.4  "Floor area";
  parameter Real ANor=5.18 *15.24 "North wall area";
  parameter Real AInt=5.18 *22.86 "Internal wall area";
  parameter Real Awin=4 * (2.13 * 1.52) + 2 * (2.13* 1.82) "total window area";
  parameter Real hWin=2.13;
  parameter Real wWin=Awin/hWin;
  parameter Real ExteriorArea=157.9352 "1700 ft2";

  /* Materials: Concrete*/
  parameter Buildings.HeatTransfer.Data.Solids.Concrete matCon(x=0.1524, k=1.311, c=836, nStaRef=nStaRef) "Concrete"
  annotation (Placement(transformation(extent={{78,40},{98,60}})));

  /* Materials: Window */
  parameter Buildings.HeatTransfer.Data.Solids.Generic F13_Built_up_roofing(
        x=0.0095,
        k=0.16,
        c=1460,
        d=1120,
        nStaRef=nStaRef);
  parameter Buildings.HeatTransfer.Data.Resistances.Generic Nonres_Roof_Insulation(R=5.30668495131472);
  parameter Buildings.HeatTransfer.Data.Solids.Generic F08_Metal_surface(
        x=0.0008,
        k=45.28,
        c=500,
        d=7824,
        nStaRef=nStaRef);

  /* Materials: Internal wall */
  parameter Buildings.HeatTransfer.Data.Solids.Generic G01_13mm_gypsum_board(
        x=0.0127,
        k=0.1600,
        c=1090,
        d=800,
        nStaRef=nStaRef);

  /* Materials: External wall  */
  parameter Buildings.HeatTransfer.Data.Solids.Generic F07_25mm_stucco(
        x=0.0254,
        k=0.72,
        c=840,
        d=1856,
        nStaRef=nStaRef);

  parameter Buildings.HeatTransfer.Data.Solids.Generic G01_16mm_gypsum_board(
        x=0.0159,
        k=0.1600,
        c=1090,
        d=800,
        nStaRef=nStaRef);

  parameter Buildings.HeatTransfer.Data.Resistances.Generic Nonres_Exterior_Wall_Insulation(R=2.36800034244138);

  /* Constructions */

  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic LGstore2_Floor_Ffactor(nLay=1,
  material={matCon}) "Concrete Slab"
  annotation (Placement(transformation(extent={{60,82},{74,96}})));

  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic nonres_roof(nLay=3,
  absIR_a=0.9,
  absIR_b=0.9,
  absSol_a=0.77,
  absSol_b=0.6,
  material={F13_Built_up_roofing,Nonres_Roof_Insulation,F08_Metal_surface}) "Roof"
  annotation (Placement(transformation(extent={{80,64},{94,78}})));

  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic int_wall(nLay=1,
  material={G01_13mm_gypsum_board}) "Internal Wall"
  annotation (Placement(transformation(extent={{80,82},{94,96}})));

  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic nonres_ext_wall(
    nLay=4,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.7,
    absSol_b=0.6,
    material={F07_25mm_stucco,G01_16mm_gypsum_board,Nonres_Exterior_Wall_Insulation,G01_16mm_gypsum_board})
                           "Exterior wall"
    annotation (Placement(transformation(extent={{60,66},{74,80}})));

   parameter Buildings.HeatTransfer.Data.Solids.Generic soil(
    x=2,
    k=1.3,
    c=800,
    d=1500) "Soil properties"
    annotation (Placement(transformation(extent={{48,40},{68,60}})));
  /* Room model */
  Buildings.ThermalZones.Detailed.MixedAir roo(
    redeclare package Medium = MediumA,
    hRoo=hRoo,
    nConExtWin=nConExtWin,
    nConBou=3,
    use_C_flow=true,
    nPorts=5,
    nConExt=2,
    nConPar=0,
    nSurBou=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=AFlo,
    datConBou(
      layers={LGstore2_Floor_Ffactor,int_wall,int_wall},
      A={AFlo,AInt,AInt},
      til={F_, E_, W_}),
    datConExt(
      layers={nonres_roof,nonres_ext_wall},
      A={AFlo,ANor},
      til={C_,Z_},
      azi={S_,N_}),
    datConExtWin(
      layers={nonres_ext_wall},
      A={ANor},
      glaSys={window600},
      wWin={wWin},
      hWin={hWin},
      fFra={0.001},
      til={Z_},
      azi={S_}),
    lat=lat,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
                      /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumA.nC))
    "Room model for Single Zone Commercial Air (LGSTORE2 of the Strip Mall DOE Prototype Building version ASHRAE 90.1 2019)"
    annotation (Placement(transformation(extent={{24,-30},{54,0}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{8,82},{16,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TSoi[1](each T=283.15)
    "Boundary condition for construction" annotation (Placement(transformation(
          extent={{0,0},{-8,8}}, origin={76,-68})));

  Buildings.ThermalZones.Detailed.Validation.BESTEST.Data.Win600
         window600(
    UFra=3,
    haveExteriorShade=false,
    haveInteriorShade=false) "Window"
    annotation (Placement(transformation(extent={{40,84},{54,98}})));
  Buildings.Fluid.Sources.MassFlowSource_T sinInf(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{4,-66},{16,-54}})));
  Buildings.Fluid.Sources.Outside souInf(redeclare package Medium = MediumA,
    C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumA.nC),
      nPorts=1) "Source model for air infiltration"
           annotation (Placement(transformation(extent={{-24,-34},{-12,-22}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-32,-60},{-22,-50}})));
  Buildings.Fluid.Sensors.Density density(redeclare package Medium = MediumA)
    "Air density inside the building"
    annotation (Placement(transformation(extent={{-22,-76},{-32,-66}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-106,88},{-90,104}}),
        iconTransformation(extent={{-106,88},{-90,104}})));

  Buildings.HeatTransfer.Conduction.SingleLayer soi(
    A=AFlo,
    material=soil,
    steadyStateInitial=false,
    stateAtSurface_a=false,
    stateAtSurface_b=true)
                      "2m deep soil (per definition on p.4 of ASHRAE 140-2007)"
    annotation (Placement(transformation(
        extent={{5,-5},{-3,3}},
        rotation=-90,
        origin={43,-47})));
  Buildings.HeatTransfer.Sources.FixedHeatFlow AdiBouEea(Q_flow=0)
    "adaibatic boundary condition for internal walls between zones" annotation (
     Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={91,-27})));
  Buildings.HeatTransfer.Sources.FixedHeatFlow AdiBouWes(Q_flow=0)
    "adaibatic boundary condition for internal walls between zones" annotation (
     Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={91,-41})));
  Modelica.Blocks.Sources.CombiTimeTable sch(
    table=[0,0.05,0,0.05,1; 1,0.05,0,0.05,1; 2,0.05,0,0.05,1; 3,0.05,0,0.05,1;
        4,0.05,0,0.05,1; 5,0.05,0,0.05,1; 6,0.05,0,0.05,1; 7,0.05,0,0.05,1; 8,
        0.05,0,0.05,1; 9,0.05,0,0.05,0.25; 10,0.5,0.11,0.5,0.25; 11,0.95,0.11,
        0.9,0.25; 12,0.95,0.43,0.9,0.25; 13,0.95,0.46,0.9,0.25; 14,0.95,0.71,
        0.9,0.25; 15,0.95,0.5,0.9,0.25; 16,0.95,0.69,0.9,0.25; 17,0.95,0.54,0.9,
        0.25; 18,0.95,0.71,0.9,0.25; 19,0.95,0.34,0.9,0.25; 20,0.95,0.26,0.9,
        0.25; 21,0.5,0.11,0.5,0.25; 22,0.05,0,0.05,1; 23,0.05,0,0.05,1; 24,0.05,
        0,0.05,1; 25,0.05,0,0.05,1; 26,0.05,0,0.05,1; 27,0.05,0,0.05,1; 28,0.05,
        0,0.05,1; 29,0.05,0,0.05,1; 30,0.05,0,0.05,1; 31,0.05,0,0.05,1; 32,0.05,
        0,0.05,1; 33,0.05,0,0.05,0.25; 34,0.5,0.11,0.5,0.25; 35,0.95,0.11,0.9,
        0.25; 36,0.95,0.43,0.9,0.25; 37,0.95,0.46,0.9,0.25; 38,0.95,0.71,0.9,
        0.25; 39,0.95,0.5,0.9,0.25; 40,0.95,0.69,0.9,0.25; 41,0.95,0.54,0.9,
        0.25; 42,0.95,0.71,0.9,0.25; 43,0.95,0.34,0.9,0.25; 44,0.95,0.26,0.9,
        0.25; 45,0.5,0.11,0.5,0.25; 46,0.05,0,0.05,1; 47,0.05,0,0.05,1; 48,0.05,
        0,0.05,1; 49,0.05,0,0.05,1; 50,0.05,0,0.05,1; 51,0.05,0,0.05,1; 52,0.05,
        0,0.05,1; 53,0.05,0,0.05,1; 54,0.05,0,0.05,1; 55,0.05,0,0.05,1; 56,0.05,
        0,0.05,1; 57,0.05,0,0.05,0.25; 58,0.5,0.11,0.5,0.25; 59,0.95,0.11,0.9,
        0.25; 60,0.95,0.43,0.9,0.25; 61,0.95,0.46,0.9,0.25; 62,0.95,0.71,0.9,
        0.25; 63,0.95,0.5,0.9,0.25; 64,0.95,0.69,0.9,0.25; 65,0.95,0.54,0.9,
        0.25; 66,0.95,0.71,0.9,0.25; 67,0.95,0.34,0.9,0.25; 68,0.95,0.26,0.9,
        0.25; 69,0.5,0.11,0.5,0.25; 70,0.05,0,0.05,1; 71,0.05,0,0.05,1; 72,0.05,
        0,0.05,1; 73,0.05,0,0.05,1; 74,0.05,0,0.05,1; 75,0.05,0,0.05,1; 76,0.05,
        0,0.05,1; 77,0.05,0,0.05,1; 78,0.05,0,0.05,1; 79,0.05,0,0.05,1; 80,0.05,
        0,0.05,1; 81,0.05,0,0.05,0.25; 82,0.5,0.11,0.5,0.25; 83,0.95,0.11,0.9,
        0.25; 84,0.95,0.43,0.9,0.25; 85,0.95,0.46,0.9,0.25; 86,0.95,0.71,0.9,
        0.25; 87,0.95,0.5,0.9,0.25; 88,0.95,0.69,0.9,0.25; 89,0.95,0.54,0.9,
        0.25; 90,0.95,0.71,0.9,0.25; 91,0.95,0.34,0.9,0.25; 92,0.95,0.26,0.9,
        0.25; 93,0.5,0.11,0.5,0.25; 94,0.05,0,0.05,1; 95,0.05,0,0.05,1; 96,0.05,
        0,0.05,1; 97,0.05,0,0.05,1; 98,0.05,0,0.05,1; 99,0.05,0,0.05,1; 100,
        0.05,0,0.05,1; 101,0.05,0,0.05,1; 102,0.05,0,0.05,1; 103,0.05,0,0.05,1;
        104,0.05,0,0.05,1; 105,0.05,0,0.05,0.25; 106,0.5,0.11,0.5,0.25; 107,
        0.95,0.11,0.9,0.25; 108,0.95,0.43,0.9,0.25; 109,0.95,0.46,0.9,0.25; 110,
        0.95,0.71,0.9,0.25; 111,0.95,0.5,0.9,0.25; 112,0.95,0.69,0.9,0.25; 113,
        0.95,0.54,0.9,0.25; 114,0.95,0.71,0.9,0.25; 115,0.95,0.34,0.9,0.25; 116,
        0.95,0.26,0.9,0.25; 117,0.5,0.11,0.5,0.25; 118,0.05,0,0.05,1; 119,0.05,
        0,0.05,1; 120,0.05,0,0.05,1; 121,0.05,0,0.05,1; 122,0.05,0,0.05,1; 123,
        0.05,0,0.05,1; 124,0.05,0,0.05,1; 125,0.05,0,0.05,1; 126,0.05,0,0.05,1;
        127,0.05,0,0.05,1; 128,0.05,0,0.05,1; 129,0.05,0,0.05,0.25; 130,0.5,
        0.11,0.5,0.25; 131,0.95,0.11,0.9,0.25; 132,0.95,0.58,0.9,0.25; 133,0.95,
        0.71,0.9,0.25; 134,0.95,0.74,0.9,0.25; 135,0.95,0.77,0.9,0.25; 136,0.95,
        0.8,0.9,0.25; 137,0.95,0.74,0.9,0.25; 138,0.95,0.54,0.9,0.25; 139,0.5,
        0.11,0.5,0.25; 140,0.05,0,0.05,1; 141,0.05,0,0.05,1; 142,0.05,0,0.05,1;
        143,0.05,0,0.05,1; 144,0.05,0,0.05,1; 145,0.05,0,0.05,1; 146,0.05,0,
        0.05,1; 147,0.05,0,0.05,1; 148,0.05,0,0.05,1; 149,0.05,0,0.05,1; 150,
        0.05,0,0.05,1; 151,0.05,0,0.05,1; 152,0.05,0,0.05,1; 153,0.05,0,0.05,1;
        154,0.05,0,0.05,0.25; 155,0.5,0.11,0.5,0.25; 156,0.95,0.11,0.9,0.25;
        157,0.95,0.43,0.9,0.25; 158,0.95,0.46,0.9,0.25; 159,0.95,0.5,0.9,0.25;
        160,0.95,0.69,0.9,0.25; 161,0.95,0.34,0.9,0.25; 162,0.5,0.11,0.5,0.25;
        163,0.05,0,0.05,1; 164,0.05,0,0.05,1; 165,0.05,0,0.05,1; 166,0.05,0,
        0.05,1; 167,0.05,0,0.05,1; 168,0.05,0,0.05,1],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600)
    "schedules in the order of Light, Occupant, Equipment and Infiltration"
    annotation (Placement(transformation(extent={{-122,80},{-110,92}})));
  Sch2Gai sch2Gai(AFlo=AFlo) "schedule to heat gains"
    annotation (Placement(transformation(extent={{-70,76},{-50,96}})));
  Modelica.Fluid.Interfaces.FluidPort_a a(redeclare package Medium = MediumA)
    "Fluid inlets and outlets" annotation (Placement(transformation(extent={{-104,
            -50},{-84,-30}}),
                           iconTransformation(extent={{-104,-50},{-84,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b b(redeclare package Medium = MediumA)
    "Fluid inlets and outlets" annotation (Placement(transformation(extent={{-106,50},
            {-84,70}}),     iconTransformation(extent={{-106,50},{-84,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Sen_Tz
    "Room air temperature"
    annotation (Placement(transformation(extent={{56,-20},{66,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Tz(unit="K")
    "Absolute temperature as output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Gain gain(k=-0.000177458624*ExteriorArea)
    annotation (Placement(transformation(extent={{-82,-78},{-66,-62}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        occ "Occupancy status"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Logical.GreaterThreshold occThr(threshold=1e-3)
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTZon(
    description="Zone air temperature measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K")) "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));

  Modelica.Blocks.Interfaces.RealOutput CO2(unit="ppm")
    "CO2 concentration of zone"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Sources.RealExpression zonCO2(y=roo.air.vol.C[1])
    "Get zone CO2 measurement"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(MMMea=
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Blocks.Math.Gain numOcc(k=occ_nominal) "Number of occupants"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Math.Gain genCO1(k=8.64e-6)
    "CO2 generation from people"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Buildings.Utilities.IO.SignalExchange.Read reaCO2(
    description="Zone air CO2 concentration measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm")) "Zone CO2 measurement"
    annotation (Placement(transformation(extent={{40,10},{60,30}})));

equation
  connect(multiplex3_1.y, roo.qGai_flow) annotation (Line(
      points={{16.4,86},{20,86},{20,-9},{22.8,-9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(density.port, roo.ports[1])  annotation (Line(
      points={{-27,-76},{26,-76},{26,-24.9},{27.75,-24.9}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(density.d, product.u2) annotation (Line(
      points={{-32.5,-71},{-46,-71},{-46,-58},{-33,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weaBus, souInf.weaBus)        annotation (Line(
      points={{-98,96},{26,96},{26,4},{-26,4},{-26,-27.88},{-24,-27.88}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sinInf.ports[1], roo.ports[2])        annotation (Line(
      points={{16,-60},{24,-60},{24,-23.7},{27.75,-23.7}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(souInf.ports[1], roo.ports[3]) annotation (Line(points={{-12,-28},{20,
          -28},{20,-22.5},{27.75,-22.5}}, color={0,127,255}));
  connect(TSoi[1].port, soi.port_a) annotation (Line(points={{68,-64},{62,-64},
          {62,-52},{42,-52}},
                          color={191,0,0}));
  connect(AdiBouEea.port, roo.surf_conBou[2]) annotation (Line(points={{86,-27},
          {74,-27},{74,-34},{43.5,-34},{43.5,-27}}, color={191,0,0}));
  connect(AdiBouWes.port, roo.surf_conBou[2]) annotation (Line(points={{86,-41},
          {76,-41},{76,-40},{43.5,-40},{43.5,-27}}, color={191,0,0}));
  connect(sch2Gai.qcon, multiplex3_1.u2[1]) annotation (Line(points={{-47.3,
          86.1},{-20,86.1},{-20,86},{7.2,86}}, color={0,0,127}));
  connect(sch2Gai.qlat, multiplex3_1.u3[1]) annotation (Line(points={{-47.1,
          81.9},{-16,81.9},{-16,83.2},{7.2,83.2}}, color={0,0,127}));
  connect(sch2Gai.qrad, multiplex3_1.u1[1]) annotation (Line(points={{-47.4,
          90.4},{-24,90.4},{-24,88.8},{7.2,88.8}}, color={0,0,127}));
  connect(soi.port_b, roo.surf_conBou[1]) annotation (Line(points={{42,-44},{42,
          -42},{43.5,-42},{43.5,-27.5}}, color={191,0,0}));
  connect(weaBus, roo.weaBus) annotation (Line(
      points={{-98,96},{26,96},{26,4},{52.425,4},{52.425,-1.575}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(roo.ports[4], a) annotation (Line(points={{27.75,-21.3},{18,-21.3},{18,
          -40},{-94,-40}},  color={0,127,255}));
  connect(roo.heaPorAir, Sen_Tz.port)
    annotation (Line(points={{38.25,-15},{56,-15}},         color={191,0,0}));
  connect(product.y, sinInf.m_flow_in) annotation (Line(points={{-21.5,-55},{
          -8.75,-55},{-8.75,-55.2},{2.8,-55.2}}, color={0,0,127}));
  connect(gain.y, product.u1) annotation (Line(points={{-65.2,-70},{-60,-70},{-60,
          -52},{-33,-52}}, color={0,0,127}));
  connect(sch.y[4], gain.u) annotation (Line(points={{-109.4,86},{-106,86},{-106,
          -70},{-83.6,-70}}, color={0,0,127}));
  connect(sch.y[1:3], sch2Gai.u) annotation (Line(points={{-109.4,86},{-90,86},
          {-90,85.6},{-70,85.6}}, color={0,0,127}));
  connect(occThr.y, occ) annotation (Line(points={{81,-90},{90,-90},{90,-80},{
          110,-80}}, color={255,0,255}));
  connect(occThr.u, sch.y[2]) annotation (Line(points={{58,-90},{-106,-90},{-106,
          86},{-109.4,86}}, color={0,0,127}));
  connect(Sen_Tz.T, reaTZon.u)
    annotation (Line(points={{66,-15},{66,0},{72,0}}, color={0,0,127}));
  connect(reaTZon.y, Tz)
    annotation (Line(points={{95,0},{110,0}}, color={0,0,127}));
  connect(b, roo.ports[5]) annotation (Line(points={{-95,60},{16,60},{16,-20.1},
          {27.75,-20.1}}, color={0,127,255}));
  connect(conMasVolFra.m, zonCO2.y)
    annotation (Line(points={{-51,20},{-59,20}}, color={0,0,127}));
  connect(conMasVolFra.V, gaiPPM.u)
    annotation (Line(points={{-29,20},{-22,20}}, color={0,0,127}));
  connect(sch.y[2], numOcc.u) annotation (Line(points={{-109.4,86},{-106,86},{-106,
          0},{-82,0}}, color={0,0,127}));
  connect(numOcc.y, genCO1.u)
    annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(genCO1.y, roo.C_flow[1]) annotation (Line(points={{-29,0},{18,0},{18,
          -12.9},{22.8,-12.9}}, color={0,0,127}));
  connect(gaiPPM.y, reaCO2.u)
    annotation (Line(points={{1,20},{38,20}}, color={0,0,127}));
  connect(reaCO2.y, CO2)
    annotation (Line(points={{61,20},{110,20}}, color={0,0,127}));
  annotation (
experiment(Tolerance=1e-06, StopTime=3.1536e+07),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/Detailed/Validation/BESTEST/Cases6xx/Case600FF.mos"
        "Simulate and plot"), Documentation(info="<html>
<p>
<div>This test case uses LGSTORE2 of the Strip Mall DOE Prototype Building version ASHRAE 90.1 2019.</div>
<div>For more information, see https://www.energycodes.gov/prototype-building-models.</div>
<div>It implements the zone with adiabatic boundary conditions at the mid-way plane of internal partitions with two neighboring zones</div>
<div>and environmental boundary conditions in the remaining boundaries as needed.</div>
</p>
</html>", revisions="<html>
<ul>
<li>
January 07, 2022, by Donghun Kim and David Blum:<br/>
Changed calculation of time averaged values to use
<a href=\"modelica://Buildings.Controls.OBC.CDL.Continuous.MovingMean\">
Buildings.Controls.OBC.CDL.Continuous.MovingMean</a>
because this does not trigger a time event every hour.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1714\">issue 1714</a>.
</li>
<li>
October 29, 2016, by Donghun Kim and David Blum:<br/>
Placed a capacity at the room-facing surface
to reduce the dimension of the nonlinear system of equations,
which generally decreases computing time.<br/>
Removed the pressure drop element which is not needed.<br/>
Linearized the radiative heat transfer, which is the default in
the library, and avoids a large nonlinear system of equations.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/565\">issue 565</a>.
</li>
<li>
December 22, 2014 by Donghun Kim and David Blum:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
October 9, 2013, by Donghun Kim and David Blum:<br/>
Implemented soil properties using a record so that <code>TSol</code> and
<code>TLiq</code> are assigned.
This avoids an error when the model is checked in the pedantic mode.
</li>
<li>
July 15, 2012, by Donghun Kim and David Blum:<br/>
Added reference results.
Changed implementation to make this model the base class
for all BESTEST cases.
Added computation of hourly and annual averaged room air temperature.
<li>
October 6, 2011, by Donghun Kim and David Blum:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(graphics={                     Text(
        extent={{-100,140},{100,100}},
        textString="%name",
        textColor={0,0,255}),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-92,92},{92,-92}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{78,42},{92,-42}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{82,42},{88,-42}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}));
end Envelope;
