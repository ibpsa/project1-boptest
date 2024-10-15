within IDEAS.Airflow.AHU.Validation.BaseClasses;
partial model PartialAdsolairValidation
   extends Modelica.Icons.Example;
  replaceable package MediumAir = IDEAS.Media.Air;

  IDEAS.Airflow.AHU.Adsolair58 adsolair58(
    redeclare package MediumAir = MediumAir,
    redeclare replaceable IDEAS.Airflow.AHU.BaseClasses.Adsolair14200
      per,
    tau=60) "Adsolair58 model"
    annotation (Placement(transformation(extent={{-22,0},{2,20}})));
  IDEAS.Fluid.Sources.MassFlowSource_T env(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    use_m_flow_in=true,
    use_X_in=true,
    nPorts=1)      "Environment"
    annotation (Placement(transformation(extent={{38,-6},{18,14}})));
  IDEAS.Fluid.Sources.MassFlowSource_T zone(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    use_m_flow_in=true,
    use_X_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-66,6},{-46,26}})));
  IDEAS.Fluid.Sources.Boundary_pT sinkAir(redeclare package Medium = MediumAir,
      nPorts=2)
    annotation (Placement(transformation(extent={{40,-20},{20,-40}})));
  IDEAS.Airflow.AHU.BaseClasses.From_m3Pers From_m3PerhRet(redeclare package
      Medium = MediumAir)
    "Conversion from volumetric flow rate to mass flow rate for return duct"
    annotation (Placement(transformation(extent={{-84,26},{-74,36}})));
  IDEAS.Airflow.AHU.BaseClasses.From_m3Pers From_m3PerhSup(redeclare package
      Medium = MediumAir)
    "Conversion from volumetric flow rate to mass flow rate for supply duct"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={61,15})));
  IDEAS.Utilities.Psychrometrics.X_pTphi
                                   XiEnv(use_p_in=false)
    "Conversion to absolute humidity"
    annotation (Placement(transformation(extent={{-86,6},{-74,18}})));
equation
  connect(From_m3PerhSup.m_flow, env.m_flow_in) annotation (Line(points={{55.7,15},
          {46,15},{46,12},{38,12}},     color={0,0,127}));
  connect(From_m3PerhRet.m_flow, zone.m_flow_in) annotation (Line(points={{-73.7,
          31},{-72,31},{-72,24},{-70,24},{-66,24}}, color={0,0,127}));
  connect(XiEnv.X, zone.X_in) annotation (Line(points={{-73.4,12},{-72,12},{-68,
          12}},                   color={0,0,127}));
  connect(XiEnv.T, zone.T_in) annotation (Line(points={{-87.2,12},{-90,12},{-90,
          20},{-68,20}}, color={0,0,127}));
  connect(From_m3PerhRet.T, XiEnv.T) annotation (Line(points={{-84.3,33},{-90,
          33},{-90,32},{-90,12},{-87.2,12}},
                                           color={0,0,127}));
  connect(zone.ports[1], adsolair58.port_a1)
    annotation (Line(points={{-46,16},{-32,16},{-18,16}}, color={0,127,255}));
  connect(adsolair58.port_b2, sinkAir.ports[1]) annotation (Line(points={{-18,4},
          {-18,-20},{-18,-32},{20,-32}}, color={0,127,255}));
  connect(adsolair58.port_b1, sinkAir.ports[2]) annotation (Line(points={{2,16},
          {10,16},{10,-28},{20,-28}}, color={0,127,255}));
  connect(adsolair58.port_a2, env.ports[1])
    annotation (Line(points={{2,4},{10,4},{18,4}}, color={0,127,255}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StartTime=500000,
      StopTime=850000,
      __Dymola_NumberOfIntervals=20000,
      __Dymola_fixedstepsize=20,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands,
    Documentation(info="<html>
<p>Validation of electrical power consumption for fans using known pressures and valve set points</p>
</html>", revisions="<html>
<ul>
<li>
October 11, 2016, by Filip Jorissen:<br/>
Added first implementation.
</li>
</ul>
</html>"));
end PartialAdsolairValidation;
