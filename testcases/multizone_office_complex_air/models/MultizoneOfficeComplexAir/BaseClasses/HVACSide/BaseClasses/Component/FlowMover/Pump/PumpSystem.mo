within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump;
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
