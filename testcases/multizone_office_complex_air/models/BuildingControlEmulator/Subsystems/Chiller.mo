within BuildingControlEmulator.Subsystems;
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
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package Medium = MediumCW)
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package Medium = MediumCW)
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package Medium = MediumCHW)
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
          iconTransformation(extent={{90,-90},{110,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CHW(redeclare package Medium = MediumCHW)
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
    replaceable Devices.WaterSide.ChillerTSet ch[n](
      redeclare package MediumCHW = MediumCHW,
      redeclare package MediumCW = MediumCW,
      dPCHW_nominal=dPCHW_nominal,
      dPCW_nominal=dPCW_nominal,
      mCHW_flow_nominal=mCHW_flow_nominal,
      mCW_flow_nominal=mCW_flow_nominal,
      TCW_start=TCW_start,
      TCHW_start=TCHW_start,
      per=per) constrainedby Devices.WaterSide.ChillerTSet(
      redeclare package MediumCHW = MediumCHW,
      redeclare package MediumCW = MediumCW,
      dPCHW_nominal=dPCHW_nominal,
      dPCW_nominal=dPCW_nominal,
      mCHW_flow_nominal=mCHW_flow_nominal,
      mCW_flow_nominal=mCW_flow_nominal,
      TCW_start=TCW_start,
      TCHW_start=TCHW_start,
      per=per) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));

    Modelica.Blocks.Interfaces.RealOutput Rat[n] "compressor speed ratio"
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCHW(redeclare package Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{70,-90},{88,-70}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCW(redeclare package Medium =
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
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(On, Rat) annotation (Line(
        points={{-109,-40},{110,-40}},
        color={0,0,127},
        pattern=LinePattern.Dash));

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
            fillPattern=FillPattern.Solid)}));
  end MultiChillers;

  model MultiHeterChillers "The chiller system with N heterogeneous chillers"
    replaceable package MediumCHW =
        Modelica.Media.Interfaces.PartialMedium
      "Medium in the chilled water side";
    replaceable package MediumCW =
        Modelica.Media.Interfaces.PartialMedium
      "Medium in the condenser water side";
    parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per[n+m]
      "Performance data" annotation (choicesAllMatching=true, Placement(
          transformation(extent={{-10,70},{10,90}})));
    parameter Modelica.Units.SI.Pressure dPCHW_nominal
      "Pressure difference at the chilled water side";
    parameter Modelica.Units.SI.Pressure dPCW_nominal
      "Pressure difference at the condenser water wide";
    parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[n + m]
      "Nominal mass flow rate at the chilled water side";
    parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[n + m]
      "Nominal mass flow rate at the condenser water wide";
    parameter Modelica.Units.SI.Temperature TCW_start
      "The start temperature of condenser water side";
    parameter Modelica.Units.SI.Temperature TCHW_start
      "The start temperature of chilled water side";

    parameter Integer n
      "Number of chiller group 1";

    parameter Integer m
      "Number of chiller group 2";

    Modelica.Blocks.Interfaces.RealInput On[n+m](min=0,max=1) "On signal"    annotation (Placement(transformation(extent={{-118,
              -31},{-100,-49}})));
    Modelica.Blocks.Interfaces.RealInput TCHWSet
      "Temperature setpoint of the chilled water"
      annotation (Placement(transformation(extent={{-118,31},{-100,49}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package Medium = MediumCW)
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package Medium = MediumCW)
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package Medium = MediumCHW)
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
          iconTransformation(extent={{90,-90},{110,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CHW(redeclare package Medium = MediumCHW)
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,70},{110,90}})));
    Modelica.Blocks.Interfaces.RealOutput P[n+m]
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
    Devices.WaterSide.Chiller ch1[n](
      redeclare package MediumCHW = MediumCHW,
      redeclare package MediumCW = MediumCW,
      dPCHW_nominal=dPCHW_nominal,
      dPCW_nominal=dPCW_nominal,
      mCHW_flow_nominal=mCHW_flow_nominal[1:n],
      mCW_flow_nominal=mCW_flow_nominal[1:n],
      TCW_start=TCW_start,
      TCHW_start=TCHW_start,
      per=per[1:n]) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));

    Devices.WaterSide.Chiller ch2[m](
      redeclare package MediumCHW = MediumCHW,
      redeclare package MediumCW = MediumCW,
      dPCHW_nominal=dPCHW_nominal,
      dPCW_nominal=dPCW_nominal,
      mCHW_flow_nominal=mCHW_flow_nominal[n+1:n+m],
      mCW_flow_nominal=mCW_flow_nominal[n+1:n+m],
      TCW_start=TCW_start,
      TCHW_start=TCHW_start,
      per=per[n+1:n+m]) annotation (Placement(transformation(extent={{-10,22},{10,42}})));

    Modelica.Blocks.Interfaces.RealOutput Rat[n + m] "compressor speed ratio"
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCHW(redeclare package Medium =
          MediumCHW)
      annotation (Placement(transformation(extent={{70,-90},{88,-70}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCW(redeclare package Medium =
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

    connect(On, Rat) annotation (Line(
        points={{-109,-40},{110,-40}},
        color={0,0,127},
        pattern=LinePattern.Dash));

    for i in 1:n loop
          connect(ch1[i].TCHWSet, TCHWSet);
          connect(ch1[i].port_a_CW, senTCWEntChi.port_b);
          connect(ch1[i].port_b_CHW, senTCHWLeaChi.port_a);
          connect(ch1[i].port_b_CW, senMasFloCW.port_a);
          connect(ch1[i].port_a_CHW, senTCHWEntChi.port_b);
          connect(ch1[i].P, P[i]);
          connect(ch1[i].On, On[i]);
    end for;

      for i in 1:m loop
          connect(ch2[i].TCHWSet, TCHWSet);
          connect(ch2[i].port_a_CW, senTCWEntChi.port_b);
          connect(ch2[i].port_b_CHW, senTCHWLeaChi.port_a);
          connect(ch2[i].port_b_CW, senMasFloCW.port_a);
          connect(ch2[i].port_a_CHW, senTCHWEntChi.port_b);
          connect(ch2[i].P, P[n+i]);
          connect(ch2[i].On, On[n+i]);
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
            fillPattern=FillPattern.Solid)}));
  end MultiHeterChillers;

  package Example "Test of the modules"
  extends Modelica.Icons.ExamplesPackage;

    model MultiChillers "Test model for MultiChillerSystem"
      import BuildingControlEmulator;
      extends Modelica.Icons.Example;

      Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19XR_742kW_5_42COP_VSD
        datChi[3] annotation (Placement(transformation(extent={{-12,42},{8,62}})));

      package MediumCHW = Buildings.Media.Water "Medium model";
      package MediumCW = Buildings.Media.Water "Medium model";
      parameter Modelica.Units.SI.TemperatureDifference dTCHW_nominal=5.56
        "Temperature difference at the chilled water side";
      parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal=5.18
        "Temperature difference at the condenser water wide";
      parameter Modelica.Units.SI.Pressure dPCHW_nominal=91166
        "Pressure difference at the chilled water side";
      parameter Modelica.Units.SI.Pressure dPCW_nominal=92661
        "Pressure difference at the condenser water wide";
      parameter Modelica.Units.SI.Temperature TCHW_nominal=273.15 + 5.56
        "Temperature at the chilled water side";
      parameter Modelica.Units.SI.Temperature TCW_nominal=273.15 + 29.44
        "Temperature at the condenser water wide";
      parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[:]={-datChi[1].QEva_flow_nominal
          /4200/5.56 for i in linspace(
              1,
              3,
              3)} "Nominal mass flow rate at the chilled water side";
      parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]={
          mCHW_flow_nominal[1]*(datChi[1].COP_nominal + 1)/datChi[1].COP_nominal
          for i in linspace(
              1,
              3,
              3)} "Nominal mass flow rate at the condenser water wide";

      BuildingControlEmulator.Subsystems.Chiller.MultiChillers mulChiSys(
        redeclare package MediumCHW = MediumCHW,
        redeclare package MediumCW = MediumCW,
        dPCHW_nominal=dPCHW_nominal,
        dPCW_nominal=dPCW_nominal,
        mCHW_flow_nominal=mCHW_flow_nominal,
        mCW_flow_nominal=mCW_flow_nominal,
        TCW_start=273.15 + 29.44,
        TCHW_start=273.15 + 5.56,
        n=3,
        per=datChi)
        annotation (Placement(transformation(extent={{-8,-12},{12,8}})));
      Modelica.Blocks.Sources.Step OnA(height=1, startTime=0) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
      Modelica.Blocks.Sources.Step OnB(          startTime=21600,
        height=1,
        offset=0)                                                 annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Blocks.Sources.Step OnC(          startTime=43200,
        height=1,
        offset=0)                                                 annotation (Placement(transformation(extent={{80,70},{60,90}})));
      Modelica.Blocks.Sources.Constant TCHWSet(k=273.15 + 5.56)
        annotation (Placement(transformation(extent={{80,30},{60,50}})));
      Buildings.Fluid.Sources.Boundary_pT sinCW(redeclare package Medium =
                   MediumCW, nPorts=1) "Sink for CW" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-70,4})));
      Buildings.Fluid.Sources.MassFlowSource_T souCW(
        redeclare package Medium = MediumCW,
        nPorts=1,
        m_flow=sum(mCW_flow_nominal),
        use_m_flow_in=true,
        use_T_in=false,
        T(displayUnit="K") = 273.15 + 21.11) "Source for CW"
        annotation (Placement(transformation(extent={{-48,-50},{-28,-30}})));
      Buildings.Fluid.Sources.MassFlowSource_T souCHW(
        use_T_in=true,
        redeclare package Medium = MediumCHW,
        nPorts=1,
        m_flow=sum(mCW_flow_nominal),
        use_m_flow_in=true,
        T=298.15) "Source for CHW"
        annotation (Placement(transformation(extent={{42,-24},{22,-4}})));
      Buildings.Fluid.Sources.Boundary_pT sinCHW(redeclare package Medium =
                   MediumCHW, nPorts=1) "Sink for CHW" annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={70,-50})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWLeaChi(
          redeclare package Medium = MediumCHW, m_flow_nominal=sum(mCHW_flow_nominal),
        T_start=273.15 + 5.56)
        annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
      Modelica.Blocks.Sources.Sine TCHWEntChi(
        f=1/21600,
        amplitude=0,
        offset=273.15 + 5.56 + 5.56)
        annotation (Placement(transformation(extent={{80,-22},{60,-2}})));
      Modelica.Blocks.Sources.RealExpression mCW_flow(y=(OnA.y + OnB.y + OnC.y)*mCW_flow_nominal[1])
        annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
      Modelica.Blocks.Sources.RealExpression mCHW_flow(y=(OnA.y + OnB.y + OnC.y)*mCHW_flow_nominal[1])
        annotation (Placement(transformation(extent={{80,2},{60,22}})));

    equation

      connect(TCHWSet.y, mulChiSys.TCHWSet) annotation (Line(
          points={{59,40},{-20,40},{-20,2},{-8.9,2}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(sinCW.ports[1], mulChiSys.port_b_CW)
        annotation (Line(
          points={{-60,4},{-36,4},{-36,6},{-8,6}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(souCW.ports[1], mulChiSys.port_a_CW)
        annotation (Line(
          points={{-28,-40},{-20,-40},{-20,-10},{-8,-10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(TCHWEntChi.y,souCHW. T_in)
        annotation (Line(
          points={{59,-12},{52,-12},{52,-10},{44,-10}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(senTCHWLeaChi.port_b,sinCHW. ports[1])
        annotation (Line(
          points={{40,-50},{60,-50}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(souCHW.ports[1], mulChiSys.port_a_CHW)
        annotation (Line(
          points={{22,-14},{18,-14},{18,6},{12,6}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(mulChiSys.port_b_CHW,senTCHWLeaChi. port_a)
        annotation (Line(
          points={{12,-10},{16,-10},{16,-50},{20,-50}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(mCW_flow.y, souCW.m_flow_in)
        annotation (Line(
          points={{-59,-60},{-54,-60},{-54,-32},{-50,-32}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(mCHW_flow.y, souCHW.m_flow_in)
        annotation (Line(
          points={{59,12},{52,12},{52,-6},{44,-6}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(OnA.y, mulChiSys.On[1]) annotation (Line(
          points={{-59,40},{-44,40},{-44,-5.4},{-8.9,-5.4}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(OnB.y, mulChiSys.On[2]) annotation (Line(
          points={{-59,80},{-44,80},{-28,80},{-28,-6},{-8.9,-6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(OnC.y, mulChiSys.On[3]) annotation (Line(
          points={{59,80},{8,80},{8,90},{-36,90},{-36,-6.6},{-8.9,-6.6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      annotation (__Dymola_Commands(file=
              "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/LejeunePlant/Chiller/Example/MultiChillerSystem.mos"
            "Simulate and plot"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        experiment(StopTime=86400),
        __Dymola_experimentSetupOutput);
    end MultiChillers;

    model MultiHeterChillers "Test model for MultiChillerSystem"
      import BuildingControlEmulator;
      extends Modelica.Icons.Example;

      Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19XR_742kW_5_42COP_VSD
        datChi[3] annotation (Placement(transformation(extent={{-12,42},{8,62}})));

      package MediumCHW = Buildings.Media.Water "Medium model";
      package MediumCW = Buildings.Media.Water "Medium model";
      parameter Modelica.Units.SI.TemperatureDifference dTCHW_nominal=5.56
        "Temperature difference at the chilled water side";
      parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal=5.18
        "Temperature difference at the condenser water wide";
      parameter Modelica.Units.SI.Pressure dPCHW_nominal=91166
        "Pressure difference at the chilled water side";
      parameter Modelica.Units.SI.Pressure dPCW_nominal=92661
        "Pressure difference at the condenser water wide";
      parameter Modelica.Units.SI.Temperature TCHW_nominal=273.15 + 5.56
        "Temperature at the chilled water side";
      parameter Modelica.Units.SI.Temperature TCW_nominal=273.15 + 29.44
        "Temperature at the condenser water wide";
      parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[:]={-datChi[1].QEva_flow_nominal
          /4200/5.56 for i in linspace(
              1,
              3,
              3)} "Nominal mass flow rate at the chilled water side";
      parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]={
          mCHW_flow_nominal[1]*(datChi[1].COP_nominal + 1)/datChi[1].COP_nominal
          for i in linspace(
              1,
              3,
              3)} "Nominal mass flow rate at the condenser water wide";

      BuildingControlEmulator.Subsystems.Chiller.MultiHeterChillers mulChiSys(
        redeclare package MediumCHW = MediumCHW,
        redeclare package MediumCW = MediumCW,
        dPCHW_nominal=dPCHW_nominal,
        dPCW_nominal=dPCW_nominal,
        mCHW_flow_nominal=mCHW_flow_nominal,
        mCW_flow_nominal=mCW_flow_nominal,
        TCW_start=273.15 + 29.44,
        TCHW_start=273.15 + 5.56,
        n=1,
        m=2,
        per=datChi)
        annotation (Placement(transformation(extent={{-8,-12},{12,8}})));
      Modelica.Blocks.Sources.Step OnA(height=1, startTime=0) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
      Modelica.Blocks.Sources.Step OnB(          startTime=21600,
        height=1,
        offset=0)                                                 annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Blocks.Sources.Step OnC(          startTime=43200,
        height=1,
        offset=0)                                                 annotation (Placement(transformation(extent={{80,70},{60,90}})));
      Modelica.Blocks.Sources.Constant TCHWSet(k=273.15 + 5.56)
        annotation (Placement(transformation(extent={{80,30},{60,50}})));
      Buildings.Fluid.Sources.Boundary_pT sinCW(redeclare package Medium =
                   MediumCW, nPorts=1) "Sink for CW" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-70,4})));
      Buildings.Fluid.Sources.MassFlowSource_T souCW(
        redeclare package Medium = MediumCW,
        nPorts=1,
        m_flow=sum(mCW_flow_nominal),
        use_m_flow_in=true,
        use_T_in=false,
        T(displayUnit="K") = 273.15 + 21.11) "Source for CW"
        annotation (Placement(transformation(extent={{-48,-50},{-28,-30}})));
      Buildings.Fluid.Sources.MassFlowSource_T souCHW(
        use_T_in=true,
        redeclare package Medium = MediumCHW,
        nPorts=1,
        m_flow=sum(mCW_flow_nominal),
        use_m_flow_in=true,
        T=298.15) "Source for CHW"
        annotation (Placement(transformation(extent={{42,-24},{22,-4}})));
      Buildings.Fluid.Sources.Boundary_pT sinCHW(redeclare package Medium =
                   MediumCHW, nPorts=1) "Sink for CHW" annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={70,-50})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWLeaChi(
          redeclare package Medium = MediumCHW, m_flow_nominal=sum(mCHW_flow_nominal),
        T_start=273.15 + 5.56)
        annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
      Modelica.Blocks.Sources.Sine TCHWEntChi(
        f=1/21600,
        amplitude=0,
        offset=273.15 + 5.56 + 5.56)
        annotation (Placement(transformation(extent={{80,-22},{60,-2}})));
      Modelica.Blocks.Sources.RealExpression mCW_flow(y=(OnA.y + OnB.y + OnC.y)*mCW_flow_nominal[1])
        annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
      Modelica.Blocks.Sources.RealExpression mCHW_flow(y=(OnA.y + OnB.y + OnC.y)*mCHW_flow_nominal[1])
        annotation (Placement(transformation(extent={{80,2},{60,22}})));

    equation

      connect(TCHWSet.y, mulChiSys.TCHWSet) annotation (Line(
          points={{59,40},{-20,40},{-20,2},{-8.9,2}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(sinCW.ports[1], mulChiSys.port_b_CW)
        annotation (Line(
          points={{-60,4},{-36,4},{-36,6},{-8,6}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(souCW.ports[1], mulChiSys.port_a_CW)
        annotation (Line(
          points={{-28,-40},{-20,-40},{-20,-10},{-8,-10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(TCHWEntChi.y,souCHW. T_in)
        annotation (Line(
          points={{59,-12},{52,-12},{52,-10},{44,-10}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(senTCHWLeaChi.port_b,sinCHW. ports[1])
        annotation (Line(
          points={{40,-50},{60,-50}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(souCHW.ports[1], mulChiSys.port_a_CHW)
        annotation (Line(
          points={{22,-14},{18,-14},{18,6},{12,6}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(mulChiSys.port_b_CHW,senTCHWLeaChi. port_a)
        annotation (Line(
          points={{12,-10},{16,-10},{16,-50},{20,-50}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(mCW_flow.y, souCW.m_flow_in)
        annotation (Line(
          points={{-59,-60},{-54,-60},{-54,-32},{-50,-32}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(mCHW_flow.y, souCHW.m_flow_in)
        annotation (Line(
          points={{59,12},{52,12},{52,-6},{44,-6}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(OnA.y, mulChiSys.On[1]) annotation (Line(
          points={{-59,40},{-44,40},{-44,-5.4},{-8.9,-5.4}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(OnB.y, mulChiSys.On[2]) annotation (Line(
          points={{-59,80},{-44,80},{-28,80},{-28,-6},{-8.9,-6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(OnC.y, mulChiSys.On[3]) annotation (Line(
          points={{59,80},{8,80},{8,90},{-36,90},{-36,-6.6},{-8.9,-6.6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      annotation (__Dymola_Commands(file=
              "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/LejeunePlant/Chiller/Example/MultiChillerSystem.mos"
            "Simulate and plot"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        experiment(StopTime=86400),
        __Dymola_experimentSetupOutput);
    end MultiHeterChillers;
  annotation (Documentation(info="<html>
<p>This package contains examples for the use of models that can be found in Chiller.</p>
</html>"));
  end Example;
annotation ();
end Chiller;
