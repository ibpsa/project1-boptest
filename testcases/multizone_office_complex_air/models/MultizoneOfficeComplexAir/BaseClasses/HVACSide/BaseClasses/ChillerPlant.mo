within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses;
model ChillerPlant
  "Chiller plant, chilled water pump system, and cooling towers"

  replaceable package MediumCHW = Modelica.Media.Interfaces.PartialMedium
    "Medium model";
  replaceable package MediumCW = Modelica.Media.Interfaces.PartialMedium
    "Medium model";
  parameter Integer n=3
    "Number of chillers";
  parameter Integer m=2
    "Number of secondary pumps";
  parameter Real thrhol[:] = {0.95,0.95}
    "Threshold for chiller staging";
  parameter Real Cap[:] "Rated Plant Capacity";
  parameter Real tWai = 900 "Waiting time";
  parameter Modelica.Units.SI.TemperatureDifference dT=0.5
    "Temperature difference for stage control";
  parameter Modelica.Units.SI.Power PTow_nominal[:]={-datChi[1].QEva_flow_nominal*(COP_nominal + 1)/COP_nominal*0.015 for i in linspace(
      1,
      n,
      n)} "Nominal cooling tower power based on CT capacity Q_cond (assume specific fan power is 0.015kW per 1kW of CT heat rejected)";
  parameter Modelica.Units.SI.TemperatureDifference dTCHW_nominal=5.56
    "Temperature difference at chilled water side";
  parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal=5.18
    "Temperature difference at condenser water wide";
  parameter Modelica.Units.SI.Pressure dPCHW_nominal=210729
    "Pressure difference at the chilled water side";
  parameter Modelica.Units.SI.Pressure dPCW_nominal=92661
    "Pressure difference at the condenser water wide";
  parameter Modelica.Units.SI.Pressure dPTow_nominal=191300
    "Pressure difference at the condenser water wide";
  parameter Modelica.Units.SI.Temperature TCHW_nominal=273.15 + 5.56
    "Temperature at chilled water side";
  parameter Modelica.Units.SI.Temperature TCW_nominal=273.15 + 23.89
    "Temperature at condenser water wide";
  parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal=4.44
    "Nominal approach temperature";
  parameter Modelica.Units.SI.TemperatureDifference dTApp=4.44
    "Approach temperature for controlling cooling towers";
  parameter Real COP_nominal = datChi[1].COP_nominal "Chiller COP";
  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[:]={-datChi[1].QEva_flow_nominal
      /4200/dTCHW_nominal for i in linspace(
      1,
      n,
      n)} "Nominal mass flow rate at chilled water side";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]={
      -datChi[1].QEva_flow_nominal*(COP_nominal + 1)/COP_nominal/4200/dTCW_nominal
      for i in linspace(
      1,
      n,
      n)} "Nominal mass flow rate at condenser water wide";
  parameter Real Motor_eta[:] = {0.87}
    "Motor efficiency";
  parameter Real Hydra_eta[:] = {1}
    "Hydraulic efficiency";
  parameter Modelica.Units.SI.Pressure dP_nominal=478250
    "Nominal pressure drop for the secondary chilled water pump ";
  parameter Real v_flow_rate[m,:] = {{0, 0.4*sum(mCHW_flow_nominal)/m/996,0.6*sum(
      mCHW_flow_nominal)/m/996,0.8*sum(mCHW_flow_nominal)/m/996,
      sum(mCHW_flow_nominal)/m/996,1.2*sum(mCHW_flow_nominal)/m/996} for i in
      linspace(
      1,
      m,
      m)};
  parameter Real pressure[m,:] = {{1.8*dP_nominal,1.6*dP_nominal,1.2*dP_nominal,1.1*dP_nominal,dP_nominal,0.75*dP_nominal} for i in linspace(1, m, m)};
  parameter Real Motor_eta_Sec[m,:] =  {{0.6,0.6,0.76,0.87,0.86,0.74} for i in linspace(1, m, m)}
    "Motor efficiency";
  parameter Real Hydra_eta_Sec[m,:] = {{1,1,1,1,1,1} for i in linspace(1, m, m)}
    "Hydraulic efficiency";
  parameter Modelica.Units.SI.Pressure dPByp_nominal=100
    "Pressure difference between the outlet and inlet of the modules ";
  parameter Real vTow_flow_rate[n,:]={{0.3,0.6,1} for i in linspace(1, n, n)}
    "Volume flow rate rate";
  parameter Real eta[n,:]={{0.3^3,0.6^3,1} for i in linspace(1, n, n)}
    "Fan efficiency";
  parameter Modelica.Units.SI.Temperature TWetBul_nominal=273.15 + 19.45
    "Nominal wet bulb temperature";
  replaceable Component.WaterSide.Chiller.MultiChillers mulChiSys(
    redeclare package MediumCHW = MediumCHW,
    redeclare package MediumCW = MediumCW,
    dPCHW_nominal=dPCHW_nominal,
    dPCW_nominal=dPCW_nominal,
    mCHW_flow_nominal=mCHW_flow_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    TCW_start=273.15 + 23.89,
    TCHW_start=273.15 + 5.56,
    per=datChi,
    n=n) annotation (Placement(transformation(extent={{-88,-16},{-74,-2}})));
  Component.FlowMover.Pump.PumpSystem pumSecCHW(
    redeclare package Medium = MediumCHW,
    n=m,
    VolFloCur=v_flow_rate,
    PreCur=pressure,
    HydEff=Hydra_eta_Sec,
    MotEff=Motor_eta_Sec,
    m_flow_nominal={sum(mCHW_flow_nominal)/m for i in linspace(
        1,
        m,
        m)},
    dpValve_nominal(displayUnit="Pa") = {dP_nominal*0.5 for i in linspace(
      1,
      m,
      m)}) annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Component.FlowMover.Pump.SimPumpSystem pumPriCHW(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=mCHW_flow_nominal,
    n=n,
    Motor_eta={Motor_eta for i in linspace(
        1,
        n,
        n)},
    Hydra_eta={Hydra_eta for i in linspace(
        1,
        n,
        n)},
    dp_nominal(displayUnit="Pa") = dPCHW_nominal)
    annotation (Placement(transformation(extent={{-12,0},{-48,36}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWByp(
    redeclare package Medium = MediumCHW,
    allowFlowReversal=true,
    m_flow_nominal=sum(mCHW_flow_nominal))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-10})));
  Buildings.Fluid.Storage.ExpansionVessel expVesCHW(
      redeclare package Medium = MediumCHW, V_start=1)
    annotation (Placement(transformation(extent={{-44,-78},{-36,-70}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloByp(redeclare package Medium =
                       MediumCHW) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-52})));
  Modelica.Blocks.Math.RealToBoolean reaToBoo
    annotation (Placement(transformation(extent={{-160,86},{-140,106}})));
  Modelica.Blocks.Sources.Constant On(k=1)
    annotation (Placement(transformation(extent={{-240,86},{-220,106}})));
  Component.WaterSide.CoolingTower.CoolingTowersWithBypass cooTowWithByp(
    redeclare package MediumCW = MediumCW,
    P_nominal=PTow_nominal,
    dP_nominal=dP_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    eta=eta,
    dPByp_nominal=dPByp_nominal,
    byp(dPByp_nominal=dPByp_nominal),
    TCW_start=273.15 + 29.44,
    v_flow_rate=vTow_flow_rate,
    dTApp_nominal=dTApp_nominal,
    TWetBul_nominal=TWetBul_nominal,
    n=n,
    TCWLowSet=288.71,
    dTCW_nominal=dTCW_nominal)
    annotation (Placement(transformation(extent={{-190,-44},{-162,-16}})));
  Component.FlowMover.Pump.SimPumpSystem pumCW(
    redeclare package Medium = MediumCW,
    m_flow_nominal=mCW_flow_nominal,
    n=n,
    Motor_eta={Motor_eta for i in linspace(
        1,
        n,
        n)},
    Hydra_eta={Hydra_eta for i in linspace(
        1,
        n,
        n)},
    dp_nominal=dPCW_nominal + dP_nominal + dPByp_nominal)
    annotation (Placement(transformation(extent={{-144,-102},{-116,-76}})));
  Buildings.Fluid.Storage.ExpansionVessel expVesCW(
      redeclare package Medium = MediumCW, V_start=1)
    annotation (Placement(transformation(extent={{-184,-78},{-176,-70}})));
  replaceable Component.WaterSide.Control.PlantStageN chiSta(
    tWai=tWai,
    n=n,
    thehol=thrhol,
    Cap=Cap) annotation (Placement(transformation(extent={{-78,58},{-62,72}})));
  Component.FlowMover.Pump.Control.SecPumCon secPumCon(tWai=1800, n=m)
    annotation (Placement(transformation(extent={{60,38},{80,58}})));
  replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWBuiEnt(
    redeclare package Medium = MediumCHW,
    allowFlowReversal=true,
    m_flow_nominal=sum(mCHW_flow_nominal))
                            annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={96,-90})));
  parameter
     Buildings.Fluid.Chillers.Data.ElectricEIR.Generic
    datChi[integer(n)]
    annotation (Placement(transformation(extent={{80,88},{100,108}})));
  Modelica.Blocks.Sources.RealExpression PCh(y=sum(mulChiSys.P))
    annotation (Placement(transformation(extent={{140,90},{160,110}})));
  Modelica.Blocks.Continuous.Integrator ECh
    annotation (Placement(transformation(extent={{200,90},{220,110}})));
  Modelica.Blocks.Sources.RealExpression PConSpePum(y=sum(pumPriCHW.P) + sum(
        pumCW.P))
    annotation (Placement(transformation(extent={{140,48},{160,68}})));
  Modelica.Blocks.Continuous.Integrator EConSpePum
    annotation (Placement(transformation(extent={{200,48},{220,68}})));
  Modelica.Blocks.Sources.RealExpression PVarSpePum(y=sum(pumSecCHW.P))
    annotation (Placement(transformation(extent={{140,10},{160,30}})));
  Modelica.Blocks.Continuous.Integrator EVarSpePum
    annotation (Placement(transformation(extent={{200,10},{220,30}})));
  Modelica.Blocks.Sources.RealExpression PCooTow(y=sum(cooTowWithByp.mulCooTowSys.P))
    annotation (Placement(transformation(extent={{140,-34},{160,-14}})));
  Modelica.Blocks.Continuous.Integrator ECooTow
    annotation (Placement(transformation(extent={{200,-34},{220,-14}})));
  Modelica.Blocks.Sources.RealExpression PTot(y=PCh.y + PConSpePum.y +
        PVarSpePum.y + PCooTow.y)
    annotation (Placement(transformation(extent={{160,-90},{180,-70}})));
  Modelica.Blocks.Continuous.Integrator ETot
    annotation (Placement(transformation(extent={{200,-90},{220,-70}})));
  Modelica.Blocks.Sources.RealExpression runCh
    annotation (Placement(transformation(extent={{160,-130},{180,-110}})));

  Modelica.Blocks.Continuous.Integrator maiCos
    annotation (Placement(transformation(extent={{200,-130},{220,-110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumCHW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{230,-50},{250,-30}}),
        iconTransformation(extent={{90,-50},{110,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumCHW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{230,50},{250,70}}),
        iconTransformation(extent={{90,50},{110,70}})));

  Modelica.Blocks.Interfaces.RealInput TCWSet
    "Temperature set point of the condenser water"
    annotation (Placement(transformation(extent={{-312,-76},{-280,-44}}),
        iconTransformation(extent={{-132,-56},{-100,-24}})));
  Modelica.Blocks.Interfaces.RealInput TWetBul
    "Entering air wet bulb temperature"
    annotation (Placement(transformation(extent={{-312,-116},{-280,-84}}),
        iconTransformation(extent={{-132,-96},{-100,-64}})));
  Modelica.Blocks.Interfaces.RealInput dpMea "Measured pressure drop"
    annotation (Placement(transformation(extent={{-312,64},{-280,96}}),
        iconTransformation(extent={{-132,64},{-100,96}})));
  Modelica.Blocks.Interfaces.RealInput TCHWSet
    "Temperature setpoint of the chilled water"
    annotation (Placement(transformation(extent={{-312,-22},{-280,10}}),
        iconTransformation(extent={{-132,-16},{-100,16}})));

  Modelica.Blocks.Interfaces.RealOutput TCHW_sup
    "Temperature of the passing fluid" annotation (Placement(transformation(
          extent={{240,-30},{260,-10}}), iconTransformation(extent={{100,-20},{
            120,0}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWBuiLea(
    redeclare package Medium = MediumCHW,
    allowFlowReversal=true,
    m_flow_nominal=sum(mCHW_flow_nominal)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,18})));
  replaceable Buildings.Fluid.Sensors.MassFlowRate senMasFloSecCHW(redeclare
      package Medium =
        MediumCHW) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={130,-90})));
  Modelica.Blocks.Sources.RealExpression Loa(y=senMasFloSecCHW.m_flow*4200*(
        senTCHWBuiLea.T - senTCHWBuiEnt.T))
    annotation (Placement(transformation(extent={{-174,16},{-154,36}})));
  Modelica.Blocks.Interfaces.RealInput dpSet
    "Static differential pressure setpoint for the secondary pump"
    annotation (Placement(transformation(extent={{-312,30},{-280,62}}),
        iconTransformation(extent={{-132,26},{-100,58}})));
  Modelica.Blocks.Interfaces.RealOutput TCHW_ret
    "Temperature of the passing fluid" annotation (Placement(transformation(
          extent={{240,-10},{260,10}}), iconTransformation(extent={{100,10},{
            120,30}})));
  Modelica.Blocks.Interfaces.RealOutput mCHW_tot annotation (Placement(
        transformation(extent={{240,-70},{260,-50}}), iconTransformation(extent
          ={{100,-80},{120,-60}})));
equation
  connect(senTCHWByp.port_a, senMasFloByp.port_b) annotation (Line(
      points={{-4.44089e-016,-20},{-4.44089e-016,-32},{0,-32},{0,-42}},
      color={0,127,255},
      thickness=1));
  connect(senTCHWByp.port_b, pumPriCHW.port_a) annotation (Line(
      points={{6.66134e-016,0},{6.66134e-016,18},{-12,18}},
      color={0,127,255},
      thickness=1));
  connect(mulChiSys.port_a_CHW, pumPriCHW.port_b) annotation (Line(
      points={{-74,-3.4},{-54,-3.4},{-54,18},{-48,18}},
      color={0,127,255},
      thickness=1));
  connect(mulChiSys.port_b_CHW, senMasFloByp.port_a) annotation (Line(
      points={{-74,-14.6},{-74,-90},{0,-90},{0,-62}},
      color={0,127,255},
      thickness=1));
  connect(expVesCHW.port_a, senMasFloByp.port_a) annotation (Line(
      points={{-40,-78},{-40,-90},{-1.77636e-015,-90},{-1.77636e-015,-62}},
      color={0,127,255},
      thickness=1));
  connect(On.y, reaToBoo.u)
    annotation (Line(points={{-219,96},{-162,96}}, color={0,0,127}));
  connect(cooTowWithByp.port_a, mulChiSys.port_b_CW) annotation (Line(
      points={{-162,-21.6},{-162,18},{-100,18},{-100,-3.4},{-88,-3.4}},
      color={0,127,255},
      thickness=1));
  connect(cooTowWithByp.port_b, pumCW.port_a) annotation (Line(
      points={{-162,-41.2},{-162,-89},{-144,-89}},
      color={0,127,255},
      thickness=1));
  connect(pumCW.port_b, mulChiSys.port_a_CW) annotation (Line(
      points={{-116,-89},{-100,-89},{-100,-14.6},{-88,-14.6}},
      color={0,127,255},
      thickness=1));
  connect(expVesCW.port_a, pumCW.port_a) annotation (Line(
      points={{-180,-78},{-180,-89},{-144,-89}},
      color={0,127,255},
      thickness=1));

  connect(pumSecCHW.port_a, senMasFloByp.port_a) annotation (Line(
      points={{40,-70},{0,-70},{0,-62},{-1.83187e-15,-62}},
      color={0,127,255},
      thickness=1));
  connect(chiSta.y, mulChiSys.On) annotation (Line(points={{-61.2,65},{-40,65},{
          -40,40},{-120,40},{-120,-11.8},{-88.63,-11.8}}, color={0,0,127}));

  connect(pumCW.On, mulChiSys.On) annotation (Line(
      points={{-145.26,-81.2},{-152,-81.2},{-152,-40},{-112,-40},{-112,-11.8},{-88.63,
          -11.8}},
      color={0,0,127}));
  connect(cooTowWithByp.On, mulChiSys.On) annotation (Line(
      points={{-191.26,-21.6},{-200,-21.6},{-200,-8},{-120,-8},{-120,-11.8},
          {-88.63,-11.8}},
      color={0,0,127}));
  connect(chiSta.On, reaToBoo.y) annotation (Line(points={{-79.6,70.6},{-120,70.6},
          {-120,96},{-139,96}}, color={255,0,255}));
  connect(chiSta.sta, mulChiSys.Rat) annotation (Line(points={{-79.6,59.4},
          {-90,59.4},{-90,36},{-44,36},{-44,-11.8},{-73.3,-11.8}}, color={0,
          0,127}));
  connect(pumPriCHW.On, mulChiSys.On) annotation (Line(
      points={{-10.38,28.8},{10,28.8},{10,52},{-120,52},{-120,-11.8},{-88.63,-11.8}},
      color={0,0,127}));
  connect(secPumCon.On, reaToBoo.y) annotation (Line(points={{58,56},{40,56},
          {40,96},{-139,96}},
                          color={255,0,255}));
  connect(pumSecCHW.speRat, secPumCon.sta) annotation (Line(points={{61,
          -63.8},{88,-63.8},{88,-14},{30,-14},{30,40},{58,40}}, color={0,0,
          127}));
  connect(pumSecCHW.port_b, senTCHWBuiEnt.port_a) annotation (Line(
      points={{60,-70},{84,-70},{84,-90},{88,-90}},
      color={0,127,255},
      thickness=1));

  connect(PCh.y, ECh.u) annotation (Line(
      points={{161,100},{198,100}},
      color={0,0,127}));
  connect(PConSpePum.y, EConSpePum.u) annotation (Line(
      points={{161,58},{198,58}},
      color={0,0,127}));
  connect(PVarSpePum.y, EVarSpePum.u) annotation (Line(
      points={{161,20},{198,20}},
      color={0,0,127}));
  connect(PCooTow.y, ECooTow.u) annotation (Line(
      points={{161,-24},{198,-24}},
      color={0,0,127}));
  connect(PTot.y, ETot.u) annotation (Line(
      points={{181,-80},{189.5,-80},{198,-80}},
      color={0,0,127}));
  connect(runCh.y, maiCos.u)
    annotation (Line(points={{181,-120},{198,-120}}, color={0,0,127}));
  connect(cooTowWithByp.TCWSet, TCWSet) annotation (Line(
      points={{-191.26,-30},{-244,-30},{-244,-60},{-296,-60}},
      color={0,0,127}));
  connect(cooTowWithByp.TWetBul, TWetBul) annotation (Line(
      points={{-191.26,-38.4},{-220,-38.4},{-220,-100},{-296,-100}},
      color={0,0,127}));
  connect(secPumCon.dpMea, dpMea) annotation (Line(points={{58,48},{20,48},
          {20,80},{-296,80}}, color={0,0,127}));

  connect(mulChiSys.TCHWSet, TCHWSet) annotation (Line(
      points={{-88.63,-6.2},{-260,-6.2},{-260,-6},{-296,-6}},
      color={0,0,127}));
  connect(pumSecCHW.speSig, secPumCon.y) annotation (Line(
      points={{39.1,-62},{18,-62},{18,0},{88,0},{88,48},{81,48}},
      color={0,0,127}));
  connect(senTCHWBuiEnt.T, TCHW_sup) annotation (Line(points={{96,-81.2},{96,-8},
          {234,-8},{234,-20},{250,-20}}, color={0,0,127}));
  connect(pumPriCHW.port_a, senTCHWBuiLea.port_b) annotation (Line(
      points={{-12,18},{60,18}},
      color={0,127,255},
      thickness=1));
  connect(senTCHWBuiLea.port_a, port_a) annotation (Line(
      points={{80,18},{100,18},{100,60},{240,60}},
      color={0,127,255},
      thickness=1));
  connect(senTCHWBuiEnt.port_b, senMasFloSecCHW.port_a) annotation (Line(points={{104,-90},
          {122,-90}},                     color={0,127,255}));
  connect(senMasFloSecCHW.port_b, port_b) annotation (Line(
      points={{138,-90},{148,-90},{148,-42},{240,-42},{240,-40}},
      color={0,127,255},
      thickness=1));
  connect(Loa.y,chiSta.loa)  annotation (Line(points={{-153,26},{-124,26},{-124,
          65},{-79.6,65}}, color={0,0,127}));
  connect(secPumCon.dpSet, dpSet) annotation (Line(points={{58,44},{-120,44},
          {-120,46},{-296,46}}, color={0,0,127}));
  connect(senTCHWBuiLea.T, TCHW_ret) annotation (Line(points={{70,29},{134,29},
          {134,0},{250,0}}, color={0,0,127}));
  connect(senMasFloSecCHW.m_flow, mCHW_tot) annotation (Line(points={{130,-81.2},
          {130,-60},{250,-60}}, color={0,0,127}));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/LejeunePlant/ChillerPlantSystem.mos"
        "Simulate and plot"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-280,-140},{240,
            120}})),
    experiment(
      StartTime=1.728e+007,
      StopTime=1.73664e+007,
      __Dymola_NumberOfIntervals=1440,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>The chilled water systems composed of three chillers, three cooling towers, a primary chilled water loop with three constant speed pumps, 
a secondary chilled water loop with two variable speed pumps, and a condenser water loop with three constant speed pumps.</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/ChillerControl.PNG\"/> </p>
<p><br>The number of operating chillers is determined via a state machine based on the thermal load (Q, kW), 
rated chiller cooling capacity of chiller k (cck, kW), threshold to start chiller k+1 (&xi;k = 0.9), and waiting time (30 min). The maximum operating chiller number is N, which is equal to 3. </p>
<p>The chiller model takes as an input the set point for the leaving chilled water temperature, which is met if the chiller has sufficient capacity. Thus, the model has a built-in, ideal temperature control. </p>
<p>The number of secondary chilled water pump is determined via a state machine based on the pump speed (S, rpm) and waiting time (30 min). The maximum operating pump number is M, which is equal to 2. </p>
<p>Secondary chilled water pump speed is controlled by a PI controller to maintain the static pressure of the secondary chilled water loop at setpoint.</p>
<p>Cooling tower fan speed is controlled by a PI controller to maintain the cooling tower supply water temperature at setpoint. </p>
<p>Three-way valve position is controlled by a PI controller to maintain the temperature of the condenser water leaving the condenser water loop to be larger than 15.56 &deg;C. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Chiller.MultiChillers\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Chiller.MultiChillers</a> for a description of the multiple chillers.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.CoolingTower.CoolingTowersWithBypass\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.CoolingTower.CoolingTowersWithBypass</a> for a description of the multiple cooling towers with the bypass.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump.SimPumpSystem\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump.SimPumpSystem</a> for a description of the primary chilled water pump and condensed water pump model.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump.PumpSystem\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump.PumpSystem</a> for a description of the secondary chilled water pump model.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Control.PlantStageN\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Control.PlantStageN</a> for a description of the chiller stage control.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump.Control.SecPumCon\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump.Control.SecPumCon</a> for a description of the chilled water secondary pump control. </p>
</html>", revisions = "<html>
<ul>
<li> August 8, 2024, by Guowen Li, Xing Lu, Yan Chen: </li>
<p> Adjusted system equipment sizing; Reduced nonlinear system warnings.</p>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang:
<p> First implementation.</p>
</ul>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,58},{28,38}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,-26},{28,-46}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-76,24},{-86,-2},{-66,-2},{-76,24}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,20},{74,-4}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-76,24},{-76,46},{-36,46}}, color={0,0,127}),
        Line(points={{-76,-2},{-76,-36},{-36,-36}}, color={0,0,127}),
        Line(points={{62,20},{62,46},{28,46}}, color={0,0,127}),
        Line(points={{62,-4},{62,-36},{28,-36}}, color={0,0,127}),
        Text(
          extent={{-158,118},{142,158}},
          textString="%name",
          textColor={0,0,255})}));
end ChillerPlant;
