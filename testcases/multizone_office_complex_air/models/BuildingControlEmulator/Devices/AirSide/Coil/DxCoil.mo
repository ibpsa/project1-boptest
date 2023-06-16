within BuildingControlEmulator.Devices.AirSide.Coil;
model DxCoil
  import BuildingControlEmulator;
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.Pressure PreDroAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Time minOffTim(min=0) = 0 "Minimum off time";
  parameter Modelica.Units.SI.Time minOnTim(min=0) = 0 "Minimum on time";
  parameter Real dT
      "Temperature control deadband";

  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium = MediumAir)
                                                   "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,-90},{-92,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium = MediumAir)
                                                   "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  BuildingControlEmulator.Devices.AirSide.Coil.Control.OnOffSta
                                             pI(
    minOffTim=minOffTim,
    minOnTim=minOnTim,
    dT=dT,
    OffTim(start=0),
    OnTim(start=0))                             annotation (Placement(transformation(extent={{-52,10},{-32,30}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  BuildingControlEmulator.Devices.AirSide.Coil.BaseClasses.DxSinSpeCoil
                                                                dxSinSpeCoil(
    redeclare package MediumAir = MediumAir,
    mAirFloRat=mAirFloRat,
    PreDroAir=PreDroAir,
    datCoi=datCoi)       annotation (Placement(transformation(extent={{-16,-30},{18,8}})));
  Modelica.Blocks.Interfaces.RealInput Mea "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput TConIn
    "Outside air dry bulb temperature for an air cooled condenser or wetbulb temperature for an evaporative cooled condenser"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  replaceable parameter
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil datCoi
    constrainedby
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil
    "Performance data"
    annotation (Placement(transformation(extent={{64,62},{76,74}})));
equation
  connect(pI.SetPoi, SetPoi)
    annotation (Line(
      points={{-54,20},{-54,20},{-70,20},{-70,40},{-120,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pI.OnSigIn, On) annotation (Line(
      points={{-54,26},{-80,26},{-80,80},{-120,80}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(dxSinSpeCoil.on, pI.OnSigOut)
    annotation (Line(
      points={{-17.7,4.2},{-26,4.2},{-26,20},{-31,20}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(dxSinSpeCoil.port_b_Air, port_b_Air)
    annotation (Line(
      points={{-16,-22.4},{-40,-22.4},{-40,-80},{-60,-80},{-60,-80},{-102,-80}},
      color={0,127,255},
      thickness=1));
  connect(dxSinSpeCoil.port_a_Air, port_a_Air)
    annotation (Line(
      points={{18,-22.4},{60,-22.4},{60,-80},{100,-80}},
      color={0,127,255},
      thickness=1));
  connect(dxSinSpeCoil.TConIn, TConIn)
    annotation (Line(
      points={{-17.7,-3.4},{-72,-3.4},{-72,-40},{-120,-40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(dxSinSpeCoil.TAirLea, pI.Mea) annotation (Line(
      points={{19.7,-14.8},{40,-14.8},{40,-62},{-80,-62},{-80,14},{-54,14}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-40,40},{-40,-80}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,40},{40,-80}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,-80},{40,-80}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,40},{40,-80}},
          color={0,0,127},
          thickness=0.5),
        Text(
          extent={{-10,50},{44,8}},
          lineColor={0,0,127},
          lineThickness=0.5,
          textString="-"),
        Line(
          points={{-92,-80},{-40,-80}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,-80},{90,-80}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,40},{40,40}},
          color={0,0,127},
          thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)));
end DxCoil;
