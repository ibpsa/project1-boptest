within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide;
package Boiler

  model MultiBoilers "The boiler system with N boilers and associated local controllers."
    replaceable package MediumHW =
       Modelica.Media.Interfaces.PartialMedium
      "Medium in the hot water side";
    parameter Modelica.Units.SI.Pressure dPHW_nominal
      "Pressure difference at the chilled water side";
    parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal[:]
      "Nominal mass flow rate at the chilled water side";
    parameter Modelica.Units.SI.Temperature THW_start
      "The start temperature of chilled water side";
    parameter Modelica.Units.SI.TemperatureDifference dTHW_nominal
      "Temperature difference between the outlet and inlet of the module";
    parameter Real eta[n,:] "Fan efficiency";
    Modelica.Blocks.Interfaces.RealInput On[n](min=0,max=1) "On signal"    annotation (Placement(transformation(extent={{-118,
              -31},{-100,-49}})));
    Modelica.Blocks.Interfaces.RealInput THWSet
      "Temperature setpoint of the chilled water"
      annotation (Placement(transformation(extent={{-118,31},{-100,49}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_HW(redeclare package
        Medium =
          MediumHW)
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
          iconTransformation(extent={{90,-90},{110,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_HW(redeclare package
        Medium =
          MediumHW)
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,70},{110,90}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTHWEntChi(
      allowFlowReversal=true,
      redeclare package Medium = MediumHW,
      m_flow_nominal=sum(mHW_flow_nominal)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={50,80})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTHWLeaChi(
      allowFlowReversal=true,
      redeclare package Medium = MediumHW,
      m_flow_nominal=sum(mHW_flow_nominal),
      T_start=THW_start) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={52,-80})));
    Modelica.Blocks.Interfaces.RealOutput Rat[n] "compressor speed ratio"
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Boiler boi[n](
      redeclare package MediumHW = MediumHW,
      dPHW_nominal=dPHW_nominal,
      mHW_flow_nominal=mHW_flow_nominal,
      dTHW_nominal=dTHW_nominal,
      eta=eta,
      each boi(T_nominal(displayUnit="K")),
      THW=THW_start,
      GaiPi=1,
      tIntPi=60)
      annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
    parameter Integer n
      "Number of boilers";

  equation
    connect(senTHWEntChi.port_a, port_a_HW) annotation (Line(
        points={{60,80},{100,80}},
        color={255,0,0},
        thickness=1));
    connect(senTHWLeaChi.port_b, port_b_HW) annotation (Line(
        points={{62,-80},{100,-80}},
        color={255,0,0},
        thickness=1));
    connect(port_b_HW, port_b_HW) annotation (Line(
        points={{100,-80},{100,-80}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    for i in 1:n loop
      connect(boi[i].port_a_HW, senTHWEntChi.port_b);
      connect(boi[i].port_b_CHW, senTHWLeaChi.port_a);
      connect(boi[i].THWSet, THWSet);
      connect(boi[i].On, On[i]);
    end for;
    connect(On, Rat) annotation (Line(points={{-109,-40},{110,-40}},           color={0,0,127}));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-28,80},{26,40}},
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
            points={{40,-80},{102,-80}},
            color={255,0,0}),
          Line(
            points={{40,-80},{40,50},{26,50}},
            color={255,0,0}),
          Line(
            points={{26,-70},{40,-70}},
            color={255,0,0}),
          Line(
            points={{26,-48},{60,-48},{60,80}},
            color={255,0,0}),
          Line(
            points={{100,80},{60,80}},
            color={255,0,0}),
          Line(
            points={{26,72},{60,72}},
            color={255,0,0}),
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
            extent={{20,-44},{30,-56}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-154,104},{146,144}},
            textString="%name",
            textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
  end MultiBoilers;

  model Boiler "Boiler"
    replaceable package MediumHW =
       Modelica.Media.Interfaces.PartialMedium
      "Medium in the hot water side";
    parameter Modelica.Units.SI.Pressure dPHW_nominal
      "Pressure difference at the chilled water side";
    parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal
      "Nominal mass flow rate at the chilled water side";
    parameter Modelica.Units.SI.Temperature THW
      "The start temperature of chilled water side";
    parameter Modelica.Units.SI.TemperatureDifference dTHW_nominal
      "Temperature difference between the outlet and inlet of the module";
    parameter Real GaiPi "Gain of the component PI controller";
    parameter Real tIntPi "Integration time of the component PI controller";
    parameter Real eta[:] "Fan efficiency";

    BaseClasses.BoilerPolynomial boi(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare package Medium = MediumHW,
      m_flow_nominal=mHW_flow_nominal,
      T_nominal=THW,
      effCur=Buildings.Fluid.Types.EfficiencyCurves.Polynomial,
      Q_flow_nominal=dTHW_nominal*mHW_flow_nominal*4200,
      a=eta,
      fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
      dp_nominal=0) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-38})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package
        Medium =
          MediumHW)
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_HW(redeclare package
        Medium =
          MediumHW)
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,70},{110,90}}),
          iconTransformation(extent={{90,70},{110,90}})));
    replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTHWLea(
      redeclare package Medium = MediumHW,
      m_flow_nominal=mHW_flow_nominal,
      T_start=THW) annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
    Buildings.Fluid.Actuators.Valves.TwoWayLinear valCHW(
      redeclare package Medium = MediumHW,
      m_flow_nominal=mHW_flow_nominal,
      dpValve_nominal=dPHW_nominal)
      annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
    Modelica.Blocks.Interfaces.RealInput On(min=0,max=1)
      "True to enable compressor to operate, or false to disable the operation of the compressor"
      annotation (Placement(transformation(extent={{-118,-50},{-100,-30}}),
          iconTransformation(extent={{-140,-70},{-100,-30}})));
    Modelica.Blocks.Interfaces.RealInput THWSet
      "Temperature setpoint of chilled water" annotation (Placement(
          transformation(extent={{-118,30},{-100,50}}), iconTransformation(extent=
             {{-140,10},{-100,50}})));

    Buildings.Fluid.Sensors.TemperatureTwoPort senTHWEnt(
      allowFlowReversal=true,
      redeclare package Medium = MediumHW,
      m_flow_nominal=mHW_flow_nominal) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={30,0})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloHW(redeclare package
        Medium =
          MediumHW)
      annotation (Placement(transformation(extent={{72,-10},{54,10}})));
    Buildings.Fluid.Sensors.Pressure senPreCWEnt(redeclare package Medium =
          MediumHW)
      annotation (Placement(transformation(extent={{2,10},{22,30}})));
    Buildings.Fluid.Sensors.Pressure senPreHWLea(redeclare package Medium =
          MediumHW)
      annotation (Placement(transformation(extent={{78,-50},{98,-30}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean
      annotation (Placement(transformation(extent={{-70,-18},{-54,-2}})));
    .MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
      conPI(Ti=2400, k=1)
      annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=boi.T)
      annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  equation
    connect(senTHWLea.port_b, valCHW.port_a)
      annotation (Line(
        points={{40,-80},{60,-80}},
        color={255,0,0},
        thickness=1));
    connect(valCHW.port_b, port_b_CHW) annotation (Line(
        points={{80,-80},{100,-80}},
        color={255,0,0},
        thickness=1));
    connect(senPreHWLea.port, port_b_CHW) annotation (Line(
        points={{88,-50},{88,-50},{88,-80},{100,-80}},
        color={255,0,0},
        thickness=1));
    connect(senMasFloHW.port_b, senTHWEnt.port_a) annotation (Line(
        points={{54,0},{47,0},{40,0}},
        color={255,0,0},
        thickness=1));
    connect(senMasFloHW.port_a, port_a_HW) annotation (Line(
        points={{72,0},{80,0},{80,80},{100,80}},
        color={255,0,0},
        thickness=1));
    connect(senTHWEnt.port_b, boi.port_a) annotation (Line(
        points={{20,0},{0,0},{0,-28}},
        color={255,0,0},
        thickness=1));
    connect(boi.port_b, senTHWLea.port_a)
      annotation (Line(
        points={{0,-48},{0,-80},{20,-80}},
        color={255,0,0},
        thickness=1));
    connect(senPreCWEnt.port, boi.port_a) annotation (Line(
        points={{12,10},{12,0},{0,0},{0,-28},{6.10623e-016,-28}},
        color={255,0,0},
        thickness=1));
    connect(On, valCHW.y) annotation (Line(
        points={{-109,-40},{-44,-40},{-44,-24},{70,-24},{70,-68}},
        color={0,0,127}));

    connect(realToBoolean.u, valCHW.y) annotation (Line(
        points={{-71.6,-10},{-80,-10},{-80,-40},{-44,-40},{-44,-24},{70,-24},{70,-68}},
        color={0,0,127}));
    connect(realToBoolean.y, conPI.On) annotation (Line(
        points={{-53.2,-10},{-40,-10},{-40,10},{-80,10},{-80,46},{-66,46}},
        color={255,0,255}));
    connect(conPI.set, THWSet)
      annotation (Line(points={{-66,40},{-109,40}}, color={0,0,127}));
    connect(conPI.y, boi.y)
      annotation (Line(
        points={{-43,40},{-8,40},{-8,-26}},
        color={0,0,127}));
    connect(realExpression.y,conPI.mea)  annotation (Line(
        points={{-49,-30},{-30,-30},{-30,22},{-76,22},{-76,34},{-66,34}},
        color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),           Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-44,-144},{50,-112}},
            lineColor={0,0,255},
            textString="%name"),
          Rectangle(
            extent={{-54,50},{60,32}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-52,-50},{62,-68}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{0,72},{100,82}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-32,-10},{-42,-22},{-22,-22},{-32,-10}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-32,-10},{-42,0},{-22,0},{-32,-10}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-34,32},{-30,0}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-34,-22},{-30,-50}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{34,32},{38,-50}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{14,10},{58,-32}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{36,10},{18,-22},{54,-22},{36,10}},
            lineColor={255,170,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{0,-86},{100,-76}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-152,106},{148,146}},
            textString="%name",
            textColor={0,0,255})}),
      Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
  end Boiler;

  package BaseClasses

    model BoilerPolynomial
      "Boiler with efficiency curve described by a polynomial of the temperature"
      extends Buildings.Fluid.Interfaces.TwoPortHeatMassExchanger(
        redeclare final Buildings.Fluid.MixingVolumes.MixingVolume vol,
        show_T=true,
        final tau=VWat*rho_default/m_flow_nominal);

      parameter Modelica.Units.SI.Power Q_flow_nominal "Nominal heating power";
      parameter Modelica.Units.SI.Temperature T_nominal=353.15
        "Temperature used to compute nominal efficiency (only used if efficiency curve depends on temperature)";
      // Assumptions
      parameter Buildings.Fluid.Types.EfficiencyCurves effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant
        "Curve used to compute the efficiency";
      parameter Real a[:] = {0.9} "Coefficients for efficiency curve";

      parameter Buildings.Fluid.Data.Fuels.Generic fue "Fuel type"
       annotation (choicesAllMatching = true);
      parameter Modelica.Units.SI.Efficiency eps(max=1) = 1
        "Heat exchanger effectiveness";
      parameter Modelica.Units.SI.ThermalConductance UA=0.05*Q_flow_nominal/30
        "Overall UA value";
      parameter Modelica.Units.SI.Volume VWat=1.5E-6*Q_flow_nominal
        "Water volume of boiler" annotation (Dialog(tab="Dynamics", enable=not (
              energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));
      parameter Modelica.Units.SI.Mass mDry=1.5E-3*Q_flow_nominal
        "Mass of boiler that will be lumped to water heat capacity" annotation (
          Dialog(tab="Dynamics", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));

      Modelica.Units.SI.Efficiency eta=if effCur == Buildings.Fluid.Types.EfficiencyCurves.Constant
           then a[1] elseif effCur == Buildings.Fluid.Types.EfficiencyCurves.Polynomial
           then Buildings.Utilities.Math.Functions.polynomial(a=a, x=y) elseif
          effCur == Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear then
          Buildings.Utilities.Math.Functions.quadraticLinear(
          a=aQuaLin,
          x1=y,
          x2=T) else 0 "Boiler efficiency";
      Modelica.Units.SI.Power QFue_flow=y*Q_flow_nominal/eta_nominal
        "Heat released by fuel";
      Modelica.Units.SI.Power QWat_flow=eta*QFue_flow*eps
        "Heat transfer from gas into water";
      Modelica.Units.SI.MassFlowRate mFue_flow=QFue_flow/fue.h
        "Fuel mass flow rate";
      Modelica.Units.SI.VolumeFlowRate VFue_flow=mFue_flow/fue.d
        "Fuel volume flow rate";

      Modelica.Blocks.Interfaces.RealInput y(min=0, max=1) "Part load ratio"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

      Modelica.Blocks.Interfaces.RealOutput T(final quantity="ThermodynamicTemperature",
                                              final unit = "K", displayUnit = "degC", min=0)
        annotation (Placement(transformation(extent={{100,70},{120,90}})));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
        "Heat port, can be used to connect to ambient"
        annotation (Placement(transformation(extent={{-10,62}, {10,82}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCapDry(
        C=500*mDry,
        T(start=T_start)) if not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
        "heat capacity of boiler metal"
        annotation (Placement(transformation(extent={{-80,12},{-60,32}})));

    protected
      parameter Real eta_nominal(fixed=false) "Boiler efficiency at nominal condition";
      parameter Real aQuaLin[6] = if size(a, 1) == 6 then a else fill(0, 6)
      "Auxiliary variable for efficiency curve because quadraticLinear requires exactly 6 elements";

      Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
        annotation (Placement(transformation(extent={{-43,-40},{-23,-20}})));
      Modelica.Blocks.Sources.RealExpression Q_flow_in(y=QWat_flow)
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSen
        "Temperature of fluid"
        annotation (Placement(transformation(extent={{0,30},{20,50}})));

      Modelica.Thermal.HeatTransfer.Components.ThermalConductor UAOve(G=UA)
        "Overall thermal conductance (if heatPort is connected)"
        annotation (Placement(transformation(extent={{-48,10},{-28,30}})));

    initial equation
      if  effCur == Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear then
        assert(size(a, 1) == 6,
        "The boiler has the efficiency curve set to 'Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear',
    and hence the parameter 'a' must have exactly 6 elements.
    However, only "     + String(size(a, 1)) + " elements were provided.");
      end if;

      if effCur ==Buildings.Fluid.Types.EfficiencyCurves.Constant then
        eta_nominal = a[1];
      elseif effCur ==Buildings.Fluid.Types.EfficiencyCurves.Polynomial then
        eta_nominal = Buildings.Utilities.Math.Functions.polynomial(
                                                              a=a, x=1);
      elseif effCur ==Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear then
        // For this efficiency curve, a must have 6 elements.
        eta_nominal = Buildings.Utilities.Math.Functions.quadraticLinear(
                                                                   a=aQuaLin, x1=1, x2=T_nominal);
      else
         eta_nominal = 999;
      end if;

    equation

      assert(eta > 0.001, "Efficiency curve is wrong.");

      connect(UAOve.port_b, vol.heatPort)            annotation (Line(
          points={{-28,20},{-22,20},{-22,-10},{-9,-10}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(UAOve.port_a, heatPort) annotation (Line(
          points={{-48,20},{-52,20},{-52,60},{0,60},{0,72}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(heaCapDry.port, vol.heatPort) annotation (Line(
          points={{-70,12},{-70,-10},{-9,-10}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(temSen.T, T) annotation (Line(
          points={{21,40},{60,40},{60,80},{110,80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(preHeaFlo.port, vol.heatPort) annotation (Line(
          points={{-23,-30},{-15,-30},{-15,-10},{-9,-10}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Q_flow_in.y,preHeaFlo. Q_flow) annotation (Line(
          points={{-59,-30},{-43,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(vol.heatPort, temSen.port) annotation (Line(
          points={{-9,-10},{-16,-10},{-16,40},{0,40}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation ( Icon(graphics={
            Polygon(
              points={{0,-34},{-12,-52},{14,-52},{0,-34}},
              pattern=LinePattern.None,
              smooth=Smooth.None,
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0}),
            Line(
              points={{-100,80},{-80,80},{-80,-44},{-6,-44}},
              smooth=Smooth.None),
            Line(
              points={{100,80},{80,80},{80,4}},
              color={0,0,127},
              smooth=Smooth.None),
            Text(
              extent={{160,144},{40,94}},
              lineColor={0,0,0},
              textString=DynamicSelect("T", String(T-273.15, format=".1f"))),
            Text(
              extent={{-38,146},{-158,96}},
              lineColor={0,0,0},
              textString=DynamicSelect("y", String(y, format=".2f")))}),
    defaultComponentName="boi",
    Documentation(info="<html>
<p>
This is a model of a boiler whose efficiency is described
by a polynomial.
The heat input into the medium is</p>
<p align=\"center\" style=\"font-style:italic;\">
  Q&#775; = y Q&#775;<sub>0</sub> &eta; &frasl; &eta;<sub>0</sub>
</p>
<p>
where
<i>y &isin; [0, 1]</i> is the control signal,
<i>Q&#775;<sub>0</sub></i> is the nominal power,
<i>&eta;</i> is the efficiency at the current operating point, and
<i>&eta;<sub>0</sub></i> is the efficiency at <i>y=1</i> and
nominal temperature <i>T=T<sub>0</sub></i> as specified by the parameter
<code>T_nominal</code>.
</p>
<p>
The parameter <code>effCur</code> determines what polynomial is used
to compute the efficiency, which is defined as
</p>
<p align=\"center\" style=\"font-style:italic;\">
  &eta; = Q&#775; &frasl; Q&#775;<sub>f</sub>,
</p>
<p>
where
<i>Q&#775;</i> is the heat transferred to the working fluid (typically water or air), and
<i>Q&#775;<sub>f</sub></i> is the heat of combustion released by the fuel.
</p>
<p>
The following polynomials can be selected to compute the efficiency:
</p>
<table summary=\"summary\"  border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Parameter <code>effCur</code></th>
<th>Efficiency curve</th>
</tr>
<tr>
<td>Buildings.Fluid.Types.EfficiencyCurves.Constant</td>
<td><i>&eta; = a<sub>1</sub></i></td>
</tr>
<tr>
<td>Buildings.Fluid.Types.EfficiencyCurves.Polynomial</td>
<td><i>&eta; = a<sub>1</sub> + a<sub>2</sub> y + a<sub>3</sub> y<sup>2</sup> + ...</i></td>
</tr>
<tr>
<td>Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear</td>
<td><i>&eta; = a<sub>1</sub> + a<sub>2</sub>  y
        + a<sub>3</sub> y<sup>2</sup>
        + (a<sub>4</sub> + a<sub>5</sub>  y
        + a<sub>6</sub> y<sup>2</sup>)  T
</i></td>
</tr>
</table>

<p>
where <i>T</i> is the boiler outlet temperature in Kelvin.
For <code>effCur = Buildings.Fluid.Types.EfficiencyCurves.Polynomial</code>,
an arbitrary number of polynomial coefficients can be specified.
</p>
<p>
The parameter <code>Q_flow_nominal</code> is the power transferred to the fluid
for <code>y=1</code> and, if the efficiency depends on temperature,
for <code>T=T0</code>.
</p>
<p>
The fuel mass flow rate and volume flow rate are computed as </p>
<p align=\"center\" style=\"font-style:italic;\">
  m&#775;<sub>f</sub> = Q&#775;<sub>f</sub> &frasl; h<sub>f</sub>
</p>
<p> and </p>
<p align=\"center\" style=\"font-style:italic;\">
  V&#775;<sub>f</sub> = m&#775;<sub>f</sub> &frasl; &rho;<sub>f</sub>,
</p>
<p>
where the fuel heating value
<i>h<sub>f</sub></i> and the fuel mass density
<i>&rho;<sub>f</sub></i> are obtained from the
parameter <code>fue</code>.
Note that if <i>&eta;</i> is the efficiency relative to the lower heating value,
then the fuel properties also need to be used for the lower heating value.
</p>

<p>
Optionally, the port <code>heatPort</code> can be connected to a heat port
outside of this model to impose a boundary condition in order to
model heat losses to the ambient. When using this <code>heatPort</code>,
make sure that the efficiency curve <code>effCur</code>
does not already account for this heat loss.
</p>

<p>
On the Assumptions tag, the model can be parameterized to compute a transient
or steady-state response.
The transient response of the boiler is computed using a first
order differential equation to compute the boiler's water and metal temperature,
which are lumped into one state. The boiler outlet temperature is equal to this water temperature.
</p>

</html>",     revisions="<html>
<ul>
<li>
May 27, 2016, by Michael Wetter:<br/>
Corrected size of input argument to
<code>Buildings.Utilities.Math.Functions.quadraticLinear</code>
for JModelica compliance check.
</li>
<li>
May 30, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
October 9, 2013 by Michael Wetter:<br/>
Removed conditional declaration of <code>mDry</code> as the use of a conditional
parameter in an instance declaration is not correct Modelica syntax.
</li>
<li>
December 14, 2012 by Michael Wetter:<br/>
Renamed protected parameters for consistency with the naming conventions.
</li>
<li>
December 22, 2011 by Michael Wetter:<br/>
Added computation of fuel usage and improved the documentation.
</li>
<li>
May 25, 2011 by Michael Wetter:<br/>
<ul>
<li>
Removed parameter <code>dT_nominal</code>, and require instead
the parameter <code>m_flow_nominal</code> to be set by the user.
This was needed to avoid a non-literal value for the nominal attribute
of the pressure drop model.
</li>
<li>
Changed assignment of parameters in model instantiation, and updated
model for the new base class that does not have a temperature sensor.
</li>
</ul>
</li>
<li>
January 29, 2009 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end BoilerPolynomial;
  end BaseClasses;
end Boiler;
