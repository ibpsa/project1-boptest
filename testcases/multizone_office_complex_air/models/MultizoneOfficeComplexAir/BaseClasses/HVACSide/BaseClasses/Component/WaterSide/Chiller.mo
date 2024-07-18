within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide;
package Chiller
  "This package contains the modules which can be used to simulate the chillers"

  model MultiChillers
    "The chiller system with N chillers and associated local controllers "
    replaceable package MediumCHW =
        Modelica.Media.Interfaces.PartialMedium
      "Medium in the chilled water side";
    replaceable package MediumCW =
        Modelica.Media.Interfaces.PartialMedium
      "Medium in the condenser water side";
    parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per[n]
      "Performance data" annotation (choicesAllMatching=true, Placement(
          transformation(extent={{-10,70},{10,90}})));
    parameter Modelica.Units.SI.Pressure dPCHW_nominal
      "Pressure difference at the chilled water side";
    parameter Modelica.Units.SI.Pressure dPCW_nominal
      "Pressure difference at the condenser water wide";
    parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[:]
      "Nominal mass flow rate at the chilled water side";
    parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]
      "Nominal mass flow rate at the condenser water wide";
    parameter Modelica.Units.SI.Temperature TCW_start
      "The start temperature of condenser water side";
    parameter Modelica.Units.SI.Temperature TCHW_start
      "The start temperature of chilled water side";

    parameter Integer n
      "the number of chillers";
    Modelica.Blocks.Interfaces.RealInput On[n](min=0,max=1) "On signal"    annotation (Placement(transformation(extent={{-118,
              -31},{-100,-49}})));
    Modelica.Blocks.Interfaces.RealInput TCHWSet
      "Temperature setpoint of the chilled water"
      annotation (Placement(transformation(extent={{-118,31},{-100,49}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package
        Medium =                                                               MediumCW)
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package
        Medium =                                                               MediumCW)
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package
        Medium =                                                                MediumCHW)
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
          iconTransformation(extent={{90,-90},{110,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CHW(redeclare package
        Medium =                                                                MediumCHW)
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,70},{110,90}})));
    Modelica.Blocks.Interfaces.RealOutput P[n]
      "Electric power consumed by compressor"
      annotation (Placement(transformation(extent={{100,30},{120,50}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWEntChi(
      redeclare package Medium = MediumCHW,
      allowFlowReversal=true,
      m_flow_nominal=sum(mCHW_flow_nominal))
                                          annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={50,80})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTCWLeaChi(
      allowFlowReversal=true,
      redeclare package Medium = MediumCW,
      m_flow_nominal=sum(mCW_flow_nominal))
                                         annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-82,80})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWLeaChi(
      allowFlowReversal=true,
      redeclare package Medium = MediumCHW,
      T_start=TCHW_start,
      m_flow_nominal=sum(mCHW_flow_nominal))
                                          annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={52,-80})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEntChi(
      allowFlowReversal=true,
      redeclare package Medium = MediumCW,
      T_start=TCW_start,
      m_flow_nominal=sum(mCW_flow_nominal))
                                         annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-70,-80})));
    replaceable ChillerTSet ch[n](
      redeclare package MediumCHW = MediumCHW,
      redeclare package MediumCW = MediumCW,
      dPCHW_nominal=dPCHW_nominal,
      dPCW_nominal=dPCW_nominal,
      mCHW_flow_nominal=mCHW_flow_nominal,
      mCW_flow_nominal=mCW_flow_nominal,
      TCW_start=TCW_start,
      TCHW_start=TCHW_start,
      per=per) constrainedby ChillerTSet(
      redeclare package MediumCHW = MediumCHW,
      redeclare package MediumCW = MediumCW,
      dPCHW_nominal=dPCHW_nominal,
      dPCW_nominal=dPCW_nominal,
      mCHW_flow_nominal=mCHW_flow_nominal,
      mCW_flow_nominal=mCW_flow_nominal,
      TCW_start=TCW_start,
      TCHW_start=TCHW_start,
      per=per)
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));

    Modelica.Blocks.Interfaces.RealOutput Rat[n] "compressor speed ratio"
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCHW(redeclare package
        Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{70,-90},{88,-70}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCW(redeclare package
        Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{-46,70},{-64,90}})));
  equation
    connect(port_b_CW, port_b_CW) annotation (Line(
        points={{-100,80},{-100,80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(port_a_CW, port_a_CW) annotation (Line(
        points={{-100,-80},{-100,-80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(senTCHWEntChi.port_a, port_a_CHW) annotation (Line(
        points={{60,80},{100,80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(port_b_CW, senTCWLeaChi.port_b) annotation (Line(
        points={{-100,80},{-92,80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(senTCWEntChi.port_a, port_a_CW) annotation (Line(
        points={{-80,-80},{-100,-80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(port_b_CHW, port_b_CHW) annotation (Line(
        points={{100,-80},{98,-80},{98,-80},{100,-80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(senTCWLeaChi.port_a, senMasFloCW.port_b) annotation (Line(
        points={{-72,80},{-64,80}},
        color={0,127,255},
        thickness=1));
    connect(senMasFloCHW.port_b, port_b_CHW) annotation (Line(
        points={{88,-80},{94,-80},{100,-80}},
        color={0,127,255},
        thickness=1));
    connect(senTCHWLeaChi.port_b, senMasFloCHW.port_a) annotation (Line(
        points={{62,-80},{66,-80},{70,-80}},
        color={0,127,255},
        thickness=1));
    connect(ch.On, On) annotation (Line(
        points={{-12,-3},{-60,-3},{-60,-40},{-109,-40}},
        color={0,0,127}));
    connect(On, Rat) annotation (Line(
        points={{-109,-40},{110,-40}},
        color={0,0,127}));

    for i in 1:n loop
          connect(ch[i].TCHWSet, TCHWSet);
          connect(ch[i].port_a_CW, senTCWEntChi.port_b);
          connect(ch[i].port_b_CHW, senTCHWLeaChi.port_a);
          connect(ch[i].port_b_CW, senMasFloCW.port_a);
          connect(ch[i].port_a_CHW, senTCHWEntChi.port_b);
          connect(ch[i].P, P[i]);
    end for;

    annotation (Documentation(info="<html>
<p>This model is to simulate the chiller system which consists of three chillers and associated local controllers.</p>
</html>",   revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),                                                                   graphics={
          Text(
            extent={{-44,-142},{50,-110}},
            lineColor={0,0,255},
            textString="%name"),
          Rectangle(
            extent={{-28,80},{26,40}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-28,20},{26,-20}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-28,-40},{26,-80}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-60,12},{-28,12}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-28,-50},{-60,-50},{-60,80}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-90,-80},{-40,-80},{-40,50},{-34,50},{-28,50}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-28,-10},{-40,-10}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-28,-70},{-40,-70}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{40,-80},{102,-80}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{40,-80},{40,50},{26,50}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{26,-12},{40,-12}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{26,-70},{40,-70}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{26,12},{60,12}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{26,-48},{60,-48},{60,80}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-100,80},{-60,80}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-28,70},{-60,70}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{100,80},{60,80}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{26,72},{60,72}},
            color={0,0,255},
            smooth=Smooth.None),
          Ellipse(
            extent={{-32,76},{-22,64}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,74},{-24,66}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-32,18},{-22,6}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,16},{-24,8}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-32,-44},{-22,-56}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,-46},{-24,-54}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,56},{30,44}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,54},{28,46}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,-6},{30,-18}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,-8},{28,-16}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,-64},{30,-76}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,-66},{28,-74}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,78},{30,66}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,18},{30,6}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,-44},{30,-56}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-32,56},{-22,44}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-32,-4},{-22,-16}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-32,-64},{-22,-76}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-158,104},{142,144}},
            textString="%name",
            textColor={0,0,255})}));
  end MultiChillers;

  model ChillerTSet "Chiller"
    replaceable package MediumCHW =
       Modelica.Media.Interfaces.PartialMedium
      "Medium in the chilled water side";
    replaceable package MediumCW =
       Modelica.Media.Interfaces.PartialMedium
      "Medium in the condenser water side";
    parameter Modelica.Units.SI.Pressure dPCHW_nominal
      "Pressure difference at the chilled water side";
    parameter Modelica.Units.SI.Pressure dPCW_nominal
      "Pressure difference at the condenser water wide";
    parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal
      "Nominal mass flow rate at the chilled water side";
    parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal
      "Nominal mass flow rate at the condenser water wide";
    parameter Modelica.Units.SI.Temperature TCW_start
      "The start temperature of condenser water side";
    parameter Modelica.Units.SI.Temperature TCHW_start
      "The start temperature of chilled water side";

     parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per
      "Performance data"
      annotation (choicesAllMatching = true,
                  Placement(transformation(extent={{40,80},{60,100}})));

    Buildings.Fluid.Chillers.ElectricEIR chi(
      redeclare package Medium1 = MediumCW,
      redeclare package Medium2 = MediumCHW,
      m1_flow_nominal=mCW_flow_nominal,
      m2_flow_nominal=mCHW_flow_nominal,
      dp1_nominal=0,
      dp2_nominal=0,
      allowFlowReversal1=true,
      allowFlowReversal2=true,
      tau1=300,
      tau2=300,
      T1_start=TCW_start,
      T2_start=TCHW_start,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      per=per)       annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-42})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package
        Medium =
          MediumCW)
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package
        Medium =
          MediumCW)
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,70},{-90,90}}),
          iconTransformation(extent={{-110,70},{-90,90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package
        Medium =
          MediumCHW)
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CHW(redeclare package
        Medium =
          MediumCHW)
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,70},{110,90}}),
          iconTransformation(extent={{90,70},{110,90}})));
    replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWLea(
      redeclare package Medium = MediumCHW,
      m_flow_nominal=mCHW_flow_nominal,
      T_start=TCHW_start)
      annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
    Buildings.Fluid.Actuators.Valves.TwoWayLinear valCW(
      redeclare package Medium = MediumCW,
      m_flow_nominal=mCW_flow_nominal,
      allowFlowReversal=false,
      dpValve_nominal=dPCW_nominal)
      annotation (Placement(transformation(extent={{-60,90},{-80,70}})));
    Buildings.Fluid.Actuators.Valves.TwoWayLinear valCHW(
      redeclare package Medium = MediumCHW,
      m_flow_nominal=mCHW_flow_nominal,
      dpValve_nominal=dPCHW_nominal)
      annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
    Modelica.Blocks.Interfaces.RealInput On(min=0,max=1)
      "True to enable compressor to operate, or false to disable the operation of the compressor"
      annotation (Placement(transformation(extent={{-118,-50},{-100,-30}}),
          iconTransformation(extent={{-140,-70},{-100,-30}})));
    Modelica.Blocks.Interfaces.RealInput TCHWSet
      "Temperature setpoint of chilled water"
      annotation (Placement(transformation(extent={{-118,30},{-100,50}}),
          iconTransformation(extent={{-140,10},{-100,50}})));
    Modelica.Blocks.Interfaces.RealOutput P
      "Electric power consumed by compressor"
      annotation (Placement(transformation(extent={{100,30},{120,50}}),
          iconTransformation(extent={{100,30},{120,50}})));

    Modelica.Blocks.Math.RealToBoolean realToBoolean
      annotation (Placement(transformation(extent={{-56,-66},{-42,-52}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTCWLea(
      allowFlowReversal=true,
      redeclare package Medium = MediumCW,
      m_flow_nominal=mCW_flow_nominal) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-40,0})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEnt(
      allowFlowReversal=true,
      redeclare package Medium = MediumCW,
      m_flow_nominal=mCW_flow_nominal) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-40,-80})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWEnt(
      allowFlowReversal=true,
      redeclare package Medium = MediumCHW,
      m_flow_nominal=mCHW_flow_nominal) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={30,0})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCHW(redeclare package
        Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{72,-10},{54,10}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCW(redeclare package
        Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{-78,-90},{-60,-70}})));
    Buildings.Fluid.Sensors.Pressure senPreCHWEnt(redeclare package Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{2,10},{22,30}})));
    Buildings.Fluid.Sensors.Pressure senPreCHWLea(redeclare package Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{78,-50},{98,-30}})));
    Buildings.Fluid.Sensors.Pressure     senPreCWLea(redeclare package
        Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{-76,68},{-96,48}})));
    Buildings.Fluid.Sensors.Pressure senPreCWEnt(redeclare package Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{-96,-70},{-76,-50}})));

  equation
    connect(chi.port_b2, senTCHWLea.port_a) annotation (Line(
        points={{6,-52},{6,-80},{20,-80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(chi.P, P) annotation (Line(
        points={{-9,-31},{-9,40},{110,40}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(senTCHWLea.port_b, valCHW.port_a) annotation (Line(
        points={{40,-80},{60,-80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(valCHW.port_b, port_b_CHW) annotation (Line(
        points={{80,-80},{100,-80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(valCW.port_b, port_b_CW) annotation (Line(
        points={{-80,80},{-100,80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(realToBoolean.y, chi.on) annotation (Line(
        points={{-41.3,-59},{-3,-59},{-3,-54}},
        color={255,0,255},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(On, valCW.y) annotation (Line(
        points={{-109,-40},{-90,-40},{-70,-40},{-70,-26},{-70,-26},{-70,68}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(valCHW.y, valCW.y) annotation (Line(
        points={{70,-68},{70,-26},{-70,-26},{-70,68}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realToBoolean.u, valCW.y) annotation (Line(
        points={{-57.4,-59},{-70,-59},{-70,-40},{-70,-26},{-70,68}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(chi.port_b1, senTCWLea.port_a) annotation (Line(
        points={{-6,-32},{-6,0},{-30,0}},
        color={0,127,255},
        thickness=1));
    connect(senTCWLea.port_b, valCW.port_a) annotation (Line(
        points={{-50,0},{-50,0},{-54,0},{-54,80},{-60,80}},
        color={0,127,255},
        thickness=1));
    connect(senTCWEnt.port_b, chi.port_a1) annotation (Line(
        points={{-30,-80},{-6,-80},{-6,-52}},
        color={0,127,255},
        thickness=1));
    connect(senTCHWEnt.port_b, chi.port_a2) annotation (Line(
        points={{20,0},{6,0},{6,-32}},
        color={0,127,255},
        thickness=1));
    connect(senPreCHWEnt.port, chi.port_a2) annotation (Line(
        points={{12,10},{12,0},{6,0},{6,-32}},
        color={0,127,255},
        thickness=1));
    connect(senPreCHWLea.port, port_b_CHW) annotation (Line(
        points={{88,-50},{88,-50},{88,-80},{100,-80}},
        color={0,127,255},
        thickness=1));
    connect(senPreCWLea.port, port_b_CW) annotation (Line(
        points={{-86,68},{-86,80},{-100,80}},
        color={0,127,255},
        thickness=1));
    connect(senMasFloCHW.port_b, senTCHWEnt.port_a) annotation (Line(
        points={{54,0},{47,0},{40,0}},
        color={0,127,255},
        thickness=1));
    connect(senMasFloCHW.port_a, port_a_CHW) annotation (Line(
        points={{72,0},{80,0},{80,80},{100,80}},
        color={0,127,255},
        thickness=1));
    connect(senMasFloCW.port_b, senTCWEnt.port_a) annotation (Line(
        points={{-60,-80},{-55,-80},{-50,-80}},
        color={0,127,255},
        thickness=1));
    connect(senMasFloCW.port_a, port_a_CW) annotation (Line(
        points={{-78,-80},{-100,-80}},
        color={0,127,255},
        thickness=1));
    connect(senPreCWEnt.port, port_a_CW) annotation (Line(
        points={{-86,-70},{-86,-80},{-100,-80}},
        color={0,127,255},
        thickness=1));
    connect(TCHWSet, chi.TSet) annotation (Line(
        points={{-109,40},{-16,40},{-16,-62},{3,-62},{3,-54}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),           Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-44,-144},{50,-112}},
            lineColor={0,0,255},
            textString="%name"),
          Rectangle(
            extent={{-101,82},{100,72}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-95,-76},{106,-86}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,50},{60,32}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-52,-50},{62,-68}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-101,82},{100,72}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{0,72},{100,82}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-95,-76},{106,-86}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-102,-86},{-2,-76}},
            lineColor={0,0,127},
            pattern=LinePattern.None,
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-32,-10},{-42,-22},{-22,-22},{-32,-10}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-32,-10},{-42,0},{-22,0},{-32,-10}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-34,32},{-30,0}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-34,-22},{-30,-50}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{34,32},{38,-50}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{14,10},{58,-32}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{36,10},{18,-22},{54,-22},{36,10}},
            lineColor={0,128,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
  end ChillerTSet;

  package BaseClasses
    model ElectricEIR "Electric chiller based on the DOE-2.1 model"
      extends PartialElectric(
        final QEva_flow_nominal=per.QEva_flow_nominal,
        final COP_nominal=per.COP_nominal,
        final PLRMax=per.PLRMax,
        final PLRMinUnl=per.PLRMinUnl,
        final PLRMin=per.PLRMin,
        final etaMotor=per.etaMotor,
        final mEva_flow_nominal=per.mEva_flow_nominal,
        final mCon_flow_nominal=per.mCon_flow_nominal,
        final TEvaLvg_nominal=per.TEvaLvg_nominal);

      parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per
        "Performance data"
        annotation (choicesAllMatching = true,
                    Placement(transformation(extent={{40,80},{60,100}})));

    protected
      final parameter Modelica.Units.NonSI.Temperature_degC TConEnt_nominal_degC=
          Modelica.Units.Conversions.to_degC(per.TConEnt_nominal)
        "Temperature of fluid entering condenser at nominal condition";

      Modelica.Units.NonSI.Temperature_degC TConEnt_degC
        "Temperature of fluid entering condenser";
    initial equation
      // Verify correctness of performance curves, and write warning if error is bigger than 10%
      Buildings.Fluid.Chillers.BaseClasses.warnIfPerformanceOutOfBounds(
         Buildings.Utilities.Math.Functions.biquadratic(a=per.capFunT,
         x1=TEvaLvg_nominal_degC, x2=TConEnt_nominal_degC),
         "Capacity as function of temperature ",
         "per.capFunT");
    equation
      TConEnt_degC=Modelica.Units.Conversions.to_degC(TConEnt);

      if on then
        // Compute the chiller capacity fraction, using a biquadratic curve.
        // Since the regression for capacity can have negative values (for unreasonable temperatures),
        // we constrain its return value to be non-negative. This prevents the solver to pick the
        // unrealistic solution.
        capFunT = Buildings.Utilities.Math.Functions.smoothMax(
           x1 = 1E-6,
           x2 = Buildings.Utilities.Math.Functions.biquadratic(a=per.capFunT, x1=TEvaLvg_degC, x2=TConEnt_degC),
           deltaX = 1E-7);
    /*    assert(capFunT > 0.1, "Error: Received capFunT = " + String(capFunT)  + ".\n"
           + "Coefficient for polynomial seem to be not valid for the encountered temperature range.\n"
           + "Temperatures are TConEnt_degC = " + String(TConEnt_degC) + " degC\n"
           + "                 TEvaLvg_degC = " + String(TEvaLvg_degC) + " degC");
*/
        // Chiller energy input ratio biquadratic curve.
        EIRFunT = Buildings.Utilities.Math.Functions.biquadratic(a=per.EIRFunT, x1=TEvaLvg_degC, x2=TConEnt_degC);
        // Chiller energy input ratio quadratic curve
        EIRFunPLR   = per.EIRFunPLR[1]+per.EIRFunPLR[2]*PLR2+per.EIRFunPLR[3]*PLR2^2;
      else
        capFunT   = 0;
        EIRFunT   = 0;
        EIRFunPLR = 0;
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                       graphics={
            Rectangle(
              extent={{-99,-54},{102,-66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,-66},{0,-54}},
              lineColor={0,0,127},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-104,66},{98,54}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-2,54},{98,66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-44,52},{-40,12}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-56,70},{58,52}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-42,2},{-52,12},{-32,12},{-42,2}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-42,2},{-52,-10},{-32,-10},{-42,2}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-44,-10},{-40,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{38,52},{42,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-56,-50},{58,-68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{18,24},{62,-18}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,24},{22,-8},{58,-8},{40,24}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
    defaultComponentName="chi",
    Documentation(info="<html>
<p>
Model of an electric chiller, based on the DOE-2.1 chiller model and
the EnergyPlus chiller model <code>Chiller:Electric:EIR</code>.
</p>
<p> This model uses three functions to predict capacity and power consumption:
</p>
<ul>
<li>
A biquadratic function is used to predict cooling capacity as a function of
condenser entering and evaporator leaving fluid temperature.
</li>
<li>
A quadratic functions is used to predict power input to cooling capacity ratio with respect to the part load ratio.
</li>
<li>
A biquadratic functions is used to predict power input to cooling capacity ratio as a function of
condenser entering and evaporator leaving fluid temperature.
</li>
</ul>
<p>
These curves are stored in the data record <code>per</code> and are available from
<a href=\"Buildings.Fluid.Chillers.Data.ElectricEIR\">
Buildings.Fluid.Chillers.Data.ElectricEIR</a>.
Additional performance curves can be developed using
two available techniques (Hydeman and Gillespie, 2002). The first technique is called the
Least-squares Linear Regression method and is used when sufficient performance data exist
to employ standard least-square linear regression techniques. The second technique is called
Reference Curve Method and is used when insufficient performance data exist to apply linear
regression techniques. A detailed description of both techniques can be found in
Hydeman and Gillespie (2002).
</p>
<p>
The model takes as an input the set point for the leaving chilled water temperature,
which is met if the chiller has sufficient capacity.
Thus, the model has a built-in, ideal temperature control.
The model has three tests on the part load ratio and the cycling ratio:
</p>
<ol>
<li>
The test<pre>
  PLR1 =min(QEva_flow_set/QEva_flow_ava, per.PLRMax);
</pre>
ensures that the chiller capacity does not exceed the chiller capacity specified
by the parameter <code>per.PLRMax</code>.
</li>
<li>
The test <pre>
  CR = min(PLR1/per.PRLMin, 1.0);
</pre>
computes a cycling ratio. This ratio expresses the fraction of time
that a chiller would run if it were to cycle because its load is smaller than the
minimal load at which it can operate.
Note that this model continuously operates even if the part load ratio is below the minimum part load ratio.
Its leaving evaporator and condenser temperature can therefore be considered as an
average temperature between the modes where the compressor is off and on.
</li>
<li>
The test <pre>
  PLR2 = max(per.PLRMinUnl, PLR1);
</pre>
computes the part load ratio of the compressor.
The assumption is that for a part load ratio below <code>per.PLRMinUnl</code>,
the chiller uses hot gas bypass to reduce the capacity, while the compressor
power draw does not change.
</li>
</ol>
<p>
The electric power only contains the power for the compressor, but not any power for pumps or fans.
</p>
<p>
The model can be parametrized to compute a transient
or steady-state response.
The transient response of the boiler is computed using a first
order differential equation for the evaporator and condenser fluid volumes.
The chiller outlet temperatures are equal to the temperatures of these lumped volumes.
</p>
<h4>References</h4>
<ul>
<li>
Hydeman, M. and K.L. Gillespie. 2002. Tools and Techniques to Calibrate Electric Chiller
Component Models. <i>ASHRAE Transactions</i>, AC-02-9-1.
</li>
</ul>
</html>",
    revisions="<html>
<ul>
<li>
March 12, 2015, by Michael Wetter:<br/>
Refactored model to make it once continuously differentiable.
This is for issue <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/373\">373</a>.
</li>
<li>
Jan. 9, 2011, by Michael Wetter:<br/>
Added input signal to switch chiller off.
</li>
<li>
Sep. 8, 2010, by Michael Wetter:<br/>
Revised model and included it in the Buildings library.
</li>
<li>
October 13, 2008, by Brandon Hencey:<br/>
First implementation.
</li>
</ul>
</html>"));
    end ElectricEIR;

    partial model PartialElectric "Partial model for electric chiller"
      extends Buildings.Fluid.Interfaces.FourPortHeatMassExchanger(
       m1_flow_nominal = mCon_flow_nominal,
       m2_flow_nominal = mEva_flow_nominal,
       T1_start = 273.15+25,
       T2_start = 273.15+5,
       redeclare final Buildings.Fluid.MixingVolumes.MixingVolume vol2(
          V=m2_flow_nominal*tau2/rho2_nominal,
          nPorts=2,
          final prescribedHeatFlowRate=true),
        vol1(
          final prescribedHeatFlowRate=true));

      Modelica.Blocks.Interfaces.BooleanInput on
        "Set to true to enable compressor, or false to disable compressor"
        annotation (Placement(transformation(extent={{-140,10},{-100,50}}),
            iconTransformation(extent={{-140,10},{-100,50}})));
      Modelica.Blocks.Interfaces.RealInput y "Cooling power output ratio" annotation (
          Placement(transformation(extent={{-140,-50},{-100,-10}}),
            iconTransformation(extent={{-140,-50},{-100,-10}})));

      Modelica.Units.SI.Temperature TEvaEnt "Evaporator entering temperature";
      Modelica.Units.SI.Temperature TEvaLvg "Evaporator leaving temperature";
      Modelica.Units.SI.Temperature TConEnt "Condenser entering temperature";
      Modelica.Units.SI.Temperature TConLvg "Condenser leaving temperature";

      Modelica.Units.SI.Efficiency COP "Coefficient of performance";
      Modelica.Units.SI.HeatFlowRate QCon_flow "Condenser heat input";
      Modelica.Units.SI.HeatFlowRate QEva_flow "Evaporator heat input";
      Modelica.Blocks.Interfaces.RealOutput P(final quantity="Power", unit="W")
        "Electric power consumed by compressor"
        annotation (Placement(transformation(extent={{100,80},{120,100}}),
            iconTransformation(extent={{100,80},{120,100}})));

      Real capFunT(min=0, unit="1")
        "Cooling capacity factor function of temperature curve";
      Modelica.Units.SI.Efficiency EIRFunT
        "Power input to cooling capacity ratio function of temperature curve";
      Modelica.Units.SI.Efficiency EIRFunPLR
        "Power input to cooling capacity ratio function of part load ratio";
      Real PLR1(min=0, unit="1") "Part load ratio";
      Real PLR2(min=0, unit="1") "Part load ratio";
      Real CR(min=0, unit="1") "Cycling ratio";
      parameter Modelica.Units.SI.Efficiency epsEva(max=1) = 1
        "Heat exchanger effectiveness at evaporator";

      parameter Modelica.Units.SI.Efficiency epsCon(max=1) = 1
        "Heat exchanger effectiveness at condenser";

    protected
      Modelica.Units.SI.HeatFlowRate QEva_flow_ava(nominal=QEva_flow_nominal, start=
           QEva_flow_nominal) "Cooling capacity available at evaporator";
      Modelica.Units.SI.HeatFlowRate QEva_flow_set(nominal=QEva_flow_nominal, start=
           QEva_flow_nominal)
        "Cooling capacity required to cool to set point temperature";

      // Performance data
      parameter Modelica.Units.SI.HeatFlowRate QEva_flow_nominal(max=0)
        "Reference capacity (negative number)";
      parameter Modelica.Units.SI.Efficiency COP_nominal
        "Reference coefficient of performance";
      parameter Real PLRMax(min=0, unit="1") "Maximum part load ratio";
      parameter Real PLRMinUnl(min=0, unit="1") "Minimum part unload ratio";
      parameter Real PLRMin(min=0, unit="1") "Minimum part load ratio";
      parameter Modelica.Units.SI.Efficiency etaMotor(max=1)
        "Fraction of compressor motor heat entering refrigerant";
      parameter Modelica.Units.SI.MassFlowRate mEva_flow_nominal
        "Nominal mass flow at evaporator";
      parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal
        "Nominal mass flow at condenser";

      parameter Modelica.Units.SI.Temperature TEvaLvg_nominal
        "Temperature of fluid leaving evaporator at nominal condition";

      final parameter Modelica.Units.NonSI.Temperature_degC TEvaLvg_nominal_degC=
          Modelica.Units.Conversions.to_degC(TEvaLvg_nominal)
        "Temperature of fluid leaving evaporator at nominal condition";
      Modelica.Units.NonSI.Temperature_degC TEvaLvg_degC
        "Temperature of fluid leaving evaporator";
      parameter Modelica.Units.SI.HeatFlowRate Q_flow_small=QEva_flow_nominal*1E-9
        "Small value for heat flow rate or power, used to avoid division by zero";
      Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloEva
        "Prescribed heat flow rate"
        annotation (Placement(transformation(extent={{-39,-50},{-19,-30}})));
      Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloCon
        "Prescribed heat flow rate"
        annotation (Placement(transformation(extent={{-39,30},{-19,50}})));
      Modelica.Blocks.Sources.RealExpression QEva_flow_in(y=QEva_flow)
        "Evaporator heat flow rate"
        annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      Modelica.Blocks.Sources.RealExpression QCon_flow_in(y=QCon_flow)
        "Condenser heat flow rate"
        annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

    initial equation
      assert(QEva_flow_nominal < 0, "Parameter QEva_flow_nominal must be smaller than zero.");
      assert(Q_flow_small < 0, "Parameter Q_flow_small must be smaller than zero.");
      assert(PLRMinUnl >= PLRMin, "Parameter PLRMinUnl must be bigger or equal to PLRMin");
      assert(PLRMax > PLRMinUnl, "Parameter PLRMax must be bigger than PLRMinUnl");
    equation
      // Condenser temperatures
      TConEnt = Medium1.temperature(Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow)));
      TConLvg = vol1.heatPort.T;
      // Evaporator temperatures
      TEvaEnt = Medium2.temperature(Medium2.setState_phX(port_a2.p, inStream(port_a2.h_outflow)));
      TEvaLvg = vol2.heatPort.T;
      TEvaLvg_degC=Modelica.Units.Conversions.to_degC(TEvaLvg);

      if on then
        // Available cooling capacity
        QEva_flow_ava = QEva_flow_nominal*capFunT;
        // Cooling capacity is controlled to be output
        QEva_flow_set = y*QEva_flow_ava;

        // Part load ratio
        PLR1 = Buildings.Utilities.Math.Functions.smoothMin(
          x1 = QEva_flow_set/(QEva_flow_ava+Q_flow_small),
          x2 = PLRMax,
          deltaX=PLRMax/100);
        // PLR2 is the compressor part load ratio. The lower bound PLRMinUnl is
        // since for PLR1<PLRMinUnl, the chiller uses hot gas bypass, under which
        // condition the compressor power is assumed to be the same as if the chiller
        // were to operate at PLRMinUnl
        PLR2 = Buildings.Utilities.Math.Functions.smoothMax(
          x1 = PLRMinUnl,
          x2 = PLR1,
          deltaX = PLRMinUnl/100);

        // Cycling ratio.
        // Due to smoothing, this can be about deltaX/10 above 1.0
        CR = Buildings.Utilities.Math.Functions.smoothMin(
          x1 = PLR1/PLRMin,
          x2 = 1,
          deltaX=0.001);

        // Compressor power.
        P = -QEva_flow_ava/COP_nominal*EIRFunT*EIRFunPLR*CR;
        // Heat flow rates into evaporator and condenser
        // Q_flow_small is a negative number.
        QEva_flow = Buildings.Utilities.Math.Functions.smoothMax(
          x1 = QEva_flow_set,
          x2 = QEva_flow_ava,
          deltaX= -Q_flow_small/10)*epsEva;

      //QEva_flow = max(QEva_flow_set, QEva_flow_ava);
        QCon_flow = epsCon*(-QEva_flow + P*etaMotor);
        // Coefficient of performance
        COP = -QEva_flow/epsEva/(P-Q_flow_small);
      else
        QEva_flow_ava = 0;
        QEva_flow_set = 0;
        PLR1 = 0;
        PLR2 = 0;
        CR   = 0;
        P    = 0;
        QEva_flow = 0;
        QCon_flow = 0;
        COP  = 0;
      end if;

      connect(QCon_flow_in.y, preHeaFloCon.Q_flow) annotation (Line(
          points={{-59,40},{-39,40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(preHeaFloCon.port, vol1.heatPort) annotation (Line(
          points={{-19,40},{-10,40},{-10,60}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(QEva_flow_in.y, preHeaFloEva.Q_flow) annotation (Line(
          points={{-59,-40},{-39,-40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(preHeaFloEva.port, vol2.heatPort) annotation (Line(
          points={{-19,-40},{12,-40},{12,-60}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                       graphics={
            Text(extent={{62,96},{112,82}},   textString="P",
              lineColor={0,0,127}),
            Text(extent={{-94,-24},{-48,-36}},  textString="T_CHWS",
              lineColor={0,0,127}),
            Rectangle(
              extent={{-99,-54},{102,-66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,-66},{0,-54}},
              lineColor={0,0,127},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-104,66},{98,54}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-2,54},{98,66}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-44,52},{-40,12}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-56,70},{58,52}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-42,2},{-52,12},{-32,12},{-42,2}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-42,2},{-52,-10},{-32,-10},{-42,2}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-44,-10},{-40,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{38,52},{42,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-56,-50},{58,-68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{18,24},{62,-18}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,24},{22,-8},{58,-8},{40,24}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-108,36},{-62,24}},
              lineColor={0,0,127},
              textString="on")}),
    Documentation(info="<html>
<p>
Base class for model of an electric chiller, based on the DOE-2.1 chiller model and the
CoolTools chiller model that are implemented in EnergyPlus as the models
<code>Chiller:Electric:EIR</code> and <code>Chiller:Electric:ReformulatedEIR</code>.
</p>
<p>
The model takes as an input the set point for the leaving chilled water temperature,
which is met if the chiller has sufficient capacity.
Thus, the model has a built-in, ideal temperature control.
The model has three tests on the part load ratio and the cycling ratio:
</p>
<ol>
<li>
The test
<pre>
  PLR1 =min(QEva_flow_set/QEva_flow_ava, PLRMax);
</pre>
ensures that the chiller capacity does not exceed the chiller capacity specified
by the parameter <code>PLRMax</code>.
</li>
<li>
The test <pre>
  CR = min(PLR1/per.PRLMin, 1.0);
</pre>
computes a cycling ratio. This ratio expresses the fraction of time
that a chiller would run if it were to cycle because its load is smaller than
the minimal load at which it can operature. Notice that this model does continuously operature even if
the part load ratio is below the minimum part load ratio. Its leaving evaporator and condenser temperature
can therefore be considered as an
average temperature between the modes where the compressor is off and on.
</li>
<li>
The test <pre>
  PLR2 = max(PLRMinUnl, PLR1);
</pre>
computes the part load ratio of the compressor.
The assumption is that for a part load ratio below <code>PLRMinUnl</code>,
the chiller uses hot gas bypass to reduce the capacity, while the compressor
power draw does not change.
</li>
</ol>
<p>
The electric power only contains the power for the compressor, but not any power for pumps or fans.
</p>
<h4>Implementation</h4>
<p>
Models that extend from this base class need to provide
three functions to predict capacity and power consumption:
</p>
<ul>
<li>
A function to predict cooling capacity. The function value needs
to be assigned to <code>capFunT</code>.
</li>
<li>
A function to predict the power input as a function of temperature.
The function value needs to be assigned to <code>EIRFunT</code>.
</li>
<li>
A function to predict the power input as a function of the part load ratio.
The function value needs to be assigned to <code>EIRFunPLR</code>.
</li>
</ul>
</html>",
    revisions="<html>
<ul>
<li>
June 28, 2019, by Michael Wetter:<br/>
Removed <code>start</code> values and removed
<code>nominal=1</code> for performance curves.<br/>
This is for issue <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1465\">1465</a>.
</li>
<li>
March 12, 2015, by Michael Wetter:<br/>
Refactored model to make it once continuously differentiable.
This is for issue <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/373\">373</a>.
</li>
<li>
Jan. 10, 2011, by Michael Wetter:<br/>
Added input signal to switch chiller off, and changed base class to use a dynamic model.
The change of the base class was required to improve the robustness of the model when the control
is switched on again.
</li>
<li>
Sep. 8, 2010, by Michael Wetter:<br/>
Revised model and included it in the Buildings library.
</li>
<li>
October 13, 2008, by Brandon Hencey:<br/>
First implementation.
</li>
</ul>
</html>"));
    end PartialElectric;
  end BaseClasses;
annotation ();
end Chiller;
