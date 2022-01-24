within singlezone_commercial_air;
model RTU_variable "variable speed RTU"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air "Medium model";
  package MediumW = Buildings.Media.Water;
  // AHU modification ==================================

  //constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";
  //parameter Modelica.SIunits.MassFlowRate mRoo_flow_nominal=6*roo.AFlo*conv
  //  "Design mass flow rate core";
  //parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.7*mRoo_flow_nominal "Nominal mass flow rate";

  //Heating: 4kW (20oX) , Cooling:8kW(22oC), 300cfm/ton~0.1m3/s/ton--> 0.28 kg/s (cf 0.068)
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1.51 "Nominal mass flow rate";
  parameter Modelica.SIunits.HeatFlowRate Qc_nominal=18*1E3 "nominal cooling total cap [W]";
  parameter Modelica.SIunits.HeatFlowRate Qh_nominal=50*1E3 "nominal heating cap [W]";

  parameter Modelica.SIunits.PressureDifference dpBuiStaSet(min=0) = 12
    "Building static pressure";

 parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal";

  /* economizer setup */
  parameter Real dpOut_nominal=10;
  parameter Real dpRec_nominal=10;
  parameter Real dpExh_nominal=10;
  /* weather */
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam="./USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.mos",
      computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-168,90})));
  /* sensors */
  Buildings.Fluid.Sensors.Pressure sen_PRA(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{20,52},{0,72}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TR(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-32,62})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TM(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Mixed air temperature sensor"
    annotation (Placement(transformation(extent={{-72,-12},{-52,8}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSh(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Mixed air temperature sensor"
    annotation (Placement(transformation(extent={{-28,-12},{-8,8}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TS(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{22,-12},{42,8}})));
  Buildings.Fluid.Sensors.Pressure sen_PSA(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{58,-2},{38,18}})));
  Buildings.Fluid.Sensors.VolumeFlowRate mS(redeclare package Medium = MediumA,
      m_flow_nominal=m_flow_nominal) "Sensor for supply fan flow rate"
    annotation (Placement(transformation(extent={{60,-12},{80,8}})));
      Buildings.Fluid.Sensors.VolumeFlowRate mO(redeclare package Medium = MediumA,
      m_flow_nominal=m_flow_nominal) "Outside air volume flow rate"
    annotation (Placement(transformation(extent={{-126,10},{-104,32}})));
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
    annotation (Placement(transformation(extent={{-94,18},{-74,38}})));
  Buildings.Fluid.Sources.Outside souInf(redeclare package Medium = MediumA,
      nPorts=2) "Source model for air infiltration"
           annotation (Placement(transformation(extent={{-146,32},{-134,44}})));

  /* RTU: boiler */
    Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                             hea(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0,
    Q_flow_nominal=Qh_nominal)
    annotation (Placement(transformation(extent={{10,-42},{30,-22}})));

  /* RTU: DX */
  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil datCoi(
    nSta=4,
    minSpeRat=0,
    sta={
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=900/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-Qc_nominal/4,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=m_flow_nominal/4),
        perCur=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Examples.PerformanceCurves.Curve_I()),
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=1200/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-Qc_nominal/3,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=m_flow_nominal/3),
        perCur=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Examples.PerformanceCurves.Curve_I()),
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-Qc_nominal/2,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=m_flow_nominal/2),
        perCur=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Examples.PerformanceCurves.Curve_II()),
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=2400/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-Qc_nominal/1,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=m_flow_nominal/1),
        perCur=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Examples.PerformanceCurves.Curve_III())})      "Coil data"
    annotation (Placement(transformation(extent={{74,76},{100,102}})));

    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed DX(
    redeclare package Medium = MediumA,
    dp_nominal=10,
    datCoi=datCoi,
    T_start=datCoi.sta[1].nomVal.TEvaIn_nominal,
    from_dp=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    minSpeRat=0.2)
    "Variable speed DX coil"
    annotation (Placement(transformation(extent={{-6,8},{12,26}})));

    /* RTU: fan */
    Buildings.Fluid.Movers.SpeedControlled_y     fanSup(
    redeclare package Medium = MediumA,
    per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{780 + 10 + dpBuiStaSet,0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false) "Supply air fan"
    annotation (Placement(transformation(extent={{-50,-12},{-30,8}})));

  /* Envelope */
    BaseClasses.EnvelopeModel envelopeModel(lat=weaDat.lat) "envelope + gains"
    annotation (Placement(transformation(extent={{50,30},{90,70}})));

  /* control & auxiliaries */
  Modelica.Blocks.Sources.RealExpression yOA(y=0.2)
    annotation (Placement(transformation(extent={{-134,52},{-112,74}})));

  Modelica.Blocks.Sources.RealExpression yfan(y=1)
    annotation (Placement(transformation(extent={{-62,24},{-40,46}})));

  Buildings.BoundaryConditions.WeatherData.Bus weaBus1
    annotation (Placement(transformation(extent={{-28,28},{-8,48}})));
    Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-134,-50},{-128,-44}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-132,-78},{-126,-72}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(
    table=[1,15.5555555556; 2,15.5555555556; 3,15.5555555556; 4,15.5555555556;
        5,15.5555555556; 6,15.5555555556; 7,15.5555555556; 8,15.5555555556; 9,
        18.3333333333; 10,21.1111111111; 11,21.1111111111; 12,21.1111111111; 13,
        21.1111111111; 14,21.1111111111; 15,21.1111111111; 16,21.1111111111; 17,
        21.1111111111; 18,21.1111111111; 19,21.1111111111; 20,21.1111111111; 21,
        21.1111111111; 22,15.5555555556; 23,15.5555555556; 24,15.5555555556; 25,
        15.555555],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "setpoint heating [C]"
    annotation (Placement(transformation(extent={{-154,-82},{-142,-70}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetCoo(
    table=[1,29.4444444444; 2,29.4444444444; 3,29.4444444444; 4,29.4444444444;
        5,29.4444444444; 6,29.4444444444; 7,29.4444444444; 8,29.4444444444; 9,
        26.6666666667; 10,23.8888888889; 11,23.8888888889; 12,23.8888888889; 13,
        23.8888888889; 14,23.8888888889; 15,23.8888888889; 16,23.8888888889; 17,
        23.8888888889; 18,23.8888888889; 19,23.8888888889; 20,23.8888888889; 21,
        23.8888888889; 22,29.4444444444; 23,29.4444444444; 24,29.4444444444; 25,
        29.4444444444],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "Setpoint cooling oC"
    annotation (Placement(transformation(extent={{-154,-54},{-142,-42}})));
  Buildings.Controls.Continuous.LimPID
                                    cooCoiCon(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=200,
    Td=0,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-112,-54},{-98,-40}})));
  Buildings.Controls.Continuous.LimPID heaCoiCon(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=200,
    Td=0,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-112,-82},{-98,-68}})));
equation
  connect(weaDat.weaBus, envelopeModel.weaBus) annotation (Line(
      points={{-162,90},{60,90},{60,69.2},{50.4,69.2}},
      color={255,204,51},
      thickness=0.5));
  connect(envelopeModel.b, sen_PRA.port) annotation (Line(points={{51,61.6},{36,
          61.6},{36,52},{10,52}}, color={0,127,255}));
  connect(sen_PRA.port, TR.port_a) annotation (Line(points={{10,52},{-6,52},{-6,
          56},{-22,56},{-22,62}}, color={0,127,255}));
  connect(TR.port_b, eco.port_Sup) annotation (Line(points={{-42,62},{-66,62},{-66,
          34},{-74,34}}, color={0,127,255}));
  connect(eco.port_Ret, TM.port_a) annotation (Line(points={{-74,22},{-72,22},{-72,
          -2}},                   color={0,127,255}));
  connect(mO.port_b, eco.port_Exh) annotation (Line(points={{-104,21},{-99,21},{
          -99,22},{-94,22}}, color={0,127,255}));
  connect(weaDat.weaBus, souInf.weaBus) annotation (Line(
      points={{-162,90},{-154,90},{-154,38.12},{-146,38.12}},
      color={255,204,51},
      thickness=0.5));
  connect(souInf.ports[1], eco.port_Out) annotation (Line(points={{-134,39.2},{-116,
          39.2},{-116,34},{-94,34}}, color={0,127,255}));
  connect(souInf.ports[2], mO.port_a) annotation (Line(points={{-134,36.8},{-130,
          36.8},{-130,21},{-126,21}}, color={0,127,255}));
  connect(TS.port_b, sen_PSA.port)
    annotation (Line(points={{42,-2},{48,-2}}, color={0,127,255}));
  connect(sen_PSA.port, mS.port_a)
    annotation (Line(points={{48,-2},{60,-2}}, color={0,127,255}));
  connect(mS.port_b, envelopeModel.a) annotation (Line(points={{80,-2},{80,26},{
          36,26},{36,41.2},{51.2,41.2}}, color={0,127,255}));
  connect(yOA.y, eco.y)
    annotation (Line(points={{-110.9,63},{-84,63},{-84,40}}, color={0,0,127}));
  connect(TM.port_b, fanSup.port_a)
    annotation (Line(points={{-52,-2},{-50,-2}}, color={0,127,255}));
  connect(fanSup.port_b, TSh.port_a)
    annotation (Line(points={{-30,-2},{-28,-2}}, color={0,127,255}));
  connect(yfan.y, fanSup.y) annotation (Line(points={{-38.9,35},{-36,35},{-36,18},
          {-40,18},{-40,10}}, color={0,0,127}));
  connect(TSh.port_b, DX.port_a)
    annotation (Line(points={{-8,-2},{-8,17},{-6,17}}, color={0,127,255}));
  connect(weaBus1.TDryBul, DX.TConIn) annotation (Line(
      points={{-18,38},{-18,19.7},{-6.9,19.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus1, weaDat.weaBus) annotation (Line(
      points={{-18,38},{-20,38},{-20,90},{-162,90},{-162,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(DX.port_b,hea. port_a) annotation (Line(points={{12,17},{14,17},{14,
          -14},{-4,-14},{-4,-32},{10,-32}}, color={0,127,255}));
  connect(hea.port_b, TS.port_a) annotation (Line(points={{30,-32},{46,-32},{46,
          -12},{22,-12},{22,-2}}, color={0,127,255}));
  connect(TSetHea.y[1], from_degC1.u) annotation (Line(points={{-141.4,-76},{
          -136,-76},{-136,-75},{-132.6,-75}}, color={0,0,127}));
  connect(TSetCoo.y[1], from_degC.u) annotation (Line(points={{-141.4,-48},{
          -138,-48},{-138,-47},{-134.6,-47}}, color={0,0,127}));
  connect(from_degC.y, cooCoiCon.u_s) annotation (Line(points={{-127.7,-47},{
          -120,-47},{-120,-47},{-113.4,-47}}, color={0,0,127}));
  connect(cooCoiCon.y, DX.speRat) annotation (Line(points={{-97.3,-47},{-12,-47},
          {-12,24.2},{-6.9,24.2}}, color={0,0,127}));
  connect(envelopeModel.Tz, cooCoiCon.u_m) annotation (Line(points={{92,52.4},{
          104,52.4},{104,52},{110,52},{110,-62},{-105,-62},{-105,-55.4}}, color=
         {0,0,127}));
  connect(from_degC1.y, heaCoiCon.u_s) annotation (Line(points={{-125.7,-75},{
          -118.85,-75},{-118.85,-75},{-113.4,-75}}, color={0,0,127}));
  connect(envelopeModel.Tz, heaCoiCon.u_m) annotation (Line(points={{92,52.4},{
          110,52.4},{110,-112},{-105,-112},{-105,-83.4}}, color={0,0,127}));
  connect(heaCoiCon.y, hea.u) annotation (Line(points={{-97.3,-75},{-8,-75},{-8,
          -26},{8,-26}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -120},{100,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{100,
            100}}),
        graphics={Text(
          extent={{-64,-114},{10,-154}},
          lineColor={28,108,200},
          textString="design air flow rate [m3/s]: 1.51 from htm
coil sizing (PSZ-AC_6): 18 kW cooling, 50 kW heating from htm ",
          fontSize=18), Rectangle(
          extent={{-156,-20},{-4,-94}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),
    experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end RTU_variable;
