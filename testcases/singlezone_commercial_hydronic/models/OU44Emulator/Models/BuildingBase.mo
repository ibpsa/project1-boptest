within OU44Emulator.Models;
partial model BuildingBase "Single-zone whole building model"
package Water = Buildings.Media.Water;
package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"});
final parameter Modelica.SIunits.Area AFlo=8500 "Floor area";
final parameter Modelica.SIunits.Length hRoo=3.2 "Average room height";
final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water=2
  "Nominal mass flow rate for water loop";
final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_air=31
  "Nominal mass flow rate for air system";

  model DistrictHeating
      replaceable package Water = Buildings.Media.Water constrainedby
      Modelica.Media.Interfaces.PartialMedium;
      Buildings.Fluid.HeatExchangers.ConstantEffectiveness dhHX(
        redeclare package Medium1 = Water,
        redeclare package Medium2 = Water,
        m1_flow_nominal=m_flow_nominal,
        eps=0.8,
      dp1_nominal=10,
      dp2_nominal=10,
      allowFlowReversal1=false,
      allowFlowReversal2=false,
      linearizeFlowResistance1=true,
      linearizeFlowResistance2=true,
      m2_flow_nominal=m_flow_nominal_dh)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Buildings.Fluid.HeatExchangers.Heater_T hea(
        redeclare package Medium = Water,
      allowFlowReversal=false,
      dp_nominal=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      m_flow_nominal=m_flow_nominal_dh)
        annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
      Modelica.Blocks.Sources.Constant dhTemp(k=273.15 + 65)
        annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
      Modelica.Blocks.Interfaces.RealOutput qdh "District heating power [W]"
        annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
      Modelica.Blocks.Sources.Constant dhPmpSp(k=1)
        annotation (Placement(transformation(extent={{-10,-48},{10,-28}})));
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloDH(redeclare package
        Medium =
            Water,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal_dh)           annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-50,-38})));
      Buildings.Fluid.Sensors.TemperatureTwoPort tDHRe(redeclare package Medium =
            Water,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal_dh)
        annotation (Placement(transformation(extent={{-26,-16},{-46,4}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort tSu(redeclare package Medium =
            Water, m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)
        annotation (Placement(transformation(extent={{34,-4},{54,16}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Water)
        annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Water)
        annotation (Placement(transformation(extent={{50,90},{70,110}})));
      Buildings.Fluid.Movers.SpeedControlled_y pmp2(
        redeclare package Medium = Water,
        addPowerToMedium=false,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=false,
      redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per(
          pressure(V_flow={0,0.00209948320413,0.00303617571059,0.00389750215332,
              0.0046188630491,0.00546942291128,0.00621231696813,
              0.00695521102498,0.00755813953488}, dp={74298.6885246,
              74154.3248189,73404.0823485,70722.2584827,66879.2916508,
              59372.6282882,49547.6683187,37985.8558902,27964.6709874}), power(
            V_flow={0,0.00209948320413,0.00303617571059,0.00389750215332,
              0.0046188630491,0.00546942291128,0.00621231696813,
              0.00695521102498,0.00755813953488}, P={205.291823945,
              337.504763698,400.584905585,453.68913657,488.040727585,
              515.872422868,528.307902115,531.276246541,523.90128749})))
                                  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-42,38})));
      Modelica.Blocks.Interfaces.RealInput y "Normalized pump speed (indoor loop)"
        annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSu(redeclare package
        Medium =
            Water, m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)                    annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={60,38})));
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal=2
        "Nominal mass flow rate";
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal_dh=5
        "Nominal mass flow rate";
      Buildings.Fluid.Sensors.TemperatureTwoPort tRe(redeclare package Medium =
            Water, m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)                    annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-60,76})));
      Buildings.Fluid.Movers.SpeedControlled_y pmp1(
        redeclare package Medium = Water,
        addPowerToMedium=false,
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=false,
      redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per(
          pressure(V_flow={0,0.00209948320413,0.00303617571059,0.00389750215332,
              0.0046188630491,0.00546942291128,0.00621231696813,
              0.00695521102498,0.00755813953488}, dp={74298.6885246,
              74154.3248189,73404.0823485,70722.2584827,66879.2916508,
              59372.6282882,49547.6683187,37985.8558902,27964.6709874}), power(
            V_flow={0,0.00209948320413,0.00303617571059,0.00389750215332,
              0.0046188630491,0.00546942291128,0.00621231696813,
              0.00695521102498,0.00755813953488}, P={205.291823945,
              337.504763698,400.584905585,453.68913657,488.040727585,
              515.872422868,528.307902115,531.276246541,523.90128749})))
                                  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={38,-38})));
      Buildings.Fluid.Sensors.MassFlowRate senMasFloDH(redeclare package Medium =
            Water, allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-42,-78},{-22,-58}})));
      Buildings.Fluid.Sensors.MassFlowRate senMasFloSu(redeclare package Medium =
            Water, allowFlowReversal=false)
                   annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={60,74})));
      Modelica.Blocks.Interfaces.RealOutput qel
        "Circulation pump electricity consumption [W]"
        annotation (Placement(transformation(extent={{96,50},{116,70}})));
    Buildings.Fluid.Storage.ExpansionVessel exp(V_start=0.3, redeclare package
        Medium = Water) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-80,-20})));
  equation
      connect(hea.TSet, dhTemp.y)
        annotation (Line(points={{-12,-60},{-69,-60}}, color={0,0,127}));
      connect(dhHX.port_b2, tDHRe.port_a)
        annotation (Line(points={{-10,-6},{-26,-6}}, color={0,127,255}));
      connect(tDHRe.port_b, senVolFloDH.port_a) annotation (Line(points={{-46,-6},
              {-50,-6},{-50,-28}}, color={0,127,255}));
      connect(tSu.port_a, dhHX.port_b1)
        annotation (Line(points={{34,6},{10,6}}, color={0,127,255}));
      connect(port_a, port_a)
        annotation (Line(points={{-60,100},{-60,100}}, color={0,127,255}));
      connect(pmp2.port_b, dhHX.port_a1) annotation (Line(points={{-32,38},{-24,38},
              {-24,6},{-10,6}}, color={0,127,255}));
      connect(y, pmp2.y)
        annotation (Line(points={{-110,60},{-42,60},{-42,50}}, color={0,0,127}));
      connect(tSu.port_b, senVolFloSu.port_a)
        annotation (Line(points={{54,6},{60,6},{60,28}}, color={0,127,255}));
      connect(hea.Q_flow, qdh)
        annotation (Line(points={{11,-60},{106,-60}}, color={0,0,127}));
      connect(port_a, tRe.port_a)
        annotation (Line(points={{-60,100},{-60,86}}, color={0,127,255}));
      connect(tRe.port_b, pmp2.port_a)
        annotation (Line(points={{-60,66},{-60,38},{-52,38}}, color={0,127,255}));
      connect(pmp1.port_b, dhHX.port_a2)
        annotation (Line(points={{38,-28},{38,-6},{10,-6}}, color={0,127,255}));
      connect(pmp1.port_a, hea.port_b)
        annotation (Line(points={{38,-48},{38,-68},{10,-68}}, color={0,127,255}));
      connect(pmp1.y, dhPmpSp.y)
        annotation (Line(points={{26,-38},{11,-38}}, color={0,0,127}));
      connect(senVolFloDH.port_b, senMasFloDH.port_a) annotation (Line(points={{
              -50,-48},{-50,-68},{-42,-68}}, color={0,127,255}));
      connect(senMasFloDH.port_b, hea.port_a)
        annotation (Line(points={{-22,-68},{-10,-68}}, color={0,127,255}));
      connect(senVolFloSu.port_b, senMasFloSu.port_a)
        annotation (Line(points={{60,48},{60,64}}, color={0,127,255}));
      connect(senMasFloSu.port_b, port_b)
        annotation (Line(points={{60,84},{60,100}}, color={0,127,255}));
      connect(pmp2.P, qel) annotation (Line(points={{-31,47},{-11.5,47},{-11.5,60},
              {106,60}}, color={0,0,127}));
    connect(exp.port_a, senVolFloDH.port_a) annotation (Line(points={{-70,-20},
            {-50,-20},{-50,-28}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,20},{20,-20}},
              lineColor={238,46,47},
              fillColor={255,255,255},
              fillPattern=FillPattern.Backward),
            Line(points={{18,-4}}, color={28,108,200}),
            Line(points={{20,0},{60,0},{60,90}}, color={238,46,47}),
            Ellipse(extent={{-74,74},{-46,46}}, lineColor={28,108,200}),
            Line(points={{-60,46},{-72,68},{-48,68},{-60,46}}, color={28,108,200}),
            Line(points={{-60,90},{-60,74}}, color={28,108,200}),
            Line(points={{-60,46},{-60,0},{-20,0}}, color={28,108,200}),
            Line(
              points={{0,-20},{0,-60},{96,-60}},
              color={238,46,47},
              pattern=LinePattern.Dash),
            Line(points={{-90,60},{-74,60}}, color={0,0,0})}),       Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=259200),
        __Dymola_experimentSetupOutput);
  end DistrictHeating;

  model Infiltration "Constant infiltration"
      replaceable package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"});
      parameter Modelica.SIunits.Volume Vi "Indoor air volume";
      parameter Real ach=0.2 "Infiltration air changes per hour";
      Buildings.Fluid.Sources.MassFlowSource_WeatherData infiltr(
        redeclare package Medium = Air,
        nPorts=1,
        m_flow=ach*Vi/1.2/3600,
      use_C_in=true)
                  "Infiltration"
        annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloIn(redeclare package
        Medium =
            Air, m_flow_nominal=1,
      allowFlowReversal=false)     annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={30,60})));
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloOut(redeclare package
        Medium =
            Air, m_flow_nominal=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={30,-60})));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
            transformation(extent={{-120,40},{-80,80}}), iconTransformation(extent={{-126,50},
                {-106,70}})));
    Buildings.Fluid.Sources.Outside
                          freshAir(nPorts=1, redeclare package Medium = Air)
      "Boundary condition"
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    Modelica.Blocks.Sources.Constant cCO2(k=0.00064)
      annotation (Placement(transformation(extent={{-26,8},{-46,28}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_b(redeclare package Medium = Air)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_a(redeclare package Medium = Air)
        annotation (Placement(transformation(extent={{90,50},{110,70}})));
  equation
      connect(senVolFloIn.port_a, infiltr.ports[1])
        annotation (Line(points={{20,60},{-26,60}}, color={0,127,255}));
      connect(weaBus, infiltr.weaBus) annotation (Line(
          points={{-100,60},{-72,60},{-72,60.2},{-46,60.2}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
    connect(senVolFloOut.port_b, freshAir.ports[1])
      annotation (Line(points={{20,-60},{-20,-60}}, color={0,127,255}));
    connect(freshAir.weaBus, weaBus) annotation (Line(
        points={{-40,-59.8},{-72,-59.8},{-72,60},{-100,60}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(cCO2.y, infiltr.C_in[1]) annotation (Line(points={{-47,18},{-62,18},
            {-62,52},{-46,52}}, color={0,0,127}));
    connect(senVolFloIn.port_b, port_a)
      annotation (Line(points={{40,60},{100,60}}, color={0,127,255}));
    connect(senVolFloOut.port_a, port_b)
      annotation (Line(points={{40,-60},{100,-60}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-8,80},{8,-80}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-60,20},{-20,0},{20,20},{60,0}},
              color={28,108,200},
              smooth=Smooth.Bezier),
            Line(
              points={{-60,50},{-20,30},{20,50},{60,30}},
              color={28,108,200},
              smooth=Smooth.Bezier),
            Line(
              points={{-60,-10},{-20,-30},{20,-10},{60,-30}},
              color={28,108,200},
              smooth=Smooth.Bezier)}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)));
  end Infiltration;

  model AirHandlingUnit
      Buildings.Fluid.Movers.SpeedControlled_y fanSu(
        addPowerToMedium=false,
        redeclare package Medium = Air,
        redeclare Data.AhuFanx4 per,
      allowFlowReversal=true,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloIn(
                                                   redeclare package Medium = Air,
        m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)
        annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn2(
                                                          redeclare package
        Medium =
            Air,
        m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
        redeclare package Medium1 = Air,
        redeclare package Medium2 = Air,
        allowFlowReversal1=false,
        allowFlowReversal2=false,
        m1_flow_nominal=m_flow_nominal,
        m2_flow_nominal=m_flow_nominal,
        dp1_nominal=150,
        dp2_nominal=150,
      eps=0.75,
      linearizeFlowResistance1=true,
      linearizeFlowResistance2=true)
        annotation (Placement(transformation(extent={{-46,-10},{-66,10}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx1(
                                                          redeclare package
        Medium =
            Air,
        m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-18,30},{-38,50}})));
      Buildings.Fluid.Sensors.VolumeFlowRate senVolFloEx(
                                                   redeclare package Medium = Air,
        allowFlowReversal=false,
        m_flow_nominal=m_flow_nominal)
        annotation (Placement(transformation(extent={{48,30},{28,50}})));
      Buildings.Fluid.Sensors.Pressure senPreIn(redeclare package Medium = Air)
        annotation (Placement(transformation(extent={{132,-40},{152,-20}})));
      Buildings.Fluid.Sensors.Pressure senPreEx(redeclare package Medium = Air)
        annotation (Placement(transformation(extent={{102,40},{122,60}})));
      Buildings.Fluid.Movers.SpeedControlled_y fanEx(
        addPowerToMedium=false,
        redeclare package Medium = Air,
        redeclare Data.AhuFanx4 per,
      allowFlowReversal=true,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
        annotation (Placement(transformation(extent={{20,30},{0,50}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx2(
                                                          redeclare package
        Medium =
            Air,
        allowFlowReversal=false,
        m_flow_nominal=m_flow_nominal)
        annotation (Placement(transformation(extent={{-80,30},{-100,50}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn1(
                                                          redeclare package
        Medium =
            Air,
        m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn3(
                                                          redeclare package
        Medium =
            Air,
        m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)
        annotation (Placement(transformation(extent={{108,-50},{128,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium = Air)
        annotation (Placement(transformation(extent={{150,-50},{170,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium = Air)
        annotation (Placement(transformation(extent={{150,30},{170,50}})));
      Modelica.Blocks.Interfaces.RealInput y annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-60,110})));
      replaceable package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"}) constrainedby
      Modelica.Media.Interfaces.PartialMedium;
      replaceable package Water = Buildings.Media.Water constrainedby
      Modelica.Media.Interfaces.PartialMedium;
      Modelica.Blocks.Interfaces.RealOutput qel annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-100,-106})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-60,-84},{-80,-64}})));
      Buildings.Fluid.Sources.Outside outEx(nPorts=1, redeclare package Medium =
            Air,
      use_C_in=true)
        annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
      Buildings.Fluid.Sources.Outside outSu(nPorts=1, redeclare package Medium =
            Air,
      use_C_in=true)
        annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
            transformation(extent={{-180,-22},{-140,18}}), iconTransformation(
              extent={{-200,104},{-180,124}})));
      Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex1(redeclare
        package Medium1 =
                    Air,
        redeclare package Medium2 = Water,
        m1_flow_nominal=m_flow_nominal,
        m2_flow_nominal=m2_flow_nominal,
      allowFlowReversal1=false,
      allowFlowReversal2=false,
      dp1_nominal=500,
      linearizeFlowResistance1=true,
      linearizeFlowResistance2=true,
      eps=0.999,
      dp2_nominal=500)
        annotation (Placement(transformation(extent={{48,-56},{68,-36}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
            Water)
        annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
            Water)
        annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal=20
        "Nominal mass flow rate - air";
      parameter Modelica.SIunits.MassFlowRate m2_flow_nominal=2
        "Nominal mass flow rate - water";
      Modelica.Blocks.Interfaces.RealOutput Tsu annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={166,-80})));
    Modelica.Blocks.Sources.Constant cCO2(k=0.00064)
      annotation (Placement(transformation(extent={{-98,-10},{-118,10}})));
    Buildings.Fluid.FixedResistances.PressureDrop resEx(
      redeclare package Medium = Air,
      m_flow_nominal=46.7,
      dp_nominal=2500,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{90,30},{70,50}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemCoilIn(
      allowFlowReversal=false,
      redeclare package Medium = Water,
      m_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{94,-82},{74,-62}})));
    Buildings.Utilities.IO.SignalExchange.Overwrite oveFanRet(description=
          "AHU return fan speed control signal", u(
        min=0,
        max=1,
        unit="1")) "Overwirte for return fan speed control signal"
      annotation (Placement(transformation(extent={{-46,62},{-26,82}})));
    Buildings.Utilities.IO.SignalExchange.Overwrite oveFanSup(description=
          "AHU supply fan speed control signal", u(
        min=0,
        max=1,
        unit="1")) "Overwrite for supply fan speed control signal" annotation (
        Placement(transformation(
          extent={{8,-8},{-8,8}},
          rotation=90,
          origin={-60,52})));
    Buildings.Utilities.IO.SignalExchange.Read reaTSupAir(
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="K"),
      description="AHU supply air temperature") "Read supply air temperature"
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=90,
          origin={131,-65})));

    Buildings.Utilities.IO.SignalExchange.Read reaTRetAir(
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="K"),
      description="AHU return air temperature") "Read returrn air temperature"
      annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={42,72})));

    Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
          Air)
      annotation (Placement(transformation(extent={{76,-52},{96,-32}})));
    Buildings.Utilities.IO.SignalExchange.Read reaFloSupAir(
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="kg/s"),
      description="AHU supply air mass flowrate")
      "Read supply air mass flow rate" annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={98,2})));

    Buildings.Utilities.IO.SignalExchange.Read reaPFanSup(
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="W"),
      description="AHU supply fan electrical power consumption")
      "Read supply fan power consumption" annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=180,
          origin={-24,-80})));

    Buildings.Utilities.IO.SignalExchange.Read reaPFanRet(
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="W"),
      description="AHU return fan electrical power consumption")
      "Read return fan power consumption" annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=180,
          origin={-28,-18})));

    Buildings.Utilities.IO.SignalExchange.Read reaTCoiSup(
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="K"),
      description="AHU heating coil supply water temperature")
      "Read heating coil supply water temperature" annotation (Placement(
          transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={120,-90})));

    Buildings.Utilities.IO.SignalExchange.Read reaTHeaRec(
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="K"),
      description=
          "AHU air temperature exiting heat recovery in supply air stream")
      "Read air temperature exiting heat recovery in supply air stream"
      annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={20,-14})));

  equation
      connect(fanSu.port_b, senVolFloIn.port_a)
        annotation (Line(points={{10,-40},{20,-40}}, color={0,127,255}));
      connect(fanSu.port_a, senTemIn2.port_b)
        annotation (Line(points={{-10,-40},{-16,-40}}, color={0,127,255}));
      connect(senTemIn2.port_a, hex.port_b2) annotation (Line(points={{-36,-40},{
              -40,-40},{-40,-6},{-46,-6}}, color={0,127,255}));
      connect(senTemEx1.port_b, hex.port_a1) annotation (Line(points={{-38,40},
            {-44,40},{-44,6},{-46,6}},  color={0,127,255}));
      connect(senVolFloEx.port_b, fanEx.port_a)
        annotation (Line(points={{28,40},{20,40}}, color={0,127,255}));
      connect(fanEx.port_b, senTemEx1.port_a)
        annotation (Line(points={{0,40},{-18,40}}, color={0,127,255}));
      connect(hex.port_b1, senTemEx2.port_a) annotation (Line(points={{-66,6},{
              -72,6},{-72,40},{-80,40}}, color={0,127,255}));
      connect(hex.port_a2, senTemIn1.port_b) annotation (Line(points={{-66,-6},{-72,
              -6},{-72,-40},{-80,-40}},     color={0,127,255}));
      connect(senPreIn.port, senTemIn3.port_b)
        annotation (Line(points={{142,-40},{128,-40}}, color={0,127,255}));
      connect(port_b1, port_b1)
        annotation (Line(points={{160,-40},{160,-40}}, color={0,127,255}));
      connect(senPreEx.port, port_a1)
        annotation (Line(points={{112,40},{160,40}}, color={0,127,255}));
      connect(senPreIn.port, port_b1) annotation (Line(points={{142,-40},{160,-40}},
                                    color={0,127,255}));
      connect(add.y, qel) annotation (Line(points={{-81,-74},{-100,-74},{-100,-106}},
            color={0,0,127}));
      connect(senTemEx2.port_b, outEx.ports[1])
        annotation (Line(points={{-100,40},{-120,40}}, color={0,127,255}));
      connect(senTemIn1.port_a, outSu.ports[1])
        annotation (Line(points={{-100,-40},{-120,-40}}, color={0,127,255}));
      connect(weaBus, outEx.weaBus) annotation (Line(
          points={{-160,-2},{-150,-2},{-150,4},{-140,4},{-140,40.2}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(weaBus, outSu.weaBus) annotation (Line(
          points={{-160,-2},{-150,-2},{-150,-6},{-140,-6},{-140,-39.8}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(senVolFloIn.port_b, hex1.port_a1)
        annotation (Line(points={{40,-40},{48,-40}}, color={0,127,255}));
    connect(cCO2.y, outEx.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
            32},{-142,32}}, color={0,0,127}));
    connect(cCO2.y, outSu.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
            -48},{-142,-48}}, color={0,0,127}));
    connect(senVolFloEx.port_a, resEx.port_b)
      annotation (Line(points={{48,40},{70,40}}, color={0,127,255}));
    connect(resEx.port_a, senPreEx.port)
      annotation (Line(points={{90,40},{112,40}}, color={0,127,255}));
    connect(port_a2, senTemCoilIn.port_a) annotation (Line(points={{100,-100},{100,
            -72},{94,-72}}, color={0,127,255}));
    connect(senTemCoilIn.port_b, hex1.port_a2)
      annotation (Line(points={{74,-72},{68,-72},{68,-52}}, color={0,127,255}));
    connect(oveFanRet.u, y)
      annotation (Line(points={{-48,72},{-60,72},{-60,110}}, color={0,0,127}));
    connect(y, oveFanSup.u)
      annotation (Line(points={{-60,110},{-60,61.6}}, color={0,0,127}));
    connect(senTemIn3.T, reaTSupAir.u) annotation (Line(points={{118,-29},{118,
            -20},{131,-20},{131,-56.6}}, color={0,0,127}));
    connect(reaTSupAir.y, Tsu) annotation (Line(points={{131,-72.7},{131,-80},{
            166,-80}}, color={0,0,127}));
    connect(senTemEx1.T, reaTRetAir.u) annotation (Line(points={{-28,51},{-28,
            58},{16,58},{16,72},{34.8,72}}, color={0,0,127}));
    connect(hex1.port_b1, senMasFlo.port_a)
      annotation (Line(points={{68,-40},{72,-40},{72,-42},{76,-42}},
                                                   color={0,127,255}));
    connect(senMasFlo.port_b, senTemIn3.port_a)
      annotation (Line(points={{96,-42},{102,-42},{102,-40},{108,-40}},
                                                    color={0,127,255}));
    connect(senMasFlo.m_flow, reaFloSupAir.u)
      annotation (Line(points={{86,-31},{86,2},{90.8,2}}, color={0,0,127}));
    connect(fanSu.P, reaPFanSup.u) annotation (Line(points={{11,-31},{15.5,-31},
            {15.5,-80},{-16.8,-80}}, color={0,0,127}));
    connect(reaPFanSup.y, add.u2)
      annotation (Line(points={{-30.6,-80},{-58,-80}}, color={0,0,127}));
    connect(fanEx.P, reaPFanRet.u) annotation (Line(points={{-1,49},{-1,50},{
            -10,50},{-10,-18},{-20.8,-18}}, color={0,0,127}));
    connect(reaPFanRet.y, add.u1) annotation (Line(points={{-34.6,-18},{-48,-18},
            {-48,-68},{-58,-68}}, color={0,0,127}));
    connect(senTemCoilIn.T, reaTCoiSup.u) annotation (Line(points={{84,-61},{92,
            -61},{92,-60},{106,-60},{106,-90},{112.8,-90}}, color={0,0,127}));
    connect(hex1.port_b2, port_b2) annotation (Line(points={{48,-52},{40,-52},{
            40,-100}}, color={0,127,255}));
    connect(senTemIn2.T, reaTHeaRec.u) annotation (Line(points={{-26,-29},{-26,
            -26},{-6,-26},{-6,-14},{12.8,-14}}, color={0,0,127}));
    connect(oveFanRet.y, fanEx.y)
      annotation (Line(points={{-25,72},{10,72},{10,52}}, color={0,0,127}));
    connect(oveFanSup.y, fanSu.y) annotation (Line(points={{-60,43.2},{-60,20},
            {0,20},{0,-28}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                -100},{160,100}}), graphics={
            Rectangle(
              extent={{-160,100},{160,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-20,60},{20,20}}, lineColor={28,108,200}),
            Line(points={{12,56},{12,24},{-20,40},{12,56}}, color={28,108,200}),
            Ellipse(extent={{-20,-20},{20,-60}}, lineColor={28,108,200}),
            Line(points={{-12,-24},{-12,-56},{20,-40},{-12,-24}}, color={28,108,200}),
            Line(points={{20,-40},{150,-40}}, color={28,108,200}),
            Line(points={{-20,-40},{-150,-40}}, color={28,108,200}),
            Line(points={{-150,40},{-20,40}}, color={28,108,200}),
            Line(points={{20,40},{150,40}}, color={28,108,200}),
            Line(points={{-82,40},{-122,-40}}, color={28,108,200}),
            Line(points={{-122,40},{-82,-40}}, color={28,108,200}),
            Rectangle(
              extent={{62,-20},{82,-60}},
              lineColor={28,108,200},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Line(points={{0,72},{0,60}}, color={0,0,0}),
            Line(points={{-60,90},{-60,-10},{0,-10},{0,-20}},
                                                          color={0,0,0}),
            Line(points={{0,72},{-60,72}}, color={0,0,0}),
            Line(
              points={{2,-60},{2,-74},{-100,-74},{-100,-96}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(
              points={{0,20},{0,12},{-40,12},{-40,-74}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(points={{-150,44},{-150,36}}, color={28,108,200}),
            Line(points={{-150,-36},{-150,-44}}, color={28,108,200}),
            Line(points={{100,-90},{100,-54},{82,-54}}, color={238,46,47}),
            Line(points={{62,-54},{40,-54},{40,-90}}, color={28,108,200}),
            Line(
              points={{156,-80},{130,-80},{130,-40}},
              color={0,140,72},
              pattern=LinePattern.Dash)}),
                                    Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-160,-100},{160,100}})));
  end AirHandlingUnit;

  model EnergyMeter
      replaceable package Water = Buildings.Media.Water;
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemRe(m_flow_nominal=
            m_flow_nominal, redeclare package Medium = Water,
      allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-60,50},{-80,70}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemSu(redeclare package
        Medium =   Water, m_flow_nominal=m_flow_nominal,
      allowFlowReversal=false)
        annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
      Buildings.Fluid.Sensors.MassFlowRate senMasFloSu(redeclare package Medium =
            Water, allowFlowReversal=false)
        annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Water) "Supply fluid inlet port"
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Water) "Supply fluid outlet port"
        annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
            Water) "Return fluid inlet port"
        annotation (Placement(transformation(extent={{90,50},{110,70}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
            Water) "Return fluid outlet port"
        annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.1
        "Nominal mass flow rate, used for regularization near zero flow";
      Modelica.Blocks.Math.Add add(k1=-1, k2=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=Water.cp_const)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
        annotation (Placement(transformation(extent={{10,-6},{22,6}})));
      Modelica.Blocks.Interfaces.RealOutput q
        "Heat flow [W] (positive for supply fluid hotter than return)"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,106})));
  equation
      connect(port_a, senTemSu.port_a)
        annotation (Line(points={{-100,-60},{-80,-60}}, color={0,127,255}));
      connect(senTemSu.port_b, senMasFloSu.port_a)
        annotation (Line(points={{-60,-60},{40,-60}}, color={0,127,255}));
      connect(senMasFloSu.port_b, port_b)
        annotation (Line(points={{60,-60},{100,-60}}, color={0,127,255}));
      connect(senTemRe.port_a, port_a2)
        annotation (Line(points={{-60,60},{100,60}}, color={0,127,255}));
      connect(senTemRe.port_b, port_b2)
        annotation (Line(points={{-80,60},{-100,60}}, color={0,127,255}));
      connect(senTemRe.T, add.u1) annotation (Line(points={{-70,71},{-48,71},{-48,
              6},{-42,6}}, color={0,0,127}));
      connect(senTemSu.T, add.u2)
        annotation (Line(points={{-70,-49},{-70,-6},{-42,-6}}, color={0,0,127}));
      connect(realExpression.y, multiProduct.u[1]) annotation (Line(points={{-19,
              30},{-4,30},{-4,2.8},{10,2.8}}, color={0,0,127}));
      connect(add.y, multiProduct.u[2]) annotation (Line(points={{-19,0},{6,0},{6,
              2.22045e-16},{10,2.22045e-16}}, color={0,0,127}));
      connect(senMasFloSu.m_flow, multiProduct.u[3]) annotation (Line(points={{50,
              -49},{-4,-49},{-4,-2.8},{10,-2.8}}, color={0,0,127}));
      connect(multiProduct.y, q) annotation (Line(points={{23.02,0},{40,0},{40,80},
              {0,80},{0,106}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-90,-60},{90,-60}},
              color={238,46,47},
              thickness=0.5),
            Line(
              points={{90,60},{-90,60}},
              color={28,108,200},
              thickness=0.5),
            Line(points={{0,-60},{0,96}}, color={0,0,0}),
            Ellipse(
              extent={{-20,20},{20,-20}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{10,10},{-10,-12}}, color={0,0,0}),
            Line(points={{10,10},{8,4}}, color={0,0,0}),
            Line(points={{10,10},{4,8}}, color={0,0,0})}),           Diagram(
            coordinateSystem(preserveAspectRatio=false)));
  end EnergyMeter;

AirHandlingUnit ahu(
    redeclare package Air = Air,
    m_flow_nominal=m_flow_nominal_air,
    m2_flow_nominal=m_flow_nominal_water,
    redeclare package Water = Water) "Air handling unit"
    annotation (Placement(transformation(extent={{-152,34},{-120,54}})));
  Buildings.ThermalZones.Detailed.MixedAir ou44Bdg(
    nConPar=0,
    nSurBou=0,
    nConBou=2,
    datConBou(
      layers={floor,extWall},
      A={87*29,3.97*87*2 + 3.97*29*2},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall},
      each azi=Buildings.Types.Azimuth.S,
      each stateAtSurface_a=false),
    datConExt(
      layers={roof},
      A={87*29},
      til={Buildings.Types.Tilt.Ceiling},
      azi={Buildings.Types.Azimuth.W}),
    nConExt=1,
    nConExtWin=4,
    redeclare package Medium = Air,
    AFlo=AFlo,
    hRoo=hRoo,
    datConExtWin(
      each layers=extWall,
      A={29*13,87*13,29*13,87*13},
      each glaSys=glaSys,
      hWin={11.9,2.4*3,11.9,2.4*3},
      wWin={16.8,70,16.8,70},
      each til=Buildings.Types.Tilt.Wall,
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.S,
          Buildings.Types.Azimuth.E}),
    use_C_flow=true,
    nPorts=5,
    C_start={0.00064},
    linearizeRadiation=true,
    lat=0.96697872811643,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-18,36},{22,76}})));
final parameter Buildings.HeatTransfer.Data.GlazingSystems.TripleClearAir13ClearAir13Clear
  glaSys(haveExteriorShade=true, shade=blinds)
         annotation (Placement(transformation(extent={{204,166},{224,186}})));
final parameter Buildings.HeatTransfer.Data.Solids.Generic insulation(
  x=0.27,
  k=0.04,
  c=1000,
  d=50)
  annotation (Placement(transformation(extent={{92,166},{112,186}})));
final parameter Buildings.HeatTransfer.Data.Solids.Concrete concrete(x=0.2)
  annotation (Placement(transformation(extent={{120,166},{140,186}})));
final parameter Buildings.HeatTransfer.Data.Solids.Generic lightPartition(
  c=1000,
  k=0.5,
  x=0.15,
  d=250)
  annotation (Placement(transformation(extent={{64,166},{84,186}})));
final parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic extWall(
  nLay=2,
  material={insulation,concrete},
  roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium)
  annotation (Placement(transformation(extent={{148,192},{168,212}})));
final parameter Buildings.HeatTransfer.Data.Solids.Generic insulationRoof(
  k=0.04,
  c=1000,
  x=0.52,
  d=50)
  annotation (Placement(transformation(extent={{92,192},{112,212}})));
final parameter Buildings.HeatTransfer.Data.Solids.Concrete concreteRoof(x=0.27)
  annotation (Placement(transformation(extent={{120,192},{140,212}})));
final parameter Buildings.HeatTransfer.Data.Solids.Concrete concreteFloor(x=0.2)
  annotation (Placement(transformation(extent={{64,192},{84,212}})));
final parameter Buildings.HeatTransfer.Data.Shades.Generic blinds(
  tauSol_a=0.05,
  tauSol_b=0.05,
  rhoSol_a=0.5,
  rhoSol_b=0.5,
  absIR_a=0.5,
  absIR_b=0.5,
  tauIR_a=0,
  tauIR_b=0)
  annotation (Placement(transformation(extent={{204,192},{224,212}})));
Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "OU44Emulator/Resources/Climate/DNK_Copenhagen.061800_IWEC.mos"))
  annotation (Placement(transformation(extent={{110,80},{90,100}})));
Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
      transformation(extent={{18,70},{58,110}}),iconTransformation(extent={{-160,
          110},{-140,130}})));
Modelica.Blocks.Math.MatrixGain matrixGain(K=[0.4; 0.4; 0.2])
  "Splits heat gains into radiant, convective and latent"
  annotation (Placement(transformation(extent={{-66,136},{-50,152}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tFloorGround
  annotation (Placement(transformation(extent={{40,8},{20,28}})));
Modelica.Blocks.Sources.Constant const5(k=283.15)
  annotation (Placement(transformation(extent={{72,8},{52,28}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tWallGround
  annotation (Placement(transformation(extent={{40,-28},{20,-8}})));
Modelica.Blocks.Sources.Constant const4(k=283.15)
  annotation (Placement(transformation(extent={{72,-28},{52,-8}})));
Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Ti
  annotation (Placement(transformation(extent={{34,46},{54,66}})));
DistrictHeating districtHeating(m_flow_nominal=2, m_flow_nominal_dh=5)
  annotation (Placement(transformation(extent={{-142,-212},{-122,-192}})));
Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
  redeclare package Medium = Water,
    allowFlowReversal=false,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    Q_flow_nominal=40*AFlo,
    dp_nominal=20000,
    T_start=293.15,
    T_a_nominal=328.15,
    T_b_nominal=318.15)
  annotation (Placement(transformation(extent={{-14,-92},{6,-72}})));
Buildings.Fluid.Actuators.Valves.ThreeWayLinear valRad(
  redeclare package Medium = Water,
  CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
  m_flow_nominal=m_flow_nominal_water,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dpValve_nominal=10,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    linearized={true,true})
  annotation (Placement(transformation(extent={{-68,-92},{-48,-72}})));
Buildings.Fluid.Sensors.TemperatureTwoPort tRadIn(redeclare package Medium =
      Water, m_flow_nominal=m_flow_nominal_water,
    allowFlowReversal=false)
  annotation (Placement(transformation(extent={{-40,-92},{-20,-72}})));
Buildings.Fluid.Sensors.TemperatureTwoPort tRadOut(redeclare package Medium =
      Water, m_flow_nominal=m_flow_nominal_water,
    allowFlowReversal=false)
  annotation (Placement(transformation(extent={{-20,-132},{-40,-112}})));
Infiltration infiltration(
  redeclare package Air = Air,
  Vi=AFlo*hRoo,
    ach=0.2)
            annotation (Placement(transformation(extent={{-80,14},{-60,34}})));
Buildings.Fluid.FixedResistances.Junction jun1(
  redeclare package Medium = Water,
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  m_flow_nominal={m_flow_nominal_water,-m_flow_nominal_water,
      m_flow_nominal_water},
  dp_nominal={5,0,5},
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
  annotation (Placement(transformation(
      extent={{10,10},{-10,-10}},
      rotation=0,
      origin={-58,-122})));
Buildings.Fluid.FixedResistances.Junction jun2(
  redeclare package Medium = Water,
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  m_flow_nominal={m_flow_nominal_water,-m_flow_nominal_water,-
      m_flow_nominal_water},
  dp_nominal={5,0,5},
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
                      annotation (Placement(transformation(
      extent={{10,10},{-10,-10}},
      rotation=-90,
      origin={-126,-84})));
Buildings.Fluid.FixedResistances.Junction jun3(
  redeclare package Medium = Water,
  dp_nominal={5,0,5},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  m_flow_nominal={m_flow_nominal_water,-m_flow_nominal_water,
      m_flow_nominal_water},
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
  annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=-90,
      origin={-152,-108})));
EnergyMeter energyMeterAhu(m_flow_nominal=m_flow_nominal_water, redeclare
      package Water=Water) annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-132,-58})));
EnergyMeter energyMeterRad(m_flow_nominal=m_flow_nominal_water, redeclare
      package Water=Water) annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=0,
      origin={-96,-102})));
EnergyMeter energyMeterMain(m_flow_nominal=m_flow_nominal_water, redeclare
      package Water=Water)  annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-132,-170})));
Buildings.Fluid.Actuators.Valves.ThreeWayLinear valCoil(
  redeclare package Medium = Water,
  CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
  m_flow_nominal=m_flow_nominal_water,
    dpValve_nominal=10,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    linearized={true,true})
                     annotation (Placement(transformation(
      extent={{10,-10},{-10,10}},
      rotation=270,
      origin={-126,-8})));
Buildings.Fluid.FixedResistances.Junction jun4(
  redeclare package Medium = Water,
  dp_nominal={5,0,5},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
  m_flow_nominal={m_flow_nominal_water,-m_flow_nominal_water,
      m_flow_nominal_water},
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
  annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=-90,
      origin={-152,-8})));
Modelica.Blocks.Math.Gain metHeat(k=120/AFlo)
  "Metabolic heat generation per person (sensible and latent)"
  annotation (Placement(transformation(extent={{-104,136},{-88,152}})));
final parameter Buildings.HeatTransfer.Data.Solids.Generic insulationFloor(
  k=0.04,
  c=1000,
  x=0.15,
  d=50) annotation (Placement(transformation(extent={{36,192},{56,212}})));
  Modelica.Blocks.Math.Gain scale_factor(k=2)
    "scale factor for CO2 concentration "
    annotation (Placement(transformation(extent={{-64,104},{-48,120}})));
  Buildings.Fluid.Sensors.PPM senCO2(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{-46,56},{-66,76}})));
  Modelica.Blocks.Continuous.Integrator Qh_coil(k=2.7778E-7) "Output in kWh"
    annotation (Placement(transformation(extent={{80,-150},{100,-130}})));
  Modelica.Blocks.Continuous.Integrator Qh_rad(k=2.7778E-7) "Output in kWh"
    annotation (Placement(transformation(extent={{80,-182},{100,-162}})));
  Modelica.Blocks.Continuous.Integrator Qh_tot(k=2.7778E-7) "Output in kWh"
    annotation (Placement(transformation(extent={{80,-226},{100,-206}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemOut(redeclare package Medium =
        Air, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Blocks.Math.Gain gaiCO2(k=8.18E-6) "CO2 emission per person"
    annotation (Placement(transformation(extent={{-104,104},{-88,120}})));
  Buildings.Fluid.Storage.ExpansionVessel exp(redeclare package Medium = Water,
      V_start=0.025)
    annotation (Placement(transformation(extent={{32,-78},{52,-58}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic floor(nLay=2,
      material={insulationFloor,concreteFloor})
    annotation (Placement(transformation(extent={{148,166},{168,186}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic roof(
    nLay=2,
    material={insulationRoof,concreteRoof},
    roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Medium)
    annotation (Placement(transformation(extent={{176,192},{196,212}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic intWall(
      material={lightPartition}, nLay=1)
    annotation (Placement(transformation(extent={{178,166},{198,186}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemCoiRet(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=m_flow_nominal_water)
    "Sensor for AHU heating coil return water temperature" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-152,-32})));
equation
connect(weaBus, ou44Bdg.weaBus) annotation (Line(
    points={{38,90},{38,73.9},{19.9,73.9}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
connect(matrixGain.y, ou44Bdg.qGai_flow) annotation (Line(points={{-49.2,144},{
          -36,144},{-36,64},{-19.6,64}},
                                   color={0,0,127}));
connect(weaBus, weaDat.weaBus) annotation (Line(
    points={{38,90},{90,90}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
connect(tFloorGround.port, ou44Bdg.surf_conBou[1])
  annotation (Line(points={{20,18},{8,18},{8,39.5}},      color={191,0,0}));
connect(const5.y, tFloorGround.T)
  annotation (Line(points={{51,18},{42,18}},     color={0,0,127}));
connect(const4.y, tWallGround.T)
  annotation (Line(points={{51,-18},{42,-18}},     color={0,0,127}));
connect(tWallGround.port, ou44Bdg.surf_conBou[2]) annotation (Line(points={{20,-18},
        {8,-18},{8,40.5}},              color={191,0,0}));
connect(Ti.port, ou44Bdg.heaPorAir) annotation (Line(points={{34,56},{1,56}},
                            color={191,0,0}));
connect(rad.heatPortRad, ou44Bdg.heaPorRad) annotation (Line(points={{-2,-74.8},
        {-2,-60},{2,-60},{2,52.2},{1,52.2}}, color={191,0,0}));
connect(rad.heatPortCon, ou44Bdg.heaPorAir)
  annotation (Line(points={{-6,-74.8},{-6,56},{1,56}}, color={191,0,0}));
connect(valRad.port_2, tRadIn.port_a)
  annotation (Line(points={{-48,-82},{-40,-82}}, color={0,127,255}));
connect(tRadIn.port_b, rad.port_a)
  annotation (Line(points={{-20,-82},{-14,-82}}, color={0,127,255}));
connect(weaBus, infiltration.weaBus) annotation (Line(
    points={{38,90},{-162,90},{-162,30},{-81.6,30}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(ahu.weaBus, weaBus) annotation (Line(
      points={{-155,55.4},{-162,55.4},{-162,90},{38,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
connect(jun1.port_3, valRad.port_3)
  annotation (Line(points={{-58,-112},{-58,-92}}, color={0,127,255}));
connect(jun1.port_1, tRadOut.port_b)
  annotation (Line(points={{-48,-122},{-40,-122}}, color={0,127,255}));
connect(jun2.port_2, energyMeterAhu.port_a)
  annotation (Line(points={{-126,-74},{-126,-68}}, color={0,127,255}));
connect(energyMeterAhu.port_b2, jun3.port_1) annotation (Line(points={{-138,-68},
          {-138,-72},{-152,-72},{-152,-98}},
                                           color={0,127,255}));
connect(jun2.port_3, energyMeterRad.port_a) annotation (Line(points={{-116,-84},
          {-112,-84},{-112,-96},{-106,-96}},
                                           color={0,127,255}));
connect(valRad.port_1, energyMeterRad.port_b) annotation (Line(points={{-68,-82},
          {-76,-82},{-76,-96},{-86,-96}},
                                        color={0,127,255}));
connect(jun1.port_2, energyMeterRad.port_a2) annotation (Line(points={{-68,-122},
          {-76,-122},{-76,-108},{-86,-108}},
                                           color={0,127,255}));
connect(energyMeterRad.port_b2, jun3.port_3)
  annotation (Line(points={{-106,-108},{-142,-108}}, color={0,127,255}));
connect(districtHeating.port_b, energyMeterMain.port_a)
  annotation (Line(points={{-126,-192},{-126,-180}}, color={0,127,255}));
connect(jun3.port_2, energyMeterMain.port_a2) annotation (Line(points={{-152,-118},
        {-152,-124},{-138,-124},{-138,-160}}, color={0,127,255}));
connect(energyMeterMain.port_b2, districtHeating.port_a)
  annotation (Line(points={{-138,-180},{-138,-192}}, color={0,127,255}));
connect(energyMeterAhu.port_b,valCoil. port_1)
  annotation (Line(points={{-126,-48},{-126,-18}}, color={0,127,255}));
connect(valCoil.port_3, jun4.port_3)
  annotation (Line(points={{-136,-8},{-142,-8}}, color={0,127,255}));
  connect(ahu.port_b2, jun4.port_1) annotation (Line(points={{-132,34},{-132,28},
          {-152,28},{-152,2}}, color={0,127,255}));
  connect(ahu.port_a2, valCoil.port_2)
    annotation (Line(points={{-126,34},{-126,2}}, color={0,127,255}));
connect(matrixGain.u[1], metHeat.y)
  annotation (Line(points={{-67.6,144},{-87.2,144}},
                                                 color={0,0,127}));
  connect(scale_factor.y, ou44Bdg.C_flow[1]) annotation (Line(points={{-47.2,
          112},{-42,112},{-42,58.8},{-19.6,58.8}},
                                              color={0,0,127}));
  connect(infiltration.port_a, ou44Bdg.ports[1]) annotation (Line(points={{-60,30},
          {-16,30},{-16,42.8},{-13,42.8}}, color={0,127,255}));
  connect(ahu.port_b1, ou44Bdg.ports[2]) annotation (Line(points={{-120,40},{-66,
          40},{-66,44.4},{-13,44.4}}, color={0,127,255}));
  connect(ahu.port_a1, ou44Bdg.ports[3]) annotation (Line(points={{-120,48},{-66,
          48},{-66,46},{-13,46}}, color={0,127,255}));
  connect(senCO2.port, ou44Bdg.ports[4]) annotation (Line(points={{-56,56},{-56,
          47.6},{-13,47.6}}, color={0,127,255}));
  connect(energyMeterRad.q, Qh_rad.u) annotation (Line(points={{-96,-112.6},{-96,
          -172},{78,-172}}, color={0,0,127}));
  connect(energyMeterAhu.q, Qh_coil.u) annotation (Line(points={{-142.6,-58},{
          -148,-58},{-148,-70},{-80,-70},{-80,-140},{78,-140}},
                                                           color={0,0,127}));
  connect(infiltration.port_b, senTemOut.port_a) annotation (Line(points={{-60,
          18},{-56,18},{-56,30},{-50,30}}, color={0,127,255}));
  connect(senTemOut.port_b, ou44Bdg.ports[5]) annotation (Line(points={{-30,30},
          {-18,30},{-18,49.2},{-13,49.2}}, color={0,127,255}));
  connect(energyMeterMain.port_b, jun2.port_1)
    annotation (Line(points={{-126,-160},{-126,-94}}, color={0,127,255}));
  connect(gaiCO2.y, scale_factor.u)
    annotation (Line(points={{-87.2,112},{-65.6,112}},
                                                   color={0,0,127}));
  connect(rad.port_b, tRadOut.port_a) annotation (Line(points={{6,-82},{48,-82},
          {48,-122},{-20,-122}}, color={0,127,255}));
  connect(exp.port_a, tRadOut.port_a) annotation (Line(points={{42,-78},{42,-82},
          {48,-82},{48,-122},{-20,-122}}, color={0,127,255}));
  connect(jun4.port_2, senTemCoiRet.port_a)
    annotation (Line(points={{-152,-18},{-152,-22}}, color={0,127,255}));
  connect(senTemCoiRet.port_b, energyMeterAhu.port_a2) annotation (Line(points=
          {{-152,-42},{-152,-44},{-138,-44},{-138,-48}}, color={0,127,255}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-240},
            {240,220}}),     graphics={Bitmap(
        extent={{-160,-162},{178,180}}, fileName=
              "modelica://OU44Emulator/Resources/Images/ou44.jpg")}),
                                                               Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-240,-240},{240,220}})),
  experiment(StopTime=259200));
end BuildingBase;
