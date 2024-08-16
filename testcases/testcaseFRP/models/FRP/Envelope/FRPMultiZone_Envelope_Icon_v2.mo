within FRP.Envelope;
model FRPMultiZone_Envelope_Icon_v2
  "FRP MultiZone envelope icon with  FRP construction_withplenum"
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
  annotation (Placement(transformation(extent={{-178,202},{-148,232}})));

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
      nStaRef=nStaRef)}) "Exterior wall for 104"
  annotation (Placement(transformation(extent={{-138,202},{-108,232}})));
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
        nStaRef=nStaRef)}) "Exterior wall for 204"
  annotation (Placement(transformation(extent={{-98,202},{-68,232}})));
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
        nStaRef=nStaRef)}) "Interior wall"
  annotation (Placement(transformation(extent={{-60,202},{-30,232}})));

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
      nStaRef=nStaRef)}) "Ground Floor"
  annotation (Placement(transformation(extent={{52,202},{84,234}})));
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
      nStaRef=nStaRef)}) "2nd floor "
    annotation (Placement(transformation(extent={{90,202},{120,232}})));

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
  annotation (Placement(transformation(extent={{14,202},{46,234}})));
parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matCeil(
    nLay=1,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0005,
        k=0.06,
        c=1340,
        d=288,
        nStaRef=nStaRef)}) "Drop Ceiling tile"
    annotation (Placement(transformation(extent={{130,202},{160,232}})));
parameter FRP.BaseClasses.DoubleClearAir16Clear windowFRP
    annotation (Placement(transformation(extent={{-20,202},{10,232}})));

Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://FRP/Resources/weatherdata/FRP2018.mos"))
  annotation (Placement(transformation(extent={{280,-58},{268,-46}})));

Buildings.Fluid.Sources.MassFlowSource_T sinInf204(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-118,90},{-106,102}})));
Modelica.Blocks.Sources.Constant Infilt204(k=1.2*35.273*2.44*0.432/3600)
    "0.432ACH"
    annotation (Placement(transformation(extent={{-148,88},{-136,100}})));
Buildings.BoundaryConditions.WeatherData.Bus weaBus
  annotation (Placement(transformation(extent={{-108,-84},{-92,-68}}),
        iconTransformation(extent={{-108,-84},{-92,-68}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir204
    "Room air temperature"
    annotation (Placement(transformation(extent={{231,51},{248,68}})));

Buildings.ThermalZones.Detailed.MixedAir roo204(
    nConExt=0,
  redeclare package Medium = MediumA,
    hRoo=2.440,
  nConExtWin=2,
    nConBou=5,
  nPorts=3,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
  AFlo=35.273,
  nConPar=0,
  nSurBou=0,
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
      layers={matFlo1,matCeil,matIntWal,matIntWal,matIntWal},
      A={35.27,35.27,11.01,11.01,13.10},
      til={F_,C_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{-36,6},{16,46}})));

Buildings.ThermalZones.Detailed.MixedAir roo203(
    nConExt=0,
  redeclare package Medium = MediumA,
    hRoo=2.440,
  nConExtWin=1,
  nConBou=5,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=12.29,
  nConPar=0,
  nSurBou=0,
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
      layers={matFlo1,matCeil,matIntWal,matIntWal,matIntWal},
      A={12.29,12.29,11.01,11.01,3.76},
      til={F_,C_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{38,2},{84,32}})));
Buildings.ThermalZones.Detailed.MixedAir roo206(
    nConExt=0,
  redeclare package Medium = MediumA,
    hRoo=2.440,
  nConExtWin=2,
  nConBou=5,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=35.27,
  nConPar=0,
  nSurBou=0,
    datConExtWin(
      layers={matExtWal,matExtWal},
      A={25.92,15.05},
      glaSys={windowFRP,windowFRP},
      wWin={4.11,4.11},
      hWin={1.95,1.95},
      fFra={0.119,0.119},
      til={Z_,Z_},
      azi={S_,E_}),
    datConBou(
      layers={matFlo1,matCeil,matIntWal,matIntWal,matIntWal},
      A={35.27,35.27,11.01,16.86,7.25},
      til={F_,C_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{58,-102},{104,-72}})));
Buildings.ThermalZones.Detailed.MixedAir roo202(
    nConExt=0,
    redeclare package Medium = MediumA,
    hRoo=2.44,
    nConExtWin=0,
    nConBou=7,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=26.46,
    nConPar=0,
    nSurBou=0,
    datConBou(
      layers={matFlo1,matCeil,matIntWal,matIntWal,matIntWal,matIntWal,matIntWal},

      A={26.46,26.46,13.10,3.76,13.10,13.10,3.76},
      til={F_,C_,Z_,Z_,Z_,Z_,Z_}),
    lat=weaDat.lat,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2)
    "Room model for Case 600"
    annotation (Placement(transformation(extent={{0,-48},{46,-18}})));
Buildings.ThermalZones.Detailed.MixedAir roo205(
    nConExt=0,
  redeclare package Medium = MediumA,
    hRoo=2.440,
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
      layers={matFlo1,matCeil,matIntWal,matIntWal,matIntWal},
      A={35.27,35.27,11.01,13.10,11.01},
      til={F_,C_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{-52,-92},{-6,-62}})));
Buildings.ThermalZones.Detailed.MixedAir roo201(
    nConExt=0,
  redeclare package Medium = MediumA,
    hRoo=2.440,
  nConExtWin=2,
    nConBou=5,
    linearizeRadiation=true,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=19.32,
  nConPar=0,
  nSurBou=0,
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
      layers={matFlo1,matCeil,matIntWal,matIntWal,matIntWal},
      A={19.32,19.32,11.01,13.1,7.25},
      til={F_,C_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{114,-10},{160,20}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf104(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-158,-218},{-146,-206}})));
Modelica.Blocks.Sources.Constant Infilt104(k=1.2*35.27*2.440*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-188,-216},{-178,-206}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir104
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-292},{252,-276}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea12
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{-34,-344},{-22,-332}})));
Modelica.Blocks.Sources.RealExpression realExpression12
  annotation (Placement(transformation(extent={{-52,-346},{-38,-330}})));
Buildings.ThermalZones.Detailed.MixedAir roo104(
  redeclare package Medium = MediumA,
    hRoo=2.440,
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
      layers={matFlo,matCeil,matIntWal,matIntWal,matIntWal},
      A={35.27,35.27,11.01,11.01,13.10},
      til={F_,C_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{-44,-322},{8,-282}})));
Buildings.ThermalZones.Detailed.MixedAir roo102(
  redeclare package Medium = MediumA,
    hRoo=2.440,
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
      layers={matFlo,matCeil,matIntWal,matIntWal,matIntWal,matIntWal},
      A={15.95,15.95,11.01,13.10,20.07,3.76},
      til={F_,C_,Z_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{40,-336},{86,-306}})));
Buildings.ThermalZones.Detailed.MixedAir roo106(
  redeclare package Medium = MediumA,
    hRoo=2.440,
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
      layers={matFlo,matCeil,matIntWal,matIntWal,matIntWal,matIntWal},
      A={35.273,35.273,11.01,13.10,3.76,7.25},
      til={F_,C_,Z_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Room model for Case 600"
  annotation (Placement(transformation(extent={{62,-428},{108,-398}})));
Buildings.ThermalZones.Detailed.MixedAir roo103(
  redeclare package Medium = MediumA,
    hRoo=2.440,
  nConExt=0,
  nConExtWin=0,
  nConBou=6,
  nPorts=2,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=22.80,
  nConPar=0,
  nSurBou=0,
    datConBou(
      layers={matFlo,matCeil,matIntWal,matIntWal,matIntWal,matIntWal},
      A={22.80,22.80,13.10,13.10,13.10,13.10},
      til={F_,C_,Z_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{4,-374},{50,-344}})));
Buildings.ThermalZones.Detailed.MixedAir roo105(
  redeclare package Medium = MediumA,
    hRoo=2.440,
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
      layers={matFlo,matCeil,matIntWal,matIntWal,matIntWal},
      A={35.27,35.27,11.01,13.10,11.01},
      til={F_,C_,Z_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=3)
  "Room model for Case 600"
  annotation (Placement(transformation(extent={{-48,-418},{-2,-388}})));
Buildings.ThermalZones.Detailed.MixedAir roo101(
  redeclare package Medium = MediumA,
    hRoo=2.440,
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
      layers={matFlo,matCeil,matIntWal,matIntWal},
      A={19.32,19.32,20.07,7.25},
      til={F_,C_,Z_,Z_}),
  lat=weaDat.lat,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2) "Room model for Case 600"
  annotation (Placement(transformation(extent={{108,-336},{154,-306}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea13
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{-44,-436},{-32,-424}})));
Modelica.Blocks.Sources.RealExpression realExpression13
  annotation (Placement(transformation(extent={{-62,-438},{-48,-422}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea14
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{56,-388},{68,-376}})));
Modelica.Blocks.Sources.RealExpression realExpression14
  annotation (Placement(transformation(extent={{36,-390},{50,-374}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea16
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{112,-360},{124,-348}})));
Modelica.Blocks.Sources.RealExpression realExpression16
  annotation (Placement(transformation(extent={{90,-362},{104,-346}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea17
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{38,-458},{50,-446}})));
Modelica.Blocks.Sources.RealExpression realExpression17
  annotation (Placement(transformation(extent={{12,-458},{26,-442}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea21
  "Prescribed heat flow for heating and cooling"
  annotation (Placement(transformation(extent={{-6,-386},{6,-374}})));
Modelica.Blocks.Sources.RealExpression realExpression21
  annotation (Placement(transformation(extent={{-30,-388},{-16,-372}})));
Buildings.BoundaryConditions.WeatherData.Bus           weaBus1
  annotation (Placement(transformation(extent={{-106,-452},{-90,-436}}),
        iconTransformation(extent={{-106,-452},{-90,-436}})));

Modelica.Blocks.Sources.Constant Infilt205(k=1.2*35.27*2.44*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-148,66},{-136,78}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf205(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-118,68},{-106,80}})));
Modelica.Blocks.Sources.Constant Infilt203(k=1.2*12.49*2.44*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-148,108},{-136,120}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf203(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-118,108},{-106,120}})));
Modelica.Blocks.Sources.Constant Infilt201(k=1.2*19.32*2.44*0.432/3600)
    "0.432ACH"
    annotation (Placement(transformation(extent={{-150,152},{-138,164}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf201(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-118,150},{-106,162}})));
Modelica.Blocks.Sources.Constant Infilt206(k=1.2*35.27*2.44*0.432/3600)
                                                                     "0.432ACH"
    annotation (Placement(transformation(extent={{-148,46},{-136,58}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir201
    "Room air temperature"
    annotation (Placement(transformation(extent={{229,115},{248,134}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir101
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-222},{252,-206}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir202
    "Room air temperature"
    annotation (Placement(transformation(extent={{232,92},{248,108}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir206
    "Room air temperature"
    annotation (Placement(transformation(extent={{232,2},{250,20}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir205
    "Room air temperature"
    annotation (Placement(transformation(extent={{231,29},{248,44}})));
Modelica.Blocks.Sources.Constant Infilt105(k=1.2*35.27*2.440*0.432/3600)
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
Modelica.Blocks.Sources.Constant Infilt106(k=1.2*35.27*2.440*0.432/3600)
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
Modelica.Blocks.Sources.Constant Infilt101(k=1.2*19.32*2.440*0.432/3600)
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
    annotation (Placement(transformation(extent={{-156,-178},{-144,-166}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir103
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-270},{252,-254}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir102
    "Room air temperature"
    annotation (Placement(transformation(extent={{236,-244},{252,-228}})));
Modelica.Blocks.Sources.Constant Infilt102(k=1.2*15.95*2.440*0.432/3600)
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
    annotation (Placement(transformation(extent={{232,72},{248,88}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_204[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-86,62},{-18,86}}),
        iconTransformation(extent={{-88,58},{-18,86}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_203[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{46,64},{104,90}}),
        iconTransformation(extent={{46,64},{104,90}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_202[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-56,-16},{14,8}}),
        iconTransformation(extent={{24,0},{88,26}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInf206(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-116,50},{-104,62}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_206[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{114,-44},{170,-20}}),
        iconTransformation(extent={{114,-48},{170,-20}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_205[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-116,18},{-68,38}}),
        iconTransformation(extent={{-116,-60},{-44,-32}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_104[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-144,-256},{-78,-232}}),
        iconTransformation(extent={{-112,-260},{-46,-234}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_102[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-40,-226},{26,-200}}),
        iconTransformation(extent={{54,-228},{110,-206}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_103[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-124,-340},{-62,-316}}),
        iconTransformation(extent={{24,-292},{82,-268}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_105[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{-172,-388},{-108,-348}}),
        iconTransformation(extent={{-102,-350},{-42,-324}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b port_106[2](redeclare
      package Medium = MediumA) "Fluid inlet and outlet"
    annotation (Placement(transformation(extent={{100,-386},{158,-368}}),
        iconTransformation(extent={{128,-360},{188,-338}})));
Buildings.Fluid.Sources.Outside souInf201(redeclare package Medium = MediumA,
      nPorts=1) "Source model for air infiltration"
    annotation (Placement(transformation(extent={{-136,-20},{-126,-10}})));
Buildings.Fluid.Sources.Outside souInf101(redeclare package Medium = MediumA,
      nPorts=1) "Source model for air infiltration"
    annotation (Placement(transformation(extent={{-132,-292},{-122,-282}})));
  Modelica.Blocks.Routing.Multiplex6 TRoo_2
    annotation (Placement(transformation(extent={{274,40},{312,78}})));
  Modelica.Blocks.Routing.Multiplex6 TRoo_1
    annotation (Placement(transformation(extent={{286,-274},{318,-242}})));
  Modelica.Blocks.Interfaces.RealOutput TrooVecFir[6]
    "1st floor room air temperature vector" annotation (Placement(
        transformation(extent={{332,-268},{352,-248}}), iconTransformation(
          extent={{332,-268},{352,-248}})));
  Modelica.Blocks.Interfaces.RealOutput TrooVecSec[6]
    "2nd floor room air temperature vector" annotation (Placement(
        transformation(extent={{328,48},{348,68}}),  iconTransformation(extent={{328,48},
            {348,68}})));
Modelica.Blocks.Sources.Constant qConGai_flow204(k=(23.4*0.1 + 1.7*0.5)/3600)
    "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,76},{-262,84}})));
Modelica.Blocks.Sources.Constant qRadGai_flow204(k=(23.4*0.9 + 1.7*0.5)/3600)
    "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,84},{-250,92}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_2(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,76},{-224,84}})));
Modelica.Blocks.Sources.Constant qLatGai_flow204(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,68},{-250,76}})));
Modelica.Blocks.Sources.Constant qConGai_flow203(k=8.15*0.1/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-268,42},{-260,50}})));
Modelica.Blocks.Sources.Constant qRadGai_flow203(k=8.15*0.9/3600)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-256,50},{-248,58}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_3(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-230,42},{-222,50}})));
Modelica.Blocks.Sources.Constant qLatGai_flow203(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-256,34},{-248,42}})));
Modelica.Blocks.Sources.Constant qConGai_flow201(k=12.82*0.1/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,4},{-262,12}})));
Modelica.Blocks.Sources.Constant qRadGai_flow201(k=12.82*0.9/3600)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,12},{-250,20}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_4(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,4},{-224,12}})));
Modelica.Blocks.Sources.Constant qLatGai_flow201(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-2},{-250,6}})));
Modelica.Blocks.Sources.Constant qConGai_flow202(k=(17.56*0.1 + 143.37*0.5)/
        3600)                                           "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,-28},{-262,-20}})));
Modelica.Blocks.Sources.Constant qRadGai_flow202(k=(17.56*0.9 + 143.37*0.5)/
        3600)                                           "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,-20},{-250,-12}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_5(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,-28},{-224,-20}})));
Modelica.Blocks.Sources.Constant qLatGai_flow202(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-34},{-250,-26}})));
Modelica.Blocks.Sources.Constant qConGai_flow205(k=(23.40*0.1 + 8.98*0.5)/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,-60},{-262,-52}})));
Modelica.Blocks.Sources.Constant qRadGai_flow205(k=(23.40*0.9 + 8.98*0.5)/3600)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,-52},{-250,-44}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_6(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,-60},{-224,-52}})));
Modelica.Blocks.Sources.Constant qLatGai_flow205(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-66},{-250,-58}})));
Modelica.Blocks.Sources.Constant qConGai_flow206(k=(23.40*0.1 + 6.36*0.5)/3600)
                                                        "Convective heat gain"
    annotation (Placement(transformation(extent={{-270,-92},{-262,-84}})));
Modelica.Blocks.Sources.Constant qRadGai_flow206(k=(23.40*0.9 + 6.36*0.5)/3600)
                                                        "Radiative heat gain"
    annotation (Placement(transformation(extent={{-258,-84},{-250,-76}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_7(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-232,-92},{-224,-84}})));
Modelica.Blocks.Sources.Constant qLatGai_flow206(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-258,-98},{-250,-90}})));
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

Buildings.ThermalZones.Detailed.MixedAir plenum1(
    nConExtWin=0,
    datConExt(
      layers={matExtWal,matExtWal,matExtWal,matExtWal},
      A={25.04,25.04,21.46,21.46},
      til={Z_,Z_,Z_,Z_},
      azi={N_,S_,E_,W_}),
    redeclare package Medium = MediumA,
    hRoo=1.65,
    nConExt=4,
    nConBou=12,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=163.88,
    nConPar=0,
    nSurBou=0,
    datConBou(
      layers={matFlo,matFlo,matFlo,matFlo,matFlo,matFlo,matCeil,matCeil,matCeil,
          matCeil,matCeil,matCeil},
      A={19.32,26.46,12.29,35.27,35.27,35.27,19.32,15.95,22.80,35.27,35.27,
          35.27},
      til={C_,C_,C_,C_,C_,C_,F_,F_,F_,F_,F_,F_}),
    lat=weaDat.lat,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2) "Room model for Case 600"
    annotation (Placement(transformation(extent={{128,-278},{174,-248}})));
Buildings.ThermalZones.Detailed.MixedAir plenum2(
    nConExtWin=0,
    datConExt(
      layers={roof,matExtWal,matExtWal,matExtWal,matExtWal},
      A={163.88,27.31,27.31,23.41,23.41},
      til={C_,Z_,Z_,Z_,Z_},
      azi={S_,N_,S_,E_,W_}),
    redeclare package Medium = MediumA,
    hRoo=1.8,
    nConExt=5,
    nConBou=6,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=163.88,
    nConPar=0,
    nSurBou=0,
    datConBou(
      layers={matCeil,matCeil,matCeil,matCeil,matCeil,matCeil},
      A={19.32,26.46,12.29,35.27,35.27,35.27},
      til={F_,F_,F_,F_,F_,F_}),
    lat=weaDat.lat,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2) "Room model for Case 600"
    annotation (Placement(transformation(extent={{124,56},{170,86}})));
Modelica.Blocks.Sources.Constant qConGai_flowple2(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-272,112},{-264,120}})));
Modelica.Blocks.Sources.Constant qRadGai_flowple2(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-260,120},{-252,128}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_1(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-234,112},{-226,120}})));
Modelica.Blocks.Sources.Constant qLatGai_flowple2(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-260,104},{-252,112}})));
Modelica.Blocks.Sources.Constant qConGai_flowple1(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-272,-240},{-264,-232}})));
Modelica.Blocks.Sources.Constant qRadGai_flowple1(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-260,-232},{-252,-224}})));
Modelica.Blocks.Routing.Multiplex3 multiplex3_14(n1=1, n2=1)
  annotation (Placement(transformation(extent={{-234,-240},{-226,-232}})));
Modelica.Blocks.Sources.Constant qLatGai_flowple1(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-260,-248},{-252,-240}})));
Modelica.Blocks.Sources.Constant Infiltple1(k=1.2*163.88*1.8*0.432/3600)
    "0.432ACH"
    annotation (Placement(transformation(extent={{-188,-156},{-178,-146}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInfple1(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-156,-158},{-144,-146}})));
Buildings.Fluid.Sources.Outside souInfPle1(redeclare package Medium = MediumA,
      nPorts=1) "Source model for air infiltration"
    annotation (Placement(transformation(extent={{-132,-278},{-122,-268}})));
Buildings.Fluid.Sources.MassFlowSource_T sinInfple2(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_T_in=false,
    use_X_in=false,
    use_C_in=false,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-118,176},{-106,188}})));
Modelica.Blocks.Sources.Constant Infiltple2(k=1.2*163.88*1.8*0.432/3600)
    "0.432ACH"
    annotation (Placement(transformation(extent={{-150,178},{-138,190}})));
Buildings.Fluid.Sources.Outside souInfPle2(redeclare package Medium = MediumA,
      nPorts=1) "Source model for air infiltration"
    annotation (Placement(transformation(extent={{-138,-6},{-128,4}})));
equation

  connect(roo204.heaPorAir, TRooAir204.port) annotation (Line(
      points={{-11.3,26},{214,26},{214,59.5},{231,59.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sinInf204.ports[1], roo204.ports[1]) annotation (Line(
      points={{-106,96},{-82,96},{-82,13.3333},{-29.5,13.3333}},
      color={0,127,255},
      smooth=Smooth.None));
connect(weaDat.weaBus,roo201.weaBus) annotation (Line(
    points={{268,-52},{202,-52},{202,18.425},{157.585,18.425}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo203.weaBus) annotation (Line(
    points={{268,-52},{214,-52},{214,30.425},{81.585,30.425}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo206.weaBus) annotation (Line(
    points={{268,-52},{136,-52},{136,-73.575},{101.585,-73.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo202.weaBus) annotation (Line(
      points={{268,-52},{192,-52},{192,-24},{118,-24},{118,-19.575},{43.585,
          -19.575}},
      color={255,204,51},
      thickness=0.5));
connect(weaDat.weaBus,roo205.weaBus) annotation (Line(
    points={{268,-52},{210,-52},{210,-63.575},{-8.415,-63.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo101.weaBus) annotation (Line(
    points={{268,-52},{202,-52},{202,-307.575},{151.585,-307.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo102.weaBus) annotation (Line(
    points={{268,-52},{200,-52},{200,-307.575},{83.585,-307.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo106.weaBus) annotation (Line(
    points={{268,-52},{202,-52},{202,-399.575},{105.585,-399.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo103.weaBus) annotation (Line(
    points={{268,-52},{198,-52},{198,-345.575},{47.585,-345.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo105.weaBus) annotation (Line(
    points={{268,-52},{202,-52},{202,-389.575},{-4.415,-389.575}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo104.weaBus) annotation (Line(
    points={{268,-52},{203.635,-52},{203.635,-284.1},{5.27,-284.1}},
    color={255,204,51},
    thickness=0.5));
connect(weaDat.weaBus,roo204.weaBus) annotation (Line(
    points={{268,-52},{194,-52},{194,43.9},{13.27,43.9}},
    color={255,204,51},
    thickness=0.5));

connect(weaDat.weaBus, weaBus) annotation (Line(
    points={{268,-52},{182,-52},{182,-58},{-64,-58},{-64,-76},{-100,-76}},
    color={255,204,51},
    thickness=0.5,
    smooth=Smooth.None), Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));
connect(weaDat.weaBus, weaBus1) annotation (Line(
    points={{268,-52},{204,-52},{204,-444},{-98,-444}},
    color={255,204,51},
    thickness=0.5,
    smooth=Smooth.None), Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));

  connect(roo104.heaPorAir, TRooAir104.port) annotation (Line(
      points={{-19.3,-302},{-2,-302},{-2,-294},{226,-294},{226,-284},{236,-284}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sinInf104.ports[1], roo104.ports[1]) annotation (Line(
      points={{-146,-212},{-60,-212},{-60,-314.667},{-37.5,-314.667}},
      color={0,127,255},
      smooth=Smooth.None));
connect(realExpression12.y, preHea12.Q_flow)
  annotation (Line(points={{-37.3,-338},{-34,-338}}, color={0,0,127}));

connect(realExpression13.y, preHea13.Q_flow)
  annotation (Line(points={{-47.3,-430},{-44,-430}}, color={0,0,127}));
connect(realExpression14.y, preHea14.Q_flow)
  annotation (Line(points={{50.7,-382},{56,-382}}, color={0,0,127}));
connect(realExpression16.y, preHea16.Q_flow)
  annotation (Line(points={{104.7,-354},{112,-354}}, color={0,0,127}));
connect(preHea12.port, roo104.surf_conBou[1]) annotation (Line(points={{-22,
          -338},{-10,-338},{-10,-318.8},{-10.2,-318.8}},
                                                       color={191,0,0}));
connect(preHea16.port, roo101.surf_conBou[1]) annotation (Line(points={{124,
          -354},{124,-344},{138,-344},{138,-334},{137.9,-334},{137.9,-333.563}},
                                                color={191,0,0}));
connect(preHea13.port, roo105.surf_conBou[1]) annotation (Line(points={{-32,
          -430},{-18,-430},{-18,-415.6},{-18.1,-415.6}},
                                                       color={191,0,0}));
connect(preHea17.port, roo106.surf_conBou[1]) annotation (Line(points={{50,-452},
          {92,-452},{92,-425.625},{91.9,-425.625}},     color={191,0,0}));
connect(realExpression17.y, preHea17.Q_flow) annotation (Line(points={{26.7,
        -450},{30,-450},{30,-452},{38,-452}}, color={0,0,127}));
connect(realExpression21.y, preHea21.Q_flow)
  annotation (Line(points={{-15.3,-380},{-6,-380}},  color={0,0,127}));

  connect(sinInf203.ports[1], roo203.ports[1]) annotation (Line(points={{-106,
          114},{6,114},{6,7.5},{43.75,7.5}}, color={0,127,255}));
  connect(sinInf201.ports[1], roo201.ports[1]) annotation (Line(points={{-106,
          156},{96,156},{96,44},{119.75,44},{119.75,-4}},  color={0,127,255}));

  connect(roo201.heaPorAir, TRooAir201.port) annotation (Line(points={{135.85,5},
          {135.85,8},{214,8},{214,124.5},{229,124.5}},
                                color={191,0,0}));
  connect(roo101.heaPorAir, TRooAir101.port) annotation (Line(points={{129.85,
          -321},{214,-321},{214,-214},{236,-214}},
                                             color={191,0,0}));
  connect(roo202.heaPorAir, TRooAir202.port) annotation (Line(points={{21.85,
          -33},{96.075,-33},{96.075,-35.5},{210,-35.5},{210,100},{232,100}},
                                color={191,0,0}));
  connect(roo206.heaPorAir, TRooAir206.port) annotation (Line(points={{79.85,
          -87},{124.075,-87},{124.075,-86},{218,-86},{218,11},{232,11}},
                                  color={191,0,0}));
  connect(roo205.heaPorAir, TRooAir205.port) annotation (Line(points={{-30.15,
          -77},{-30.15,-72},{216,-72},{216,36.5},{231,36.5}},
                                                  color={191,0,0}));
  connect(sinInf105.ports[1], roo105.ports[1]) annotation (Line(points={{-146,
          -232},{-58,-232},{-58,-412},{-50,-412},{-50,-412.5},{-42.25,-412.5}},
                                                                          color=
         {0,127,255}));

  connect(roo105.heaPorAir, TRooAir105.port) annotation (Line(points={{-26.15,
          -403},{10,-403},{10,-402},{226,-402},{226,-306},{236,-306}},
                                    color={191,0,0}));

  connect(roo106.heaPorAir, TRooAir106.port) annotation (Line(points={{83.85,
          -413},{228,-413},{228,-332},{236,-332}},
                                             color={191,0,0}));
  connect(sinInf101.ports[1], roo101.ports[1]) annotation (Line(points={{-144,
          -172},{113.75,-172},{113.75,-330}},
                                          color={0,127,255}));

  connect(roo103.heaPorAir, TRooAir103.port) annotation (Line(points={{25.85,
          -359},{222,-359},{222,-262},{236,-262}}, color={191,0,0}));
  connect(roo102.heaPorAir, TRooAir102.port) annotation (Line(points={{61.85,
          -321},{61.85,-322},{218,-322},{218,-236},{236,-236}},
                                                   color={191,0,0}));
  connect(sinInf106.ports[1], roo106.ports[1]) annotation (Line(points={{-146,
          -252},{56,-252},{56,-422},{67.75,-422},{67.75,-422.5}},
                                                            color={0,127,255}));
  connect(sinInf102.ports[1], roo102.ports[1]) annotation (Line(points={{-146,
          -194},{45.75,-194},{45.75,-330.5}},                   color={0,127,255}));

  connect(roo203.heaPorAir, TRooAir203.port) annotation (Line(points={{59.85,17},
          {59.85,36},{212,36},{212,80},{232,80}},
                                    color={191,0,0}));

  connect(sinInf206.ports[1], roo206.ports[1]) annotation (Line(points={{-104,56},
          {26,56},{26,-96},{30,-96},{30,-96.5},{63.75,-96.5}},         color={0,
          127,255}));
  connect(sinInf205.ports[1], roo205.ports[1]) annotation (Line(points={{-106,74},
          {-86,74},{-86,-86},{-46.25,-86},{-46.25,-86.5}},      color={0,127,255}));

  connect(port_104[:], roo104.ports[2:3]) annotation (Line(points={{-111,-244},
          {-70,-244},{-70,-309.333},{-37.5,-309.333}},
                                              color={0,127,255}));
  connect(port_102[:], roo102.ports[2:3]) annotation (Line(points={{-7,-213},{
          36,-213},{36,-326.5},{45.75,-326.5}},
                                       color={0,127,255}));
  connect(port_103[:], roo103.ports[1:2]) annotation (Line(points={{-93,-328},{
          9.75,-328},{9.75,-365}},
                                color={0,127,255}));
  connect(port_105[:], roo105.ports[2:3]) annotation (Line(points={{-140,-368},
          {-42.25,-368},{-42.25,-408.5}},
                                  color={0,127,255}));
  connect(port_106[:], roo106.ports[2:3]) annotation (Line(points={{129,-377},{
          129,-418.5},{67.75,-418.5}},
                           color={0,127,255}));
  connect(port_205[:], roo205.ports[2:3]) annotation (Line(points={{-92,28},{-46.25,
          28},{-46.25,-82.5}},    color={0,127,255}));
  connect(port_204[:], roo204.ports[2:3]) annotation (Line(points={{-52,74},{
          -64,74},{-64,18.6667},{-29.5,18.6667}},
                                   color={0,127,255}));
  connect(port_203[:], roo203.ports[2:3]) annotation (Line(points={{75,77},{20,77},
          {20,11.5},{43.75,11.5}},   color={0,127,255}));
  connect(port_202[:], roo202.ports[1:2]) annotation (Line(points={{-21,-4},{-21,
          -39},{5.75,-39}},            color={0,127,255}));
  connect(port_206[:], roo206.ports[2:3]) annotation (Line(points={{142,-32},{14,
          -32},{14,-92.5},{63.75,-92.5}},    color={0,127,255}));
  connect(Infilt201.y, sinInf201.m_flow_in) annotation (Line(points={{-137.4,
          158},{-130,158},{-130,160.8},{-119.2,160.8}},
                                               color={0,0,127}));
  connect(Infilt203.y, sinInf203.m_flow_in) annotation (Line(points={{-135.4,
          114},{-132,114},{-132,118.8},{-119.2,118.8}},
                                               color={0,0,127}));
  connect(Infilt204.y, sinInf204.m_flow_in) annotation (Line(points={{-135.4,94},
          {-130,94},{-130,100.8},{-119.2,100.8}},
                                               color={0,0,127}));
  connect(Infilt205.y, sinInf205.m_flow_in) annotation (Line(points={{-135.4,72},
          {-130,72},{-130,78.8},{-119.2,78.8}},
                                            color={0,0,127}));
  connect(Infilt206.y, sinInf206.m_flow_in) annotation (Line(points={{-135.4,52},
          {-126,52},{-126,60.8},{-117.2,60.8}},   color={0,0,127}));
  connect(Infilt101.y, sinInf101.m_flow_in) annotation (Line(points={{-177.5,
          -171},{-166,-171},{-166,-167.2},{-157.2,-167.2}},
                                                      color={0,0,127}));
  connect(Infilt102.y, sinInf102.m_flow_in) annotation (Line(points={{-177.5,-191},
          {-170,-191},{-170,-189.2},{-159.2,-189.2}}, color={0,0,127}));
  connect(Infilt104.y, sinInf104.m_flow_in) annotation (Line(points={{-177.5,-211},
          {-170,-211},{-170,-207.2},{-159.2,-207.2}}, color={0,0,127}));
  connect(Infilt105.y, sinInf105.m_flow_in) annotation (Line(points={{-177.5,-231},
          {-168.75,-231},{-168.75,-227.2},{-159.2,-227.2}}, color={0,0,127}));
  connect(Infilt106.y, sinInf106.m_flow_in) annotation (Line(points={{-177.5,-253},
          {-168.75,-253},{-168.75,-247.2},{-159.2,-247.2}}, color={0,0,127}));
  connect(souInf101.weaBus, weaBus1) annotation (Line(
      points={{-132,-286.9},{-154,-286.9},{-154,-444},{-98,-444}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(souInf101.ports[1], roo101.ports[2]) annotation (Line(points={{-122,
          -287},{90,-287},{90,-294},{102,-294},{102,-327},{113.75,-327}}, color=
         {0,127,255}));
  connect(weaBus, souInf201.weaBus) annotation (Line(
      points={{-100,-76},{-148,-76},{-148,-14.9},{-136,-14.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TRooAir201.T, TRoo_2.u1[1]) annotation (Line(points={{248,124.5},{266,
          124.5},{266,75.15},{271.72,75.15}},
                                           color={0,0,127}));
  connect(TRooAir202.T, TRoo_2.u2[1]) annotation (Line(points={{248,100},{264,
          100},{264,68.69},{271.72,68.69}},
                                       color={0,0,127}));
  connect(TRooAir203.T, TRoo_2.u3[1]) annotation (Line(points={{248,80},{262,80},
          {262,62.23},{271.72,62.23}}, color={0,0,127}));
  connect(TRooAir204.T, TRoo_2.u4[1]) annotation (Line(points={{248,59.5},{288,
          59.5},{288,55.77},{271.72,55.77}},    color={0,0,127}));
  connect(TRooAir205.T, TRoo_2.u5[1]) annotation (Line(points={{248,36.5},{264,
          36.5},{264,49.31},{271.72,49.31}},    color={0,0,127}));
  connect(TRooAir206.T, TRoo_2.u6[1]) annotation (Line(points={{250,11},{266,11},
          {266,42.85},{271.72,42.85}},        color={0,0,127}));
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
  connect(TRoo_2.y, TrooVecSec) annotation (Line(points={{313.9,59},{324,59},{
          324,60},{328,60},{328,58},{338,58}},      color={0,0,127}));
  connect(qRadGai_flow204.y, multiplex3_2.u1[1]) annotation (Line(
      points={{-249.6,88},{-248,88},{-248,82.8},{-232.8,82.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow204.y, multiplex3_2.u3[1]) annotation (Line(
      points={{-249.6,72},{-236,72},{-236,76},{-234,76},{-234,77.2},{-232.8,
          77.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow204.y, multiplex3_2.u2[1]) annotation (Line(
      points={{-261.6,80},{-232.8,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_2.y, roo204.qGai_flow) annotation (Line(points={{-223.6,80},
          {-208,80},{-208,34},{-38.08,34}},  color={0,0,127}));
  connect(qRadGai_flow203.y, multiplex3_3.u1[1]) annotation (Line(
      points={{-247.6,54},{-246,54},{-246,48.8},{-230.8,48.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow203.y, multiplex3_3.u3[1]) annotation (Line(
      points={{-247.6,38},{-234,38},{-234,42},{-232,42},{-232,43.2},{-230.8,
          43.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow203.y, multiplex3_3.u2[1]) annotation (Line(
      points={{-259.6,46},{-230.8,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow201.y, multiplex3_4.u1[1]) annotation (Line(
      points={{-249.6,16},{-248,16},{-248,10.8},{-232.8,10.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow201.y, multiplex3_4.u3[1]) annotation (Line(
      points={{-249.6,2},{-236,2},{-236,4},{-234,4},{-234,5.2},{-232.8,5.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow201.y, multiplex3_4.u2[1]) annotation (Line(
      points={{-261.6,8},{-232.8,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow202.y, multiplex3_5.u1[1]) annotation (Line(
      points={{-249.6,-16},{-248,-16},{-248,-21.2},{-232.8,-21.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow202.y, multiplex3_5.u3[1]) annotation (Line(
      points={{-249.6,-30},{-236,-30},{-236,-28},{-234,-28},{-234,-26.8},{
          -232.8,-26.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow202.y, multiplex3_5.u2[1]) annotation (Line(
      points={{-261.6,-24},{-232.8,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow205.y, multiplex3_6.u1[1]) annotation (Line(
      points={{-249.6,-48},{-248,-48},{-248,-53.2},{-232.8,-53.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow205.y, multiplex3_6.u3[1]) annotation (Line(
      points={{-249.6,-62},{-236,-62},{-236,-60},{-234,-60},{-234,-58.8},{
          -232.8,-58.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow205.y, multiplex3_6.u2[1]) annotation (Line(
      points={{-261.6,-56},{-232.8,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qRadGai_flow206.y, multiplex3_7.u1[1]) annotation (Line(
      points={{-249.6,-80},{-248,-80},{-248,-85.2},{-232.8,-85.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flow206.y, multiplex3_7.u3[1]) annotation (Line(
      points={{-249.6,-94},{-236,-94},{-236,-92},{-234,-92},{-234,-90.8},{
          -232.8,-90.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow206.y, multiplex3_7.u2[1]) annotation (Line(
      points={{-261.6,-88},{-232.8,-88}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_3.y, roo203.qGai_flow) annotation (Line(points={{-221.6,46},
          {-210,46},{-210,24},{-86,24},{-86,23},{36.16,23}},           color={0,
          0,127}));
  connect(multiplex3_4.y, roo201.qGai_flow) annotation (Line(points={{-223.6,8},
          {-210,8},{-210,11},{112.16,11}},          color={0,0,127}));
  connect(multiplex3_5.y, roo202.qGai_flow) annotation (Line(points={{-223.6,
          -24},{-208,-24},{-208,-26},{-114,-26},{-114,-27},{-1.84,-27}},color={
          0,0,127}));
  connect(multiplex3_6.y, roo205.qGai_flow) annotation (Line(points={{-223.6,
          -56},{-210,-56},{-210,-71},{-53.84,-71}},     color={0,0,127}));
  connect(multiplex3_7.y, roo206.qGai_flow) annotation (Line(points={{-223.6,
          -88},{-14,-88},{-14,-81},{56.16,-81}},     color={0,0,127}));
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
  connect(qRadGai_flowple2.y, multiplex3_1.u1[1]) annotation (Line(
      points={{-251.6,124},{-250,124},{-250,118.8},{-234.8,118.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flowple2.y, multiplex3_1.u3[1]) annotation (Line(
      points={{-251.6,108},{-238,108},{-238,112},{-236,112},{-236,113.2},{
          -234.8,113.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flowple2.y, multiplex3_1.u2[1]) annotation (Line(
      points={{-263.6,116},{-234.8,116}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(plenum2.qGai_flow, multiplex3_1.y) annotation (Line(points={{122.16,
          77},{-54,77},{-54,26},{-204,26},{-204,116},{-225.6,116}}, color={0,0,
          127}));
  connect(qRadGai_flowple1.y, multiplex3_14.u1[1]) annotation (Line(
      points={{-251.6,-228},{-250,-228},{-250,-233.2},{-234.8,-233.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGai_flowple1.y, multiplex3_14.u3[1]) annotation (Line(
      points={{-251.6,-244},{-238,-244},{-238,-240},{-236,-240},{-236,-238.8},{
          -234.8,-238.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flowple1.y, multiplex3_14.u2[1]) annotation (Line(
      points={{-263.6,-236},{-234.8,-236}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(plenum1.qGai_flow, multiplex3_14.y) annotation (Line(points={{126.16,
          -257},{-48,-257},{-48,-262},{-200,-262},{-200,-236},{-225.6,-236}},
        color={0,0,127}));
  connect(Infiltple1.y, sinInfple1.m_flow_in) annotation (Line(points={{-177.5,
          -151},{-168.75,-151},{-168.75,-147.2},{-157.2,-147.2}}, color={0,0,
          127}));
  connect(sinInfple1.ports[1], plenum1.ports[1]) annotation (Line(points={{-144,
          -152},{102,-152},{102,-272},{133.75,-272}}, color={0,127,255}));
  connect(weaBus1, souInfPle1.weaBus) annotation (Line(
      points={{-98,-444},{-156,-444},{-156,-272.9},{-132,-272.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(souInfPle1.ports[1], plenum1.ports[2]) annotation (Line(points={{-122,
          -273},{-6,-273},{-6,-269},{133.75,-269}}, color={0,127,255}));
  connect(Infiltple2.y, sinInfple2.m_flow_in) annotation (Line(points={{-137.4,
          184},{-128,184},{-128,186.8},{-119.2,186.8}}, color={0,0,127}));
  connect(sinInfple2.ports[1], plenum2.ports[1]) annotation (Line(points={{-106,
          182},{114,182},{114,62},{129.75,62}}, color={0,127,255}));
  connect(weaBus, souInfPle2.weaBus) annotation (Line(
      points={{-100,-76},{-104,-76},{-104,-78},{-152,-78},{-152,-0.9},{-138,
          -0.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(souInfPle2.ports[1], plenum2.ports[2]) annotation (Line(points={{-128,
          -1},{-58,-1},{-58,65},{129.75,65}}, color={0,127,255}));
  connect(plenum2.weaBus, weaDat.weaBus) annotation (Line(
      points={{167.585,84.425},{190,84.425},{190,-52},{268,-52}},
      color={255,204,51},
      thickness=0.5));
  connect(plenum1.weaBus, weaDat.weaBus) annotation (Line(
      points={{171.585,-249.575},{186,-249.575},{186,-52},{268,-52}},
      color={255,204,51},
      thickness=0.5));
  connect(roo101.surf_conBou[2], plenum1.surf_conBou[7]) annotation (Line(
        points={{137.9,-333.188},{137.9,-344},{157.9,-344},{157.9,-274.938}},
        color={191,0,0}));
  connect(roo101.surf_conBou[3], roo102.surf_conBou[5]) annotation (Line(points={{137.9,
          -332.813},{137.9,-344},{69.9,-344},{69.9,-332.625}},        color={
          191,0,0}));
  connect(preHea14.port, roo102.surf_conBou[1]) annotation (Line(points={{68,-382},
          {68,-334},{69.9,-334},{69.9,-333.625}},       color={191,0,0}));
  connect(roo101.surf_conBou[4], roo106.surf_conBou[6]) annotation (Line(points={{137.9,
          -332.438},{137.9,-434},{91.9,-434},{91.9,-424.375}},        color={191,
          0,0}));
  connect(roo102.surf_conBou[2], plenum1.surf_conBou[8]) annotation (Line(
        points={{69.9,-333.375},{69.9,-344},{158,-344},{158,-280},{157.9,-280},
          {157.9,-274.813}},color={191,0,0}));
  connect(roo102.surf_conBou[3], roo104.surf_conBou[3]) annotation (Line(points=
         {{69.9,-333.125},{-10.2,-333.125},{-10.2,-318}}, color={191,0,0}));
  connect(roo102.surf_conBou[6], roo106.surf_conBou[5]) annotation (Line(points=
         {{69.9,-332.375},{69.9,-392},{114,-392},{114,-434},{91.9,-434},{91.9,-424.625}},
        color={191,0,0}));
  connect(preHea21.port, roo103.surf_conBou[1]) annotation (Line(points={{6,-380},
          {33.9,-380},{33.9,-371.625}}, color={191,0,0}));
  connect(roo103.surf_conBou[2], plenum1.surf_conBou[9]) annotation (Line(
        points={{33.9,-371.375},{33.9,-376},{157.9,-376},{157.9,-274.688}},
        color={191,0,0}));
  connect(roo103.surf_conBou[3], roo104.surf_conBou[5]) annotation (Line(points=
         {{33.9,-371.125},{-10.2,-371.125},{-10.2,-317.2}}, color={191,0,0}));
  connect(roo103.surf_conBou[5], roo105.surf_conBou[4]) annotation (Line(points=
         {{33.9,-370.625},{33.9,-430},{-18.1,-430},{-18.1,-414.7}}, color={191,0,
          0}));
  connect(roo103.surf_conBou[6], roo106.surf_conBou[4]) annotation (Line(points=
         {{33.9,-370.375},{33.9,-430},{91.9,-430},{91.9,-424.875}}, color={191,0,
          0}));
  connect(roo104.surf_conBou[2], plenum1.surf_conBou[10]) annotation (Line(
        points={{-10.2,-318.4},{-10,-318.4},{-10,-336},{157.9,-336},{157.9,
          -274.563}},
        color={191,0,0}));
  connect(roo104.surf_conBou[4], roo105.surf_conBou[3]) annotation (Line(points=
         {{-10.2,-317.6},{-10.2,-368},{-2,-368},{-2,-430},{-18.1,-430},{-18.1,-415}},
        color={191,0,0}));
  connect(roo105.surf_conBou[2], plenum1.surf_conBou[11]) annotation (Line(
        points={{-18.1,-415.3},{-18.1,-430},{157.9,-430},{157.9,-274.438}},
        color={191,0,0}));
  connect(roo105.surf_conBou[5], roo106.surf_conBou[3]) annotation (Line(points=
         {{-18.1,-414.4},{-18.1,-430},{91.9,-430},{91.9,-425.125}}, color={191,0,
          0}));
  connect(roo106.surf_conBou[2], plenum1.surf_conBou[12]) annotation (Line(
        points={{91.9,-425.375},{91.9,-434},{157.9,-434},{157.9,-274.313}},
        color={191,0,0}));
  connect(roo201.surf_conBou[3], roo203.surf_conBou[4]) annotation (Line(points=
         {{143.9,-7},{143.9,-12},{144,-12},{144,-16},{67.9,-16},{67.9,5.3}},
        color={191,0,0}));
  connect(roo201.surf_conBou[4], roo202.surf_conBou[5]) annotation (Line(points={{143.9,
          -6.7},{144,-6.7},{144,-16},{68,-16},{68,-50},{29.9,-50},{29.9,
          -44.7857}},
        color={191,0,0}));
  connect(roo201.surf_conBou[5], roo206.surf_conBou[5]) annotation (Line(points=
         {{143.9,-6.4},{143.9,-110},{87.9,-110},{87.9,-98.4}}, color={191,0,0}));
  connect(roo202.surf_conBou[1], plenum1.surf_conBou[2]) annotation (Line(
        points={{29.9,-45.6429},{29.9,-280},{157.9,-280},{157.9,-275.563}},
        color={191,0,0}));
  connect(roo202.surf_conBou[3], roo204.surf_conBou[5]) annotation (Line(points={{29.9,
          -45.2143},{29.9,-54},{-2.2,-54},{-2.2,10.8}},       color={191,0,0}));
  connect(roo202.surf_conBou[4], roo203.surf_conBou[5]) annotation (Line(points=
         {{29.9,-45},{29.9,-50},{67.9,-50},{67.9,5.6}}, color={191,0,0}));
  connect(roo202.surf_conBou[6], roo205.surf_conBou[4]) annotation (Line(points={{29.9,
          -44.5714},{29.9,-98},{-22.1,-98},{-22.1,-88.7}},       color={191,0,0}));
  connect(roo202.surf_conBou[7], roo206.surf_conBou[4]) annotation (Line(points={{29.9,
          -44.3571},{29.9,-110},{87.9,-110},{87.9,-98.7}},       color={191,0,0}));
  connect(roo201.surf_conBou[1], plenum1.surf_conBou[1]) annotation (Line(
        points={{143.9,-7.6},{143.9,-16},{180,-16},{180,-280},{157.9,-280},{
          157.9,-275.688}},
                      color={191,0,0}));
  connect(roo201.surf_conBou[2], plenum2.surf_conBou[1]) annotation (Line(
        points={{143.9,-7.3},{143.9,-16},{180,-16},{180,56},{153.9,56},{153.9,58.375}},
        color={191,0,0}));
  connect(roo202.surf_conBou[1], plenum1.surf_conBou[2]) annotation (Line(
        points={{29.9,-45.6429},{29.9,-110},{180,-110},{180,-280},{157.9,-280},
          {157.9,-275.563}},color={191,0,0}));
  connect(roo202.surf_conBou[2], plenum2.surf_conBou[2]) annotation (Line(
        points={{29.9,-45.4286},{29.9,-50},{180,-50},{180,56},{153.9,56},{153.9,
          58.625}}, color={191,0,0}));
  connect(roo203.surf_conBou[1], plenum1.surf_conBou[3]) annotation (Line(
        points={{67.9,4.4},{67.9,-50},{180,-50},{180,-280},{157.9,-280},{157.9,
          -275.438}},
        color={191,0,0}));
  connect(roo203.surf_conBou[2], plenum2.surf_conBou[3]) annotation (Line(
        points={{67.9,4.7},{67.9,-16},{180,-16},{180,56},{153.9,56},{153.9,58.875}},
        color={191,0,0}));
  connect(roo203.surf_conBou[3], roo204.surf_conBou[3]) annotation (Line(points=
         {{67.9,5},{67.9,-6},{-2.2,-6},{-2.2,10}}, color={191,0,0}));
  connect(roo204.surf_conBou[1], plenum1.surf_conBou[4]) annotation (Line(
        points={{-2.2,9.2},{-2,9.2},{-2,-54},{180,-54},{180,-280},{157.9,-280},
          {157.9,-275.313}},color={191,0,0}));
  connect(roo204.surf_conBou[2], plenum2.surf_conBou[4]) annotation (Line(
        points={{-2.2,9.6},{-2,9.6},{-2,-16},{180,-16},{180,56},{153.9,56},{153.9,
          59.125}}, color={191,0,0}));
  connect(roo204.surf_conBou[4], roo205.surf_conBou[3]) annotation (Line(points=
         {{-2.2,10.4},{-2,10.4},{-2,-98},{-22.1,-98},{-22.1,-89}}, color={191,0,
          0}));
  connect(roo205.surf_conBou[1], plenum1.surf_conBou[5]) annotation (Line(
        points={{-22.1,-89.6},{-22.1,-110},{180,-110},{180,-280},{157.9,-280},{
          157.9,-275.188}},
                      color={191,0,0}));
  connect(roo205.surf_conBou[2], plenum2.surf_conBou[5]) annotation (Line(
        points={{-22.1,-89.3},{-22.1,-110},{180,-110},{180,56},{154,56},{154,60},
          {153.9,60},{153.9,59.375}}, color={191,0,0}));
  connect(roo205.surf_conBou[5], roo206.surf_conBou[3]) annotation (Line(points=
         {{-22.1,-88.4},{-22.1,-110},{87.9,-110},{87.9,-99}}, color={191,0,0}));
  connect(roo206.surf_conBou[1], plenum1.surf_conBou[6]) annotation (Line(
        points={{87.9,-99.6},{87.9,-110},{180,-110},{180,-280},{157.9,-280},{
          157.9,-275.063}},
                      color={191,0,0}));
  connect(roo206.surf_conBou[2], plenum2.surf_conBou[6]) annotation (Line(
        points={{87.9,-99.3},{87.9,-104},{88,-104},{88,-110},{180,-110},{180,56},
          {153.9,56},{153.9,59.625}}, color={191,0,0}));
  connect(souInf201.ports[1], roo201.ports[2]) annotation (Line(points={{-126,
          -15},{-4,-15},{-4,-1},{119.75,-1}}, color={0,127,255}));
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
  Diagram(coordinateSystem(extent={{-300,-460},{320,240}})),
    Icon(coordinateSystem(extent={{-300,-460},{320,240}}), graphics={
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
end FRPMultiZone_Envelope_Icon_v2;
