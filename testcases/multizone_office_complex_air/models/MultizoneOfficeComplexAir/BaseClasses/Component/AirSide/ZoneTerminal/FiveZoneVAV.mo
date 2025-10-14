within MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal;
model FiveZoneVAV "Five thermal zones, VAV terminals, and duct network"
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "medium for the air";

  replaceable package MediumWat = Modelica.Media.Interfaces.PartialMedium "medium for the water";

  parameter Modelica.Units.SI.Pressure PreAirDroMai1
    "pressure drop 1 across the duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai2
    "Pressure drop 2 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai3
    "Pressure drop 3 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai4
    "Pressure drop 4 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroBra1
    "Pressure drop 1 across the duct branch 1";

  parameter Modelica.Units.SI.Pressure PreAirDroBra2
    "Pressure drop 1 across the duct branch 2";

  parameter Modelica.Units.SI.Pressure PreAirDroBra3
    "Pressure drop 1 across the duct branch 3";

  parameter Modelica.Units.SI.Pressure PreAirDroBra4
    "Pressure drop 1 across the duct branch 4";

  parameter Modelica.Units.SI.Pressure PreAirDroBra5
    "Pressure drop 1 across the duct branch 5";

  parameter Modelica.Units.SI.Pressure PreWatDroMai1
    "Pressure drop 1 across the pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai2
    "Pressure drop 2 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai3
    "Pressure drop 3 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai4
    "Pressure drop 4 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroBra1
    "Pressure drop 1 across the pipe branch 1";

  parameter Modelica.Units.SI.Pressure PreWatDroBra2
    "Pressure drop 1 across the pipe branch 2";

  parameter Modelica.Units.SI.Pressure PreWatDroBra3
    "Pressure drop 1 across the pipe branch 3";

  parameter Modelica.Units.SI.Pressure PreWatDroBra4
    "Pressure drop 1 across the pipe branch 4";

  parameter Modelica.Units.SI.Pressure PreWatDroBra5
    "Pressure drop 1 across the pipe branch 5";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat1
    "mass flow rate for vav 1";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat2
    "mass flow rate for vav 2";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat3
    "mass flow rate for vav 3";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat4
    "mass flow rate for vav 4";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat5
    "mass flow rate for vav 5";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat1
    "mass flow rate for vav 1";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat2
    "mass flow rate for vav 2";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat3
    "mass flow rate for vav 3";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat4
    "mass flow rate for vav 4";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat5
    "mass flow rate for vav 5";

  parameter Modelica.Units.SI.Pressure PreDroAir1
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat1
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";

  parameter Modelica.Units.SI.Pressure PreDroAir2
    "Pressure drop in the air side of vav 2";
  parameter Modelica.Units.SI.Pressure PreDroWat2
    "Pressure drop in the water side of vav 2";
  parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
    "Heat exchanger effectiveness of vav 2";

  parameter Modelica.Units.SI.Pressure PreDroAir3
    "Pressure drop in the air side of vav 3";
  parameter Modelica.Units.SI.Pressure PreDroWat3
    "Pressure drop in the water side of vav 3";
  parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
    "Heat exchanger effectiveness of vav 3";

  parameter Modelica.Units.SI.Pressure PreDroAir4
    "Pressure drop in the air side of vav 4";
  parameter Modelica.Units.SI.Pressure PreDroWat4
    "Pressure drop in the water side of vav 4";
  parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
    "Heat exchanger effectiveness of vav 4";

  parameter Modelica.Units.SI.Pressure PreDroAir5
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat5
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
    "Heat exchanger effectiveness of vav 5";

  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=p_start
    "Start value of pressure";
  parameter Modelica.Media.Interfaces.Types.Temperature T_start=T_start
    "Start value of temperature";
  parameter Modelica.Media.Interfaces.Types.MassFraction X_start[MediumAir.nX]=X_start
    "Start value of mass fractions m_i/m";
  parameter Modelica.Media.Interfaces.Types.ExtraProperty C_start[MediumAir.nC]=C_start
    "Start value of trace substances";
  parameter Modelica.Media.Interfaces.Types.ExtraProperty C_nominal[MediumAir.nC]=C_nominal
    "Nominal value of trace substances. (Set to typical order of magnitude.)";

  parameter Modelica.Units.SI.MassFlowRate m_flow_lea[4]=m_flow_lea "Air infiltration mass flow rates to four exterior zones";
  parameter Integer floorMultiplier=1 "Floor multiplier to scale HVAC airflow for the single floor that is modeled in EnergyPlus";

  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneDuctNetwork
    ReheatWatNet(
    redeclare package Medium = MediumWat,
    PreDroMai1=PreWatDroMai1,
    PreDroMai2=PreWatDroMai2,
    PreDroMai3=PreWatDroMai3,
    PreDroMai4=PreWatDroMai4,
    PreDroBra1=PreWatDroBra1,
    PreDroBra2=PreWatDroBra2,
    PreDroBra3=PreWatDroBra3,
    PreDroBra4=PreWatDroBra4,
    PreDroBra5=PreWatDroBra5,
    mFloRat1=mWatFloRat1,
    mFloRat2=mWatFloRat2,
    mFloRat3=mWatFloRat3,
    mFloRat4=mWatFloRat4,
    mFloRat5=mWatFloRat5)
    annotation (Placement(transformation(extent={{-76,64},{-46,30}})));
  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneDuctNetwork
    AirNetWor(
    redeclare package Medium = MediumAir,
    PreDroMai1=PreAirDroMai1,
    PreDroMai2=PreAirDroMai2,
    PreDroMai3=PreAirDroMai3,
    PreDroMai4=PreAirDroMai4,
    mFloRat1=mAirFloRat1,
    mFloRat2=mAirFloRat2,
    mFloRat3=mAirFloRat3,
    mFloRat4=mAirFloRat4,
    mFloRat5=mAirFloRat5,
    PreDroBra1=PreAirDroBra1,
    PreDroBra2=PreAirDroBra2,
    PreDroBra3=PreAirDroBra3,
    PreDroBra4=PreAirDroBra4,
    PreDroBra5=PreAirDroBra5)
    annotation (Placement(transformation(extent={{-74,-52},{-44,-18}})));
  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
    vAV1(
    zonNam="cor",
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat1,
    mWatFloRat=mWatFloRat1,
    PreDroAir=PreDroAir1,
    PreDroWat=PreDroWat1,
    eps=eps1) annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone
                                             zon[5](
    zoneName=zoneName,
    redeclare package Medium = MediumAir,
    each p_start=p_start,
    each T_start=T_start,
    each X_start=X_start,
    each final C_start=C_start,
    each C_nominal=C_nominal,
    each nPorts=5,
    each use_C_flow=true)
    annotation (Placement(transformation(extent={{70,-70},{90,-50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package Medium =
        MediumWat) "Second port, typically outlet"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package Medium =
        MediumWat) "Second port, typically outlet"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium =
        MediumAir)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium =
        MediumAir)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.RealInput airFloRatSet[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,76},{-100,96}})));
  Modelica.Blocks.Interfaces.RealInput yVal[5]
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.BooleanInput on[5]
    "Zonal On signal (not implemented)"
    annotation (Placement(transformation(extent={{-120,-22},{-100,-2}})));
  Modelica.Blocks.Interfaces.RealOutput ducStaPre "Actual duct tatic pressure "
    annotation (Placement(transformation(extent={{200,-22},{220,-2}}),
        iconTransformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Interfaces.RealOutput TZon[5]
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{200,70},{220,90}}),
        iconTransformation(extent={{100,30},{120,50}})));

  Modelica.Blocks.Interfaces.RealOutput yDam[5]
    "Control signal for terminal box damper"
    annotation (Placement(transformation(extent={{200,44},{220,64}}),
        iconTransformation(extent={{100,4},{120,24}})));
  Modelica.Blocks.Sources.RealExpression yDamMea[5](y={vAV1.dam.y_actual,vAV2.dam.y_actual,
        vAV3.dam.y_actual,vAV4.dam.y_actual,vAV5.dam.y_actual})
    annotation (Placement(transformation(extent={{170,44},{190,64}}),
        iconTransformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput yReaHea[5]
    "Control signal for terminal box reheat"
    annotation (Placement(transformation(extent={{200,18},{220,38}}),
        iconTransformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Sources.RealExpression yReaValMea[5](y={vAV1.rehVal.y_actual,
        vAV2.rehVal.y_actual,vAV3.rehVal.y_actual,vAV4.rehVal.y_actual,vAV5.rehVal.y_actual})
    annotation (Placement(transformation(extent={{170,18},{190,38}})));

  Modelica.Blocks.Sources.RealExpression TZonAir[5](y=zon.heaPorAir.T)
    annotation (Placement(transformation(extent={{170,70},{190,90}})));
  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
    vAV2(
    zonNam="sou",
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat2,
    mWatFloRat=mWatFloRat2,
    PreDroAir=PreDroAir2,
    PreDroWat=PreDroWat2,
    eps=eps2) annotation (Placement(transformation(extent={{30,-2},{50,18}})));
  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
    vAV3(
    zonNam="eas",
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat3,
    mWatFloRat=mWatFloRat3,
    PreDroAir=PreDroAir3,
    PreDroWat=PreDroWat3,
    eps=eps3) annotation (Placement(transformation(extent={{72,-2},{92,18}})));
  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
    vAV4(
    zonNam="nor",
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat4,
    mWatFloRat=mWatFloRat4,
    PreDroAir=PreDroAir4,
    PreDroWat=PreDroWat4,
    eps=eps4) annotation (Placement(transformation(extent={{118,-2},{138,18}})));
  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
    vAV5(
    zonNam="wes",
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat5,
    mWatFloRat=mWatFloRat5,
    PreDroAir=PreDroAir5,
    PreDroWat=PreDroWat5,
    eps=eps5) annotation (Placement(transformation(extent={{158,-2},{178,18}})));

  Modelica.Blocks.Sources.RealExpression Vflow_setMea[5](y={vAV1.airFloRatSet
        *vAV1.mAirFloRat/1.2,vAV2.airFloRatSet*vAV2.mAirFloRat/1.2,vAV3.airFloRatSet
        *vAV3.mAirFloRat/1.2,vAV4.airFloRatSet*vAV4.mAirFloRat/1.2,vAV5.airFloRatSet
        *vAV5.mAirFloRat/1.2})
    "VAV terminal airflow setpoint measurement"
    annotation (Placement(transformation(extent={{170,-50},{190,-30}})));
  Modelica.Blocks.Interfaces.RealOutput Vflow_set[5]
    "VAV terminal airflow setpoint" annotation (Placement(transformation(
          extent={{200,-50},{220,-30}}), iconTransformation(extent={{100,-46},
            {120,-26}})));
  Modelica.Blocks.Sources.RealExpression Vflow_Mea[5](y={vAV1.V_flowLea.V_flow,
        vAV2.V_flowLea.V_flow,vAV3.V_flowLea.V_flow,vAV4.V_flowLea.V_flow,vAV5.V_flowLea.V_flow})
                                      "VAV terminal airflow measurement"
    annotation (Placement(transformation(extent={{170,-70},{190,-50}})));
  Modelica.Blocks.Interfaces.RealOutput Vflow[5] "VAV terminal airflow"
    annotation (Placement(transformation(extent={{200,-70},{220,-50}}),
        iconTransformation(extent={{100,-72},{120,-52}})));
  Modelica.Blocks.Interfaces.RealOutput TSup[5]
    "VAV supply air temperature" annotation (Placement(transformation(
          extent={{200,-90},{220,-70}}), iconTransformation(extent={{100,56},
            {120,76}})));
  Modelica.Blocks.Sources.RealExpression TSupMea[5](y={vAV1.TAirLea,vAV2.TAirLea,
        vAV3.TAirLea,vAV4.TAirLea,vAV5.TAirLea})
    annotation (Placement(transformation(extent={{170,-90},{190,-70}})));

  Modelica.Blocks.Interfaces.RealInput nPeo[5] "Number of occupant" annotation (
     Placement(transformation(extent={{-120,-100},{-100,-80}}),
        iconTransformation(extent={{-120,-106},{-100,-86}})));
  Modelica.Blocks.Math.Gain gaiCO2[5](each k=8.18E-6) "CO2 emission per person"
    annotation (Placement(transformation(extent={{-40,-96},{-28,-84}})));

  Buildings.Fluid.Sensors.TraceSubstances senCO2[5](redeclare package Medium = MediumAir,
    each warnAboutOnePortConnection=false) "Sensor at volume"
    annotation (Placement(transformation(extent={{84,-102},{100,-86}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra[5](each
      MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{108,-100},{120,-88}})));
  Modelica.Blocks.Math.Gain gaiPPM[5](each k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{130,-100},{142,-88}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Zon[5]
    "Zonal CO2 volume fraction PPM" annotation (Placement(transformation(
          extent={{200,-104},{220,-84}}), iconTransformation(extent={{100,
            80},{120,100}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData infAir[4](
    use_m_flow_in=true,
    each nPorts=1,
    redeclare package Medium = MediumAir,
    C={fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumAir.nC),
        fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumAir.nC),
        fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumAir.nC),
        fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumAir.nC)})
    "Air infiltration through the envelope for four exterior zones (no infiltration for core zone)"
    annotation (Placement(transformation(extent={{38,-140},{58,-120}})));

  Modelica.Icons.SignalBus weaBus
    annotation (Placement(transformation(extent={{-10,-108},{6,-92}}),
        iconTransformation(extent={{-10,-108},{6,-92}})));

  Modelica.Blocks.Sources.RealExpression m_flow_infAir[4](y=m_flow_lea)
    "Infiltration nominal air flow rate"
    annotation (Placement(transformation(extent={{-86,-114},{-66,-94}})));
  Modelica.Blocks.Sources.RealExpression schFac_infAir[4](y={if on[1] == true
         then 0.25 else 1.0 for i in 1:4})
    "Schedule factor for infiltration air (refer to E+)"
    annotation (Placement(transformation(extent={{-86,-134},{-66,-114}})));
  Modelica.Blocks.Math.Gain winSpe_infAir[4](each k=0.224)
    "Wind speed factor for infiltration air (refer to E+)"
    annotation (Placement(transformation(extent={{-80,-148},{-66,-134}})));
  Modelica.Blocks.Math.MultiProduct multiProduct[4](nu=3)
    annotation (Placement(transformation(extent={{-38,-120},{-26,-108}})));
  Buildings.Fluid.Sources.MassFlowSource_T exfAir[4](
    use_C_in=true,
    use_m_flow_in=true,
    redeclare package Medium = MediumAir,
    each use_T_in=true,
    each nPorts=1)
    "Air exfiltration through the envelope for four exterior zones"
    annotation (Placement(transformation(extent={{134,-140},{154,-120}})));
  Modelica.Blocks.Math.Gain gain[4](k=-1)
    annotation (Placement(transformation(extent={{68,-116},{80,-104}})));
  Modelica.Blocks.Routing.Replicator replicator[4](nout=MediumAir.nC)
    annotation (Placement(transformation(extent={{108,-144},{120,-132}})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{128,-42},{148,-22}})));
  Buildings.Fluid.Sources.Outside out(redeclare package Medium = MediumAir,
      nPorts=1)
    annotation (Placement(transformation(extent={{26,-58},{46,-38}})));
  parameter String zoneName[5]
    "Name of the thermal zones as specified in the EnergyPlus input";
  Modelica.Blocks.Sources.Constant qIntMod[5,3](k=0)
    "Zero internal gains from Modelica"
    annotation (Placement(transformation(extent={{-68,-80},{-48,-60}})));
  Modelica.Blocks.Sources.RealExpression TZonAir1[4](y={zon[2].heaPorAir.T,zon[3].heaPorAir.T,
        zon[4].heaPorAir.T,zon[5].heaPorAir.T})
    annotation (Placement(transformation(extent={{68,-158},{88,-138}})));
  Buildings.Fluid.BaseClasses.MassFlowRateMultiplier m_flow_mulSup[5](
      redeclare package Medium = MediumAir, k=1/floorMultiplier)
    "Air mass flow rate multiplier for supply to zones"
    annotation (Placement(transformation(extent={{-30,-50},{-20,-40}})));
  Buildings.Fluid.BaseClasses.MassFlowRateMultiplier m_flow_mulRet[5](
      redeclare package Medium = MediumAir, k=floorMultiplier)
    "Air mass flow rate multiplier for return from zones"
    annotation (Placement(transformation(extent={{-20,-66},{-30,-56}})));
equation
  for i in 1:5 loop
    connect(m_flow_mulSup[i].port_b, zon[i].ports[1]);
    connect(zon[i].ports[2], m_flow_mulRet[i].port_a);
    connect(m_flow_mulRet[i].port_b, AirNetWor.ports_a[i]);
  end for;

  connect(ReheatWatNet.port_b, port_b_Wat) annotation (Line(
      points={{-76,57.2},{-74,57.2},{-74,72},{40,72},{40,100}},
      color={255,0,0},
      thickness=1));
  connect(ReheatWatNet.port_a, port_a_Wat) annotation (Line(
      points={{-76,40.2},{-76,40.2},{-76,40},{-82,40},{-82,76},{-40,76},{
          -40,100}},
      color={255,0,0},
      thickness=1));
  connect(AirNetWor.port_a, port_a_Air)
    annotation (Line(points={{-74,-28.2},{-88,-28.2},{-88,40},{-100,40}}, color={0,140,72},
      thickness=0.5));
  connect(AirNetWor.port_b, port_b_Air)
    annotation (Line(points={{-74,-45.2},{-80,-45.2},{-80,-60},{-100,-60}}, color={0,140,72},
      thickness=0.5));
  connect(TZonAir.y, TZon) annotation (Line(
      points={{191,80},{210,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(on[2], vAV2.On) annotation (Line(points={{-110,-14},{18,-14},{18,2.44444},
          {29,2.44444}},
               color={255,0,255}));
  connect(on[3], vAV3.On) annotation (Line(points={{-110,-12},{-72,-12},{-72,-8},
          {56,-8},{56,2.44444},{71,2.44444}},
                              color={255,0,255}));
  connect(on[4], vAV4.On) annotation (Line(points={{-110,-10},{-72,-10},{-72,-10},
          {100,-10},{100,2.44444},{117,2.44444}},
                                 color={255,0,255}));
  connect(on[5], vAV5.On) annotation (Line(points={{-110,-8},{-72,-8},{-72,-10},
          {148,-10},{148,2.44444},{157,2.44444}},
                                 color={255,0,255}));
  connect(on[1], vAV1.On) annotation (Line(points={{-110,-16},{-72,-16},{-72,2.44444},
          {-11,2.44444}},
               color={255,0,255}));
  connect(yVal[1], vAV1.yVal) annotation (Line(points={{-110,56},{-34,56},{-34,
          11.3333},{-11,11.3333}},
                     color={0,0,127}));
  connect(yVal[2], vAV2.yVal) annotation (Line(points={{-110,58},{20,58},{20,
          11.3333},{29,11.3333}},
                    color={0,0,127}));
  connect(yVal[3], vAV3.yVal) annotation (Line(points={{-110,60},{64,60},{64,
          11.3333},{71,11.3333}},
                    color={0,0,127}));
  connect(yVal[4], vAV4.yVal) annotation (Line(points={{-110,62},{110,62},{110,
          11.3333},{117,11.3333}},
                     color={0,0,127}));
  connect(yVal[5], vAV5.yVal) annotation (Line(points={{-110,64},{-4,64},{-4,62},
          {150,62},{150,11.3333},{157,11.3333}},
                                       color={0,0,127}));
  connect(airFloRatSet[1], vAV1.airFloRatSet) annotation (Line(points={{-110,82},
          {-30,82},{-30,15.7778},{-11,15.7778}},
                                           color={0,0,127}));
  connect(airFloRatSet[2], vAV2.airFloRatSet) annotation (Line(points={{-110,84},
          {18,84},{18,15.7778},{29,15.7778}},
                                        color={0,0,127}));
  connect(airFloRatSet[3], vAV3.airFloRatSet) annotation (Line(points={{-110,86},
          {62,86},{62,15.7778},{71,15.7778}},
                                        color={0,0,127}));
  connect(airFloRatSet[4], vAV4.airFloRatSet) annotation (Line(points={{-110,88},
          {108,88},{108,15.7778},{117,15.7778}},
                                           color={0,0,127}));
  connect(airFloRatSet[5], vAV5.airFloRatSet) annotation (Line(points={{-110,90},
          {148,90},{148,15.7778},{157,15.7778}},
                                           color={0,0,127}));
  connect(vAV1.port_a_Wat, ReheatWatNet.ports_b[1]) annotation (Line(
      points={{-8,18},{-10,18},{-10,41.9},{-46,41.9}},
      color={238,46,47},
      thickness=0.5));
  connect(vAV2.port_a_Wat, ReheatWatNet.ports_b[2]) annotation (Line(
      points={{32,18},{32,38},{-46,38},{-46,40.54}},
      color={238,46,47},
      thickness=0.5));
  connect(vAV3.port_a_Wat, ReheatWatNet.ports_b[3]) annotation (Line(
      points={{74,18},{74,32},{-46,32},{-46,39.18}},
      color={238,46,47},
      thickness=0.5));
  connect(vAV4.port_a_Wat, ReheatWatNet.ports_b[4]) annotation (Line(
      points={{120,18},{118,18},{118,37.82},{-46,37.82}},
      color={238,46,47},
      thickness=0.5));
  connect(vAV5.port_a_Wat, ReheatWatNet.ports_b[5]) annotation (Line(
      points={{160,18},{162,18},{162,36.46},{-46,36.46}},
      color={238,46,47},
      thickness=0.5));
  connect(vAV1.port_b_Wat, ReheatWatNet.ports_a[1]) annotation (Line(
      points={{-2,18},{-2,60.26},{-46,60.26}},
      color={238,46,47},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(vAV2.port_b_Wat, ReheatWatNet.ports_a[2]) annotation (Line(
      points={{38,18},{40,18},{40,58.9},{-46,58.9}},
      color={238,46,47},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(vAV3.port_b_Wat, ReheatWatNet.ports_a[3]) annotation (Line(
      points={{80,18},{80,54},{-46,54},{-46,57.54}},
      color={238,46,47},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(vAV4.port_b_Wat, ReheatWatNet.ports_a[4]) annotation (Line(
      points={{126,18},{126,56.18},{-46,56.18}},
      color={238,46,47},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(vAV5.port_b_Wat, ReheatWatNet.ports_a[5]) annotation (Line(
      points={{166,18},{166,52},{-46,52},{-46,54.82}},
      color={238,46,47},
      thickness=0.5,
      pattern=LinePattern.Dash));
  connect(vAV1.port_a, AirNetWor.ports_b[1]) annotation (Line(
      points={{-10,6.88889},{-28,6.88889},{-28,-29.9},{-44,-29.9}},
      color={0,127,0},
      thickness=0.5));
  connect(vAV2.port_a, AirNetWor.ports_b[2]) annotation (Line(
      points={{30,6.88889},{16,6.88889},{16,-30},{-16,-30},{-16,-28.54},{-44,-28.54}},
      color={0,127,0},
      thickness=0.5));
  connect(vAV3.port_a, AirNetWor.ports_b[3]) annotation (Line(
      points={{72,6.88889},{58,6.88889},{58,-28},{-44,-28},{-44,-27.18}},
      color={0,127,0},
      thickness=0.5));
  connect(vAV4.port_a, AirNetWor.ports_b[4]) annotation (Line(
      points={{118,6.88889},{108,6.88889},{108,-25.82},{-44,-25.82}},
      color={0,127,0},
      thickness=0.5));
  connect(vAV5.port_a, AirNetWor.ports_b[5]) annotation (Line(
      points={{158,6.88889},{146,6.88889},{146,-24.46},{-44,-24.46}},
      color={0,127,0},
      thickness=0.5));

  connect(yDamMea.y, yDam) annotation (Line(points={{191,54},{210,54}},
                    color={0,0,127}));
  connect(yReaValMea.y, yReaHea)
    annotation (Line(points={{191,28},{210,28}}, color={0,0,127}));
  connect(Vflow_setMea.y, Vflow_set)
    annotation (Line(points={{191,-40},{210,-40}}, color={0,0,127}));
  connect(Vflow_Mea.y, Vflow)
    annotation (Line(points={{191,-60},{210,-60}}, color={0,0,127}));
  connect(TSupMea.y, TSup)
    annotation (Line(points={{191,-80},{210,-80}}, color={0,0,127}));

  connect(nPeo, gaiCO2.u)
    annotation (Line(points={{-110,-90},{-41.2,-90}}, color={0,0,127}));
  connect(gaiCO2.y,zon. C_flow[1])
    annotation (Line(points={{-27.4,-90},{69,-90},{69,-65}}, color={0,0,127}));

  for i in 1:5 loop
    connect(senCO2[i].port,zon [i].ports[1]);
  end for;
  connect(senCO2.C, conMasVolFra.m) annotation (Line(
      points={{100.8,-94},{107.4,-94}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conMasVolFra.V, gaiPPM.u)
    annotation (Line(points={{120.6,-94},{128.8,-94}}, color={0,0,127}));
  connect(gaiPPM.y, CO2Zon) annotation (Line(points={{142.6,-94},{210,-94}},
                                color={0,0,127}));
  for i in 1:4 loop
    connect(infAir[i].ports[1],zon [i+1].ports[1]) annotation (Line(points={{58,-130},
            {79.2,-130},{79.2,-69.55}},                                                                                         color={0,140,72},
        pattern=LinePattern.Dash,
        thickness=0.5));
  end for;

   for i in 1:4 loop
    connect(exfAir[i].ports[1],zon [i + 1].ports[1]) annotation (Line(
        points={{154,-130},{160,-130},{160,-108},{79.2,-108},{79.2,-69.55}},
        color={0,140,72},
        pattern=LinePattern.Dash,
        thickness=0.5));
  end for;

  connect(weaBus,infAir [1].weaBus) annotation (Line(
      points={{-2,-100},{-2,-129.8},{38,-129.8}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus,infAir [2].weaBus) annotation (Line(
      points={{-2,-100},{-2,-129.8},{38,-129.8}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus,infAir [3].weaBus) annotation (Line(
      points={{-2,-100},{-2,-129.8},{38,-129.8}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus,infAir [4].weaBus) annotation (Line(
      points={{-2,-100},{-2,-129.8},{38,-129.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winSpe, winSpe_infAir[1].u) annotation (Line(
      points={{-2,-100},{-2,-156},{-90,-156},{-90,-141},{-81.4,-141}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winSpe, winSpe_infAir[2].u);
  connect(weaBus.winSpe, winSpe_infAir[3].u);
  connect(weaBus.winSpe, winSpe_infAir[4].u);
  for i in 1:4 loop
    connect(m_flow_infAir[i].y, multiProduct[i].u[1]) annotation (Line(points={{-65,
            -104},{-44,-104},{-44,-115.4},{-38,-115.4}},
                                            color={0,0,127}));
    connect(schFac_infAir[i].y, multiProduct[i].u[2]) annotation (Line(points={{-65,
            -124},{-44,-124},{-44,-114},{-38,-114}},
                                            color={0,0,127}));
    connect(winSpe_infAir[i].y, multiProduct[i].u[3]) annotation (Line(points={{-65.3,
            -141},{-44,-141},{-44,-112.6},{-38,-112.6}},
                                            color={0,0,127}));
  end for;
  connect(multiProduct.y, infAir.m_flow_in) annotation (Line(points={{-24.98,
          -114},{6,-114},{6,-122},{38,-122}},
                                            color={0,0,127}));
  connect(gain.y, exfAir.m_flow_in) annotation (Line(points={{80.6,-110},{106,
          -110},{106,-122},{132,-122}}, color={0,0,127}));
  connect(gain.u, multiProduct.y) annotation (Line(points={{66.8,-110},{20,-110},
          {20,-114},{-24.98,-114}},  color={0,0,127}));

  for i in 1:4 loop
  end for;

  connect(replicator.y, exfAir.C_in)
    annotation (Line(points={{120.6,-138},{132,-138}}, color={0,0,127}));

  for i in 1:4 loop
  connect(replicator[i].u, senCO2[i+1].C) annotation (Line(points={{106.8,-138},
            {104,-138},{104,-94},{100.8,-94}},               color={0,0,127}));
  end for;
  connect(vAV5.port_a, senRelPre.port_a) annotation (Line(points={{158,6.88889},
          {158,-16},{114,-16},{114,-32},{128,-32}},
                                               color={0,127,255}));
  connect(out.weaBus, weaBus) annotation (Line(
      points={{26,-47.8},{-2,-47.8},{-2,-100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(out.ports[1], senRelPre.port_b) annotation (Line(points={{46,-48},{72,
          -48},{72,-40},{160,-40},{160,-32},{148,-32}}, color={0,127,255}));
  connect(senRelPre.p_rel, ducStaPre) annotation (Line(points={{138,-41},{138,
          -48},{166,-48},{166,-12},{210,-12}}, color={0,0,127}));
  connect(qIntMod.y, zon.qGai_flow) annotation (Line(points={{-47,-70},{54,-70},
          {54,-55},{69,-55}}, color={0,0,127}));
  connect(TZonAir1.y, exfAir.T_in) annotation (Line(points={{89,-148},{100,-148},
          {100,-126},{132,-126}}, color={0,0,127}));
  connect(vAV1.port_b, m_flow_mulSup[1].port_a) annotation (Line(points={{10,6.88889},
          {14,6.88889},{14,-40},{-32,-40},{-32,-45},{-30,-45}}, color={0,127,255}));
  connect(vAV2.port_b, m_flow_mulSup[2].port_a) annotation (Line(points={{50,6.88889},
          {50,8},{54,8},{54,-40},{-32,-40},{-32,-44},{-30,-44},{-30,-45}},
        color={0,127,255}));
  connect(vAV3.port_b, m_flow_mulSup[3].port_a) annotation (Line(points={{92,6.88889},
          {96,6.88889},{96,-38},{-34,-38},{-34,-45},{-30,-45}}, color={0,127,255}));
  connect(vAV4.port_b, m_flow_mulSup[4].port_a) annotation (Line(points={{138,6.88889},
          {140,6.88889},{140,6},{142,6},{142,-36},{-36,-36},{-36,-45},{-30,-45}},
        color={0,127,255}));
  connect(vAV5.port_b, m_flow_mulSup[5].port_a) annotation (Line(points={{178,6.88889},
          {184,6.88889},{184,6},{188,6},{188,-34},{-38,-34},{-38,-45},{-30,-45}},
        color={0,127,255}));
    annotation (
        Icon(
      coordinateSystem(
        preserveAspectRatio=false),
      graphics={
        Line(points = {{100.8, -90}, {121.2, -90}}, color = {0, 0, 127}),
        Line(points = {{-90, 40}, {80, 40}},   color = {0, 127, 255}),
        Line(points = {{-90, -60}, {80, -60}}, color = {0, 127, 255}),
        Line(points = {{80, 40}, {80, -60}},   color = {0, 127, 255}),
        Line(points = {{50, 40}, {50, -60}},   color = {0, 127, 255}),
        Line(points = {{20, 40}, {20, -60}},   color = {0, 127, 255}),
        Line(points = {{-10, 40}, {-10, -60}}, color = {0, 127, 255}),
        Line(points = {{-40, 40}, {-40, -60}}, color = {0, 127, 255}),
        Rectangle(
          extent =     {{-46, 0}, {-34, -20}},
          lineColor =  {28, 108, 200},
          fillColor =  {0, 128, 255},
          fillPattern= FillPattern.Solid),
        Rectangle(
          extent =     {{-16, 0}, {-4, -20}},
          lineColor =  {28, 108, 200},
          fillColor =  {0, 128, 255},
          fillPattern= FillPattern.Solid),
        Rectangle(
          extent =     {{14, 0}, {26, -20}},
          lineColor =  {28, 108, 200},
          fillColor =  {0, 128, 255},
          fillPattern= FillPattern.Solid),
        Rectangle(
          extent =     {{44, 0}, {56, -20}},
          lineColor =  {28, 108, 200},
          fillColor =  {0, 128, 255},
          fillPattern= FillPattern.Solid),
        Rectangle(
          extent =     {{74, 0}, {86, -20}},
          lineColor =  {28, 108, 200},
          fillColor =  {0, 128, 255},
          fillPattern= FillPattern.Solid),
        Line(points = {{-40, 90},  {-40, 60}},   color = {255, 0, 0}),
        Line(points = {{-60, 60},  {-40, 60}},   color = {255, 0, 0}),
        Line(points = {{-60, 60},  {-60, -12}},  color = {255, 0, 0}),
        Line(points = {{64, 20},   {-60, 20}},   color = {255, 0, 0}),
        Line(points = {{-24, 20},  {-24, -12}},  color = {255, 0, 0}),
        Line(points = {{6, 20},    {6, -12}},    color = {255, 0, 0}),
        Line(points = {{36, 20},   {36, -12}},   color = {255, 0, 0}),
        Line(points = {{64, 20},   {64, -12}},   color = {255, 0, 0}),
        Line(points = {{-60, -12}, {-46, -12}},  color = {255, 0, 0}),
        Line(points = {{-24, -12}, {-16, -12}},  color = {255, 0, 0}),
        Line(points = {{6, -12},   {14, -12}},   color = {255, 0, 0}),
        Line(points = {{36, -12},  {44, -12}},   color = {255, 0, 0}),
        Line(points = {{64, -12},  {74, -12}},   color = {255, 0, 0}),
        Line(points = {{90, -32},  {-36, -32}},  color = {255, 0, 0}),
        Line(points = {{-36, -20}, {-36, -32}},  color = {255, 0, 0}),
        Line(points = {{-6, -20},  {-6, -32}},   color = {255, 0, 0}),
        Line(points = {{24, -20},  {24, -32}},   color = {255, 0, 0}),
        Line(points = {{54, -20},  {54, -32}},   color = {255, 0, 0}),
        Line(points = {{84, -20},  {84, -32}},   color = {255, 0, 0}),
        Line(points = {{90, 60},   {90, -32}},   color = {255, 0, 0}),
        Line(points = {{40, 60},   {90, 60}},    color = {255, 0, 0}),
        Line(points = {{40, 90},   {40, 60}},    color = {255, 0, 0}),
        Text(
          extent={{-150,-142},{150,-102}},
          textColor =  {0, 0, 255},
          textString = "%name")}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio = false,
        extent              = {{-100, -160}, {200, 100}})),
    Documentation(info="<html>
<p>This model comprises five thermal zones served by an air-distribution duct network, a hot-water reheat hydronic loop, and variable-air-volume (VAV) terminal units. In each zone, infiltration is prescribed as a mass-flow rate in accordance with ASHRAE 90.1 Appendix G.</p>
<p><br>For details on the VAV terminal implementation, see the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal\">MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal</a> for a description of the VAV terminal unit model. </p>
</html>", revisions="<html>
<ul>
<li>August 17, 2023, by Xing Lu, Sen Huang: </li>
<p>First implementation.</p>
</ul>
</html>"));
end FiveZoneVAV;
