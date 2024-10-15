within IDEAS.Experimental.Electric.Distribution.AC.Components;
model MvLvTransformer_1P
  "Single-phase equivalent of medium to low-voltage transfomer for three-phase grids"

  replaceable parameter
    IDEAS.Experimental.Electric.Data.Interfaces.TransformerImp transformer
    "Choose a transformer" annotation (choicesAllMatching=true);

 parameter Boolean traTCal = true "Calculate transformer hot spot?" annotation (choices(
        choice=false "No hot spot calculations",
        choice=true "Hot spot calculations",
        __Dymola_radioButtons=true));

  parameter Real gridFreq=50
    "Grid frequency: should normally not be changed when simulating belgian grids!";
  parameter Modelica.SIunits.ComplexVoltage VSource=230 + 0*Modelica.ComplexMath.j "Voltage"
              annotation (choices(
      choice=(230*1) + 0*MCM.j "100% at HVpin of transformer",
      choice=(230*1.02) + 0*MCM.j "102% at HVpin of transformer",
      choice=(230*1.05) + 0*MCM.j "105% at HVpin of transformer",
      choice=(230*1.1) + 0*MCM.j "110% at HVpin of transformer",
      choice=(230*0.95) + 0*MCM.j "95% at HVpin of transformer",
      choice=(230*0.9) + 0*MCM.j "90% at HVpin of transformer"));

   final parameter Modelica.SIunits.HeatFlowRate traLosQRef=
       transformer.P0 + Modelica.ComplexMath.real(transformer.Zd)*(transformer.Sn/3/Modelica.ComplexMath.real(VSource))^2
       + Modelica.ComplexMath.real(transformer.Zi)*(transformer.Sn/3/Modelica.ComplexMath.real(VSource))^2
       + Modelica.ComplexMath.real(transformer.Z0)*(transformer.Sn/3/Modelica.ComplexMath.real(VSource))^2 if  traTCal;

   final parameter Modelica.SIunits.HeatCapacity CHs = transformer.tauHs/(RHs+RTo) if  traTCal;
   final parameter Modelica.SIunits.ThermalResistance RHs = (transformer.THs-transformer.TTo)/traLosQRef if  traTCal;
   final parameter Modelica.SIunits.HeatCapacity CTo = transformer.tauTo/RTo if  traTCal;
   final parameter Modelica.SIunits.ThermalResistance RTo = (transformer.TTo-transformer.TRef)/traLosQRef if  traTCal;

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
                  pin_lv_p
    annotation (Placement(transformation(extent={{90,50},{110,70}}),
        iconTransformation(extent={{90,50},{110,70}})));

// Output ----------------------------------------------------------------------

  Modelica.SIunits.ActivePower traLosP0 = transformer.P0
    "No-load losses (can be assumed constant)";
  Modelica.SIunits.ActivePower traLosPTot = transformer.P0 + phase1.Plos
    "Total losses in transformer";
   Modelica.SIunits.Temperature THs = capHotSpot.T if  traTCal
    "Hottest spot temperature";
   Modelica.SIunits.Temperature TTo = capOil.T if  traTCal
    "Top oil temperature";

protected
  parameter Boolean traHeatLosses = traTCal
    "Calculate heatlosses if hot spot temperature is calculated";

  BaseClasses.Branch phase1(R=Modelica.ComplexMath.real(transformer.Zd)/3, X=
        Modelica.ComplexMath.imag(transformer.Zd)/3,
    heatLosses=traHeatLosses)
    annotation (Placement(transformation(extent={{-10,50},{10,30}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    V=Modelica.ComplexMath.'abs'(VSource),
    phi=Modelica.ComplexMath.arg(VSource),
    f=gridFreq) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,14})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,-20})));
   IDEAS.Experimental.HeatTransfer.HeatCapacitor capHotSpot(C=CHs) if  traTCal        annotation (
       Placement(transformation(
         extent={{-10,-10},{10,10}},
         rotation=-90,
         origin={22,4})));
   IDEAS.Experimental.HeatTransfer.HeatCapacitor capOil(C=CTo) if  traTCal        annotation (Placement(
         transformation(
         extent={{-10,-10},{10,10}},
         rotation=-90,
         origin={22,-16})));
   IDEAS.Experimental.HeatTransfer.ThermalResistor resOil(R=RHs) if  traTCal        annotation (Placement(
         transformation(
         extent={{-10,-10},{10,10}},
         rotation=-90,
         origin={12,-6})));
   IDEAS.Experimental.HeatTransfer.ThermalResistor resOut(R=RTo) if  traTCal        annotation (Placement(
         transformation(
         extent={{-10,-10},{10,10}},
         rotation=-90,
         origin={12,-26})));
   Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature T_Bou if  traTCal annotation (
      Placement(transformation(
         extent={{10,-10},{-10,10}},
         rotation=-90,
         origin={12,-46})));
   Modelica.Blocks.Sources.RealExpression realExpr(y=sim.Te) if  traTCal annotation (
       Placement(transformation(
         extent={{-10,-10},{10,10}},
         rotation=90,
         origin={12,-80})));
  outer BoundaryConditions.SimInfoManager sim if
                                traTCal
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation

  connect(voltageSource.pin_n, ground.pin) annotation (Line(
      points={{-80,4},{-80,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource.pin_p, phase1.pin_p) annotation (Line(
      points={{-80,24},{-80,40},{-10,40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(phase1.pin_n, pin_lv_p) annotation (Line(
      points={{10,40},{56,40},{56,60},{100,60}},
      color={85,170,255},
      smooth=Smooth.None));

  if   traTCal then
   connect(capHotSpot.port, resOil.port_a) annotation (Line(
       points={{12,4},{12,4}},
       color={191,0,0},
       smooth=Smooth.None));
   connect(resOil.port_b, capOil.port) annotation (Line(
       points={{12,-16},{12,-16}},
       color={191,0,0},
       smooth=Smooth.None));
   connect(resOil.port_b, resOut.port_a) annotation (Line(
       points={{12,-16},{12,-16}},
       color={191,0,0},
       smooth=Smooth.None));
   connect(resOut.port_b, T_Bou.port) annotation (Line(
       points={{12,-36},{12,-36}},
       color={191,0,0},
       smooth=Smooth.None));
   connect(realExpr.y, T_Bou.T) annotation (Line(
       points={{12,-69},{12,-58}},
       color={0,0,127},
       smooth=Smooth.None));
   connect(resOil.port_b, resOut.port_a) annotation (Line(
       points={{12,-16},{12,-16}},
       color={191,0,0},
       smooth=Smooth.None));
  connect(phase1.port_a, capHotSpot.port) annotation (Line(
      points={{2,38},{12,38},{12,4}},
      color={191,0,0},
      smooth=Smooth.None));
  end if;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                          graphics), Documentation(info="<html>
      <p>Select the Rated Power for the Transformer as apparent power<b> Sn</b>! Only three-phase transformers!</p>
      <p>This will set the winding impedance, which define the Joule losses and voltage drop over the transformer.</p>
      <p>Equivalent scheme of a three-phase transformer, used to define the losses and voltage drops within the transformer. Therefore, the input voltage is the secondary nominal voltage, e.g., 230 V.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={
        Line(
          points={{10,60},{10,-60},{10,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{20,60},{20,-60},{20,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-70,40},{-18,40},{0,30},{-20,20},{0,10},{-20,0},{0,-10},{-20,
              -20},{0,-30},{-20,-40},{-70,-40}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{48,60},{48,40},{30,30},{50,20},{30,10},{50,0},{30,-10},{50,
              -20},{30,-30},{50,-40},{50,-60}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{48,60},{100,60}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{50,-60},{50,-60}},
          color={85,170,255},
          smooth=Smooth.None),
        Ellipse(
          extent={{-90,20},{-50,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,40},{-70,20}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{-70,-20},{-70,-40}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{-82,2},{-78,10},{-74,10},{-68,-10}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-60,-2},{-64,-10},{-68,-10},{-74,10}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{50,-60},{80,-60},{80,40},{140,40}},
          color={85,170,255},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}));
end MvLvTransformer_1P;
