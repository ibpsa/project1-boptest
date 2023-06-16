within BuildingControlEmulator.Systems;
model ChillerPlant_simple "a typical chiller plant"

  replaceable package MediumCHW = Modelica.Media.Interfaces.PartialMedium
    "Medium model";
  replaceable package MediumCW = Modelica.Media.Interfaces.PartialMedium
    "Medium model";
  parameter Integer n=3
    "Number of chillers";
  parameter Integer m=1
    "Number of secondary pumps";
  parameter Real thrhol[:] = {0.95,0.95}
    "Threshold for chiller staging";
  parameter Real Cap[:] "Rated Plant Capacity";
  parameter Real tWai = 900 "Waiting time";
  parameter Modelica.Units.SI.TemperatureDifference dT=0.5
    "Temperature difference for stage control";
  parameter Modelica.Units.SI.Power PTow_nominal[:]={10E3 for i in linspace(
      1,
      n,
      n)} "Nominal cooling tower power (at y=1)";
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
      /4200/5.56 for i in linspace(
      1,
      n,
      n)} "Nominal mass flow rate at chilled water side";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]={
      mCHW_flow_nominal[1]*(datChi[1].COP_nominal + 1)/datChi[1].COP_nominal
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
  parameter Real v_flow_rate[m,:] = {{0.4*sum(mCHW_flow_nominal)/m/996,0.6*sum(
      mCHW_flow_nominal)/m/996,0.8*sum(mCHW_flow_nominal)/m/996,
      sum(mCHW_flow_nominal)/m/996,1.2*sum(mCHW_flow_nominal)/m/996}};
  parameter Real pressure[m,:] = {{2.2*dP_nominal,1.2*dP_nominal,1.1*dP_nominal,dP_nominal,0.75*dP_nominal}};
  parameter Real Motor_eta_Sec[m,:] =  {{0.6,0.76,0.87,0.86,0.74}}
    "Motor efficiency";
  parameter Real Hydra_eta_Sec[m,:] = {{1,1,1,1,1}}
    "Hydraulic efficiency";
  parameter Modelica.Units.SI.Pressure dPByp_nominal=100
    "Pressure difference between the outlet and inlet of the modules ";
  parameter Real vTow_flow_rate[n,:]={{0.3,0.6,1} for i in linspace(1, n, n)}
    "Volume flow rate rate";
  parameter Real eta[n,:]={{0.3^3,0.6^3,1} for i in linspace(1, n, n)}
    "Fan efficiency";
  parameter Modelica.Units.SI.Temperature TWetBul_nominal=273.15 + 19.45
    "Nominal wet bulb temperature";
  replaceable Subsystems.Chiller.MultiChillers
                             mulChiSys(
    redeclare package MediumCHW = MediumCHW,
    redeclare package MediumCW = MediumCW,
    dPCHW_nominal=dPCHW_nominal,
    dPCW_nominal=dPCW_nominal,
    mCHW_flow_nominal=mCHW_flow_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    TCW_start=273.15 + 23.89,
    TCHW_start=273.15 + 5.56,
    per=datChi,
    n=n)
    annotation (Placement(transformation(extent={{-94,-28},{-56,10}})));
  Subsystems.Pump.PumpSystem            pumSecCHW(
    redeclare package Medium = MediumCHW,
    n=m,
    VolFloCur=v_flow_rate,
    PreCur=pressure,
    HydEff=Hydra_eta_Sec,
    MotEff=Motor_eta_Sec,
    m_flow_nominal={sum(mCHW_flow_nominal)/m},
    dp(displayUnit="Pa") = {dP_nominal*0.5})
    annotation (Placement(transformation(extent={{44,-108},{78,-72}})));
  Subsystems.Pump.SimPumpSystem      pumPriCHW(
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
        n)})
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
      redeclare package Medium = MediumCHW)
    annotation (Placement(transformation(extent={{-44,-78},{-36,-70}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloByp(redeclare package Medium =
                       MediumCHW) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-52})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant On(k=1)
    annotation (Placement(transformation(extent={{-262,30},{-242,50}})));
  Subsystems.CoolingTower.CoolingTowersWithBypass
                                            cooTowWithByp(
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
    annotation (Placement(transformation(extent={{-190,-42},{-162,-14}})));
  Subsystems.Pump.SimPumpSystem      pumCW(
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
        n)})             annotation (Placement(transformation(extent={{-146,-110},
            {-112,-74}})));
  Buildings.Fluid.Storage.ExpansionVessel expVesCW(
      redeclare package Medium = MediumCW)
    annotation (Placement(transformation(extent={{-184,-78},{-176,-70}})));
  replaceable Devices.WaterSide.Control.PlantStageN       chillerStage(
    tWai=1800,
    n=n,
    thehol=thrhol,
    Cap=Cap) annotation (Placement(transformation(extent={{-80,58},{-60,78}})));
  replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWBuiEnt(
    redeclare package Medium = MediumCHW,
    allowFlowReversal=true,
    m_flow_nominal=sum(mCHW_flow_nominal))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={98,-90})));
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
    annotation (Placement(transformation(extent={{142,48},{162,68}})));
  Modelica.Blocks.Continuous.Integrator EConSpePum
    annotation (Placement(transformation(extent={{200,48},{220,68}})));
  Modelica.Blocks.Sources.RealExpression PVarSpePum(y=sum(pumSecCHW.P))
    annotation (Placement(transformation(extent={{140,22},{160,42}})));
  Modelica.Blocks.Continuous.Integrator EVarSpePum
    annotation (Placement(transformation(extent={{200,10},{220,30}})));
  Modelica.Blocks.Sources.RealExpression PCooTow(y=sum(cooTowWithByp.mulCooTowSys.P))
    annotation (Placement(transformation(extent={{158,-32},{178,-12}})));
  Modelica.Blocks.Continuous.Integrator ECooTow
    annotation (Placement(transformation(extent={{200,-34},{220,-14}})));
  Modelica.Blocks.Sources.RealExpression PTot(y=PCh.y + PConSpePum.y +
        PVarSpePum.y + PCooTow.y)
    annotation (Placement(transformation(extent={{160,-90},{180,-70}})));
  Modelica.Blocks.Continuous.Integrator ETot
    annotation (Placement(transformation(extent={{200,-90},{220,-70}})));
  Modelica.Blocks.Sources.RealExpression runCh
    annotation (Placement(transformation(extent={{160,-130},{180,-110}})));

  Modelica.Blocks.Continuous.Integrator mainCos
    annotation (Placement(transformation(extent={{216,-130},{236,-110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumCHW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{130,-152},{150,-132}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumCHW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{130,110},{150,130}})));
  Modelica.Blocks.Interfaces.RealInput TCWSet
    "Temperature set point of the condenser water"
    annotation (Placement(transformation(extent={{-312,-78},{-280,-46}})));
  Modelica.Blocks.Interfaces.RealInput TWetBul
    "Entering air wet bulb temperature"
    annotation (Placement(transformation(extent={{-312,-136},{-280,-104}})));
  Modelica.Blocks.Interfaces.RealInput dP "Measured pressure drop"
    annotation (Placement(transformation(extent={{-314,84},{-282,116}})));
  Modelica.Blocks.Interfaces.RealInput TCHWSet
    "Temperature setpoint of the chilled water"
    annotation (Placement(transformation(extent={{-312,-16},{-280,16}})));
  Modelica.Blocks.Interfaces.RealOutput T "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{242,-12},{262,8}})));
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
        extent={{10,12},{-10,-12}},
        rotation=180,
        origin={126,-90})));
  Modelica.Blocks.Sources.RealExpression Loa(y=senMasFloSecCHW.m_flow*4200*(
        senTCHWBuiLea.T - senTCHWBuiEnt.T))
    annotation (Placement(transformation(extent={{-174,16},{-154,36}})));
  Devices.Control.conPI conPI(k=0.001, Ti=60)
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Sources.RealExpression SetPoi(y=dP_nominal*0.5)
    annotation (Placement(transformation(extent={{-12,62},{8,82}})));
equation
  connect(senTCHWByp.port_a, senMasFloByp.port_b) annotation (Line(
      points={{-4.44089e-016,-20},{-4.44089e-016,-32},{0,-32},{0,-42}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senTCHWByp.port_b, pumPriCHW.port_a) annotation (Line(
      points={{6.66134e-016,0},{6.66134e-016,18},{-12,18}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(mulChiSys.port_a_CHW, pumPriCHW.port_b) annotation (Line(
      points={{-56,6.2},{-54,6.2},{-54,18},{-48,18}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(mulChiSys.port_b_CHW, senMasFloByp.port_a) annotation (Line(
      points={{-56,-24.2},{-56,-90},{0,-90},{0,-62}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(expVesCHW.port_a, senMasFloByp.port_a) annotation (Line(
      points={{-40,-78},{-40,-90},{-1.77636e-015,-90},{-1.77636e-015,-62}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(On.y, realToBoolean.u) annotation (Line(
      points={{-241,40},{-200,40},{-200,90},{-162,90}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cooTowWithByp.port_a, mulChiSys.port_b_CW) annotation (Line(
      points={{-162,-19.6},{-162,18},{-100,18},{-100,4},{-98,4},{-98,6.2},{-94,6.2}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(cooTowWithByp.port_b, pumCW.port_a) annotation (Line(
      points={{-162,-39.2},{-162,-92},{-146,-92}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pumCW.port_b, mulChiSys.port_a_CW) annotation (Line(
      points={{-112,-92},{-100,-92},{-100,-24.2},{-94,-24.2}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(expVesCW.port_a, pumCW.port_a) annotation (Line(
      points={{-180,-78},{-180,-92},{-146,-92}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));

  connect(pumSecCHW.port_a, senMasFloByp.port_a) annotation (Line(
      points={{44,-90},{0,-90},{0,-62},{-1.83187e-015,-62}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(chillerStage.y, mulChiSys.On) annotation (Line(
      points={{-59,68},{-40,68},{-40,40},{-120,40},{-120,-16.6},{-95.71,-16.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(pumCW.On, mulChiSys.On) annotation (Line(
      points={{-147.53,-81.2},{-152,-81.2},{-152,-40},{-112,-40},{-112,-16.6},{-95.71,
          -16.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooTowWithByp.On, mulChiSys.On) annotation (Line(
      points={{-191.26,-19.6},{-200,-19.6},{-200,-8},{-120,-8},{-120,-16.6},{-95.71,
          -16.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(chillerStage.On, realToBoolean.y) annotation (Line(
      points={{-82,76},{-120,76},{-120,90},{-139,90}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(chillerStage.Status, mulChiSys.Rat) annotation (Line(
      points={{-82,60},{-90,60},{-90,36},{-44,36},{-44,-16.6},{-54.1,-16.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumPriCHW.On, mulChiSys.On) annotation (Line(
      points={{-10.38,28.8},{10,28.8},{10,52},{-120,52},{-120,-16.6},{-95.71,-16.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumSecCHW.port_b, senTCHWBuiEnt.port_a) annotation (Line(
      points={{78,-90},{88,-90}},
      color={0,127,255},
      thickness=1));

  connect(PCh.y, ECh.u) annotation (Line(
      points={{161,100},{198,100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PConSpePum.y, EConSpePum.u) annotation (Line(
      points={{163,58},{163,58},{194,58},{198,58}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PVarSpePum.y, EVarSpePum.u) annotation (Line(
      points={{161,32},{180,32},{180,20},{198,20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PCooTow.y, ECooTow.u) annotation (Line(
      points={{179,-22},{179,-22},{192,-22},{192,-24},{198,-24}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PTot.y, ETot.u) annotation (Line(
      points={{181,-80},{189.5,-80},{198,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(runCh.y, mainCos.u) annotation (Line(
      points={{181,-120},{200,-120},{214,-120}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooTowWithByp.TCWSet, TCWSet) annotation (Line(
      points={{-191.26,-28},{-260,-28},{-260,-62},{-296,-62}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooTowWithByp.TWetBul, TWetBul) annotation (Line(
      points={{-191.26,-36.4},{-240,-36.4},{-240,-120},{-296,-120}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(mulChiSys.TCHWSet, TCHWSet) annotation (Line(
      points={{-95.71,-1.4},{-144,-1.4},{-144,0},{-296,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTCHWBuiEnt.T, T) annotation (Line(
      points={{98,-79},{110,-79},{110,-2},{252,-2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumPriCHW.port_a, senTCHWBuiLea.port_b) annotation (Line(
      points={{-12,18},{60,18}},
      color={0,127,255},
      thickness=1));
  connect(senTCHWBuiLea.port_a, port_a) annotation (Line(
      points={{80,18},{140,18},{140,120}},
      color={0,127,255},
      thickness=1));
  connect(senTCHWBuiEnt.port_b, senMasFloSecCHW.port_a) annotation (Line(points={{108,-90},
          {108,-90},{116,-90}},           color={0,127,255}));
  connect(senMasFloSecCHW.port_b, port_b) annotation (Line(
      points={{136,-90},{140,-90},{140,-142}},
      color={0,127,255},
      thickness=1));
  connect(Loa.y, chillerStage.Loa) annotation (Line(
      points={{-153,26},{-124,26},{-124,68},{-82,68}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conPI.On, realToBoolean.y) annotation (Line(points={{58,66},{28,66},{
          28,90},{-139,90}}, color={255,0,255}));
  connect(SetPoi.y, conPI.SetPoi) annotation (Line(points={{9,72},{36,72},{36,
          60},{58,60}}, color={0,0,127}));
  connect(conPI.Mea, dP) annotation (Line(points={{58,54},{26,54},{26,44},{-194,
          44},{-194,100},{-298,100}}, color={0,0,127}));
  connect(conPI.y, pumSecCHW.SpeSig[1]) annotation (Line(points={{81,60},{96,60},
          {96,-30},{18,-30},{18,-75.6},{42.47,-75.6}}, color={0,0,127}));
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
<p>The schematic drawing of the Lejeune plant is shown as folowing.</p>
<p><img src=\"Resources/Images/lejeunePlant/lejeune_schematic_drawing.jpg\" alt=\"image\"/> </p>
<p>In addition, the parameters are listed as below.</p>
<p>The parameters for the chiller plant.</p>
<p><img src=\"Resources/Images/lejeunePlant/Chiller.png\" alt=\"image\"/> </p>
<p>The parameters for the primary chilled water pump.</p>
<p><img src=\"Resources/Images/lejeunePlant/PriCHWPum.png\" alt=\"image\"/> </p>
<p>The parameters for the secondary chilled water pump.</p>
<p><img src=\"Resources/Images/lejeunePlant/SecCHWPum1.png\" alt=\"image\"/> </p>
<p><img src=\"Resources/Images/lejeunePlant/SecCHWPum2.png\" alt=\"image\"/> </p>
<p>The parameters for the condenser water pump.</p>
<p><img src=\"Resources/Images/lejeunePlant/CWPum.png\" alt=\"image\"/> </p>
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
        Line(points={{62,-4},{62,-36},{28,-36}}, color={0,0,127})}));
end ChillerPlant_simple;
