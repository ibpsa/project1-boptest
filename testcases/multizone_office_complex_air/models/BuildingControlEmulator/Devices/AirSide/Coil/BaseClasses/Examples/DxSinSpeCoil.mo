within BuildingControlEmulator.Devices.AirSide.Coil.BaseClasses.Examples;
model DxSinSpeCoil
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;

  package Medium2 = Buildings.Media.Air "Medium model";
  BuildingControlEmulator.Devices.AirSide.Coil.BaseClasses.DxSinSpeCoil
                                                                DxCoil(
    redeclare package MediumAir = Medium2,
    datCoi=datCoi,
    mAirFloRat=0.1,
    PreDroAir(displayUnit="Pa") = 1000)
    annotation (Placement(transformation(extent={{-20,14},{22,-28}})));
  Buildings.Fluid.Sources.Boundary_pT souAir(
    redeclare package Medium = Medium2,
    p(displayUnit="Pa") = 100000,
    X={0.02,1 - 0.02},
    use_T_in=true,
    use_X_in=true,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{82,32},{62,52}})));
  Buildings.Fluid.Sources.Boundary_pT   sinAir(
    redeclare package Medium = Medium2,
    nPorts=1,
    p(displayUnit="Pa") = 100000 - 1000,
    T=303.15) annotation (Placement(transformation(extent={{-80,38},{-60,58}})));

  Modelica.Blocks.Sources.Constant relHum(k=0.8) "Relative humidity"
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Buildings.Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false)
    annotation (Placement(transformation(extent={{18,70},{38,90}})));
  Modelica.Blocks.Sources.Constant temSou(k=273.15 + 30)
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Constant Tcon(k=273.15 + 23.89) "Relative humidity"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=500, startValue=false)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
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
    annotation (Placement(transformation(extent={{60,-36},{80,-16}})));
  Modelica.Blocks.Sources.Constant Pressure(k=100000) "Relative humidity"
    annotation (Placement(transformation(extent={{50,-6},{70,14}})));
equation
  connect(DxCoil.port_b_Air, sinAir.ports[1]) annotation (Line(points={{-20,5.6},
          {-40,5.6},{-40,48},{-60,48}}, color={0,127,255}));
  connect(relHum.y,x_pTphi. phi) annotation (Line(
      points={{-9,30},{-6,30},{-6,74},{16,74}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temSou.y, x_pTphi.T) annotation (Line(
      points={{-39,80},{16,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(souAir.T_in, x_pTphi.T) annotation (Line(
      points={{84,46},{90,46},{90,58},{-28,58},{-28,80},{16,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(x_pTphi.X, souAir.X_in) annotation (Line(points={{39,80},{68,80},{98,80},
          {98,38},{84,38}}, color={0,0,127}));
  connect(Tcon.y, DxCoil.TConIn) annotation (Line(
      points={{-79,-10},{-79,-10},{-40,-10},{-40,-15.4},{-22.1,-15.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanStep.y, DxCoil.on) annotation (Line(
      points={{-79,-50},{-40,-50},{-40,-23.8},{-22.1,-23.8}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(Pressure.y, souAir.p_in)
    annotation (Line(points={{71,4},{94,4},{94,50},{84,50}}, color={0,0,127}));
  connect(DxCoil.port_a_Air, souAir.ports[1]) annotation (Line(points={{22,5.6},
          {32,5.6},{32,6},{40,6},{40,42},{62,42}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000));
end DxSinSpeCoil;
