within IDEAS.Experimental.Electric.Batteries.DC;
model BatterySystemGeneral
  extends DC.Partials.BatterySystem;

  // Variables
  Modelica.SIunits.Power Pnet "Power available to charge/discharge battery";

  // Models
  Modelica.Electrical.Analog.Interfaces.NegativePin pin annotation (Placement(transformation(extent={{-106,-10},{-86,10}},
          rotation=0)));

  IDEAS.Experimental.Electric.Batteries.Control.BatteryCtrlGeneral batteryCtrlGeneral(
    DOD_max=DOD_max,
    EBat=3600000*EBat,
    eta_out=technology.eta_out,
    eta_in=technology.eta_in,
    eta_c=technology.eta_c,
    eta_d=technology.eta_d,
    e_c=technology.e_c,
    e_d=technology.e_d,
    P=Pnet) annotation (Placement(transformation(extent={{20,0},{40,20}})));

equation
  connect(wattsLaw.vi[1], pin) annotation (Line(
      points={{-20,30},{-20,0},{-96,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(batteryCtrlGeneral.PFinal, wattsLaw.P) annotation (Line(
      points={{20,13},{10,13},{10,20},{0,20},{0,40},{-46,40},{-46,32},{-40,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(battery.SoC_out, batteryCtrlGeneral.SoC) annotation (Line(
      points={{60,7},{40,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(batteryCtrlGeneral.PInit, battery.PFlow) annotation (Line(
      points={{40,13},{60,13}},
      color={0,0,127},
      smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),       graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Polygon(
          points={{-62,40},{-62,-40},{72,-40},{72,40},{-62,40}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{58,32},{58,-30},{32,-30},{10,32},{58,32}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,32},{20,-30},{0,-30},{-22,32},{-2,32}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-74,12},{-74,-12},{-62,-12},{-62,12},{-74,12}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})},
          defaultComponentName="battery",
          defaultComponentPrefixes="inner"));
end BatterySystemGeneral;
