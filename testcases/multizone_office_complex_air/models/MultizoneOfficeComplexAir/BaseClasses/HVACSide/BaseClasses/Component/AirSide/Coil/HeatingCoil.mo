within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil;
model HeatingCoil
  extends MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.BaseClasses.WatCoil;
  parameter Modelica.Units.SI.Efficiency eps(max=1) = 0.8
    "Heat exchanger effectiveness";

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.BaseClasses.DryCoil coi(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat,
    mWatFloRat=mWatFloRat,
    PreDroAir(displayUnit="Pa") = PreDroAir,
    PreDroWat(displayUnit="Pa") = 0,
    eps=eps) annotation (Placement(transformation(extent={{-18,-34},{20,
            8}})));
equation
  connect(coi.port_a_Wat, port_a_Wat) annotation (Line(
      points={{-18,-0.4},{-40,-0.4},{-40,0},{-60,0},{-60,80},{-100,80}},
      color={0,127,255},
      thickness=1));
  connect(coi.port_b_Wat, val.port_a) annotation (Line(
      points={{20,-0.4},{80,-0.4},{80,36}},
      color={0,127,255},
      thickness=1));
  connect(coi.port_a_Air, port_a_Air) annotation (Line(
      points={{20,-25.6},{30,-25.6},{30,-26},{40,-26},{40,-80},{100,-80}},
      color={0,127,255},
      thickness=1));
  connect(coi.port_b_Air, port_b_Air) annotation (Line(
      points={{-18,-25.6},{-58,-25.6},{-58,-80},{-102,-80}},
      color={0,127,255},
      thickness=1));
  connect(coi.TAirLea,pI.mea)  annotation (Line(
      points={{21.9,-17.2},{58,-17.2},{58,-60},{-52,-60},{-52,14},{-42,
          14}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(graphics={
        Line(
          points={{-90,80},{-40,80}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,80},{90,80}},
          color={0,0,127},
          thickness=0.5),
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
          points={{-40,80},{-40,40}},
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
          textString="+"),
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
          thickness=0.5),
        Line(
          points={{40,80},{40,40}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{32,72},{48,72}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{30,46},{50,46}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{32,72},{50,46}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{30,46},{48,72}},
          color={0,0,127},
          thickness=0.5),
        Text(
          extent={{-148,102},{152,142}},
          textString="%name",
          textColor={0,0,255})}));
end HeatingCoil;
