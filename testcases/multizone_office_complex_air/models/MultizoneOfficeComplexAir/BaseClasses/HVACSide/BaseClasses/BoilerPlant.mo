within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses;
model BoilerPlant "Boiler hot water plant"
  replaceable package MediumHW =
     Modelica.Media.Interfaces.PartialMedium
    "Medium in the hot water side";
  parameter Real alpha = 1  "Sizing factor for overall system design capacity and mass flow rate";
  parameter Integer n=2
    "Number of boilers";
  parameter Integer m=2
    "Number of pumps";
  parameter Real thrhol[:]= {0.95}
    "Threshold for boiler staging";
  parameter Real Cap[:] = {4191000*alpha/n for i in linspace(1, n, n)} "Rated Plant Capacity";
  parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal[:]={62.4/n*alpha for i in linspace(
      1,
      n,
      n)} "Nominal mass flow rate at the hot water side";
  parameter Modelica.Units.SI.Temperature THW_start=273.15 + 80
    "The start temperature of hot water side";
  parameter Modelica.Units.SI.TemperatureDifference dTHW_nominal=20
    "Temperature difference between the outlet and inlet of the module";
  parameter Real eta[n,:]={{0.8} for i in linspace(1,n,n)} "Fan efficiency";
  parameter Modelica.Units.SI.Pressure dP_nominal=478250
    "Nominal pressure drop for the secondary hot water pump ";
  parameter Real v_flow_rate[m,:] = {{0.1*sum(mHW_flow_nominal)/m/996,0.6*sum(mHW_flow_nominal)/m/996,0.8*sum(mHW_flow_nominal)/m/996,sum(mHW_flow_nominal)/m/996,1.2*sum(mHW_flow_nominal)/m/996} for i in linspace(1,m,m)};
  parameter Real pressure[m,:] = {{2*dP_nominal,1.5*dP_nominal,1.1*dP_nominal,dP_nominal,0.75*dP_nominal} for i in linspace(1,m,m)};
  parameter Real Motor_eta_Sec[m,:] = {{0.6,0.76,0.87,0.86,0.74} for i in linspace(1,m,m)} "Motor efficiency";
  parameter Real Hydra_eta_Sec[m,:] = {{1,1,1,1,1} for i in linspace(1,m,m)} "Hydraulic efficiency";

  Component.FlowMover.Pump.PumpSystem pumSecHW(
    redeclare package Medium = MediumHW,
    n=m,
    m_flow_nominal={sum(mHW_flow_nominal)/m for i in linspace(
        1,
        m,
        m)},
    HydEff=Hydra_eta_Sec,
    MotEff=Motor_eta_Sec,
    VolFloCur=v_flow_rate,
    PreCur=pressure,
    dpValve_nominal={dP_nominal*0.25 for i in linspace(
        1,
        m,
        m)}) annotation (Placement(transformation(extent={{10,20},{-10,40}})));
  Modelica.Blocks.Math.RealToBoolean reaToBoolea
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant On(k=1)
    annotation (Placement(transformation(extent={{-260,80},{-240,100}})));
  Component.FlowMover.Pump.Control.SecPumCon secPumCon(tWai=1800, n=m)
    annotation (Placement(transformation(extent={{60,46},{80,66}})));
  replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTHWBuiEnt(
    allowFlowReversal=true,
    redeclare package Medium = MediumHW,
    m_flow_nominal=sum(mHW_flow_nominal))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={64,-96})));
  replaceable Component.WaterSide.Boiler.MultiBoilers mulBoi(
    redeclare package MediumHW = MediumHW,
    dPHW_nominal=dP_nominal*0.5,
    mHW_flow_nominal=mHW_flow_nominal,
    dTHW_nominal=dTHW_nominal,
    eta=eta,
    n=n,
    THW_start=THW_start)
    annotation (Placement(transformation(extent={{-96,-44},{-62,-16}})));
  Buildings.Fluid.Storage.ExpansionVessel expVesCHW(redeclare package Medium =
        MediumHW, V_start=10)
    annotation (Placement(transformation(extent={{30,8},{38,16}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = MediumHW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{230,30},{250,50}}),
        iconTransformation(extent={{90,30},{110,50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = MediumHW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{230,-70},{250,-50}}),
        iconTransformation(extent={{90,-70},{110,-50}})));
  Component.WaterSide.Control.PlantStageN boiSta(
    tWai=1800,
    n=n,
    thehol=thrhol,
    Cap=Cap) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Interfaces.RealInput dp "Measured pressure drop"
    annotation (Placement(transformation(extent={{-320,-20},{-280,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealOutput THW_sup
    "Temperature of the passing fluid" annotation (Placement(transformation(
          extent={{240,-30},{260,-10}}), iconTransformation(extent={{100,-40},{
            120,-20}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTHWBuiLea(
    allowFlowReversal=true,
    redeclare package Medium = MediumHW,
    m_flow_nominal=sum(mHW_flow_nominal)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={120,22})));
  replaceable Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package
      Medium =
        MediumHW) annotation (Placement(transformation(
        extent={{-10,12},{10,-12}},
        rotation=180,
        origin={82,22})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=senMasFlo.m_flow*4200
        *(senTHWBuiEnt.T - senTHWBuiLea.T))
    annotation (Placement(transformation(extent={{62,-50},{42,-30}})));
  Modelica.Blocks.Interfaces.RealInput THWSet
    "Temperature setpoint of the hot water"
    annotation (Placement(transformation(extent={{-320,40},{-280,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput dpSet
    "Static differential pressure setpoint for the secondary pump"
    annotation (Placement(transformation(extent={{-320,-80},{-280,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Sources.RealExpression PTot(y=sum(pumSecHW.P) + sum(
        mulBoi.boi.boi.QFue_flow))
    annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
  Modelica.Blocks.Continuous.Integrator ETot
    annotation (Placement(transformation(extent={{180,-120},{200,-100}})));
  Modelica.Blocks.Interfaces.RealOutput THW_ret
    "Temperature of the passing fluid" annotation (Placement(transformation(
          extent={{240,-10},{260,10}}), iconTransformation(extent={{100,-10},{
            120,10}})));
  Modelica.Blocks.Interfaces.RealOutput mHW_tot annotation (Placement(
        transformation(extent={{240,50},{260,70}}), iconTransformation(extent={
            {100,60},{120,80}})));
equation
  connect(On.y, reaToBoolea.u)
    annotation (Line(points={{-239,90},{-162,90}}, color={0,0,127}));

  connect(secPumCon.On, reaToBoolea.y) annotation (Line(points={{58,64},{40,64},
          {40,90},{-139,90}}, color={255,0,255}));
  connect(mulBoi.port_a_HW, pumSecHW.port_b) annotation (Line(
      points={{-62,-18.8},{-62,30},{-10,30}},
      color={255,0,0},
      thickness=1));
  connect(mulBoi.port_b_HW, senTHWBuiEnt.port_a) annotation (Line(
      points={{-62,-41.2},{-58,-41.2},{-58,-96},{54,-96}},
      color={255,0,0},
      thickness=1));

  connect(pumSecHW.speRat, secPumCon.sta) annotation (Line(points={{-11,
          36.2},{-20,36.2},{-20,48},{58,48}}, color={0,0,127}));
  connect(senTHWBuiEnt.port_b, port_b) annotation (Line(
      points={{74,-96},{106,-96},{106,-60},{240,-60}},
      color={255,0,0},
      thickness=1));
  connect(boiSta.On, reaToBoolea.y) annotation (Line(points={{-82,78},{-120,78},
          {-120,90},{-139,90}}, color={255,0,255}));
  connect(secPumCon.dpMea, dp) annotation (Line(points={{58,56},{-180,56},{
          -180,0},{-300,0}}, color={0,0,127}));
  connect(senTHWBuiEnt.T, THW_sup) annotation (Line(points={{64,-85},{64,-56},{
          220,-56},{220,-20},{250,-20}}, color={0,0,127}));
  connect(mulBoi.Rat, boiSta.sta) annotation (Line(points={{-60.3,-35.6},{-32,
          -35.6},{-32,34},{-92,34},{-92,62},{-82,62}}, color={0,0,127}));
  connect(boiSta.y, mulBoi.On) annotation (Line(points={{-59,70},{-42,70},{
          -42,28},{-142,28},{-142,-35.6},{-97.53,-35.6}}, color={0,0,127}));
  connect(senTHWBuiLea.port_a, port_a) annotation (Line(
      points={{130,22},{134,22},{134,40},{240,40}},
      color={255,0,0},
      thickness=1));
  connect(expVesCHW.port_a, pumSecHW.port_a) annotation (Line(
      points={{34,8},{34,2},{54,2},{54,30},{10,30}},
      color={255,0,0},
      thickness=1));
  connect(senMasFlo.port_b, pumSecHW.port_a) annotation (Line(
      points={{72,22},{48,22},{48,30},{10,30}},
      color={255,0,0},
      thickness=1));
  connect(senMasFlo.port_a, senTHWBuiLea.port_b) annotation (Line(
      points={{92,22},{110,22}},
      color={255,0,0},
      thickness=1));
  connect(realExpression.y,boiSta.loa)  annotation (Line(points={{41,-40},{-20,-40},
          {-20,2},{-110,2},{-110,70},{-82,70}}, color={0,0,127}));
  connect(secPumCon.y,pumSecHW.speSig)  annotation (Line(
      points={{81,56},{86,56},{86,38},{10.9,38}},
      color={0,0,127}));
  connect(mulBoi.THWSet, THWSet) annotation (Line(points={{-97.53,-24.4},{-220,
          -24.4},{-220,60},{-300,60}}, color={0,0,127}));
  connect(secPumCon.dpSet, dpSet) annotation (Line(points={{58,52},{-240,52},
          {-240,-60},{-300,-60}}, color={0,0,127}));
  connect(PTot.y,ETot. u) annotation (Line(
      points={{161,-110},{178,-110}},
      color={0,0,127}));
  connect(senTHWBuiLea.T, THW_ret) annotation (Line(points={{120,33},{120,36},{
          220,36},{220,0},{250,0}}, color={0,0,127}));
  connect(senMasFlo.m_flow, mHW_tot) annotation (Line(points={{82,35.2},{100,
          35.2},{100,60},{250,60}}, color={0,0,127}));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/LejeunePlant/ChillerPlantSystem.mos"
        "Simulate and plot"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-280,-140},{240,
            120}})),
    experiment(
      StartTime=2.9376e+006,
      StopTime=3.6288e+006,
      __Dymola_NumberOfIntervals=1440,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>The hot water system consists of two gas boilers and two variable speed pumps.</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/BoilerControl.PNG\"/> </p>
<p>The number of operating boilers is determined via a state machine based on the thermal load(Q, kW), rated heating capacity of boiler k (hck, kW),
 threshold to start boiler k+1 (&xi;k = 0.9), and waiting time (30 min). The maximum operating boiler number is N, which is equal to 2.</p>
<p>Boiler heating power is controlled by a PI controller to maintain the temperature of the hot water leaving each boiler to be 80 &deg;C. 
It takes the hot water measurements and set points as inputs. It takes the heating power as the output. </p>
<p>Boiler pump speed is controlled by a PI controller to maintain the static pressure of the boiler water loop at setpoint. 
It takes the heat water loop pressure drop measurements and setpoints as inputs. It takes the pump speed as the output. All the boiler pumps share the same speed. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Boiler.MultiBoilers\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Boiler.MultiBoilers</a> for a description of the multiple boiler. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Control.PlantStageN\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Control.PlantStageN</a> for a description of the boiler stage control. </p>
</html>", revisions = "<html>
<ul>
<li>August 8, 2024, by Guowen Li, Xing Lu, Yan Chen: </li>
<p>Adjusted system equipment sizing; Reduced nonlinear system warnings.</p>
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
        Line(points={{-76,24},{-76,46},{28,46}},  color={0,0,127}),
        Line(points={{-76,-2},{-76,-36},{-36,-36}}, color={0,0,127}),
        Line(points={{62,20},{62,46},{28,46}}, color={0,0,127}),
        Line(points={{62,-4},{62,-36},{28,-36}}, color={0,0,127}),
        Text(
          extent={{-150,104},{150,144}},
          textString="%name",
          textColor={0,0,255})}));
end BoilerPlant;
