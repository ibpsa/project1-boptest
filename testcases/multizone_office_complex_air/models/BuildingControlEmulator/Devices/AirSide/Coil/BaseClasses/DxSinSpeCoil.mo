within BuildingControlEmulator.Devices.AirSide.Coil.BaseClasses;
model DxSinSpeCoil
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.Pressure PreDroAir
    "Pressure drop in the air side";

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.SingleSpeed
                                                   coi(redeclare package Medium
      = MediumAir,
    datCoi=datCoi,
    dp_nominal=PreDroAir,
    T_start=datCoi.sta[1].nomVal.TEvaIn_nominal,
    show_T=true,
    from_dp=true)
    annotation (Placement(transformation(extent={{10,-8},{-10,12}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temEntAir(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Modelica.Fluid.Sensors.MassFlowRate masFloAir(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temLeaAir(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{-68,-70},{-88,-50}})));
  Modelica.Fluid.Sensors.Pressure preAirLea(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-30,-46},{-50,-26}})));
  Modelica.Fluid.Sensors.Pressure preAirEnt(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{50,-44},{30,-24}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium =
        MediumAir)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium =
        MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.RealOutput TAirLea
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealInput TConIn
    "Outside air dry bulb temperature for an air cooled condenser or wetbulb temperature for an evaporative cooled condenser"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Interfaces.BooleanInput on
    "Set to true to enable compressor, or false to disable compressor"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  replaceable parameter
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil datCoi
    constrainedby
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil
    "Performance data"
    annotation (Placement(transformation(extent={{64,82},{76,94}})));
equation
  connect(temEntAir.port_a,port_a_Air)  annotation (Line(
      points={{50,-60},{100,-60}},
      color={0,127,255},
      thickness=1));
  connect(temLeaAir.port_a, masFloAir.port_b) annotation (Line(
      points={{-68,-60},{-60,-60}},
      color={0,127,255},
      thickness=1));
  connect(temLeaAir.port_b,port_b_Air)  annotation (Line(
      points={{-88,-60},{-100,-60}},
      color={0,127,255},
      thickness=1));
  connect(temLeaAir.T,TAirLea)  annotation (Line(
      points={{-78,-49},{-78,-20},{110,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(coi.TConIn, TConIn) annotation (Line(
      points={{11,5},{54,5},{54,38},{-28,38},{-28,40},{-110,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(coi.on, on) annotation (Line(
      points={{11,10},{40,10},{40,80},{-110,80}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(temEntAir.port_b, coi.port_a) annotation (Line(
      points={{30,-60},{26,-60},{20,-60},{20,2},{10,2}},
      color={0,127,255},
      thickness=1));
  connect(preAirEnt.port, coi.port_a) annotation (Line(
      points={{40,-44},{20,-44},{20,2},{10,2}},
      color={0,127,255},
      thickness=1));
  connect(coi.port_b, masFloAir.port_a) annotation (Line(
      points={{-10,2},{-16,2},{-20,2},{-20,-60},{-40,-60}},
      color={0,127,255},
      thickness=1));
  connect(preAirLea.port, masFloAir.port_a) annotation (Line(
      points={{-40,-46},{-20,-46},{-20,-60},{-40,-60}},
      color={0,127,255},
      thickness=1));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-40,60},{-40,-60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,60},{40,-60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,-60},{40,-60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,60},{40,60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-40,60},{40,-60}},
          color={0,0,127},
          thickness=0.5),
        Text(
          extent={{-46,-16},{8,-58}},
          lineColor={0,0,127},
          lineThickness=0.5,
          textString="-"),
        Line(
          points={{-90,-60},{-40,-60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,-60},{90,-60}},
          color={0,0,127},
          thickness=0.5)}),  Diagram(coordinateSystem(preserveAspectRatio=false)));
end DxSinSpeCoil;
