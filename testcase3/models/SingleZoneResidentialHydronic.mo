within ;
package SingleZoneResidentialHydronic
  model SingleZoneResidentialHydronicControl
    "Single zone residential hydronic example model with controller"
    import IDEAS;
    import IBPSA;
    extends Modelica.Icons.Example;
    package Medium = IDEAS.Media.Water;
    IDEAS.Buildings.Validation.Cases.Case900Template case900Template
      "Case 900 BESTEST model"
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    inner IDEAS.BoundaryConditions.SimInfoManager       sim
      "Simulation information manager for climate data"
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
      redeclare package Medium = Medium,
      T_a_nominal=273.15 + 70,
      T_b_nominal=273.15 + 50,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      Q_flow_nominal=2000) "Radiator"
                               annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-30,10})));
    IDEAS.Fluid.HeatExchangers.Heater_T hea(redeclare package Medium = Medium,
        m_flow_nominal=pump.m_flow_nominal,
      dp_nominal=0) "Ideal heater"
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      use_inputFilter=false,
      massFlowRates={0,0.05},
      redeclare package Medium = Medium,
      m_flow_nominal=rad.m_flow_nominal,
      inputType=IDEAS.Fluid.Types.InputType.Constant,
      constantMassFlowRate=0.05)         "Hydronic pump"
      annotation (Placement(transformation(extent={{0,-20},{20,0}})));

    IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1,
      redeclare package Medium = Medium)
      "Absolute pressure boundary"
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Modelica.Blocks.Interfaces.RealOutput Q "Thermal power use of heater"
      annotation (Placement(transformation(extent={{100,70},{120,90}})));
    Modelica.Blocks.Interfaces.RealOutput TZone
      "Zone operative temperature"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    IDEAS.Controls.Continuous.PIDHysteresis       con(
      pre_y_start=false,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=600,
      Td=60,
      k=300,
      yMax=273.15 + 70,
      yMin=273.15 + 10)
      annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
    Modelica.Blocks.Sources.Constant TSet(               y(unit="K"), k=273.15 +
          22) "Set point"
      annotation (Placement(transformation(extent={{-98,50},{-78,70}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        TRooAir(KPIs="comfort") "Read the room air temperature"
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    IBPSA.Utilities.IO.SignalExchange.Read PHea(KPIs="power")
      "Read heating power"
      annotation (Placement(transformation(extent={{60,70},{80,90}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveTsup
      "Overwrite the supply temperature"
      annotation (Placement(transformation(extent={{-28,50},{-8,70}})));
    IBPSA.Utilities.IO.SignalExchange.Read ETotHea(KPIs="energy")
      "Read heating energy"
      annotation (Placement(transformation(extent={{72,40},{92,60}})));
    Modelica.Blocks.Interfaces.RealOutput E "Thermal power use of heater"
      annotation (Placement(transformation(extent={{100,40},{120,60}})));
    Modelica.Blocks.Continuous.Integrator intEHeat
      "Calculate the heater energy"
      annotation (Placement(transformation(extent={{42,40},{62,60}})));
  equation
    connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points={{-37.2,
            12},{-48,12},{-48,7},{-60,7}}, color={191,0,0}));
    connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points={{-37.2,
            8},{-46,8},{-46,4},{-60,4}}, color={191,0,0}));
    connect(hea.port_b, rad.port_a)
      annotation (Line(points={{0,30},{-30,30},{-30,20}}, color={0,127,255}));
    connect(pump.port_a, rad.port_b)
      annotation (Line(points={{0,-10},{-30,-10},{-30,0}}, color={0,127,255}));
    connect(pump.port_b, hea.port_a) annotation (Line(points={{20,-10},{40,-10},{40,
            30},{20,30}}, color={0,127,255}));
    connect(bou.ports[1], pump.port_a)
      annotation (Line(points={{-20,-30},{0,-30},{0,-10}}, color={0,127,255}));
    connect(case900Template.TSensor, con.u_m)
      annotation (Line(points={{-59,12},{-50,12},{-50,48}}, color={0,0,127}));
    connect(TSet.y, con.u_s)
      annotation (Line(points={{-77,60},{-62,60}}, color={0,0,127}));
    connect(TRooAir.y, TZone)
      annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
    connect(hea.Q_flow, PHea.u) annotation (Line(points={{-1,38},{0,38},{0,80},
            {58,80}}, color={0,0,127}));
    connect(PHea.y, Q)
      annotation (Line(points={{81,80},{110,80}}, color={0,0,127}));
    connect(con.y, oveTsup.u)
      annotation (Line(points={{-39,60},{-30,60}}, color={0,0,127}));
    connect(oveTsup.y, hea.TSet) annotation (Line(points={{-7,60},{-7,60},{24,
            60},{24,38},{22,38}},
                              color={0,0,127}));
    connect(case900Template.TSensor, TRooAir.u) annotation (Line(points={{-59,12},
            {-50,12},{-50,-50},{50,-50},{50,0},{58,0}}, color={0,0,127}));
    connect(ETotHea.y, E)
      annotation (Line(points={{93,50},{98,50},{110,50}}, color={0,0,127}));
    connect(ETotHea.u, intEHeat.y)
      annotation (Line(points={{70,50},{63,50}}, color={0,0,127}));
    connect(intEHeat.u, PHea.u) annotation (Line(points={{40,50},{36,50},{36,80},
            {58,80}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=2.4192e+006,
        __Dymola_NumberOfIntervals=5000,
        __Dymola_Algorithm="Lsodar"),
      Documentation(info="<html>
<p>
This is a single zone hydronic system model 
for WP 1.2 of IBPSA project 1.
</p>
</html>",   revisions="<html>
<ul>
<li>
January 22nd, 2019 by Filip Jorissen:<br/>
Revised implementation by adding external inputs.
</li>
<li>
May 2, 2018 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
  end SingleZoneResidentialHydronicControl;

  model SingleZoneResidentialHydronicBOPTEST
    "Single zone residential hydronic example model for BOPTEST"
    extends Modelica.Icons.Example;
    package Medium = IDEAS.Media.Water;
    IDEAS.Buildings.Validation.Cases.Case900Template case900Template
      "Case 900 BESTEST model"
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    inner IDEAS.BoundaryConditions.SimInfoManager sim
      "Simulation information manager for climate data"
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
      redeclare package Medium = Medium,
      T_a_nominal=273.15 + 70,
      T_b_nominal=273.15 + 50,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      Q_flow_nominal=2000) "Radiator" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-30,10})));
    IDEAS.Fluid.HeatExchangers.Heater_T hea(
      redeclare package Medium = Medium,
      m_flow_nominal=pump.m_flow_nominal,
      dp_nominal=0) "Ideal heater"
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      use_inputFilter=false,
      massFlowRates={0,0.05},
      redeclare package Medium = Medium,
      m_flow_nominal=rad.m_flow_nominal,
      inputType=IDEAS.Fluid.Types.InputType.Constant,
      constantMassFlowRate=0.05) "Hydronic pump"
      annotation (Placement(transformation(extent={{0,-20},{20,0}})));

    IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
          Medium) "Absolute pressure boundary"
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Modelica.Blocks.Interfaces.RealOutput Q
      "Thermal power use of heater"
      annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput TZone
      "Zone operative temperature"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    IBPSA.Utilities.IO.SignalExchange.Read pumpRead(KPIs="power", y(unit="W"))
      annotation (Placement(transformation(extent={{46,-40},{66,-20}})));
    IBPSA.Utilities.IO.SignalExchange.Read heaRead(KPIs="power", y(unit="W"))
      annotation (Placement(transformation(extent={{120,26},{140,46}})));
    IBPSA.Utilities.IO.SignalExchange.Read TRooAir(KPIs="comfort", y(unit="K"))
      annotation (Placement(transformation(extent={{122,-38},{142,-18}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveTsup(u(unit="K"))
      annotation (Placement(transformation(extent={{52,70},{72,90}})));
    Modelica.Blocks.Sources.Constant const(k=320)
      annotation (Placement(transformation(extent={{10,70},{30,90}})));
    IBPSA.Utilities.IO.SignalExchange.Read TSupRead(KPIs="", y(unit="K"))
      annotation (Placement(transformation(extent={{120,96},{140,116}})));
  equation
    connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points={{-37.2,
            12},{-48,12},{-48,7},{-60,7}}, color={191,0,0}));
    connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points={{-37.2,
            8},{-46,8},{-46,4},{-60,4}}, color={191,0,0}));
    connect(hea.port_b, rad.port_a)
      annotation (Line(points={{0,30},{-30,30},{-30,20}}, color={0,127,255}));
    connect(pump.port_a, rad.port_b)
      annotation (Line(points={{0,-10},{-30,-10},{-30,0}}, color={0,127,255}));
    connect(pump.port_b, hea.port_a) annotation (Line(points={{20,-10},{40,-10},{40,
            30},{20,30}}, color={0,127,255}));
    connect(bou.ports[1], pump.port_a)
      annotation (Line(points={{-20,-30},{0,-30},{0,-10}}, color={0,127,255}));
    connect(hea.Q_flow, Q) annotation (Line(points={{-1,38},{0,38},{0,60},{110,60}},
          color={0,0,127}));
    connect(case900Template.TSensor, TZone) annotation (Line(points={{-59,12},{80,
            12},{80,0},{110,0}}, color={0,0,127}));
    connect(pump.P, pumpRead.u)
      annotation (Line(points={{21,-1},{44,-1},{44,-30}}, color={0,0,127}));
    connect(Q, heaRead.u) annotation (Line(points={{110,60},{106,60},{106,36},{
            118,36}}, color={0,0,127}));
    connect(TZone, TRooAir.u)
      annotation (Line(points={{110,0},{110,-28},{120,-28}}, color={0,0,127}));
    connect(oveTsup.y, hea.TSet) annotation (Line(points={{73,80},{84,80},{84,
            38},{22,38}}, color={0,0,127}));
    connect(const.y, oveTsup.u)
      annotation (Line(points={{31,80},{50,80}}, color={0,0,127}));
    connect(TSupRead.u, hea.TSet) annotation (Line(points={{118,106},{100,106},
            {100,80},{84,80},{84,38},{22,38}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=2.4192e+006,
        __Dymola_NumberOfIntervals=5000,
        __Dymola_Algorithm="Lsodar"),
      Documentation(info="<html>
<p>
This is a single zone hydronic system model 
for WP 1.2 of IBPSA project 1.
</p>
</html>",   revisions="<html>
<ul>
<li>
January 22nd, 2019 by Filip Jorissen:<br/>
Revised implementation by adding external inputs.
</li>
<li>
May 2, 2018 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
  end SingleZoneResidentialHydronicBOPTEST;

  model SingleZoneResidentialHydronicBOPTEST_withBaseline
    "Single zone residential hydronic example model for BOPTEST"
    extends Modelica.Icons.Example;
    package Medium = IDEAS.Media.Water;
    IDEAS.Buildings.Validation.Cases.Case900Template case900Template
      "Case 900 BESTEST model"
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    inner IDEAS.BoundaryConditions.SimInfoManager sim
      "Simulation information manager for climate data"
      annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
    IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
      redeclare package Medium = Medium,
      T_a_nominal=273.15 + 70,
      T_b_nominal=273.15 + 50,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      Q_flow_nominal=2000) "Radiator" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-30,10})));
    IDEAS.Fluid.HeatExchangers.Heater_T hea(
      redeclare package Medium = Medium,
      m_flow_nominal=pump.m_flow_nominal,
      dp_nominal=0) "Ideal heater"
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      use_inputFilter=false,
      massFlowRates={0,0.05},
      redeclare package Medium = Medium,
      m_flow_nominal=rad.m_flow_nominal,
      inputType=IDEAS.Fluid.Types.InputType.Constant,
      constantMassFlowRate=0.05) "Hydronic pump"
      annotation (Placement(transformation(extent={{0,-20},{20,0}})));

    IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
          Medium) "Absolute pressure boundary"
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Modelica.Blocks.Interfaces.RealOutput Q
      "Thermal power use of heater"
      annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput TZone
      "Zone operative temperature"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    IBPSA.Utilities.IO.SignalExchange.Read pumpRead(KPIs="power", y(unit="W"))
      annotation (Placement(transformation(extent={{46,-40},{66,-20}})));
    IBPSA.Utilities.IO.SignalExchange.Read heaRead(KPIs="power", y(unit="W"))
      annotation (Placement(transformation(extent={{120,26},{140,46}})));
    IBPSA.Utilities.IO.SignalExchange.Read TRooAir(KPIs="comfort", y(unit="K"))
      annotation (Placement(transformation(extent={{122,-38},{142,-18}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveTsup(u(unit="K"))
      annotation (Placement(transformation(extent={{34,78},{54,98}})));
    IBPSA.Utilities.IO.SignalExchange.Read TSupRead(KPIs="", y(unit="K"))
      annotation (Placement(transformation(extent={{120,78},{140,98}})));
    Modelica.Blocks.Sources.Constant TSet_lower(y(unit="K"), k=273.15 + 22)
      "Set point"
      annotation (Placement(transformation(extent={{-96,36},{-76,56}})));
    IDEAS.Controls.Discrete.HysteresisRelease con(revert=true, use_input=true)
      annotation (Placement(transformation(extent={{-40,78},{-20,98}})));
    Modelica.Blocks.Sources.Constant TSet_upper(y(unit="K"), k=273.15 + 24)
      "Set point"
      annotation (Placement(transformation(extent={{-96,70},{-76,90}})));
    Modelica.Blocks.Math.Gain gain(k=273.15 + 65)
      annotation (Placement(transformation(extent={{-6,78},{14,98}})));
  equation
    connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points={{-37.2,
            12},{-48,12},{-48,7},{-60,7}}, color={191,0,0}));
    connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points={{-37.2,
            8},{-46,8},{-46,4},{-60,4}}, color={191,0,0}));
    connect(hea.port_b, rad.port_a)
      annotation (Line(points={{0,30},{-30,30},{-30,20}}, color={0,127,255}));
    connect(pump.port_a, rad.port_b)
      annotation (Line(points={{0,-10},{-30,-10},{-30,0}}, color={0,127,255}));
    connect(pump.port_b, hea.port_a) annotation (Line(points={{20,-10},{40,-10},{40,
            30},{20,30}}, color={0,127,255}));
    connect(bou.ports[1], pump.port_a)
      annotation (Line(points={{-20,-30},{0,-30},{0,-10}}, color={0,127,255}));
    connect(hea.Q_flow, Q) annotation (Line(points={{-1,38},{-6,38},{-6,60},{
            110,60}},
          color={0,0,127}));
    connect(case900Template.TSensor, TZone) annotation (Line(points={{-59,12},{80,
            12},{80,0},{110,0}}, color={0,0,127}));
    connect(pump.P, pumpRead.u)
      annotation (Line(points={{21,-1},{44,-1},{44,-30}}, color={0,0,127}));
    connect(Q, heaRead.u) annotation (Line(points={{110,60},{106,60},{106,36},{
            118,36}}, color={0,0,127}));
    connect(TZone, TRooAir.u)
      annotation (Line(points={{110,0},{110,-28},{120,-28}}, color={0,0,127}));
    connect(oveTsup.y, hea.TSet) annotation (Line(points={{55,88},{84,88},{84,
            38},{22,38}}, color={0,0,127}));
    connect(TSupRead.u, hea.TSet) annotation (Line(points={{118,88},{84,88},{84,
            38},{22,38}}, color={0,0,127}));
    connect(TSet_lower.y, con.uLow) annotation (Line(points={{-75,46},{-60,46},
            {-60,80},{-42,80}}, color={0,0,127}));
    connect(TSet_upper.y, con.uHigh) annotation (Line(points={{-75,80},{-62,80},
            {-62,84},{-42,84}}, color={0,0,127}));
    connect(con.u, TZone) annotation (Line(points={{-42,88},{-52,88},{-52,12},{
            80,12},{80,0},{110,0}}, color={0,0,127}));
    connect(con.y, gain.u)
      annotation (Line(points={{-19,88},{-8,88}}, color={0,0,127}));
    connect(gain.y, oveTsup.u)
      annotation (Line(points={{15,88},{32,88}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -60},{140,120}})),                                   Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},{140,
              120}})),
      experiment(
        StopTime=2.4192e+006,
        __Dymola_NumberOfIntervals=5000,
        __Dymola_Algorithm="Lsodar"),
      Documentation(info="<html>
<p>
This is a single zone hydronic system model 
for WP 1.2 of IBPSA project 1.
</p>
</html>",   revisions="<html>
<ul>
<li>
January 22nd, 2019 by Filip Jorissen:<br/>
Revised implementation by adding external inputs.
</li>
<li>
May 2, 2018 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
  end SingleZoneResidentialHydronicBOPTEST_withBaseline;
  annotation (uses(Modelica(version="3.2.2"),
      IDEAS(version="2.0.0"),
      IBPSA(version="3.0.0")));
end SingleZoneResidentialHydronic;
