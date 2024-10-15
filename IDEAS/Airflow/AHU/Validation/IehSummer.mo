within IDEAS.Airflow.AHU.Validation;
model IehSummer
  "Validation of indirect evaporative heat exchanger using summer data set"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air
    annotation (__Dymola_choicesAllMatching=true);
  IDEAS.Fluid.Sources.Boundary_pT bui(
    nPorts=1,
    redeclare package Medium = Medium) "Building"
    annotation (Placement(transformation(extent={{-100,10},{-80,-10}})));
  IDEAS.Fluid.Sources.Boundary_pT bou2(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=false,
    use_X_in=false)
              annotation (Placement(transformation(extent={{60,20},{40,40}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TRetOut(redeclare package Medium =
        Medium) "Return outlet air temperature"
    annotation (Placement(transformation(extent={{2,24},{14,36}})));



  IDEAS.Fluid.Sensors.TemperatureTwoPort    TSupOut(redeclare package
      Medium =
        Medium, m_flow_nominal=4,
    tau=0)
    annotation (Placement(transformation(extent={{-60,8},{-74,-8}})));
  IDEAS.Utilities.Psychrometrics.X_pTphi XRet(use_p_in=false)
    "Absolute humidity of return air inlet"
    annotation (Placement(transformation(extent={{-118,32},{-106,44}})));
  Modelica.Blocks.Sources.Constant TRet(k=273.15 + 26.4)
    "Return inlet temperature"
    annotation (Placement(transformation(extent={{-140,40},{-128,52}})));
  Modelica.Blocks.Sources.Constant RhRet(k=0.54)
    "Relative humidity of return air inlet"
    annotation (Placement(transformation(extent={{-140,20},{-128,32}})));
  IDEAS.Utilities.Psychrometrics.X_pTphi XSup(use_p_in=false)
    "Absolute humidity at supply inlet"
    annotation (Placement(transformation(extent={{80,-8},{68,-20}})));
  Modelica.Blocks.Sources.Constant TSup(k=273.15 + 32)
    "Supply inlet dry bulb temperature"
    annotation (Placement(transformation(extent={{100,-20},{88,-8}})));
  Modelica.Blocks.Sources.Constant RhSup(k=0.4)
    "Supply inlet relative humidity"
    annotation (Placement(transformation(extent={{100,0},{88,12}})));
  IDEAS.Fluid.Sensors.RelativeHumidityTwoPort RhRetOut(
    redeclare package Medium = Medium,
    m_flow_nominal=4,
    tau=0) "Relative humidity of return outlet"
    annotation (Placement(transformation(extent={{22,24},{34,36}})));
  Modelica.Blocks.Sources.Constant V_flowRet(k=14200/3600)
    "Return air inlet volumetric flow rate"
    annotation (Placement(transformation(extent={{-140,0},{-128,12}})));
  IDEAS.Fluid.HeatExchangers.IndirectEvaporativeHex IEH(
    m1_flow_nominal=4.5,
    m2_flow_nominal=4.5,
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    eps_adia_off=adsolair14200.eps_adia_off,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    eps_adia_on=adsolair14200.eps_adia_on,
    use_eNTU=true,
    UA_adia_on=adsolair14200.UA_adia_on,
    UA_adia_off=adsolair14200.UA_adia_off)
                   "Indirect evaporative heat exchanger model"
    annotation (Placement(transformation(extent={{-38,2},{-4,36}})));
  Modelica.Blocks.Sources.BooleanConstant iehOn(k=true)
    "Indirect evaporative cooling function"
    annotation (Placement(transformation(extent={{12,8},{4,16}})));
  Modelica.Blocks.Sources.Constant V_flowSup(k=14493/3600)
    "Supply volumetric flow rate"
    annotation (Placement(transformation(extent={{100,20},{88,32}})));
  Modelica.Blocks.Sources.Constant datasheet_RhRetOut(k=0.8)
    annotation (Placement(transformation(extent={{-80,-60},{-70,-50}})));
  Modelica.Blocks.Sources.Constant datasheet_TRetOut(k=273.15 + 25.3)
    annotation (Placement(transformation(extent={{-80,-80},{-70,-70}})));
  Modelica.Blocks.Sources.Constant datasheet_RhSupOut(k=0.75)
    annotation (Placement(transformation(extent={{-60,-60},{-50,-50}})));
  Modelica.Blocks.Sources.Constant datasheet_TSupOut(k=273.15 + 21.4)
    annotation (Placement(transformation(extent={{-60,-80},{-50,-70}})));
  IDEAS.Fluid.Sensors.RelativeHumidityTwoPort RhSupOut(
    redeclare package Medium = Medium,
    m_flow_nominal=4,
    tau=0) "Relative humidity of supply outlet"
    annotation (Placement(transformation(extent={{-44,6},{-56,-6}})));
  IDEAS.Airflow.AHU.BaseClasses.Adsolair14200 adsolair14200
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  IDEAS.Airflow.AHU.BaseClasses.From_m3Pers from_m3PersSup(redeclare package
      Medium = Medium) "Conversion from m3/s to kg/s"
    annotation (Placement(transformation(extent={{-118,0},{-106,12}})));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,40},{-80,20}})));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  IDEAS.Airflow.AHU.BaseClasses.From_m3Pers from_m3PerhSup(redeclare package
      Medium = Medium) "Conversion from m3/s to kg/s"
    annotation (Placement(transformation(extent={{80,20},{68,8}})));
equation
  connect(TSupOut.port_b, bui.ports[1]) annotation (Line(
      points={{-74,0},{-80,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TRet.y, XRet.T) annotation (Line(
      points={{-127.4,46},{-124,46},{-124,38},{-119.2,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(RhRet.y, XRet.phi) annotation (Line(
      points={{-127.4,26},{-124,26},{-124,34.4},{-119.2,34.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSup.y, XSup.T) annotation (Line(
      points={{87.4,-14},{81.2,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(XSup.phi, RhSup.y) annotation (Line(
      points={{81.2,-10.4},{82,-10.4},{82,6},{87.4,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TRetOut.port_b, RhRetOut.port_a) annotation (Line(
      points={{14,30},{22,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(RhRetOut.port_b, bou2.ports[1]) annotation (Line(
      points={{34,30},{40,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(iehOn.y, IEH.adiabaticOn) annotation (Line(points={{3.6,12},{-3.32,12},
          {-3.32,19}},color={255,0,255}));
  connect(RhSupOut.port_a, IEH.port_b2)
    annotation (Line(points={{-44,0},{-38,0},{-38,8.8}}, color={0,127,255}));
  connect(IEH.port_b1, TRetOut.port_a)
    annotation (Line(points={{-4,29.2},{-4,30},{2,30}}, color={0,127,255}));
  connect(TSupOut.port_a, RhSupOut.port_b)
    annotation (Line(points={{-60,0},{-56,0}}, color={0,127,255}));
  connect(V_flowRet.y, from_m3PersSup.V_flow) annotation (Line(points={{-127.4,6},
          {-118.24,6},{-118.24,3.6}}, color={0,0,127}));
  connect(from_m3PersSup.T, TRet.y) annotation (Line(points={{-118.36,8.4},{-118.36,
          11},{-127.4,11},{-127.4,46}}, color={0,0,127}));
  connect(boundary.ports[1], IEH.port_a1) annotation (Line(points={{-80,30},{-38,
          30},{-38,29.2}},        color={0,127,255}));
  connect(boundary.X_in, XRet.X) annotation (Line(points={{-102,34},{-105.4,34},
          {-105.4,38}}, color={0,0,127}));
  connect(boundary.m_flow_in, from_m3PersSup.m_flow) annotation (Line(points={{-102,22},
          {-105.64,22},{-105.64,6}},     color={0,0,127}));
  connect(boundary.T_in, TRet.y) annotation (Line(points={{-102,26},{-122,26},{-122,
          46},{-127.4,46}}, color={0,0,127}));
  connect(boundary1.ports[1], IEH.port_a2)
    annotation (Line(points={{40,0},{-4,0},{-4,8.8}}, color={0,127,255}));
  connect(XSup.X, boundary1.X_in)
    annotation (Line(points={{67.4,-14},{62,-14},{62,-4}}, color={0,0,127}));
  connect(TSup.y, boundary1.T_in) annotation (Line(points={{87.4,-14},{86,-14},{
          86,-4},{86,4},{62,4}}, color={0,0,127}));
  connect(from_m3PerhSup.T, TSup.y) annotation (Line(points={{80.36,11.6},{86,11.6},
          {86,-14},{87.4,-14}}, color={0,0,127}));
  connect(from_m3PerhSup.V_flow, V_flowSup.y) annotation (Line(points={{80.24,16.4},
          {84,16.4},{84,26},{87.4,26}}, color={0,0,127}));
  connect(from_m3PerhSup.m_flow, boundary1.m_flow_in)
    annotation (Line(points={{67.64,14},{62,14},{62,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
            {100,100}}), graphics), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-140,-100},{100,100}}), graphics={
          Text(
          extent={{-92,-34},{-40,-48}},
          lineColor={28,108,200},
          textString="Datasheet solutions")}),
    experiment(StopTime=500, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Airflow/AHU/Validation/IehSummer.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>Error can be explained by data sheet: it does not seem to be consistent since there is a surplus of 6.3 kW.</p>
</html>"));
end IehSummer;
