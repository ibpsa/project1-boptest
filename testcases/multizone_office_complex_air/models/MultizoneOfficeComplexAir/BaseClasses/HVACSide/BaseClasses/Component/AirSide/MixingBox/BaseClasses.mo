within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox;
package BaseClasses

  model MixingBox
    replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium                          "Medium for the fluid";
    parameter Modelica.Units.SI.Pressure PreDro "Pressure drop in the air side";
    parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat
      "mass flow rate for fresh air";
    parameter Modelica.Units.SI.MassFlowRate mTotAirFloRat
      "mass flow rate for water";

    Buildings.Fluid.FixedResistances.Junction jun(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      redeclare package Medium = Medium,
      from_dp=false,
      m_flow_nominal={mTotAirFloRat,mFreAirFloRat,-mTotAirFloRat + mFreAirFloRat},
      dp_nominal={PreDro/4,PreDro/4,PreDro/4},
      linearized=true)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-70,-12})));

    Buildings.Fluid.FixedResistances.Junction jun1(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      redeclare package Medium = Medium,
      from_dp=false,
      m_flow_nominal={mFreAirFloRat,mTotAirFloRat,mTotAirFloRat - mFreAirFloRat},
      dp_nominal={PreDro/4,PreDro/4,PreDro/4},
      linearized=true)
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=90,
          origin={60,-12})));

    Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package Medium = Medium)
      "First port, typically inlet"                                              annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package Medium = Medium)
      "Second port, typically outlet"                                              annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
    replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valExh(
      redeclare package Medium = Medium,
      m_flow_nominal=mFreAirFloRat,
      dpValve_nominal=PreDro/2)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-70,58})));
    replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valFre(
      redeclare package Medium = Medium,
      m_flow_nominal=mFreAirFloRat,
      dpValve_nominal=PreDro/2)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={60,54})));
    Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium = Medium)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_Fre(redeclare package Medium = Medium)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{50,90},{70,110}})));
    replaceable Buildings.Fluid.Sensors.TemperatureTwoPort TOutSen(
        redeclare package Medium = Medium, m_flow_nominal=mFreAirFloRat)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={60,82})));
    replaceable Buildings.Fluid.Sensors.TemperatureTwoPort TMix(
        redeclare package Medium = Medium, m_flow_nominal=mTotAirFloRat)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={60,-42})));
    Modelica.Fluid.Sensors.TemperatureTwoPort TRet(redeclare package Medium =
                 Medium) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-70,-50})));
    Modelica.Fluid.Sensors.MassFlowRate m_flowAir(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={60,20})));
    Modelica.Blocks.Interfaces.RealInput damPos "Actuator position (0: closed, 1: open)"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Fluid.Sensors.MassFlowRate m_flowSupAir(redeclare package Medium
        =        Medium) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={60,-72})));
    Modelica.Blocks.Interfaces.RealOutput T "Temperature of the passing fluid"
      annotation (Placement(transformation(extent={{100,-52},{120,-32}})));
    Modelica.Blocks.Interfaces.RealOutput TOut "Temperature of the passing fluid"
      annotation (Placement(transformation(extent={{100,72},{120,92}})));
    replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valRet(
      redeclare package Medium = Medium,
      dpValve_nominal=PreDro/2,
      m_flow_nominal=mTotAirFloRat - mFreAirFloRat)
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={0,-12})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=1 -damPos)
      annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
    Buildings.Utilities.IO.SignalExchange.Overwrite yOA(description=
          "Outside air damper position setpoint for AHU", u(
        unit="1",
        min=0,
        max=1)) "Outside air damper position setpoint"
      annotation (Placement(transformation(extent={{0,44},{20,64}})));
    Buildings.Utilities.IO.SignalExchange.Overwrite yRet(description=
          "Return air damper position setpoint for AHU", u(
        unit="1",
        min=0,
        max=1)) "Return air damper position setpoint"
      annotation (Placement(transformation(extent={{-28,10},{-8,30}})));
    Buildings.Utilities.IO.SignalExchange.Overwrite yEA(description=
          "Exhaust air damper position setpoint for AHU", u(
        unit="1",
        min=0,
        max=1)) "Exhaust air damper position setpoint" annotation (
        Placement(transformation(extent={{-48,80},{-28,100}})));
  equation
    connect(valExh.port_a, jun.port_2)
      annotation (Line(
        points={{-70,48},{-70,-2}},
        color={0,127,255},
        thickness=1));
    connect(valExh.port_b, port_Exh)
      annotation (Line(
        points={{-70,68},{-70,100}},
        color={0,127,255},
        thickness=1));
    connect(port_Fre, TOutSen.port_a) annotation (Line(
        points={{60,100},{60,100},{60,92}},
        color={0,127,255},
        thickness=1));
    connect(jun1.port_2, TMix.port_a) annotation (Line(
        points={{60,-22},{60,-28},{60,-32}},
        color={0,127,255},
        thickness=1));
    connect(jun.port_1, TRet.port_b) annotation (Line(
        points={{-70,-22},{-70,-32},{-70,-40}},
        color={0,127,255},
        thickness=1));
    connect(TRet.port_a, port_Ret) annotation (Line(
        points={{-70,-60},{-70,-80},{-70,-100}},
        color={0,127,255},
        thickness=1));
    connect(m_flowAir.port_b, jun1.port_1) annotation (Line(
        points={{60,10},{60,4},{60,-2}},
        color={0,127,255},
        thickness=1));
    connect(port_Fre, port_Fre) annotation (Line(points={{60,100},{60,104},{56,104},{60,104},{60,100}},
                                                                             color={0,127,255}));
    connect(port_Sup, m_flowSupAir.port_b) annotation (Line(
        points={{60,-100},{60,-92},{60,-82}},
        color={0,127,255},
        thickness=1));
    connect(m_flowSupAir.port_a, TMix.port_b) annotation (Line(
        points={{60,-62},{60,-62},{60,-52}},
        color={0,127,255},
        thickness=1));
    connect(TMix.T, T) annotation (Line(
        points={{71,-42},{110,-42}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TOutSen.T, TOut) annotation (Line(
        points={{71,82},{110,82}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TOutSen.port_b, valFre.port_a) annotation (Line(
        points={{60,72},{60,64}},
        color={0,127,255},
        thickness=1));
    connect(valFre.port_b,m_flowAir. port_a)
      annotation (Line(
        points={{60,44},{60,44},{60,30}},
        color={0,127,255},
        thickness=0.5));
    connect(jun.port_3, valRet.port_a) annotation (Line(
        points={{-60,-12},{-10,-12}},
        color={0,127,255},
        thickness=1));
    connect(valRet.port_b, jun1.port_3) annotation (Line(
        points={{10,-12},{50,-12}},
        color={0,127,255},
        thickness=1));
    connect(yOA.y, valFre.y)
      annotation (Line(points={{21,54},{48,54}}, color={0,0,127}));
    connect(yOA.u,damPos)  annotation (Line(points={{-2,54},{-40,54},{
            -40,32},{-84,32},{-84,0},{-120,0}}, color={0,0,127}));
    connect(realExpression.y, yRet.u)
      annotation (Line(points={{-39,20},{-30,20}}, color={0,0,127}));
    connect(yRet.y, valRet.y) annotation (Line(points={{-7,20},{0,20},{
            0,-1.77636e-15}}, color={0,0,127}));
    connect(damPos, yEA.u) annotation (Line(points={{-120,0},{-92,0},{
            -92,90},{-50,90}}, color={0,0,127}));
    connect(yEA.y, valExh.y) annotation (Line(points={{-27,90},{-18,90},
            {-18,76},{-88,76},{-88,58},{-82,58}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(
            points={{-70,92},{-70,-92}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{60,92},{60,-92}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{60,0},{-70,0}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-70,72},{-70,32}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-78,64},{-62,64}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-80,38},{-60,38}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-78,64},{-60,38}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-80,38},{-62,64}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{60,74},{60,34}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{52,66},{68,66}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{50,40},{70,40}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{52,66},{70,40}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{50,40},{68,66}},
            color={0,0,127},
            thickness=0.5),
          Text(
            extent={{-152,108},{148,148}},
            textString="%name",
            textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
  end MixingBox;
end BaseClasses;
