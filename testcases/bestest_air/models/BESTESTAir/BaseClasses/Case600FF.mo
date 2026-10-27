within BESTESTAir.BaseClasses;
model Case600FF
  "Basic test with light-weight construction and free floating temperature"

  replaceable package MediumA = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Medium model";
  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal "Nominal air mass flow rate";
  parameter Modelica.Units.SI.Angle S_=
    Buildings.Types.Azimuth.S "Azimuth for south walls";
  parameter Modelica.Units.SI.Angle E_=
    Buildings.Types.Azimuth.E "Azimuth for east walls";
  parameter Modelica.Units.SI.Angle W_=
    Buildings.Types.Azimuth.W "Azimuth for west walls";
  parameter Modelica.Units.SI.Angle N_=
    Buildings.Types.Azimuth.N "Azimuth for north walls";
  parameter Modelica.Units.SI.Angle C_=
    Buildings.Types.Tilt.Ceiling "Tilt for ceiling";
  parameter Modelica.Units.SI.Angle F_=
    Buildings.Types.Tilt.Floor "Tilt for floor";
  parameter Modelica.Units.SI.Angle Z_=
    Buildings.Types.Tilt.Wall "Tilt for wall";
  parameter Integer nConExtWin = 1 "Number of constructions with a window";
  parameter Integer nConBou = 1
    "Number of surface that are connected to constructions that are modeled inside the room";
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matExtWal(
    nLay=3,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.009,
        k=0.140,
        c=900,
        d=530,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.066,
        k=0.040,
        c=840,
        d=12,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.012,
        k=0.160,
        c=840,
        d=950,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)})
                           "Exterior wall"
    annotation (Placement(transformation(extent={{20,84},{34,98}})));
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
    annotation (Placement(transformation(extent={{80,84},{94,98}})));
   parameter Buildings.HeatTransfer.Data.Solids.Generic soil(
    x=2,
    k=1.3,
    c=800,
    d=1500) "Soil properties"
    annotation (Placement(transformation(extent={{40,40},{60,60}})));

  Buildings.ThermalZones.Detailed.MixedAir roo(
    redeclare package Medium = MediumA,
    hRoo=2.7,
    nConExtWin=nConExtWin,
    nConBou=1,
    use_C_flow=true,
    C_start={400e-6},
    nPorts=5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    AFlo=48,
    datConBou(
      layers={matFlo},
      each A=48,
      each til=F_),
    datConExt(
      layers={roof,matExtWal,matExtWal,matExtWal},
      A={48,6*2.7,6*2.7,8*2.7},
      til={C_,Z_,Z_,Z_},
      azi={S_,W_,E_,N_}),
    nConExt=4,
    nConPar=0,
    nSurBou=0,
    datConExtWin(
      layers={matExtWal},
      A={8*2.7},
      glaSys={window600},
      wWin={2*3},
      hWin={2},
      fFra={0.001},
      til={Z_},
      azi={S_}))
    "Room model for Case 600"
    annotation (Placement(transformation(extent={{36,-30},{66,0}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-18,64},{-10,72}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/DRYCOLD.mos"),
      computeWetBulbTemperature=true)
    annotation (Placement(transformation(extent={{98,-94},{86,-82}})));
  Modelica.Blocks.Sources.Constant uSha(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-28,76},{-20,84}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=max(1,nConExtWin))
    annotation (Placement(transformation(extent={{-12,76},{-4,84}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TSoi[nConBou](each T=
        283.15) "Boundary condition for construction"
                                          annotation (Placement(transformation(
        extent={{0,0},{-8,8}},
        origin={72,-52})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic roof(nLay=3,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.019,
        k=0.140,
        c=900,
        d=530,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.1118,
        k=0.040,
        c=840,
        d=12,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef),
                         Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.010,
        k=0.160,
        c=840,
        d=950,
        nStaRef=Buildings.ThermalZones.Detailed.Validation.BESTEST.nStaRef)})
                           "Roof"
    annotation (Placement(transformation(extent={{60,84},{74,98}})));
  parameter Buildings.ThermalZones.Detailed.Validation.BESTEST.Data.Win600
         window600(
    UFra=3,
    haveExteriorShade=false,
    haveInteriorShade=false) "Window"
    annotation (Placement(transformation(extent={{40,84},{54,98}})));
  Buildings.HeatTransfer.Conduction.SingleLayer soi(
    A=48,
    material=soil,
    steadyStateInitial=true,
    stateAtSurface_a=false,
    stateAtSurface_b=true,
    T_a_start=283.15,
    T_b_start=283.75) "2m deep soil (per definition on p.4 of ASHRAE 140-2007)"
    annotation (Placement(transformation(
        extent={{5,-5},{-3,3}},
        rotation=-90,
        origin={57,-35})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData
                                           sinInf(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_C_in=true,
    nPorts=1) "Sink model for air infiltration"
    annotation (Placement(transformation(extent={{-10,-66},{2,-54}})));
  Modelica.Blocks.Sources.Constant InfiltrationRate(k=-48*2.7*0.5/3600)
    "0.41 ACH adjusted for the altitude (0.5 at sea level)"
    annotation (Placement(transformation(extent={{-96,-78},{-88,-70}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-50,-60},{-40,-50}})));
  Buildings.Fluid.Sensors.Density density(redeclare package Medium = MediumA)
    "Air density inside the building"
    annotation (Placement(transformation(extent={{-40,-76},{-50,-66}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAirSen
    "Room air temperature"
    annotation (Placement(transformation(extent={{80,16},{90,26}})));
  replaceable parameter
    Buildings.ThermalZones.Detailed.Validation.BESTEST.Data.StandardResultsFreeFloating
      staRes(
        minT( Min=-18.8+273.15, Max=-15.6+273.15, Mean=-17.6+273.15),
        maxT( Min=64.9+273.15,  Max=69.5+273.15,  Mean=66.2+273.15),
        meanT(Min=24.2+273.15,  Max=25.9+273.15,  Mean=25.1+273.15))
          constrainedby Modelica.Icons.Record
    "Reference results from ASHRAE/ANSI Standard 140"
    annotation (Placement(transformation(extent={{80,40},{94,54}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=1)
    annotation (Placement(transformation(extent={{-78,-80},{-66,-68}})));

  Modelica.Blocks.Interfaces.RealOutput TRooAir "Room air temperature"
    annotation (Placement(transformation(extent={{160,-10},{180,10}}),
        iconTransformation(extent={{160,-10},{180,10}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData
                                           souInf(
    redeclare package Medium = MediumA,
    m_flow=1,
    use_m_flow_in=true,
    use_C_in=true,
    nPorts=1) "source model for air infiltration"
    annotation (Placement(transformation(extent={{4,-46},{16,-34}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-18,-40},{-8,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium = MediumA) "Supply air"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}}),
        iconTransformation(extent={{-110,10},{-90,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA) "Return air"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}}),
        iconTransformation(extent={{-110,-30},{-90,-10}})));
  InternalLoad lig(
    radFraction=0.5,
    latPower_nominal=0,
    senPower_nominal=11.8)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  InternalLoad equ(
    latPower_nominal=0,
    senPower_nominal=5.4,
    radFraction=0.7)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  OccupancyLoad occ(
    radFraction=0.6,
    co2Gen=8.64e-6,
    occ_density=2/48,
    senPower=73,
    latPower=45)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Math.MultiSum sumRad(nu=3) "Sum of radiant internal gains"
    annotation (Placement(transformation(extent={{-52,82},{-40,94}})));
  Modelica.Blocks.Math.MultiSum sumCon(nu=3) "Sum of convective internal gains"
    annotation (Placement(transformation(extent={{-52,62},{-40,74}})));
  Modelica.Blocks.Math.MultiSum sumLat(nu=3) "Sum of latent internal gains"
    annotation (Placement(transformation(extent={{-52,42},{-40,54}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPLig(y(unit="W"), description=
        "Lighting power submeter") "Read lighting power consumption"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPPlu(y(unit="W"), description=
        "Plug load power submeter") "Read plug load power consumption"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Math.MultiSum sumLig(k=fill(roo.AFlo, 2), nu=2)
    "Lighting power consumption"
    annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
  Modelica.Blocks.Math.MultiSum sumPlu(k=fill(roo.AFlo, 2), nu=2)
    "Plug power consumption"
    annotation (Placement(transformation(extent={{-52,4},{-40,16}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTRooAir(
    description="Zone air temperature",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K")) "Read room air temperature"
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));

  Buildings.Utilities.IO.SignalExchange.Read reaCO2RooAir(
    description="Zone air CO2 concentration",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm"))
                 "Read room air CO2 concentration"
    annotation (Placement(transformation(extent={{130,-40},{150,-20}})));

  Modelica.Blocks.Interfaces.RealOutput CO2RooAir(unit="ppm") "Room air CO2 concentration"
    annotation (Placement(transformation(extent={{160,-50},{180,-30}}),
        iconTransformation(extent={{160,-50},{180,-30}})));
  Modelica.Blocks.Sources.Constant conCO2Out(k=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
        /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Outside air CO2 concentration"
    annotation (Placement(transformation(extent={{-34,-72},{-26,-64}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2(
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal)
                    "CO2 sensor"
    annotation (Placement(transformation(extent={{28,-70},{8,-50}})));
  Modelica.Blocks.Math.Gain gaiCO2Gen(k=roo.AFlo)
    "Gain for CO2 generation by floor area"
    annotation (Placement(transformation(extent={{-50,-18},{-40,-8}})));
  Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(MMMea=
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta
    "BOPTEST weather station"
    annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
equation
  connect(multiplex3_1.y, roo.qGai_flow) annotation (Line(
      points={{-9.6,68},{20,68},{20,-9},{34.8,-9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(roo.uSha, replicator.y) annotation (Line(
      points={{34.8,-1.5},{24,-1.5},{24,80},{-3.6,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weaDat.weaBus, roo.weaBus)  annotation (Line(
      points={{86,-88},{80.07,-88},{80.07,-1.575},{64.425,-1.575}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(uSha.y, replicator.u) annotation (Line(
      points={{-19.6,80},{-12.8,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, sinInf.m_flow_in)       annotation (Line(
      points={{-39.5,-55},{-36,-55},{-36,-55.2},{-10,-55.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(density.port, roo.ports[1])  annotation (Line(
      points={{-45,-76},{32,-76},{32,-24.9},{39.75,-24.9}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(density.d, product.u2) annotation (Line(
      points={{-50.5,-71},{-56,-71},{-56,-58},{-51,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSoi[1].port, soi.port_a) annotation (Line(
      points={{64,-48},{56,-48},{56,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(soi.port_b, roo.surf_conBou[1]) annotation (Line(
      points={{56,-32},{56,-27},{55.5,-27}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(multiSum.y, product.u1) annotation (Line(
      points={{-64.98,-74},{-54,-74},{-54,-52},{-51,-52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(InfiltrationRate.y, multiSum.u[1]) annotation (Line(
      points={{-87.6,-74},{-78,-74}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(TRooAirSen.port, roo.heaPorAir) annotation (Line(points={{80,21},{60,
          21},{60,-15},{50.25,-15}}, color={191,0,0}));
  connect(gain.y, souInf.m_flow_in) annotation (Line(points={{-7.5,-35},{-4.75,-35},
          {-4.75,-35.2},{4,-35.2}},        color={0,0,127}));
  connect(gain.u, sinInf.m_flow_in) annotation (Line(points={{-19,-35},{-30,-35},
          {-30,-55.2},{-10,-55.2}}, color={0,0,127}));
  connect(souInf.ports[1], roo.ports[2]) annotation (Line(points={{16,-40},{20,-40},
          {20,-23.7},{39.75,-23.7}},      color={0,127,255}));
  connect(supplyAir, roo.ports[3]) annotation (Line(points={{-100,20},{-80,20},{
          -80,-22.5},{39.75,-22.5}},
                                   color={0,127,255}));
  connect(occ.rad, sumRad.u[1]) annotation (Line(points={{-79,94},{-60,94},{-60,
          90.8},{-52,90.8}}, color={0,0,127}));
  connect(equ.rad, sumRad.u[2]) annotation (Line(points={{-79,74},{-60,74},{-60,
          88},{-52,88}}, color={0,0,127}));
  connect(lig.rad, sumRad.u[3]) annotation (Line(points={{-79,54},{-58,54},{-58,
          85.2},{-52,85.2}}, color={0,0,127}));
  connect(occ.con, sumCon.u[1]) annotation (Line(points={{-79,90},{-64,90},{-64,
          70.8},{-52,70.8}}, color={0,0,127}));
  connect(equ.con, sumCon.u[2]) annotation (Line(points={{-79,70},{-68,70},{-68,
          68},{-52,68}}, color={0,0,127}));
  connect(lig.con, sumCon.u[3]) annotation (Line(points={{-79,50},{-60,50},{-60,
          65.2},{-52,65.2}}, color={0,0,127}));
  connect(occ.lat, sumLat.u[1]) annotation (Line(points={{-79,86},{-72,86},{-72,
          50.8},{-52,50.8}}, color={0,0,127}));
  connect(equ.lat, sumLat.u[2]) annotation (Line(points={{-79,66},{-74,66},{-74,
          48},{-52,48}}, color={0,0,127}));
  connect(lig.lat, sumLat.u[3]) annotation (Line(points={{-79,46},{-76,46},{-76,
          44},{-52,44},{-52,45.2}}, color={0,0,127}));
  connect(sumRad.y, multiplex3_1.u1[1]) annotation (Line(points={{-38.98,88},{
          -32,88},{-32,70.8},{-18.8,70.8}}, color={0,0,127}));
  connect(sumCon.y, multiplex3_1.u2[1])
    annotation (Line(points={{-38.98,68},{-18.8,68}}, color={0,0,127}));
  connect(sumLat.y, multiplex3_1.u3[1]) annotation (Line(points={{-38.98,48},{
          -32,48},{-32,65.2},{-18.8,65.2}}, color={0,0,127}));
  connect(sumLig.y, reaPLig.u)
    annotation (Line(points={{-38.98,30},{-22,30}}, color={0,0,127}));
  connect(sumPlu.y, reaPPlu.u)
    annotation (Line(points={{-38.98,10},{-22,10}}, color={0,0,127}));
  connect(equ.con, sumPlu.u[1]) annotation (Line(points={{-79,70},{-68,70},{-68,
          12.1},{-52,12.1}}, color={0,0,127}));
  connect(equ.rad, sumPlu.u[2]) annotation (Line(points={{-79,74},{-70,74},{-70,
          7.9},{-52,7.9}}, color={0,0,127}));
  connect(lig.rad, sumLig.u[1]) annotation (Line(points={{-79,54},{-58,54},{-58,
          32.1},{-52,32.1}}, color={0,0,127}));
  connect(lig.con, sumLig.u[2]) annotation (Line(points={{-79,50},{-60,50},{-60,
          27.9},{-52,27.9}}, color={0,0,127}));
  connect(TRooAirSen.T, reaTRooAir.u) annotation (Line(points={{90.5,21},{96,21},
          {96,0},{118,0}}, color={0,0,127}));
  connect(reaTRooAir.y, TRooAir)
    annotation (Line(points={{141,0},{170,0}}, color={0,0,127}));
  connect(reaCO2RooAir.y, CO2RooAir) annotation (Line(points={{151,-30},{156,
          -30},{156,-40},{170,-40}},
                                color={0,0,127}));
  connect(returnAir, roo.ports[4]) annotation (Line(points={{-100,-20},{-30,-20},
          {-30,-21.3},{39.75,-21.3}}, color={0,127,255}));
  connect(sinInf.ports[1], senCO2.port_b)
    annotation (Line(points={{2,-60},{8,-60}}, color={0,127,255}));
  connect(senCO2.port_a, roo.ports[5]) annotation (Line(points={{28,-60},{30,-60},
          {30,-20.1},{39.75,-20.1}}, color={0,127,255}));
  connect(occ.co2, gaiCO2Gen.u) annotation (Line(points={{-79,82},{-66,82},{-66,
          -13},{-51,-13}}, color={0,0,127}));
  connect(gaiCO2Gen.y, roo.C_flow[1]) annotation (Line(points={{-39.5,-13},{-1.75,
          -13},{-1.75,-12.9},{34.8,-12.9}}, color={0,0,127}));
  connect(weaDat.weaBus, sinInf.weaBus) annotation (Line(
      points={{86,-88},{-20,-88},{-20,-59.88},{-10,-59.88}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, souInf.weaBus) annotation (Line(
      points={{86,-88},{-20,-88},{-20,-39.88},{4,-39.88}},
      color={255,204,51},
      thickness=0.5));
  connect(conCO2Out.y, sinInf.C_in[1]) annotation (Line(points={{-25.6,-68},{-16,
          -68},{-16,-64.8},{-10,-64.8}}, color={0,0,127}));
  connect(conCO2Out.y, souInf.C_in[1]) annotation (Line(points={{-25.6,-68},{-16,
          -68},{-16,-44.8},{4,-44.8}}, color={0,0,127}));
  connect(gaiPPM.y, reaCO2RooAir.u)
    annotation (Line(points={{121,-30},{128,-30}}, color={0,0,127}));
  connect(senCO2.C, conMasVolFra.m)
    annotation (Line(points={{18,-49},{18,-30},{69,-30}}, color={0,0,127}));
  connect(conMasVolFra.V, gaiPPM.u)
    annotation (Line(points={{91,-30},{98,-30}}, color={0,0,127}));
  connect(weaSta.weaBus, roo.weaBus) annotation (Line(
      points={{59.9,-70.1},{80,-70},{80.07,-70},{80.07,-1.575},{64.425,-1.575}},
      color={255,204,51},
      thickness=0.5));

  annotation (
experiment(Tolerance=1e-06, StopTime=3.1536e+07),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/Detailed/Validation/BESTEST/Cases6xx/Case600FF.mos"
        "Simulate and plot"), Documentation(info="<html>
<p>
This model is used for the test case 600FF of the BESTEST validation suite.
Case 600FF is a light-weight building.
The room temperature is free floating.
</p>
</html>", revisions="<html>
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
end Case600FF;
