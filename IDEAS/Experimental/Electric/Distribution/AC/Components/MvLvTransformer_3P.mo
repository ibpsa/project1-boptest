within IDEAS.Experimental.Electric.Distribution.AC.Components;
model MvLvTransformer_3P
  "Medium to low-voltage transfomer for three-phase grids"

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
                  pin_lv_p[3]
    annotation (Placement(transformation(extent={{90,50},{110,70}}),
        iconTransformation(extent={{90,50},{110,70}})));

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
                  pin_lv_n
    "This should NOT be connected for single phase equivalent circuits"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
        iconTransformation(extent={{90,-70},{110,-50}})));

// Output ----------------------------------------------------------------------

  Modelica.SIunits.ActivePower traLosP0 = transformer.P0
    "No-load losses (can be assumed constant)";
  Modelica.SIunits.ActivePower traLosPTot = transformer.P0 + phase1.Plos + phase2.Plos + phase3.Plos
    "Total losses in transformer";
   Modelica.SIunits.Temperature THs = capHotSpot.T if   traTCal
    "Hottest spot temperature";
   Modelica.SIunits.Temperature TTo = capOil.T if   traTCal
    "Top oil temperature";

protected
  parameter Boolean traHeatLosses = traTCal
    "Calculate heatlosses if hot spot temperature is calculated";

  IDEAS.Experimental.Electric.BaseClasses.AC.Con3PlusNTo3 con3PlusNTo3_HV
    annotation (Placement(transformation(extent={{-60,50},{-40,30}})));
  IDEAS.Experimental.Electric.BaseClasses.AC.Con3PlusNTo3 con3PlusNTo3_LV
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,40})));

  BaseClasses.Branch phase1(R=Modelica.ComplexMath.real(transformer.Zd), X=
        Modelica.ComplexMath.imag(transformer.Zd),
    heatLosses=traHeatLosses)
    annotation (Placement(transformation(extent={{-6,60},{14,40}})));
  BaseClasses.Branch phase2(R=Modelica.ComplexMath.real(transformer.Zi), X=
        Modelica.ComplexMath.imag(transformer.Zi),
    heatLosses=traHeatLosses)
    annotation (Placement(transformation(extent={{-10,50},{10,30}})));
  BaseClasses.Branch phase3(R=Modelica.ComplexMath.real(transformer.Z0), X=
        Modelica.ComplexMath.imag(transformer.Z0),
    heatLosses=traHeatLosses)
    annotation (Placement(transformation(extent={{-14,40},{6,20}})));

  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource[3]
    voltageSource(
    each V=Modelica.ComplexMath.'abs'(VSource),
    phi={Modelica.ComplexMath.arg(
        VSource),Modelica.ComplexMath.arg(VSource) + 2*Modelica.Constants.pi/3,
        Modelica.ComplexMath.arg(VSource) + 4*Modelica.Constants.pi/3},
    each f=gridFreq) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,14})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,-20})));
   IDEAS.Experimental.HeatTransfer.HeatCapacitor capHotSpot(C=CHs) if   traTCal       annotation (
       Placement(transformation(
         extent={{-10,-10},{10,10}},
         rotation=-90,
         origin={22,4})));
   IDEAS.Experimental.HeatTransfer.HeatCapacitor capOil(C=CTo) if   traTCal       annotation (Placement(
         transformation(
         extent={{-10,-10},{10,10}},
         rotation=-90,
         origin={22,-16})));
   IDEAS.Experimental.HeatTransfer.ThermalResistor resOil(R=RHs) if   traTCal       annotation (Placement(
         transformation(
         extent={{-10,-10},{10,10}},
         rotation=-90,
         origin={12,-6})));
   IDEAS.Experimental.HeatTransfer.ThermalResistor resOut(R=RTo) if   traTCal       annotation (Placement(
         transformation(
         extent={{-10,-10},{10,10}},
         rotation=-90,
         origin={12,-26})));
   Modelica.Thermal.HeatTransfer.Components.ThermalCollector thColl if   traTCal
     annotation (Placement(transformation(extent={{2,4},{22,24}})));
   Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature T_Bou if   traTCal annotation (
      Placement(transformation(
         extent={{10,-10},{-10,10}},
         rotation=-90,
         origin={12,-46})));
   Modelica.Blocks.Sources.RealExpression realExpr(y=sim.Te) if   traTCal annotation (
       Placement(transformation(
         extent={{-10,-10},{10,10}},
         rotation=90,
         origin={12,-80})));
  outer BoundaryConditions.SimInfoManager sim if
                                 traTCal
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(pin_lv_p, con3PlusNTo3_LV.fourWire[1:3])
                                                annotation (Line(
      points={{100,60},{86,60},{86,40},{74,40},{74,39.75},{60,39.75}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(pin_lv_n, con3PlusNTo3_LV.fourWire[4])
                                             annotation (Line(
      points={{100,-60},{86,-60},{86,39.25},{60,39.25}},
      color={85,170,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(con3PlusNTo3_HV.threeWire[1], phase1.pin_p)
                                                     annotation (Line(
      points={{-40,40.6667},{-30,40.6667},{-30,50},{-6,50}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(con3PlusNTo3_HV.threeWire[2], phase2.pin_p)
                                                     annotation (Line(
      points={{-40,40},{-10,40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(con3PlusNTo3_HV.threeWire[3], phase3.pin_p)
                                                     annotation (Line(
      points={{-40,39.3333},{-30,39.3333},{-30,30},{-14,30}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(phase1.pin_n, con3PlusNTo3_LV.threeWire[1])
                                                     annotation (Line(
      points={{14,50},{30,50},{30,40.6667},{40,40.6667}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(phase2.pin_n, con3PlusNTo3_LV.threeWire[2])
                                                     annotation (Line(
      points={{10,40},{40,40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(phase3.pin_n, con3PlusNTo3_LV.threeWire[3])
                                                     annotation (Line(
      points={{6,30},{30,30},{30,39.3333},{40,39.3333}},
      color={85,170,255},
      smooth=Smooth.None));

  connect(ground.pin, con3PlusNTo3_HV.fourWire[4]) annotation (Line(
      points={{-80,-20},{-70,-20},{-70,39.25},{-60,39.25}},
      color={85,170,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(ground.pin, pin_lv_n) annotation (Line(
      points={{-80,-20},{-80,-20},{80,-20},{80,-60},{100,-60}},
      color={85,170,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

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
   connect(thColl.port_b, resOil.port_a) annotation (Line(
       points={{12,4},{12,4}},
       color={191,0,0},
       smooth=Smooth.None));
   connect(phase1.port_a, thColl.port_a[1]) annotation (Line(
       points={{6,48},{12,48},{12,24.6667}},
       color={191,0,0},
       smooth=Smooth.None));
   connect(phase2.port_a, thColl.port_a[2]) annotation (Line(
       points={{2,38},{12,38},{12,24}},
       color={191,0,0},
       smooth=Smooth.None));
   connect(phase3.port_a, thColl.port_a[3]) annotation (Line(
       points={{-2,28},{12,28},{12,23.3333}},
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
      end if;
  connect(voltageSource[1].pin_p, con3PlusNTo3_HV.fourWire[1]) annotation (Line(
      points={{-80,24},{-80,40.75},{-60,40.75}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource[2].pin_p, con3PlusNTo3_HV.fourWire[2]) annotation (Line(
      points={{-80,24},{-80,40.25},{-60,40.25}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource[3].pin_p, con3PlusNTo3_HV.fourWire[3]) annotation (Line(
      points={{-80,24},{-80,39.75},{-60,39.75}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource[1].pin_n, ground.pin) annotation (Line(
      points={{-80,4},{-80,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource[2].pin_n, ground.pin) annotation (Line(
      points={{-80,4},{-80,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource[3].pin_n, ground.pin) annotation (Line(
      points={{-80,4},{-80,-20}},
      color={85,170,255},
      smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                          graphics), Documentation(info="<html>
      <p>Select the Rated Power for the Transformer as apparent power<b> Sn</b>! Only three-phase transformers!</p>
      <p>This will set the winding impedance, which define the Joule losses and voltage drop over the transformer.</p>
      <p>Equivalent scheme of a three-phase transformer, used to define the losses and voltage drops within the transformer. Therefore, the input voltage is the secondary nominal voltage, e.g., 230 V.</p>
</html>", revisions="<html>
<ul>
<li>
January 26, 2015 by Juan Van Roy:<br/>
Small changes.
</li>
</ul>
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
          points={{50,-60},{100,-60}},
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
          smooth=Smooth.None)}));
end MvLvTransformer_3P;
