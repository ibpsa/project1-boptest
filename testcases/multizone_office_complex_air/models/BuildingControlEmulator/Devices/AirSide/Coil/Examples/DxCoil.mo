within BuildingControlEmulator.Devices.AirSide.Coil.Examples;
model DxCoil
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;

  package Medium2 = Buildings.Media.Air "Medium model";
  BuildingControlEmulator.Devices.AirSide.Coil.DxCoil           DxCoil(
    redeclare package MediumAir = Medium2,
    datCoi=datCoi,
    PreDroAir(displayUnit="Pa") = 1000,
    mAirFloRat=1,
    minOffTim=300,
    dT=0.5,
    minOnTim=1500)
    annotation (Placement(transformation(extent={{-34,40},{8,-2}})));
  Buildings.Fluid.MixingVolumes.MixingVolume
                                  souAir(
    redeclare package Medium = Medium2,
    p(displayUnit="Pa") = 100000,
    nPorts=2,
    V=10000,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{76,-34},{56,-14}})));

  Modelica.Blocks.Sources.Constant Tcon(k=273.15 + 23.89) "Relative humidity"
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=500, startValue=false)
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  parameter
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.SingleSpeed.Carrier_Comfort_50ES060
    datCoi(sta={
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=1800,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-17500.95,
          COP_nominal=3.9,
          SHR_nominal=0.78,
          m_flow_nominal=1.2*0.944),
        perCur=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.PerformanceCurve(
          capFunT={1.6380187,-0.0747347,0.0029747,0.0015201,-0.0000519,-0.0004509},
          capFunFF={0.8185792,0.2831771,-0.1017563},
          EIRFunT={-0.2209648,0.1033303,-0.0030061,-0.0070657,0.0006322,-0.0002496},
          EIRFunFF={1.0380778,-0.2013868,0.1633090},
          TConInMin=273.15 + 23.89,
          TConInMax=273.15 + 51.67,
          TEvaInMin=273.15 + 13.89,
          TEvaInMax=273.15 + 22.22,
          ffMin=0.875,
          ffMax=1.125))})
    annotation (Placement(transformation(extent={{70,-88},{90,-68}})));
  Modelica.Blocks.Sources.Constant TSet(k=273.15 + 20)    "Relative humidity" annotation (Placement(transformation(extent={{-100,-58},{-80,-38}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = Medium2,
    dp_nominal=1000,
    m_flow_nominal=1)
                     annotation (Placement(transformation(extent={{40,24},{20,
            44}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium2, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{50,-72},{30,-52}})));
  Modelica.Blocks.Sources.Constant const(k=100)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
    "Prescribed heat flow rate"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Blocks.Sources.Constant m_flow(k=1)   "Relative humidity" annotation (Placement(transformation(extent={{-100,40},
            {-80,60}})));

equation
  connect(Tcon.y, DxCoil.TConIn) annotation (Line(
      points={{-79,20},{-79,20},{-60,20},{-60,27.4},{-38.2,27.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTem.port_a, souAir.ports[1])
    annotation (Line(
      points={{50,-62},{66,-62},{78,-62},{78,-34},{68,-34}},
      color={0,127,255},
      thickness=1));
  connect(preHeaFlo.Q_flow,const. y) annotation (Line(
      points={{0,80},{-19,80}},
      color={0,0,127}));
  connect(preHeaFlo.port, souAir.heatPort) annotation (Line(points={{20,80},{56,
          80},{92,80},{92,-24},{76,-24}},                                                                       color={191,0,0}));
  connect(m_flow.y, fan.m_flow_in) annotation (Line(
      points={{-79,50},{30,50},{30,46}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(fan.port_a, souAir.ports[2]) annotation (Line(
      points={{40,34},{50,34},{50,-34},{64,-34}},
      color={0,127,255},
      thickness=1));
  connect(fan.port_b, DxCoil.port_a_Air)
    annotation (Line(points={{20,34},{8,34},{8,35.8}}, color={0,127,255}));
  connect(senTem.port_b, DxCoil.port_b_Air) annotation (Line(
      points={{30,-62},{-4,-62},{-50,-62},{-50,35.8},{-34.42,35.8}},
      color={0,127,255},
      thickness=1));
  connect(booleanStep.y, DxCoil.On) annotation (Line(
      points={{-79,-80},{-60,-80},{-60,2.2},{-38.2,2.2}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(TSet.y, DxCoil.SetPoi) annotation (Line(
      points={{-79,-48},{-66,-48},{-66,10.6},{-38.2,10.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTem.T, DxCoil.Mea) annotation (Line(
      points={{40,-51},{40,-51},{40,-22},{-76,-22},{-76,14},{-54,14},{-54,19},{
          -38.2,19}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end DxCoil;
