within IDEAS.Experimental.Electric.BaseClasses.Converters.Examples;
model Inverter_1phase
extends Modelica.Icons.Example;
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=400)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={56,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(
            useHeatPort=false, R_ref=50)
                               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor
    voltageSensor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-20})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor
    voltageSensor1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-20})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    f=50,
    V=230,
    phi=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-20})));
  Converters.ConvertersPin.Inverter inverter(
    inverter=true, eff=0.95)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=20) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,10})));
equation
  connect(voltageSensor1.pin_p, resistor.pin_n) annotation (Line(
      points={{-60,-10},{-60,1.22465e-015},{-40,1.22465e-015}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource.pin_p, resistor.pin_n) annotation (Line(
      points={{-80,-10},{-80,1.22465e-015},{-40,1.22465e-015}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(constantVoltage.n, inverter.pin_nDC) annotation (Line(
      points={{56,-10},{10,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground1.p, inverter.pin_nDC) annotation (Line(
      points={{10,-40},{10,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(voltageSensor.pin_n, resistor.pin_p) annotation (Line(
      points={{-20,-10},{-20,-1.22465e-015}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(resistor1.n, inverter.pin_pDC) annotation (Line(
      points={{20,10},{10,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor1.p, constantVoltage.p) annotation (Line(
      points={{40,10},{56,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(voltageSource.pin_n, ground.pin) annotation (Line(
      points={{-80,-30},{-80,-40},{-60,-40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSensor1.pin_n, ground.pin) annotation (Line(
      points={{-60,-30},{-60,-40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSensor.pin_p, ground.pin) annotation (Line(
      points={{-20,-30},{-20,-40},{-60,-40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(resistor.pin_p, inverter.pin_pAC[1]) annotation (Line(
      points={{-20,0},{-10.8,0}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end Inverter_1phase;
