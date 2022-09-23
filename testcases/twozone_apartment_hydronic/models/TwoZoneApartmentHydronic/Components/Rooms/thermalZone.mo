within TwoZoneApartmentHydronic.Components.Rooms;
model thermalZone "Reference Thermal zone model Milan"
  replaceable package MediumA = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Medium model";
  replaceable package MediumW = Buildings.Media.Water "Medium model";
  parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal = 0.1 "Nominal air mass flow rate";
  parameter Modelica.SIunits.Angle S_=
    Buildings.Types.Azimuth.SE "Azimuth for south walls";
  parameter Modelica.SIunits.Angle E_=
    Buildings.Types.Azimuth.NE "Azimuth for east walls";
  parameter Modelica.SIunits.Angle W_=
    Buildings.Types.Azimuth.SW "Azimuth for west walls";
  parameter Modelica.SIunits.Angle N_=
    Buildings.Types.Azimuth.NW "Azimuth for north walls";
  parameter Modelica.SIunits.Angle C_=
    Buildings.Types.Tilt.Ceiling "Tilt for ceiling";
  parameter Modelica.SIunits.Angle F_=
    Buildings.Types.Tilt.Floor "Tilt for floor";
  parameter Modelica.SIunits.Angle Z_=
    Buildings.Types.Tilt.Wall "Tilt for wall";
  parameter Integer nConExtWin = 1 "Number of constructions with a window";
  parameter Integer nConBou = 3
    "Number of surface that are connected to constructions that are modeled inside the room";
  parameter Integer nSurBou = 2 "Number of surface that are connected to constructions that are modeled outside the room";
  parameter Modelica.SIunits.VolumeFlowRate AirChange= -48*2.7*0.5/3600 "Infiltration rate";
  parameter Modelica.SIunits.Area Afloor = 22 "Floor area";
  parameter Modelica.SIunits.MassFlowRate mflow_n= 2400/2/3600 "nominal flow rate";
  parameter Real qint= 1 "Presence or not of Internal gains";
  parameter Modelica.SIunits.Temperature Tstart = 8+273.15 "Starting temperature";
  parameter String zonName = "Thermal Zone" "Parameter used to designate  zone name";
  final parameter Boolean have_surBou = (nSurBou>1);  //if nSurBou > 1 then true else false "Boolean to add remove additional heat port";
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matExtWal(
    nLay=4,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.005,
        k=0.3,
        c=840,
        d=1300,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.1,
        k=0.034,
        c=1250,
        d=23,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.3,
        k=0.207,
        c=840,
        d=750,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.02,
        k=0.570,
        c=1000,
        d=1300,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)})
    "Exterior wall"
    annotation (Placement(transformation(extent={{48,84},{62,98}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic
                                                          matFlo(final nLay=
           2,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=1.003,
        k=0.040,
        c=0,
        d=0,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.025,
        k=0.140,
        c=1200,
        d=650,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)})
                           "Floor"
    annotation (Placement(transformation(extent={{86,84},{100,98}})));
   parameter Buildings.HeatTransfer.Data.Solids.Generic soil(
    x=2,
    k=1.3,
    c=800,
    d=1500) "Soil properties"
    annotation (Placement(transformation(extent={{-80,-74},{-64,-58}})));
  Buildings.ThermalZones.Detailed.MixedAir roo(
    surBou(
      A={Afloor,11.94},
      each absIR=0.9,
      each absSol=0.9,
      til={F_,Z_}),
    redeclare package Medium = MediumA,
    hRoo=2.7,
    nConExtWin=nConExtWin,
    nConBou=nConBou,
    use_C_flow=true,
    T_start=Tstart,
    C_start={400e-6},
    nPorts=5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=Afloor,
    datConBou(
      layers={matRoof,matAptSep,matElevatorSep},
      A={Afloor,11.94,14.28},
      til={C_,Z_,Z_},
      azi={S_,E_,N_},
      each stateAtSurface_a=false),
    nConExt=0,
    nConPar=0,
    nSurBou=nSurBou,
    datConExtWin(
      layers={matExtWal},
      A={5.3*2.7},
      glaSys={W24},
      wWin={1.6},
      hWin={2.35},
      fFra={0.001},
      til={Z_},
      azi={S_}),
    lat(displayUnit="rad") = 0.7937268746) "Night zone APT 25 E06 Merezzate+"
    annotation (Placement(transformation(extent={{34,6},{64,36}})));
  Modelica.Blocks.Routing.Multiplex3 Qints
    annotation (Placement(transformation(extent={{-28,60},{-20,68}})));
  Modelica.Blocks.Sources.Constant uSha(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{6,68},{14,76}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=max(1,nConExtWin))
    annotation (Placement(transformation(extent={{18,66},{26,74}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matRoof(nLay=7,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.015,
        k=1,
        c=840,
        d=2300,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.064,
        k=1,
        c=880,
        d=1800,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.026,
        k=0.034,
        c=1300,
        d=25,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                       Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.006,
        k=0.113,
        c=2100,
        d=450,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                       Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.105,
        k=0.1,
        c=1200,
        d=400,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                       Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.230,
        k=2.3,
        c=1000,
        d=2300,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef*3),
                       Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.02,
        k=0.8,
        c=1000,
        d=1600,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)})
                           "Roof"
    annotation (Placement(transformation(extent={{68,84},{82,98}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData
                                           sinInf(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_C_in=true,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{8,-12},{16,-4}})));
  Modelica.Blocks.Sources.Constant InfiltrationRate(k=AirChange)
    "0.41 ACH adjusted for the altitude (0.5 at sea level)"
    annotation (Placement(transformation(extent={{-78,2},{-70,10}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-40,2},{-32,10}})));
  Buildings.Fluid.Sensors.Density density(redeclare package Medium = MediumA,
      warnAboutOnePortConnection=false)
    "Air density inside the building"
    annotation (Placement(transformation(extent={{-34,-20},{-44,-10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAirSen
    "Room air temperature"
    annotation (Placement(transformation(extent={{66,18},{76,28}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=1)
    annotation (Placement(transformation(extent={{-64,2},{-56,10}})));
  Modelica.Blocks.Interfaces.RealOutput TRooAir "Room air temperature"
    annotation (Placement(transformation(extent={{160,28},{180,48}}),
        iconTransformation(extent={{160,28},{180,48}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData
                                           souInf(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_C_in=true,
    nPorts=1) "source model for air infiltration"
    annotation (Placement(transformation(extent={{8,0},{16,8}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-16,2},{-8,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium = MediumA) "Supply air"
    annotation (Placement(transformation(extent={{-110,22},{-90,42}}),
        iconTransformation(extent={{-110,22},{-90,42}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA) "Return air"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}}),
        iconTransformation(extent={{-110,-30},{-90,-10}})));
  TwoZoneApartmentHydronic.Components.BaseClasses.InternalLoad lig(
    radFraction=0.5,
    latPower_nominal=0,
    senPower_nominal=1.5)
    annotation (Placement(transformation(extent={{-100,48},{-88,60}})));
  TwoZoneApartmentHydronic.Components.BaseClasses.InternalLoad equ(
    latPower_nominal=0,
    senPower_nominal=4,
    radFraction=0.5)
    annotation (Placement(transformation(extent={{-100,72},{-88,84}})));
  TwoZoneApartmentHydronic.Components.BaseClasses.OccupancyLoad occ(
    radFraction=0.5,
    co2Gen=8.64e-6,
    occ_density=1/Afloor,
    senPower=60,
    latPower=20)
    annotation (Placement(transformation(extent={{-100,60},{-88,72}})));
  Modelica.Blocks.Math.MultiSum sumRad(nu=3) "Sum of radiant internal gains"
    annotation (Placement(transformation(extent={{-48,76},{-42,82}})));
  Modelica.Blocks.Math.MultiSum sumCon(nu=3) "Sum of convective internal gains"
    annotation (Placement(transformation(extent={{-50,66},{-44,72}})));
  Modelica.Blocks.Math.MultiSum sumLat(nu=3) "Sum of latent internal gains"
    annotation (Placement(transformation(extent={{-48,56},{-42,62}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPLig(y(unit="W"), description=
        "Lighting power submeter") "Read lighting power consumption"
    annotation (Placement(transformation(extent={{-26,46},{-18,54}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPPlu(y(unit="W"), description=
        "Plug load power submeter") "Read plug load power consumption"
    annotation (Placement(transformation(extent={{-26,88},{-18,96}})));
  Modelica.Blocks.Math.MultiSum sumLig(k=fill(roo.AFlo, 2), nu=2)
    "Lighting power consumption"
    annotation (Placement(transformation(extent={{-48,46},{-42,52}})));
  Modelica.Blocks.Math.MultiSum sumPlu(k=fill(roo.AFlo, 2), nu=2)
    "Plug power consumption"
    annotation (Placement(transformation(extent={{-48,88},{-42,94}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTRooAir(
    description="Zone air temperature",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K"),
    zone=zonName)
                 "Read room air temperature"
    annotation (Placement(transformation(extent={{86,18},{98,30}})));
  Buildings.Utilities.IO.SignalExchange.Read reaCO2RooAir(
    description="Zone air CO2 concentration",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm"),
    zone=zonName)  "Read room air CO2 concentration"
    annotation (Placement(transformation(extent={{82,-6},{92,4}})));
  Modelica.Blocks.Interfaces.RealOutput CO2RooAir(unit="ppm") "Room air CO2 concentration"
    annotation (Placement(transformation(extent={{160,-26},{180,-6}}),
        iconTransformation(extent={{160,-26},{180,-6}})));
  Modelica.Blocks.Sources.Constant conCO2Out(k=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
        /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Outside air CO2 concentration"
    annotation (Placement(transformation(extent={{-32,-14},{-26,-8}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2(
    redeclare package Medium = MediumA, m_flow_nominal=-AirChange)
                    "CO2 sensor"
    annotation (Placement(transformation(extent={{30,-10},{20,0}})));
  Modelica.Blocks.Math.Gain gaiCO2Gen(k=Afloor)
    "Gain for CO2 generation by floor area"
    annotation (Placement(transformation(extent={{-46,22},{-38,30}})));
  Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{56,-6},{66,4}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(MMMea=
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{34,-6},{46,6}})));
  Buildings.Fluid.HeatExchangers.RadiantSlabs.SingleCircuitSlab radiantSlab(
    sysTyp=Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.SystemType.Floor,
    steadyStateInitial=false,
    iLayPip=2,
    T_a_start=Tstart,
    T_b_start=Tstart,
    redeclare package Medium = MediumW,
    pipe=pipe,
    layers=slaCon,
    p_start=300000,
    T_start=Tstart + 3,
    allowFlowReversal=true,
    m_flow_nominal=mflow_n,
    from_dp=false,
    dp_nominal=dp_nominal,
    linearizeFlowResistance=true,
    A=Afloor,
    length=60,
    disPip=0.1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    stateAtSurface_b=true,
    heatTransfer=Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.HeatTransfer.FiniteDifference,
    T_c_start=Tstart)       "Floor Radiant Slab"
    annotation (Placement(transformation(extent={{8,-104},{28,-84}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic
    slaCon(nLay=7,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.015,
        k=1,
        c=840,
        d=2300,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.064,
        k=1,
        c=880,
        d=1800,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0281,
        k=0.034,
        c=1300,
        d=25,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.006,
        k=0.113,
        c=2100,
        d=450,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.105,
        k=0.1,
        c=1200,
        d=400,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.230,
        k=2.3,
        c=1000,
        d=2300,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.02,
        k=0.8,
        c=1000,
        d=1600,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)}) "Construction of the slab"
    annotation (Placement(transformation(extent={{-98,-98},{-82,-82}})));
  parameter Buildings.Fluid.Data.Pipes.PEX_RADTEST pipe(
    dIn=0.015,
    dOut=0.017,
    roughness(displayUnit="m"),
    d(displayUnit="kg/m3"),
    k=0.4)
    annotation (Placement(transformation(extent={{-98,-74},{-84,-60}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnWater(redeclare package Medium =
        MediumW) "Return water" annotation (Placement(transformation(
          extent={{44,-160},{64,-140}}),iconTransformation(extent={{44,-160},{64,
            -140}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyWater(redeclare package Medium =
        MediumW) "Supply water" annotation (Placement(transformation(
          extent={{-60,-104},{-40,-84}}), iconTransformation(extent={{-64,-160},
            {-44,-140}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matIntWall(
    nLay=5,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={            Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=1025,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                          Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=710,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                          Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.07,
        k=0.04,
        c=840,
        d=40,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                          Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=710,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                            Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=1025,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)})
    "Interior Wall separator"
    annotation (Placement(transformation(extent={{40,64},{54,78}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matAptSep(
    nLay=7,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=1025,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=710,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.07,
        k=0.04,
        c=840,
        d=40,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.250,
        c=1000,
        d=710,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.07,
        k=0.04,
        c=840,
        d=40,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=710,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=1025,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)})
    "Right wall separating apartments"
    annotation (Placement(transformation(extent={{64,64},{78,78}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matElevatorSep(
    nLay=5,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.02,
        k=0.57,
        c=1000,
        d=1300,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.3,
        k=2.15,
        c=880,
        d=2400,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.045,
        k=0.038,
        c=1030,
        d=13,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.250,
        c=1000,
        d=710,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
        Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0125,
        k=0.25,
        c=1000,
        d=1025,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)})
    "Upper wall separating apartment from elevator/stairs"
    annotation (Placement(transformation(extent={{84,64},{98,78}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surf_conBou[nConBou]
    "Heat port at surface b of construction conBou"                                                                        annotation (
      Placement(transformation(extent={{-22,-42},{-8,-28}}),
        iconTransformation(extent={{2,-32},{22,-12}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-116,-64},{-76,-24}}), iconTransformation(
          extent={{-200,-10},{-180,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a FloorHeatingH
    "Heat port at surface b of construction conBou" annotation (Placement(
        transformation(extent={{14,-124},{28,-110}}),
                                                    iconTransformation(extent=
           {{74,-122},{94,-102}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surf_surBou if have_surBou
    "Heat port at surface b of construction surBou" annotation (Placement(
        transformation(extent={{84,-44},{98,-30}}), iconTransformation(extent=
           {{70,-34},{90,-14}})));
  parameter BaseClasses.Data.Window24 W24
    annotation (Placement(transformation(extent={{24,84},{40,100}})));
  Modelica.Blocks.Math.MultiSum Qint(k={Afloor,Afloor,Afloor},                nu=3)
    annotation (Placement(transformation(extent={{-2,86},{4,92}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tfloor
    "Room air temperature"
    annotation (Placement(transformation(extent={{26,-82},{38,-70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temSup(redeclare package Medium =
        MediumW, m_flow_nominal=mflow_n)
    annotation (Placement(transformation(extent={{-5,-6},{5,6}},
        rotation=0,
        origin={-27,-94})));
  Buildings.Fluid.Sensors.MassFlowRate mflowTotin(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{-14,-100},{-2,-88}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temRet(redeclare package Medium =
        MediumW, m_flow_nominal=mflow_n) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={40,-94})));
  Modelica.Blocks.Math.MatrixGain matrixGain(K=[qint,0,0; 0,qint,0; 0,0,qint])
    annotation (Placement(transformation(extent={{-16,62},{-6,72}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTsupFloHea(description=
        "Zone supply water temperature floor heating",
                                                 y(unit="K"))
    "Supply temperature Floor heating"
    annotation (Placement(transformation(extent={{104,-58},{114,-48}})));
  Buildings.Utilities.IO.SignalExchange.Read reaMFloHea(description=
        "Zone water mass flow rate floor heating",
                                        y(unit="kg/s"))
    "Mass flow rate floor heating"
    annotation (Placement(transformation(extent={{104,-72},{114,-62}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTretFloHea(description=
        "Zone return water temperature floor heating",
                                                 y(unit="K"))
    "Return temperature Floor heating"
    annotation (Placement(transformation(extent={{104,-86},{114,-76}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTavgFloHea(description=
        "Zone average floor temperature",         y(unit="K"))
    "Average temperature Floor heating"
    annotation (Placement(transformation(extent={{104,-44},{114,-34}})));
  Modelica.Blocks.Sources.RealExpression powFloHeat(y=(mflowTotin.m_flow*
        4186*(temSup.T - temRet.T)))  "Floor heating thermal power"
    annotation (Placement(transformation(extent={{60,-104},{78,-86}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPowFlooHea(
    y(unit="W"),
    description="Floor heating power") "Reading of floor heating"
    annotation (Placement(transformation(extent={{104,-100},{114,-90}})));
  Modelica.Blocks.Sources.RealExpression avgTfloHea(y=(Tfloor.T +radiantSlab.con_a[
        1].T[1]                   +radiantSlab.con_a[1].T[2]) /3)
    "Floor heating thermal power"
    annotation (Placement(transformation(extent={{54,-58},{74,-38}})));
  Modelica.Blocks.Math.Gain powerCon(k=1) "Converts kW to W"
    annotation (Placement(transformation(extent={{88,-100},{98,-90}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPowQint(y(unit="W"),
      description="Internal heat gains") "Internal heat gain power"
    annotation (Placement(transformation(extent={{10,84},{20,94}})));
  Modelica.Blocks.Interfaces.RealInput occupation annotation (Placement(
        transformation(extent={{-160,64},{-120,104}}), iconTransformation(
          extent={{-160,64},{-120,104}})));
  parameter Modelica.SIunits.PressureDifference dp_nominal=10000
    "Pressure difference";
equation
  connect(roo.uSha, replicator.y) annotation (Line(
      points={{32.8,34.5},{30,34.5},{30,34},{28,34},{28,70},{26.4,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(uSha.y, replicator.u) annotation (Line(
      points={{14.4,72},{14,72},{14,70},{17.2,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, sinInf.m_flow_in)       annotation (Line(
      points={{-31.6,6},{-30,6},{-30,-4.8},{8,-4.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(density.port, roo.ports[1])  annotation (Line(
      points={{-39,-20},{32,-20},{32,11.1},{37.75,11.1}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(density.d, product.u2) annotation (Line(
      points={{-44.5,-15},{-46,-15},{-46,3.6},{-40.8,3.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiSum.y, product.u1) annotation (Line(
      points={{-55.32,6},{-44,6},{-44,8.4},{-40.8,8.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(InfiltrationRate.y, multiSum.u[1]) annotation (Line(
      points={{-69.6,6},{-64,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TRooAirSen.port, roo.heaPorAir) annotation (Line(points={{66,23},{
          56,23},{56,21},{48.25,21}},color={191,0,0}));
  connect(gain.y, souInf.m_flow_in) annotation (Line(points={{-7.6,6},{6,6},{6,7.2},
          {8,7.2}},                        color={0,0,127}));
  connect(gain.u, sinInf.m_flow_in) annotation (Line(points={{-16.8,6},{-30,6},{
          -30,-4.8},{8,-4.8}},      color={0,0,127}));
  connect(souInf.ports[1], roo.ports[2]) annotation (Line(points={{16,4},{20,
          4},{20,12.3},{37.75,12.3}},     color={0,127,255}));
  connect(supplyAir, roo.ports[3]) annotation (Line(points={{-100,32},{-80,32},{
          -80,16},{38,16},{38,14},{37.75,14},{37.75,13.5}},
                                   color={0,127,255}));
  connect(occ.rad, sumRad.u[1]) annotation (Line(points={{-87.4,68.4},{-60,68.4},
          {-60,80.4},{-48,80.4}},
                             color={0,0,127}));
  connect(equ.rad, sumRad.u[2]) annotation (Line(points={{-87.4,80.4},{-60,80.4},
          {-60,79},{-48,79}},
                         color={0,0,127}));
  connect(lig.rad, sumRad.u[3]) annotation (Line(points={{-87.4,56.4},{-58,56.4},
          {-58,77.6},{-48,77.6}},
                             color={0,0,127}));
  connect(occ.con, sumCon.u[1]) annotation (Line(points={{-87.4,66},{-64,66},{-64,
          70.4},{-50,70.4}}, color={0,0,127}));
  connect(equ.con, sumCon.u[2]) annotation (Line(points={{-87.4,78},{-64,78},{-64,
          72},{-56,72},{-56,69},{-50,69}},
                         color={0,0,127}));
  connect(lig.con, sumCon.u[3]) annotation (Line(points={{-87.4,54},{-60,54},{-60,
          67.6},{-50,67.6}}, color={0,0,127}));
  connect(occ.lat, sumLat.u[1]) annotation (Line(points={{-87.4,63.6},{-72,63.6},
          {-72,60.4},{-48,60.4}},
                             color={0,0,127}));
  connect(equ.lat, sumLat.u[2]) annotation (Line(points={{-87.4,75.6},{-74,75.6},
          {-74,59},{-48,59}},
                         color={0,0,127}));
  connect(lig.lat, sumLat.u[3]) annotation (Line(points={{-87.4,51.6},{-62,51.6},
          {-62,52},{-54,52},{-54,58},{-48,58},{-48,57.6}},
                                    color={0,0,127}));
  connect(sumRad.y, Qints.u1[1]) annotation (Line(points={{-41.49,79},{-32,
          79},{-32,66.8},{-28.8,66.8}}, color={0,0,127}));
  connect(sumCon.y, Qints.u2[1]) annotation (Line(points={{-43.49,69},{-42,
          69},{-42,64},{-28.8,64}}, color={0,0,127}));
  connect(sumLat.y, Qints.u3[1]) annotation (Line(points={{-41.49,59},{-32,
          59},{-32,61.2},{-28.8,61.2}}, color={0,0,127}));
  connect(sumLig.y, reaPLig.u)
    annotation (Line(points={{-41.49,49},{-38,49},{-38,50},{-26.8,50}},
                                                    color={0,0,127}));
  connect(sumPlu.y, reaPPlu.u)
    annotation (Line(points={{-41.49,91},{-38,91},{-38,92},{-26.8,92}},
                                                    color={0,0,127}));
  connect(equ.con, sumPlu.u[1]) annotation (Line(points={{-87.4,78},{-68,78},{-68,
          92.05},{-48,92.05}},
                             color={0,0,127}));
  connect(equ.rad, sumPlu.u[2]) annotation (Line(points={{-87.4,80.4},{-70,80.4},
          {-70,89.95},{-48,89.95}},
                           color={0,0,127}));
  connect(lig.rad, sumLig.u[1]) annotation (Line(points={{-87.4,56.4},{-80,56.4},
          {-80,50.05},{-48,50.05}},
                             color={0,0,127}));
  connect(lig.con, sumLig.u[2]) annotation (Line(points={{-87.4,54},{-82,54},{-82,
          47.95},{-48,47.95}},
                             color={0,0,127}));
  connect(TRooAirSen.T, reaTRooAir.u) annotation (Line(points={{76,23},{78,23},{
          78,24},{84.8,24}},
                           color={0,0,127}));
  connect(reaTRooAir.y, TRooAir)
    annotation (Line(points={{98.6,24},{134,24},{134,38},{170,38}},
                                               color={0,0,127}));
  connect(reaCO2RooAir.y, CO2RooAir) annotation (Line(points={{92.5,-1},{94,-1},
          {94,-16},{170,-16}},  color={0,0,127}));
  connect(returnAir, roo.ports[4]) annotation (Line(points={{-100,-20},{-80,-20},
          {-80,14.7},{37.75,14.7}},   color={0,127,255}));
  connect(sinInf.ports[1], senCO2.port_b)
    annotation (Line(points={{16,-8},{16,-5},{20,-5}},
                                               color={0,127,255}));
  connect(senCO2.port_a, roo.ports[5]) annotation (Line(points={{30,-5},{30,
          15.9},{37.75,15.9}},       color={0,127,255}));
  connect(occ.co2, gaiCO2Gen.u) annotation (Line(points={{-87.4,61.2},{-76,61.2},
          {-76,26},{-46.8,26}},
                           color={0,0,127}));
  connect(gaiCO2Gen.y, roo.C_flow[1]) annotation (Line(points={{-37.6,26},{
          -1.75,26},{-1.75,23.1},{32.8,23.1}},
                                            color={0,0,127}));
  connect(conCO2Out.y, sinInf.C_in[1]) annotation (Line(points={{-25.7,-11},{-16,
          -11},{-16,-11.2},{8,-11.2}},   color={0,0,127}));
  connect(conCO2Out.y, souInf.C_in[1]) annotation (Line(points={{-25.7,-11},{-16,
          -11},{-16,0.8},{8,0.8}},     color={0,0,127}));
  connect(gaiPPM.y, reaCO2RooAir.u)
    annotation (Line(points={{66.5,-1},{81,-1}},   color={0,0,127}));
  connect(senCO2.C, conMasVolFra.m)
    annotation (Line(points={{25,0.5},{25,0},{33.4,0}},   color={0,0,127}));
  connect(conMasVolFra.V, gaiPPM.u)
    annotation (Line(points={{46.6,0},{50,0},{50,-1},{55,-1}},
                                                 color={0,0,127}));
  connect(roo.surf_surBou[1],radiantSlab. surf_a) annotation (Line(points={{46.15,
          10.125},{46.15,-13.75},{22,-13.75},{22,-84}},
                                                      color={191,0,0}));
  connect(surf_conBou, roo.surf_conBou) annotation (Line(points={{-15,-35},{34,-35},
          {34,-8},{54,-8},{54,9},{53.5,9}},
                                   color={191,0,0}));
  connect(weaBus, sinInf.weaBus) annotation (Line(
      points={{-96,-44},{-50,-44},{-50,-7.92},{8,-7.92}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, souInf.weaBus) annotation (Line(
      points={{-96,-44},{-52,-44},{-52,4.08},{8,4.08}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, roo.weaBus) annotation (Line(
      points={{-96,-44},{-68,-44},{-68,44},{66,44},{66,34.425},{62.425,34.425}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(radiantSlab.surf_b, FloorHeatingH) annotation (Line(points={{22,-104},
          {28,-104},{28,-116},{24,-116},{24,-117},{21,-117}},
                                       color={191,0,0}));
  connect(surf_surBou, roo.surf_surBou[2]) annotation (Line(points={{91,-37},{
          91,-27.5},{46.15,-27.5},{46.15,10.875}},  color={191,0,0}));
  connect(radiantSlab.surf_a, Tfloor.port) annotation (Line(points={{22,-84},{26,
          -84},{26,-76}},          color={191,0,0}));
  connect(temSup.port_b, mflowTotin.port_a)
    annotation (Line(points={{-22,-94},{-14,-94}},color={0,127,255}));
  connect(mflowTotin.port_b,radiantSlab. port_a) annotation (Line(points={{-2,-94},
          {8,-94}},                    color={0,127,255}));
  connect(temSup.port_a, supplyWater) annotation (Line(points={{-32,-94},{-50,-94}},
                                color={0,127,255}));
  connect(radiantSlab.port_b, temRet.port_a) annotation (Line(points={{28,-94},{
          34,-94}},                   color={0,127,255}));
  connect(temRet.port_b, returnWater) annotation (Line(points={{46,-94},{46,-150},
          {54,-150}},           color={0,127,255}));
  connect(Qints.y, matrixGain.u)
    annotation (Line(points={{-19.6,64},{-17,64},{-17,67}}, color={0,0,127}));
  connect(matrixGain.y, Qint.u[1:3]) annotation (Line(points={{-5.5,67},{-5.5,86},
          {-6,86},{-6,88},{-2,88},{-2,87.6}},
                                color={0,0,127}));
  connect(matrixGain.y, roo.qGai_flow) annotation (Line(points={{-5.5,67},{0,67},
          {0,68},{4,68},{4,27},{32.8,27}},
                                     color={0,0,127}));
  connect(temRet.T, reaTretFloHea.u) annotation (Line(points={{40,-87.4},{40,-80},
          {98,-80},{98,-81},{103,-81}}, color={0,0,127}));
  connect(temSup.T, reaTsupFloHea.u) annotation (Line(points={{-27,-87.4},{-28,
          -87.4},{-28,-53},{103,-53}}, color={0,0,127}));
  connect(mflowTotin.m_flow, reaMFloHea.u) annotation (Line(points={{-8,-87.4},
          {-8,-66},{102,-66},{102,-67},{103,-67}}, color={0,0,127}));
  connect(avgTfloHea.y, reaTavgFloHea.u) annotation (Line(points={{75,-48},{100,
          -48},{100,-39},{103,-39}}, color={0,0,127}));
  connect(powerCon.u, powFloHeat.y) annotation (Line(points={{87,-95},{78.9,-95}},
                                     color={0,0,127}));
  connect(powerCon.y, reaPowFlooHea.u) annotation (Line(points={{98.5,-95},{103,
          -95}},                              color={0,0,127}));
  connect(occupation, equ.occupation) annotation (Line(points={{-140,84},{-121,84},
          {-121,78},{-100.12,78}}, color={0,0,127}));
  connect(occupation, occ.occupation) annotation (Line(points={{-140,84},{-122,84},
          {-122,65.88},{-100.12,65.88}}, color={0,0,127}));
  connect(occupation, lig.occupation) annotation (Line(points={{-140,84},{-122,84},
          {-122,54},{-100.12,54}}, color={0,0,127}));
  connect(Qint.y, reaPowQint.u) annotation (Line(points={{4.51,89},{4,89},{4,90},
          {6,90},{6,89},{9,89}},         color={0,0,127}));
  annotation (
experiment(
      StopTime=1080000,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/Detailed/Validation/BESTEST/Cases6xx/Case600FF.mos"
        "Simulate and plot"), Documentation(info="<html>
<p>
This is the thermal zone reference model used for both Day and Night zone in the two room apartment
</p>
</html>", revisions="<html>
<ul>
<li>
August 5, 2022, by Ettore Zanetti:<br/>
Revision after comments
</li>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
Adaptation with addition of floor heating.
</li>
<li>
October 29, 2016, by Michael Wetter:<br/>
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
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
October 9, 2013, by Michael Wetter:<br/>
Implemented soil properties using a record so that <code>TSol</code> and
<code>TLiq</code> are assigned.
This avoids an error when the model is checked in the pedantic mode.
</li>
<li>
July 15, 2012, by Michael Wetter:<br/>
Added reference results.
Changed implementation to make this model the base class
for all BESTEST cases.
Added computation of hourly and annual averaged room air temperature.
<li>
October 6, 2011, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-160,-160},{160,160}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-140,138},{140,-140}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{140,70},{160,-70}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{146,70},{154,-70}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}));
end thermalZone;
