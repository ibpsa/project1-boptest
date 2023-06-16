within BuildingControlEmulator.Subsystems.Pump;
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
  Devices.FlowMover.BaseClasses.WithoutMotor                  pum[n](
    redeclare package Medium = Medium,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    PreCur=PreCur,
    TimCon=900,
    VarSpeFloMov(addPowerToMedium=false))
                         annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput SpeSig[n] "On signal"
    annotation (Placement(transformation(extent={{-118,71},{-100,89}})));
  Modelica.Blocks.Interfaces.RealOutput SpeRat[n]
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
    annotation (Placement(transformation(extent={{-12,50},{8,70}})));
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal[n]
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
equation

  for i in 1:n loop
   connect(pum[i].Rat, SpeRat[i]);
   connect(pum[i].port_a, port_a);
   connect(val[i].port_b, port_b);
   connect(pum[i].P, P[i]);
     connect(pum[i].port_b, val[i].port_a);
  end for;


  connect(pum.u, SpeSig) annotation (Line(
      points={{-11,6},{-80,6},{-80,80},{-109,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(valCon.On, SpeSig) annotation (Line(
      points={{-12.9,60},{-36,60},{-60,60},{-60,80},{-109,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(valCon.y, val.y) annotation (Line(
      points={{8.9,60},{30,60},{52,60},{52,12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
end PumpSystem;
