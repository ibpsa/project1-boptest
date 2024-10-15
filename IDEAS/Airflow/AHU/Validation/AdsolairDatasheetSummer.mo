within IDEAS.Airflow.AHU.Validation;
model AdsolairDatasheetSummer
  "Validaiton using nominal data sheet performance data for summer"
  extends IDEAS.Airflow.AHU.Validation.BaseClasses.PartialAdsolairValidation(
      adsolair58(                    use_onOffSignal=false, IEH(
          mFloAdiBot(y=(IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(
              pSat=IDEAS.Media.Air.saturationPressure(adsolair58.IEH.volBot.heatPort.T),
              p=adsolair58.IEH.port_a2.p,
              phi=0.75) -adsolair58.IEH.Xw_in_bot)      *adsolair58.IEH.port_a2.m_flow),
          prescribeTBot=true)),
      sinkAir);
  Modelica.Blocks.Sources.Constant T_room(k=273.15 + 26.4)
    annotation (Placement(transformation(extent={{-114,20},{-100,34}})));
  Modelica.Blocks.Sources.Constant RH_room(k=0.54)
    annotation (Placement(transformation(extent={{-114,0},{-100,14}})));
  Modelica.Blocks.Sources.Constant V_flow_room(k=14200/3600)
    annotation (Placement(transformation(extent={{-114,42},{-100,56}})));
  IDEAS.Utilities.Psychrometrics.X_pTphi
                                   XiEnv1(
                                         use_p_in=false)
    annotation (Placement(transformation(extent={{68,-2},{56,10}})));
  Modelica.Blocks.Sources.Constant RH_env(k=0.4)
    annotation (Placement(transformation(extent={{94,0},{80,14}})));
  Modelica.Blocks.Sources.Constant T_env(k=273.15 + 32)
    annotation (Placement(transformation(extent={{94,20},{80,34}})));
  Modelica.Blocks.Sources.Constant V_flow_env(k=14493/3600)
    annotation (Placement(transformation(extent={{94,40},{80,54}})));
  Modelica.Blocks.Sources.Constant dp_set(k=270)
    annotation (Placement(transformation(extent={{-40,60},{-26,74}})));
  Modelica.Blocks.Sources.Constant T_set(k=273.15 + 16.7)
    annotation (Placement(transformation(extent={{-40,80},{-26,94}})));
  Modelica.Blocks.Sources.Constant RH_evap(k=0.87)
    annotation (Placement(transformation(extent={{-78,-76},{-64,-62}})));
  Modelica.Blocks.Sources.Constant Q_evap(k=40040)
    annotation (Placement(transformation(extent={{-78,-98},{-64,-84}})));
  Modelica.Blocks.Sources.Constant T_cond(k=273.15 + 35.2)
    annotation (Placement(transformation(extent={{-40,-76},{-26,-62}})));
  Modelica.Blocks.Sources.Constant Q_cond(k=46700)
    annotation (Placement(transformation(extent={{-40,-98},{-26,-84}})));
  Real relHumIn=IDEAS.Utilities.Psychrometrics.Functions.phi_pTX(
      p=adsolair58.IEH.volBot.ports[1].p,
      T=adsolair58.IEH.volBot.heatPort.T,
      X_w=adsolair58.IEH.volBot.ports[1].Xi_outflow[1]);

  Modelica.Blocks.Sources.RealExpression realExpression(y=adsolair58.eva.T)
    annotation (Placement(transformation(extent={{-8,-70},{58,-54}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=adsolair58.eva.Xi[1])
    annotation (Placement(transformation(extent={{-8,-78},{58,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=101300)
    annotation (Placement(transformation(extent={{-8,-86},{58,-70}})));
  IDEAS.Utilities.Psychrometrics.Phi_pTX phi_evap
    "Relative humidity of evaporator outlet, for checking with reference result"
    annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
initial equation
  der(adsolair58.IEH.volBot.dynBal.mXi)=zeros(MediumAir.nXi);
equation
  connect(RH_room.y, XiEnv.phi) annotation (Line(points={{-99.3,7},{-94,7},{-94,
          8.4},{-87.2,8.4}}, color={0,0,127}));
  connect(T_room.y, XiEnv.T) annotation (Line(points={{-99.3,27},{-94,27},{-94,12},
          {-87.2,12}},   color={0,0,127}));
  connect(V_flow_room.y, From_m3PerhRet.V_flow) annotation (Line(points={{-99.3,
          49},{-88,49},{-88,29},{-84.2,29}}, color={0,0,127}));
  connect(env.T_in, From_m3PerhSup.T)
    annotation (Line(points={{40,8},{66.3,8},{66.3,13}},   color={0,0,127}));
  connect(XiEnv1.X, env.X_in)
    annotation (Line(points={{55.4,4},{40,4},{40,0}}, color={0,0,127}));
  connect(XiEnv1.T, From_m3PerhSup.T) annotation (Line(points={{69.2,4},{70,4},{
          70,14},{70,13},{66.3,13}},  color={0,0,127}));
  connect(T_env.y, From_m3PerhSup.T) annotation (Line(points={{79.3,27},{74,27},
          {74,13},{66.3,13}}, color={0,0,127}));
  connect(XiEnv1.phi, RH_env.y) annotation (Line(points={{69.2,0.4},{76,0.4},{
          76,7},{79.3,7}}, color={0,0,127}));
  connect(V_flow_env.y, From_m3PerhSup.V_flow)
    annotation (Line(points={{79.3,47},{66.2,47},{66.2,17}}, color={0,0,127}));
  connect(dp_set.y, adsolair58.dpSet[1])
    annotation (Line(points={{-25.3,67},{-7.6,67},{-7.6,20.9}},
                                                            color={0,0,127}));
  connect(dp_set.y, adsolair58.dpSet[2])
    annotation (Line(points={{-25.3,67},{-7.6,67},{-7.6,19.5}},
                                                            color={0,0,127}));
  connect(T_set.y, adsolair58.Tset)
    annotation (Line(points={{-25.3,87},{-2.8,87},{-2.8,20.2}},
                                                            color={0,0,127}));
  connect(realExpression.y, phi_evap.T)
    annotation (Line(points={{61.3,-62},{79,-62}}, color={0,0,127}));
  connect(realExpression1.y, phi_evap.X_w)
    annotation (Line(points={{61.3,-70},{79,-70}}, color={0,0,127}));
  connect(realExpression2.y, phi_evap.p)
    annotation (Line(points={{61.3,-78},{79,-78}},          color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=3000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput(events=false),
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Airflow/AHU/Validation/AdsolairDatasheetSummer.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>Note that the inlet conditions of the evaporator are overwritten by custom equations!</p>
</html>", revisions="<html>
<ul>
<li>
October 11, 2016, by Filip Jorissen:<br/>
Added first implementation.
</li>
</ul>
</html>"));
end AdsolairDatasheetSummer;
