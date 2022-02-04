within singlezone_commercial_air.BaseClasses;
model RTU_Staged "Staged RTU model"
  package MediumA = Buildings.Media.Air "Air Medium model";
  // AHU modification ==================================

  //constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";
  //parameter Modelica.SIunits.MassFlowRate mRoo_flow_nominal=6*roo.AFlo*conv
  //  "Design mass flow rate core";
  //parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.7*mRoo_flow_nominal "Nominal mass flow rate";

  //Heating: 4kW (20oX) , Cooling:8kW(22oC), 300cfm/ton~0.1m3/s/ton--> 0.28 kg/s (cf 0.068)
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1.51 "Nominal mass flow rate";
  parameter Modelica.SIunits.HeatFlowRate Qc_nominal=18*1E3 "nominal cooling total cap [W]";
  parameter Modelica.SIunits.HeatFlowRate Qh_nominal=50*1E3 "nominal heating cap [W]";

  parameter Modelica.SIunits.PressureDifference dpBuiStaSet = 12 "Building static pressure set point";
  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal";

  /* economizer setup */
  parameter Real dpOut_nominal=10;
  parameter Real dpRec_nominal=10;
  parameter Real dpExh_nominal=10;

  /* sensors */
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemRet(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Return air temperature sensor"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,60})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemMix(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Mixed air temperature sensor"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemSup(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Supply air temperature sensor"
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senFloSup(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for supply fan flow rate"
    annotation (Placement(transformation(extent={{110,-10},{130,10}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senFloOut(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for outside air volume flow rate"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  /* RTU: economizer */
  Buildings.Fluid.Actuators.Dampers.MixingBox eco(
    redeclare package Medium = MediumA,
    mOut_flow_nominal=m_flow_nominal,
    dpDamOut_nominal=2*dpOut_nominal,
    dpFixOut_nominal=dpOut_nominal,
    dpDamRec_nominal=2*dpRec_nominal,
    dpFixRec_nominal=dpRec_nominal,
    dpDamExh_nominal=2*dpExh_nominal,
    dpFixExh_nominal=dpExh_nominal,
    mRec_flow_nominal=m_flow_nominal,
    mExh_flow_nominal=m_flow_nominal,
    from_dp=false) "Economizer"
    annotation (Placement(transformation(extent={{-70,-4},{-50,16}})));
  Buildings.Fluid.Sources.Outside souInf(redeclare package Medium = MediumA,
      nPorts=2) "Source model for air infiltration"
           annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,50})));

  /* RTU: furnace */
  Buildings.Fluid.HeatExchangers.HeaterCooler_u heaCoi(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0,
    Q_flow_nominal=Qh_nominal)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));

  /* RTU: DX */
  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil datCoi(
    nSta=1,
    minSpeRat=0,
    sta={
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=2400/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-Qc_nominal/1,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=m_flow_nominal/1),
        perCur=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Examples.PerformanceCurves.Curve_I())})        "Coil data"
    annotation (Placement(transformation(extent={{120,80},{140,100}})));

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.SingleSpeed cooCoi(
    redeclare package Medium = MediumA,
    dp_nominal=dp_nominal - dpRec_nominal - dpOut_nominal - dpBuiStaSet,
    datCoi=datCoi,
    T_start=datCoi.sta[1].nomVal.TEvaIn_nominal,
    from_dp=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Single speed DX coil"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  /* RTU: fan */
  Buildings.Fluid.Movers.SpeedControlled_y     fanSup(
    redeclare package Medium = MediumA,
    per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{dp_nominal +
            dpRec_nominal + dpOut_nominal + dpBuiStaSet,0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=true)  "Supply air fan"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));


  /* weather */

  Buildings.BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-150,90},{-130,110}})));

  /* ports */
  Modelica.Fluid.Interfaces.FluidPort_a port_ret(redeclare package Medium =
        MediumA) "Return air port"
    annotation (Placement(transformation(extent={{130,50},{150,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_sup(redeclare package Medium =
        MediumA) "Supply air port"
    annotation (Placement(transformation(extent={{130,-10},{150,10}})));
  Modelica.Blocks.Interfaces.RealInput uFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{-180,60},{-140,100}})));
  Modelica.Blocks.Interfaces.BooleanInput enaDx "Enable DX unit"
    annotation (Placement(transformation(extent={{-180,20},{-140,60}})));
  Modelica.Blocks.Interfaces.RealInput uHea "Heating rate control signal"
    annotation (Placement(transformation(extent={{-180,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealInput yDamOut
    "Outside air damper position control signal"
    annotation (Placement(transformation(extent={{-180,-60},{-140,-20}})));
  parameter Modelica.SIunits.PressureDifference dp_nominal=0
    "Nominal pressure drop of system";
equation
  connect(senFloOut.port_b, eco.port_Exh)
    annotation (Line(points={{-80,0},{-70,0}},     color={0,127,255}));
  connect(souInf.ports[1], eco.port_Out) annotation (Line(points={{-78,40},{-76,
          40},{-76,20},{-70,20},{-70,12}},
                                     color={0,127,255}));
  connect(souInf.ports[2], senFloOut.port_a)
    annotation (Line(points={{-82,40},{-82,20},{-100,20},{-100,0}},
                                                   color={0,127,255}));
  connect(senTemMix.port_b, fanSup.port_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  connect(weaBus.TDryBul, cooCoi.TConIn) annotation (Line(
      points={{-140,100},{20,100},{20,3},{19,3}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(fanSup.port_b, cooCoi.port_a)
    annotation (Line(points={{10,0},{20,0}},   color={0,127,255}));
  connect(cooCoi.port_b, heaCoi.port_a)
    annotation (Line(points={{40,0},{50,0}},color={0,127,255}));
  connect(heaCoi.port_b, senTemSup.port_a)
    annotation (Line(points={{70,0},{80,0}}, color={0,127,255}));
  connect(senTemSup.port_b, senFloSup.port_a)
    annotation (Line(points={{100,0},{110,0}},
                                             color={0,127,255}));
  connect(senTemRet.port_a, port_ret)
    annotation (Line(points={{100,60},{140,60}}, color={0,127,255}));
  connect(senFloSup.port_b, port_sup)
    annotation (Line(points={{130,0},{140,0}},color={0,127,255}));
  connect(weaBus, souInf.weaBus) annotation (Line(
      points={{-140,100},{-80,100},{-80,60},{-79.8,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(fanSup.y, uFan)
    annotation (Line(points={{0,12},{0,80},{-160,80}},     color={0,0,127}));
  connect(cooCoi.on, enaDx) annotation (Line(points={{19,8},{18,8},{18,78},{
          -110,78},{-110,40},{-160,40}},
                                    color={255,0,255}));
  connect(heaCoi.u, uHea) annotation (Line(points={{48,6},{48,76},{-108,76},{
          -108,0},{-160,0}},
                        color={0,0,127}));
  connect(eco.y, yDamOut) annotation (Line(points={{-60,18},{-60,74},{-106,74},
          {-106,-40},{-160,-40}}, color={0,0,127}));
  connect(eco.port_Sup, senTemMix.port_a) annotation (Line(points={{-50,12},{
          -46,12},{-46,0},{-40,0}}, color={0,127,255}));
  connect(eco.port_Ret, senTemRet.port_b) annotation (Line(points={{-50,0},{-50,
          4},{-40,4},{-40,60},{80,60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{140,100}}), graphics={
                                        Text(
        extent={{-100,140},{100,100}},
        textString="%name",
        textColor={0,0,255}), Rectangle(
          extent={{140,-100},{-140,100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{140,
            100}})));
end RTU_Staged;
