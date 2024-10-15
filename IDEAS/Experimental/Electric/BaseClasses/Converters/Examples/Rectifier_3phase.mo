within IDEAS.Experimental.Electric.BaseClasses.Converters.Examples;
model Rectifier_3phase
extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Resistor resistor(R=380) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,10})));
  Converters.ConvertersPin.Rectifier aCDC_Singlephase(
    inverter=false,
    numPha=3,
    eff=0.95)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource1(
    f=50,
    V=230,
    phi=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-10})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground2
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource2(
    f=50,
    V=230,
    phi(displayUnit="rad") = 2*Modelica.Constants.pi/3)
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-22})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground3
    annotation (Placement(transformation(extent={{-60,-72},{-40,-52}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource3(
    f=50,
    V=230,
    phi=4*Modelica.Constants.pi/3)
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-30})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground4
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
equation
  connect(aCDC_Singlephase.pin_pDC, resistor.n) annotation (Line(
      points={{10,10},{40,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.p, aCDC_Singlephase.pin_nDC) annotation (Line(
      points={{60,10},{70,10},{70,-10},{10,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(aCDC_Singlephase.pin_nDC, ground1.p) annotation (Line(
      points={{10,-10},{10,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(voltageSource1.pin_p, aCDC_Singlephase.pin_pAC[1]) annotation (Line(
      points={{-70,0},{-40.4,0},{-40.4,0.666667},{-10.8,0.666667}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource2.pin_p, aCDC_Singlephase.pin_pAC[2]) annotation (Line(
      points={{-50,-12},{-30,-12},{-30,-5.55112e-017},{-10.8,-5.55112e-017}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource3.pin_p, aCDC_Singlephase.pin_pAC[3]) annotation (Line(
      points={{-30,-20},{-20,-20},{-20,-0.666667},{-10.8,-0.666667}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ground2.pin, voltageSource1.pin_n) annotation (Line(
      points={{-70,-40},{-70,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ground3.pin, voltageSource2.pin_n) annotation (Line(
      points={{-50,-52},{-50,-32}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ground4.pin, voltageSource3.pin_n) annotation (Line(
      points={{-30,-60},{-30,-40}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end Rectifier_3phase;
