within IDEAS.Experimental.Electric.Photovoltaics;
model PVSystemGeneral "PV system with separate shut-down controller"

  parameter Real amount=1;
  parameter Real inc=34/180*Modelica.Constants.pi "inclination";
  parameter Real azi=0 "azimuth";

  parameter Integer prod=1;

  parameter Modelica.SIunits.Time timeOff=300;
  parameter Modelica.SIunits.Voltage VMax=253
    "Max grid voltage for operation of the PV system";

  parameter Integer numPha=1;
  output Real PInit;
  output Real PFinal;

  replaceable parameter IDEAS.Experimental.Electric.Data.Interfaces.PvPanel pvPanel=
      Data.PvPanels.SanyoHIP230HDE1() "Choose a Photovoltaic panel to be used"
    annotation (choicesAllMatching=true);

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin pin[
    numPha] annotation (Placement(transformation(extent={{92,30},{112,50}},
          rotation=0)));

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.PvArray pvArray(
    amount=amount,
    azi=azi,
    inc=inc,
    pvPanel=pvPanel) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,32})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.SimpleInverter invertor
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-26,-14},{-6,6}})));
  IDEAS.Experimental.Electric.BaseClasses.AC.WattsLaw wattsLaw(numPha=numPha)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  IDEAS.Experimental.Electric.Photovoltaics.Components.PvVoltageToPower vi2PQ
    annotation (Placement(transformation(extent={{-6,20},{14,40}})));

  IDEAS.Experimental.Electric.Photovoltaics.Components.PvVoltageCtrlGeneral pvVoltageCtrl(
    VMax=VMax,
    timeOff=timeOff,
    numPha=numPha)
    annotation (Placement(transformation(extent={{26,20},{46,40}})));
equation
  PInit = pvVoltageCtrl.PInit;
  PFinal = pvVoltageCtrl.PFinal;
  connect(pvArray.p, invertor.p1) annotation (Line(
      points={{-60,32},{-56,32},{-56,35},{-40,35}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(invertor.n1, ground1.p) annotation (Line(
      points={{-40,25},{-44,25},{-44,6},{-16,6}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(invertor.n2, ground1.p) annotation (Line(
      points={{-20,25},{-16,25},{-16,6}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(pvArray.n, ground1.p) annotation (Line(
      points={{-80,32},{-84,32},{-84,6},{-16,6}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(wattsLaw.vi, pin) annotation (Line(
      points={{80,30},{92,30},{92,40},{102,40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(invertor.p2, vi2PQ.pin) annotation (Line(
      points={{-20,35},{-10,35},{-10,36},{-6,36}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(vi2PQ.P, pvVoltageCtrl.PInit) annotation (Line(
      points={{14,36},{20,36},{20,34},{26,34}},
      color={135,135,135},
      smooth=Smooth.None));
  connect(vi2PQ.Q, pvVoltageCtrl.QInit) annotation (Line(
      points={{14,32},{20,32},{20,24},{26,24}},
      color={135,135,135},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.PFinal, wattsLaw.P) annotation (Line(
      points={{46,34},{53,34},{53,36},{60.2,36}},
      color={135,135,135},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.QFinal, wattsLaw.Q) annotation (Line(
      points={{46,24},{54,24},{54,32},{60.2,32}},
      color={135,135,135},
      smooth=Smooth.None));
  connect(pin, pvVoltageCtrl.pin) annotation (Line(
      points={{102,40},{92,40},{92,4},{42,4},{42,20}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Polygon(
          points={{-80,60},{-60,80},{60,80},{80,60},{80,-60},{60,-80},{-60,-80},
              {-80,-60},{-80,60}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,80},{-40,-80}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{40,80},{40,-80}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-100,100},{100,-100}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="#")}), Diagram(graphics));
end PVSystemGeneral;
