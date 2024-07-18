within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover;
package Pump
  "This package contains the modules which can be used to simulate the primary chilled water pump, the condenser water pump and the secondary chilled water pump"

  model SimPumpSystem
    "This model is used to simulate the primary chilled water pump and condenser water pump system"
      replaceable package Medium =
           Modelica.Media.Interfaces.PartialMedium "Medium water";
    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal[n]
      "Rated mass flow rate";

      parameter Integer n= 2
      "the number of pumps";
      parameter Real Motor_eta[n,:] "Motor efficiency";
      parameter Real Hydra_eta[n,:] "Hydraulic efficiency";
    parameter Modelica.Units.SI.PressureDifference dp_nominal
      "Nominal pressure raise";

    Buildings.Fluid.Movers.FlowControlled_m_flow
                                         pumConSpe[n](redeclare package
        Medium =                                                                 Medium,
      m_flow_nominal=m_flow_nominal,
      per(
        use_powerCharacteristic=false,
        motorEfficiency(eta=Motor_eta),
        hydraulicEfficiency(eta=Hydra_eta)),
      dp_nominal=dp_nominal)                                                           "Constant Speed pump"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealInput On[n] "On signal"    annotation (Placement(transformation(extent={{-118,51},
              {-100,69}})));

    Modelica.Blocks.Interfaces.RealOutput P[n]
      "Electric power consumed by compressor"
      annotation (Placement(transformation(extent={{100,30},{120,50}})));
    Modelica.Blocks.Math.Gain gain[n](k=m_flow_nominal)
      annotation (Placement(transformation(extent={{-80,50},{-60,70}})));

  equation

    for i in 1:n loop
      connect(pumConSpe[i].port_a, port_a);
      connect(pumConSpe[i].port_b, port_b);
      connect(pumConSpe[i].P, P[i]);

    end for;

    connect(gain.u, On)
      annotation (Line(
        points={{-82,60},{-109,60}},
        color={0,0,127}));
    connect(gain.y, pumConSpe.m_flow_in) annotation (Line(points={{-59,60},{-28,60},{0,60},{0,12}}, color={0,0,127}));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),                                                                               Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-40,-102},{46,-156}},
            lineColor={0,0,255},
            textString="%name"),
          Ellipse(
            extent={{-20,80},{20,40}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{16,60},{-8,48},{-8,70},{16,60}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-100,0},{-40,0},{-40,60}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-40,60},{-20,60}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-40,0},{-16,0}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-40,0},{-40,-60},{-16,-60}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{20,60},{40,60},{40,-60},{14,-60}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{40,0},{14,0}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{40,0},{90,0}},
            color={0,0,255},
            smooth=Smooth.None),
          Ellipse(
            extent={{-20,20},{20,-20}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,-40},{20,-80}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{16,0},{-8,-12},{-8,10},{16,0}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{16,-60},{-8,-72},{-8,-50},{16,-60}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(revisions="<html>
<ul>
<li>
March 30, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
  end SimPumpSystem;

  model PumpSystem "This model is used to simulate the secondary chilled water pump"
      replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium  "Medium water";
      parameter Integer n= 2
      "the number of pumps";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal[n];
    parameter Real HydEff[n,:] "Hydraulic efficiency";
    parameter Real MotEff[n,:] "Motor efficiency";
    parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[n,:]
      "Volume flow rate curve";
    parameter Modelica.Units.SI.Pressure PreCur[n,:] "Pressure curve";
    MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor
      pum[n](
      varSpeFloMov(addPowerToMedium=false),
      redeclare package Medium = Medium,
      HydEff=HydEff,
      MotEff=MotEff,
      VolFloCur=VolFloCur,
      PreCur=PreCur,
      TimCon=900)
      annotation (Placement(transformation(extent={{-12,-10},{10,10}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealInput speSig[n] "On signal"
      annotation (Placement(transformation(extent={{-118,71},{-100,89}})));
    Modelica.Blocks.Interfaces.RealOutput speRat[n]
      "Speed of the pump divided by the nominal value"
      annotation (Placement(transformation(extent={{100,52},{120,72}})));
    Modelica.Blocks.Interfaces.RealOutput P[n]
      "Electric power consumed by compressor"
      annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
    Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val[n](redeclare
        package Medium = Medium,
        m_flow_nominal=m_flow_nominal,
      dpValve_nominal=dpValve_nominal)
      annotation (Placement(transformation(extent={{42,-10},{62,10}})));
    BaseClasses.ValCon valCon(n=n)
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    parameter Modelica.Units.SI.PressureDifference dpValve_nominal[n]
      "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
  equation

    for i in 1:n loop
     connect(pum[i].Rat,speRat [i]);
     connect(pum[i].port_a, port_a);
     connect(val[i].port_b, port_b);
     connect(pum[i].P, P[i]);
       connect(pum[i].port_b, val[i].port_a);
    end for;

    connect(pum.u,speSig)  annotation (Line(
        points={{-13.1,6},{-80,6},{-80,80},{-109,80}},
        color={0,0,127}));
    connect(valCon.On,speSig)  annotation (Line(
        points={{-10.9,60},{-60,60},{-60,80},{-109,80}},
        color={0,0,127}));
    connect(valCon.y, val.y) annotation (Line(
        points={{10.9,60},{52,60},{52,12}},
        color={0,0,127}));
    annotation (Icon(graphics={
          Text(
            extent={{-152,104},{148,144}},
            textString="%name",
            textColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end PumpSystem;

  package Control

    model SecPumCon "This model is used for secondary chilled water pump control."
      parameter Real tWai = 300 "Waiting time";

        parameter Integer n=3
        "the number of pumps";
      WaterSide.Control.PumpStageN pumSta(
        tWai=tWai,
        thehol_up=0.9,
        n=n,
        thehol_down=0.6)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      Modelica.Blocks.Interfaces.BooleanInput On "On signal"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealInput sta[n] "Speeds of pumps"
        annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
      Modelica.Blocks.Interfaces.RealInput dpMea "Measured pressure drop"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Math.Product product[n]
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Modelica.Blocks.Interfaces.RealOutput y[n] "Connector of Real output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      Modelica.Blocks.Routing.Replicator replicator(nout=n)
        annotation (Placement(transformation(extent={{56,-40},{76,-20}})));
      MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
        conPI(k=0.001, Ti=60)
        annotation (Placement(transformation(extent={{18,-20},{38,0}})));
      Modelica.Blocks.Interfaces.RealInput dpSet
        "Static differential pressure setpoint for the secondary pump"
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
    equation
      connect(pumSta.On, On) annotation (Line(points={{-52,8},{-66,8},{-80,
              8},{-80,80},{-120,80}}, color={255,0,255}));
      connect(pumSta.sta, sta) annotation (Line(points={{-52,-8},{-80,-8},{
              -80,-80},{-120,-80}}, color={0,0,127}));
      connect(product.y, y) annotation (Line(
          points={{41,50},{60,50},{80,50},{80,0},{110,0}},
          color={0,0,127}));
      connect(pumSta.y, product.u1) annotation (Line(points={{-29,0},{0,0},
              {0,56},{18,56}}, color={0,0,127}));
      connect(replicator.y, product.u2) annotation (Line(
          points={{77,-30},{90,-30},{90,-12},{58,-12},{58,24},{8,24},{8,44},{18,44}},
          color={0,0,127}));

      connect(conPI.On, On) annotation (Line(
          points={{16,-4},{-20,-4},{-20,80},{-120,80}},
          color={255,0,255}));
      connect(conPI.y, replicator.u) annotation (Line(
          points={{39,-10},{46,-10},{46,-30},{54,-30}},
          color={0,0,127}));
      connect(conPI.mea, dpMea) annotation (Line(points={{16,-16},{-92,-16},
              {-92,0},{-120,0}}, color={0,0,127}));
      connect(conPI.set, dpSet) annotation (Line(points={{16,-10},{-20,-10},
              {-20,-40},{-120,-40}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-156,104},{144,144}},
              textString="%name",
              textColor={0,0,255})}),           Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end SecPumCon;

  end Control;

  package BaseClasses

    model ValCon
        parameter Integer n= 2
        "the number of pumps";

      Modelica.Blocks.Interfaces.RealInput On[n] "On signal"    annotation (Placement(transformation(extent={{-118,-9},
                {-100,9}})));
      Modelica.Blocks.Interfaces.RealOutput y[n] "On signal"
        annotation (Placement(transformation(extent={{100,-9},{118,9}})));

    equation

        for i in 1:n loop
          y[i] =noEvent(if On[i]>0.01 then 1 else 0);
        end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,102},{150,142}},
              textString="%name",
              textColor={0,0,255})}),           Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end ValCon;
  end BaseClasses;

annotation ();
end Pump;
