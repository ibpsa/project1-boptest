within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide;
package MixingBox

  model MixingBoxWithControl "The model of the mixing box"
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "medium for the fluid";
    parameter Modelica.Units.SI.Pressure PreDro "pressure drop in the air side";
    parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat
      "mass flow rate for fresh air";
    parameter Modelica.Units.SI.MassFlowRate mTotAirFloRat
      "mass flow rate for water";
    parameter Modelica.Units.SI.Temperature TemHig
      "highest temeprature when the economizer is on";
    parameter Modelica.Units.SI.Temperature TemLow
      "lowest temeprature when the economizer is on";
    parameter Real DamMin "minimum damper postion";
    parameter Real k(min=0, unit="1") = 1 "gain of controller";
    parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
      "time constant of Integrator block";
    BaseClasses.MixingBox mixBox(
      redeclare package Medium = Medium,
      PreDro=PreDro,
      mFreAirFloRat=mFreAirFloRat,
      mTotAirFloRat=mTotAirFloRat)
      annotation (Placement(transformation(extent={{-10,-24},{26,0}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium = Medium)
                                                   "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-70,90},{-50,110}}),
          iconTransformation(extent={{-70,90},{-50,110}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_Fre(redeclare package Medium = Medium)
                                                   "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{50,90},{70,110}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package Medium = Medium)
                                                   "First port, typically inlet" annotation (Placement(transformation(extent={{-68,
              -110},{-48,-90}}), iconTransformation(extent={{-68,-110},{-48,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package Medium = Medium)
                                                   "Second port, typically outlet" annotation (Placement(transformation(extent={{50,-112},{70,-92}})));
    Control.ecoCon ecoCon(
      TemHig=TemHig,
      TemLow=TemLow,
      DamMin=DamMin,
      k=k,
      Ti=Ti)              annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    Modelica.Blocks.Interfaces.RealInput TMix
      "Connector of setpoint input signal" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput TOut
      "Connector of measurement input signal"
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  equation
    connect(mixBox.port_Exh, port_Exh) annotation (Line(
        points={{-4.6,0},{-4.6,60},{-60,60},{-60,100}},
        color={0,140,72},
        thickness=0.5));
    connect(mixBox.port_Fre, port_Fre) annotation (Line(
        points={{18.8,0},{18.8,60},{60,60},{60,100}},
        color={0,140,72},
        thickness=0.5));
    connect(mixBox.port_Ret, port_Ret)
      annotation (Line(
        points={{-4.6,-24},{-4.6,-58},{-58,-58},{-58,-100}},
        color={0,140,72},
        thickness=0.5));
    connect(mixBox.port_Sup, port_Sup)
      annotation (Line(
        points={{18.8,-24},{20,-24},{20,-58},{60,-58},{60,-102}},
        color={0,140,72},
        thickness=0.5));
    connect(mixBox.T, ecoCon.Mea)
      annotation (Line(
        points={{27.8,-17.04},{38,-17.04},{38,22},{-78,22},{-78,32},{-72,32}},
        color={0,0,127}));
    connect(ecoCon.TMix, TMix) annotation (Line(
        points={{-72,40},{-92,40},{-92,0},{-120,0}},
        color={0,0,127}));
    connect(ecoCon.On, On) annotation (Line(
        points={{-72,48},{-90,48},{-90,80},{-120,80}},
        color={255,0,255}));
    connect(ecoCon.TOut,TOut)  annotation (Line(
        points={{-72,36},{-80,36},{-80,-60},{-120,-60}},
        color={0,0,127}));
    connect(ecoCon.y,mixBox.damPos)  annotation (Line(points={{-49,40},{-46,
            40},{-46,-12},{-13.6,-12}},
                                      color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(
            points={{-60,90},{-60,-94}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{60,92},{60,-92}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{60,0},{-60,0}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-60,72},{-60,32}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-68,64},{-52,64}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-70,38},{-50,38}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-68,64},{-50,38}},
            color={0,0,127},
            thickness=0.5),
          Line(
            points={{-70,38},{-52,64}},
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
            extent={{-148,112},{152,152}},
            textString="%name",
            textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
  end MixingBoxWithControl;

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

      Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package
          Medium =                                                              Medium)
        "First port, typically inlet"                                              annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package
          Medium =                                                              Medium)
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
      Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package
          Medium =                                                              Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_Fre(redeclare package
          Medium =                                                              Medium)
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
      Modelica.Fluid.Sensors.TemperatureTwoPort TRet(redeclare package
          Medium = Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-70,-50})));
      Modelica.Fluid.Sensors.MassFlowRate m_flowAir(redeclare package
          Medium =                                                             Medium)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={60,20})));
      Modelica.Blocks.Interfaces.RealInput damPos "Actuator position (0: closed, 1: open)"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Fluid.Sensors.MassFlowRate m_flowSupAir(redeclare package
          Medium = Medium) annotation (Placement(transformation(
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

  package Control

    model ecoCon
      import BuildingControlEmulator =
             MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component;
      parameter Modelica.Units.SI.Temperature TemHig
        "the highest temeprature when the economizer is on";
      parameter Modelica.Units.SI.Temperature TemLow
        "the lowest temeprature when the economizer is on";
       parameter Real DamMin "the minimum damper postion";
      parameter Real k(min=0, unit="1") = 1 "Gain of controller";
      parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
        "Time constant of Integrator block";

      BuildingControlEmulator.conPI pI(
        k=k,
        Ti=Ti,
        reverseActing=false,
        conPID(y_reset=1))
        annotation (Placement(transformation(extent={{10,2},{30,22}})));
      Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealInput TMix
        "Connector of setpoint input signal" annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealInput Mea "Connector of measurement input signal"
        annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
      Modelica.Blocks.Sources.BooleanExpression integerExpression(y=(TOut <= TemHig)
             and (TOut > TemLow))                                                 annotation (Placement(transformation(extent={{-80,30},
                {-60,50}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=DamMin) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
      Modelica.Blocks.Math.Max max annotation (Placement(transformation(extent={{52,-10},{72,10}})));
      Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.RealInput TOut
        "Connector of measurement input signal"
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
      Buildings.Controls.OBC.CDL.Continuous.LimitSlewRate ramLim(raisingSlewRate=1/
            120) "Ramp limiter for fan control signal"
        annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
      Buildings.Controls.OBC.CDL.Continuous.Limiter lim(uMax=1, uMin=0)
        annotation (Placement(transformation(extent={{68,-60},{88,-40}})));
      Buildings.Controls.OBC.CDL.Continuous.Switch swi
        annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=DamMin)
        annotation (Placement(transformation(extent={{-34,-68},{-14,-48}})));
    equation
      connect(pI.set, TMix) annotation (Line(
          points={{8,12},{8,10},{-60,10},{-60,0},{-120,0}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(pI.mea, Mea) annotation (Line(
          points={{8,6},{8,4},{-40,4},{-40,-80},{-120,-80}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(integerExpression.y, pI.On) annotation (Line(points={{-59,40},{-59,40},
              {0,40},{0,18},{8,18}},                                                                        color={255,0,255}));
      connect(pI.y, max.u1) annotation (Line(points={{31,12},{40,12},{40,6},{50,6}}, color={0,0,127}));
      connect(max.u2, realExpression.y) annotation (Line(points={{50,-6},{40,-6},{40,-20},{31,-20}}, color={0,0,127}));
      connect(ramLim.y, lim.u)
        annotation (Line(points={{62,-50},{66,-50}}, color={0,0,127}));
      connect(swi.y, ramLim.u)
        annotation (Line(points={{22,-50},{38,-50}}, color={0,0,127}));
      connect(On, swi.u2) annotation (Line(points={{-120,80},{-20,80},{-20,-50},{-2,
              -50}}, color={255,0,255}));
      connect(max.y, swi.u1) annotation (Line(points={{73,0},{88,0},{88,-28},{-12,
              -28},{-12,-42},{-2,-42}}, color={0,0,127}));
      connect(realExpression1.y, swi.u3)
        annotation (Line(points={{-13,-58},{-2,-58}}, color={0,0,127}));
      connect(lim.y, y) annotation (Line(points={{90,-50},{96,-50},{96,0},{110,0}},
            color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,127,255},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-34,26},{38,-34}},
              lineColor={0,127,255},
              lineThickness=1,
              textString="Eco"),
            Text(
              extent={{-156,112},{144,152}},
              textString="%name",
              textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
    end ecoCon;
  end Control;

end MixingBox;
