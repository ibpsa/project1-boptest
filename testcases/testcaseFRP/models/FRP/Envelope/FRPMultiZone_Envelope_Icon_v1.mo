within FRP.Envelope;
model FRPMultiZone_Envelope_Icon_v1
  "FRP MultiZone envelope icon with  FRP construction"
  import ModelicaServices;

constant Integer nStaRef=3;
package MediumA = Buildings.Media.Air "Medium model";
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

parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matExtWal(
  nLay=6,
  absIR_a=0.9,
  absIR_b=0.9,
  absSol_a=0.6,
  absSol_b=0.6,
  material={Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.092,
      k=1.31,
      c=920.48,
      d=2082.3,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.004106,
      k=0.0262,
      c=0.000718,
      d=1.2,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.1015,
      k=1.31,
      c=920,
      d=1121.3,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.1015,
      k=1.31,
      c=920,
      d=1121.3,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.0889,
      k=0.02884,
      c=1210,
      d=32,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.0158,
      k=0.16,
      c=1090,
      d=784.9,
      nStaRef=nStaRef)}) "Exterior wall"
  annotation (Placement(transformation(extent={{-208,100},{-178,130}})));

parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic           matExtWal1(
  nLay=6,
  absIR_a=0.9,
  absIR_b=0.9,
  absSol_a=0.6,
  absSol_b=0.6,
  material={Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.092,
      k=1.31,
      c=920.48,
      d=2082.3,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.004106,
      k=0.0262,
      c=0.000718,
      d=1.2,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.203,
      k=1.31,
      c=920,
      d=1121.3,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.0889,
      k=0.02884,
      c=1210,
      d=32,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.004706,
      k=0.0262,
      c=0.000718,
      d=1.2,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.0158,
      k=0.16,
      c=1090,
      d=784.9,
      nStaRef=nStaRef)}) "Exterior wall"
  annotation (Placement(transformation(extent={{-168,100},{-138,130}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic           matExtWal2(
    nLay=6,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.092,
        k=1.31,
        c=920.48,
        d=2082.3,
        nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.004106,
        k=0.0262,
        c=0.000718,
        d=1.2,
        nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.203,
        k=1.31,
        c=920,
        d=1121.3,
        nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0889,
        k=0.02884,
        c=1210,
        d=32,
        nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.058,
        k=0.02605,
        c=920,
        d=32,
        nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0158,
        k=0.16,
        c=1090,
        d=784.9,
        nStaRef=nStaRef)})
                         "Exterior wall"
  annotation (Placement(transformation(extent={{-128,100},{-98,130}})));
parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic           matIntWal(
  nLay=1,
  absIR_a=0.9,
  absIR_b=0.9,
  absSol_a=0.6,
  absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0127,
        k=0.16,
        c=1090,
        d=800,
        nStaRef=nStaRef)}) "Exterior wall"
  annotation (Placement(transformation(extent={{-90,100},{-60,130}})));

parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic
                                                        matFlo(
  nLay=3,
  absIR_a=0.9,
  absIR_b=0.9,
  absSol_a=0.6,
  absSol_b=0.6,
  material={Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.1524,
      k=1.95,
      c=900,
      d=2322.6,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.3048,
      k=0.033,
      c=836.8,
      d=51.5,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.3048,
      k=1.95,
      c=900,
      d=2322.6,
      nStaRef=nStaRef)})
  "Floor"
  annotation (Placement(transformation(extent={{22,100},{54,132}})));
parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matFlo1(
  nLay=1,
  absIR_a=0.9,
  absIR_b=0.9,
  absSol_a=0.6,
  absSol_b=0.6,
  material={Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.0825,
      k=1.95,
      c=900,
      d=2322.6,
      nStaRef=nStaRef)}) "Exterior wall"
    annotation (Placement(transformation(extent={{60,100},{90,130}})));

parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic roof(
  nLay=4,
  absIR_a=0.9,
  absIR_b=0.9,
  absSol_a=0.6,
  absSol_b=0.6,
  material={Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.019,
      k=0.115,
      c=1213,
      d=545,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.0762,
      k=0.024023,
      c=836.8,
      d=265,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.0095,
      k=0.16,
      c=1460,
      d=1121.3,
      nStaRef=nStaRef),Buildings.HeatTransfer.Data.Solids.Generic(
      x=0.0015,
      k=45.006,
      c=418.4,
      d=7680,
      nStaRef=nStaRef)}) "Roof"
  annotation (Placement(transformation(extent={{-16,100},{16,132}})));

parameter FRP.BaseClasses.DoubleClearAir16Clear windowFRP
    annotation (Placement(transformation(extent={{-50,100},{-20,130}})));

Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "Resources/FRP2018.mos"))
  annotation (Placement(transformation(extent={{282,-130},{270,-118}})));

Buildings.Fluid.Sources.MassFlowSource_T sinInf204(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-116,18},{-104,30}})));
Buildings.Fluid.Sources.Outside souInf204(redeclare package Medium = MediumA,
      nPorts=1) "Source model for air infiltration"
    annotation (Placement(transformation(extent={{-128,-76},{-116,-64}})));
Modelica.Blocks.Sources.Constant Infilt204(k=1.2*35.273*2.743*0.432/3600)
    "0.432ACH"
    annotation (Placement(transformation(extent={{-146,16},{-134,28}})));
Buildings.BoundaryConditions.WeatherData.Bus weaBus
  annotation (Placement(transformation(extent={{-106,-156},{-90,-140}}),
        iconTransformation(extent={{-106,-156},{-90,-140}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir204
    "Room air temperature"
    annotation (Placement(transformation(extent={{233,-21},{250,-4}})));

Buildings.ThermalZones.Detailed.MixedAir roo204(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=1,
  nConExtWin=2,
  nConBou=4,
  nPorts=4,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
  AFlo=35.273,
  nConPar=0,
  nSurBou=0,
    datConExt(
      layers={roof},
      A={35.27},
      til={C_},
      azi={S_}),
    datConExtWin(
      layers={matExtWal2,matExtWal2},
      A={20.07,15.05},
      glaSys={windowFRP,windowFRP},
      wWin={4.11,4.11},
      hWin={1.95,1.95},
      fFra={0.118957,0.118957},
      til={Z_,Z_},
      azi={N_,W_}),
    datConBou(
      layers={matFlo1,matIntWal,matIntWal,matIntWal},
      A={35.27,11.01,11.01,13.10},
      til={F_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{-34,-66},{18,-26}})));

Buildings.ThermalZones.Detailed.MixedAir roo203(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=1,
  nConExtWin=1,
  nConBou=5,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=15.95,
  nConPar=0,
  nSurBou=0,
    datConExt(
      layers={roof},
      A={15.95},
      til={C_},
      azi={S_}),
    datConExtWin(
      layers={matExtWal},
      A={7.80},
      glaSys={windowFRP},
      wWin={2.05},
      hWin={1.95},
      fFra={0.118957},
      til={Z_},
      azi={N_}),
    datConBou(
      layers={matFlo1,matIntWal,matIntWal,matIntWal,matIntWal},
      A={15.95,11.01,20.07,13.10,3.76},
      til={F_,Z_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{40,-70},{86,-40}})));
Buildings.ThermalZones.Detailed.MixedAir roo206(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=1,
  nConExtWin=2,
  nConBou=5,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=35.27,
  nConPar=0,
  nSurBou=0,
    datConExt(
      layers={roof},
      A={35.27},
      til={C_},
      azi={S_}),
    datConExtWin(
      layers={matExtWal,matExtWal},
      A={20.07,15.05},
      glaSys={windowFRP,windowFRP},
      wWin={4.11,4.11},
      hWin={1.95,1.95},
      fFra={0.119,0.119},
      til={Z_,Z_},
      azi={S_,E_}),
    datConBou(
      layers={matFlo1,matIntWal,matIntWal,matIntWal,matIntWal},
      A={35.27,11.01,13.10,3.76,7.25},
      til={F_,Z_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{60,-174},{106,-144}})));
Buildings.ThermalZones.Detailed.MixedAir roo202(
    redeclare package Medium = MediumA,
    hRoo=2.743,
    nConExt=1,
    nConExtWin=0,
    nConBou=5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=22.80,
    nConPar=0,
    nSurBou=0,
    datConExt(
      layers={roof},
      A={22.80},
      til={C_},
      azi={S_}),
    datConBou(
      layers={matFlo1,matIntWal,matIntWal,matIntWal,matIntWal},
      A={22.80,13.10,13.10,13.10,13.10},
      til={F_,Z_,Z_,Z_,Z_}),
    lat=weaDat.lat,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
    "Room model for Case 600"
    annotation (Placement(transformation(extent={{2,-120},{48,-90}})));
Buildings.ThermalZones.Detailed.MixedAir roo205(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=1,
  nConExtWin=2,
  nConBou=4,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=35.27,
  nConPar=0,
  nSurBou=0,
    datConExt(
      layers={roof},
      A={35.27},
      til={C_},
      azi={S_}),
    datConExtWin(
      layers={matExtWal,matExtWal},
      A={15.05,20.07},
      glaSys={windowFRP,windowFRP},
      wWin={4.11,4.11},
      hWin={1.95,1.95},
      fFra={0.119,0.119},
      til={Z_,Z_},
      azi={S_,W_}),
    datConBou(
      layers={matFlo1,matIntWal,matIntWal,matIntWal},
      A={35.27,11.01,11.01,13.10},
      til={F_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{-50,-164},{-4,-134}})));
Buildings.ThermalZones.Detailed.MixedAir roo201(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=1,
  nConExtWin=2,
  nConBou=3,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=19.32,
  nConPar=0,
  nSurBou=0,
    datConExt(
      layers={roof},
      A={19.32},
      til={C_},
      azi={S_}),
    datConExtWin(
      layers={matExtWal,matExtWal},
      A={7.25,20.07},
      glaSys={windowFRP,windowFRP},
      wWin={2.05,4.11},
      hWin={1.95,1.95},
      fFra={0.119,0.119},
      til={Z_,Z_},
      azi={N_,E_}),
    datConBou(
      layers={matFlo1,matIntWal,matIntWal},
      each A=35.273,
      each til=F_),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{116,-82},{162,-52}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf104(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-158,-218},{-146,-206}})));
Modelica.Blocks.Sources.Constant Infilt104(k=1.2*35.27*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-188,-216},{-178,-206}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir104
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-292},{252,-276}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea12
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{-32,-334},{-20,-322}})));
Modelica.Blocks.Sources.RealExpression realExpression12
  annotation (Placement(transformation(extent={{-52,-336},{-38,-320}})));
Buildings.ThermalZones.Detailed.MixedAir roo104(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=0,
  nConExtWin=2,
  nConBou=5,
  nPorts=3,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=35.27,
  nConPar=0,
  nSurBou=0,
    datConExtWin(
      layers={matExtWal1,matExtWal1},
      A={20.07,15.05},
      glaSys={windowFRP,windowFRP},
      wWin={4.11,4.11},
      hWin={1.95,1.95},
      fFra={0.119,0.119},
      til={Z_,Z_},
      azi={N_,W_}),
    datConBou(
      layers={matFlo,matIntWal,matIntWal,matIntWal,matFlo1},
      A={35.27,11.01,11.01,13.10,35.27},
      til={F_,Z_,Z_,Z_,C_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{-44,-322},{8,-282}})));
Buildings.ThermalZones.Detailed.MixedAir roo102(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=0,
  nConExtWin=1,
  nConBou=6,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=15.95,
  nConPar=0,
  nSurBou=0,
    datConExtWin(
      layers={matExtWal},
      A={7.80},
      glaSys={windowFRP},
      wWin={1.40},
      hWin={2.36},
      fFra={0.296},
      til={Z_},
      azi={N_}),
    datConBou(
      layers={matFlo,matIntWal,matIntWal,matIntWal,matIntWal,matFlo1},
      A={15.95,11.01,20.07,13.10,3.76,15.95},
      til={F_,Z_,Z_,Z_,Z_,C_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{40,-336},{86,-306}})));
Buildings.ThermalZones.Detailed.MixedAir roo106(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=0,
  nConExtWin=2,
  nConBou=6,
  nPorts=3,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=35.27,
  nConPar=0,
  nSurBou=0,
    datConExtWin(
      layers={matExtWal,matExtWal},
      A={20.07,15.05},
      glaSys={windowFRP,windowFRP},
      wWin={4.11,4.11},
      hWin={1.95,1.95},
      fFra={0.119,0.119},
      til={Z_,Z_},
      azi={S_,E_}),
  datConBou(
    layers={matFlo,matIntWal,matIntWal,matIntWal,matIntWal,matFlo1},
    each A=35.273,
    each til=F_),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Room model for Case 600"
  annotation (Placement(transformation(extent={{62,-428},{108,-398}})));
Buildings.ThermalZones.Detailed.MixedAir roo103(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=0,
  nConExtWin=0,
  nConBou=6,
  nPorts=2,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=22.80,
  nConPar=0,
  nSurBou=0,
    datConBou(
      layers={matFlo,matIntWal,matIntWal,matIntWal,matIntWal,matFlo1},
      A={22.80,13.10,13.10,13.10,13.10,22.80},
      til={F_,Z_,Z_,Z_,Z_,C_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{4,-374},{50,-344}})));
Buildings.ThermalZones.Detailed.MixedAir roo105(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=0,
  nConExtWin=2,
  nConBou=5,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=35.27,
  nConPar=0,
  nSurBou=0,
    datConExtWin(
      layers={matExtWal,matExtWal},
      A={15.05,20.07},
      glaSys={windowFRP,windowFRP},
      wWin={4.11,4.11},
      hWin={1.95,1.95},
      fFra={0.119,0.119},
      til={Z_,Z_},
      azi={S_,W_}),
    datConBou(
      layers={matFlo,matIntWal,matIntWal,matIntWal,matFlo1},
      A={35.27,11.01,11.01,13.10,35.27},
      til={F_,Z_,Z_,Z_,C_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{-48,-418},{-2,-388}})));
Buildings.ThermalZones.Detailed.MixedAir roo101(
  redeclare package Medium = MediumA,
  hRoo=2.743,
  nConExt=0,
  nConExtWin=2,
  nConBou=4,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=19.32,
  nConPar=0,
  nSurBou=0,
    datConExtWin(
      layers={matExtWal,matExtWal},
      A={7.25,20.07},
      glaSys={windowFRP,windowFRP},
      wWin={2.05,6.72},
      hWin={1.95,1.95},
      fFra={0.119,0.116},
      til={Z_,Z_},
      azi={N_,E_}),
    datConBou(
      layers={matFlo,matIntWal,matIntWal,roof},
      A={19.32,11.01,7.25,19.32},
      til={F_,Z_,Z_,C_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{108,-336},{154,-306}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea13
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{-44,-436},{-32,-424}})));
Modelica.Blocks.Sources.RealExpression realExpression13
  annotation (Placement(transformation(extent={{-62,-438},{-48,-422}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea14
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{16,-386},{28,-374}})));
Modelica.Blocks.Sources.RealExpression realExpression14
  annotation (Placement(transformation(extent={{-4,-388},{10,-372}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea16
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{114,-348},{126,-336}})));
Modelica.Blocks.Sources.RealExpression realExpression16
  annotation (Placement(transformation(extent={{94,-350},{108,-334}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea17
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{38,-458},{50,-446}})));
Modelica.Blocks.Sources.RealExpression realExpression17
  annotation (Placement(transformation(extent={{12,-458},{26,-442}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea21
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{-28,-362},{-16,-350}})));
Modelica.Blocks.Sources.RealExpression realExpression21
  annotation (Placement(transformation(extent={{-48,-364},{-34,-348}})));
Buildings.BoundaryConditions.WeatherData.Bus           weaBus1
  annotation (Placement(transformation(extent={{-106,-452},{-90,-436}}),
        iconTransformation(extent={{-106,-452},{-90,-436}})));

Modelica.Blocks.Sources.Constant Infilt205(k=1.2*35.27*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-146,-6},{-134,6}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf205(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-116,-4},{-104,8}})));
Modelica.Blocks.Sources.Constant Infilt203(k=1.2*15.95*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-146,36},{-134,48}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf203(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-116,36},{-104,48}})));
Modelica.Blocks.Sources.Constant Infilt201(k=1.2*19.32*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-148,80},{-136,92}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf201(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-116,78},{-104,90}})));
Modelica.Blocks.Sources.Constant Infilt206(k=1.2*35.27*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-146,-26},{-134,-14}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir201
    "Room air temperature"
    annotation (Placement(transformation(extent={{231,43},{250,62}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir101
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-222},{252,-206}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir202
    "Room air temperature"
    annotation (Placement(transformation(extent={{234,20},{250,36}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir206
    "Room air temperature"
    annotation (Placement(transformation(extent={{234,-70},{252,-52}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir205
    "Room air temperature"
    annotation (Placement(transformation(extent={{233,-43},{250,-28}})));
Modelica.Blocks.Sources.Constant Infilt105(k=1.2*35.27*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-188,-236},{-178,-226}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf105(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-158,-238},{-146,-226}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir105
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-314},{252,-298}})));
Modelica.Blocks.Sources.Constant Infilt106(k=1.2*35.27*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-188,-258},{-178,-248}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf106(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-158,-258},{-146,-246}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir106
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-340},{252,-324}})));
Modelica.Blocks.Sources.Constant Infilt101(k=1.2*19.32*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-188,-176},{-178,-166}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf101(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-158,-182},{-146,-170}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir103
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-270},{252,-254}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir102
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-244},{252,-228}})));
Modelica.Blocks.Sources.Constant Infilt102(k=1.2*15.95*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-188,-196},{-178,-186}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf102(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-158,-200},{-146,-188}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir203
    "Room air temperature"
    annotation (Placement(transformation(extent={{234,0},{250,16}})));
Modelica.Blocks.Sources.Constant Infilt202(k=1.2*22.80*2.743*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-146,58},{-134,70}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf202(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-116,56},{-104,68}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_204[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-86,16},{-16,44}}),
        iconTransformation(extent={{-86,16},{-16,44}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_203[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{50,58},{108,84}}),
        iconTransformation(extent={{50,58},{108,84}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_202[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-72,-90},{16,-60}}),
        iconTransformation(extent={{24,0},{88,26}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf206(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-114,-22},{-102,-10}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_206[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{122,-78},{178,-50}}),
        iconTransformation(extent={{122,-78},{178,-50}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_205[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-116,-60},{-66,-34}}),
        iconTransformation(extent={{-116,-60},{-44,-32}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_104[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-150,-264},{-84,-234}}),
        iconTransformation(extent={{-112,-260},{-46,-234}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_102[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-44,-230},{26,-200}}),
        iconTransformation(extent={{54,-228},{110,-206}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_103[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-124,-348},{-54,-316}}),
        iconTransformation(extent={{24,-292},{82,-268}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_105[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-172,-388},{-108,-348}}),
        iconTransformation(extent={{-102,-350},{-42,-324}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_106[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{80,-384},{166,-352}}),
        iconTransformation(extent={{128,-360},{188,-338}})));
Buildings.Fluid.Sources.Outside souInf201(redeclare package Medium = MediumA,
      nPorts=1) "Source model for air infiltration"
    annotation (Placement(transformation(extent={{-128,-62},{-114,-48}})));
Buildings.Fluid.Sources.Outside souInf101(redeclare package Medium = MediumA,
      nPorts=1) "Source model for air infiltration"
    annotation (Placement(transformation(extent={{-130,-300},{-116,-286}})));
  Modelica.Blocks.Routing.Multiplex6 TRoo_2
    annotation (Placement(transformation(extent={{276,-32},{314,6}})));
  Modelica.Blocks.Routing.Multiplex6 TRoo_1
    annotation (Placement(transformation(extent={{286,-274},{318,-242}})));
  Modelica.Blocks.Interfaces.RealOutput TrooVecFir[6]
    "1st floor room air temperature vector" annotation (Placement(
        transformation(extent={{332,-268},{352,-248}}), iconTransformation(
          extent={{332,-268},{352,-248}})));
  Modelica.Blocks.Interfaces.RealOutput TrooVecSec[6]
    "2nd floor room air temperature vector" annotation (Placement(
        transformation(extent={{330,-24},{350,-4}}), iconTransformation(extent=
            {{330,-24},{350,-4}})));
Modelica.Blocks.Sources.Constant qConGai_flow204(k=(23.4*0.1 + 1.7*0.5)/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-268,4},{-260,12}})));
Modelica.Blocks.Sources.Constant qRadGai_flow204(k=(23.4*0.9 + 1.7*0.5)/3600)
    "Radiative heat gain"
    annotation (Placement(transformation(extent={{-256,12},{-248,20}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_2(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-230,4},{-222,12}})));
Modelica.Blocks.Sources.Constant qLatGai_flow204(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-256,-4},{-248,4}})));
Modelica.Blocks.Sources.Constant qConGai_flow203(k=10.58*0.1/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-266,-30},{-258,-22}})));
Modelica.Blocks.Sources.Constant qRadGai_flow203(k=10.58*0.9/3600)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-254,-22},{-246,-14}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_3(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-228,-30},{-220,-22}})));
Modelica.Blocks.Sources.Constant qLatGai_flow203(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-254,-38},{-246,-30}})));
Modelica.Blocks.Sources.Constant qConGai_flow201(k=12.82*0.1/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-268,-68},{-260,-60}})));
Modelica.Blocks.Sources.Constant qRadGai_flow201(k=12.82*0.9/3600)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-256,-60},{-248,-52}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_4(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-230,-68},{-222,-60}})));
Modelica.Blocks.Sources.Constant qLatGai_flow201(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-256,-74},{-248,-66}})));
Modelica.Blocks.Sources.Constant qConGai_flow202(k=(15.13*0.1 + 143.37*0.5)/
        3600)                                           "Convective heat gain"
    annotation (Placement(transformation(extent={{-268,-100},{-260,-92}})));
Modelica.Blocks.Sources.Constant qRadGai_flow202(k=(15.13*0.9 + 143.37*0.5)/
        3600)                                           "Radiative heat gain"
    annotation (Placement(transformation(extent={{-256,-92},{-248,-84}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_5(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-230,-100},{-222,-92}})));
Modelica.Blocks.Sources.Constant qLatGai_flow202(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-256,-106},{-248,-98}})));
Modelica.Blocks.Sources.Constant qConGai_flow205(k=(23.40*0.1 + 8.98*0.5)/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-268,-132},{-260,-124}})));
Modelica.Blocks.Sources.Constant qRadGai_flow205(k=(23.40*0.9 + 8.98*0.5)/3600)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-256,-124},{-248,-116}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_6(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-230,-132},{-222,-124}})));
Modelica.Blocks.Sources.Constant qLatGai_flow205(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-256,-138},{-248,-130}})));
Modelica.Blocks.Sources.Constant qConGai_flow206(k=(23.40*0.1 + 6.36*0.5)/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-268,-164},{-260,-156}})));
Modelica.Blocks.Sources.Constant qRadGai_flow206(k=(23.40*0.9 + 6.36*0.5)/3600)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-256,-156},{-248,-148}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_7(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-230,-164},{-222,-156}})));
Modelica.Blocks.Sources.Constant qLatGai_flow206(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-256,-170},{-248,-162}})));
Modelica.Blocks.Sources.Constant qConGai_flow104(k=6.94*0.1 + 22.95*0.5)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,-270},{-262,-262}})));
Modelica.Blocks.Sources.Constant qRadGai_flow104(k=6.94*0.9 + 22.95*0.5)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,-262},{-250,-254}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_8(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,-270},{-224,-262}})));
Modelica.Blocks.Sources.Constant qLatGai_flow104(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-278},{-250,-270}})));
Modelica.Blocks.Sources.Constant qConGai_flow102(k=3.14*0.1 + 0.75*0.5)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-268,-304},{-260,-296}})));
Modelica.Blocks.Sources.Constant qRadGai_flow102(k=3.14*0.9 + 0.75*0.5)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-256,-296},{-248,-288}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_9(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-230,-304},{-222,-296}})));
Modelica.Blocks.Sources.Constant qLatGai_flow102(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-256,-312},{-248,-304}})));
Modelica.Blocks.Sources.Constant qConGai_flow101(k=3.80*0.1)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,-342},{-262,-334}})));
Modelica.Blocks.Sources.Constant qRadGai_flow101(k=3.80*0.9)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,-334},{-250,-326}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_10(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,-342},{-224,-334}})));
Modelica.Blocks.Sources.Constant qLatGai_flow101(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-348},{-250,-340}})));
Modelica.Blocks.Sources.Constant qConGai_flow103(k=4.48*0.1 + 20.88*0.5)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,-374},{-262,-366}})));
Modelica.Blocks.Sources.Constant qRadGai_flow103(k=4.48*0.9 + 20.88*0.5)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,-366},{-250,-358}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_11(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,-374},{-224,-366}})));
Modelica.Blocks.Sources.Constant qLatGai_flow103(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-380},{-250,-372}})));
Modelica.Blocks.Sources.Constant qConGai_flow105(k=6.94*0.1 + 62.02*0.5)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,-402},{-262,-394}})));
Modelica.Blocks.Sources.Constant qRadGai_flow105(k=6.94*0.9 + 62.02*0.5)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-260,-396},{-252,-388}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_12(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,-404},{-224,-396}})));
Modelica.Blocks.Sources.Constant qLatGai_flow105(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-410},{-250,-402}})));
Modelica.Blocks.Sources.Constant qConGai_flow106(k=6.94*0.1 + 62.02*0.5)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,-438},{-262,-430}})));
Modelica.Blocks.Sources.Constant qRadGai_flow106(k=6.94*0.9 + 62.02*0.5)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,-430},{-250,-422}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_13(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,-438},{-224,-430}})));
Modelica.Blocks.Sources.Constant qLatGai_flow106(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-444},{-250,-436}})));
equation

  connect(roo204.heaPorAir, TRooAir204.port) annotation (Line(
      points={{-9.3,-46},{216,-46},{216,-12.5},{233,-12.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sinInf204.ports[1], roo204.ports[1]) annotation (Line(
      points={{-104,24},{-80,24},{-80,-57.5},{-27.5,-57.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(souInf204.ports[1], roo204.ports[2]) annotation (Line(points={{-116,
          -70},{-78,-70},{-78,-56.5},{-27.5,-56.5}},    color={0,127,255}));
connect(weaDat.weaBus,roo201.weaBus) annotation (Line(
    points={{270,-124},{204,-124},{204,-53.575},{159.585,-53.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo203.weaBus) annotation (Line(
    points={{270,-124},{216,-124},{216,-41.575},{83.585,-41.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo206.weaBus) annotation (Line(
    points={{270,-124},{138,-124},{138,-145.575},{103.585,-145.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo202.weaBus) annotation (Line(
      points={{270,-124},{194,-124},{194,-96},{120,-96},{120,-91.575},{45.585,
          -91.575}},
      color={255,204,51},
      thickness=0.5));
connect(weaDat.weaBus,roo205.weaBus) annotation (Line(
    points={{270,-124},{212,-124},{212,-135.575},{-6.415,-135.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo101.weaBus) annotation (Line(
    points={{270,-124},{204,-124},{204,-307.575},{151.585,-307.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo102.weaBus) annotation (Line(
    points={{270,-124},{202,-124},{202,-307.575},{83.585,-307.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo106.weaBus) annotation (Line(
    points={{270,-124},{204,-124},{204,-399.575},{105.585,-399.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo103.weaBus) annotation (Line(
    points={{270,-124},{200,-124},{200,-345.575},{47.585,-345.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo105.weaBus) annotation (Line(
    points={{270,-124},{204,-124},{204,-389.575},{-4.415,-389.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo104.weaBus) annotation (Line(
    points={{270,-124},{205.635,-124},{205.635,-284.1},{5.27,-284.1}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo204.weaBus) annotation (Line(
    points={{270,-124},{196,-124},{196,-28.1},{15.27,-28.1}},
    color={255,204,51},
    thickness=0.5));

connect(weaDat.weaBus, weaBus) annotation (Line(
    points={{270,-124},{184,-124},{184,-130},{-62,-130},{-62,-148},{-98,-148}},
    color={255,204,51},
    thickness=0.5,
    smooth=Smooth.None), Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));
connect(weaDat.weaBus, weaBus1) annotation (Line(
    points={{270,-124},{206,-124},{206,-444},{-98,-444}},
    color={255,204,51},
    thickness=0.5,
    smooth=Smooth.None), Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));

connect(roo204.surf_conBou[2],roo203. surf_conBou[2]) annotation (Line(points={{-0.2,
          -62.125},{15.75,-62.125},{15.75,-67.15},{69.9,-67.15}},      color={
        191,0,0}));
  connect(roo204.surf_conBou[4], roo202.surf_conBou[2]) annotation (Line(points={{-0.2,
          -61.625},{-0.2,-91},{31.9,-91},{31.9,-117.15}},       color={191,0,0}));
connect(roo204.surf_conBou[3],roo205. surf_conBou[2]) annotation (Line(points={{-0.2,
          -61.875},{-16,-61.875},{-16,-161.094},{-20.1,-161.094}},
                                                        color={191,0,0}));
  connect(roo205.surf_conBou[4], roo202.surf_conBou[4]) annotation (Line(points={{-20.1,
          -160.719},{5.95,-160.719},{5.95,-116.85},{31.9,-116.85}},      color={
          191,0,0}));
connect(roo205.surf_conBou[3],roo206. surf_conBou[2]) annotation (Line(points={{-20.1,
          -160.906},{35.95,-160.906},{35.95,-171.15},{89.9,-171.15}},  color=
        {191,0,0}));
  connect(roo206.surf_conBou[3], roo202.surf_conBou[5]) annotation (Line(points={{89.9,
          -171},{60.95,-171},{60.95,-116.7},{31.9,-116.7}},       color={191,0,0}));
connect(roo206.surf_conBou[4],roo203. surf_conBou[5]) annotation (Line(points={{89.9,
          -170.85},{89.9,-124.5},{69.9,-124.5},{69.9,-66.7}},          color=
        {191,0,0}));
connect(roo206.surf_conBou[5],roo201. surf_conBou[3]) annotation (Line(points={{89.9,
          -170.7},{89.9,-124.5},{145.9,-124.5},{145.9,-78.75}},         color=
       {191,0,0}));
connect(roo201.surf_conBou[2],roo203. surf_conBou[3]) annotation (Line(points={{145.9,
          -79},{99.95,-79},{99.95,-67},{69.9,-67}},
      color={191,0,0}));
  connect(roo202.surf_conBou[3], roo203.surf_conBou[4]) annotation (Line(points={{31.9,
          -117},{31.9,-97.5},{69.9,-97.5},{69.9,-66.85}},      color={191,0,0}));

  connect(roo104.heaPorAir, TRooAir104.port) annotation (Line(
      points={{-19.3,-302},{-2,-302},{-2,-294},{226,-294},{226,-284},{236,-284}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sinInf104.ports[1], roo104.ports[1]) annotation (Line(
      points={{-146,-212},{-60,-212},{-60,-313.333},{-37.5,-313.333}},
      color={0,127,255},
      smooth=Smooth.None));
connect(realExpression12.y, preHea12.Q_flow)
  annotation (Line(points={{-37.3,-328},{-32,-328}}, color={0,0,127}));

connect(roo104.surf_conBou[2], roo102.surf_conBou[2]) annotation (Line(points={{-10.2,
          -318.2},{17.75,-318.2},{17.75,-333.188},{69.9,-333.188}},
      color={191,0,0}));
connect(roo104.surf_conBou[4], roo103.surf_conBou[2]) annotation (Line(points={{-10.2,
          -317.8},{-10.2,-345},{33.9,-345},{33.9,-371.188}},      color={191,
        0,0}));
connect(roo104.surf_conBou[3], roo105.surf_conBou[2]) annotation (Line(points={{-10.2,
          -318},{-14,-318},{-14,-415.15},{-18.1,-415.15}},    color={191,0,0}));
connect(roo105.surf_conBou[4], roo103.surf_conBou[4]) annotation (Line(points={{-18.1,
          -414.85},{7.95,-414.85},{7.95,-370.938},{33.9,-370.938}},    color=
        {191,0,0}));
connect(roo105.surf_conBou[3], roo106.surf_conBou[2]) annotation (Line(points={{-18.1,
          -415},{37.95,-415},{37.95,-425.188},{91.9,-425.188}},      color={
        191,0,0}));
connect(roo106.surf_conBou[3], roo103.surf_conBou[5]) annotation (Line(points={{91.9,
          -425.062},{62.95,-425.062},{62.95,-370.812},{33.9,-370.812}},
      color={191,0,0}));
connect(roo106.surf_conBou[4], roo102.surf_conBou[5]) annotation (Line(points={{91.9,
          -424.938},{91.9,-378.5},{69.9,-378.5},{69.9,-332.812}},     color={
        191,0,0}));
connect(roo106.surf_conBou[5], roo101.surf_conBou[3]) annotation (Line(points={{91.9,
          -424.812},{91.9,-378.5},{137.9,-378.5},{137.9,-332.906}},     color=
       {191,0,0}));
connect(roo101.surf_conBou[2], roo102.surf_conBou[3]) annotation (Line(points={{137.9,
          -333.094},{101.95,-333.094},{101.95,-333.062},{69.9,-333.062}},
      color={191,0,0}));
connect(roo103.surf_conBou[3], roo102.surf_conBou[4]) annotation (Line(points={{33.9,
          -371.062},{33.9,-351.5},{69.9,-351.5},{69.9,-332.938}},     color={
        191,0,0}));
connect(realExpression13.y, preHea13.Q_flow)
  annotation (Line(points={{-47.3,-430},{-44,-430}}, color={0,0,127}));
connect(realExpression14.y, preHea14.Q_flow)
  annotation (Line(points={{10.7,-380},{16,-380}}, color={0,0,127}));
connect(realExpression16.y, preHea16.Q_flow)
  annotation (Line(points={{108.7,-342},{114,-342}}, color={0,0,127}));
connect(preHea12.port, roo104.surf_conBou[1]) annotation (Line(points={{-20,
          -328},{-14,-328},{-14,-318.4},{-10.2,-318.4}},
                                                       color={191,0,0}));
connect(preHea16.port, roo101.surf_conBou[1]) annotation (Line(points={{126,
          -342},{126,-333.281},{137.9,-333.281}},
                                                color={191,0,0}));
connect(preHea14.port, roo103.surf_conBou[1]) annotation (Line(points={{28,-380},
          {32,-380},{32,-371.312},{33.9,-371.312}},     color={191,0,0}));
connect(preHea13.port, roo105.surf_conBou[1]) annotation (Line(points={{-32,
          -430},{-24,-430},{-24,-415.3},{-18.1,-415.3}},
                                                       color={191,0,0}));
connect(preHea17.port, roo106.surf_conBou[1]) annotation (Line(points={{50,-452},
          {72,-452},{72,-425.312},{91.9,-425.312}},     color={191,0,0}));
connect(realExpression17.y, preHea17.Q_flow) annotation (Line(points={{26.7,
        -450},{30,-450},{30,-452},{38,-452}}, color={0,0,127}));
connect(realExpression21.y, preHea21.Q_flow)
  annotation (Line(points={{-33.3,-356},{-28,-356}}, color={0,0,127}));
connect(preHea21.port, roo103.surf_conBou[6]) annotation (Line(points={{-16,
          -356},{8,-356},{8,-370.688},{33.9,-370.688}},
                                                      color={191,0,0}));

connect(roo105.surf_conBou[5], roo205.surf_conBou[1]) annotation (Line(points={{-18.1,
          -414.7},{-18.1,-161.281},{-20.1,-161.281}},  color={191,0,0}));
connect(roo106.surf_conBou[6], roo206.surf_conBou[1]) annotation (Line(points={{91.9,
          -424.688},{91.9,-171.3},{89.9,-171.3}},         color={191,0,0}));
connect(roo101.surf_conBou[4], roo201.surf_conBou[1]) annotation (Line(points={{137.9,
          -332.719},{137.9,-79.25},{145.9,-79.25}},
      color={191,0,0}));
connect(roo102.surf_conBou[6],roo203. surf_conBou[1]) annotation (Line(points={{69.9,
          -332.688},{69.9,-67.3}},                                   color={
        191,0,0}));
  connect(roo103.surf_conBou[6], roo202.surf_conBou[1]) annotation (Line(points={{33.9,
          -370.688},{33.9,-117.3},{31.9,-117.3}},       color={191,0,0}));
connect(roo104.surf_conBou[5], roo204.surf_conBou[1]) annotation (Line(points={{-10.2,
          -317.6},{-34,-317.6},{-34,-124},{-0.2,-124},{-0.2,-62.375}},
      color={191,0,0}));
  connect(sinInf203.ports[1], roo203.ports[1]) annotation (Line(points={{-104,42},
          {8,42},{8,-63.5},{45.75,-63.5}},   color={0,127,255}));
  connect(sinInf201.ports[1], roo201.ports[1]) annotation (Line(points={{-104,84},
          {98,84},{98,-28},{121.75,-28},{121.75,-75.25}},  color={0,127,255}));

  connect(roo201.heaPorAir, TRooAir201.port) annotation (Line(points={{137.85,
          -67},{137.85,-64},{216,-64},{216,52.5},{231,52.5}},
                                color={191,0,0}));
  connect(roo101.heaPorAir, TRooAir101.port) annotation (Line(points={{129.85,
          -321},{214,-321},{214,-214},{236,-214}},
                                             color={191,0,0}));
  connect(roo202.heaPorAir, TRooAir202.port) annotation (Line(points={{23.85,
          -105},{98.075,-105},{98.075,-107.5},{212,-107.5},{212,28},{234,28}},
                                color={191,0,0}));
  connect(roo206.heaPorAir, TRooAir206.port) annotation (Line(points={{81.85,
          -159},{126.075,-159},{126.075,-158},{220,-158},{220,-61},{234,-61}},
                                  color={191,0,0}));
  connect(roo205.heaPorAir, TRooAir205.port) annotation (Line(points={{-28.15,
          -149},{-28.15,-144},{218,-144},{218,-35.5},{233,-35.5}},
                                                  color={191,0,0}));
  connect(sinInf105.ports[1], roo105.ports[1]) annotation (Line(points={{-146,
          -232},{-58,-232},{-58,-412},{-50,-412},{-50,-411.5},{-42.25,-411.5}},
                                                                          color=
         {0,127,255}));

  connect(roo105.heaPorAir, TRooAir105.port) annotation (Line(points={{-26.15,
          -403},{10,-403},{10,-402},{226,-402},{226,-306},{236,-306}},
                                    color={191,0,0}));

  connect(roo106.heaPorAir, TRooAir106.port) annotation (Line(points={{83.85,
          -413},{228,-413},{228,-332},{236,-332}},
                                             color={191,0,0}));
  connect(sinInf101.ports[1], roo101.ports[1]) annotation (Line(points={{-146,
          -176},{113.75,-176},{113.75,-329.25}},
                                          color={0,127,255}));

  connect(roo103.heaPorAir, TRooAir103.port) annotation (Line(points={{25.85,
          -359},{222,-359},{222,-262},{236,-262}}, color={191,0,0}));
  connect(roo102.heaPorAir, TRooAir102.port) annotation (Line(points={{61.85,
          -321},{61.85,-322},{218,-322},{218,-236},{236,-236}},
                                                   color={191,0,0}));
  connect(sinInf106.ports[1], roo106.ports[1]) annotation (Line(points={{-146,
          -252},{56,-252},{56,-422},{67.75,-422},{67.75,-421.5}},
                                                            color={0,127,255}));
  connect(sinInf102.ports[1], roo102.ports[1]) annotation (Line(points={{-146,
          -194},{45.75,-194},{45.75,-329.5}},                   color={0,127,255}));

  connect(roo203.heaPorAir, TRooAir203.port) annotation (Line(points={{61.85,
          -55},{61.85,-36},{214,-36},{214,8},{234,8}},
                                    color={191,0,0}));
  connect(sinInf202.ports[1], roo202.ports[1]) annotation (Line(points={{-104,62},
          {-22,62},{-22,-114},{7.75,-114},{7.75,-113.5}},       color={0,127,255}));

  connect(souInf204.weaBus, weaBus) annotation (Line(
      points={{-128,-69.88},{-128,-148},{-98,-148}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(sinInf206.ports[1], roo206.ports[1]) annotation (Line(points={{-102,
          -16},{28,-16},{28,-170},{32,-170},{32,-167.5},{65.75,-167.5}},
                                                                       color={0,
          127,255}));
  connect(sinInf205.ports[1], roo205.ports[1]) annotation (Line(points={{-104,2},
          {-84,2},{-84,-158},{-44.25,-158},{-44.25,-157.5}},    color={0,127,255}));

  connect(port_104[:], roo104.ports[2:3]) annotation (Line(points={{-117,-249},
          {-70,-249},{-70,-310.667},{-37.5,-310.667}},
                                              color={0,127,255}));
  connect(port_102[:], roo102.ports[2:3]) annotation (Line(points={{-9,-215},{
          36,-215},{36,-327.5},{45.75,-327.5}},
                                       color={0,127,255}));
  connect(port_103[:], roo103.ports[1:2]) annotation (Line(points={{-89,-332},{
          9.75,-332},{9.75,-365.75}},
                                color={0,127,255}));
  connect(port_105[:], roo105.ports[2:3]) annotation (Line(points={{-140,-368},
          {-42.25,-368},{-42.25,-409.5}},
                                  color={0,127,255}));
  connect(port_106[:], roo106.ports[2:3]) annotation (Line(points={{123,-368},{
          123,-419.5},{67.75,-419.5}},
                           color={0,127,255}));
  connect(port_205[:], roo205.ports[2:3]) annotation (Line(points={{-91,-47},{
          -44.25,-47},{-44.25,-155.5}},
                                  color={0,127,255}));
  connect(port_204[:], roo204.ports[3:4]) annotation (Line(points={{-51,30},{
          -62,30},{-62,-54.5},{-27.5,-54.5}},
                                   color={0,127,255}));
  connect(port_203[:], roo203.ports[2:3]) annotation (Line(points={{79,71},{22,
          71},{22,-61.5},{45.75,-61.5}},
                                     color={0,127,255}));
  connect(port_202[:], roo202.ports[2:3]) annotation (Line(points={{-28,-75},{
          -28,-111.5},{7.75,-111.5}},  color={0,127,255}));
  connect(port_206[:], roo206.ports[2:3]) annotation (Line(points={{150,-64},{
          16,-64},{16,-165.5},{65.75,-165.5}},
                                             color={0,127,255}));
  connect(Infilt201.y, sinInf201.m_flow_in) annotation (Line(points={{-135.4,86},
          {-128,86},{-128,88.8},{-117.2,88.8}},color={0,0,127}));
  connect(Infilt203.y, sinInf203.m_flow_in) annotation (Line(points={{-133.4,42},
          {-130,42},{-130,46.8},{-117.2,46.8}},color={0,0,127}));
  connect(Infilt202.y, sinInf202.m_flow_in) annotation (Line(points={{-133.4,64},
          {-128,64},{-128,66.8},{-117.2,66.8}},color={0,0,127}));
  connect(Infilt204.y, sinInf204.m_flow_in) annotation (Line(points={{-133.4,22},
          {-128,22},{-128,28.8},{-117.2,28.8}},color={0,0,127}));
  connect(Infilt205.y, sinInf205.m_flow_in) annotation (Line(points={{-133.4,0},
          {-128,0},{-128,6.8},{-117.2,6.8}},color={0,0,127}));
  connect(Infilt206.y, sinInf206.m_flow_in) annotation (Line(points={{-133.4,
          -20},{-124,-20},{-124,-11.2},{-115.2,-11.2}},
                                                  color={0,0,127}));
  connect(Infilt101.y, sinInf101.m_flow_in) annotation (Line(points={{-177.5,-171},
          {-168,-171},{-168,-171.2},{-159.2,-171.2}}, color={0,0,127}));
  connect(Infilt102.y, sinInf102.m_flow_in) annotation (Line(points={{-177.5,-191},
          {-170,-191},{-170,-189.2},{-159.2,-189.2}}, color={0,0,127}));
  connect(Infilt104.y, sinInf104.m_flow_in) annotation (Line(points={{-177.5,-211},
          {-170,-211},{-170,-207.2},{-159.2,-207.2}}, color={0,0,127}));
  connect(Infilt105.y, sinInf105.m_flow_in) annotation (Line(points={{-177.5,-231},
          {-168.75,-231},{-168.75,-227.2},{-159.2,-227.2}}, color={0,0,127}));
  connect(Infilt106.y, sinInf106.m_flow_in) annotation (Line(points={{-177.5,-253},
          {-168.75,-253},{-168.75,-247.2},{-159.2,-247.2}}, color={0,0,127}));
  connect(souInf101.weaBus, weaBus1) annotation (Line(
      points={{-130,-292.86},{-154,-292.86},{-154,-444},{-98,-444}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(souInf101.ports[1], roo101.ports[2]) annotation (Line(points={{-116,
          -293},{90,-293},{90,-294},{102,-294},{102,-327.75},{113.75,-327.75}},
                                                                          color=
         {0,127,255}));
  connect(weaBus, souInf201.weaBus) annotation (Line(
      points={{-98,-148},{-146,-148},{-146,-54.86},{-128,-54.86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(souInf201.ports[1], roo201.ports[2]) annotation (Line(points={{-114,
          -55},{110,-55},{110,-73.75},{121.75,-73.75}},
                                                  color={0,127,255}));
  connect(TRooAir201.T, TRoo_2.u1[1]) annotation (Line(points={{250,52.5},{268,
          52.5},{268,3.15},{273.72,3.15}}, color={0,0,127}));
  connect(TRooAir202.T, TRoo_2.u2[1]) annotation (Line(points={{250,28},{266,28},
          {266,-3.31},{273.72,-3.31}}, color={0,0,127}));
  connect(TRooAir203.T, TRoo_2.u3[1]) annotation (Line(points={{250,8},{264,8},
          {264,-9.77},{273.72,-9.77}}, color={0,0,127}));
  connect(TRooAir204.T, TRoo_2.u4[1]) annotation (Line(points={{250,-12.5},{290,
          -12.5},{290,-16.23},{273.72,-16.23}}, color={0,0,127}));
  connect(TRooAir205.T, TRoo_2.u5[1]) annotation (Line(points={{250,-35.5},{266,
          -35.5},{266,-22.69},{273.72,-22.69}}, color={0,0,127}));
  connect(TRooAir206.T, TRoo_2.u6[1]) annotation (Line(points={{252,-61},{268,
          -61},{268,-29.15},{273.72,-29.15}}, color={0,0,127}));
  connect(TRooAir101.T, TRoo_1.u1[1]) annotation (Line(points={{252,-214},{268,
          -214},{268,-244.4},{284.08,-244.4}}, color={0,0,127}));
  connect(TRooAir102.T, TRoo_1.u2[1]) annotation (Line(points={{252,-236},{264,
          -236},{264,-249.84},{284.08,-249.84}}, color={0,0,127}));
  connect(TRooAir103.T, TRoo_1.u3[1]) annotation (Line(points={{252,-262},{256,
          -262},{256,-258},{284.08,-258},{284.08,-255.28}}, color={0,0,127}));
  connect(TRooAir104.T, TRoo_1.u4[1]) annotation (Line(points={{252,-284},{266,
          -284},{266,-260.72},{284.08,-260.72}}, color={0,0,127}));
  connect(TRooAir105.T, TRoo_1.u5[1]) annotation (Line(points={{252,-306},{270,
          -306},{270,-266.16},{284.08,-266.16}}, color={0,0,127}));
  connect(TRooAir106.T, TRoo_1.u6[1]) annotation (Line(points={{252,-332},{272,
          -332},{272,-271.6},{284.08,-271.6}}, color={0,0,127}));
  connect(TRoo_1.y, TrooVecFir)
    annotation (Line(points={{319.6,-258},{342,-258}}, color={0,0,127}));
  connect(TRoo_2.y, TrooVecSec) annotation (Line(points={{315.9,-13},{326,-13},
          {326,-12},{330,-12},{330,-14},{340,-14}}, color={0,0,127}));
  connect(qRadGai_flow204.y, multiplex3_2.u1[1]) annotation (Line(
      points={{-247.6,16},{-246,16},{-246,10.8},{-230.8,10.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow204.y, multiplex3_2.u3[1]) annotation (Line(
      points={{-247.6,0},{-234,0},{-234,4},{-232,4},{-232,5.2},{-230.8,5.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow204.y, multiplex3_2.u2[1]) annotation (Line(
      points={{-259.6,8},{-230.8,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_2.y, roo204.qGai_flow) annotation (Line(points={{-221.6,8},
          {-206,8},{-206,-38},{-36.08,-38}}, color={0,0,127}));
  connect(qRadGai_flow203.y, multiplex3_3.u1[1]) annotation (Line(
      points={{-245.6,-18},{-244,-18},{-244,-23.2},{-228.8,-23.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow203.y, multiplex3_3.u3[1]) annotation (Line(
      points={{-245.6,-34},{-232,-34},{-232,-30},{-230,-30},{-230,-28.8},{
          -228.8,-28.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow203.y, multiplex3_3.u2[1]) annotation (Line(
      points={{-257.6,-26},{-228.8,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow201.y, multiplex3_4.u1[1]) annotation (Line(
      points={{-247.6,-56},{-246,-56},{-246,-61.2},{-230.8,-61.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow201.y, multiplex3_4.u3[1]) annotation (Line(
      points={{-247.6,-70},{-234,-70},{-234,-68},{-232,-68},{-232,-66.8},{
          -230.8,-66.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow201.y, multiplex3_4.u2[1]) annotation (Line(
      points={{-259.6,-64},{-230.8,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow202.y, multiplex3_5.u1[1]) annotation (Line(
      points={{-247.6,-88},{-246,-88},{-246,-93.2},{-230.8,-93.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow202.y, multiplex3_5.u3[1]) annotation (Line(
      points={{-247.6,-102},{-234,-102},{-234,-100},{-232,-100},{-232,-98.8},{
          -230.8,-98.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow202.y, multiplex3_5.u2[1]) annotation (Line(
      points={{-259.6,-96},{-230.8,-96}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow205.y, multiplex3_6.u1[1]) annotation (Line(
      points={{-247.6,-120},{-246,-120},{-246,-125.2},{-230.8,-125.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow205.y, multiplex3_6.u3[1]) annotation (Line(
      points={{-247.6,-134},{-234,-134},{-234,-132},{-232,-132},{-232,-130.8},{
          -230.8,-130.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow205.y, multiplex3_6.u2[1]) annotation (Line(
      points={{-259.6,-128},{-230.8,-128}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow206.y, multiplex3_7.u1[1]) annotation (Line(
      points={{-247.6,-152},{-246,-152},{-246,-157.2},{-230.8,-157.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow206.y, multiplex3_7.u3[1]) annotation (Line(
      points={{-247.6,-166},{-234,-166},{-234,-164},{-232,-164},{-232,-162.8},{
          -230.8,-162.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow206.y, multiplex3_7.u2[1]) annotation (Line(
      points={{-259.6,-160},{-230.8,-160}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_3.y, roo203.qGai_flow) annotation (Line(points={{-219.6,
          -26},{-208,-26},{-208,-48},{-84,-48},{-84,-49},{38.16,-49}}, color={0,
          0,127}));
  connect(multiplex3_4.y, roo201.qGai_flow) annotation (Line(points={{-221.6,
          -64},{-208,-64},{-208,-61},{114.16,-61}}, color={0,0,127}));
  connect(multiplex3_5.y, roo202.qGai_flow) annotation (Line(points={{-221.6,
          -96},{-206,-96},{-206,-98},{-112,-98},{-112,-99},{0.16,-99}}, color={
          0,0,127}));
  connect(multiplex3_6.y, roo205.qGai_flow) annotation (Line(points={{-221.6,
          -128},{-208,-128},{-208,-143},{-51.84,-143}}, color={0,0,127}));
  connect(multiplex3_7.y, roo206.qGai_flow) annotation (Line(points={{-221.6,
          -160},{-12,-160},{-12,-153},{58.16,-153}}, color={0,0,127}));
  connect(qRadGai_flow104.y, multiplex3_8.u1[1]) annotation (Line(
      points={{-249.6,-258},{-248,-258},{-248,-263.2},{-232.8,-263.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow104.y, multiplex3_8.u3[1]) annotation (Line(
      points={{-249.6,-274},{-236,-274},{-236,-270},{-234,-270},{-234,-268.8},{
          -232.8,-268.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow104.y, multiplex3_8.u2[1]) annotation (Line(
      points={{-261.6,-266},{-232.8,-266}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow102.y, multiplex3_9.u1[1]) annotation (Line(
      points={{-247.6,-292},{-246,-292},{-246,-297.2},{-230.8,-297.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow102.y, multiplex3_9.u3[1]) annotation (Line(
      points={{-247.6,-308},{-234,-308},{-234,-304},{-232,-304},{-232,-302.8},{
          -230.8,-302.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow102.y, multiplex3_9.u2[1]) annotation (Line(
      points={{-259.6,-300},{-230.8,-300}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow101.y, multiplex3_10.u1[1]) annotation (Line(
      points={{-249.6,-330},{-248,-330},{-248,-335.2},{-232.8,-335.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow101.y, multiplex3_10.u3[1]) annotation (Line(
      points={{-249.6,-344},{-236,-344},{-236,-342},{-234,-342},{-234,-340.8},{
          -232.8,-340.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow101.y, multiplex3_10.u2[1]) annotation (Line(
      points={{-261.6,-338},{-232.8,-338}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow103.y, multiplex3_11.u1[1]) annotation (Line(
      points={{-249.6,-362},{-248,-362},{-248,-367.2},{-232.8,-367.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow103.y, multiplex3_11.u3[1]) annotation (Line(
      points={{-249.6,-376},{-236,-376},{-236,-374},{-234,-374},{-234,-372.8},{
          -232.8,-372.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow103.y, multiplex3_11.u2[1]) annotation (Line(
      points={{-261.6,-370},{-232.8,-370}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow105.y, multiplex3_12.u1[1]) annotation (Line(
      points={{-251.6,-392},{-248,-392},{-248,-397.2},{-232.8,-397.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow105.y, multiplex3_12.u3[1]) annotation (Line(
      points={{-249.6,-406},{-236,-406},{-236,-404},{-234,-404},{-234,-402.8},{
          -232.8,-402.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow105.y, multiplex3_12.u2[1]) annotation (Line(
      points={{-261.6,-398},{-248,-398},{-248,-400},{-232.8,-400}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow106.y, multiplex3_13.u1[1]) annotation (Line(
      points={{-249.6,-426},{-248,-426},{-248,-431.2},{-232.8,-431.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow106.y, multiplex3_13.u3[1]) annotation (Line(
      points={{-249.6,-440},{-236,-440},{-236,-438},{-234,-438},{-234,-436.8},{
          -232.8,-436.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow106.y, multiplex3_13.u2[1]) annotation (Line(
      points={{-261.6,-434},{-232.8,-434}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_8.y, roo104.qGai_flow) annotation (Line(points={{-223.6,
          -266},{-198,-266},{-198,-294},{-46.08,-294}}, color={0,0,127}));
  connect(multiplex3_9.y, roo102.qGai_flow) annotation (Line(points={{-221.6,
          -300},{-198,-300},{-198,-315},{38.16,-315}}, color={0,0,127}));
  connect(multiplex3_10.y, roo101.qGai_flow) annotation (Line(points={{-223.6,
          -338},{-56,-338},{-56,-328},{108,-328},{108,-315},{106.16,-315}},
        color={0,0,127}));
  connect(roo103.qGai_flow, multiplex3_11.y) annotation (Line(points={{2.16,
          -353},{-198,-353},{-198,-370},{-223.6,-370}}, color={0,0,127}));
  connect(multiplex3_12.y, roo105.qGai_flow) annotation (Line(points={{-223.6,
          -400},{-198,-400},{-198,-398},{-68,-398},{-68,-397},{-49.84,-397}},
        color={0,0,127}));
  connect(multiplex3_13.y, roo106.qGai_flow) annotation (Line(points={{-223.6,
          -434},{-198,-434},{-198,-407},{60.16,-407}}, color={0,0,127}));
annotation (
    experiment(
      StartTime=15984000,
      StopTime=16243200,
      Tolerance=1e-05),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/Detailed/Validation/BESTEST/Cases6xx/Case600FF.mos"
      "Simulate and plot"), Documentation(info="<html>
<p>This model is FRP building envelop model. The model utilizes &quot;MixedAir&quot; model of Modelica buildings library. </p>
</html>",
        revisions="<html>
<ul>
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
  Diagram(coordinateSystem(extent={{-260,-460},{320,140}})),
    Icon(coordinateSystem(extent={{-260,-460},{320,140}}), graphics={
        Rectangle(
          extent={{-140,-166},{210,-438}},
          lineColor={28,108,200},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-140,132},{210,-140}},
          lineColor={28,108,200},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid),
        Line(points={{40,130},{40,42}}, color={0,0,0}),
        Line(points={{28,40},{100,40},{132,40}},
                                             color={0,0,0}),
        Line(points={{134,130},{134,-10}},
                                        color={0,0,0}),
        Line(points={{110,-12},{212,-12}},color={0,0,0}),
        Line(points={{20,-44},{20,-138}},   color={0,0,0}),
        Line(points={{-12,-44},{110,-44},{110,-12}},
                                                   color={0,0,0}),
        Line(points={{-10,-46},{-10,40},{44,40}},color={0,0,0}),
        Line(points={{-12,14},{-138,14}},   color={0,0,0}),
        Text(
          extent={{-90,122},{-16,86}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="204"),
        Text(
          extent={{58,120},{120,88}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="203"),
        Text(
          extent={{148,120},{204,86}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="201"),
        Text(
          extent={{28,-2},{90,-36}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="202"),
        Text(
          extent={{-82,-78},{-24,-114}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="205"),
        Text(
          extent={{66,-78},{122,-114}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="206"),
        Text(
          extent={{148,-178},{196,-208}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="101"),
        Text(
          extent={{-96,-176},{-30,-210}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="104"),
        Text(
          extent={{-84,-384},{-18,-416}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="105"),
        Text(
          extent={{64,-382},{130,-414}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="106"),
        Text(
          extent={{22,-304},{90,-334}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="103"),
        Line(points={{18,-344},{18,-438}},  color={0,0,0}),
        Line(points={{-12,-346},{-12,-260},{42,-260}},
                                                 color={0,0,0}),
        Line(points={{-14,-344},{108,-344},{108,-312}},
                                                   color={0,0,0}),
        Line(points={{108,-312},{210,-312}},
                                          color={0,0,0}),
        Line(points={{132,-170},{132,-310}},
                                        color={0,0,0}),
        Line(points={{38,-170},{38,-258}},
                                        color={0,0,0}),
        Line(points={{-14,-286},{-140,-286}},
                                            color={0,0,0}),
        Line(points={{26,-260},{98,-260},{130,-260}},
                                             color={0,0,0}),
        Text(
          extent={{56,-176},{120,-206}},
          lineColor={0,0,0},
          fillColor={133,168,200},
          fillPattern=FillPattern.Solid,
          textString="102")}));
end FRPMultiZone_Envelope_Icon_v1;
