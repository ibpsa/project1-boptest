within IDEAS.Experimental.Electric.Photovoltaics;
model PvSystemGeneralFromFile "PV system with separate shut-down controller"

  parameter Real PNom "Nominal power, in Wp";
  parameter Integer prod=1;

  parameter Modelica.SIunits.Time timeOff=300;
  parameter Modelica.SIunits.Voltage VMax=253
    "Max grid voltage for operation of the PV system";

  parameter Integer numPha=1;
  output Real PInit;
  output Real PFinal;
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin pin[
    numPha] annotation (Placement(transformation(extent={{92,30},{112,50}},
          rotation=0)));

  IDEAS.Experimental.Electric.Photovoltaics.Components.ForInputFiles.SimpleDCAC_effP
    inverter(PNom=PNom)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  IDEAS.Experimental.Electric.BaseClasses.AC.WattsLaw wattsLaw(numPha=numPha)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));

  IDEAS.Experimental.Electric.Photovoltaics.Components.PvVoltageCtrlGeneral pvVoltageCtrl(
    VMax=VMax,
    timeOff=timeOff,
    numPha=numPha)
    annotation (Placement(transformation(extent={{26,20},{46,40}})));
  outer
    IDEAS.Experimental.Electric.Photovoltaics.Components.ForInputFiles.PVProfileReader
    PV1 annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  inverter.P_dc = PV1.P_ratio*PNom;
  connect(wattsLaw.vi, pin) annotation (Line(
      points={{80,30},{92,30},{92,40},{102,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.PFinal, wattsLaw.P) annotation (Line(
      points={{46,36},{53,36},{53,36},{60.2,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.QFinal, wattsLaw.Q) annotation (Line(
      points={{46,32},{54,32},{54,32},{60.2,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pin, pvVoltageCtrl.pin) annotation (Line(
      points={{102,40},{92,40},{92,4},{42,4},{42,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter.P, pvVoltageCtrl.PInit) annotation (Line(
      points={{-19.4,36},{4,36},{4,36},{26,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(inverter.Q, pvVoltageCtrl.QInit) annotation (Line(
      points={{-19.6,32},{4,32},{4,32},{26,32}},
      color={0,0,127},
      smooth=Smooth.None));
  PInit = pvVoltageCtrl.PInit;
  PFinal = pvVoltageCtrl.PFinal;
  annotation (Icon(graphics={
        Polygon(
          points={{-80,60},{-60,80},{60,80},{80,60},{80,-60},{60,-80},{-60,-80},
              {-80,-60},{-80,60}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{100,-100}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="#"),
        Line(
          points={{-40,80},{-40,-80}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{40,80},{40,-80}},
          color={0,0,0},
          smooth=Smooth.None)}), Diagram(graphics));
end PvSystemGeneralFromFile;
