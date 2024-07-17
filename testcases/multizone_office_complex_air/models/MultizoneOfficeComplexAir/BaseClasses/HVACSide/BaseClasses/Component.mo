within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses;
package Component "System conmponent models"

  model conPI "PI Controller with ON/OFF Signal"

    parameter Real yMin(min=0, max=1, unit="1") = 0
      "Lowest y output";
    parameter Real k(min=0, unit="1") = 1 "Gain of controller";
    parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
      "Time constant of Integrator block";
    parameter Boolean reverseActing=true
      "Set to true for reverse acting, or false for direct acting control action";
    Modelica.Blocks.Interfaces.BooleanInput On
      annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Buildings.Controls.OBC.CDL.Continuous.PIDWithReset
                                     conPID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=yMin,
      xi_start=0,
      k=k,
      Ti=Ti,
      reverseActing=reverseActing,
      y_reset=yMin)
      annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
    Modelica.Blocks.Interfaces.RealInput set
      "Connector of setpoint input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput mea
      "Connector of measurement input signal"
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
    Buildings.Controls.OBC.CDL.Continuous.Switch swi
      annotation (Placement(transformation(extent={{40,10},{60,-10}})));

    Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zerSpe(k=0)
      "Zero fan speed when it becomes OFF"
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));
  equation
    connect(conPID.u_s, set) annotation (Line(points={{-10,-20},{-66,-20},{
            -66,0},{-120,0}}, color={0,0,127}));
    connect(swi.y, y) annotation (Line(
        points={{62,0},{110,0}},
        color={0,0,127}));
    connect(mea, conPID.u_m) annotation (Line(
        points={{-120,-60},{-60,-60},{2,-60},{2,-32}},
        color={0,0,127}));
    connect(On, swi.u2) annotation (Line(points={{-120,60},{-40,60},{-40,0},{38,0}},
          color={255,0,255}));
    connect(conPID.y, swi.u1) annotation (Line(points={{14,-20},{20,-20},{20,-8},{
            38,-8}}, color={0,0,127}));
    connect(zerSpe.y, swi.u3)
      annotation (Line(points={{12,36},{30,36},{30,8},{38,8}}, color={0,0,127}));
    connect(On, conPID.trigger) annotation (Line(points={{-120,60},{-60,60},{-60,-40},
            {-4,-40},{-4,-32}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-66,50},{62,-48}},
            lineColor={0,127,255},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="PI"),
          Text(
            extent={{-152,110},{148,150}},
            textString="%name",
            textColor={0,0,255})}),        Diagram(coordinateSystem(
            preserveAspectRatio=false), graphics={Line(points={{32,-16}}, color={28,
                108,200})}),
      Documentation(info="<html>
<p>This model is a PI controller with an external boolean signal. When the boolean signal is true, the model outputs the PI controller output. When it is false, the model outputs zero.</p>
</html>"));
  end conPI;

  package AirSide "\"Models for device level components\""
    package AirHandlingUnit

      model DuaFanAirHanUnit "AHU with supply/return fans and cooling coil."

        replaceable package MediumAir =
            Modelica.Media.Interfaces.PartialMedium "Medium for the air";
        replaceable package MediumWat =
            Modelica.Media.Interfaces.PartialMedium "Medium for the water";
        parameter Real UA "Rated heat exchange coefficients";
        parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
        parameter Modelica.Units.SI.MassFlowRate mWatFloRat
          "mass flow rate for water";
        parameter Modelica.Units.SI.Pressure PreDroCoiAir
          "Pressure drop in the air side";
        parameter Modelica.Units.SI.Pressure PreDroMixingBoxAir
          "Pressure drop in the air side";
        parameter Modelica.Units.SI.Pressure PreDroWat
          "Pressure drop in the water side";
        parameter Real Coi_k(min=0, unit="1") = 1 "Gain of controller";
        parameter Modelica.Units.SI.Time Coi_Ti(min=Modelica.Constants.small) = 0.5
          "Time constant of Integrator block";
        parameter Modelica.Units.SI.Efficiency eps(max=1) = 1
          "Heat exchanger effectiveness";

        parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat
          "mass flow rate for fresh air";
        parameter Modelica.Units.SI.Temperature TemEcoHig
          "the highest temeprature when the economizer is on";
        parameter Modelica.Units.SI.Temperature TemEcoLow
          "the lowest temeprature when the economizer is on";
        parameter Real MixingBoxDamMin "the minimum damper postion";
        parameter Real MixingBox_k(min=0, unit="1") = 1 "Gain of controller";
        parameter Modelica.Units.SI.Time MixingBox_Ti(min=Modelica.Constants.small)=
             0.5 "Time constant of Integrator block";

        parameter Real Fan_k(min=0, unit="1") = 1 "Gain of controller";
        parameter Modelica.Units.SI.Time Fan_Ti(min=Modelica.Constants.small) = 0.5
          "Time constant of Integrator block";
        parameter Modelica.Units.SI.Time waitTime(min=0) = 0
          "Wait time before transition fires";
        parameter Real Fan_SpeRat
            "Speed ratio";
        parameter Integer numTemp(min=1) = 1
            "The size of the temeprature vector";
        parameter Real HydEff[:] "Hydraulic efficiency";
        parameter Real MotEff[:] "Motor efficiency";
        parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]
          "Volume flow rate curve";
        parameter Modelica.Units.SI.Pressure SupPreCur[:] "Supply Fan Pressure curve";
        parameter Modelica.Units.SI.Pressure RetPreCur[:] "Return Fan Pressure curve";

        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor
          retFan(
          redeclare package Medium = MediumAir,
          HydEff=HydEff,
          MotEff=MotEff,
          VolFloCur=VolFloCur,
          TimCon=1,
          PreCur=RetPreCur)
          annotation (Placement(transformation(extent={{-10,-90},{-30,-70}})));

        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.VAVSupFan
          supFan(
          redeclare package Medium = MediumAir,
          TimCon=1,
          k=Fan_k,
          Ti=Fan_Ti,
          waitTime=waitTime,
          SpeRat=Fan_SpeRat,
          numTemp=numTemp,
          HydEff=HydEff,
          MotEff=MotEff,
          VolFloCur=VolFloCur,
          PreCur=SupPreCur)
          annotation (Placement(transformation(extent={{18,-10},{38,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package
            Medium = MediumAir)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.CoolingCoil
          cooCoi(
          redeclare package MediumAir = MediumAir,
          redeclare package MediumWat = MediumWat,
          mAirFloRat=mAirFloRat,
          mWatFloRat=mWatFloRat,
          PreDroAir=PreDroCoiAir,
          PreDroWat=PreDroWat,
          k=Coi_k,
          Ti=Coi_Ti,
          UA=UA*1.2*eps)
          annotation (Placement(transformation(extent={{-2,-2},{-20,18}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox.MixingBoxWithControl
          mixBox(
          mTotAirFloRat=mAirFloRat,
          redeclare package Medium = MediumAir,
          PreDro=PreDroMixingBoxAir,
          mFreAirFloRat=mFreAirFloRat,
          TemHig=TemEcoHig,
          TemLow=TemEcoLow,
          DamMin=MixingBoxDamMin,
          k=MixingBox_k,
          Ti=MixingBox_Ti) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,0})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package
            Medium =  MediumWat)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{10,90},{30,110}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package
            Medium = MediumWat)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_Exh_Air(redeclare package
            Medium =  MediumAir)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_Fre_Air(redeclare package
            Medium = MediumAir)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package
            Medium =  MediumAir)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
        Modelica.Blocks.Interfaces.BooleanInput On
          annotation (Placement(transformation(extent={{-120,-110},{-100,-90}})));
        Modelica.Blocks.Interfaces.RealInput disTSet
          "Connector of setpoint input signal" annotation (Placement(
              transformation(extent={{-120,-30},{-100,-10}})));
        Modelica.Blocks.Interfaces.RealInput pSet
          "Connector of setpoint input signal" annotation (Placement(
              transformation(extent={{-120,-70},{-100,-50}})));
        Modelica.Blocks.Interfaces.RealInput pMea
          "Connector of measurement input signal" annotation (Placement(
              transformation(extent={{-120,84},{-100,104}})));
        Modelica.Blocks.Interfaces.RealInput cooTSet[numTemp]
          "Connector of setpoint input signal" annotation (Placement(
              transformation(extent={{-120,30},{-100,50}})));
        Modelica.Blocks.Interfaces.RealInput zonT[numTemp]
          "Connector of setpoint input signal" annotation (Placement(
              transformation(extent={{-120,-50},{-100,-30}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTDisAir(redeclare package
            Medium =         MediumAir, m_flow_nominal=mAirFloRat)
          annotation (Placement(transformation(extent={{76,-6},{88,6}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=100000)
          annotation (Placement(transformation(extent={{40,66},{60,86}})));
        Modelica.Blocks.Math.Add add(k2=-1)
          annotation (Placement(transformation(extent={{50,40},{30,60}})));
        Modelica.Blocks.Interfaces.RealInput heaTSet[numTemp]
          "Connector of setpoint input signal" annotation (Placement(
              transformation(extent={{-120,70},{-100,90}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-34,-60},{-14,-40}})));
        Modelica.Blocks.Interfaces.RealInput TOut "outdoor air temperature"
          annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
        Modelica.Blocks.Interfaces.RealOutput TSupAir(
          final unit="K",
          final displayUnit="degC",
          final quantity="ThermodynamicTemperature")
          "AHU supply air temperature"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTMixAir(redeclare package
            Medium =         MediumAir, m_flow_nominal=mAirFloRat)
          annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
        Modelica.Blocks.Interfaces.RealOutput TMixAir(
          final unit="K",
          final displayUnit="degC",
          final quantity="ThermodynamicTemperature") "Mixing air temperature"
          annotation (Placement(transformation(extent={{100,18},{120,38}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTRetAir(redeclare package
            Medium = MediumAir, m_flow_nominal=mAirFloRat)
          annotation (Placement(transformation(extent={{86,-88},{70,-72}})));
        Modelica.Blocks.Interfaces.RealOutput TRetAir "AHU return air temperature"
          annotation (Placement(transformation(extent={{100,-64},{120,-44}})));
        Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSupAir(
          redeclare package Medium = MediumAir,
          m_flow_nominal=mAirFloRat,
          tau=1) annotation (Placement(transformation(extent={{60,-6},{72,6}})));
        Modelica.Blocks.Interfaces.RealOutput V_flowSupAir(
          final min=0,
          final unit = "m3/s",
          final quantity = "VolumeFlowRate") "Supply air volume flow rate"
          annotation (Placement(transformation(extent={{100,6},{120,26}})));
        Buildings.Fluid.Sensors.VolumeFlowRate senVolFloRetAir(
          redeclare package Medium = MediumAir,
          m_flow_nominal=mAirFloRat,
          tau=1)
          annotation (Placement(transformation(extent={{54,-88},{38,-72}})));
        Modelica.Blocks.Interfaces.RealOutput V_flowRetAir
          "Return air volume flow rate "
          annotation (Placement(transformation(extent={{100,-76},{120,-56}})));
        Modelica.Blocks.Sources.RealExpression yDamOutAirMea(y=mixBox.mixBox.valFre.y)
          annotation (Placement(transformation(extent={{40,84},{60,104}})));
        Modelica.Blocks.Interfaces.RealOutput yDamOutAir(
          final min=0,
          final max=1,
          final unit="1")
          "AHU OA damper position measurement"
          annotation (Placement(transformation(extent={{100,84},{120,104}})));
        Modelica.Blocks.Sources.RealExpression PFanTot(y=supFan.P + retFan.P)
          annotation (Placement(transformation(extent={{-34,-42},{-14,-22}})));
        Modelica.Blocks.Interfaces.RealOutput PFan "Total fan power"
          annotation (Placement(transformation(extent={{100,-38},{120,-18}})));
        Modelica.Blocks.Interfaces.RealOutput TSupCHW(
          final unit="K",
          final displayUnit="degC",
          final quantity="ThermodynamicTemperature")
          "AHU supply chilled water temperature"
          annotation (Placement(transformation(extent={{100,70},{120,90}})));
        Modelica.Blocks.Interfaces.RealOutput TRetCHW(
          final unit="K",
          final displayUnit="degC",
          final quantity="ThermodynamicTemperature")
          "AHU return chilled water temperature"
          annotation (Placement(transformation(extent={{100,-24},{120,-4}})));
        Modelica.Blocks.Sources.RealExpression TSupCHWMea(y=cooCoi.coi.TEntWat.T)
          annotation (Placement(transformation(extent={{72,70},{92,90}})));
        Modelica.Blocks.Sources.RealExpression TRetCHWMea(y=cooCoi.coi.TLeaWat.T)
          annotation (Placement(transformation(extent={{70,-32},{90,-12}})));
        Modelica.Blocks.Sources.RealExpression yCooValMea(y=cooCoi.val.y)
          annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
        Modelica.Blocks.Interfaces.RealOutput yCooVal
          "AHU cooling coil valve position measurement" annotation (Placement(
              transformation(extent={{100,-50},{120,-30}})));
        Buildings.Fluid.Sensors.VolumeFlowRate senVolFloOutAir(
          redeclare package Medium = MediumAir,
          m_flow_nominal=mAirFloRat,
          tau=1) annotation (Placement(transformation(
              extent={{-8,-8},{8,8}},
              rotation=-90,
              origin={-80,28})));
        Modelica.Blocks.Interfaces.RealOutput V_flowOutAir(
          final min=0,
          final unit="m3/s",
          final quantity="VolumeFlowRate") "Outdoor air volume flow rate"
          annotation (Placement(transformation(extent={{100,50},{120,70}})));
        Buildings.Utilities.IO.SignalExchange.Overwrite oveSpeRetFan(
            description="AHU return fan speed control signal", u(
            min=0,
            max=1,
            unit="1"))
          annotation (Placement(transformation(extent={{48,-56},{64,-40}})));
        Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2RetAir(redeclare
            package Medium = MediumAir, m_flow_nominal=mAirFloRat)
          "Sensor at AHU return air"
          annotation (Placement(transformation(extent={{24,-72},{8,-88}})));
        Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(each
            MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
          "Conversion from mass fraction CO2 to volume fraction CO2"
          annotation (Placement(transformation(extent={{24,-106},{36,-94}})));
        Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
          annotation (Placement(transformation(extent={{60,-106},{72,-94}})));
        Modelica.Blocks.Interfaces.RealOutput CO2_AHURetAir
          "AHU return air CO2 volume fraction PPM" annotation (Placement(
              transformation(extent={{100,-110},{120,-90}}), iconTransformation(
                extent={{100,-110},{120,-90}})));
        Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2FreAir(redeclare
            package Medium = MediumAir, m_flow_nominal=mAirFloRat)
          "Sensor at AHU fresh air" annotation (Placement(transformation(
              extent={{8,8},{-8,-8}},
              rotation=90,
              origin={-80,50})));
        Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra1(each
            MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
          "Conversion from mass fraction CO2 to volume fraction CO2"
          annotation (Placement(transformation(extent={{24,-126},{36,-114}})));
        Modelica.Blocks.Math.Gain gaiPPM1(k=1e6) "Convert mass fraction to PPM"
          annotation (Placement(transformation(extent={{60,-126},{72,-114}})));
        Modelica.Blocks.Interfaces.RealOutput CO2_AHUFreAir
          "AHU fresh air CO2 volume fraction PPM" annotation (Placement(
              transformation(extent={{100,-130},{120,-110}}),
              iconTransformation(extent={{100,-120},{120,-100}})));
        Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra2(each
            MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
          "Conversion from mass fraction CO2 to volume fraction CO2"
          annotation (Placement(transformation(extent={{24,-144},{36,-132}})));
        Modelica.Blocks.Math.Gain gaiPPM2(k=1e6) "Convert mass fraction to PPM"
          annotation (Placement(transformation(extent={{60,-144},{72,-132}})));
        Modelica.Blocks.Interfaces.RealOutput CO2_AHUSupAir
          "AHU supply air CO2 volume fraction PPM" annotation (Placement(
              transformation(extent={{100,-148},{120,-128}}),
              iconTransformation(extent={{100,-132},{120,-112}})));
        Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2SupAir(redeclare
            package Medium = MediumAir, m_flow_nominal=mAirFloRat)
          "Sensor at AHU supply air" annotation (Placement(transformation(
              extent={{6,6},{-6,-6}},
              rotation=180,
              origin={50,0})));
      equation
        connect(cooCoi.port_b_Air, supFan.port_a) annotation (Line(
            points={{-1.82,0},{18,0}},
            color={0,140,72},
            thickness=0.5));
        connect(mixBox.TMix, disTSet) annotation (Line(points={{-60,-12},{-60,-20},
                {-110,-20}}, color={0,0,127}));
        connect(cooCoi.SetPoi, disTSet) annotation (Line(points={{-0.2,6},{6,
                6},{6,-20},{-110,-20}}, color={0,0,127}));
        connect(supFan.T, zonT) annotation (Line(points={{16,-6},{16,-40},{-110,
                -40}}, color={0,0,127}));
        connect(supFan.pSet, pSet) annotation (Line(points={{16,2},{12,2},{12,
                -60},{-110,-60}}, color={0,0,127}));
        connect(port_Exh_Air, mixBox.port_Exh) annotation (Line(
            points={{-102,0},{-82,0},{-82,-6},{-70,-6}},
            color={0,140,72},
            thickness=0.5));
        connect(mixBox.port_Ret, retFan.port_b) annotation (Line(
            points={{-50,-5.8},{-42,-5.8},{-42,-80},{-30,-80}},
            color={0,140,72},
            thickness=0.5));
        connect(port_b_Air, senTDisAir.port_b) annotation (Line(
            points={{100,0},{88,0}},
            color={0,127,255},
            thickness=1));
        connect(pMea, add.u1) annotation (Line(points={{-110,94},{-20,94},{-20,
                68},{60,68},{60,56},{52,56}}, color={0,0,127}));
        connect(realExpression.y, add.u2) annotation (Line(
            points={{61,76},{68,76},{68,44},{52,44}},
            color={0,0,127}));
        connect(add.y, supFan.pMea) annotation (Line(points={{29,50},{10,50},
                {10,-10},{16,-10}}, color={0,0,127}));
        connect(supFan.heaTSet, heaTSet) annotation (Line(points={{16,10},{12,
                10},{12,80},{-110,80}}, color={0,0,127}));
        connect(supFan.cooTSet, cooTSet) annotation (Line(points={{16,-2},{-46,
                -2},{-46,40},{-110,40}}, color={0,0,127}));
        connect(booleanExpression.y, cooCoi.On) annotation (Line(points={{-13,-50},
                {8,-50},{8,12},{-0.2,12}},      color={255,0,255}));
        connect(mixBox.TOut, TOut) annotation (Line(points={{-54,-12},{-54,-80},
                {-110,-80}}, color={0,0,127}));
        connect(On, mixBox.On) annotation (Line(points={{-110,-100},{-68,-100},
                {-68,-12}}, color={255,0,255}));
        connect(On, supFan.On) annotation (Line(points={{-110,-100},{4,-100},{4,6},{16,
                6}},     color={255,0,255}));
        connect(senTDisAir.T, TSupAir) annotation (Line(points={{82,6.6},{82,40},
                {110,40}},     color={0,0,127},
            pattern=LinePattern.Dash));
        connect(senTMixAir.port_b, cooCoi.port_a_Air) annotation (Line(
            points={{-24,0},{-20,0}},
            color={0,140,72},
            thickness=0.5));
        connect(mixBox.port_Sup, senTMixAir.port_a) annotation (Line(
            points={{-49.8,6},{-48,6},{-48,0},{-44,0}},
            color={0,140,72},
            thickness=0.5));
        connect(senTMixAir.T, TMixAir) annotation (Line(points={{-34,11},{-34,
                28},{110,28}}, color={0,0,127},
            pattern=LinePattern.Dash));
        connect(senTRetAir.T, TRetAir) annotation (Line(points={{78,-71.2},{78,
                -54},{110,-54}},
                            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(senVolFloSupAir.port_b, senTDisAir.port_a)
          annotation (Line(points={{72,0},{76,0}}, color={0,127,255}));
        connect(senVolFloSupAir.V_flow, V_flowSupAir) annotation (Line(points={{66,6.6},
                {66,16},{110,16}},         color={0,0,127},
            pattern=LinePattern.Dash));
        connect(senVolFloRetAir.V_flow, V_flowRetAir) annotation (Line(points={{46,
                -71.2},{46,-66},{110,-66}},   color={0,0,127},
            pattern=LinePattern.Dash));
        connect(yDamOutAirMea.y, yDamOutAir)
          annotation (Line(points={{61,94},{110,94}}, color={0,0,127},
            pattern=LinePattern.Dash));
        connect(PFanTot.y, PFan) annotation (Line(points={{-13,-32},{-8,-32},{
                -8,-28},{110,-28}},
                            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(cooCoi.port_a_Wat, port_a_Wat) annotation (Line(
            points={{-2,16},{20,16},{20,100}},
            color={0,127,255},
            thickness=1));
        connect(cooCoi.port_b_Wat, port_b_Wat) annotation (Line(
            points={{-20,16},{-40,16},{-40,100}},
            color={0,127,255},
            thickness=1));
        connect(TSupCHWMea.y, TSupCHW)
          annotation (Line(points={{93,80},{110,80}}, color={0,0,127},
            pattern=LinePattern.Dash));
        connect(TRetCHWMea.y, TRetCHW)
          annotation (Line(points={{91,-22},{96,-22},{96,-14},{110,-14}},
                                                        color={0,0,127},
            pattern=LinePattern.Dash));
        connect(yCooValMea.y, yCooVal)
          annotation (Line(points={{91,-40},{110,-40}}, color={0,0,127},
            pattern=LinePattern.Dash));
        connect(senVolFloOutAir.port_b, mixBox.port_Fre) annotation (Line(
              points={{-80,20},{-80,6},{-70,6}}, color={0,127,255}));
        connect(senVolFloOutAir.V_flow, V_flowOutAir) annotation (Line(points={{-71.2,
                28},{80,28},{80,60},{110,60}},      color={0,0,127},
            pattern=LinePattern.Dash));
        connect(supFan.yRet, oveSpeRetFan.u) annotation (Line(points={{39,
                -8.2},{42,-8.2},{42,-48},{46.4,-48}}, color={0,0,127}));
        connect(oveSpeRetFan.y, retFan.u) annotation (Line(points={{64.8,-48},{
                70,-48},{70,-74},{-9,-74}},  color={0,0,127}));
        connect(senCO2RetAir.C, conMasVolFra.m) annotation (Line(
            points={{16,-88.8},{16,-100},{23.4,-100}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(conMasVolFra.V,gaiPPM. u)
          annotation (Line(points={{36.6,-100},{58.8,-100}}, color={0,0,127}));
        connect(gaiPPM.y, CO2_AHURetAir)
          annotation (Line(points={{72.6,-100},{110,-100}}, color={0,0,127}));
        connect(port_a_Air, senTRetAir.port_a)
          annotation (Line(points={{100,-80},{86,-80}}, color={0,127,255}));
        connect(senTRetAir.port_b, senVolFloRetAir.port_a)
          annotation (Line(points={{70,-80},{54,-80}}, color={0,127,255}));
        connect(senVolFloRetAir.port_b, senCO2RetAir.port_a)
          annotation (Line(points={{38,-80},{24,-80}}, color={0,127,255}));
        connect(senCO2RetAir.port_b, retFan.port_a)
          annotation (Line(points={{8,-80},{-10,-80}}, color={0,127,255}));
        connect(port_Fre_Air, senCO2FreAir.port_a) annotation (Line(points={{
                -100,60},{-80,60},{-80,58}}, color={0,127,255}));
        connect(senCO2FreAir.port_b, senVolFloOutAir.port_a)
          annotation (Line(points={{-80,42},{-80,36}}, color={0,127,255}));
        connect(conMasVolFra1.V, gaiPPM1.u)
          annotation (Line(points={{36.6,-120},{58.8,-120}}, color={0,0,127}));
        connect(gaiPPM1.y, CO2_AHUFreAir)
          annotation (Line(points={{72.6,-120},{110,-120}}, color={0,0,127}));
        connect(conMasVolFra2.V, gaiPPM2.u)
          annotation (Line(points={{36.6,-138},{58.8,-138}}, color={0,0,127}));
        connect(gaiPPM2.y, CO2_AHUSupAir)
          annotation (Line(points={{72.6,-138},{110,-138}}, color={0,0,127}));
        connect(senCO2FreAir.C, conMasVolFra1.m) annotation (Line(
            points={{-71.2,50},{-46,50},{-46,-120},{23.4,-120}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(supFan.port_b, senCO2SupAir.port_a)
          annotation (Line(points={{38,0},{44,0}}, color={0,127,255}));
        connect(senCO2SupAir.port_b, senVolFloSupAir.port_a)
          annotation (Line(points={{56,0},{60,0}}, color={0,127,255}));
        connect(senCO2SupAir.C, conMasVolFra2.m) annotation (Line(
            points={{50,6.6},{50,24},{-46,24},{-46,-138},{23.4,-138}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-120},{100,100}}),                             graphics={
              Rectangle(
                extent={{-100,100},{100,-120}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-80},{90,-80}}, color={255,170,170},
                thickness=0.5),
              Line(points={{-80,0},{-80,-80}}, color={255,170,170},
                thickness=0.5),
              Line(points={{-92,0},{-80,0}}, color={255,170,170},
                thickness=0.5),
              Line(points={{-90,60},{-60,60}}, color={0,255,255},
                thickness=0.5),
              Line(points={{-60,60},{-60,0}}, color={0,255,255},
                thickness=0.5),
              Line(points={{-60,0},{-70,0}}, color={0,255,255},
                thickness=0.5),
              Line(points={{-80,0},{-70,0}}, color={255,170,170}),
              Line(points={{-40,90},{-40,20}}, color={0,0,255},
                thickness=1),
              Rectangle(
                extent={{-30,28},{12,-10}},
                lineColor={0,255,255},
                lineThickness=0.5,
                fillColor={170,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{20,90},{20,20}}, color={0,0,255},
                thickness=1),
              Rectangle(extent={{-100,100},{100,-100}}, pattern=LinePattern.None),
              Line(points={{20,20},{-40,20}}, color={0,0,255},
                thickness=1),
              Line(points={{-60,0},{100,0}}, color={0,255,255},
                thickness=0.5),
              Text(
                extent={{-156,-148},{144,-108}},
                textString="%name",
                textColor={0,0,255})}),                                Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{
                  100,100}}),                              graphics={
              Text(
                extent={{-146,300},{154,340}},
                textString="%name",
                textColor={0,0,255})}),
          Documentation(info="<html>
<p>There are two fans (i.e., one supply fan, and one return fan) in the AHU system. Only a cooling coil is installed in the AHU.</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/AHUControl.png\"/></p>
<p>Supply fan speed is controlled by a PI controller to maintain duct static pressure (DSP) at setpoint when the fan is proven ON. 
Cooling coil valve position is controlled by a PI controller to maintain the AHU supply air temperature at setpoint.</p>
<p>In the mixing box of the AHU, an economizer is implemented to use the outdoor air to meet the cooling load when outdoor conditions are favorable. 
Outdoor air damper position is controlled by a PI controller to maintain the mixed air temperature at setpoint. It takes the mixed and outdoor air temperature measurements, as well as the mixed air temperature setpoints as inputs. It takes the outdoor air damper position as the output. The return air damper are interlocked with the outdoor air damper while exhausted air damper share the same opening position with the outdoor air damper. On top of that, an economizer control based on the fixed dry-bulb outdoor air temperature-based is adopted. The economizer higher temperature limit is set as 21 degC according to ASHRAE 90.1-2019 for Climate Zone 5A.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.VAVSupFan\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.VAVSupFan</a> for a description of the supply fan model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor</a> for a description of the return fan model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.CoolingCoil\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.CoolingCoil</a> for a description of the cooling coil model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox.MixingBoxWithControl\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox.MixingBoxWithControl</a> for a description of the mixing box model. </p>
</html>",       revisions = "<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang:
<p> First implementation.</p>
</ul>
</html>"));
      end DuaFanAirHanUnit;

      package BaseClasses

        model OccupancyMode "Occupied mdoe controller"

          parameter Real start_time;
          parameter Real end_time;

          Modelica.Blocks.Sources.BooleanExpression
                                                 booleanExpression(y=(mod(time,86400) > start_time*3600) and (mod(time,86400) < end_time*3600))
            annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
          Modelica.Blocks.Interfaces.BooleanOutput Occ annotation (Placement(transformation(extent={{100,-20},{140,20}})));
        equation
          connect(booleanExpression.y, Occ) annotation (Line(points={{9,0},{120,0}}, color={255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                  Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-42,38},{44,-46}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.None,
                  textString="Occ"),
                Text(
                  extent={{-152,104},{148,144}},
                  textString="%name",
                  textColor={0,0,255})}),
                                       Diagram(coordinateSystem(preserveAspectRatio=false)));
        end OccupancyMode;

        model ZoneSetpoint
          "Zone air temperature setPoint controller based on the occupancy signal"
          parameter Integer n=2 "dimenison of the setpoint vector";
          parameter Real setpoint_on[n] "the values of setpoint during 'on' period";
          parameter Real setpoint_off[n] "the values of setpoint during 'off' period";

          Modelica.Blocks.Sources.RealExpression realExpression[n](y=noEvent(if Occ then setpoint_on else setpoint_off))
            annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
          Modelica.Blocks.Interfaces.BooleanInput  Occ
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput SetPoi[n]
            annotation (Placement(transformation(extent={{100,-20},{140,20}})));
        equation
          connect(realExpression.y, SetPoi) annotation (Line(points={{9,0},{120,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                  Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-42,38},{44,-46}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.None,
                  textString="SetPo"),
                Text(
                  extent={{-154,102},{146,142}},
                  textString="%name",
                  textColor={0,0,255})}),
                                       Diagram(coordinateSystem(preserveAspectRatio=false)));
        end ZoneSetpoint;

      end BaseClasses;
    end AirHandlingUnit;

    package Coil "\"Component used for modelling water coils\""

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

      model CoolingCoil "The model of the cooling coil"
        extends MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.BaseClasses.WatCoil(val(
              dpValve_nominal=PreDroWat), pI(reverseActing=false, conPID(y_reset=1)));
        parameter Real UA "Rated heat exchange coefficients";

        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.BaseClasses.WetCoil coi(
          redeclare package MediumAir = MediumAir,
          redeclare package MediumWat = MediumWat,
          mAirFloRat=mAirFloRat,
          mWatFloRat=mWatFloRat,
          PreDroAir(displayUnit="Pa") = PreDroAir,
          PreDroWat(displayUnit="Pa") = 0,
          UA=UA) annotation (Placement(transformation(extent={{-18,-34},{20,8}})));
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
            points={{21.9,-17.2},{58,-17.2},{58,-60},{-52,-60},{-52,14},{-42,14}},
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
                extent={{-148,104},{152,144}},
                textString="%name",
                textColor={0,0,255})}));
      end CoolingCoil;

      package BaseClasses
        model WetCoil
          replaceable package MediumAir =
              Modelica.Media.Interfaces.PartialMedium                             "Medium for the air";
          replaceable package MediumWat =
              Modelica.Media.Interfaces.PartialMedium                             "Medium for the water";
          parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
          parameter Modelica.Units.SI.MassFlowRate mWatFloRat
            "mass flow rate for water";
          parameter Modelica.Units.SI.Pressure PreDroAir
            "Pressure drop in the air side";
          parameter Modelica.Units.SI.Pressure PreDroWat
            "Pressure drop in the water side";
          parameter Real UA "Rated heat exchange coefficients";

          Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(redeclare
              package Medium1 =
                        MediumWat, redeclare package Medium2 = MediumAir,
            m1_flow_nominal=mWatFloRat,
            m2_flow_nominal=mAirFloRat,
            dp1_nominal=PreDroWat,
            dp2_nominal=PreDroAir,
            UA_nominal=UA,
            energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
            annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
          Modelica.Fluid.Sensors.TemperatureTwoPort TEntWat(redeclare package
              Medium = MediumWat) annotation (Placement(transformation(extent=
                   {{-74,-4},{-54,16}})));
           Modelica.Fluid.Sensors.TemperatureTwoPort TLeaWat(redeclare package
              Medium =         MediumWat)
            annotation (Placement(transformation(extent={{62,-4},{82,16}})));
          Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package
              Medium =
                MediumWat)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package
              Medium =
                MediumWat)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,50},{110,70}})));
          Modelica.Fluid.Sensors.TemperatureTwoPort TEntAir(redeclare package
              Medium = MediumAir) annotation (Placement(transformation(extent=
                   {{50,-70},{30,-50}})));
          Modelica.Fluid.Sensors.MassFlowRate m_flowWat(redeclare package
              Medium =
                MediumWat)
            annotation (Placement(transformation(extent={{32,-4},{52,16}})));
          Modelica.Fluid.Sensors.Pressure pWatEnt(redeclare package Medium =
                MediumWat)
            annotation (Placement(transformation(extent={{-20,6},{-40,26}})));
          Modelica.Fluid.Sensors.Pressure pWatLea(redeclare package Medium =
                MediumWat)
            annotation (Placement(transformation(extent={{32,6},{12,26}})));
          Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package
              Medium =
                MediumAir)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
          Modelica.Fluid.Sensors.MassFlowRate m_flowAir(redeclare package
              Medium =
                MediumAir)
            annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
          replaceable Buildings.Fluid.Sensors.TemperatureTwoPort TLeaAir(
              redeclare package Medium = MediumAir, m_flow_nominal=mAirFloRat)
            annotation (Placement(transformation(extent={{-68,-70},{-88,-50}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package
              Medium =
                MediumAir)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
          Modelica.Fluid.Sensors.Pressure pAirLea(redeclare package Medium =
                MediumAir) annotation (Placement(transformation(extent={{-30,
                    -46},{-50,-26}})));
          Modelica.Fluid.Sensors.Pressure pAirEnt(redeclare package Medium =
                MediumAir) annotation (Placement(transformation(extent={{50,-44},
                    {30,-24}})));
          Modelica.Blocks.Interfaces.RealOutput TAirLea
            "Temperature of the passing fluid"
            annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
        equation
          connect(cooCoi.port_a1, TEntWat.port_b) annotation (Line(
              points={{-14,6},{-40,6},{-54,6}},
              color={0,127,255},
              thickness=1));
          connect(TEntWat.port_a, port_a_Wat) annotation (Line(
              points={{-74,6},{-88,6},{-88,60},{-100,60}},
              color={0,127,255},
              thickness=1));
          connect(TLeaWat.port_b, port_b_Wat) annotation (Line(
              points={{82,6},{90,6},{90,60},{100,60}},
              color={0,127,255},
              thickness=1));
          connect(cooCoi.port_b1,m_flowWat. port_a) annotation (Line(
              points={{6,6},{32,6}},
              color={0,127,255},
              thickness=1));
          connect(m_flowWat.port_b, TLeaWat.port_a) annotation (Line(
              points={{52,6},{52,6},{62,6}},
              color={0,127,255},
              thickness=1));
          connect(pWatEnt.port, TEntWat.port_b) annotation (Line(
              points={{-30,6},{-30,6},{-40,6},{-54,6}},
              color={0,127,255},
              thickness=1));
          connect(pWatLea.port, m_flowWat.port_a) annotation (Line(
              points={{22,6},{22,6},{32,6}},
              color={0,127,255},
              thickness=1));
          connect(TEntAir.port_b, cooCoi.port_a2) annotation (Line(
              points={{30,-60},{20,-60},{20,-6},{6,-6}},
              color={0,127,255},
              thickness=1));
          connect(TEntAir.port_a, port_a_Air) annotation (Line(
              points={{50,-60},{100,-60}},
              color={0,127,255},
              thickness=1));
          connect(m_flowAir.port_a, cooCoi.port_b2) annotation (Line(
              points={{-40,-60},{-20,-60},{-20,-6},{-14,-6}},
              color={0,127,255},
              thickness=1));
          connect(TLeaAir.port_a, m_flowAir.port_b) annotation (Line(
              points={{-68,-60},{-60,-60}},
              color={0,127,255},
              thickness=1));
          connect(TLeaAir.port_b, port_b_Air) annotation (Line(
              points={{-88,-60},{-100,-60}},
              color={0,127,255},
              thickness=1));
          connect(pAirLea.port, cooCoi.port_b2) annotation (Line(
              points={{-40,-46},{-20,-46},{-20,-6},{-14,-6}},
              color={0,127,255},
              thickness=1));
          connect(pAirEnt.port, cooCoi.port_a2) annotation (Line(
              points={{40,-44},{40,-46},{20,-46},{20,-6},{6,-6}},
              color={0,127,255},
              thickness=1));
          connect(TLeaAir.T, TAirLea) annotation (Line(
              points={{-78,-49},{-78,-20},{110,-20}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          connect(cooCoi.port_a1, pWatEnt.port)
            annotation (Line(points={{-14,6},{-30,6}}, color={0,127,255}));
          connect(cooCoi.port_b1, pWatLea.port)
            annotation (Line(points={{6,6},{22,6}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Line(
                  points={{-90,60},{-40,60}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{-76,60}},
                  color={0,0,127},
                  pattern=LinePattern.Dash),
                Line(
                  points={{40,60},{90,60}},
                  color={0,0,127},
                  thickness=0.5),
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
                  extent={{-10,30},{44,-12}},
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
                  thickness=0.5)}),                                      Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end WetCoil;

        model DryCoil
          parameter Modelica.Units.SI.Efficiency eps(max=1) = 0.8
            "Heat exchanger effectiveness";
          replaceable package MediumAir =
              Modelica.Media.Interfaces.PartialMedium "Medium for the air";
          replaceable package MediumWat =
              Modelica.Media.Interfaces.PartialMedium "Medium for the water";
          parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
          parameter Modelica.Units.SI.MassFlowRate mWatFloRat
            "mass flow rate for water";
          parameter Modelica.Units.SI.Pressure PreDroAir
            "Pressure drop in the air side";
          parameter Modelica.Units.SI.Pressure PreDroWat
            "Pressure drop in the water side";

          Buildings.Fluid.HeatExchangers.ConstantEffectiveness dryCoi(
            redeclare package Medium1 = MediumWat,
            redeclare package Medium2 = MediumAir,
            m1_flow_nominal=mWatFloRat,
            m2_flow_nominal=mAirFloRat,
            dp1_nominal=PreDroWat,
            dp2_nominal=PreDroAir,
            eps=eps)
            annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
          Modelica.Fluid.Sensors.TemperatureTwoPort temEntWat(redeclare package
              Medium =
                MediumWat)
            annotation (Placement(transformation(extent={{-74,-4},{-54,16}})));
          Modelica.Fluid.Sensors.TemperatureTwoPort temLeaWat(redeclare package
              Medium =
                MediumWat)
            annotation (Placement(transformation(extent={{62,-4},{82,16}})));
          Modelica.Fluid.Sensors.TemperatureTwoPort temEntAir(redeclare package
              Medium =
                MediumAir)
            annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
          Modelica.Fluid.Sensors.MassFlowRate masFloWat(redeclare package
              Medium =
                MediumWat)
            annotation (Placement(transformation(extent={{32,-4},{52,16}})));
          Modelica.Fluid.Sensors.Pressure preWatEnt(redeclare package Medium =
                MediumWat)
            annotation (Placement(transformation(extent={{-20,6},{-40,26}})));
          Modelica.Fluid.Sensors.Pressure preWatLea(redeclare package Medium =
                MediumWat)
            annotation (Placement(transformation(extent={{32,6},{12,26}})));
          Modelica.Fluid.Sensors.MassFlowRate masFloAir(redeclare package
              Medium =
                MediumAir)
            annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
          Modelica.Fluid.Sensors.TemperatureTwoPort temLeaAir(redeclare package
              Medium =
                MediumAir)
            annotation (Placement(transformation(extent={{-68,-70},{-88,-50}})));
          Modelica.Fluid.Sensors.Pressure preAirLea(redeclare package Medium =
                MediumAir)
            annotation (Placement(transformation(extent={{-30,-46},{-50,-26}})));
          Modelica.Fluid.Sensors.Pressure preAirEnt(redeclare package Medium =
                MediumAir)
            annotation (Placement(transformation(extent={{50,-44},{30,-24}})));
          Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package
              Medium =
                MediumWat)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package
              Medium =
                MediumWat)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,50},{110,70}})));
          Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package
              Medium =
                MediumAir)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package
              Medium =
                MediumAir)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
          Modelica.Blocks.Interfaces.RealOutput TAirLea
            "Temperature of the passing fluid"
            annotation (Placement(transformation(extent={{100,-30},{120,-10}})));

        equation
          connect(dryCoi.port_a1, temEntWat.port_b) annotation (Line(
              points={{-14,6},{-40,6},{-54,6}},
              color={0,127,255},
              thickness=1));
          connect(temEntWat.port_a,port_a_Wat)  annotation (Line(
              points={{-74,6},{-88,6},{-88,60},{-100,60}},
              color={0,127,255},
              thickness=1));
          connect(temLeaWat.port_b,port_b_Wat)  annotation (Line(
              points={{82,6},{90,6},{90,60},{100,60}},
              color={0,127,255},
              thickness=1));
          connect(dryCoi.port_b1, masFloWat.port_a) annotation (Line(
              points={{6,6},{32,6}},
              color={0,127,255},
              thickness=1));
          connect(masFloWat.port_b,temLeaWat. port_a) annotation (Line(
              points={{52,6},{52,6},{62,6}},
              color={0,127,255},
              thickness=1));
          connect(preWatEnt.port,temEntWat. port_b) annotation (Line(
              points={{-30,6},{-30,6},{-40,6},{-54,6}},
              color={0,127,255},
              thickness=1));
          connect(preWatLea.port,masFloWat. port_a) annotation (Line(
              points={{22,6},{22,6},{32,6}},
              color={0,127,255},
              thickness=1));
          connect(temEntAir.port_b, dryCoi.port_a2) annotation (Line(
              points={{30,-60},{20,-60},{20,-6},{6,-6}},
              color={0,140,72},
              thickness=0.5));
          connect(temEntAir.port_a,port_a_Air)  annotation (Line(
              points={{50,-60},{100,-60}},
              color={0,140,72},
              thickness=0.5));
          connect(masFloAir.port_a, dryCoi.port_b2) annotation (Line(
              points={{-40,-60},{-20,-60},{-20,-6},{-14,-6}},
              color={0,140,72},
              thickness=0.5));
          connect(temLeaAir.port_a, masFloAir.port_b) annotation (Line(
              points={{-68,-60},{-60,-60}},
              color={0,140,72},
              thickness=0.5));
          connect(temLeaAir.port_b,port_b_Air)  annotation (Line(
              points={{-88,-60},{-100,-60}},
              color={0,140,72},
              thickness=0.5));
          connect(preAirLea.port, dryCoi.port_b2) annotation (Line(
              points={{-40,-46},{-20,-46},{-20,-6},{-14,-6}},
              color={0,140,72},
              thickness=0.5));
          connect(preAirEnt.port, dryCoi.port_a2) annotation (Line(
              points={{40,-44},{40,-46},{20,-46},{20,-6},{6,-6}},
              color={0,140,72},
              thickness=0.5));
          connect(temLeaAir.T,TAirLea)  annotation (Line(
              points={{-78,-49},{-78,-20},{110,-20}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          connect(dryCoi.port_a1, preWatEnt.port)
            annotation (Line(points={{-14,6},{-30,6}}, color={0,127,255}));
          connect(dryCoi.port_b1, preWatLea.port)
            annotation (Line(points={{6,6},{22,6}}, color={0,127,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Line(
                  points={{-90,60},{-40,60}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{40,60},{90,60}},
                  color={0,0,127},
                  thickness=0.5),
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
                  thickness=0.5),
                Text(
                  extent={{-10,50},{44,8}},
                  lineColor={0,0,127},
                  lineThickness=0.5,
                  textString="+")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
        end DryCoil;

        partial model WatCoil
          import BuildingControlEmulator =
                 MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component;
          replaceable package MediumAir =
              Modelica.Media.Interfaces.PartialMedium                             "Medium for the air";
          replaceable package MediumWat =
              Modelica.Media.Interfaces.PartialMedium                             "Medium for the water";
          parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
          parameter Modelica.Units.SI.MassFlowRate mWatFloRat
            "mass flow rate for water";
          parameter Modelica.Units.SI.Pressure PreDroAir
            "Pressure drop in the air side";
          parameter Modelica.Units.SI.Pressure PreDroWat
            "Pressure drop in the water side";
          parameter Real k(min=0, unit="1") = 1 "Gain of controller";
          parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
            "Time constant of Integrator block";
          Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package
              Medium =                                                                MediumAir)
                                                           "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-112,-90},{-92,-70}})));
          Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package
              Medium =                                                                MediumAir)
                                                           "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package
              Medium =                                                                MediumWat)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{90,70},{110,90}})));
          Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package
              Medium =                                                                MediumWat)
            "Fluid connector a (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
          replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
            redeclare package Medium = MediumWat,
            m_flow_nominal=mWatFloRat,
            dpValve_nominal=PreDroWat)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={80,46})));
          BuildingControlEmulator.conPI pI(k=k, Ti=Ti)
            annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
          Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
          Modelica.Blocks.Interfaces.RealInput SetPoi "Connector of setpoint input signal"
            annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
          Buildings.Controls.OBC.CDL.Continuous.LimitSlewRate ramLim(raisingSlewRate=1/
                120) "Ramp limiter for water coil control signal"
            annotation (Placement(transformation(extent={{30,36},{50,56}})));
          Buildings.Utilities.IO.SignalExchange.Overwrite yCoo(description=
                "Cooling coil valve control signal for AHU", u(
              unit="1",
              min=0,
              max=1)) "Cooling coil control signal"
            annotation (Placement(transformation(extent={{-4,36},{16,56}})));
        equation
          connect(val.port_b, port_b_Wat) annotation (Line(
              points={{80,56},{80,80},{100,80}},
              color={0,127,255},
              thickness=1));
          connect(pI.On, On)
            annotation (Line(
              points={{-42,26},{-42,26},{-52,26},{-80,26},{-80,40},{-120,40}},
              color={255,0,255},
              pattern=LinePattern.Dash));
          connect(pI.set, SetPoi) annotation (Line(
              points={{-42,20},{-42,20},{-80,20},{-80,-20},{-120,-20}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          connect(ramLim.y, val.y) annotation (Line(points={{52,46},{68,46}},
                        color={0,0,127}));
          connect(yCoo.y, ramLim.u)
            annotation (Line(points={{17,46},{28,46}}, color={0,0,127}));
          connect(yCoo.u, pI.y) annotation (Line(points={{-6,46},{-14,46},{
                  -14,20},{-19,20}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
        end WatCoil;

      end BaseClasses;

    end Coil;

    package MixingBox

      model MixingBoxWithControl "The model of the mixing box"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "medium for the fluid";
        parameter Modelica.Units.SI.Pressure PreDro "pressure drop in the air side";
        parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat
          "mass flow rate for fresh air";
        parameter Modelica.Units.SI.MassFlowRate mTotAirFloRat
          "mass flow rate for water";
        parameter Modelica.Units.SI.Temperature TemHig
          "highest temeprature when the economizer is on";
        parameter Modelica.Units.SI.Temperature TemLow
          "lowest temeprature when the economizer is on";
        parameter Real DamMin "minimum damper postion";
        parameter Real k(min=0, unit="1") = 1 "gain of controller";
        parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
          "time constant of Integrator block";
        BaseClasses.MixingBox mixBox(
          redeclare package Medium = Medium,
          PreDro=PreDro,
          mFreAirFloRat=mFreAirFloRat,
          mTotAirFloRat=mTotAirFloRat)
          annotation (Placement(transformation(extent={{-10,-24},{26,0}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium = Medium)
                                                       "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-70,90},{-50,110}}),
              iconTransformation(extent={{-70,90},{-50,110}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_Fre(redeclare package Medium = Medium)
                                                       "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{50,90},{70,110}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package Medium = Medium)
                                                       "First port, typically inlet" annotation (Placement(transformation(extent={{-68,
                  -110},{-48,-90}}), iconTransformation(extent={{-68,-110},{-48,-90}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package Medium = Medium)
                                                       "Second port, typically outlet" annotation (Placement(transformation(extent={{50,-112},{70,-92}})));
        Control.ecoCon ecoCon(
          TemHig=TemHig,
          TemLow=TemLow,
          DamMin=DamMin,
          k=k,
          Ti=Ti)              annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
        Modelica.Blocks.Interfaces.RealInput TMix
          "Connector of setpoint input signal" annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput TOut
          "Connector of measurement input signal"
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
      equation
        connect(mixBox.port_Exh, port_Exh) annotation (Line(
            points={{-4.6,0},{-4.6,60},{-60,60},{-60,100}},
            color={0,140,72},
            thickness=0.5));
        connect(mixBox.port_Fre, port_Fre) annotation (Line(
            points={{18.8,0},{18.8,60},{60,60},{60,100}},
            color={0,140,72},
            thickness=0.5));
        connect(mixBox.port_Ret, port_Ret)
          annotation (Line(
            points={{-4.6,-24},{-4.6,-58},{-58,-58},{-58,-100}},
            color={0,140,72},
            thickness=0.5));
        connect(mixBox.port_Sup, port_Sup)
          annotation (Line(
            points={{18.8,-24},{20,-24},{20,-58},{60,-58},{60,-102}},
            color={0,140,72},
            thickness=0.5));
        connect(mixBox.T, ecoCon.Mea)
          annotation (Line(
            points={{27.8,-17.04},{38,-17.04},{38,22},{-78,22},{-78,32},{-72,32}},
            color={0,0,127}));
        connect(ecoCon.TMix, TMix) annotation (Line(
            points={{-72,40},{-92,40},{-92,0},{-120,0}},
            color={0,0,127}));
        connect(ecoCon.On, On) annotation (Line(
            points={{-72,48},{-90,48},{-90,80},{-120,80}},
            color={255,0,255}));
        connect(ecoCon.TOut,TOut)  annotation (Line(
            points={{-72,36},{-80,36},{-80,-60},{-120,-60}},
            color={0,0,127}));
        connect(ecoCon.y,mixBox.damPos)  annotation (Line(points={{-49,40},{-46,
                40},{-46,-12},{-13.6,-12}},
                                          color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(
                points={{-60,90},{-60,-94}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{60,92},{60,-92}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{60,0},{-60,0}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{-60,72},{-60,32}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{-68,64},{-52,64}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{-70,38},{-50,38}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{-68,64},{-50,38}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{-70,38},{-52,64}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{60,74},{60,34}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{52,66},{68,66}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{50,40},{70,40}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{52,66},{70,40}},
                color={0,0,127},
                thickness=0.5),
              Line(
                points={{50,40},{68,66}},
                color={0,0,127},
                thickness=0.5),
              Text(
                extent={{-148,112},{152,152}},
                textString="%name",
                textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
      end MixingBoxWithControl;

      package BaseClasses

        model MixingBox
          replaceable package Medium =
              Modelica.Media.Interfaces.PartialMedium                          "Medium for the fluid";
          parameter Modelica.Units.SI.Pressure PreDro "Pressure drop in the air side";
          parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat
            "mass flow rate for fresh air";
          parameter Modelica.Units.SI.MassFlowRate mTotAirFloRat
            "mass flow rate for water";

          Buildings.Fluid.FixedResistances.Junction jun(
            energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
            redeclare package Medium = Medium,
            from_dp=false,
            m_flow_nominal={mTotAirFloRat,mFreAirFloRat,-mTotAirFloRat + mFreAirFloRat},
            dp_nominal={PreDro/4,PreDro/4,PreDro/4},
            linearized=true)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,-12})));

          Buildings.Fluid.FixedResistances.Junction jun1(
            energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
            redeclare package Medium = Medium,
            from_dp=false,
            m_flow_nominal={mFreAirFloRat,mTotAirFloRat,mTotAirFloRat - mFreAirFloRat},
            dp_nominal={PreDro/4,PreDro/4,PreDro/4},
            linearized=true)
            annotation (Placement(transformation(extent={{10,10},{-10,-10}},
                rotation=90,
                origin={60,-12})));

          Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package
              Medium =                                                              Medium)
            "First port, typically inlet"                                              annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package
              Medium =                                                              Medium)
            "Second port, typically outlet"                                              annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
          replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valExh(
            redeclare package Medium = Medium,
            m_flow_nominal=mFreAirFloRat,
            dpValve_nominal=PreDro/2)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,58})));
          replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valFre(
            redeclare package Medium = Medium,
            m_flow_nominal=mFreAirFloRat,
            dpValve_nominal=PreDro/2)
            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={60,54})));
          Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package
              Medium =                                                              Medium)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_Fre(redeclare package
              Medium =                                                              Medium)
            "Fluid connector b (positive design flow direction is from port_a to port_b)"
            annotation (Placement(transformation(extent={{50,90},{70,110}})));
          replaceable Buildings.Fluid.Sensors.TemperatureTwoPort TOutSen(
              redeclare package Medium = Medium, m_flow_nominal=mFreAirFloRat)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={60,82})));
          replaceable Buildings.Fluid.Sensors.TemperatureTwoPort TMix(
              redeclare package Medium = Medium, m_flow_nominal=mTotAirFloRat)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={60,-42})));
          Modelica.Fluid.Sensors.TemperatureTwoPort TRet(redeclare package
              Medium = Medium) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,-50})));
          Modelica.Fluid.Sensors.MassFlowRate m_flowAir(redeclare package
              Medium =                                                             Medium)
            annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=90,
                origin={60,20})));
          Modelica.Blocks.Interfaces.RealInput damPos "Actuator position (0: closed, 1: open)"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Fluid.Sensors.MassFlowRate m_flowSupAir(redeclare package
              Medium = Medium) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={60,-72})));
          Modelica.Blocks.Interfaces.RealOutput T "Temperature of the passing fluid"
            annotation (Placement(transformation(extent={{100,-52},{120,-32}})));
          Modelica.Blocks.Interfaces.RealOutput TOut "Temperature of the passing fluid"
            annotation (Placement(transformation(extent={{100,72},{120,92}})));
          replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valRet(
            redeclare package Medium = Medium,
            dpValve_nominal=PreDro/2,
            m_flow_nominal=mTotAirFloRat - mFreAirFloRat)
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={0,-12})));
          Modelica.Blocks.Sources.RealExpression realExpression(y=1 -damPos)
            annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
          Buildings.Utilities.IO.SignalExchange.Overwrite yOA(description=
                "Outside air damper position setpoint for AHU", u(
              unit="1",
              min=0,
              max=1)) "Outside air damper position setpoint"
            annotation (Placement(transformation(extent={{0,44},{20,64}})));
          Buildings.Utilities.IO.SignalExchange.Overwrite yRet(description=
                "Return air damper position setpoint for AHU", u(
              unit="1",
              min=0,
              max=1)) "Return air damper position setpoint"
            annotation (Placement(transformation(extent={{-28,10},{-8,30}})));
          Buildings.Utilities.IO.SignalExchange.Overwrite yEA(description=
                "Exhaust air damper position setpoint for AHU", u(
              unit="1",
              min=0,
              max=1)) "Exhaust air damper position setpoint" annotation (
              Placement(transformation(extent={{-48,80},{-28,100}})));
        equation
          connect(valExh.port_a, jun.port_2)
            annotation (Line(
              points={{-70,48},{-70,-2}},
              color={0,127,255},
              thickness=1));
          connect(valExh.port_b, port_Exh)
            annotation (Line(
              points={{-70,68},{-70,100}},
              color={0,127,255},
              thickness=1));
          connect(port_Fre, TOutSen.port_a) annotation (Line(
              points={{60,100},{60,100},{60,92}},
              color={0,127,255},
              thickness=1));
          connect(jun1.port_2, TMix.port_a) annotation (Line(
              points={{60,-22},{60,-28},{60,-32}},
              color={0,127,255},
              thickness=1));
          connect(jun.port_1, TRet.port_b) annotation (Line(
              points={{-70,-22},{-70,-32},{-70,-40}},
              color={0,127,255},
              thickness=1));
          connect(TRet.port_a, port_Ret) annotation (Line(
              points={{-70,-60},{-70,-80},{-70,-100}},
              color={0,127,255},
              thickness=1));
          connect(m_flowAir.port_b, jun1.port_1) annotation (Line(
              points={{60,10},{60,4},{60,-2}},
              color={0,127,255},
              thickness=1));
          connect(port_Fre, port_Fre) annotation (Line(points={{60,100},{60,104},{56,104},{60,104},{60,100}},
                                                                                   color={0,127,255}));
          connect(port_Sup, m_flowSupAir.port_b) annotation (Line(
              points={{60,-100},{60,-92},{60,-82}},
              color={0,127,255},
              thickness=1));
          connect(m_flowSupAir.port_a, TMix.port_b) annotation (Line(
              points={{60,-62},{60,-62},{60,-52}},
              color={0,127,255},
              thickness=1));
          connect(TMix.T, T) annotation (Line(
              points={{71,-42},{110,-42}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          connect(TOutSen.T, TOut) annotation (Line(
              points={{71,82},{110,82}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          connect(TOutSen.port_b, valFre.port_a) annotation (Line(
              points={{60,72},{60,64}},
              color={0,127,255},
              thickness=1));
          connect(valFre.port_b,m_flowAir. port_a)
            annotation (Line(
              points={{60,44},{60,44},{60,30}},
              color={0,127,255},
              thickness=0.5));
          connect(jun.port_3, valRet.port_a) annotation (Line(
              points={{-60,-12},{-10,-12}},
              color={0,127,255},
              thickness=1));
          connect(valRet.port_b, jun1.port_3) annotation (Line(
              points={{10,-12},{50,-12}},
              color={0,127,255},
              thickness=1));
          connect(yOA.y, valFre.y)
            annotation (Line(points={{21,54},{48,54}}, color={0,0,127}));
          connect(yOA.u,damPos)  annotation (Line(points={{-2,54},{-40,54},{
                  -40,32},{-84,32},{-84,0},{-120,0}}, color={0,0,127}));
          connect(realExpression.y, yRet.u)
            annotation (Line(points={{-39,20},{-30,20}}, color={0,0,127}));
          connect(yRet.y, valRet.y) annotation (Line(points={{-7,20},{0,20},{
                  0,-1.77636e-15}}, color={0,0,127}));
          connect(damPos, yEA.u) annotation (Line(points={{-120,0},{-92,0},{
                  -92,90},{-50,90}}, color={0,0,127}));
          connect(yEA.y, valExh.y) annotation (Line(points={{-27,90},{-18,90},
                  {-18,76},{-88,76},{-88,58},{-82,58}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Line(
                  points={{-70,92},{-70,-92}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{60,92},{60,-92}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{60,0},{-70,0}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{-70,72},{-70,32}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{-78,64},{-62,64}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{-80,38},{-60,38}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{-78,64},{-60,38}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{-80,38},{-62,64}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{60,74},{60,34}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{52,66},{68,66}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{50,40},{70,40}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{52,66},{70,40}},
                  color={0,0,127},
                  thickness=0.5),
                Line(
                  points={{50,40},{68,66}},
                  color={0,0,127},
                  thickness=0.5),
                Text(
                  extent={{-152,108},{148,148}},
                  textString="%name",
                  textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
        end MixingBox;

      end BaseClasses;

      package Control

        model ecoCon
          import BuildingControlEmulator =
                 MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component;
          parameter Modelica.Units.SI.Temperature TemHig
            "the highest temeprature when the economizer is on";
          parameter Modelica.Units.SI.Temperature TemLow
            "the lowest temeprature when the economizer is on";
           parameter Real DamMin "the minimum damper postion";
          parameter Real k(min=0, unit="1") = 1 "Gain of controller";
          parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
            "Time constant of Integrator block";

          BuildingControlEmulator.conPI pI(
            k=k,
            Ti=Ti,
            reverseActing=false,
            conPID(y_reset=1))
            annotation (Placement(transformation(extent={{10,2},{30,22}})));
          Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
          Modelica.Blocks.Interfaces.RealInput TMix
            "Connector of setpoint input signal" annotation (Placement(
                transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealInput Mea "Connector of measurement input signal"
            annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
          Modelica.Blocks.Sources.BooleanExpression integerExpression(y=(TOut <= TemHig)
                 and (TOut > TemLow))                                                 annotation (Placement(transformation(extent={{-80,30},
                    {-60,50}})));
          Modelica.Blocks.Sources.RealExpression realExpression(y=DamMin) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
          Modelica.Blocks.Math.Max max annotation (Placement(transformation(extent={{52,-10},{72,10}})));
          Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Interfaces.RealInput TOut
            "Connector of measurement input signal"
            annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
          Buildings.Controls.OBC.CDL.Continuous.LimitSlewRate ramLim(raisingSlewRate=1/
                120) "Ramp limiter for fan control signal"
            annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
          Buildings.Controls.OBC.CDL.Continuous.Limiter lim(uMax=1, uMin=0)
            annotation (Placement(transformation(extent={{68,-60},{88,-40}})));
          Buildings.Controls.OBC.CDL.Continuous.Switch swi
            annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
          Modelica.Blocks.Sources.RealExpression realExpression1(y=DamMin)
            annotation (Placement(transformation(extent={{-34,-68},{-14,-48}})));
        equation
          connect(pI.set, TMix) annotation (Line(
              points={{8,12},{8,10},{-60,10},{-60,0},{-120,0}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          connect(pI.mea, Mea) annotation (Line(
              points={{8,6},{8,4},{-40,4},{-40,-80},{-120,-80}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          connect(integerExpression.y, pI.On) annotation (Line(points={{-59,40},{-59,40},
                  {0,40},{0,18},{8,18}},                                                                        color={255,0,255}));
          connect(pI.y, max.u1) annotation (Line(points={{31,12},{40,12},{40,6},{50,6}}, color={0,0,127}));
          connect(max.u2, realExpression.y) annotation (Line(points={{50,-6},{40,-6},{40,-20},{31,-20}}, color={0,0,127}));
          connect(ramLim.y, lim.u)
            annotation (Line(points={{62,-50},{66,-50}}, color={0,0,127}));
          connect(swi.y, ramLim.u)
            annotation (Line(points={{22,-50},{38,-50}}, color={0,0,127}));
          connect(On, swi.u2) annotation (Line(points={{-120,80},{-20,80},{-20,-50},{-2,
                  -50}}, color={255,0,255}));
          connect(max.y, swi.u1) annotation (Line(points={{73,0},{88,0},{88,-28},{-12,
                  -28},{-12,-42},{-2,-42}}, color={0,0,127}));
          connect(realExpression1.y, swi.u3)
            annotation (Line(points={{-13,-58},{-2,-58}}, color={0,0,127}));
          connect(lim.y, y) annotation (Line(points={{90,-50},{96,-50},{96,0},{110,0}},
                color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                  Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,127,255},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-34,26},{38,-34}},
                  lineColor={0,127,255},
                  lineThickness=1,
                  textString="Eco"),
                Text(
                  extent={{-156,112},{144,152}},
                  textString="%name",
                  textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
        end ecoCon;
      end Control;

    end MixingBox;

    package ZoneTerminal

      model FiveZoneDuctNetwork
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
        parameter Modelica.Units.SI.Pressure PreDroMai1
          "Pressure drop 1 across the duct";

        parameter Modelica.Units.SI.Pressure PreDroMai2
          "Pressure drop 2 across the main duct";

        parameter Modelica.Units.SI.Pressure PreDroMai3
          "Pressure drop 3 across the main duct";

        parameter Modelica.Units.SI.Pressure PreDroMai4
          "Pressure drop 4 across the main duct";

        parameter Modelica.Units.SI.Pressure PreDroBra1
          "Pressure drop 1 across the duct branch 1";

        parameter Modelica.Units.SI.Pressure PreDroBra2
          "Pressure drop 1 across the duct branch 2";

        parameter Modelica.Units.SI.Pressure PreDroBra3
          "Pressure drop 1 across the duct branch 3";

        parameter Modelica.Units.SI.Pressure PreDroBra4
          "Pressure drop 1 across the duct branch 4";

        parameter Modelica.Units.SI.Pressure PreDroBra5
          "Pressure drop 1 across the duct branch 5";

        parameter Modelica.Units.SI.MassFlowRate mFloRat1
          "mass flow rate for the first branch1";

        parameter Modelica.Units.SI.MassFlowRate mFloRat2
          "mass flow rate for the first branch2";

        parameter Modelica.Units.SI.MassFlowRate mFloRat3
          "mass flow rate for the first branch3";

        parameter Modelica.Units.SI.MassFlowRate mFloRat4
          "mass flow rate for the first branch4";

        parameter Modelica.Units.SI.MassFlowRate mFloRat5
          "mass flow rate for the first branch5";

        Buildings.Fluid.FixedResistances.Junction junSup1(
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                                          m_flow_nominal={mFloRat1 + mFloRat2 + mFloRat3 + mFloRat4 + mFloRat5,-mFloRat2-mFloRat3-mFloRat4 - mFloRat5,-
              mFloRat1}, redeclare package Medium = Medium,
          dp_nominal={PreDroMai1/2,PreDroMai2/2,PreDroBra1/2})
          annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
        Buildings.Fluid.FixedResistances.Junction junRet1(redeclare package
            Medium =                                                                 Medium,
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,                         m_flow_nominal={mFloRat2 + mFloRat3 + mFloRat4 + mFloRat5,-mFloRat1-mFloRat2-mFloRat3-
              mFloRat4 - mFloRat5,mFloRat1},
          dp_nominal={PreDroMai2/2,PreDroMai1/2,PreDroBra1/2})
                                                      annotation (Placement(transformation(extent={{-70,-70},{-90,-50}})));
        Buildings.Fluid.FixedResistances.Junction junRet2( redeclare package
            Medium =                                                                  Medium,
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,                          m_flow_nominal={mFloRat3 + mFloRat4 + mFloRat5,-mFloRat2-mFloRat3-
              mFloRat4 - mFloRat5,mFloRat2},
          dp_nominal={PreDroMai3/2,PreDroMai2/2,PreDroBra2/2})
                                                      annotation (Placement(transformation(extent={{-30,-70},{-50,-50}})));
        Buildings.Fluid.FixedResistances.Junction junSup2(
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                                          m_flow_nominal={mFloRat2 + mFloRat3 + mFloRat4 + mFloRat5,-mFloRat3-mFloRat4 - mFloRat5,-
              mFloRat2}, redeclare package Medium = Medium,
          dp_nominal={PreDroMai2/2,PreDroMai3/2,PreDroBra2/2})
                            annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
        Buildings.Fluid.FixedResistances.Junction junSup3(
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                                          m_flow_nominal={mFloRat3 + mFloRat4 + mFloRat5,-mFloRat4 - mFloRat5,-
              mFloRat3}, redeclare package Medium = Medium,
          dp_nominal={PreDroMai3/2,PreDroMai4/2,PreDroBra3/2})
                                                      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Buildings.Fluid.FixedResistances.Junction junRet3(redeclare package
            Medium =                                                                 Medium,
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,                         m_flow_nominal={mFloRat4 + mFloRat5,-mFloRat3-
              mFloRat4 - mFloRat5,mFloRat3},
          dp_nominal={PreDroMai4/2,PreDroMai3/2,PreDroBra3/2})
                                                      annotation (Placement(transformation(extent={{10,-50},{-10,-70}})));
        Buildings.Fluid.FixedResistances.Junction junSup4(
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                                          m_flow_nominal={mFloRat4 + mFloRat5,-mFloRat5,-mFloRat4}, redeclare
            package Medium =
                     Medium,
          dp_nominal={PreDroMai4/2,PreDroBra5/2,PreDroBra4/2})
                                                      annotation (Placement(transformation(extent={{30,30},{50,50}})));
        Buildings.Fluid.FixedResistances.Junction junRet4(redeclare package
            Medium =                                                                 Medium,
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,                         m_flow_nominal={mFloRat5,-mFloRat4 - mFloRat5,
              mFloRat4},
          dp_nominal={PreDroBra5/2,PreDroMai4/2,PreDroBra4/2})
                                                      annotation (Placement(transformation(extent={{50,-70},{30,-50}})));

        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
              Medium) "Second port, typically outlet"
                                          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
              Medium) "Second port, typically outlet"
                                          annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
        replaceable Buildings.Fluid.Sensors.Pressure         senRelPre(redeclare
            package Medium =                                                                  Medium)
                                                       annotation (Placement(transformation(extent={{34,70},
                  {14,90}})));
        Modelica.Fluid.Interfaces.FluidPorts_b ports_b[5](redeclare package
            Medium =                                                                 Medium)
          annotation (Placement(transformation(extent={{90,6},{110,86}})));
        Modelica.Fluid.Interfaces.FluidPorts_a ports_a[5](redeclare package
            Medium =                                                                 Medium)
          annotation (Placement(transformation(extent={{90,-102},{110,-22}})));
        Modelica.Blocks.Interfaces.RealOutput p "Pressure at port"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        connect(junSup1.port_2, junSup2.port_1) annotation (Line(
            points={{-70,40},{-62,40},{-50,40}},
            color={0,127,255},
            thickness=1));
        connect(junSup2.port_2, junSup3.port_1) annotation (Line(
            points={{-30,40},{-30,40},{-10,40}},
            color={0,127,255},
            thickness=1));
        connect(junSup3.port_2, junSup4.port_1) annotation (Line(
            points={{10,40},{10,40},{30,40}},
            color={0,127,255},
            thickness=1));
        connect(junRet4.port_2, junRet3.port_1) annotation (Line(
            points={{30,-60},{10,-60}},
            color={0,127,255},
            thickness=1));
        connect(junRet3.port_2, junRet2.port_1)
          annotation (Line(
            points={{-10,-60},{-10,-60},{-30,-60}},
            color={0,127,255},
            thickness=1));
        connect(junRet2.port_2, junRet1.port_1)
          annotation (Line(
            points={{-50,-60},{-50,-60},{-70,-60}},
            color={0,127,255},
            thickness=1));
        connect(junRet1.port_2, port_b) annotation (Line(
            points={{-90,-60},{-100,-60}},
            color={0,127,255},
            thickness=1));
        connect(junSup1.port_1, port_a) annotation (Line(
            points={{-90,40},{-100,40}},
            color={0,127,255},
            thickness=1));

        connect(ports_b, ports_b) annotation (Line(points={{100,46},{100,46}}, color={0,127,255}));
        connect(junSup4.port_3, ports_b[4])
          annotation (Line(
            points={{40,30},{40,16},{60,16},{60,54},{100,54}},
            color={0,127,255},
            thickness=1));
        connect(junSup3.port_3, ports_b[3])
          annotation (Line(
            points={{0,30},{0,12},{78,12},{78,46},{100,46}},
            color={0,127,255},
            thickness=1));
        connect(junSup2.port_3, ports_b[2])
          annotation (Line(
            points={{-40,30},{-40,30},{-40,8},{84,8},{84,38},{100,38}},
            color={0,127,255},
            thickness=1));
        connect(junSup1.port_3, ports_b[1])
          annotation (Line(
            points={{-80,30},{-80,30},{-80,0},{90,0},{90,30},{100,30}},
            color={0,127,255},
            thickness=1));
        connect(junRet4.port_1, ports_a[5])
          annotation (Line(
            points={{50,-60},{70,-60},{70,-34},{70,-46},{100,-46}},
            color={0,127,255},
            thickness=1));
        connect(junRet4.port_3, ports_a[4])
          annotation (Line(
            points={{40,-70},{40,-70},{70,-70},{86,-70},{86,-54},{100,-54}},
            color={0,127,255},
            thickness=1));
        connect(junRet2.port_3, ports_a[2])
          annotation (Line(
            points={{-40,-70},{-40,-86},{100,-86},{100,-70}},
            color={0,127,255},
            thickness=1));
        connect(junRet1.port_3, ports_a[1])
          annotation (Line(
            points={{-80,-70},{-80,-70},{-80,-94},{100,-94},{100,-78}},
            color={0,127,255},
            thickness=1));
        connect(junRet3.port_3, ports_a[3])
          annotation (Line(
            points={{0,-50},{0,-38},{82,-38},{82,-62},{100,-62}},
            color={0,127,255},
            thickness=1));
        connect(senRelPre.port, junSup4.port_2) annotation (Line(
            points={{24,70},{24,60},{56,60},{56,40},{50,40}},
            color={0,127,255},
            thickness=1));
        connect(junSup4.port_2, ports_b[5]) annotation (Line(
            points={{50,40},{54,40},{56,40},{56,82},{100,82},{100,62}},
            color={0,127,255},
            thickness=1));
        connect(senRelPre.p, p) annotation (Line(
            points={{13,80},{-20,80},{-20,-20},{96,-20},{96,0},{110,0}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(points={{-90,40},{80,40}}, color={0,127,255}),
              Line(points={{-90,-60},{80,-60}}, color={0,127,255}),
              Line(points={{80,40},{80,-60}}, color={0,127,255}),
              Line(points={{50,40},{50,-60}}, color={0,127,255}),
              Line(points={{20,40},{20,-60}}, color={0,127,255}),
              Line(points={{-10,40},{-10,-60}}, color={0,127,255}),
              Line(points={{-40,40},{-40,-60}}, color={0,127,255})}),  Diagram(coordinateSystem(preserveAspectRatio=false)));
      end FiveZoneDuctNetwork;

      model FiveZoneVAV "Thermal zones, VAV terminals, and duct network"
        replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium
                                                                                "medium for the air";

        replaceable package MediumWat = Modelica.Media.Interfaces.PartialMedium
                                                                                "medium for the water";

        parameter Modelica.Units.SI.Pressure PreAirDroMai1
          "pressure drop 1 across the duct";

        parameter Modelica.Units.SI.Pressure PreAirDroMai2
          "Pressure drop 2 across the main duct";

        parameter Modelica.Units.SI.Pressure PreAirDroMai3
          "Pressure drop 3 across the main duct";

        parameter Modelica.Units.SI.Pressure PreAirDroMai4
          "Pressure drop 4 across the main duct";

        parameter Modelica.Units.SI.Pressure PreAirDroBra1
          "Pressure drop 1 across the duct branch 1";

        parameter Modelica.Units.SI.Pressure PreAirDroBra2
          "Pressure drop 1 across the duct branch 2";

        parameter Modelica.Units.SI.Pressure PreAirDroBra3
          "Pressure drop 1 across the duct branch 3";

        parameter Modelica.Units.SI.Pressure PreAirDroBra4
          "Pressure drop 1 across the duct branch 4";

        parameter Modelica.Units.SI.Pressure PreAirDroBra5
          "Pressure drop 1 across the duct branch 5";

        parameter Modelica.Units.SI.Pressure PreWatDroMai1
          "Pressure drop 1 across the pipe";

        parameter Modelica.Units.SI.Pressure PreWatDroMai2
          "Pressure drop 2 across the main pipe";

        parameter Modelica.Units.SI.Pressure PreWatDroMai3
          "Pressure drop 3 across the main pipe";

        parameter Modelica.Units.SI.Pressure PreWatDroMai4
          "Pressure drop 4 across the main pipe";

        parameter Modelica.Units.SI.Pressure PreWatDroBra1
          "Pressure drop 1 across the pipe branch 1";

        parameter Modelica.Units.SI.Pressure PreWatDroBra2
          "Pressure drop 1 across the pipe branch 2";

        parameter Modelica.Units.SI.Pressure PreWatDroBra3
          "Pressure drop 1 across the pipe branch 3";

        parameter Modelica.Units.SI.Pressure PreWatDroBra4
          "Pressure drop 1 across the pipe branch 4";

        parameter Modelica.Units.SI.Pressure PreWatDroBra5
          "Pressure drop 1 across the pipe branch 5";

        parameter Modelica.Units.SI.MassFlowRate mAirFloRat1
          "mass flow rate for vav 1";

        parameter Modelica.Units.SI.MassFlowRate mAirFloRat2
          "mass flow rate for vav 2";

        parameter Modelica.Units.SI.MassFlowRate mAirFloRat3
          "mass flow rate for vav 3";

        parameter Modelica.Units.SI.MassFlowRate mAirFloRat4
          "mass flow rate for vav 4";

        parameter Modelica.Units.SI.MassFlowRate mAirFloRat5
          "mass flow rate for vav 5";

        parameter Modelica.Units.SI.MassFlowRate mWatFloRat1
          "mass flow rate for vav 1";

        parameter Modelica.Units.SI.MassFlowRate mWatFloRat2
          "mass flow rate for vav 2";

        parameter Modelica.Units.SI.MassFlowRate mWatFloRat3
          "mass flow rate for vav 3";

        parameter Modelica.Units.SI.MassFlowRate mWatFloRat4
          "mass flow rate for vav 4";

        parameter Modelica.Units.SI.MassFlowRate mWatFloRat5
          "mass flow rate for vav 5";

        parameter Modelica.Units.SI.Pressure PreDroAir1
          "Pressure drop in the air side of vav 1";
        parameter Modelica.Units.SI.Pressure PreDroWat1
          "Pressure drop in the water side of vav 1";
        parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
          "Heat exchanger effectiveness of vav 1";

        parameter Modelica.Units.SI.Pressure PreDroAir2
          "Pressure drop in the air side of vav 2";
        parameter Modelica.Units.SI.Pressure PreDroWat2
          "Pressure drop in the water side of vav 2";
        parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
          "Heat exchanger effectiveness of vav 2";

        parameter Modelica.Units.SI.Pressure PreDroAir3
          "Pressure drop in the air side of vav 3";
        parameter Modelica.Units.SI.Pressure PreDroWat3
          "Pressure drop in the water side of vav 3";
        parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
          "Heat exchanger effectiveness of vav 3";

        parameter Modelica.Units.SI.Pressure PreDroAir4
          "Pressure drop in the air side of vav 4";
        parameter Modelica.Units.SI.Pressure PreDroWat4
          "Pressure drop in the water side of vav 4";
        parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
          "Heat exchanger effectiveness of vav 4";

        parameter Modelica.Units.SI.Pressure PreDroAir5
          "Pressure drop in the air side of vav 1";
        parameter Modelica.Units.SI.Pressure PreDroWat5
          "Pressure drop in the water side of vav 1";
        parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
          "Heat exchanger effectiveness of vav 5";

        parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=p_start
          "Start value of pressure";
        parameter Modelica.Media.Interfaces.Types.Temperature T_start=T_start
          "Start value of temperature";
        parameter Modelica.Media.Interfaces.Types.MassFraction X_start[MediumAir.nX]=X_start
          "Start value of mass fractions m_i/m";
        parameter Modelica.Media.Interfaces.Types.ExtraProperty C_start[MediumAir.nC]=C_start
          "Start value of trace substances";
        parameter Modelica.Media.Interfaces.Types.ExtraProperty C_nominal[MediumAir.nC]=C_nominal
          "Nominal value of trace substances. (Set to typical order of magnitude.)";

        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneDuctNetwork
          ReheatWatNet(
          redeclare package Medium = MediumWat,
          PreDroMai1=PreWatDroMai1,
          PreDroMai2=PreWatDroMai2,
          PreDroMai3=PreWatDroMai3,
          PreDroMai4=PreWatDroMai4,
          PreDroBra1=PreWatDroBra1,
          PreDroBra2=PreWatDroBra2,
          PreDroBra3=PreWatDroBra3,
          PreDroBra4=PreWatDroBra4,
          PreDroBra5=PreWatDroBra5,
          mFloRat1=mWatFloRat1,
          mFloRat2=mWatFloRat2,
          mFloRat3=mWatFloRat3,
          mFloRat4=mWatFloRat4,
          mFloRat5=mWatFloRat5)
          annotation (Placement(transformation(extent={{-76,64},{-46,30}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneDuctNetwork
          AirNetWor(
          redeclare package Medium = MediumAir,
          PreDroMai1=PreAirDroMai1,
          PreDroMai2=PreAirDroMai2,
          PreDroMai3=PreAirDroMai3,
          PreDroMai4=PreAirDroMai4,
          mFloRat1=mAirFloRat1,
          mFloRat2=mAirFloRat2,
          mFloRat3=mAirFloRat3,
          mFloRat4=mAirFloRat4,
          mFloRat5=mAirFloRat5,
          PreDroBra1=PreAirDroBra1,
          PreDroBra2=PreAirDroBra2,
          PreDroBra3=PreAirDroBra3,
          PreDroBra4=PreAirDroBra4,
          PreDroBra5=PreAirDroBra5)
          annotation (Placement(transformation(extent={{-74,-52},{-44,-18}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
          vAV1(
          zonNam="cor",
          redeclare package MediumAir = MediumAir,
          redeclare package MediumWat = MediumWat,
          mAirFloRat=mAirFloRat1,
          mWatFloRat=mWatFloRat1,
          PreDroAir=PreDroAir1,
          PreDroWat=PreDroWat1,
          eps=eps1)
          annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
        Buildings.Fluid.MixingVolumes.MixingVolume vol[5](
          redeclare package Medium = MediumAir,
          each energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
          each p_start=p_start,
          each T_start=T_start,
          each X_start=X_start,
          each final C_start=C_start,
          each C_nominal=C_nominal,
          each nPorts=4,
          each V=10,
          m_flow_nominal={mAirFloRat1,mAirFloRat2,mAirFloRat3,mAirFloRat4,mAirFloRat5},
          each allowFlowReversal=true,
          each use_C_flow=true)
          annotation (Placement(transformation(extent={{70,-70},{90,-50}})));

        Buildings.HeatTransfer.Sources.PrescribedHeatFlow fixedHeatFlow[5]
          annotation (Placement(transformation(extent={{-40,-84},{-20,-64}})));
        Modelica.Blocks.Interfaces.RealInput Q_flow[5]
          annotation (Placement(transformation(extent={{-120,-84},{-100,-64}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package
            Medium =
              MediumWat) "Second port, typically outlet"
          annotation (Placement(transformation(extent={{30,90},{50,110}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package
            Medium =
              MediumWat) "Second port, typically outlet"
          annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package
            Medium =
              MediumAir)
          "Second port, typically outlet"
          annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package
            Medium =
              MediumAir)
          "Second port, typically outlet"
          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Modelica.Blocks.Interfaces.RealInput airFloRatSet[5]
          "Connector of setpoint input signal"
          annotation (Placement(transformation(extent={{-120,76},{-100,96}})));
        Modelica.Blocks.Interfaces.RealInput yVal[5]
          "Actuator position (0: closed, 1: open)"
          annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
        Modelica.Blocks.Interfaces.BooleanInput On[5]
          annotation (Placement(transformation(extent={{-120,-22},{-100,-2}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TZonSen[5](redeclare package
            Medium = MediumAir)
          annotation (Placement(transformation(extent={{138,-68},{118,-48}})));
        Modelica.Blocks.Interfaces.RealOutput p "Pressure at port" annotation (
            Placement(transformation(extent={{200,-22},{220,-2}}),
              iconTransformation(extent={{100,-100},{120,-80}})));
        Modelica.Blocks.Interfaces.RealOutput TZon[5]
          "Temperature of the passing fluid"
          annotation (Placement(transformation(extent={{200,70},{220,90}}),
              iconTransformation(extent={{100,30},{120,50}})));

        Modelica.Blocks.Interfaces.RealOutput yDam[5]
          "Control signal for terminal box damper"
          annotation (Placement(transformation(extent={{200,44},{220,64}}),
              iconTransformation(extent={{100,4},{120,24}})));
        Modelica.Blocks.Sources.RealExpression yDamMea[5](y={vAV1.dam.y,vAV2.dam.y,
              vAV3.dam.y,vAV4.dam.y,vAV5.dam.y})
          annotation (Placement(transformation(extent={{170,44},{190,64}}),
              iconTransformation(extent={{100,70},{120,90}})));
        Modelica.Blocks.Interfaces.RealOutput yReaHea[5]
          "Control signal for terminal box reheat"
          annotation (Placement(transformation(extent={{200,18},{220,38}}),
              iconTransformation(extent={{100,-20},{120,0}})));
        Modelica.Blocks.Sources.RealExpression yReaValMea[5](y={vAV1.rehVal.y,
              vAV2.rehVal.y,vAV3.rehVal.y,vAV4.rehVal.y,vAV5.rehVal.y})
          annotation (Placement(transformation(extent={{170,18},{190,38}})));

        Modelica.Blocks.Sources.RealExpression TZonAir[5](y=vol.heatPort.T)
          annotation (Placement(transformation(extent={{170,70},{190,90}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
          vAV2(
          zonNam="sou",
          redeclare package MediumAir = MediumAir,
          redeclare package MediumWat = MediumWat,
          mAirFloRat=mAirFloRat2,
          mWatFloRat=mWatFloRat2,
          PreDroAir=PreDroAir2,
          PreDroWat=PreDroWat2,
          eps=eps2)
          annotation (Placement(transformation(extent={{30,-2},{50,18}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
          vAV3(
          zonNam="eas",
          redeclare package MediumAir = MediumAir,
          redeclare package MediumWat = MediumWat,
          mAirFloRat=mAirFloRat3,
          mWatFloRat=mWatFloRat3,
          PreDroAir=PreDroAir3,
          PreDroWat=PreDroWat3,
          eps=eps3)
          annotation (Placement(transformation(extent={{72,-2},{92,18}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
          vAV4(
          zonNam="nor",
          redeclare package MediumAir = MediumAir,
          redeclare package MediumWat = MediumWat,
          mAirFloRat=mAirFloRat4,
          mWatFloRat=mWatFloRat4,
          PreDroAir=PreDroAir4,
          PreDroWat=PreDroWat4,
          eps=eps4)
          annotation (Placement(transformation(extent={{118,-2},{138,18}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal
          vAV5(
          zonNam="wes",
          redeclare package MediumAir = MediumAir,
          redeclare package MediumWat = MediumWat,
          mAirFloRat=mAirFloRat5,
          mWatFloRat=mWatFloRat5,
          PreDroAir=PreDroAir5,
          PreDroWat=PreDroWat5,
          eps=eps5)
          annotation (Placement(transformation(extent={{158,-2},{178,18}})));

        Modelica.Blocks.Interfaces.RealInput yCoo[5]
          "Cooling PID signal measurement"
          annotation (Placement(transformation(extent={{-120,16},{-100,36}})));
        Modelica.Blocks.Interfaces.RealInput yHea[5]
          "Heating PID signal measurement"
          annotation (Placement(transformation(extent={{-120,-4},{-100,16}})));
        Modelica.Blocks.Sources.RealExpression Vflow_setMea[5](y={vAV1.airFloRatSet
              *vAV1.mAirFloRat/1.2,vAV2.airFloRatSet*vAV2.mAirFloRat/1.2,vAV3.airFloRatSet
              *vAV3.mAirFloRat/1.2,vAV4.airFloRatSet*vAV4.mAirFloRat/1.2,vAV5.airFloRatSet
              *vAV5.mAirFloRat/1.2})
          "VAV terminal airflow setpoint measurement"
          annotation (Placement(transformation(extent={{170,-50},{190,-30}})));
        Modelica.Blocks.Interfaces.RealOutput Vflow_set[5]
          "VAV terminal airflow setpoint" annotation (Placement(transformation(
                extent={{200,-50},{220,-30}}), iconTransformation(extent={{100,-46},
                  {120,-26}})));
        Modelica.Blocks.Sources.RealExpression Vflow_Mea[5](y={vAV1.m_flow.m_flow
              /1.2,vAV2.m_flow.m_flow/1.2,vAV3.m_flow.m_flow/1.2,vAV4.m_flow.m_flow
              /1.2,vAV5.m_flow.m_flow/1.2}) "VAV terminal airflow measurement"
          annotation (Placement(transformation(extent={{170,-70},{190,-50}})));
        Modelica.Blocks.Interfaces.RealOutput Vflow[5] "VAV terminal airflow"
          annotation (Placement(transformation(extent={{200,-70},{220,-50}}),
              iconTransformation(extent={{100,-72},{120,-52}})));
        Modelica.Blocks.Interfaces.RealOutput TSup[5]
          "VAV supply air temperature" annotation (Placement(transformation(
                extent={{200,-90},{220,-70}}), iconTransformation(extent={{100,56},
                  {120,76}})));
        Modelica.Blocks.Sources.RealExpression TSupMea[5](y={vAV1.TAirLea,vAV2.TAirLea,
              vAV3.TAirLea,vAV4.TAirLea,vAV5.TAirLea})
          annotation (Placement(transformation(extent={{170,-90},{190,-70}})));

        Modelica.Blocks.Interfaces.RealInput nPeo[5] "Number of occupant" annotation (
           Placement(transformation(extent={{-120,-100},{-100,-80}}),
              iconTransformation(extent={{-120,-106},{-100,-86}})));
        Modelica.Blocks.Math.Gain gaiCO2[5](each k=8.18E-6)
          "CO2 emission per person"
          annotation (Placement(transformation(extent={{-40,-96},{-28,-84}})));

        Buildings.Fluid.Sensors.TraceSubstances senCO2[5](redeclare package
            Medium =                                                                 MediumAir,
          each warnAboutOnePortConnection=false) "Sensor at volume"
          annotation (Placement(transformation(extent={{82,-98},{98,-82}})));
        Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra[5](each
            MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
          "Conversion from mass fraction CO2 to volume fraction CO2"
          annotation (Placement(transformation(extent={{104,-96},{116,-84}})));
        Modelica.Blocks.Math.Gain gaiPPM[5](k=1e6)
          "Convert mass fraction to PPM"
          annotation (Placement(transformation(extent={{126,-96},{138,-84}})));
        Modelica.Blocks.Interfaces.RealOutput CO2Zon[5]
          "Zonal CO2 volume fraction PPM" annotation (Placement(transformation(
                extent={{200,-104},{220,-84}}), iconTransformation(extent={{100,
                  80},{120,100}})));
        Buildings.Fluid.Sources.MassFlowSource_WeatherData leaAir[4](
          m_flow={0.206*1.2, 0.137*1.2, 0.206*1.2, 0.137*1.2},
          each nPorts=1,
          redeclare package Medium = MediumAir,
          C={fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
              Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumAir.nC),
              fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
              Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumAir.nC),
              fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
              Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumAir.nC),
              fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
              Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, MediumAir.nC)})
          "Air infiltration through the envelope for four exterior zones (no infiltration for core zone)"
          annotation (Placement(transformation(extent={{38,-120},{58,-100}})));

        Modelica.Icons.SignalBus weaBus
          annotation (Placement(transformation(extent={{-8,-128},{8,-112}}),
              iconTransformation(extent={{-8,-128},{8,-112}})));
      equation

        connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,-74},{
                30,-74},{30,-60},{70,-60}},
                                          color={191,0,0}));
        connect(fixedHeatFlow.Q_flow, Q_flow)
          annotation (Line(points={{-40,-74},{-110,-74}}, color={0,0,127},
            pattern=LinePattern.Dash));

        connect(vAV1.port_b, vol[1].ports[1])
                                             annotation (Line(points={{10,8},{14,8},{14,
                -78},{76,-78},{76,-74},{78.5,-74},{78.5,-70}},
                                               color={0,140,72},
            thickness=0.5,
            pattern=LinePattern.Dash));
        connect(vAV2.port_b, vol[2].ports[1])
                                             annotation (Line(points={{50,8},{60,8},{60,
                -78},{76,-78},{76,-74},{78.5,-74},{78.5,-70}},
                                               color={0,140,72},
            thickness=0.5,      pattern=LinePattern.Dash));
        connect(vAV3.port_b, vol[3].ports[1])
                                             annotation (Line(points={{92,8},{100,8},{
                100,-78},{80,-78},{80,-70},{78.5,-70}},
                                               color={0,140,72},
            thickness=0.5,      pattern=LinePattern.Dash));
        connect(vAV4.port_b, vol[4].ports[1])
                                             annotation (Line(points={{138,8},{150,8},
                {150,-78},{80,-78},{80,-70},{78.5,-70}},
                                               color={0,140,72},
            thickness=0.5,      pattern=LinePattern.Dash));
        connect(vAV5.port_b, vol[5].ports[1])
                                             annotation (Line(points={{178,8},{188,8},
                {188,-78},{80,-78},{80,-70},{78.5,-70}},
                                               color={0,140,72},
            thickness=0.5,      pattern=LinePattern.Dash));

        for i in 1:5 loop
          connect(TZonSen[i].port_b, AirNetWor.ports_a[i]);
          connect(TZonSen[i].port_a, vol[i].ports[2]);
        end for;

        connect(ReheatWatNet.port_b, port_b_Wat) annotation (Line(
            points={{-76,57.2},{-74,57.2},{-74,72},{40,72},{40,100}},
            color={255,0,0},
            thickness=1));
        connect(ReheatWatNet.port_a, port_a_Wat) annotation (Line(
            points={{-76,40.2},{-76,40.2},{-76,40},{-82,40},{-82,76},{-40,76},{
                -40,100}},
            color={255,0,0},
            thickness=1));
        connect(AirNetWor.port_a, port_a_Air)
          annotation (Line(points={{-74,-28.2},{-88,-28.2},{-88,40},{-100,40}}, color={0,140,72},
            thickness=0.5));

        connect(AirNetWor.port_b, port_b_Air)
          annotation (Line(points={{-74,-45.2},{-80,-45.2},{-80,-60},{-100,-60}}, color={0,140,72},
            thickness=0.5));

        connect(AirNetWor.p, p) annotation (Line(
            points={{-42.5,-35},{-8,-35},{-8,-12},{210,-12}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(TZonAir.y, TZon) annotation (Line(
            points={{191,80},{210,80}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(On[2], vAV2.On) annotation (Line(points={{-110,-14},{18,-14},{18,0},{29,
                0}}, color={255,0,255}));
        connect(On[3], vAV3.On) annotation (Line(points={{-110,-12},{-72,-12},{
                -72,-8},{56,-8},{56,0},{71,0}},
                                    color={255,0,255}));
        connect(On[4], vAV4.On) annotation (Line(points={{-110,-10},{-72,-10},{-72,-10},
                {100,-10},{100,0},{117,0}},
                                       color={255,0,255}));
        connect(On[5], vAV5.On) annotation (Line(points={{-110,-8},{-72,-8},{-72,-10},
                {148,-10},{148,0},{157,0}},
                                       color={255,0,255}));
        connect(On[1], vAV1.On) annotation (Line(points={{-110,-16},{-72,-16},{-72,0},
                {-11,0}},
                     color={255,0,255}));
        connect(yVal[1], vAV1.yVal) annotation (Line(points={{-110,56},{-34,56},{-34,12},
                {-11,12}}, color={0,0,127}));
        connect(yVal[2], vAV2.yVal) annotation (Line(points={{-110,58},{20,58},{20,12},
                {29,12}}, color={0,0,127}));
        connect(yVal[3], vAV3.yVal) annotation (Line(points={{-110,60},{64,60},{64,12},
                {71,12}}, color={0,0,127}));
        connect(yVal[4], vAV4.yVal) annotation (Line(points={{-110,62},{110,62},{110,12},
                {117,12}}, color={0,0,127}));
        connect(yVal[5], vAV5.yVal) annotation (Line(points={{-110,64},{-4,64},{-4,62},
                {150,62},{150,12},{157,12}}, color={0,0,127}));
        connect(airFloRatSet[1], vAV1.airFloRatSet) annotation (Line(points={{-110,82},
                {-30,82},{-30,16},{-11,16}},     color={0,0,127}));
        connect(airFloRatSet[2], vAV2.airFloRatSet) annotation (Line(points={{-110,84},
                {18,84},{18,16},{29,16}},     color={0,0,127}));
        connect(airFloRatSet[3], vAV3.airFloRatSet) annotation (Line(points={{-110,
                86},{62,86},{62,16},{71,16}}, color={0,0,127}));
        connect(airFloRatSet[4], vAV4.airFloRatSet) annotation (Line(points={{-110,88},
                {108,88},{108,16},{117,16}},     color={0,0,127}));
        connect(airFloRatSet[5], vAV5.airFloRatSet) annotation (Line(points={{-110,90},
                {148,90},{148,16},{157,16}},     color={0,0,127}));
        connect(vAV1.port_a_Wat, ReheatWatNet.ports_b[1]) annotation (Line(
            points={{-8,18},{-10,18},{-10,41.9},{-46,41.9}},
            color={238,46,47},
            thickness=0.5));
        connect(vAV2.port_a_Wat, ReheatWatNet.ports_b[2]) annotation (Line(
            points={{32,18},{32,38},{-46,38},{-46,40.54}},
            color={238,46,47},
            thickness=0.5));
        connect(vAV3.port_a_Wat, ReheatWatNet.ports_b[3]) annotation (Line(
            points={{74,18},{74,32},{-46,32},{-46,39.18}},
            color={238,46,47},
            thickness=0.5));
        connect(vAV4.port_a_Wat, ReheatWatNet.ports_b[4]) annotation (Line(
            points={{120,18},{118,18},{118,37.82},{-46,37.82}},
            color={238,46,47},
            thickness=0.5));
        connect(vAV5.port_a_Wat, ReheatWatNet.ports_b[5]) annotation (Line(
            points={{160,18},{162,18},{162,36.46},{-46,36.46}},
            color={238,46,47},
            thickness=0.5));
        connect(vAV1.port_b_Wat, ReheatWatNet.ports_a[1]) annotation (Line(
            points={{-2,18},{-2,60.26},{-46,60.26}},
            color={238,46,47},
            thickness=0.5,
            pattern=LinePattern.Dash));
        connect(vAV2.port_b_Wat, ReheatWatNet.ports_a[2]) annotation (Line(
            points={{38,18},{40,18},{40,58.9},{-46,58.9}},
            color={238,46,47},
            thickness=0.5,
            pattern=LinePattern.Dash));
        connect(vAV3.port_b_Wat, ReheatWatNet.ports_a[3]) annotation (Line(
            points={{80,18},{80,54},{-46,54},{-46,57.54}},
            color={238,46,47},
            thickness=0.5,
            pattern=LinePattern.Dash));
        connect(vAV4.port_b_Wat, ReheatWatNet.ports_a[4]) annotation (Line(
            points={{126,18},{126,56.18},{-46,56.18}},
            color={238,46,47},
            thickness=0.5,
            pattern=LinePattern.Dash));
        connect(vAV5.port_b_Wat, ReheatWatNet.ports_a[5]) annotation (Line(
            points={{166,18},{166,52},{-46,52},{-46,54.82}},
            color={238,46,47},
            thickness=0.5,
            pattern=LinePattern.Dash));
        connect(vAV1.port_a, AirNetWor.ports_b[1]) annotation (Line(
            points={{-10,8},{-28,8},{-28,-29.9},{-44,-29.9}},
            color={0,127,0},
            thickness=0.5));
        connect(vAV2.port_a, AirNetWor.ports_b[2]) annotation (Line(
            points={{30,8},{16,8},{16,-30},{-16,-30},{-16,-28.54},{-44,-28.54}},
            color={0,127,0},
            thickness=0.5));
        connect(vAV3.port_a, AirNetWor.ports_b[3]) annotation (Line(
            points={{72,8},{58,8},{58,-28},{-44,-28},{-44,-27.18}},
            color={0,127,0},
            thickness=0.5));
        connect(vAV4.port_a, AirNetWor.ports_b[4]) annotation (Line(
            points={{118,8},{108,8},{108,-25.82},{-44,-25.82}},
            color={0,127,0},
            thickness=0.5));
        connect(vAV5.port_a, AirNetWor.ports_b[5]) annotation (Line(
            points={{158,8},{146,8},{146,-24.46},{-44,-24.46}},
            color={0,127,0},
            thickness=0.5));

        connect(yDamMea.y, yDam) annotation (Line(points={{191,54},{210,54}},
                          color={0,0,127}));
        connect(yReaValMea.y, yReaHea)
          annotation (Line(points={{191,28},{210,28}}, color={0,0,127}));
        connect(Vflow_setMea.y, Vflow_set)
          annotation (Line(points={{191,-40},{210,-40}}, color={0,0,127}));
        connect(Vflow_Mea.y, Vflow)
          annotation (Line(points={{191,-60},{210,-60}}, color={0,0,127}));
        connect(TSupMea.y, TSup)
          annotation (Line(points={{191,-80},{210,-80}}, color={0,0,127}));

        connect(nPeo, gaiCO2.u)
          annotation (Line(points={{-110,-90},{-41.2,-90}}, color={0,0,127}));
        connect(gaiCO2.y, vol.C_flow[1])
          annotation (Line(points={{-27.4,-90},{68,-90},{68,-66}}, color={0,0,127}));

        for i in 1:5 loop
          connect(senCO2[i].port, vol[i].ports[3]);
        end for;
        connect(senCO2.C, conMasVolFra.m) annotation (Line(
            points={{98.8,-90},{103.4,-90}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(conMasVolFra.V, gaiPPM.u)
          annotation (Line(points={{116.6,-90},{124.8,-90}}, color={0,0,127}));
        connect(gaiPPM.y, CO2Zon) annotation (Line(points={{138.6,-90},{166,-90},
                {166,-94},{210,-94}}, color={0,0,127}));
        for i in 1:4 loop
          connect(leaAir[i].ports[1], vol[i+1].ports[4]) annotation (Line(points={{58,-110},
                  {81.5,-110},{81.5,-70}},                                                                                            color={0,140,72},

              pattern=LinePattern.Dash,
              thickness=0.5));
        end for;
        connect(weaBus, leaAir[1].weaBus) annotation (Line(
            points={{0,-120},{0,-109.8},{38,-109.8}},
            color={255,204,51},
            thickness=0.5));
        connect(weaBus, leaAir[2].weaBus) annotation (Line(
            points={{0,-120},{0,-109.8},{38,-109.8}},
            color={255,204,51},
            thickness=0.5));
        connect(weaBus, leaAir[3].weaBus) annotation (Line(
            points={{0,-120},{0,-109.8},{38,-109.8}},
            color={255,204,51},
            thickness=0.5));
        connect(weaBus, leaAir[4].weaBus) annotation (Line(
            points={{0,-120},{0,-109.8},{38,-109.8}},
            color={255,204,51},
            thickness=0.5));
          annotation (Placement(transformation(extent={{84,-82},{100,-98}})),
                      Placement(transformation(extent={{122,-98},{138,-82}})),
                      Line(points={{100.8,-90},{121.2,-90}}, color={0,0,127}),
                    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},
                  {200,100}}),                                        graphics={
              Line(points={{-90,40},{80,40}}, color={0,127,255}),
              Line(points={{-90,-60},{80,-60}}, color={0,127,255}),
              Line(points={{80,40},{80,-60}}, color={0,127,255}),
              Line(points={{50,40},{50,-60}}, color={0,127,255}),
              Line(points={{20,40},{20,-60}}, color={0,127,255}),
              Line(points={{-10,40},{-10,-60}}, color={0,127,255}),
              Line(points={{-40,40},{-40,-60}}, color={0,127,255}),
              Rectangle(
                extent={{-46,0},{-34,-20}},
                lineColor={28,108,200},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-16,0},{-4,-20}},
                lineColor={28,108,200},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{14,0},{26,-20}},
                lineColor={28,108,200},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{44,0},{56,-20}},
                lineColor={28,108,200},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{74,0},{86,-20}},
                lineColor={28,108,200},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-40,90},{-40,60}}, color={255,0,0}),
              Line(points={{-60,60},{-40,60}}, color={255,0,0}),
              Line(points={{-60,60},{-60,-12}}, color={255,0,0}),
              Line(points={{64,20},{-60,20}}, color={255,0,0}),
              Line(points={{-24,20},{-24,-12}}, color={255,0,0}),
              Line(points={{6,20},{6,-12}}, color={255,0,0}),
              Line(points={{36,20},{36,-12}}, color={255,0,0}),
              Line(points={{64,20},{64,-12}}, color={255,0,0}),
              Line(points={{-60,-12},{-46,-12}}, color={255,0,0}),
              Line(points={{-24,-12},{-16,-12}}, color={255,0,0}),
              Line(points={{6,-12},{14,-12}}, color={255,0,0}),
              Line(points={{36,-12},{44,-12}}, color={255,0,0}),
              Line(points={{64,-12},{74,-12}}, color={255,0,0}),
              Line(points={{90,-32},{-36,-32}}, color={255,0,0}),
              Line(points={{-36,-20},{-36,-32}}, color={255,0,0}),
              Line(points={{-6,-20},{-6,-32}}, color={255,0,0}),
              Line(points={{24,-20},{24,-32}}, color={255,0,0}),
              Line(points={{54,-20},{54,-32}}, color={255,0,0}),
              Line(points={{84,-20},{84,-32}}, color={255,0,0}),
              Line(points={{90,60},{90,-32}}, color={255,0,0}),
              Line(points={{40,60},{90,60}}, color={255,0,0}),
              Line(points={{40,90},{40,60}}, color={255,0,0}),
              Text(
                extent={{-148,-110},{152,-70}},
                textColor={0,0,255},
                textString="%name")}),
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},
                  {200,100}})),
          Documentation(info="<html>
<p>A hot water reheat coil is installed in each VAV terminal. The components and control systems of the VAV is shown in the figure below:</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/VAVControl.png\"/></p>
<p>The controller for terminal VAV box is based on the &quot;single maximum VAV reheat control logic&quot;.</p>
<ul>
<li>When the Zone State is cooling, the cooling-loop output shall be mapped to the active airflow setpoint from the cooling minimum endpoint to the cooling maximum endpoint. Heating coil is disabled. When the Zone State is deadband, the active airflow setpoint shall be the minimum endpoint. Heating coil is disabled.</li>
<li>When the Zone State is heating, the active airflow setpoint shall be the minimum endpoint. The reheat valve position shall be mapped to the supply air temperature setpoint from the heating minimum endpoint to the heating maximum endpoint.</li>
</ul>
<p>VAV damper position is controlled by a PI controller to maintain the air flow rate at setpoint. Heating coil valve position is controlled by a PI controller to maintain the supply air temperature at setpoint.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.VAVTerminal</a> for a description of the VAV terminal model. </p>
</html>",       revisions = "<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang:
<p> First implementation.</p>
</ul>
</html>"));
      end FiveZoneVAV;

      model VAVTerminal "The model of the VAV terminals"
          parameter String zonNam "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
        replaceable package MediumAir =
            Modelica.Media.Interfaces.PartialMedium "Medium for the air";
        replaceable package MediumWat =
            Modelica.Media.Interfaces.PartialMedium "Medium for the water";
        parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
        parameter Modelica.Units.SI.MassFlowRate mWatFloRat "mass flow rate for air";
        parameter Modelica.Units.SI.Pressure PreDroAir
          "Pressure drop in the air side";
        parameter Modelica.Units.SI.Pressure PreDroWat
          "Pressure drop in the water side";
        parameter Modelica.Units.SI.Efficiency eps(max=1) = 0.8
          "Heat exchanger effectiveness";

        Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage dam(
          redeclare package Medium = MediumAir,
          m_flow_nominal=mAirFloRat,
          dpValve_nominal=PreDroAir,
          riseTime=15,
          y_start=0.3)               annotation (Placement(transformation(extent={{-12,-10},
                  {8,10}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort TEnt(redeclare package Medium =
                     MediumAir) annotation (Placement(transformation(extent=
                 {{-88,-10},{-68,10}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort TLea(
          redeclare package Medium = MediumAir,
          m_flow_nominal=mAirFloRat,
          tau=1,
          transferHeat=true)
          annotation (Placement(transformation(extent={{26,10},{46,-10}})));
        Modelica.Fluid.Sensors.MassFlowRate m_flow(redeclare package Medium =
              MediumAir)
          annotation (Placement(transformation(extent={{56,-10},{76,10}})));
        Modelica.Fluid.Sensors.Pressure pEnt(redeclare package Medium =
              MediumAir) annotation (Placement(transformation(extent={{-16,
                  -20},{-36,-40}})));
        Modelica.Fluid.Sensors.Pressure pLea(redeclare package Medium =
              MediumAir) annotation (Placement(transformation(extent={{30,-20},
                  {10,-40}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
              MediumAir)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
              MediumAir)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Coil.BaseClasses.DryCoil heaCoil(
          redeclare package MediumAir = MediumAir,
          redeclare package MediumWat = MediumWat,
          mAirFloRat=mAirFloRat,
          mWatFloRat=mWatFloRat,
          PreDroWat=0,
          eps=eps,
          PreDroAir=0)
          annotation (Placement(transformation(extent={{-40,-4},{-60,16}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package
            Medium =
              MediumWat)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package
            Medium =
              MediumWat)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
          pI(
          yMin=0.3,
          k=0.02,
          Ti=120)
          annotation (Placement(transformation(extent={{10,70},{30,90}})));
        Modelica.Blocks.Math.Gain gain(k=1/mAirFloRat/1.25)
                                       annotation (Placement(transformation(
              extent={{4,-4},{-4,4}},
              rotation=-90,
              origin={66,24})));
        Modelica.Blocks.Interfaces.RealInput airFloRatSet
          "Connector of setpoint input signal" annotation (Placement(
              transformation(extent={{-120,70},{-100,90}})));
        Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage rehVal(
          redeclare package Medium = MediumWat,
          m_flow_nominal=mWatFloRat,
          dpValve_nominal=PreDroWat,
          y_start=0.01) annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=-90,
              origin={-20,42})));
        Modelica.Blocks.Interfaces.RealInput yVal
          "Actuator position (0: closed, 1: open)"
          annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
        Modelica.Blocks.Interfaces.RealOutput TAirLea
          "Temperature of the passing fluid"
          annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
        Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
          annotation (Placement(transformation(extent={{-60,76},{-40,96}})));
        ReadOverwrite.WriteZoneLoc oveZonLoc(zonNam=zonNam)
          annotation (Placement(transformation(extent={{-68,40},{-48,60}})));
      equation
        connect(TEnt.port_a, port_a) annotation (Line(
            points={{-88,0},{-88,0},{-100,0}},
            color={0,140,72},
            thickness=0.5));
        connect(dam.port_b, TLea.port_a) annotation (Line(
            points={{8,0},{26,0}},
            color={0,140,72},
            thickness=0.5));
        connect(TLea.port_b, m_flow.port_a) annotation (Line(
            points={{46,0},{56,0}},
            color={0,140,72},
            thickness=0.5));
        connect(pLea.port, TLea.port_a) annotation (Line(
            points={{20,-20},{20,0},{26,0}},
            color={0,140,72},
            thickness=0.5));
        connect(pEnt.port, dam.port_a) annotation (Line(
            points={{-26,-20},{-26,0},{-12,0}},
            color={0,140,72},
            thickness=0.5));
        connect(m_flow.m_flow, gain.u) annotation (Line(
            points={{66,11},{66,19.2}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(gain.y,pI.mea)  annotation (Line(
            points={{66,28.4},{66,52},{0,52},{0,74},{8,74}},
            color={0,0,127}));
        connect(pI.set, airFloRatSet)
          annotation (Line(points={{8,80},{-110,80}}, color={0,0,127}));
        connect(rehVal.port_b, port_b_Wat) annotation (Line(
            points={{-20,52},{-20,100}},
            color={255,0,0},
            thickness=1));
        connect(heaCoil.port_a_Air, TEnt.port_b) annotation (Line(
            points={{-60,0},{-64,0},{-68,0}},
            color={0,140,72},
            thickness=0.5));
        connect(heaCoil.port_b_Air,dam. port_a)
          annotation (Line(points={{-40,0},{-26,0},{-12,0}},
                                                     color={0,140,72},
            thickness=0.5));
        connect(rehVal.port_a, heaCoil.port_b_Wat) annotation (Line(
            points={{-20,32},{-22,32},{-22,28},{-60,28},{-60,12}},
            color={255,0,0},
            thickness=1));
        connect(heaCoil.port_a_Wat, port_a_Wat) annotation (Line(
            points={{-40,12},{-40,36},{-80,36},{-80,100}},
            color={255,0,0},
            thickness=1));
        connect(booleanExpression.y, pI.On) annotation (Line(
            points={{-39,86},{8,86}},
            color={255,0,255}));
        connect(TLea.T, TAirLea) annotation (Line(points={{36,-11},{36,-60},
                {110,-60}}, color={0,0,127}));
        connect(m_flow.port_b, port_b) annotation (Line(
            points={{76,0},{88,0},{88,0},{100,0}},
            color={0,140,72},
            thickness=0.5));
        connect(oveZonLoc.yReaHea_out, rehVal.y) annotation (Line(points={{-47,46},
                {-40,46},{-40,42},{-32,42}},         color={0,0,127}));
        connect(yVal, oveZonLoc.yReaHea_in) annotation (Line(points={{-110,40},
                {-90,40},{-90,46},{-70,46}},
                                    color={0,0,127}));
        connect(pI.y, oveZonLoc.yDam_in) annotation (Line(points={{31,80},{34,
                80},{34,68},{-78,68},{-78,54},{-70,54}},
                                                 color={0,0,127}));
        connect(oveZonLoc.yDam_out,dam. y)
          annotation (Line(points={{-47,54},{-2,54},{-2,12}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{102,-100}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-90,0},{90,0}},
                color={255,255,255},
                pattern=LinePattern.Dash),
              Text(
                extent={{-60,58},{68,-66}},
                lineColor={0,0,0},
                pattern=LinePattern.Dash,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                textString="VAV"),
              Text(
                extent={{-144,118},{156,158}},
                textString="%name",
                textColor={0,0,255})}),                                Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end VAVTerminal;

      package Control

        model ZonCon "Zone terminal VAV controller"
          parameter Real MinFlowRateSetPoi "Minimum flow rate ratio";
          parameter Real HeatingFlowRateSetPoi "constant flow rate ratio during heating mode";
          Buildings.Controls.Continuous.LimPID cooCon(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            k=0.1,
            Ti=60,
            yMin=MinFlowRateSetPoi,
            reverseActing=false)
                   annotation (Placement(transformation(extent={{-10,50},{10,70}})));
          Buildings.Controls.Continuous.LimPID heaCon(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            Ti=60,
            k=0.01,
            reverseActing=true)
                   annotation (Placement(transformation(extent={{50,-70},{70,
                    -50}})));
          Modelica.Blocks.Interfaces.RealInput T
            "Connector of measurement input signal"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealInput TCooSet
            "Connector of setpoint input signal" annotation (Placement(
                transformation(extent={{-140,40},{-100,80}})));
          Modelica.Blocks.Interfaces.RealInput THeaSet
            "Connector of setpoint input signal" annotation (Placement(
                transformation(extent={{-140,-80},{-100,-40}})));
          Modelica.Blocks.Interfaces.RealOutput yAirFlowSet
            "Connector of actuator output signal" annotation (Placement(
                transformation(extent={{100,-30},{120,-10}}),
                iconTransformation(extent={{100,-30},{120,-10}})));
          Modelica.Blocks.Interfaces.RealOutput yValPos
            "Connector of actuator output signal"
            annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
                iconTransformation(extent={{100,-70},{120,-50}})));
          Modelica.Blocks.Logical.Switch swi
            "Switch between external signal and direct feedthrough signal"
            annotation (Placement(transformation(extent={{50,10},{70,30}})));
          Modelica.Blocks.Sources.Constant const(k=HeatingFlowRateSetPoi)
            annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
          Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0, uHigh=0.5)
            annotation (Placement(transformation(extent={{-26,10},{-6,30}})));
          Modelica.Blocks.Math.Add add(k2=-1)
            annotation (Placement(transformation(extent={{-56,10},{-36,30}})));
          Modelica.Blocks.Interfaces.RealOutput yCoo
            "Connector of actuator output signal" annotation (Placement(
                transformation(extent={{100,70},{120,90}})));
          Modelica.Blocks.Interfaces.RealOutput yHea
            "Connector of actuator output signal" annotation (Placement(
                transformation(extent={{100,30},{120,50}})));
        equation
          connect(cooCon.y, swi.u1) annotation (Line(points={{11,60},{34,60},
                  {34,28},{48,28}},
                        color={0,0,127}));
          connect(const.y, swi.u3) annotation (Line(
              points={{21,-20},{34,-20},{34,12},{48,12}},
              color={0,0,127}));
          connect(add.y, hysteresis.u) annotation (Line(
              points={{-35,20},{-28,20}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          connect(hysteresis.y, swi.u2) annotation (Line(
              points={{-5,20},{48,20}},
              color={255,0,255}));
          connect(TCooSet, cooCon.u_s)
            annotation (Line(points={{-120,60},{-12,60}}, color={0,0,127}));
          connect(T, add.u1) annotation (Line(points={{-120,0},{-80,0},{-80,
                  26},{-58,26}}, color={0,0,127}));
          connect(T, cooCon.u_m) annotation (Line(points={{-120,0},{0,0},{0,
                  48}}, color={0,0,127}));
          connect(T, heaCon.u_m) annotation (Line(points={{-120,0},{-40,0},{
                  -40,-80},{60,-80},{60,-72}}, color={0,0,127}));
          connect(THeaSet, heaCon.u_s)
            annotation (Line(points={{-120,-60},{48,-60}}, color={0,0,127}));
          connect(THeaSet, add.u2) annotation (Line(points={{-120,-60},{-72,-60},
                  {-72,14},{-58,14}}, color={0,0,127}));
          connect(heaCon.y, yValPos)
            annotation (Line(points={{71,-60},{110,-60}}, color={0,0,127}));
          connect(swi.y, yAirFlowSet) annotation (Line(points={{71,20},{84,20},
                  {84,-20},{110,-20}}, color={0,0,127}));
          connect(cooCon.y, yCoo) annotation (Line(points={{11,60},{34,60},{
                  34,80},{110,80}}, color={0,0,127}));
          connect(heaCon.y, yHea) annotation (Line(points={{71,-60},{80,-60},
                  {80,40},{110,40}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                  Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-154,112},{146,152}},
                  textString="%name",
                  textColor={0,0,255})}),           Diagram(coordinateSystem(
                  preserveAspectRatio=false)),
            Documentation(info="<html>
<p>This is the zone terminal VAV controller. It takes the temperature measurements and cooling/heating setpoints as inputs. It takes the zone heating/cooling mode, discharge airflow setpoint, VAV damper position as the output.</p>
</html>",         revisions = "<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang:
<p> First implementation.</p>
</ul>
</html>"));
        end ZonCon;

      end Control;

      package Examples
        extends Modelica.Icons.ExamplesPackage;
        model FivZonVAVCO2
          extends Modelica.Icons.Example;
            //package MediumAir = Buildings.Media.Air "Medium model for air";
            package MediumAir = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Buildings library air media package with CO2";

            package MediumWat = Buildings.Media.Water "Medium model for water";

          parameter Modelica.Units.SI.Pressure PreAirDroMai1=140
            "Pressure drop 1 across the duct";

          parameter Modelica.Units.SI.Pressure PreAirDroMai2=140
            "Pressure drop 2 across the main duct";

          parameter Modelica.Units.SI.Pressure PreAirDroMai3=120
            "Pressure drop 3 across the main duct";

          parameter Modelica.Units.SI.Pressure PreAirDroMai4=152
            "Pressure drop 4 across the main duct";

          parameter Modelica.Units.SI.Pressure PreAirDroBra1=0
            "Pressure drop 1 across the duct branch 1";

          parameter Modelica.Units.SI.Pressure PreAirDroBra2=0
            "Pressure drop 1 across the duct branch 2";

          parameter Modelica.Units.SI.Pressure PreAirDroBra3=0
            "Pressure drop 1 across the duct branch 3";

          parameter Modelica.Units.SI.Pressure PreAirDroBra4=0
            "Pressure drop 1 across the duct branch 4";

          parameter Modelica.Units.SI.Pressure PreAirDroBra5=0
            "Pressure drop 1 across the duct branch 5";

          parameter Modelica.Units.SI.Pressure PreWatDroMai1=79712*0.2
            "Pressure drop 1 across the pipe";

          parameter Modelica.Units.SI.Pressure PreWatDroMai2=79712*0.2
            "Pressure drop 2 across the main pipe";

          parameter Modelica.Units.SI.Pressure PreWatDroMai3=79712*0.2
            "Pressure drop 3 across the main pipe";

          parameter Modelica.Units.SI.Pressure PreWatDroMai4=79712*0.2
            "Pressure drop 4 across the main pipe";

          parameter Modelica.Units.SI.Pressure PreWatDroBra1=0
            "Pressure drop 1 across the pipe branch 1";

          parameter Modelica.Units.SI.Pressure PreWatDroBra2=0
            "Pressure drop 1 across the pipe branch 2";

          parameter Modelica.Units.SI.Pressure PreWatDroBra3=0
            "Pressure drop 1 across the pipe branch 3";

          parameter Modelica.Units.SI.Pressure PreWatDroBra4=0
            "Pressure drop 1 across the pipe branch 4";

          parameter Modelica.Units.SI.Pressure PreWatDroBra5=0
            "Pressure drop 1 across the pipe branch 5";

          parameter Modelica.Units.SI.MassFlowRate mAirFloRat1=10.92*1.2
            "mass flow rate for vav 1";

          parameter Modelica.Units.SI.MassFlowRate mAirFloRat2=2.25*1.2
            "mass flow rate for vav 2";

          parameter Modelica.Units.SI.MassFlowRate mAirFloRat3=1.49*1.2
            "mass flow rate for vav 3";

          parameter Modelica.Units.SI.MassFlowRate mAirFloRat4=1.9*1.2
            "mass flow rate for vav 4";

          parameter Modelica.Units.SI.MassFlowRate mAirFloRat5=1.73*1.2
            "mass flow rate for vav 5";

          parameter Modelica.Units.SI.MassFlowRate mWatFloRat1=mAirFloRat1*0.3*(35 -
              12.88)/4.2/20 "mass flow rate for vav 1";

          parameter Modelica.Units.SI.MassFlowRate mWatFloRat2=mAirFloRat2*0.3*(35 -
              12.88)/4.2/20 "mass flow rate for vav 2";

          parameter Modelica.Units.SI.MassFlowRate mWatFloRat3=mAirFloRat3*0.3*(35 -
              12.88)/4.2/20 "mass flow rate for vav 3";

          parameter Modelica.Units.SI.MassFlowRate mWatFloRat4=mAirFloRat4*0.3*(35 -
              12.88)/4.2/20 "mass flow rate for vav 4";

          parameter Modelica.Units.SI.MassFlowRate mWatFloRat5=mAirFloRat5*0.3*(35 -
              12.88)/4.2/20 "mass flow rate for vav 5";

          parameter Modelica.Units.SI.Pressure PreDroAir1=200
            "Pressure drop in the air side of vav 1";
          parameter Modelica.Units.SI.Pressure PreDroWat1=79712
            "Pressure drop in the water side of vav 1";
          parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
            "Heat exchanger effectiveness of vav 1";

          parameter Modelica.Units.SI.Pressure PreDroAir2=124
            "Pressure drop in the air side of vav 2";
          parameter Modelica.Units.SI.Pressure PreDroWat2=79712
            "Pressure drop in the water side of vav 2";
          parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
            "Heat exchanger effectiveness of vav 2";

          parameter Modelica.Units.SI.Pressure PreDroAir3=124
            "Pressure drop in the air side of vav 3";
          parameter Modelica.Units.SI.Pressure PreDroWat3=79712
            "Pressure drop in the water side of vav 3";
          parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
            "Heat exchanger effectiveness of vav 1";

          parameter Modelica.Units.SI.Pressure PreDroAir4=124
            "Pressure drop in the air side of vav 4";
          parameter Modelica.Units.SI.Pressure PreDroWat4=79712
            "Pressure drop in the water side of vav 4";
          parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
            "Heat exchanger effectiveness of vav 1";

          parameter Modelica.Units.SI.Pressure PreDroAir5=124
            "Pressure drop in the air side of vav 1";
          parameter Modelica.Units.SI.Pressure PreDroWat5=79712
            "Pressure drop in the water side of vav 1";
          parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
            "Heat exchanger effectiveness of vav 1";

          // Initialization
          parameter MediumAir.AbsolutePressure p_start = MediumAir.p_default
            "Start value of zone air pressure"
            annotation(Dialog(tab = "Initialization"));
          parameter MediumAir.Temperature T_start=MediumAir.T_default
            "Start value of zone air temperature"
            annotation(Dialog(tab = "Initialization"));
          parameter MediumAir.MassFraction X_start[MediumAir.nX](
               quantity=MediumAir.substanceNames) = MediumAir.X_default
            "Start value of zone air mass fractions m_i/m"
            annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
          parameter MediumAir.ExtraProperty C_start[MediumAir.nC](
               quantity=MediumAir.extraPropertiesNames)=fill(0, MediumAir.nC)
            "Start value of zone air trace substances"
            annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
          parameter MediumAir.ExtraProperty C_nominal[MediumAir.nC](
               quantity=MediumAir.extraPropertiesNames) = fill(1E-2, MediumAir.nC)
            "Nominal value of zone air trace substances. (Set to typical order of magnitude.)"
           annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

          Buildings.Fluid.Sources.Boundary_pT souAir(
            p(displayUnit="Pa") = 100000 + PreAirDroMai1 + PreAirDroMai2 + PreAirDroMai3 + PreAirDroMai4 + PreAirDroBra5 + PreDroAir5,
            redeclare package Medium = MediumAir,
            nPorts=1,
            T=286.02) annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

          Buildings.Fluid.Sources.Boundary_pT sinAir(
            redeclare package Medium = MediumAir,
            p(displayUnit="Pa") = 100000,
            nPorts=1,
            T=299.15) annotation (Placement(transformation(extent={{-100,-26},{
                    -80,-6}})));

          Modelica.Blocks.Sources.Ramp Q_flow[5](duration=86400, height=1*1000*10)
            annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
          FiveZoneVAV                                                     fivZonVAV(
            redeclare package MediumAir = MediumAir,
            redeclare package MediumWat = MediumWat,
            p_start=p_start,
            T_start=T_start,
            X_start=X_start,
            C_start=C_start,
            C_nominal=C_nominal,
            PreAirDroMai1=PreAirDroMai1,
            PreAirDroMai2=PreAirDroMai2,
            PreAirDroMai3=PreAirDroMai3,
            PreAirDroMai4=PreAirDroMai4,
            PreAirDroBra1=PreAirDroBra1,
            PreAirDroBra2=PreAirDroBra2,
            PreAirDroBra3=PreAirDroBra3,
            PreAirDroBra4=PreAirDroBra4,
            PreAirDroBra5=PreAirDroBra5,
            PreWatDroMai1=PreWatDroMai1,
            PreWatDroMai2=PreWatDroMai2,
            PreWatDroMai3=PreWatDroMai3,
            PreWatDroMai4=PreWatDroMai4,
            PreWatDroBra1=PreWatDroBra1,
            PreWatDroBra2=PreWatDroBra2,
            PreWatDroBra3=PreWatDroBra3,
            PreWatDroBra4=PreWatDroBra4,
            PreWatDroBra5=PreWatDroBra5,
            mAirFloRat1=mAirFloRat1,
            mAirFloRat2=mAirFloRat2,
            mAirFloRat3=mAirFloRat3,
            mAirFloRat4=mAirFloRat4,
            mAirFloRat5=mAirFloRat5,
            mWatFloRat1=mWatFloRat1,
            mWatFloRat2=mWatFloRat2,
            mWatFloRat3=mWatFloRat3,
            mWatFloRat4=mWatFloRat4,
            mWatFloRat5=mWatFloRat5,
            PreDroAir1=PreDroAir1,
            PreDroWat1=PreDroWat1,
            eps1=eps1,
            PreDroAir2=PreDroAir2,
            PreDroWat2=PreDroWat2,
            eps2=eps2,
            PreDroAir3=PreDroAir3,
            PreDroWat3=PreDroWat3,
            eps3=eps3,
            PreDroAir4=PreDroAir4,
            PreDroWat4=PreDroWat4,
            eps4=eps4,
            PreDroAir5=PreDroAir5,
            PreDroWat5=PreDroWat5,
            eps5=eps5)
            annotation (Placement(transformation(extent={{-28,-28},{48,16}})));
          Buildings.Fluid.Sources.Boundary_pT souWat(
            p(displayUnit="Pa") = 100000 + PreWatDroMai1 + PreWatDroMai2 + PreWatDroMai3 + PreWatDroMai4 + PreWatDroBra5 + PreDroWat5,
            nPorts=1,
            redeclare package Medium = MediumWat,
            T=353.15) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
          Buildings.Fluid.Sources.Boundary_pT sinWat(
            p(displayUnit="Pa") = 100000,
            nPorts=1,
            redeclare package Medium = MediumWat,
            T=299.15) annotation (Placement(transformation(extent={{20,70},{0,90}})));
          Modelica.Blocks.Sources.BooleanExpression booleanExpression[5](y=true) annotation (Placement(transformation(extent={{-70,-14},
                    {-50,6}})));
          Modelica.Blocks.Sources.Ramp airFloRat[5](duration=86400, height=1)
            annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
          Modelica.Blocks.Sources.Ramp yVal[5](
            duration=86400,
            height=-1,
            offset=1)
            annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
          Modelica.Blocks.Sources.Constant nPeo[5](k=20)
            annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
                Modelica.Utilities.Files.loadResource(
                "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
              computeWetBulbTemperature=true)  "Weather data reader"
            annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
        equation

          connect(fivZonVAV.port_a_Air, souAir.ports[1]) annotation (Line(points={{-28,4},
                  {-38,4},{-38,50},{-80,50}},                                                                           color={0,127,255}));
          connect(fivZonVAV.port_b_Air, sinAir.ports[1]) annotation (Line(points={{-28,-16},
                  {-80,-16}},                                                                                                         color={0,127,255}));
          connect(souWat.ports[1], fivZonVAV.port_a_Wat) annotation (Line(points={{-40,80},
                  {-12.8,80},{-12.8,16}},                                                                                                  color={0,127,255}));
          connect(sinWat.ports[1], fivZonVAV.port_b_Wat) annotation (Line(points={{0,80},{
                  -4,80},{-4,28},{7.46667,28},{7.46667,16}},                                                                                     color={0,127,255}));
          connect(Q_flow.y, fivZonVAV.Q_flow) annotation (Line(points={{-79,-50},
                  {-48,-50},{-48,-18.8},{-30.5333,-18.8}},
                                              color={0,0,127}));
          connect(booleanExpression.y, fivZonVAV.On) annotation (Line(points={{-49,-4},
                  {-38,-4},{-38,-6.4},{-30.5333,-6.4}},                                                                 color={255,0,255}));
          connect(yVal.y, fivZonVAV.yVal) annotation (Line(points={{-79,22},{
                  -40,22},{-40,8},{-30.5333,8}},
                                   color={0,0,127}));
          connect(airFloRat.y, fivZonVAV.airFloRatSet) annotation (Line(points={{-79,80},
                  {-66,80},{-66,52},{-30.5333,52},{-30.5333,13.2}},
                                                     color={0,0,127}));
          connect(nPeo.y, fivZonVAV.nPeo) annotation (Line(points={{-79,-80},{
                  -42,-80},{-42,-23.2},{-30.5333,-23.2}},
                                         color={0,0,127}));
          connect(weaDat.weaBus, fivZonVAV.weaBus) annotation (Line(
              points={{-10,-50},{-2.66667,-50},{-2.66667,-28}},
              color={255,204,51},
              thickness=0.5));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
            experiment(StopTime=259200, __Dymola_Algorithm="Dassl"));
        end FivZonVAVCO2;
      end Examples;
    end ZoneTerminal;
  end AirSide;

  package FlowMover "\"Component used for modelling fans and pumps\""
    model VariableSpeedMover
      "The component contains both the variable speed fan/pump and the controller"
      import BuildingControlEmulator =
             MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component;
      extends BaseClasses.FlowMover(withoutMotor(varSpeFloMov(riseTime=240)));
      parameter Real k(min=0, unit="1") = 1 "Gain of controller";
      parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
        "Time constant of Integrator block";

      BuildingControlEmulator.conPI variableSpeed
        annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
      Modelica.Blocks.Interfaces.RealInput SetPoi
        "Connector of setpoint input signal"
        annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
      Modelica.Blocks.Interfaces.RealInput Mea
        "Connector of measurement input signal"
        annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
    equation
      connect(withoutMotor.port_a, temEnt.port_b) annotation (Line(
          points={{-18,0},{-60,0}},
          color={0,127,255},
          thickness=1));
      connect(temEnt.port_a, port_a) annotation (Line(
          points={{-80,0},{-100,0}},
          color={0,127,255},
          thickness=1));
      connect(withoutMotor.port_b, temLea.port_a) annotation (Line(
          points={{2,0},{30,0}},
          color={0,127,255},
          thickness=1));
      connect(temLea.port_b, masFloRat.port_a) annotation (Line(
          points={{50,0},{60,0}},
          color={0,127,255},
          thickness=1));
      connect(masFloRat.port_b, port_b) annotation (Line(
          points={{80,0},{100,0}},
          color={0,127,255},
          thickness=1));
      connect(preEnt.port, temEnt.port_b) annotation (Line(
          points={{-42,-20},{-42,0},{-60,0}},
          color={0,127,255},
          thickness=1));
      connect(preLea.port, temLea.port_a) annotation (Line(
          points={{20,-20},{20,0},{30,0}},
          color={0,127,255},
          thickness=1));
      connect(withoutMotor.P, P) annotation (Line(
          points={{3,6},{12,6},{20,6},{20,40},{110,40}},
          color={0,0,127}));
      connect(variableSpeed.y, withoutMotor.u) annotation (Line(
          points={{-39,54},{-30,54},{-30,6},{-19,6}},
          color={0,0,127}));
      connect(On, variableSpeed.On) annotation (Line(
          points={{-120,60},{-62,60}},
          color={255,0,255}));
      connect(variableSpeed.set, SetPoi) annotation (Line(
          points={{-62,54},{-78,54},{-78,20},{-120,20}},
          color={0,0,127}));
      connect(variableSpeed.mea, Mea) annotation (Line(
          points={{-62,48},{-66,48},{-66,16},{-56,16},{-56,-60},{-120,-60}},
          color={0,0,127}));
      annotation (Icon(graphics={
            Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
                  200}),
            Text(
              extent={{-30,24},{28,-28}},
              lineColor={28,108,200},
              textString="V")}));
    end VariableSpeedMover;

    model VAVSupFan
      "The AHU supply fan and the controller"
      extends BaseClasses.FlowMover;
      parameter Real k(min=0, unit="1") = 1 "Gain of controller";
      parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
        "Time constant of Integrator block";
      parameter Modelica.Units.SI.Time waitTime(min=0) = 0
        "Wait time before transition fires";
      parameter Real SpeRat
          "Speed ratio";
      parameter Integer numTemp(min=1) = 1
          "The size of the temeprature vector";
      Control.VAVDualFanControl varSpe(
        k=k,
        Ti=Ti,
        waitTime=waitTime)
        annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
      Modelica.Blocks.Interfaces.RealInput pSet
        "Connector of setpoint input signal"
        annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
      Modelica.Blocks.Interfaces.RealInput pMea
        "Connector of measurement input signal" annotation (Placement(
            transformation(extent={{-140,-120},{-100,-80}})));
      Modelica.Blocks.Interfaces.RealOutput yRet "Output signal connector"
        annotation (Placement(transformation(extent={{100,-92},{120,-72}})));
      Control.TemperatureCheck TChe(numTemp=numTemp)
        annotation (Placement(transformation(extent={{-92,-50},{-72,-30}})));
      Modelica.Blocks.Interfaces.RealInput T[numTemp]
        "Connector of setpoint input signal" annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealInput cooTSet[numTemp]
        "Connector of setpoint input signal"
        annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
      Modelica.Blocks.Interfaces.RealInput heaTSet[numTemp]
        "Connector of setpoint input signal"
        annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveSpeSupFan(
          description="AHU supply fan speed control signal", u(
          min=0,
          max=1,
          unit="1"))
        annotation (Placement(transformation(extent={{-26,44},{-6,64}})));
      Modelica.Blocks.Math.Gain gain(k=SpeRat)
        annotation (Placement(transformation(extent={{16,50},{24,58}})));
    equation
      connect(withoutMotor.port_a, temEnt.port_b) annotation (Line(
          points={{-18,0},{-60,0}},
          color={0,140,72},
          thickness=0.5));
      connect(temEnt.port_a, port_a) annotation (Line(
          points={{-80,0},{-100,0}},
          color={0,140,72},
          thickness=0.5));
      connect(withoutMotor.port_b, temLea.port_a) annotation (Line(
          points={{2,0},{30,0}},
          color={0,140,72},
          thickness=0.5));
      connect(temLea.port_b, masFloRat.port_a) annotation (Line(
          points={{50,0},{60,0}},
          color={0,140,72},
          thickness=0.5));
      connect(masFloRat.port_b, port_b) annotation (Line(
          points={{80,0},{100,0}},
          color={0,140,72},
          thickness=0.5));
      connect(preEnt.port, temEnt.port_b) annotation (Line(
          points={{-42,-20},{-42,0},{-60,0}},
          color={0,140,72},
          thickness=0.5));
      connect(preLea.port, temLea.port_a) annotation (Line(
          points={{20,-20},{20,0},{30,0}},
          color={0,140,72},
          thickness=0.5));
      connect(withoutMotor.P, P) annotation (Line(
          points={{3,6},{12,6},{20,6},{20,40},{110,40}},
          color={0,0,127}));
      connect(On, varSpe.On)
        annotation (Line(points={{-120,60},{-62,60}}, color={255,0,255}));
      connect(varSpe.SetPoi, pSet) annotation (Line(points={{-62,56},{-80,56},
              {-80,20},{-120,20}}, color={0,0,127}));
      connect(varSpe.Mea, pMea) annotation (Line(points={{-62,52},{-66,52},{-66,
              16},{-56,16},{-56,-100},{-120,-100}}, color={0,0,127}));
      connect(TChe.Temp, T) annotation (Line(points={{-94,-40},{-100,-40},{-100,
              -60},{-120,-60}}, color={0,0,127}));
      connect(TChe.On, varSpe.CyclingOn) annotation (Line(points={{-71,-40},{
              -68,-40},{-68,48},{-62,48}}, color={255,0,255}));
      connect(TChe.CooSetPoi, cooTSet) annotation (Line(points={{-94,-34},{-98,
              -34},{-98,-20},{-120,-20}}, color={0,0,127}));
      connect(TChe.HeaSetPoi, heaTSet) annotation (Line(points={{-94,-46},{-98,
              -46},{-98,-60},{-60,-60},{-60,34},{-88,34},{-88,100},{-120,100}},
            color={0,0,127}));
      connect(varSpe.ySup, oveSpeSupFan.u)
        annotation (Line(points={{-39,54},{-28,54}}, color={0,0,127}));
      connect(oveSpeSupFan.y, withoutMotor.u) annotation (Line(points={{-5,54},
              {2,54},{2,26},{-30,26},{-30,6},{-19,6}},     color={0,0,127}));
      connect(oveSpeSupFan.y, gain.u)
        annotation (Line(points={{-5,54},{15.2,54}}, color={0,0,127}));
      connect(gain.y, yRet) annotation (Line(points={{24.4,54},{32,54},{32,
              -82},{110,-82}}, color={0,0,127}));
      annotation (Icon(graphics={
            Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
                  200}),
            Text(
              extent={{-30,24},{28,-28}},
              lineColor={28,108,200},
              textString="V"),
            Text(
              extent={{-152,106},{148,146}},
              textString="%name",
              textColor={0,0,255})}));
    end VAVSupFan;

    package BaseClasses "\"Base classes for modelling fans or pumps\""
      partial model FlowMover
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the fluid";
        parameter Real HydEff[:] "Hydraulic efficiency";
        parameter Real MotEff[:] "Motor efficiency";
        parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]
          "Volume flow rate curve";
        parameter Modelica.Units.SI.Pressure PreCur[:] "Pressure curve";
        parameter Modelica.Units.SI.Time TimCon "Time constant for the fluid";
        WithoutMotor             withoutMotor(
          redeclare package Medium = Medium,
          HydEff=HydEff,
          MotEff=MotEff,
          VolFloCur=VolFloCur,
          PreCur=PreCur,
          TimCon=TimCon)
          annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temEnt(redeclare package
            Medium =
              Medium)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temLea(redeclare package
            Medium =
              Medium)
          annotation (Placement(transformation(extent={{30,-10},{50,10}})));
        Modelica.Fluid.Sensors.MassFlowRate masFloRat(redeclare package Medium =
              Medium)
          annotation (Placement(transformation(extent={{60,-10},{80,10}})));
        Modelica.Fluid.Sensors.Pressure preEnt(redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{-32,-20},{-52,-40}})));
        Modelica.Fluid.Sensors.Pressure preLea(redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{30,-20},{10,-40}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealOutput P "Electrical power consumed"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Modelica.Blocks.Interfaces.BooleanInput On "On-off signal" annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
        Modelica.Blocks.Interfaces.RealOutput Rat
          "Actual normalised pump speed that is used for computations"
          annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
      equation
        connect(withoutMotor.port_a, temEnt.port_b) annotation (Line(
            points={{-18,0},{-60,0}},
            color={0,127,255},
            thickness=1));
        connect(temEnt.port_a, port_a) annotation (Line(
            points={{-80,0},{-100,0}},
            color={0,127,255},
            thickness=1));
        connect(withoutMotor.port_b, temLea.port_a) annotation (Line(
            points={{2,0},{30,0}},
            color={0,127,255},
            thickness=1));
        connect(temLea.port_b, masFloRat.port_a) annotation (Line(
            points={{50,0},{60,0}},
            color={0,127,255},
            thickness=1));
        connect(masFloRat.port_b, port_b) annotation (Line(
            points={{80,0},{100,0}},
            color={0,127,255},
            thickness=1));
        connect(preEnt.port, temEnt.port_b) annotation (Line(
            points={{-42,-20},{-42,0},{-60,0}},
            color={0,127,255},
            thickness=1));
        connect(preLea.port, temLea.port_a) annotation (Line(
            points={{20,-20},{20,0},{30,0}},
            color={0,127,255},
            thickness=1));
        connect(withoutMotor.P, P) annotation (Line(
            points={{3,6},{12,6},{20,6},{20,40},{110,40}},
            color={0,0,127}));
        connect(withoutMotor.Rat, Rat) annotation (Line(
            points={{3,-6},{12,-6},{12,-60},{110,-60}},
            color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
                    200}),
              Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={28,108,200})}), Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end FlowMover;

      model WithoutMotor
        "Model for fans or pumps where motors are not explicitly modelled"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the fluid";
        parameter Real HydEff[:] "Hydraulic efficiency";
        parameter Real MotEff[:] "Motor efficiency";
        parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]
          "Volume flow rate curve";
        parameter Modelica.Units.SI.Pressure PreCur[:] "Pressure curve";
        parameter Modelica.Units.SI.Time TimCon "Time constant for the fluid";
        Buildings.Fluid.Movers.SpeedControlled_y varSpeFloMov(
          redeclare package Medium = Medium,
          per(
            pressure(V_flow=VolFloCur, dp=PreCur),
            hydraulicEfficiency(eta=HydEff, V_flow=VolFloCur),
            motorEfficiency(eta=MotEff, V_flow=VolFloCur)),
          tau=TimCon,
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
          use_inputFilter=false)
                      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));

        Modelica.Blocks.Interfaces.RealInput u "control signal"
          annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
        Modelica.Blocks.Interfaces.RealOutput P "Electrical power consumed"
          annotation (Placement(transformation(extent={{100,50},{120,70}})));
        Modelica.Blocks.Interfaces.RealOutput Rat
          "Actual normalised pump speed that is used for computations"
          annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
      equation
        connect(varSpeFloMov.port_a, port_a)
          annotation (Line(
            points={{-10,0},{-10,0},{-100,0}},
            color={0,140,72},
            thickness=0.5));
        connect(varSpeFloMov.port_b, port_b)
          annotation (Line(
            points={{10,0},{56,0},{100,0}},
            color={0,140,72},
            thickness=0.5));
        connect(varSpeFloMov.P, P) annotation (Line(
            points={{11,9},{40,9},{40,60},{110,60}},
            color={0,0,127}));
        connect(varSpeFloMov.y_actual, Rat) annotation (Line(
            points={{11,7},{40,7},{40,-60},{110,-60}},
            color={0,0,127}));
        connect(u,varSpeFloMov. y) annotation (Line(points={{-110,60},{0,60},
                {0,12}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Polygon(points={{-40,60},{-40,-60},{60,0},{-40,60}}, lineColor={28,108,
                    200}),
              Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={28,108,200}),
              Text(
                extent={{-30,24},{28,-28}},
                lineColor={28,108,200},
                textString="NoMotor"),
              Text(
                extent={{-150,108},{150,148}},
                textString="%name",
                textColor={0,0,255})}),                                Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end WithoutMotor;

    end BaseClasses;

    package Control
      model CyclingOn
        "\"Controller for constant speed fans or pumps\""
        parameter Modelica.Units.SI.Time waitTime(min=0) = 0
          "Wait time before transition fires";

        Modelica.StateGraph.StepWithSignal On(nOut=2, nIn=1)
                                              annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=-90,
              origin={56,-44})));
        Modelica.StateGraph.InitialStepWithSignal Off(nIn=2, nOut=1)
                                                      annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=-90,
              origin={54,42})));
        inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
          annotation (Placement(transformation(extent={{-80,72},{-60,92}})));
        Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer=true, waitTime=
             waitTime)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=-90,
              origin={0,-40})));
        Modelica.StateGraph.TransitionWithSignal transitionWithSignal1 annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={54,0})));
        Modelica.Blocks.Interfaces.BooleanInput CyclingOn
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Logical.Not not1
          annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
        Modelica.Blocks.Interfaces.BooleanOutput OnSigOut
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput OnSigIn
          annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
        Modelica.Blocks.Logical.And and1
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.StateGraph.TransitionWithSignal transitionWithSignal2(waitTime=
              waitTime, enableTimer=false)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=-90,
              origin={-22,48})));
        Modelica.Blocks.Logical.Not not2
          annotation (Placement(transformation(extent={{-60,38},{-40,58}})));
      equation
        connect(transitionWithSignal.inPort, On.outPort[1]) annotation (Line(
            points={{-6.66134e-016,-44},{-6.66134e-016,-80},{55.75,-80},{55.75,-54.5}},
            color={0,0,0},
            pattern=LinePattern.Dash));
        connect(transitionWithSignal.outPort, Off.inPort[1]) annotation (Line(
            points={{2.22045e-016,-38.5},{0,-38.5},{0,60},{53.5,60},{53.5,53}},
            color={0,0,0},
            pattern=LinePattern.Dash));

        connect(Off.outPort[1], transitionWithSignal1.inPort) annotation (Line(
            points={{54,31.5},{54,20},{54,4}},
            color={0,0,0},
            pattern=LinePattern.Dash));
        connect(transitionWithSignal1.outPort, On.inPort[1]) annotation (Line(
            points={{54,-1.5},{54,-12},{54,-33},{56,-33}},
            color={0,0,0},
            pattern=LinePattern.Dash));
        connect(not1.y, transitionWithSignal.condition) annotation (Line(
            points={{-39,-40},{-12,-40}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(not1.u, CyclingOn) annotation (Line(
            points={{-62,-40},{-96,-40},{-96,0},{-120,0}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(On.active, OnSigOut) annotation (Line(
            points={{67,-44},{67,-44},{80,-44},{80,0},{110,0}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(and1.u1, OnSigIn) annotation (Line(
            points={{-62,0},{-86,0},{-86,40},{-120,40}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(and1.u2, CyclingOn) annotation (Line(
            points={{-62,-8},{-90,-8},{-90,0},{-120,0}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(and1.y, transitionWithSignal1.condition) annotation (Line(
            points={{-39,0},{-39,0},{-8,0},{42,0}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(transitionWithSignal2.inPort, On.outPort[2]) annotation (Line(
            points={{-22,44},{-22,44},{-22,42},{-22,36},{-22,-96},{56.25,-96},{56.25,
                -54.5}},
            color={0,0,0},
            pattern=LinePattern.Dash));
        connect(transitionWithSignal2.outPort, Off.inPort[2]) annotation (Line(
            points={{-22,49.5},{-22,49.5},{-22,74},{54.5,74},{54.5,53}},
            color={0,0,0},
            pattern=LinePattern.Dash));
        connect(OnSigIn, not2.u) annotation (Line(
            points={{-120,40},{-86,40},{-86,48},{-62,48}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(not2.y, transitionWithSignal2.condition) annotation (Line(
            points={{-39,48},{-39,48},{-34,48}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-66,50},{62,-48}},
                lineColor={0,127,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                textString="CyclingControl"),
              Text(
                extent={{-154,102},{146,142}},
                textString="%name",
                textColor={0,0,255})}),        Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end CyclingOn;

      model VAVDualFanControl
        import BuildingControlEmulator =
               MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component;
        parameter Real k(min=0, unit="1") = 1 "Gain of controller";
        parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
          "Time constant of Integrator block";
        parameter Modelica.Units.SI.Time waitTime(min=0) = 0
          "Wait time before transition fires";

        BuildingControlEmulator.FlowMover.Control.CyclingOn cyclingOn(waitTime=
              waitTime)
          annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
        BuildingControlEmulator.conPI variableSpeed(
          yMin=0.3,
          k=k,
          Ti=Ti,
          conPID(y_reset=1))
          annotation (Placement(transformation(extent={{-60,36},{-40,56}})));
        Modelica.Blocks.Interfaces.BooleanInput On
          annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
        Modelica.Blocks.Interfaces.RealInput SetPoi
          "Connector of setpoint input signal"
          annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
        Modelica.Blocks.Interfaces.RealInput Mea
          "Connector of measurement input signal"
          annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
        Modelica.Blocks.Interfaces.RealOutput ySup "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput CyclingOn
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
        Modelica.Blocks.Logical.Not not1
          annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
        Buildings.Controls.OBC.CDL.Continuous.Switch swi
          annotation (Placement(transformation(extent={{12,28},{32,48}})));
        Buildings.Controls.OBC.CDL.Continuous.LimitSlewRate ramLim(raisingSlewRate=1/
              120) "Ramp limiter for fan control signal"
          annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        Buildings.Controls.OBC.CDL.Continuous.Limiter lim(uMax=1, uMin=0)
          annotation (Placement(transformation(extent={{66,-10},{86,10}})));
        Modelica.Blocks.Math.BooleanToReal booToRea
          annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      equation
        connect(variableSpeed.On, On) annotation (Line(
            points={{-62,52},{-80,52},{-80,60},{-120,60}},
            color={255,0,255}));
        connect(variableSpeed.mea, Mea) annotation (Line(
            points={{-62,40},{-70,40},{-70,-20},{-120,-20}},
            color={0,0,127}));
        connect(cyclingOn.CyclingOn, CyclingOn) annotation (Line(
            points={{-62,-30},{-80,-30},{-80,-60},{-120,-60}},
            color={255,0,255}));
        connect(not1.u, On) annotation (Line(
            points={{-64,10},{-80,10},{-80,60},{-120,60}},
            color={255,0,255}));
        connect(not1.y, cyclingOn.OnSigIn) annotation (Line(
            points={{-41,10},{-24,10},{-24,-8},{-80,-8},{-80,-26},{-62,-26}},
            color={255,0,255}));
        connect(variableSpeed.y, swi.u1)
          annotation (Line(points={{-39,46},{10,46}}, color={0,0,127}));
        connect(ramLim.y, lim.u)
          annotation (Line(points={{62,0},{64,0}},   color={0,0,127}));
        connect(lim.y, ySup) annotation (Line(points={{88,0},{110,0}},
              color={0,0,127}));
        connect(ramLim.u, swi.y) annotation (Line(points={{38,0},{36,0},{36,
                38},{34,38}}, color={0,0,127}));
        connect(SetPoi, variableSpeed.set) annotation (Line(points={{-120,20},
                {-74,20},{-74,46},{-62,46}}, color={0,0,127}));
        connect(On, swi.u2) annotation (Line(points={{-120,60},{-80,60},{-80,
                28},{-20,28},{-20,38},{10,38}}, color={255,0,255}));
        connect(cyclingOn.OnSigOut, booToRea.u)
          annotation (Line(points={{-39,-30},{-22,-30}}, color={255,0,255}));
        connect(booToRea.y, swi.u3) annotation (Line(points={{1,-30},{6,-30},{6,
                30},{10,30}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-66,50},{62,-48}},
                lineColor={0,127,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                textString="VAVDualFanControl"),
              Text(
                extent={{-154,102},{146,142}},
                textString="%name",
                textColor={0,0,255})}),            Diagram(coordinateSystem(
                preserveAspectRatio=false)),
          experiment(
            StartTime=15638400,
            StopTime=16243200,
            __Dymola_NumberOfIntervals=1440,
            __Dymola_Algorithm="Cvode"));
      end VAVDualFanControl;

      model TemperatureCheck "\"Controller for constant speed fans or pumps\""
        parameter Integer numTemp(min=1) = 1
            "The size of the temeprature vector";

        Modelica.Blocks.Interfaces.RealInput Temp[numTemp]
          "Connector of setpoint input signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput On
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.RealInput CooSetPoi[numTemp]
          "Connector of setpoint input signal"
          annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
        Modelica.Blocks.Interfaces.RealInput HeaSetPoi[numTemp]
          "Connector of setpoint input signal"
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
        parameter Modelica.Units.SI.TemperatureDifference dTCycCon = 0.2
          "Temperature difference for trigerring the cycle control";
      algorithm
       for i in 1:numTemp loop
          if (Temp[i] > CooSetPoi[i] + dTCycCon) or (Temp[i] < HeaSetPoi[i] - dTCycCon) then
             On := true;
             break;
           end if;
         On := false;
         end for;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-66,50},{62,-48}},
                lineColor={0,127,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                textString="CyclingControl"),
              Text(
                extent={{-156,106},{144,146}},
                textString="%name",
                textColor={0,0,255})}),        Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end TemperatureCheck;

    end Control;

    package Pump
      "This package contains the modules which can be used to simulate the primary chilled water pump, the condenser water pump and the secondary chilled water pump"

      model SimPumpSystem
        "This model is used to simulate the primary chilled water pump and condenser water pump system"
          replaceable package Medium =
               Modelica.Media.Interfaces.PartialMedium "Medium water";
        parameter Modelica.Units.SI.MassFlowRate m_flow_nominal[n]
          "Rated mass flow rate";

          parameter Integer n= 2
          "the number of pumps";
          parameter Real Motor_eta[n,:] "Motor efficiency";
          parameter Real Hydra_eta[n,:] "Hydraulic efficiency";
        parameter Modelica.Units.SI.PressureDifference dp_nominal
          "Nominal pressure raise";

        Buildings.Fluid.Movers.FlowControlled_m_flow
                                             pumConSpe[n](redeclare package
            Medium =                                                                 Medium,
          m_flow_nominal=m_flow_nominal,
          per(
            use_powerCharacteristic=false,
            motorEfficiency(eta=Motor_eta),
            hydraulicEfficiency(eta=Hydra_eta)),
          dp_nominal=dp_nominal)                                                           "Constant Speed pump"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput On[n] "On signal"    annotation (Placement(transformation(extent={{-118,51},
                  {-100,69}})));

        Modelica.Blocks.Interfaces.RealOutput P[n]
          "Electric power consumed by compressor"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Modelica.Blocks.Math.Gain gain[n](k=m_flow_nominal)
          annotation (Placement(transformation(extent={{-80,50},{-60,70}})));

      equation

        for i in 1:n loop
          connect(pumConSpe[i].port_a, port_a);
          connect(pumConSpe[i].port_b, port_b);
          connect(pumConSpe[i].P, P[i]);

        end for;

        connect(gain.u, On)
          annotation (Line(
            points={{-82,60},{-109,60}},
            color={0,0,127}));
        connect(gain.y, pumConSpe.m_flow_in) annotation (Line(points={{-59,60},{-28,60},{0,60},{0,12}}, color={0,0,127}));

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),                                                                               Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Text(
                extent={{-40,-102},{46,-156}},
                lineColor={0,0,255},
                textString="%name"),
              Ellipse(
                extent={{-20,80},{20,40}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{16,60},{-8,48},{-8,70},{16,60}},
                lineColor={0,0,255},
                smooth=Smooth.None,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-100,0},{-40,0},{-40,60}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-40,60},{-20,60}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-40,0},{-16,0}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-40,0},{-40,-60},{-16,-60}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{20,60},{40,60},{40,-60},{14,-60}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{40,0},{14,0}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{40,0},{90,0}},
                color={0,0,255},
                smooth=Smooth.None),
              Ellipse(
                extent={{-20,20},{20,-20}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-20,-40},{20,-80}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{16,0},{-8,-12},{-8,10},{16,0}},
                lineColor={0,0,255},
                smooth=Smooth.None,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{16,-60},{-8,-72},{-8,-50},{16,-60}},
                lineColor={0,0,255},
                smooth=Smooth.None,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid)}),
          Documentation(revisions="<html>
<ul>
<li>
March 30, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end SimPumpSystem;

      model PumpSystem "This model is used to simulate the secondary chilled water pump"
          replaceable package Medium =
            Modelica.Media.Interfaces.PartialMedium  "Medium water";
          parameter Integer n= 2
          "the number of pumps";

        parameter Modelica.Units.SI.MassFlowRate m_flow_nominal[n];
        parameter Real HydEff[n,:] "Hydraulic efficiency";
        parameter Real MotEff[n,:] "Motor efficiency";
        parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[n,:]
          "Volume flow rate curve";
        parameter Modelica.Units.SI.Pressure PreCur[n,:] "Pressure curve";
        MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor
          pum[n](
          varSpeFloMov(addPowerToMedium=false),
          redeclare package Medium = Medium,
          HydEff=HydEff,
          MotEff=MotEff,
          VolFloCur=VolFloCur,
          PreCur=PreCur,
          TimCon=900)
          annotation (Placement(transformation(extent={{-12,-10},{10,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput speSig[n] "On signal"
          annotation (Placement(transformation(extent={{-118,71},{-100,89}})));
        Modelica.Blocks.Interfaces.RealOutput speRat[n]
          "Speed of the pump divided by the nominal value"
          annotation (Placement(transformation(extent={{100,52},{120,72}})));
        Modelica.Blocks.Interfaces.RealOutput P[n]
          "Electric power consumed by compressor"
          annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
        Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val[n](redeclare
            package Medium = Medium,
            m_flow_nominal=m_flow_nominal,
          dpValve_nominal=dpValve_nominal)
          annotation (Placement(transformation(extent={{42,-10},{62,10}})));
        BaseClasses.ValCon valCon(n=n)
          annotation (Placement(transformation(extent={{-10,50},{10,70}})));
        parameter Modelica.Units.SI.PressureDifference dpValve_nominal[n]
          "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
      equation

        for i in 1:n loop
         connect(pum[i].Rat,speRat [i]);
         connect(pum[i].port_a, port_a);
         connect(val[i].port_b, port_b);
         connect(pum[i].P, P[i]);
           connect(pum[i].port_b, val[i].port_a);
        end for;

        connect(pum.u,speSig)  annotation (Line(
            points={{-13.1,6},{-80,6},{-80,80},{-109,80}},
            color={0,0,127}));
        connect(valCon.On,speSig)  annotation (Line(
            points={{-10.9,60},{-60,60},{-60,80},{-109,80}},
            color={0,0,127}));
        connect(valCon.y, val.y) annotation (Line(
            points={{10.9,60},{52,60},{52,12}},
            color={0,0,127}));
        annotation (Icon(graphics={
              Text(
                extent={{-152,104},{148,144}},
                textString="%name",
                textColor={0,0,255}),
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
      end PumpSystem;

      package Control

        model SecPumCon "This model is used for secondary chilled water pump control."
          parameter Real tWai = 300 "Waiting time";

            parameter Integer n=3
            "the number of pumps";
          WaterSide.Control.PumpStageN pumSta(
            tWai=tWai,
            thehol_up=0.9,
            n=n,
            thehol_down=0.6)
            annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
          Modelica.Blocks.Interfaces.BooleanInput On "On signal"
            annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
          Modelica.Blocks.Interfaces.RealInput sta[n] "Speeds of pumps"
            annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
          Modelica.Blocks.Interfaces.RealInput dpMea "Measured pressure drop"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Math.Product product[n]
            annotation (Placement(transformation(extent={{20,40},{40,60}})));
          Modelica.Blocks.Interfaces.RealOutput y[n] "Connector of Real output signal"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));

          Modelica.Blocks.Routing.Replicator replicator(nout=n)
            annotation (Placement(transformation(extent={{56,-40},{76,-20}})));
          MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
            conPI(k=0.001, Ti=60)
            annotation (Placement(transformation(extent={{18,-20},{38,0}})));
          Modelica.Blocks.Interfaces.RealInput dpSet
            "Static differential pressure setpoint for the secondary pump"
            annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
        equation
          connect(pumSta.On, On) annotation (Line(points={{-52,8},{-66,8},{-80,
                  8},{-80,80},{-120,80}}, color={255,0,255}));
          connect(pumSta.sta, sta) annotation (Line(points={{-52,-8},{-80,-8},{
                  -80,-80},{-120,-80}}, color={0,0,127}));
          connect(product.y, y) annotation (Line(
              points={{41,50},{60,50},{80,50},{80,0},{110,0}},
              color={0,0,127}));
          connect(pumSta.y, product.u1) annotation (Line(points={{-29,0},{0,0},
                  {0,56},{18,56}}, color={0,0,127}));
          connect(replicator.y, product.u2) annotation (Line(
              points={{77,-30},{90,-30},{90,-12},{58,-12},{58,24},{8,24},{8,44},{18,44}},
              color={0,0,127}));

          connect(conPI.On, On) annotation (Line(
              points={{16,-4},{-20,-4},{-20,80},{-120,80}},
              color={255,0,255}));
          connect(conPI.y, replicator.u) annotation (Line(
              points={{39,-10},{46,-10},{46,-30},{54,-30}},
              color={0,0,127}));
          connect(conPI.mea, dpMea) annotation (Line(points={{16,-16},{-92,-16},
                  {-92,0},{-120,0}}, color={0,0,127}));
          connect(conPI.set, dpSet) annotation (Line(points={{16,-10},{-20,-10},
                  {-20,-40},{-120,-40}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                  Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-156,104},{144,144}},
                  textString="%name",
                  textColor={0,0,255})}),           Diagram(coordinateSystem(
                  preserveAspectRatio=false)));
        end SecPumCon;

      end Control;

      package BaseClasses

        model ValCon
            parameter Integer n= 2
            "the number of pumps";

          Modelica.Blocks.Interfaces.RealInput On[n] "On signal"    annotation (Placement(transformation(extent={{-118,-9},
                    {-100,9}})));
          Modelica.Blocks.Interfaces.RealOutput y[n] "On signal"
            annotation (Placement(transformation(extent={{100,-9},{118,9}})));

        equation

            for i in 1:n loop
              y[i] =noEvent(if On[i]>0.01 then 1 else 0);
            end for;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                  Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-150,102},{150,142}},
                  textString="%name",
                  textColor={0,0,255})}),           Diagram(coordinateSystem(
                  preserveAspectRatio=false)));
        end ValCon;
      end BaseClasses;

    annotation ();
    end Pump;
  end FlowMover;

  package WaterSide "Basic modeld"

    package Boiler

      model MultiBoilers "The boiler system with N boilers and associated local controllers."
        replaceable package MediumHW =
           Modelica.Media.Interfaces.PartialMedium
          "Medium in the hot water side";
        parameter Modelica.Units.SI.Pressure dPHW_nominal
          "Pressure difference at the chilled water side";
        parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal[:]
          "Nominal mass flow rate at the chilled water side";
        parameter Modelica.Units.SI.Temperature THW_start
          "The start temperature of chilled water side";
        parameter Modelica.Units.SI.TemperatureDifference dTHW_nominal
          "Temperature difference between the outlet and inlet of the module";
        parameter Real eta[n,:] "Fan efficiency";
        Modelica.Blocks.Interfaces.RealInput On[n](min=0,max=1) "On signal"    annotation (Placement(transformation(extent={{-118,
                  -31},{-100,-49}})));
        Modelica.Blocks.Interfaces.RealInput THWSet
          "Temperature setpoint of the chilled water"
          annotation (Placement(transformation(extent={{-118,31},{-100,49}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_HW(redeclare package
            Medium =
              MediumHW)
          "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
              iconTransformation(extent={{90,-90},{110,-70}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_HW(redeclare package
            Medium =
              MediumHW)
          "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,70},{110,90}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTHWEntChi(
          allowFlowReversal=true,
          redeclare package Medium = MediumHW,
          m_flow_nominal=sum(mHW_flow_nominal)) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={50,80})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTHWLeaChi(
          allowFlowReversal=true,
          redeclare package Medium = MediumHW,
          m_flow_nominal=sum(mHW_flow_nominal),
          T_start=THW_start) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={52,-80})));
        Modelica.Blocks.Interfaces.RealOutput Rat[n] "compressor speed ratio"
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Boiler boi[n](
          redeclare package MediumHW = MediumHW,
          dPHW_nominal=dPHW_nominal,
          mHW_flow_nominal=mHW_flow_nominal,
          dTHW_nominal=dTHW_nominal,
          eta=eta,
          each boi(T_nominal(displayUnit="K")),
          THW=THW_start,
          GaiPi=1,
          tIntPi=60)
          annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
        parameter Integer n
          "Number of boilers";

      equation
        connect(senTHWEntChi.port_a, port_a_HW) annotation (Line(
            points={{60,80},{100,80}},
            color={255,0,0},
            thickness=1));
        connect(senTHWLeaChi.port_b, port_b_HW) annotation (Line(
            points={{62,-80},{100,-80}},
            color={255,0,0},
            thickness=1));
        connect(port_b_HW, port_b_HW) annotation (Line(
            points={{100,-80},{100,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        for i in 1:n loop
          connect(boi[i].port_a_HW, senTHWEntChi.port_b);
          connect(boi[i].port_b_CHW, senTHWLeaChi.port_a);
          connect(boi[i].THWSet, THWSet);
          connect(boi[i].On, On[i]);
        end for;
        connect(On, Rat) annotation (Line(points={{-109,-40},{110,-40}},           color={0,0,127}));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-28,80},{26,40}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-28,-40},{26,-80}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(
                points={{40,-80},{102,-80}},
                color={255,0,0}),
              Line(
                points={{40,-80},{40,50},{26,50}},
                color={255,0,0}),
              Line(
                points={{26,-70},{40,-70}},
                color={255,0,0}),
              Line(
                points={{26,-48},{60,-48},{60,80}},
                color={255,0,0}),
              Line(
                points={{100,80},{60,80}},
                color={255,0,0}),
              Line(
                points={{26,72},{60,72}},
                color={255,0,0}),
              Ellipse(
                extent={{20,56},{30,44}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{22,54},{28,46}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,-64},{30,-76}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{22,-66},{28,-74}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,78},{30,66}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,-44},{30,-56}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-154,104},{146,144}},
                textString="%name",
                textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
      end MultiBoilers;

      model Boiler "Boiler"
        replaceable package MediumHW =
           Modelica.Media.Interfaces.PartialMedium
          "Medium in the hot water side";
        parameter Modelica.Units.SI.Pressure dPHW_nominal
          "Pressure difference at the chilled water side";
        parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal
          "Nominal mass flow rate at the chilled water side";
        parameter Modelica.Units.SI.Temperature THW
          "The start temperature of chilled water side";
        parameter Modelica.Units.SI.TemperatureDifference dTHW_nominal
          "Temperature difference between the outlet and inlet of the module";
        parameter Real GaiPi "Gain of the component PI controller";
        parameter Real tIntPi "Integration time of the component PI controller";
        parameter Real eta[:] "Fan efficiency";

        BaseClasses.BoilerPolynomial boi(
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
          redeclare package Medium = MediumHW,
          m_flow_nominal=mHW_flow_nominal,
          T_nominal=THW,
          effCur=Buildings.Fluid.Types.EfficiencyCurves.Polynomial,
          Q_flow_nominal=dTHW_nominal*mHW_flow_nominal*4200,
          a=eta,
          fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
          dp_nominal=0) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={0,-38})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package
            Medium =
              MediumHW)
          "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_HW(redeclare package
            Medium =
              MediumHW)
          "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,70},{110,90}}),
              iconTransformation(extent={{90,70},{110,90}})));
        replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTHWLea(
          redeclare package Medium = MediumHW,
          m_flow_nominal=mHW_flow_nominal,
          T_start=THW) annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear valCHW(
          redeclare package Medium = MediumHW,
          m_flow_nominal=mHW_flow_nominal,
          dpValve_nominal=dPHW_nominal)
          annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
        Modelica.Blocks.Interfaces.RealInput On(min=0,max=1)
          "True to enable compressor to operate, or false to disable the operation of the compressor"
          annotation (Placement(transformation(extent={{-118,-50},{-100,-30}}),
              iconTransformation(extent={{-140,-70},{-100,-30}})));
        Modelica.Blocks.Interfaces.RealInput THWSet
          "Temperature setpoint of chilled water" annotation (Placement(
              transformation(extent={{-118,30},{-100,50}}), iconTransformation(extent=
                 {{-140,10},{-100,50}})));

        Buildings.Fluid.Sensors.TemperatureTwoPort senTHWEnt(
          allowFlowReversal=true,
          redeclare package Medium = MediumHW,
          m_flow_nominal=mHW_flow_nominal) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={30,0})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloHW(redeclare package
            Medium =
              MediumHW)
          annotation (Placement(transformation(extent={{72,-10},{54,10}})));
        Buildings.Fluid.Sensors.Pressure senPreCWEnt(redeclare package Medium =
              MediumHW)
          annotation (Placement(transformation(extent={{2,10},{22,30}})));
        Buildings.Fluid.Sensors.Pressure senPreHWLea(redeclare package Medium =
              MediumHW)
          annotation (Placement(transformation(extent={{78,-50},{98,-30}})));
        Modelica.Blocks.Math.RealToBoolean realToBoolean
          annotation (Placement(transformation(extent={{-70,-18},{-54,-2}})));
        .MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
          conPI(Ti=2400, k=1)
          annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=boi.T)
          annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
      equation
        connect(senTHWLea.port_b, valCHW.port_a)
          annotation (Line(
            points={{40,-80},{60,-80}},
            color={255,0,0},
            thickness=1));
        connect(valCHW.port_b, port_b_CHW) annotation (Line(
            points={{80,-80},{100,-80}},
            color={255,0,0},
            thickness=1));
        connect(senPreHWLea.port, port_b_CHW) annotation (Line(
            points={{88,-50},{88,-50},{88,-80},{100,-80}},
            color={255,0,0},
            thickness=1));
        connect(senMasFloHW.port_b, senTHWEnt.port_a) annotation (Line(
            points={{54,0},{47,0},{40,0}},
            color={255,0,0},
            thickness=1));
        connect(senMasFloHW.port_a, port_a_HW) annotation (Line(
            points={{72,0},{80,0},{80,80},{100,80}},
            color={255,0,0},
            thickness=1));
        connect(senTHWEnt.port_b, boi.port_a) annotation (Line(
            points={{20,0},{0,0},{0,-28}},
            color={255,0,0},
            thickness=1));
        connect(boi.port_b, senTHWLea.port_a)
          annotation (Line(
            points={{0,-48},{0,-80},{20,-80}},
            color={255,0,0},
            thickness=1));
        connect(senPreCWEnt.port, boi.port_a) annotation (Line(
            points={{12,10},{12,0},{0,0},{0,-28},{6.10623e-016,-28}},
            color={255,0,0},
            thickness=1));
        connect(On, valCHW.y) annotation (Line(
            points={{-109,-40},{-44,-40},{-44,-24},{70,-24},{70,-68}},
            color={0,0,127}));

        connect(realToBoolean.u, valCHW.y) annotation (Line(
            points={{-71.6,-10},{-80,-10},{-80,-40},{-44,-40},{-44,-24},{70,-24},{70,-68}},
            color={0,0,127}));
        connect(realToBoolean.y, conPI.On) annotation (Line(
            points={{-53.2,-10},{-40,-10},{-40,10},{-80,10},{-80,46},{-66,46}},
            color={255,0,255}));
        connect(conPI.set, THWSet)
          annotation (Line(points={{-66,40},{-109,40}}, color={0,0,127}));
        connect(conPI.y, boi.y)
          annotation (Line(
            points={{-43,40},{-8,40},{-8,-26}},
            color={0,0,127}));
        connect(realExpression.y,conPI.mea)  annotation (Line(
            points={{-49,-30},{-30,-30},{-30,22},{-76,22},{-76,34},{-66,34}},
            color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Text(
                extent={{-44,-144},{50,-112}},
                lineColor={0,0,255},
                textString="%name"),
              Rectangle(
                extent={{-54,50},{60,32}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-52,-50},{62,-68}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,72},{100,82}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-32,-10},{-42,-22},{-22,-22},{-32,-10}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-32,-10},{-42,0},{-22,0},{-32,-10}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-34,32},{-30,0}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-34,-22},{-30,-50}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{34,32},{38,-50}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{14,10},{58,-32}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{36,10},{18,-22},{54,-22},{36,10}},
                lineColor={255,170,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,-86},{100,-76}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-152,106},{148,146}},
                textString="%name",
                textColor={0,0,255})}),
          Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end Boiler;

      package BaseClasses

        model BoilerPolynomial
          "Boiler with efficiency curve described by a polynomial of the temperature"
          extends Buildings.Fluid.Interfaces.TwoPortHeatMassExchanger(
            redeclare final Buildings.Fluid.MixingVolumes.MixingVolume vol,
            show_T=true,
            final tau=VWat*rho_default/m_flow_nominal);

          parameter Modelica.Units.SI.Power Q_flow_nominal "Nominal heating power";
          parameter Modelica.Units.SI.Temperature T_nominal=353.15
            "Temperature used to compute nominal efficiency (only used if efficiency curve depends on temperature)";
          // Assumptions
          parameter Buildings.Fluid.Types.EfficiencyCurves effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant
            "Curve used to compute the efficiency";
          parameter Real a[:] = {0.9} "Coefficients for efficiency curve";

          parameter Buildings.Fluid.Data.Fuels.Generic fue "Fuel type"
           annotation (choicesAllMatching = true);
          parameter Modelica.Units.SI.Efficiency eps(max=1) = 1
            "Heat exchanger effectiveness";
          parameter Modelica.Units.SI.ThermalConductance UA=0.05*Q_flow_nominal/30
            "Overall UA value";
          parameter Modelica.Units.SI.Volume VWat=1.5E-6*Q_flow_nominal
            "Water volume of boiler" annotation (Dialog(tab="Dynamics", enable=not (
                  energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));
          parameter Modelica.Units.SI.Mass mDry=1.5E-3*Q_flow_nominal
            "Mass of boiler that will be lumped to water heat capacity" annotation (
              Dialog(tab="Dynamics", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));

          Modelica.Units.SI.Efficiency eta=if effCur == Buildings.Fluid.Types.EfficiencyCurves.Constant
               then a[1] elseif effCur == Buildings.Fluid.Types.EfficiencyCurves.Polynomial
               then Buildings.Utilities.Math.Functions.polynomial(a=a, x=y) elseif
              effCur == Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear then
              Buildings.Utilities.Math.Functions.quadraticLinear(
              a=aQuaLin,
              x1=y,
              x2=T) else 0 "Boiler efficiency";
          Modelica.Units.SI.Power QFue_flow=y*Q_flow_nominal/eta_nominal
            "Heat released by fuel";
          Modelica.Units.SI.Power QWat_flow=eta*QFue_flow*eps
            "Heat transfer from gas into water";
          Modelica.Units.SI.MassFlowRate mFue_flow=QFue_flow/fue.h
            "Fuel mass flow rate";
          Modelica.Units.SI.VolumeFlowRate VFue_flow=mFue_flow/fue.d
            "Fuel volume flow rate";

          Modelica.Blocks.Interfaces.RealInput y(min=0, max=1) "Part load ratio"
            annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

          Modelica.Blocks.Interfaces.RealOutput T(final quantity="ThermodynamicTemperature",
                                                  final unit = "K", displayUnit = "degC", min=0)
            annotation (Placement(transformation(extent={{100,70},{120,90}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
            "Heat port, can be used to connect to ambient"
            annotation (Placement(transformation(extent={{-10,62}, {10,82}})));
          Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCapDry(
            C=500*mDry,
            T(start=T_start)) if not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
            "heat capacity of boiler metal"
            annotation (Placement(transformation(extent={{-80,12},{-60,32}})));

        protected
          parameter Real eta_nominal(fixed=false) "Boiler efficiency at nominal condition";
          parameter Real aQuaLin[6] = if size(a, 1) == 6 then a else fill(0, 6)
          "Auxiliary variable for efficiency curve because quadraticLinear requires exactly 6 elements";

          Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
            annotation (Placement(transformation(extent={{-43,-40},{-23,-20}})));
          Modelica.Blocks.Sources.RealExpression Q_flow_in(y=QWat_flow)
            annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSen
            "Temperature of fluid"
            annotation (Placement(transformation(extent={{0,30},{20,50}})));

          Modelica.Thermal.HeatTransfer.Components.ThermalConductor UAOve(G=UA)
            "Overall thermal conductance (if heatPort is connected)"
            annotation (Placement(transformation(extent={{-48,10},{-28,30}})));

        initial equation
          if  effCur == Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear then
            assert(size(a, 1) == 6,
            "The boiler has the efficiency curve set to 'Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear',
    and hence the parameter 'a' must have exactly 6 elements.
    However, only "         + String(size(a, 1)) + " elements were provided.");
          end if;

          if effCur ==Buildings.Fluid.Types.EfficiencyCurves.Constant then
            eta_nominal = a[1];
          elseif effCur ==Buildings.Fluid.Types.EfficiencyCurves.Polynomial then
            eta_nominal = Buildings.Utilities.Math.Functions.polynomial(
                                                                  a=a, x=1);
          elseif effCur ==Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear then
            // For this efficiency curve, a must have 6 elements.
            eta_nominal = Buildings.Utilities.Math.Functions.quadraticLinear(
                                                                       a=aQuaLin, x1=1, x2=T_nominal);
          else
             eta_nominal = 999;
          end if;

        equation

          assert(eta > 0.001, "Efficiency curve is wrong.");

          connect(UAOve.port_b, vol.heatPort)            annotation (Line(
              points={{-28,20},{-22,20},{-22,-10},{-9,-10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UAOve.port_a, heatPort) annotation (Line(
              points={{-48,20},{-52,20},{-52,60},{0,60},{0,72}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(heaCapDry.port, vol.heatPort) annotation (Line(
              points={{-70,12},{-70,-10},{-9,-10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(temSen.T, T) annotation (Line(
              points={{21,40},{60,40},{60,80},{110,80}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(preHeaFlo.port, vol.heatPort) annotation (Line(
              points={{-23,-30},{-15,-30},{-15,-10},{-9,-10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Q_flow_in.y,preHeaFlo. Q_flow) annotation (Line(
              points={{-59,-30},{-43,-30}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(vol.heatPort, temSen.port) annotation (Line(
              points={{-9,-10},{-16,-10},{-16,40},{0,40}},
              color={191,0,0},
              smooth=Smooth.None));
          annotation ( Icon(graphics={
                Polygon(
                  points={{0,-34},{-12,-52},{14,-52},{0,-34}},
                  pattern=LinePattern.None,
                  smooth=Smooth.None,
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Line(
                  points={{-100,80},{-80,80},{-80,-44},{-6,-44}},
                  smooth=Smooth.None),
                Line(
                  points={{100,80},{80,80},{80,4}},
                  color={0,0,127},
                  smooth=Smooth.None),
                Text(
                  extent={{160,144},{40,94}},
                  lineColor={0,0,0},
                  textString=DynamicSelect("T", String(T-273.15, format=".1f"))),
                Text(
                  extent={{-38,146},{-158,96}},
                  lineColor={0,0,0},
                  textString=DynamicSelect("y", String(y, format=".2f")))}),
        defaultComponentName="boi",
        Documentation(info="<html>
<p>
This is a model of a boiler whose efficiency is described
by a polynomial.
The heat input into the medium is</p>
<p align=\"center\" style=\"font-style:italic;\">
  Q&#775; = y Q&#775;<sub>0</sub> &eta; &frasl; &eta;<sub>0</sub>
</p>
<p>
where
<i>y &isin; [0, 1]</i> is the control signal,
<i>Q&#775;<sub>0</sub></i> is the nominal power,
<i>&eta;</i> is the efficiency at the current operating point, and
<i>&eta;<sub>0</sub></i> is the efficiency at <i>y=1</i> and
nominal temperature <i>T=T<sub>0</sub></i> as specified by the parameter
<code>T_nominal</code>.
</p>
<p>
The parameter <code>effCur</code> determines what polynomial is used
to compute the efficiency, which is defined as
</p>
<p align=\"center\" style=\"font-style:italic;\">
  &eta; = Q&#775; &frasl; Q&#775;<sub>f</sub>,
</p>
<p>
where
<i>Q&#775;</i> is the heat transferred to the working fluid (typically water or air), and
<i>Q&#775;<sub>f</sub></i> is the heat of combustion released by the fuel.
</p>
<p>
The following polynomials can be selected to compute the efficiency:
</p>
<table summary=\"summary\"  border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Parameter <code>effCur</code></th>
<th>Efficiency curve</th>
</tr>
<tr>
<td>Buildings.Fluid.Types.EfficiencyCurves.Constant</td>
<td><i>&eta; = a<sub>1</sub></i></td>
</tr>
<tr>
<td>Buildings.Fluid.Types.EfficiencyCurves.Polynomial</td>
<td><i>&eta; = a<sub>1</sub> + a<sub>2</sub> y + a<sub>3</sub> y<sup>2</sup> + ...</i></td>
</tr>
<tr>
<td>Buildings.Fluid.Types.EfficiencyCurves.QuadraticLinear</td>
<td><i>&eta; = a<sub>1</sub> + a<sub>2</sub>  y
        + a<sub>3</sub> y<sup>2</sup>
        + (a<sub>4</sub> + a<sub>5</sub>  y
        + a<sub>6</sub> y<sup>2</sup>)  T
</i></td>
</tr>
</table>

<p>
where <i>T</i> is the boiler outlet temperature in Kelvin.
For <code>effCur = Buildings.Fluid.Types.EfficiencyCurves.Polynomial</code>,
an arbitrary number of polynomial coefficients can be specified.
</p>
<p>
The parameter <code>Q_flow_nominal</code> is the power transferred to the fluid
for <code>y=1</code> and, if the efficiency depends on temperature,
for <code>T=T0</code>.
</p>
<p>
The fuel mass flow rate and volume flow rate are computed as </p>
<p align=\"center\" style=\"font-style:italic;\">
  m&#775;<sub>f</sub> = Q&#775;<sub>f</sub> &frasl; h<sub>f</sub>
</p>
<p> and </p>
<p align=\"center\" style=\"font-style:italic;\">
  V&#775;<sub>f</sub> = m&#775;<sub>f</sub> &frasl; &rho;<sub>f</sub>,
</p>
<p>
where the fuel heating value
<i>h<sub>f</sub></i> and the fuel mass density
<i>&rho;<sub>f</sub></i> are obtained from the
parameter <code>fue</code>.
Note that if <i>&eta;</i> is the efficiency relative to the lower heating value,
then the fuel properties also need to be used for the lower heating value.
</p>

<p>
Optionally, the port <code>heatPort</code> can be connected to a heat port
outside of this model to impose a boundary condition in order to
model heat losses to the ambient. When using this <code>heatPort</code>,
make sure that the efficiency curve <code>effCur</code>
does not already account for this heat loss.
</p>

<p>
On the Assumptions tag, the model can be parameterized to compute a transient
or steady-state response.
The transient response of the boiler is computed using a first
order differential equation to compute the boiler's water and metal temperature,
which are lumped into one state. The boiler outlet temperature is equal to this water temperature.
</p>

</html>",         revisions="<html>
<ul>
<li>
May 27, 2016, by Michael Wetter:<br/>
Corrected size of input argument to
<code>Buildings.Utilities.Math.Functions.quadraticLinear</code>
for JModelica compliance check.
</li>
<li>
May 30, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
October 9, 2013 by Michael Wetter:<br/>
Removed conditional declaration of <code>mDry</code> as the use of a conditional
parameter in an instance declaration is not correct Modelica syntax.
</li>
<li>
December 14, 2012 by Michael Wetter:<br/>
Renamed protected parameters for consistency with the naming conventions.
</li>
<li>
December 22, 2011 by Michael Wetter:<br/>
Added computation of fuel usage and improved the documentation.
</li>
<li>
May 25, 2011 by Michael Wetter:<br/>
<ul>
<li>
Removed parameter <code>dT_nominal</code>, and require instead
the parameter <code>m_flow_nominal</code> to be set by the user.
This was needed to avoid a non-literal value for the nominal attribute
of the pressure drop model.
</li>
<li>
Changed assignment of parameters in model instantiation, and updated
model for the new base class that does not have a temperature sensor.
</li>
</ul>
</li>
<li>
January 29, 2009 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
        end BoilerPolynomial;
      end BaseClasses;
    end Boiler;

    package Chiller
      "This package contains the modules which can be used to simulate the chillers"

      model MultiChillers
        "The chiller system with N chillers and associated local controllers "
        replaceable package MediumCHW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium in the chilled water side";
        replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium in the condenser water side";
        parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per[n]
          "Performance data" annotation (choicesAllMatching=true, Placement(
              transformation(extent={{-10,70},{10,90}})));
        parameter Modelica.Units.SI.Pressure dPCHW_nominal
          "Pressure difference at the chilled water side";
        parameter Modelica.Units.SI.Pressure dPCW_nominal
          "Pressure difference at the condenser water wide";
        parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal[:]
          "Nominal mass flow rate at the chilled water side";
        parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]
          "Nominal mass flow rate at the condenser water wide";
        parameter Modelica.Units.SI.Temperature TCW_start
          "The start temperature of condenser water side";
        parameter Modelica.Units.SI.Temperature TCHW_start
          "The start temperature of chilled water side";

        parameter Integer n
          "the number of chillers";
        Modelica.Blocks.Interfaces.RealInput On[n](min=0,max=1) "On signal"    annotation (Placement(transformation(extent={{-118,
                  -31},{-100,-49}})));
        Modelica.Blocks.Interfaces.RealInput TCHWSet
          "Temperature setpoint of the chilled water"
          annotation (Placement(transformation(extent={{-118,31},{-100,49}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package
            Medium =                                                               MediumCW)
          "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
          annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package
            Medium =                                                               MediumCW)
          "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
          annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package
            Medium =                                                                MediumCHW)
          "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
              iconTransformation(extent={{90,-90},{110,-70}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_CHW(redeclare package
            Medium =                                                                MediumCHW)
          "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,70},{110,90}})));
        Modelica.Blocks.Interfaces.RealOutput P[n]
          "Electric power consumed by compressor"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWEntChi(
          redeclare package Medium = MediumCHW,
          allowFlowReversal=true,
          m_flow_nominal=sum(mCHW_flow_nominal))
                                              annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={50,80})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTCWLeaChi(
          allowFlowReversal=true,
          redeclare package Medium = MediumCW,
          m_flow_nominal=sum(mCW_flow_nominal))
                                             annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={-82,80})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWLeaChi(
          allowFlowReversal=true,
          redeclare package Medium = MediumCHW,
          T_start=TCHW_start,
          m_flow_nominal=sum(mCHW_flow_nominal))
                                              annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={52,-80})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEntChi(
          allowFlowReversal=true,
          redeclare package Medium = MediumCW,
          T_start=TCW_start,
          m_flow_nominal=sum(mCW_flow_nominal))
                                             annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-70,-80})));
        replaceable ChillerTSet ch[n](
          redeclare package MediumCHW = MediumCHW,
          redeclare package MediumCW = MediumCW,
          dPCHW_nominal=dPCHW_nominal,
          dPCW_nominal=dPCW_nominal,
          mCHW_flow_nominal=mCHW_flow_nominal,
          mCW_flow_nominal=mCW_flow_nominal,
          TCW_start=TCW_start,
          TCHW_start=TCHW_start,
          per=per) constrainedby ChillerTSet(
          redeclare package MediumCHW = MediumCHW,
          redeclare package MediumCW = MediumCW,
          dPCHW_nominal=dPCHW_nominal,
          dPCW_nominal=dPCW_nominal,
          mCHW_flow_nominal=mCHW_flow_nominal,
          mCW_flow_nominal=mCW_flow_nominal,
          TCW_start=TCW_start,
          TCHW_start=TCHW_start,
          per=per)
          annotation (Placement(transformation(extent={{-10,-8},{10,12}})));

        Modelica.Blocks.Interfaces.RealOutput Rat[n] "compressor speed ratio"
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloCHW(redeclare package
            Medium =
              MediumCHW)
          annotation (Placement(transformation(extent={{70,-90},{88,-70}})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloCW(redeclare package
            Medium =
              MediumCHW)
          annotation (Placement(transformation(extent={{-46,70},{-64,90}})));
      equation
        connect(port_b_CW, port_b_CW) annotation (Line(
            points={{-100,80},{-100,80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(port_a_CW, port_a_CW) annotation (Line(
            points={{-100,-80},{-100,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(senTCHWEntChi.port_a, port_a_CHW) annotation (Line(
            points={{60,80},{100,80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(port_b_CW, senTCWLeaChi.port_b) annotation (Line(
            points={{-100,80},{-92,80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(senTCWEntChi.port_a, port_a_CW) annotation (Line(
            points={{-80,-80},{-100,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(port_b_CHW, port_b_CHW) annotation (Line(
            points={{100,-80},{98,-80},{98,-80},{100,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(senTCWLeaChi.port_a, senMasFloCW.port_b) annotation (Line(
            points={{-72,80},{-64,80}},
            color={0,127,255},
            thickness=1));
        connect(senMasFloCHW.port_b, port_b_CHW) annotation (Line(
            points={{88,-80},{94,-80},{100,-80}},
            color={0,127,255},
            thickness=1));
        connect(senTCHWLeaChi.port_b, senMasFloCHW.port_a) annotation (Line(
            points={{62,-80},{66,-80},{70,-80}},
            color={0,127,255},
            thickness=1));
        connect(ch.On, On) annotation (Line(
            points={{-12,-3},{-60,-3},{-60,-40},{-109,-40}},
            color={0,0,127}));
        connect(On, Rat) annotation (Line(
            points={{-109,-40},{110,-40}},
            color={0,0,127}));

        for i in 1:n loop
              connect(ch[i].TCHWSet, TCHWSet);
              connect(ch[i].port_a_CW, senTCWEntChi.port_b);
              connect(ch[i].port_b_CHW, senTCHWLeaChi.port_a);
              connect(ch[i].port_b_CW, senMasFloCW.port_a);
              connect(ch[i].port_a_CHW, senTCHWEntChi.port_b);
              connect(ch[i].P, P[i]);
        end for;

        annotation (Documentation(info="<html>
<p>This model is to simulate the chiller system which consists of three chillers and associated local controllers.</p>
</html>",       revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"),       Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}})),
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),                                                                   graphics={
              Text(
                extent={{-44,-142},{50,-110}},
                lineColor={0,0,255},
                textString="%name"),
              Rectangle(
                extent={{-28,80},{26,40}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-28,20},{26,-20}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-28,-40},{26,-80}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-60,12},{-28,12}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-28,-50},{-60,-50},{-60,80}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-90,-80},{-40,-80},{-40,50},{-34,50},{-28,50}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-28,-10},{-40,-10}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-28,-70},{-40,-70}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{40,-80},{102,-80}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{40,-80},{40,50},{26,50}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{26,-12},{40,-12}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{26,-70},{40,-70}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{26,12},{60,12}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{26,-48},{60,-48},{60,80}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-100,80},{-60,80}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-28,70},{-60,70}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{100,80},{60,80}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{26,72},{60,72}},
                color={0,0,255},
                smooth=Smooth.None),
              Ellipse(
                extent={{-32,76},{-22,64}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,74},{-24,66}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-32,18},{-22,6}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,16},{-24,8}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-32,-44},{-22,-56}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,-46},{-24,-54}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,56},{30,44}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{22,54},{28,46}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,-6},{30,-18}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{22,-8},{28,-16}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,-64},{30,-76}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{22,-66},{28,-74}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,78},{30,66}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,18},{30,6}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{20,-44},{30,-56}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-32,56},{-22,44}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-32,-4},{-22,-16}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-32,-64},{-22,-76}},
                lineColor={0,0,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-158,104},{142,144}},
                textString="%name",
                textColor={0,0,255})}));
      end MultiChillers;

      model ChillerTSet "Chiller"
        replaceable package MediumCHW =
           Modelica.Media.Interfaces.PartialMedium
          "Medium in the chilled water side";
        replaceable package MediumCW =
           Modelica.Media.Interfaces.PartialMedium
          "Medium in the condenser water side";
        parameter Modelica.Units.SI.Pressure dPCHW_nominal
          "Pressure difference at the chilled water side";
        parameter Modelica.Units.SI.Pressure dPCW_nominal
          "Pressure difference at the condenser water wide";
        parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal
          "Nominal mass flow rate at the chilled water side";
        parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal
          "Nominal mass flow rate at the condenser water wide";
        parameter Modelica.Units.SI.Temperature TCW_start
          "The start temperature of condenser water side";
        parameter Modelica.Units.SI.Temperature TCHW_start
          "The start temperature of chilled water side";

         parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per
          "Performance data"
          annotation (choicesAllMatching = true,
                      Placement(transformation(extent={{40,80},{60,100}})));

        Buildings.Fluid.Chillers.ElectricEIR chi(
          redeclare package Medium1 = MediumCW,
          redeclare package Medium2 = MediumCHW,
          m1_flow_nominal=mCW_flow_nominal,
          m2_flow_nominal=mCHW_flow_nominal,
          dp1_nominal=0,
          dp2_nominal=0,
          allowFlowReversal1=true,
          allowFlowReversal2=true,
          tau1=300,
          tau2=300,
          T1_start=TCW_start,
          T2_start=TCHW_start,
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
          per=per)       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-42})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package
            Medium =
              MediumCW)
          "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
          annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package
            Medium =
              MediumCW)
          "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
          annotation (Placement(transformation(extent={{-110,70},{-90,90}}),
              iconTransformation(extent={{-110,70},{-90,90}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package
            Medium =
              MediumCHW)
          "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_CHW(redeclare package
            Medium =
              MediumCHW)
          "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,70},{110,90}}),
              iconTransformation(extent={{90,70},{110,90}})));
        replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWLea(
          redeclare package Medium = MediumCHW,
          m_flow_nominal=mCHW_flow_nominal,
          T_start=TCHW_start)
          annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear valCW(
          redeclare package Medium = MediumCW,
          m_flow_nominal=mCW_flow_nominal,
          allowFlowReversal=false,
          dpValve_nominal=dPCW_nominal)
          annotation (Placement(transformation(extent={{-60,90},{-80,70}})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear valCHW(
          redeclare package Medium = MediumCHW,
          m_flow_nominal=mCHW_flow_nominal,
          dpValve_nominal=dPCHW_nominal)
          annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
        Modelica.Blocks.Interfaces.RealInput On(min=0,max=1)
          "True to enable compressor to operate, or false to disable the operation of the compressor"
          annotation (Placement(transformation(extent={{-118,-50},{-100,-30}}),
              iconTransformation(extent={{-140,-70},{-100,-30}})));
        Modelica.Blocks.Interfaces.RealInput TCHWSet
          "Temperature setpoint of chilled water"
          annotation (Placement(transformation(extent={{-118,30},{-100,50}}),
              iconTransformation(extent={{-140,10},{-100,50}})));
        Modelica.Blocks.Interfaces.RealOutput P
          "Electric power consumed by compressor"
          annotation (Placement(transformation(extent={{100,30},{120,50}}),
              iconTransformation(extent={{100,30},{120,50}})));

        Modelica.Blocks.Math.RealToBoolean realToBoolean
          annotation (Placement(transformation(extent={{-56,-66},{-42,-52}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTCWLea(
          allowFlowReversal=true,
          redeclare package Medium = MediumCW,
          m_flow_nominal=mCW_flow_nominal) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={-40,0})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEnt(
          allowFlowReversal=true,
          redeclare package Medium = MediumCW,
          m_flow_nominal=mCW_flow_nominal) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-40,-80})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTCHWEnt(
          allowFlowReversal=true,
          redeclare package Medium = MediumCHW,
          m_flow_nominal=mCHW_flow_nominal) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={30,0})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloCHW(redeclare package
            Medium =
              MediumCHW)
          annotation (Placement(transformation(extent={{72,-10},{54,10}})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloCW(redeclare package
            Medium =
              MediumCHW)
          annotation (Placement(transformation(extent={{-78,-90},{-60,-70}})));
        Buildings.Fluid.Sensors.Pressure senPreCHWEnt(redeclare package Medium =
              MediumCHW)
          annotation (Placement(transformation(extent={{2,10},{22,30}})));
        Buildings.Fluid.Sensors.Pressure senPreCHWLea(redeclare package Medium =
              MediumCHW)
          annotation (Placement(transformation(extent={{78,-50},{98,-30}})));
        Buildings.Fluid.Sensors.Pressure     senPreCWLea(redeclare package
            Medium =
              MediumCHW)
          annotation (Placement(transformation(extent={{-76,68},{-96,48}})));
        Buildings.Fluid.Sensors.Pressure senPreCWEnt(redeclare package Medium =
              MediumCHW)
          annotation (Placement(transformation(extent={{-96,-70},{-76,-50}})));

      equation
        connect(chi.port_b2, senTCHWLea.port_a) annotation (Line(
            points={{6,-52},{6,-80},{20,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(chi.P, P) annotation (Line(
            points={{-9,-31},{-9,40},{110,40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(senTCHWLea.port_b, valCHW.port_a) annotation (Line(
            points={{40,-80},{60,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valCHW.port_b, port_b_CHW) annotation (Line(
            points={{80,-80},{100,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valCW.port_b, port_b_CW) annotation (Line(
            points={{-80,80},{-100,80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(realToBoolean.y, chi.on) annotation (Line(
            points={{-41.3,-59},{-3,-59},{-3,-54}},
            color={255,0,255},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(On, valCW.y) annotation (Line(
            points={{-109,-40},{-90,-40},{-70,-40},{-70,-26},{-70,-26},{-70,68}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(valCHW.y, valCW.y) annotation (Line(
            points={{70,-68},{70,-26},{-70,-26},{-70,68}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(realToBoolean.u, valCW.y) annotation (Line(
            points={{-57.4,-59},{-70,-59},{-70,-40},{-70,-26},{-70,68}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(chi.port_b1, senTCWLea.port_a) annotation (Line(
            points={{-6,-32},{-6,0},{-30,0}},
            color={0,127,255},
            thickness=1));
        connect(senTCWLea.port_b, valCW.port_a) annotation (Line(
            points={{-50,0},{-50,0},{-54,0},{-54,80},{-60,80}},
            color={0,127,255},
            thickness=1));
        connect(senTCWEnt.port_b, chi.port_a1) annotation (Line(
            points={{-30,-80},{-6,-80},{-6,-52}},
            color={0,127,255},
            thickness=1));
        connect(senTCHWEnt.port_b, chi.port_a2) annotation (Line(
            points={{20,0},{6,0},{6,-32}},
            color={0,127,255},
            thickness=1));
        connect(senPreCHWEnt.port, chi.port_a2) annotation (Line(
            points={{12,10},{12,0},{6,0},{6,-32}},
            color={0,127,255},
            thickness=1));
        connect(senPreCHWLea.port, port_b_CHW) annotation (Line(
            points={{88,-50},{88,-50},{88,-80},{100,-80}},
            color={0,127,255},
            thickness=1));
        connect(senPreCWLea.port, port_b_CW) annotation (Line(
            points={{-86,68},{-86,80},{-100,80}},
            color={0,127,255},
            thickness=1));
        connect(senMasFloCHW.port_b, senTCHWEnt.port_a) annotation (Line(
            points={{54,0},{47,0},{40,0}},
            color={0,127,255},
            thickness=1));
        connect(senMasFloCHW.port_a, port_a_CHW) annotation (Line(
            points={{72,0},{80,0},{80,80},{100,80}},
            color={0,127,255},
            thickness=1));
        connect(senMasFloCW.port_b, senTCWEnt.port_a) annotation (Line(
            points={{-60,-80},{-55,-80},{-50,-80}},
            color={0,127,255},
            thickness=1));
        connect(senMasFloCW.port_a, port_a_CW) annotation (Line(
            points={{-78,-80},{-100,-80}},
            color={0,127,255},
            thickness=1));
        connect(senPreCWEnt.port, port_a_CW) annotation (Line(
            points={{-86,-70},{-86,-80},{-100,-80}},
            color={0,127,255},
            thickness=1));
        connect(TCHWSet, chi.TSet) annotation (Line(
            points={{-109,40},{-16,40},{-16,-62},{3,-62},{3,-54}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Text(
                extent={{-44,-144},{50,-112}},
                lineColor={0,0,255},
                textString="%name"),
              Rectangle(
                extent={{-101,82},{100,72}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-95,-76},{106,-86}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,50},{60,32}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-52,-50},{62,-68}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-101,82},{100,72}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,72},{100,82}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-95,-76},{106,-86}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-102,-86},{-2,-76}},
                lineColor={0,0,127},
                pattern=LinePattern.None,
                fillColor={0,0,127},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-32,-10},{-42,-22},{-22,-22},{-32,-10}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-32,-10},{-42,0},{-22,0},{-32,-10}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-34,32},{-30,0}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-34,-22},{-30,-50}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{34,32},{38,-50}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{14,10},{58,-32}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{36,10},{18,-22},{54,-22},{36,10}},
                lineColor={0,128,255},
                fillColor={170,170,255},
                fillPattern=FillPattern.Solid)}),
          Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end ChillerTSet;

      package BaseClasses
        model ElectricEIR "Electric chiller based on the DOE-2.1 model"
          extends PartialElectric(
            final QEva_flow_nominal=per.QEva_flow_nominal,
            final COP_nominal=per.COP_nominal,
            final PLRMax=per.PLRMax,
            final PLRMinUnl=per.PLRMinUnl,
            final PLRMin=per.PLRMin,
            final etaMotor=per.etaMotor,
            final mEva_flow_nominal=per.mEva_flow_nominal,
            final mCon_flow_nominal=per.mCon_flow_nominal,
            final TEvaLvg_nominal=per.TEvaLvg_nominal);

          parameter Buildings.Fluid.Chillers.Data.ElectricEIR.Generic per
            "Performance data"
            annotation (choicesAllMatching = true,
                        Placement(transformation(extent={{40,80},{60,100}})));

        protected
          final parameter Modelica.Units.NonSI.Temperature_degC TConEnt_nominal_degC=
              Modelica.Units.Conversions.to_degC(per.TConEnt_nominal)
            "Temperature of fluid entering condenser at nominal condition";

          Modelica.Units.NonSI.Temperature_degC TConEnt_degC
            "Temperature of fluid entering condenser";
        initial equation
          // Verify correctness of performance curves, and write warning if error is bigger than 10%
          Buildings.Fluid.Chillers.BaseClasses.warnIfPerformanceOutOfBounds(
             Buildings.Utilities.Math.Functions.biquadratic(a=per.capFunT,
             x1=TEvaLvg_nominal_degC, x2=TConEnt_nominal_degC),
             "Capacity as function of temperature ",
             "per.capFunT");
        equation
          TConEnt_degC=Modelica.Units.Conversions.to_degC(TConEnt);

          if on then
            // Compute the chiller capacity fraction, using a biquadratic curve.
            // Since the regression for capacity can have negative values (for unreasonable temperatures),
            // we constrain its return value to be non-negative. This prevents the solver to pick the
            // unrealistic solution.
            capFunT = Buildings.Utilities.Math.Functions.smoothMax(
               x1 = 1E-6,
               x2 = Buildings.Utilities.Math.Functions.biquadratic(a=per.capFunT, x1=TEvaLvg_degC, x2=TConEnt_degC),
               deltaX = 1E-7);
        /*    assert(capFunT > 0.1, "Error: Received capFunT = " + String(capFunT)  + ".\n"
           + "Coefficient for polynomial seem to be not valid for the encountered temperature range.\n"
           + "Temperatures are TConEnt_degC = " + String(TConEnt_degC) + " degC\n"
           + "                 TEvaLvg_degC = " + String(TEvaLvg_degC) + " degC");
*/
            // Chiller energy input ratio biquadratic curve.
            EIRFunT = Buildings.Utilities.Math.Functions.biquadratic(a=per.EIRFunT, x1=TEvaLvg_degC, x2=TConEnt_degC);
            // Chiller energy input ratio quadratic curve
            EIRFunPLR   = per.EIRFunPLR[1]+per.EIRFunPLR[2]*PLR2+per.EIRFunPLR[3]*PLR2^2;
          else
            capFunT   = 0;
            EIRFunT   = 0;
            EIRFunPLR = 0;
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                           graphics={
                Rectangle(
                  extent={{-99,-54},{102,-66}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-100,-66},{0,-54}},
                  lineColor={0,0,127},
                  pattern=LinePattern.None,
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-104,66},{98,54}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-2,54},{98,66}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-44,52},{-40,12}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-56,70},{58,52}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-42,2},{-52,12},{-32,12},{-42,2}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-42,2},{-52,-10},{-32,-10},{-42,2}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-44,-10},{-40,-50}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{38,52},{42,-50}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-56,-50},{58,-68}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{18,24},{62,-18}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{40,24},{22,-8},{58,-8},{40,24}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
        defaultComponentName="chi",
        Documentation(info="<html>
<p>
Model of an electric chiller, based on the DOE-2.1 chiller model and
the EnergyPlus chiller model <code>Chiller:Electric:EIR</code>.
</p>
<p> This model uses three functions to predict capacity and power consumption:
</p>
<ul>
<li>
A biquadratic function is used to predict cooling capacity as a function of
condenser entering and evaporator leaving fluid temperature.
</li>
<li>
A quadratic functions is used to predict power input to cooling capacity ratio with respect to the part load ratio.
</li>
<li>
A biquadratic functions is used to predict power input to cooling capacity ratio as a function of
condenser entering and evaporator leaving fluid temperature.
</li>
</ul>
<p>
These curves are stored in the data record <code>per</code> and are available from
<a href=\"Buildings.Fluid.Chillers.Data.ElectricEIR\">
Buildings.Fluid.Chillers.Data.ElectricEIR</a>.
Additional performance curves can be developed using
two available techniques (Hydeman and Gillespie, 2002). The first technique is called the
Least-squares Linear Regression method and is used when sufficient performance data exist
to employ standard least-square linear regression techniques. The second technique is called
Reference Curve Method and is used when insufficient performance data exist to apply linear
regression techniques. A detailed description of both techniques can be found in
Hydeman and Gillespie (2002).
</p>
<p>
The model takes as an input the set point for the leaving chilled water temperature,
which is met if the chiller has sufficient capacity.
Thus, the model has a built-in, ideal temperature control.
The model has three tests on the part load ratio and the cycling ratio:
</p>
<ol>
<li>
The test<pre>
  PLR1 =min(QEva_flow_set/QEva_flow_ava, per.PLRMax);
</pre>
ensures that the chiller capacity does not exceed the chiller capacity specified
by the parameter <code>per.PLRMax</code>.
</li>
<li>
The test <pre>
  CR = min(PLR1/per.PRLMin, 1.0);
</pre>
computes a cycling ratio. This ratio expresses the fraction of time
that a chiller would run if it were to cycle because its load is smaller than the
minimal load at which it can operate.
Note that this model continuously operates even if the part load ratio is below the minimum part load ratio.
Its leaving evaporator and condenser temperature can therefore be considered as an
average temperature between the modes where the compressor is off and on.
</li>
<li>
The test <pre>
  PLR2 = max(per.PLRMinUnl, PLR1);
</pre>
computes the part load ratio of the compressor.
The assumption is that for a part load ratio below <code>per.PLRMinUnl</code>,
the chiller uses hot gas bypass to reduce the capacity, while the compressor
power draw does not change.
</li>
</ol>
<p>
The electric power only contains the power for the compressor, but not any power for pumps or fans.
</p>
<p>
The model can be parametrized to compute a transient
or steady-state response.
The transient response of the boiler is computed using a first
order differential equation for the evaporator and condenser fluid volumes.
The chiller outlet temperatures are equal to the temperatures of these lumped volumes.
</p>
<h4>References</h4>
<ul>
<li>
Hydeman, M. and K.L. Gillespie. 2002. Tools and Techniques to Calibrate Electric Chiller
Component Models. <i>ASHRAE Transactions</i>, AC-02-9-1.
</li>
</ul>
</html>",
        revisions="<html>
<ul>
<li>
March 12, 2015, by Michael Wetter:<br/>
Refactored model to make it once continuously differentiable.
This is for issue <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/373\">373</a>.
</li>
<li>
Jan. 9, 2011, by Michael Wetter:<br/>
Added input signal to switch chiller off.
</li>
<li>
Sep. 8, 2010, by Michael Wetter:<br/>
Revised model and included it in the Buildings library.
</li>
<li>
October 13, 2008, by Brandon Hencey:<br/>
First implementation.
</li>
</ul>
</html>"));
        end ElectricEIR;

        partial model PartialElectric "Partial model for electric chiller"
          extends Buildings.Fluid.Interfaces.FourPortHeatMassExchanger(
           m1_flow_nominal = mCon_flow_nominal,
           m2_flow_nominal = mEva_flow_nominal,
           T1_start = 273.15+25,
           T2_start = 273.15+5,
           redeclare final Buildings.Fluid.MixingVolumes.MixingVolume vol2(
              V=m2_flow_nominal*tau2/rho2_nominal,
              nPorts=2,
              final prescribedHeatFlowRate=true),
            vol1(
              final prescribedHeatFlowRate=true));

          Modelica.Blocks.Interfaces.BooleanInput on
            "Set to true to enable compressor, or false to disable compressor"
            annotation (Placement(transformation(extent={{-140,10},{-100,50}}),
                iconTransformation(extent={{-140,10},{-100,50}})));
          Modelica.Blocks.Interfaces.RealInput y "Cooling power output ratio" annotation (
              Placement(transformation(extent={{-140,-50},{-100,-10}}),
                iconTransformation(extent={{-140,-50},{-100,-10}})));

          Modelica.Units.SI.Temperature TEvaEnt "Evaporator entering temperature";
          Modelica.Units.SI.Temperature TEvaLvg "Evaporator leaving temperature";
          Modelica.Units.SI.Temperature TConEnt "Condenser entering temperature";
          Modelica.Units.SI.Temperature TConLvg "Condenser leaving temperature";

          Modelica.Units.SI.Efficiency COP "Coefficient of performance";
          Modelica.Units.SI.HeatFlowRate QCon_flow "Condenser heat input";
          Modelica.Units.SI.HeatFlowRate QEva_flow "Evaporator heat input";
          Modelica.Blocks.Interfaces.RealOutput P(final quantity="Power", unit="W")
            "Electric power consumed by compressor"
            annotation (Placement(transformation(extent={{100,80},{120,100}}),
                iconTransformation(extent={{100,80},{120,100}})));

          Real capFunT(min=0, unit="1")
            "Cooling capacity factor function of temperature curve";
          Modelica.Units.SI.Efficiency EIRFunT
            "Power input to cooling capacity ratio function of temperature curve";
          Modelica.Units.SI.Efficiency EIRFunPLR
            "Power input to cooling capacity ratio function of part load ratio";
          Real PLR1(min=0, unit="1") "Part load ratio";
          Real PLR2(min=0, unit="1") "Part load ratio";
          Real CR(min=0, unit="1") "Cycling ratio";
          parameter Modelica.Units.SI.Efficiency epsEva(max=1) = 1
            "Heat exchanger effectiveness at evaporator";

          parameter Modelica.Units.SI.Efficiency epsCon(max=1) = 1
            "Heat exchanger effectiveness at condenser";

        protected
          Modelica.Units.SI.HeatFlowRate QEva_flow_ava(nominal=QEva_flow_nominal, start=
               QEva_flow_nominal) "Cooling capacity available at evaporator";
          Modelica.Units.SI.HeatFlowRate QEva_flow_set(nominal=QEva_flow_nominal, start=
               QEva_flow_nominal)
            "Cooling capacity required to cool to set point temperature";

          // Performance data
          parameter Modelica.Units.SI.HeatFlowRate QEva_flow_nominal(max=0)
            "Reference capacity (negative number)";
          parameter Modelica.Units.SI.Efficiency COP_nominal
            "Reference coefficient of performance";
          parameter Real PLRMax(min=0, unit="1") "Maximum part load ratio";
          parameter Real PLRMinUnl(min=0, unit="1") "Minimum part unload ratio";
          parameter Real PLRMin(min=0, unit="1") "Minimum part load ratio";
          parameter Modelica.Units.SI.Efficiency etaMotor(max=1)
            "Fraction of compressor motor heat entering refrigerant";
          parameter Modelica.Units.SI.MassFlowRate mEva_flow_nominal
            "Nominal mass flow at evaporator";
          parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal
            "Nominal mass flow at condenser";

          parameter Modelica.Units.SI.Temperature TEvaLvg_nominal
            "Temperature of fluid leaving evaporator at nominal condition";

          final parameter Modelica.Units.NonSI.Temperature_degC TEvaLvg_nominal_degC=
              Modelica.Units.Conversions.to_degC(TEvaLvg_nominal)
            "Temperature of fluid leaving evaporator at nominal condition";
          Modelica.Units.NonSI.Temperature_degC TEvaLvg_degC
            "Temperature of fluid leaving evaporator";
          parameter Modelica.Units.SI.HeatFlowRate Q_flow_small=QEva_flow_nominal*1E-9
            "Small value for heat flow rate or power, used to avoid division by zero";
          Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloEva
            "Prescribed heat flow rate"
            annotation (Placement(transformation(extent={{-39,-50},{-19,-30}})));
          Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloCon
            "Prescribed heat flow rate"
            annotation (Placement(transformation(extent={{-39,30},{-19,50}})));
          Modelica.Blocks.Sources.RealExpression QEva_flow_in(y=QEva_flow)
            "Evaporator heat flow rate"
            annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
          Modelica.Blocks.Sources.RealExpression QCon_flow_in(y=QCon_flow)
            "Condenser heat flow rate"
            annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

        initial equation
          assert(QEva_flow_nominal < 0, "Parameter QEva_flow_nominal must be smaller than zero.");
          assert(Q_flow_small < 0, "Parameter Q_flow_small must be smaller than zero.");
          assert(PLRMinUnl >= PLRMin, "Parameter PLRMinUnl must be bigger or equal to PLRMin");
          assert(PLRMax > PLRMinUnl, "Parameter PLRMax must be bigger than PLRMinUnl");
        equation
          // Condenser temperatures
          TConEnt = Medium1.temperature(Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow)));
          TConLvg = vol1.heatPort.T;
          // Evaporator temperatures
          TEvaEnt = Medium2.temperature(Medium2.setState_phX(port_a2.p, inStream(port_a2.h_outflow)));
          TEvaLvg = vol2.heatPort.T;
          TEvaLvg_degC=Modelica.Units.Conversions.to_degC(TEvaLvg);

          if on then
            // Available cooling capacity
            QEva_flow_ava = QEva_flow_nominal*capFunT;
            // Cooling capacity is controlled to be output
            QEva_flow_set = y*QEva_flow_ava;

            // Part load ratio
            PLR1 = Buildings.Utilities.Math.Functions.smoothMin(
              x1 = QEva_flow_set/(QEva_flow_ava+Q_flow_small),
              x2 = PLRMax,
              deltaX=PLRMax/100);
            // PLR2 is the compressor part load ratio. The lower bound PLRMinUnl is
            // since for PLR1<PLRMinUnl, the chiller uses hot gas bypass, under which
            // condition the compressor power is assumed to be the same as if the chiller
            // were to operate at PLRMinUnl
            PLR2 = Buildings.Utilities.Math.Functions.smoothMax(
              x1 = PLRMinUnl,
              x2 = PLR1,
              deltaX = PLRMinUnl/100);

            // Cycling ratio.
            // Due to smoothing, this can be about deltaX/10 above 1.0
            CR = Buildings.Utilities.Math.Functions.smoothMin(
              x1 = PLR1/PLRMin,
              x2 = 1,
              deltaX=0.001);

            // Compressor power.
            P = -QEva_flow_ava/COP_nominal*EIRFunT*EIRFunPLR*CR;
            // Heat flow rates into evaporator and condenser
            // Q_flow_small is a negative number.
            QEva_flow = Buildings.Utilities.Math.Functions.smoothMax(
              x1 = QEva_flow_set,
              x2 = QEva_flow_ava,
              deltaX= -Q_flow_small/10)*epsEva;

          //QEva_flow = max(QEva_flow_set, QEva_flow_ava);
            QCon_flow = epsCon*(-QEva_flow + P*etaMotor);
            // Coefficient of performance
            COP = -QEva_flow/epsEva/(P-Q_flow_small);
          else
            QEva_flow_ava = 0;
            QEva_flow_set = 0;
            PLR1 = 0;
            PLR2 = 0;
            CR   = 0;
            P    = 0;
            QEva_flow = 0;
            QCon_flow = 0;
            COP  = 0;
          end if;

          connect(QCon_flow_in.y, preHeaFloCon.Q_flow) annotation (Line(
              points={{-59,40},{-39,40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(preHeaFloCon.port, vol1.heatPort) annotation (Line(
              points={{-19,40},{-10,40},{-10,60}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(QEva_flow_in.y, preHeaFloEva.Q_flow) annotation (Line(
              points={{-59,-40},{-39,-40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(preHeaFloEva.port, vol2.heatPort) annotation (Line(
              points={{-19,-40},{12,-40},{12,-60}},
              color={191,0,0},
              smooth=Smooth.None));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}),
                           graphics={
                Text(extent={{62,96},{112,82}},   textString="P",
                  lineColor={0,0,127}),
                Text(extent={{-94,-24},{-48,-36}},  textString="T_CHWS",
                  lineColor={0,0,127}),
                Rectangle(
                  extent={{-99,-54},{102,-66}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-100,-66},{0,-54}},
                  lineColor={0,0,127},
                  pattern=LinePattern.None,
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-104,66},{98,54}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-2,54},{98,66}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-44,52},{-40,12}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-56,70},{58,52}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-42,2},{-52,12},{-32,12},{-42,2}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-42,2},{-52,-10},{-32,-10},{-42,2}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-44,-10},{-40,-50}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{38,52},{42,-50}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-56,-50},{58,-68}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{18,24},{62,-18}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{40,24},{22,-8},{58,-8},{40,24}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(extent={{-108,36},{-62,24}},
                  lineColor={0,0,127},
                  textString="on")}),
        Documentation(info="<html>
<p>
Base class for model of an electric chiller, based on the DOE-2.1 chiller model and the
CoolTools chiller model that are implemented in EnergyPlus as the models
<code>Chiller:Electric:EIR</code> and <code>Chiller:Electric:ReformulatedEIR</code>.
</p>
<p>
The model takes as an input the set point for the leaving chilled water temperature,
which is met if the chiller has sufficient capacity.
Thus, the model has a built-in, ideal temperature control.
The model has three tests on the part load ratio and the cycling ratio:
</p>
<ol>
<li>
The test
<pre>
  PLR1 =min(QEva_flow_set/QEva_flow_ava, PLRMax);
</pre>
ensures that the chiller capacity does not exceed the chiller capacity specified
by the parameter <code>PLRMax</code>.
</li>
<li>
The test <pre>
  CR = min(PLR1/per.PRLMin, 1.0);
</pre>
computes a cycling ratio. This ratio expresses the fraction of time
that a chiller would run if it were to cycle because its load is smaller than
the minimal load at which it can operature. Notice that this model does continuously operature even if
the part load ratio is below the minimum part load ratio. Its leaving evaporator and condenser temperature
can therefore be considered as an
average temperature between the modes where the compressor is off and on.
</li>
<li>
The test <pre>
  PLR2 = max(PLRMinUnl, PLR1);
</pre>
computes the part load ratio of the compressor.
The assumption is that for a part load ratio below <code>PLRMinUnl</code>,
the chiller uses hot gas bypass to reduce the capacity, while the compressor
power draw does not change.
</li>
</ol>
<p>
The electric power only contains the power for the compressor, but not any power for pumps or fans.
</p>
<h4>Implementation</h4>
<p>
Models that extend from this base class need to provide
three functions to predict capacity and power consumption:
</p>
<ul>
<li>
A function to predict cooling capacity. The function value needs
to be assigned to <code>capFunT</code>.
</li>
<li>
A function to predict the power input as a function of temperature.
The function value needs to be assigned to <code>EIRFunT</code>.
</li>
<li>
A function to predict the power input as a function of the part load ratio.
The function value needs to be assigned to <code>EIRFunPLR</code>.
</li>
</ul>
</html>",
        revisions="<html>
<ul>
<li>
June 28, 2019, by Michael Wetter:<br/>
Removed <code>start</code> values and removed
<code>nominal=1</code> for performance curves.<br/>
This is for issue <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1465\">1465</a>.
</li>
<li>
March 12, 2015, by Michael Wetter:<br/>
Refactored model to make it once continuously differentiable.
This is for issue <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/373\">373</a>.
</li>
<li>
Jan. 10, 2011, by Michael Wetter:<br/>
Added input signal to switch chiller off, and changed base class to use a dynamic model.
The change of the base class was required to improve the robustness of the model when the control
is switched on again.
</li>
<li>
Sep. 8, 2010, by Michael Wetter:<br/>
Revised model and included it in the Buildings library.
</li>
<li>
October 13, 2008, by Brandon Hencey:<br/>
First implementation.
</li>
</ul>
</html>"));
        end PartialElectric;
      end BaseClasses;
    annotation ();
    end Chiller;

    package CoolingTower
      "This package contains the modules which can be used to simulate the cooling towers"

      model MultiCoolingTowers
        "This model is designed to simulate the cooling tower systwm with N towers"
        replaceable package MediumCW =
             Modelica.Media.Interfaces.PartialMedium
          "Medium in the  condenser water side";
        parameter Modelica.Units.SI.Power P_nominal[n]
          "Nominal cooling tower power (at y=1)";
        parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal
          "Temperature difference between the outlet and inlet of the tower ";
        parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal
          "Nominal approach temperature";
        parameter Modelica.Units.SI.Temperature TWetBul_nominal
          "Nominal wet bulb temperature";
        parameter Modelica.Units.SI.Pressure dP_nominal
          "Pressure difference between the outlet and inlet of the tower ";
        parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[n]
          "Nominal mass flow rate at condenser water wide";
        parameter Real GaiPi "Gain of the tower PI controller";
        parameter Real tIntPi "Integration time of the tower PI controller";
        parameter Real v_flow_rate[n,:] "Air volume flow rate ratio";
        parameter Real eta[n,:] "Fan efficiency";
        parameter Modelica.Units.SI.Temperature TCW_start
          "The start temperature of condenser water side";

        parameter Integer n
          "the number of cooling towers";
        Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package
            Medium =                                                               MediumCW)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package
            Medium =                                                               MediumCW)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput TWetBul
          "Entering air wet bulb temperature"
          annotation (Placement(transformation(extent={{-118,-69},{-100,-51}})));
        Modelica.Blocks.Interfaces.RealInput TCWSet
          "Temperature set point of the condenser water"
          annotation (Placement(transformation(extent={{-118,70},{-100,88}})));
        VSDCoolingTower ct[n](
          redeclare package MediumCW = MediumCW,
          P_nominal=P_nominal,
          dTCW_nominal=dTCW_nominal,
          dTApp_nominal=dTApp_nominal,
          TWetBul_nominal=TWetBul_nominal,
          dP_nominal=dP_nominal,
          mCW_flow_nominal=mCW_flow_nominal,
          GaiPi=GaiPi,
          tIntPi=tIntPi,
          eta=eta,
          TCW_start=TCW_start,
          v_flow_rate=v_flow_rate,
          conPI(reverseActing=false))
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Interfaces.RealInput On[n]
          "Temperature set point of the condenser water"
          annotation (Placement(transformation(extent={{-118,30},{-100,48}})));
        Modelica.Blocks.Interfaces.RealOutput P[n]
          "Electric power consumed by compressor"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
      equation

        for i in 1:n loop
          connect(ct[i].port_a_CW, port_a_CW);
          connect(ct[i].port_b_CW, port_b_CW);
          connect(ct[i].TSet, TCWSet);
           connect(TWetBul, ct[i].TWetBul);
             connect(ct[i].P, P[i]);
        end for;

        connect(ct.On, On) annotation (Line(
            points={{-12,4},{-60,4},{-60,39},{-109,39}},
            color={0,0,127},
            pattern=LinePattern.Dash));

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Text(
                extent={{-44,-144},{50,-112}},
                lineColor={0,0,255},
                textString="%name"),
              Rectangle(
                extent={{-14,68},{14,40}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-10,76},{10,68}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-10,72},{-2,70}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{2,72},{10,70}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-8,60},{-10,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-8,60},{-6,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,60},{-2,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,60},{2,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{8,60},{6,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{8,60},{10,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Rectangle(
                extent={{-14,8},{14,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-10,16},{10,8}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-10,12},{-2,10}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{2,12},{10,10}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-8,0},{-10,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-8,0},{-6,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,0},{-2,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,0},{2,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{8,0},{6,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{8,0},{10,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Rectangle(
                extent={{-14,-52},{14,-80}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-10,-44},{10,-52}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-10,-48},{-2,-50}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{2,-48},{10,-50}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-8,-60},{-10,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-8,-60},{-6,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,-60},{-2,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,-60},{2,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{8,-60},{6,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{8,-60},{10,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-100,0},{-40,0},{-40,60},{8,60}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-40,0},{8,0}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-40,0},{-40,-60},{8,-60}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{14,40},{40,40},{40,0},{90,0}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{14,-20},{40,-20},{40,0}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{14,-80},{40,-80},{40,-20}},
                color={0,0,255},
                smooth=Smooth.None)}),
          Documentation(revisions="<html>
<ul>
<li>
March 30, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end MultiCoolingTowers;

      model CoolingTowersWithBypass
        "This model is designed to simulate the cooling tower system with N way bypass valve"
        replaceable package MediumCW =
             Modelica.Media.Interfaces.PartialMedium
          "Medium condenser water side";
        parameter Modelica.Units.SI.Temperature TCWLowSet
          "The lower temperatre limit of condenser water entering the chiller plant";
        parameter Modelica.Units.SI.Power P_nominal[n] "Nominal tower power (at y=1)";
        parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal
          "Temperature difference between the outlet and inlet of the tower";
        parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal
          "Nominal approach temperature";
        parameter Modelica.Units.SI.Temperature TWetBul_nominal
          "Nominal wet bulb temperature";
        parameter Modelica.Units.SI.Pressure dP_nominal
          "Pressure difference between the outlet and inlet of the tower ";
        parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]
          "Nominal mass flow rate at condenser water wide";
        parameter Real v_flow_rate[n,:] "Air volume flow rate ratio";
        parameter Real eta[n,:] "Fan efficiency";
        parameter Modelica.Units.SI.Pressure dPByp_nominal
          "Pressure difference between the outlet and inlet of the bypass valve ";
        parameter Modelica.Units.SI.Temperature TCW_start
          "The start temperature of condenser water side";
        parameter Integer n
          "the number of cooling towers";
        replaceable MultiCoolingTowers mulCooTowSys(
          redeclare package MediumCW = MediumCW,
          P_nominal=P_nominal,
          dTCW_nominal=dTCW_nominal,
          dP_nominal=dP_nominal,
          mCW_flow_nominal=mCW_flow_nominal,
          v_flow_rate=v_flow_rate,
          TCW_start=TCW_start,
          dTApp_nominal=dTApp_nominal,
          TWetBul_nominal=TWetBul_nominal,
          eta=eta,
          n=n,
          GaiPi=1,
          tIntPi=60)
          annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
        Bypass byp(
          redeclare package MediumCW = MediumCW,
          dPByp_nominal=dPByp_nominal,
          m_flow_nominal=sum(mCW_flow_nominal))
          annotation (Placement(transformation(extent={{0,-20},{20,0}})));
        Modelica.Blocks.Interfaces.RealInput On[n] "On signal"
          annotation (Placement(transformation(extent={{-118,51},{-100,69}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{90,50},{110,70}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
        replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEntChi(
            redeclare package Medium = MediumCW,
          T_start=TCW_start,
          m_flow_nominal=sum(mCW_flow_nominal))
          annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
        Modelica.Blocks.Interfaces.RealInput TWetBul
          "Entering air wet bulb temperature"
          annotation (Placement(transformation(extent={{-118,-69},{-100,-51}})));
        Modelica.Blocks.Interfaces.RealInput TCWSet
          "Temperature set point of the condenser water"
          annotation (Placement(transformation(extent={{-118,-9},{-100,9}})));

        .MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
          conPI(k=1, Ti=60)
          annotation (Placement(transformation(extent={{-40,38},{-20,58}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=TCWLowSet)
                                                              annotation (Placement(transformation(extent={{-74,10},{-54,30}})));
        Modelica.Blocks.Sources.BooleanExpression realExpression1(y=true)
          annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      equation
        connect(mulCooTowSys.port_b_CW, byp.port_a2) annotation (Line(
            points={{-20,-30},{-8,-30},{-8,-14},{0,-14}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(byp.port_b1, mulCooTowSys.port_a_CW) annotation (Line(
            points={{0,-6},{-60,-6},{-60,-30},{-40,-30}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(byp.port_a1, port_a) annotation (Line(
            points={{20,-6},{40,-6},{40,60},{100,60}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(byp.port_b2, senTCWEntChi.port_a) annotation (Line(
            points={{20,-14},{40,-14},{40,-80},{60,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(senTCWEntChi.port_b, port_b) annotation (Line(
            points={{80,-80},{100,-80}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(mulCooTowSys.TWetBul, TWetBul) annotation (Line(
            points={{-40.9,-36},{-80,-36},{-80,-60},{-109,-60}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(mulCooTowSys.TCWSet, TCWSet) annotation (Line(
            points={{-40.9,-22.1},{-72,-22.1},{-72,0},{-109,0}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(conPI.y, byp.yBypVal) annotation (Line(
            points={{-19,48},{0,48},{0,22},{-20,22},{-20,-2},{-2,-2}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(senTCWEntChi.T,conPI.mea)  annotation (Line(
            points={{70,-69},{70,70},{-58,70},{-58,42},{-42,42}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(realExpression.y, conPI.set) annotation (Line(
            points={{-53,20},{-48,20},{-48,48},{-42,48}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(realExpression1.y, conPI.On) annotation (Line(
            points={{-59,80},{-50,80},{-50,54},{-42,54}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(On, mulCooTowSys.On) annotation (Line(
            points={{-109,60},{-94,60},{-80,60},{-80,-26.1},{-40.9,-26.1}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Text(
                extent={{-42,-144},{52,-112}},
                lineColor={0,0,255},
                textString="%name"),
              Rectangle(
                extent={{-40,68},{-12,40}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-36,76},{-16,68}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-36,72},{-28,70}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-24,72},{-16,70}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-34,60},{-36,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-34,60},{-32,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-26,60},{-28,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-26,60},{-24,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-18,60},{-20,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-18,60},{-16,54}},
                color={255,0,0},
                smooth=Smooth.None),
              Rectangle(
                extent={{-40,8},{-12,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-36,16},{-16,8}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-36,12},{-28,10}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-24,12},{-16,10}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-34,0},{-36,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-34,0},{-32,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-26,0},{-28,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-26,0},{-24,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-18,0},{-20,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-18,0},{-16,-6}},
                color={255,0,0},
                smooth=Smooth.None),
              Rectangle(
                extent={{-40,-52},{-12,-80}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-36,-44},{-16,-52}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-36,-48},{-28,-50}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-24,-48},{-16,-50}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-34,-60},{-36,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-34,-60},{-32,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-26,-60},{-28,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-26,-60},{-24,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-18,-60},{-20,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-18,-60},{-16,-66}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{60,60},{60,-60}},
                color={0,0,255},
                smooth=Smooth.None),
              Polygon(
                points={{60,0},{50,10},{70,10},{60,0}},
                lineColor={0,0,0},
                smooth=Smooth.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{60,0},{50,-12},{70,-12},{60,0}},
                lineColor={0,0,0},
                smooth=Smooth.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{90,60},{100,60},{-34,60}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,60},{0,0},{-34,0}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,0},{0,-60},{-34,-60}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                points={{-12,40},{10,40},{10,-80},{60,-80},{60,-60}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{100,-80},{60,-80}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-12,-20},{10,-20}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{-12,-80},{10,-80}},
                color={0,0,255},
                smooth=Smooth.None)}),
          Documentation(revisions="<html>
<ul>
<li>
March 30, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end CoolingTowersWithBypass;

      model VSDCoolingTower "the cooling tower"
        replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium in the condenser water side";
        parameter Modelica.Units.SI.Power P_nominal
          "Nominal cooling tower component power (at y=1)";
        parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal
          "Temperature difference between the outlet and inlet of the module";
        parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal
          "Nominal approach temperature";
        parameter Modelica.Units.SI.Temperature TWetBul_nominal
          "Nominal wet bulb temperature";
        parameter Modelica.Units.SI.Pressure dP_nominal
          "Pressure difference between the outlet and inlet of the module ";
        parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal
          "Nominal mass flow rate";
        parameter Real GaiPi "Gain of the component PI controller";
        parameter Real tIntPi "Integration time of the component PI controller";
        parameter Real v_flow_rate[:] "Volume flow rate ratio";
        parameter Real eta[:] "Fan efficiency";
        parameter Modelica.Units.SI.Temperature TCW_start
          "The start temperature of condenser water side";
        BaseClasses.YorkCalc yorkCalc(
          redeclare package Medium = MediumCW,
          m_flow_nominal=mCW_flow_nominal,
          dp_nominal=0,
          TRan_nominal=dTCW_nominal,
          TAirInWB_nominal=TWetBul_nominal,
          TApp_nominal=dTApp_nominal,
          fraPFan_nominal=P_nominal/mCW_flow_nominal,
          T_start=TCW_start,
          fanRelPow(r_V=v_flow_rate, r_P=eta))
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package
            Medium =
              MediumCW)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package
            Medium =
              MediumCW)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
          redeclare package Medium = MediumCW,
          m_flow_nominal=mCW_flow_nominal,
          dpValve_nominal=dP_nominal)
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        .MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
          conPI(k=GaiPi, Ti=tIntPi)
          annotation (Placement(transformation(extent={{-30,72},{-10,92}})));
        Modelica.Blocks.Interfaces.RealInput On(min=0,max=1) "On signal"
          annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
        Modelica.Blocks.Interfaces.RealInput TSet
          "Temperature setpoint of the condenser water"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput TWetBul
          "Entering air wet bulb temperature"
          annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=yorkCalc.PFan) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
        Modelica.Blocks.Interfaces.RealOutput P "Power of the cooling tower module"
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEnt(
          allowFlowReversal=true,
          redeclare package Medium = MediumCW,
          m_flow_nominal=mCW_flow_nominal) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-78,0})));
        replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTCWLea(
          allowFlowReversal=true,
          redeclare package Medium = MediumCW,
          m_flow_nominal=mCW_flow_nominal) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={44,0})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloCW(redeclare package
            Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{60,-10},{78,10}})));
        Buildings.Fluid.Sensors.Pressure senPreCWLea(redeclare package Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{94,-16},{74,-36}})));
        Buildings.Fluid.Sensors.Pressure senPreCWEnt(redeclare package Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{-22,-16},{-42,-36}})));
        Modelica.Blocks.Math.RealToBoolean realToBoolean
          annotation (Placement(transformation(extent={{-86,20},{-72,34}})));
      equation
        connect(yorkCalc.port_a, val.port_b) annotation (Line(
            points={{0,0},{-40,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(yorkCalc.TAir, TWetBul) annotation (Line(
            points={{-2,4},{-20,4},{-20,-40},{-120,-40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(realExpression.y, P) annotation (Line(
            points={{21,-40},{110,-40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(val.port_a, senTCWEnt.port_b) annotation (Line(
            points={{-60,0},{-68,0}},
            color={0,127,255},
            thickness=1));
        connect(senTCWEnt.port_a, port_a_CW) annotation (Line(
            points={{-88,0},{-100,0}},
            color={0,127,255},
            thickness=1));
        connect(yorkCalc.port_b, senTCWLea.port_a) annotation (Line(
            points={{20,0},{34,0}},
            color={0,127,255},
            thickness=1));
        connect(senTCWLea.port_b, senMasFloCW.port_a) annotation (Line(
            points={{54,0},{56,0},{60,0}},
            color={0,127,255},
            thickness=1));
        connect(senMasFloCW.port_b, port_b_CW) annotation (Line(
            points={{78,0},{100,0}},
            color={0,127,255},
            thickness=1));
        connect(senPreCWLea.port, port_b_CW) annotation (Line(
            points={{84,-16},{84,0},{100,0}},
            color={0,127,255},
            thickness=1));
        connect(senPreCWEnt.port, val.port_b) annotation (Line(
            points={{-32,-16},{-32,-16},{-32,0},{-40,0}},
            color={0,127,255},
            thickness=1));
        connect(realToBoolean.u, On) annotation (Line(
            points={{-87.4,27},{-92,27},{-92,40},{-120,40}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(realToBoolean.y, conPI.On) annotation (Line(
            points={{-71.3,27},{-54,27},{-54,88},{-32,88}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(conPI.set, TSet) annotation (Line(
            points={{-32,82},{-76,82},{-76,80},{-120,80}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(senTCWLea.T,conPI.mea)  annotation (Line(
            points={{44,11},{44,11},{44,40},{-44,40},{-44,76},{-32,76}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(conPI.y, yorkCalc.y) annotation (Line(
            points={{-9,82},{12,82},{12,22},{-20,22},{-20,8},{-2,8}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(val.y, On) annotation (Line(
            points={{-50,12},{-50,40},{-120,40}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-52,34},{58,-34}},
                lineColor={0,0,255},
                textString="CoolingTower"),
              Text(
                extent={{-44,-146},{50,-114}},
                lineColor={0,0,255},
                textString="%name")}));
      end VSDCoolingTower;

      model Bypass "Three way bypass valve"
        replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium condenser water side";
        parameter Modelica.Units.SI.Pressure dPByp_nominal
          "Pressure difference between the outlet and inlet of the valve ";
        parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
          "Nominal mass flow rate";
        Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{90,30},{110,50}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
        Modelica.Blocks.Interfaces.RealInput yBypVal "(0: closed, 1: open)"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloTow(redeclare package
            Medium =         MediumCW)
          annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
        Modelica.Blocks.Interfaces.RealOutput m_flow
          "Mass flow rate through the cooling towers"
          annotation (Placement(transformation(extent={{100,70},{120,90}})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloByp(redeclare package
            Medium =         MediumCW) annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=90,
              origin={0,-20})));
        Modelica.Blocks.Interfaces.RealOutput m_flow_bypass
          "Mass flow rate through the bypass "
          annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
              MediumCW)
          annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
        replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valByp(
          redeclare package Medium = MediumCW,
          m_flow_nominal=m_flow_nominal,
          dpValve_nominal=dPByp_nominal)               annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={0,10})));
      equation
        connect(port_a2, port_b2) annotation (Line(
            points={{-100,-40},{100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valByp.port_b, senMasFloByp.port_a) annotation (Line(
            points={{0,0},{0,-10}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(senMasFloByp.port_b, port_b2) annotation (Line(
            points={{0,-30},{0,-40},{100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(senMasFloTow.port_b, port_b1) annotation (Line(
            points={{-80,40},{-100,40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(senMasFloByp.m_flow, m_flow_bypass) annotation (Line(
            points={{11,-20},{60,-20},{60,-80},{110,-80}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(senMasFloTow.m_flow, m_flow) annotation (Line(
            points={{-70,51},{-70,60},{80,60},{80,80},{110,80}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(senMasFloTow.port_a, port_a1) annotation (Line(
            points={{-60,40},{100,40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valByp.port_a, port_a1) annotation (Line(
            points={{0,20},{0,40},{100,40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valByp.y, yBypVal) annotation (Line(
            points={{-12,10},{-40,10},{-40,80},{-120,80}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-50,32},{56,-32}},
                lineColor={0,0,255},
                textString="BypassValve"),
              Text(
                extent={{-44,-142},{50,-110}},
                lineColor={0,0,255},
                textString="%name")}));
      end Bypass;

      package BaseClasses
        model YorkCalc
          "Cooling tower with variable speed using the York calculation for the approach temperature"
          extends
            Buildings.Fluid.HeatExchangers.CoolingTowers.BaseClasses.CoolingTower;
          parameter Modelica.Units.SI.Efficiency eps(
            min=0.1,
            max=1) = 1 "Heat exchanger effectiveness";
          import cha =
            Buildings.Fluid.HeatExchangers.CoolingTowers.BaseClasses.Characteristics;

          parameter Modelica.Units.SI.Temperature TAirInWB_nominal=273.15 + 25.55
            "Design inlet air wet bulb temperature"
            annotation (Dialog(group="Nominal condition"));
          parameter Modelica.Units.SI.TemperatureDifference TApp_nominal(displayUnit=
                "K") = 3.89 "Design approach temperature"
            annotation (Dialog(group="Nominal condition"));
          parameter Modelica.Units.SI.TemperatureDifference TRan_nominal(displayUnit=
                "K") = 5.56 "Design range temperature (water in - water out)"
            annotation (Dialog(group="Nominal condition"));
          parameter Real fraPFan_nominal(unit="W/(kg/s)") = 275/0.15
            "Fan power divided by water mass flow rate at design condition"
            annotation(Dialog(group="Fan"));
          parameter Modelica.Units.SI.Power PFan_nominal=fraPFan_nominal*m_flow_nominal
            "Fan power" annotation (Dialog(group="Fan"));

          replaceable parameter cha.fan fanRelPow(
               r_V = {0, 0.1,   0.3,   0.6,   1},
               r_P = {0, 0.1^3, 0.3^3, 0.6^3, 1})
            constrainedby cha.fan
            "Fan relative power consumption as a function of control signal, fanRelPow=P(y)/P(y=1)"
            annotation (
            choicesAllMatching=true,
            Placement(transformation(extent={{60,60},{80,80}})),
            Dialog(group="Fan"));

          parameter Real yMin(min=0.01, max=1, unit="1") = 0.3
            "Minimum control signal until fan is switched off (used for smoothing between forced and free convection regime)"
            annotation(Dialog(group="Fan"));

          parameter Real fraFreCon(min=0, max=1) = 0.125
            "Fraction of tower capacity in free convection regime";

          Modelica.Blocks.Interfaces.RealInput y(unit="1") "Fan control signal"
             annotation (Placement(transformation(
                  extent={{-140,60},{-100,100}})));

          Modelica.Blocks.Interfaces.RealInput TAir(
            min=0,
            unit="K",
            displayUnit="degC")
            "Entering air wet bulb temperature"
             annotation (Placement(transformation(
                  extent={{-140,20},{-100,60}})));

          Modelica.Blocks.Interfaces.RealOutput PFan(
            final quantity="Power",
            final unit="W")=
              Buildings.Utilities.Math.Functions.spliceFunction(
                pos=cha.normalizedPower(per=fanRelPow, r_V=y, d=fanRelPowDer) * PFan_nominal,
                neg=0,
                x=y-yMin+yMin/20,
                deltax=yMin/20)
            "Electric power consumed by fan"
            annotation (Placement(transformation(extent={{100,70},{120,90}}),
                iconTransformation(extent={{100,70},{120,90}})));

          Buildings.Fluid.HeatExchangers.CoolingTowers.Correlations.BoundsYorkCalc bou
            "Bounds for correlation";

          Modelica.Units.SI.TemperatureDifference TRan(displayUnit="K") = T_a - T_b
            "Range temperature";
          Modelica.Units.SI.TemperatureDifference TAppAct(displayUnit="K")=
            Buildings.Utilities.Math.Functions.spliceFunction(
            pos=TAppCor,
            neg=TAppFreCon,
            x=y - yMin + yMin/20,
            deltax=yMin/20) "Approach temperature difference";
          Modelica.Units.SI.MassFraction FRWat=m_flow/mWat_flow_nominal
            "Ratio actual over design water mass flow ratio";
          Modelica.Units.SI.MassFraction FRAir=y
            "Ratio actual over design air mass flow ratio";

        protected
          package Water =  Buildings.Media.Water "Medium package for water";
          parameter Real FRWat0(min=0, start=1, fixed=false)
            "Ratio actual over design water mass flow ratio at nominal condition";
          parameter Modelica.Units.SI.Temperature TWatIn0(fixed=false)
            "Water inlet temperature at nominal condition";
          parameter Modelica.Units.SI.Temperature TWatOut_nominal(fixed=false)
            "Water outlet temperature at nominal condition";
          parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal(
            min=0,
            start=m_flow_nominal,
            fixed=false) "Nominal water mass flow rate";

          Modelica.Units.SI.TemperatureDifference dTMax(displayUnit="K") = T_a - TAir
            "Maximum possible temperature difference";
          Modelica.Units.SI.TemperatureDifference TAppCor(
            min=0,
            displayUnit="K")=
            Buildings.Fluid.HeatExchangers.CoolingTowers.Correlations.yorkCalc(
            TRan=TRan,
            TWetBul=TAir,
            FRWat=FRWat,
            FRAir=Buildings.Utilities.Math.Functions.smoothMax(
              x1=FRWat/bou.liqGasRat_max,
              x2=FRAir,
              deltaX=0.01)) "Approach temperature for forced convection";
          Modelica.Units.SI.TemperatureDifference TAppFreCon(
            min=0,
            displayUnit="K") = (1 - fraFreCon)*dTMax + fraFreCon*
            Buildings.Fluid.HeatExchangers.CoolingTowers.Correlations.yorkCalc(
            TRan=TRan,
            TWetBul=TAir,
            FRWat=FRWat,
            FRAir=1) "Approach temperature for free convection";

          final parameter Real fanRelPowDer[size(fanRelPow.r_V,1)](each fixed=false)
            "Coefficients for fan relative power consumption as a function of control signal";

          Modelica.Units.SI.Temperature T_a "Temperature in port_a";
          Modelica.Units.SI.Temperature T_b "Temperature in port_b";

          Modelica.Blocks.Sources.RealExpression QWat_flow(
            y = eps*m_flow*(
              Medium.specificEnthalpy(Medium.setState_pTX(
                p=port_b.p,
                T=TAir + TAppAct,
                X=inStream(port_b.Xi_outflow))) -
              inStream(port_a.h_outflow)))
            "Heat input into water"
            annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
        initial equation
          TWatOut_nominal = TAirInWB_nominal + TApp_nominal;
          TRan_nominal = TWatIn0 - TWatOut_nominal; // by definition of the range temp.
          TApp_nominal = Buildings.Fluid.HeatExchangers.CoolingTowers.Correlations.yorkCalc(
                           TRan=TRan_nominal, TWetBul=TAirInWB_nominal,
                           FRWat=FRWat0, FRAir=1); // this will be solved for FRWat0
          mWat_flow_nominal = m_flow_nominal/FRWat0;

          // Derivatives for spline that interpolates the fan relative power
          fanRelPowDer = Buildings.Utilities.Math.Functions.splineDerivatives(
                    x=fanRelPow.r_V,
                    y=fanRelPow.r_P,
                    ensureMonotonicity=Buildings.Utilities.Math.Functions.isMonotonic(x=fanRelPow.r_P,
                                                                                      strict=false));
          // Check validity of relative fan power consumption at y=yMin and y=1
          assert(cha.normalizedPower(per=fanRelPow, r_V=yMin, d=fanRelPowDer) > -1E-4,
            "The fan relative power consumption must be non-negative for y=0."
          + "\n   Obtained fanRelPow(0) = " + String(cha.normalizedPower(per=fanRelPow, r_V=yMin, d=fanRelPowDer))
          + "\n   You need to choose different values for the parameter fanRelPow.");
          assert(abs(1-cha.normalizedPower(per=fanRelPow, r_V=1, d=fanRelPowDer))<1E-4, "The fan relative power consumption must be one for y=1."
          + "\n   Obtained fanRelPow(1) = " + String(cha.normalizedPower(per=fanRelPow, r_V=1, d=fanRelPowDer))
          + "\n   You need to choose different values for the parameter fanRelPow."
          + "\n   To increase the fan power, change fraPFan_nominal or PFan_nominal.");

          // Check that a medium is used that has the same definition of enthalpy vs. temperature.
          // This is needed because below, T_a=Water.temperature needed to be hard-coded to use
          // Water.* instead of Medium.* in the function calls due to a bug in OpenModelica.
          assert(abs(Medium.specificEnthalpy_pTX(p=101325, T=273.15, X=Medium.X_default) -
                     Water.specificEnthalpy_pTX(p=101325, T=273.15, X=Medium.X_default)) < 1E-5 and
                 abs(Medium.specificEnthalpy_pTX(p=101325, T=293.15, X=Medium.X_default) -
                     Water.specificEnthalpy_pTX(p=101325, T=293.15, X=Medium.X_default)) < 1E-5,
                 "The selected medium has an enthalpy computation that is not consistent
  with the one in Buildings.Media.Water
  Use a different medium, such as Buildings.Media.Water.");
        equation
          // States at the inlet and outlet

          if allowFlowReversal then
            if homotopyInitialization then
              T_a=Water.temperature(Water.setState_phX(p=port_a.p,
                                         h=homotopy(actual=actualStream(port_a.h_outflow),
                                                    simplified=inStream(port_a.h_outflow)),
                                         X=homotopy(actual=actualStream(port_a.Xi_outflow),
                                                    simplified=inStream(port_a.Xi_outflow))));
              T_b=Water.temperature(Water.setState_phX(p=port_b.p,
                                         h=homotopy(actual=actualStream(port_b.h_outflow),
                                                    simplified=port_b.h_outflow),
                                         X=homotopy(actual=actualStream(port_b.Xi_outflow),
                                                    simplified=port_b.Xi_outflow)));

            else
              T_a=Water.temperature(Water.setState_phX(p=port_a.p,
                                         h=actualStream(port_a.h_outflow),
                                         X=actualStream(port_a.Xi_outflow)));
              T_b=Water.temperature(Water.setState_phX(p=port_b.p,
                                         h=actualStream(port_b.h_outflow),
                                         X=actualStream(port_b.Xi_outflow)));
            end if; // homotopyInitialization

          else // reverse flow not allowed
            T_a=Water.temperature(Water.setState_phX(p=port_a.p,
                                       h=inStream(port_a.h_outflow),
                                       X=inStream(port_a.Xi_outflow)));
            T_b=Water.temperature(Water.setState_phX(p=port_b.p,
                                       h=inStream(port_b.h_outflow),
                                       X=inStream(port_b.Xi_outflow)));
          end if;

          connect(QWat_flow.y, preHea.Q_flow)
            annotation (Line(points={{-59,-60},{-40,-60}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={
                Text(
                  extent={{-104,70},{-70,32}},
                  lineColor={0,0,127},
                  textString="TWB"),
                Text(
                  extent={{-50,4},{42,-110}},
                  lineColor={255,255,255},
                  fillColor={0,127,0},
                  fillPattern=FillPattern.Solid,
                  textString="York"),
                Rectangle(
                  extent={{-100,81},{-70,78}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{78,-58},{102,-62}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{78,-60},{82,-4}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{70,-58},{104,-96}},
                  lineColor={0,0,127},
                  textString="TLvg"),
                Rectangle(
                  extent={{70,56},{82,52}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{78,54},{82,80}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{64,114},{98,76}},
                  lineColor={0,0,127},
                  textString="PFan"),
                Ellipse(
                  extent={{0,62},{54,50}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-54,62},{0,50}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{78,82},{100,78}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-98,100},{-86,84}},
                  lineColor={0,0,127},
                  textString="y")}),
        Documentation(info="<html>
<p>
Model for a steady-state or dynamic cooling tower with variable speed fan using the York calculation for the
approach temperature at off-design conditions.
</p>
<h4>Thermal performance</h4>
<p>
To compute the thermal performance, this model takes as parameters
the approach temperature, the range temperature and the inlet air wet bulb temperature
at the design condition. Since the design mass flow rate (of the chiller condenser loop)
is also a parameter, these parameters define the rejected heat.
</p>
<p>
For off-design conditions, the model uses the actual range temperature and a polynomial
to compute the approach temperature for free convection and for forced convection, i.e.,
with the fan operating. The polynomial is valid for a York cooling tower.
If the fan input signal <code>y</code> is below the minimum fan revolution <code>yMin</code>,
then the cooling tower operates in free convection mode, otherwise it operates in
the forced convection mode.
For numerical reasons, this transition occurs in the range of <code>y &isin; [0.9*yMin, yMin]</code>.
</p>
<h4>Fan power consumption</h4>
<p>
The fan power consumption at the design condition can be specified as follows:
</p>
<ul>
<li>
The parameter <code>fraPFan_nominal</code> can be used to specify at the
nominal conditions the fan power divided by the water flow rate. The default value is
<i>275</i> Watts for a water flow rate of <i>0.15</i> kg/s.
</li>
<li>
The parameter <code>PFan_nominal</code> can be set to the fan power at nominal conditions.
If a user does not set this parameter, then the fan power will be
<code>PFan_nominal = fraPFan_nominal * m_flow_nominal</code>, where <code>m_flow_nominal</code>
is the nominal water flow rate.
</li>
</ul>
<p>
In the forced convection mode, the actual fan power is
computed as <code>PFan=fanRelPow(y) * PFan_nominal</code>, where
the default value for the fan relative power consumption at part load is
<code>fanRelPow(y)=y<sup>3</sup></code>.
In the free convection mode, the fan power consumption is zero.
For numerical reasons, the transition of fan power from the part load mode
to zero power consumption in the free convection mode occurs in the range
<code>y &isin; [0.9*yMin, yMin]</code>.
<br/>
To change the fan relative power consumption at part load in the forced convection mode,
points of fan controls signal and associated relative power consumption can be specified.
In between these points, the values are interpolated using cubic splines.
</p>
<h4>Comparison the cooling tower model of EnergyPlus</h4>
<p>
This model is similar to the model <code>Cooling Tower:Variable Speed</code> that
is implemented in the EnergyPlus building energy simulation program version 6.0.
The main differences are
</p>
<ol>
<li>
Not implemented are the basin heater power consumption, and
the make-up water usage.
</li>
<li>
The model has no built-in control to switch individual cells of the tower on or off.
To switch cells on or off, use multiple instances of this model, and use your own
control law to compute the input signal <code>y</code>.
</li>
</ol>
<h4>Assumptions and limitations</h4>
<p>
This model requires a medium that has the same computation of the enthalpy as
<a href=\"Buildings.Media.Water\">
Buildings.Media.Water</a>,
which computes
</p>
<p align=\"center\" style=\"font-style:italic;\">
 h = c<sub>p</sub> (T-T<sub>0</sub>),
</p>
<p>
where
<i>h</i> is the enthalpy,
<i>c<sub>p</sub> = 4184</i> J/(kg K) is the specific heat capacity,
<i>T</i> is the temperature in Kelvin and
<i>T<sub>0</sub> = 273.15</i> Kelvin.
If this is not the case, the simulation will stop with an error message.
The reason for this limitation is that as of January 2015, OpenModelica
failed to translate the model if <code>Medium.temperature()</code> is used
instead of
<code>Water.temperature()</code>.
</p>
<h4>References</h4>
<p>
<a href=\"http://www.energyplus.gov\">EnergyPlus 2.0.0 Engineering Reference</a>, April 9, 2007.
</p>
</html>",         revisions="<html>
<ul>
<li>
January 16, 2020, by Michael Wetter:<br/>
Refactored model to avoid mixing textual equations and connect statements.
</li>
<li>
December, 22, 2019, by Kathryn Hinkelman:<br/>
Corrected fan power consumption.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1691\">
issue 1691</a>.
</li>
<li>
November 3, 2016, by Michael Wetter:<br/>
Corrected wrong type for <code>FRWat0</code>, as this variable
can take on values that are bigger than <i>1</i>.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/567\">issue 567</a>.
</li>
<li>
January 2, 2015, by Michael Wetter:<br/>
Replaced <code>Medium.temperature()</code> with
<code>Water.temperature()</code> in order for the model
to work with OpenModelica.
Added an <code>assert</code> that stops the simulation if
an incompatible medium is used.
</li>
<li>
November 13, 2014, by Michael Wetter:<br/>
Added missing <code>each</code> keyword for <code>fanRelPowDer</code>.
Added regularization in computation of <code>TAppCor</code>.
Removed intermediate states with temperatures.
</li>
<li>
May 30, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
October 9, 2013, by Michael Wetter:<br/>
Simplified the implementation for the situation if
<code>allowReverseFlow=false</code>.
Avoided the use of the conditionally enabled variables <code>sta_a</code> and
<code>sta_b</code> as this was not proper use of the Modelica syntax.
</li>
<li>
September 29, 2011, by Michael Wetter:<br/>
Revised model to use cubic spline interpolation instead of a polynomial.
</li>
<li>
July 12, 2011, by Michael Wetter:<br/>
Introduced common base class for
<a href=\"modelica://Buildings.Fluid.HeatExchangers.CoolingTowers.YorkCalc\">Buildings.Fluid.HeatExchangers.CoolingTowers.YorkCalc</a>
and
<a href=\"modelica://Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach\">Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach</a>
so that they can be used as replaceable models.
</li>
<li>
May 12, 2011, by Michael Wetter:<br/>
Added binding equations for <code>Q_flow</code> and <code>mXi_flow</code>.
</li>
<li>
March 8, 2011, by Michael Wetter:<br/>
Removed base class and unused variables.
</li>
<li>
February 25, 2011, by Michael Wetter:<br/>
Revised implementation to facilitate scaling the model to different nominal sizes.
Removed parameter <code>mWat_flow_nominal</code> since it is equal to <code>m_flow_nominal</code>,
which is the water flow rate from the chiller condenser loop.
</li>
<li>
May 16, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
        end YorkCalc;
      end BaseClasses;
    end CoolingTower;

    package Control "Basic control models for waterside system"

      model PlantStageCondition
        "Stage checking for N chillers or N boilers"

        parameter Real thehol[n-1]
          "Threshold";

        parameter Real Cap[n]
          "Normal Cooling Capacity";

        parameter Integer n=3
          "Number of chillers";

        Real PLR
          "Part load ratio";
        Real cap_avi
          "Available cooling capacity";

        Modelica.Blocks.Interfaces.RealInput Loa "Load signal"
          annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
        Modelica.Blocks.Interfaces.RealInput Status[n] "Status signal"
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
        Modelica.Blocks.Interfaces.BooleanOutput On[n] "Staging up signal"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Modelica.Blocks.Interfaces.BooleanOutput Off[n] "Staging down signal"
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Modelica.Blocks.Interfaces.BooleanInput OnSin "On signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

      algorithm
          cap_avi :=0;
          for i in 1:n loop
           cap_avi :=cap_avi + Status[i]*Cap[i];
          end for;
          if cap_avi>0.01 then
          PLR:=Loa/cap_avi;
          else
          PLR:=0;
          end if;
          On[1] :=OnSin;
          Off[1] :=not OnSin;

          for i in 2:n loop
              On[i] :=PLR > thehol[i - 1] and Status[i - 1] > 0;
          end for;

          for i in 2:n loop
              Off[i] :=PLR*(sum(Status)/(sum(Status) - 1 + 0.0001)) < thehol[i - 1]
             and Status[i] > 0;
          end for;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-56,42},{58,-42}},
                lineColor={0,0,255},
                textString="StageCheck"),
              Text(
                extent={{-44,-144},{50,-112}},
                lineColor={0,0,255},
                textString="%name")}),
          Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end PlantStageCondition;

      model PlantStageN "Combined stage controller for N chillers or N boilers"
        parameter Real tWai "Waiting time";

        parameter Real thehol[n-1] "Threshold";

        parameter Real Cap[n] "Rated Plant Capacity";

        parameter Integer n=3
          "the number of chillers";

        Modelica.Blocks.Interfaces.RealOutput y[n]( each start=0)
          "Output of stage control"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput
                                             On "On signal"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput sta[n] "Compressor speed ratio"
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
        Modelica.Blocks.Interfaces.RealInput loa
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        PlantStageCondition plantNStageCondition(
          thehol=thehol,
          n=n,
          Cap=Cap) annotation (Placement(transformation(extent={{-60,-16},{
                  -40,4}})));
        BaseClasses.StageN nSta(tWai=tWai, n=n)
          annotation (Placement(transformation(extent={{-8,-18},{12,2}})));
      equation

        for i in 1:n loop
           y[i] =if i <= integer(nSta.y) then 1 else 0;
        end for;

        connect(plantNStageCondition.OnSin, On) annotation (Line(
            points={{-62,-6},{-80,-6},{-80,80},{-120,80}},
            color={255,0,255}));
        connect(plantNStageCondition.Loa,loa)  annotation (Line(
            points={{-62,0},{-120,0}},
            color={0,0,127}));
        connect(plantNStageCondition.Status, sta) annotation (Line(points={{-62,
                -12},{-80,-12},{-80,-80},{-120,-80}}, color={0,0,127}));
        connect(plantNStageCondition.Off, nSta.Off) annotation (Line(points={
                {-39,-10},{-24,-10},{-24,-14},{-10,-14}}, color={255,0,255}));
        connect(plantNStageCondition.On, nSta.On)
          annotation (Line(points={{-39,-2},{-10,-2}}, color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-56,42},{58,-42}},
                lineColor={0,0,255},
                textString="ChiSta"),
              Text(
                extent={{-44,-144},{50,-112}},
                lineColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-152,106},{148,146}},
                textString="%name",
                textColor={0,0,255})}),
          Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end PlantStageN;

      model PumpStageCondition "Stage checking for N pumps"

        parameter Real thehol_up "Threshold for staging up";

          parameter Real thehol_down "Threshold for staging down";

        parameter Integer n=3
          "the number of chillers";

        Modelica.Blocks.Interfaces.RealInput Status[n] "On signal"
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
        Modelica.Blocks.Interfaces.BooleanOutput On[n]
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Modelica.Blocks.Interfaces.BooleanOutput Off[n]
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Modelica.Blocks.Interfaces.BooleanInput OnSin "On signal"
          annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
      equation

          On[1] =  OnSin;
          Off[1] =  not OnSin;
          for i in 2:n loop
           On[i] = Status[i-1]>thehol_up and Status[i-1]>0;
          end for;

          for i in 2:n loop
           Off[i] = Status[i]<thehol_down*0.9 and Status[i]>0;
          end for;

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-56,42},{58,-42}},
                lineColor={0,0,255},
                textString="StageCheck"),
              Text(
                extent={{-44,-144},{50,-112}},
                lineColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-152,104},{148,144}},
                textString="%name",
                textColor={0,0,255})}),
          Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end PumpStageCondition;

      model PumpStageN "Combined stage controller for N pumps"
        parameter Real tWai "Waiting time";

        parameter Real thehol_up = 0.9 "Threshold for staging up";

        parameter Real thehol_down = 0.6 "Threshold for staging down";

        parameter Integer n=3
          "the number of pumps";

        Modelica.Blocks.Interfaces.RealOutput y[n]
          "Output of stage control"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput
                                             On "On signal"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput sta[n] "Compressor speed ratio"
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
        PumpStageCondition pumNStaCon(
          n=n,
          thehol_up=thehol_up,
          thehol_down=thehol_down)
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        BaseClasses.StageN pumNSta(tWai=tWai, n=n)
          annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
      equation

          for i in 1:n loop
          y[i]=if i > pumNSta.y then 0 else 1;

          end for;

        connect(pumNStaCon.OnSin, On) annotation (Line(points={{-62,6},{-80,6},
                {-80,80},{-120,80}}, color={255,0,255}));
        connect(pumNStaCon.Status, sta) annotation (Line(points={{-62,-6},{-80,
                -6},{-80,-80},{-120,-80}}, color={0,0,127}));
        connect(pumNStaCon.Off, pumNSta.Off) annotation (Line(points={{-39,-4},
                {-20,-4},{-20,-6},{-10,-6}}, color={255,0,255}));
        connect(pumNStaCon.On, pumNSta.On) annotation (Line(points={{-39,4},{
                -20,4},{-20,6},{-10,6}}, color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),           Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-54,42},{60,-42}},
                lineColor={0,0,255},
                textString="PumSta"),
              Text(
                extent={{-154,102},{146,142}},
                textString="%name",
                textColor={0,0,255})}),
          Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
      end PumpStageN;

      package BaseClasses

        block MultiSwitch
          "Set Real expression that is associated with the first active input signal"

          input Real expr[nu]=fill(0.0, nu)
            "y = if u[i] then expr[i] else y_default (time varying)"
            annotation (Dialog);
          parameter Real y_default=0.0
            "Default value of output y if all u[i] = false";

          parameter Integer nu(min=0) = 0 "Number of input connections"
            annotation (Dialog(connectorSizing=true), HideResult=true);
          parameter Integer precision(min=0) = 3
            "Number of significant digits to be shown in dynamic diagram layer for y"
            annotation (Dialog(tab="Advanced"));

          Modelica.Blocks.Interfaces.BooleanVectorInput u[nu]
            "Set y = expr[i], if u[i] = true"
            annotation (Placement(transformation(extent={{-110,30},{-90,-30}})));
          Modelica.Blocks.Interfaces.RealOutput y "Output depending on expression"
            annotation (Placement(transformation(extent={{300,-10},{320,10}})));

        protected
          Integer firstActiveIndex;

        equation
          firstActiveIndex = Modelica.Math.BooleanVectors.firstTrueIndex(u);
          y = if firstActiveIndex == 0 then y_default else expr[firstActiveIndex];
          annotation (
            defaultComponentName="multiSwitch1",
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{300,
                    100}}), graphics={
                Rectangle(
                  extent={{-100,-51},{300,50}},
                  lineThickness=5.0,
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid,
                  borderPattern=BorderPattern.Raised),
                Text(
                  extent={{-86,16},{295,-17}},
                  lineColor={0,0,0},
                  fillColor={255,246,238},
                  fillPattern=FillPattern.Solid,
                  textString="%expr"),
                Text(
                  extent={{310,-25},{410,-45}},
                  lineColor={0,0,0},
                  textString=DynamicSelect(" ", String(
                        y,
                        minimumLength=1,
                        significantDigits=precision))),
                Text(
                  extent={{-100,-60},{300,-90}},
                  lineColor={0,0,0},
                  textString="else: %y_default"),
                Text(
                  extent={{-100,100},{300,60}},
                  textString="%name",
                  lineColor={0,0,255})}),
            Documentation(info="<html>
<p>
This block has a vector of Boolean input signals u[nu] and a vector of
(time varying) Real expressions expr[nu]. The output signal y is
set to expr[i], if i is the first element in the input vector u that is true. If all input signals are
false, y is set to parameter \"y_default\".
</p>

<blockquote><pre>
  // Conceptual equation (not valid Modelica)
  i = 'first element of u[:] that is true';
  y = <b>if</b> i==0 <b>then</b> y_default <b>else</b> expr[i];
</pre></blockquote>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>

</html>"));
        end MultiSwitch;

        model StageN "Stage controller for N states"
          parameter Real tWai "Waiting time";

          parameter Integer n=3
            "the number of chillers";

          Modelica.StateGraph.InitialStepWithSignal
                                    AllOff(
            nOut=1, nIn=1)
                   "Both of the two compressors are off"
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=-90,
                origin={0,72})));
          Modelica.Blocks.Interfaces.BooleanInput On[n] "On signal"
            annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
          Modelica.StateGraph.StepWithSignal iOn[n-1](nIn=2, nOut=2) annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={0,2})));
          Modelica.StateGraph.TransitionWithSignal
                                         Off2One               annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-50,44})));
          Modelica.StateGraph.TransitionWithSignal
                                         One2Off                   annotation (
              Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={52,48})));
          Modelica.StateGraph.StepWithSignal nOn(nOut=1, nIn=1)
                                                         annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={0,-80})));
          Modelica.StateGraph.TransitionWithSignal
                                         nmin12n(
            enableTimer=true,
            waitTime=tWai)                                           annotation (
              Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-50,-54})));
          Modelica.StateGraph.TransitionWithSignal
                                         N2Nmin1(
            waitTime=tWai,
            enableTimer=true)                                 annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={40,-60})));
          inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
            annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
          BaseClasses.MultiSwitch
                      multiSwitch(nu=n+1, expr=linspace(
                0,
                n,
                n + 1))
            annotation (Placement(transformation(extent={{76,-26},{92,-6}})));
          Modelica.StateGraph.TransitionWithSignal
                                         imin12i[n - 2](
            enableTimer=true,
            waitTime=tWai)  annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-50,0})));
          Modelica.StateGraph.TransitionWithSignal
                                         i2imin1[n - 2](
            waitTime=tWai,
            enableTimer=true)  annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={66,0})));
          Modelica.Blocks.Interfaces.BooleanInput Off[n] "On signal"
            annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
          Modelica.Blocks.Interfaces.RealOutput y "Output depending on expression"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        equation

          connect(AllOff.outPort[1], Off2One.inPort) annotation (Line(points={{0,61.5},{
                  0,61.5},{0,54},{0,52},{-50,52},{-50,48}},  color={0,0,0}));
          connect(nmin12n.outPort, nOn.inPort[1]) annotation (Line(points={{-50,-55.5},{
                  -50,-62},{0,-62},{0,-66},{6.66134e-016,-66},{6.66134e-016,-69}},
                                             color={0,0,0}));
          connect(nOn.outPort[1], N2Nmin1.inPort) annotation (Line(points={{-6.66134e-016,
                  -90.5},{-6.66134e-016,-98},{40,-98},{40,-64}},
                                                  color={0,0,0}));
          connect(One2Off.outPort, AllOff.inPort[1]) annotation (Line(points={{52,49.5},
                  {52,49.5},{52,86},{52,88},{1.9984e-015,88},{1.9984e-015,83}}, color={
                  0,0,0}));

          connect(Off2One.outPort, iOn[1].inPort[1]) annotation (Line(points={{-50,42.5},
                  {-50,42.5},{-50,26},{-0.5,26},{-0.5,13}}, color={0,0,0}));
          connect(iOn[1].outPort[2], One2Off.inPort) annotation (Line(points={{0.25,
                  -8.5},{2,-8.5},{2,-20},{52,-20},{52,44}},
                                                       color={0,0,0}));
          connect(nmin12n.inPort, iOn[n-1].outPort[1]) annotation (Line(points={{-50,-50},
                  {-50,-40},{-0.25,-40},{-0.25,-8.5}},  color={0,0,0}));

          connect(AllOff.active, multiSwitch.u[1]);
          for i in 1:n-1 loop
            connect(iOn[i].active, multiSwitch.u[i + 1]);
          end for;
          connect(nOn.active, multiSwitch.u[n + 1]);

          connect(Off2One.condition, On[1]);
            for i in 1:n-2 loop
             connect(imin12i[i].condition, On[i+1]);
            end for;
          connect(nmin12n.condition, On[n]);

          connect(One2Off.condition, Off[1]);
            for i in 1:n-2 loop
             connect(i2imin1[i].condition, Off[i+1]);
            end for;
          connect(N2Nmin1.condition, Off[n]);
          for i in 1:n-2 loop
             connect(iOn[i].outPort[1], imin12i[i].inPort);
             connect(imin12i[i].outPort, iOn[i+1].inPort[1]);
             connect(i2imin1[i].inPort, iOn[i+1].outPort[2]);
             connect(i2imin1[i].outPort, iOn[i].inPort[2]);
          end for;

          connect(N2Nmin1.outPort, iOn[n-1].inPort[2]) annotation (Line(points={{40,
                  -58.5},{40,-58.5},{40,16},{0.5,16},{0.5,13}},
                                                         color={0,0,0}));
          connect(multiSwitch.y, y) annotation (Line(
              points={{92.4,-16},{96,-16},{98,-16},{98,0},{110,0}},
              color={0,0,127},
              pattern=LinePattern.Dash));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}})),           Icon(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                  Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-56,42},{58,-42}},
                  lineColor={0,0,255},
                  textString="CompressorStage"),
                Text(
                  extent={{-44,-144},{50,-112}},
                  lineColor={0,0,255},
                  textString="%name"),
                Text(
                  extent={{-150,106},{150,146}},
                  textString="%name",
                  textColor={0,0,255})}),
            Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
        end StageN;
      end BaseClasses;

    end Control;

    package Network

      model PipeNetwork "Water distribution network"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
        parameter Modelica.Units.SI.Pressure PreDroMai1
          "Pressure drop 1 across the duct";

        parameter Modelica.Units.SI.Pressure PreDroMai2
          "Pressure drop 2 across the main duct";

        parameter Modelica.Units.SI.Pressure PreDroBra1
          "Pressure drop 1 across the duct branch 1";

        parameter Modelica.Units.SI.Pressure PreDroBra2
          "Pressure drop 1 across the duct branch 2";

        parameter Modelica.Units.SI.Pressure PreDroBra3
          "Pressure drop 1 across the duct branch 3";

        parameter Modelica.Units.SI.MassFlowRate mFloRat1
          "mass flow rate for the first branch1";

        parameter Modelica.Units.SI.MassFlowRate mFloRat2
          "mass flow rate for the first branch2";

        parameter Modelica.Units.SI.MassFlowRate mFloRat3
          "mass flow rate for the first branch3";

        Buildings.Fluid.FixedResistances.Junction junSup1(m_flow_nominal={mFloRat1 + mFloRat2 + mFloRat3,-mFloRat2-mFloRat3,-
              mFloRat1}, redeclare package Medium = Medium,
          dp_nominal={PreDroMai1/2,PreDroMai2/2,PreDroBra1/2})
          annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
        Buildings.Fluid.FixedResistances.Junction junRet1(redeclare package
            Medium =                                                                 Medium, m_flow_nominal={mFloRat2 + mFloRat3,-mFloRat1-mFloRat2-mFloRat3,mFloRat1},
          dp_nominal={PreDroMai2/2,PreDroMai1/2,PreDroBra1/2})
                                                      annotation (Placement(transformation(extent={{-70,-70},{-90,-50}})));
        Buildings.Fluid.FixedResistances.Junction junRet2( redeclare package
            Medium =                                                                  Medium, m_flow_nominal={mFloRat3,-mFloRat2-mFloRat3,mFloRat2},
          dp_nominal={PreDroBra3/2,PreDroMai2/2,PreDroBra2/2})
                                                      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
        Buildings.Fluid.FixedResistances.Junction junSup2(m_flow_nominal={mFloRat2 + mFloRat3,-mFloRat3,-
              mFloRat2}, redeclare package Medium = Medium,
          dp_nominal={PreDroMai2/2,PreDroBra3/2,PreDroBra2/2})
                            annotation (Placement(transformation(extent={{-10,30},{10,50}})));

        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
              Medium) "Second port, typically outlet"
                                          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
              Medium) "Second port, typically outlet"
                                          annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
        Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package
            Medium =                                                                  Medium)
                                                       annotation (Placement(transformation(extent={{-80,-26},{-60,-6}})));
        Modelica.Fluid.Interfaces.FluidPorts_b ports_b[3](redeclare package
            Medium =                                                                 Medium)
          annotation (Placement(transformation(extent={{90,6},{110,86}})));
        Modelica.Fluid.Interfaces.FluidPorts_a ports_a[3](redeclare package
            Medium =                                                                 Medium)
          annotation (Placement(transformation(extent={{90,-102},{110,-22}})));
        Modelica.Blocks.Interfaces.RealOutput p "Pressure at port"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        connect(junSup1.port_2, junSup2.port_1) annotation (Line(
            points={{-70,40},{-10,40}},
            color={0,127,255},
            thickness=1));
        connect(junRet2.port_2, junRet1.port_1)
          annotation (Line(
            points={{-10,-60},{-10,-60},{-70,-60}},
            color={0,127,255},
            thickness=1));
        connect(junRet1.port_2, port_b) annotation (Line(
            points={{-90,-60},{-100,-60}},
            color={0,127,255},
            thickness=1));
        connect(junSup1.port_1, port_a) annotation (Line(
            points={{-90,40},{-100,40}},
            color={0,127,255},
            thickness=1));

        connect(ports_b, ports_b) annotation (Line(points={{100,46},{100,46}}, color={0,127,255}));
        connect(junSup2.port_3, ports_b[2])
          annotation (Line(
            points={{0,30},{0,30},{0,8},{84,8},{84,46},{100,46}},
            color={0,127,255},
            thickness=1));
        connect(junSup1.port_3, ports_b[1])
          annotation (Line(
            points={{-80,30},{-80,30},{-80,0},{90,0},{90,19.3333},{100,19.3333}},
            color={0,127,255},
            thickness=1));
        connect(junRet2.port_3, ports_a[2])
          annotation (Line(
            points={{0,-70},{0,-86},{100,-86},{100,-62}},
            color={0,127,255},
            thickness=1));
        connect(junRet1.port_3, ports_a[1])
          annotation (Line(
            points={{-80,-70},{-80,-70},{-80,-94},{100,-94},{100,-88.6667}},
            color={0,127,255},
            thickness=1));
        connect(junSup2.port_2, ports_b[3])
          annotation (Line(
            points={{10,40},{100,40},{100,72.6667}},
            color={0,127,255},
            thickness=1));
        connect(junRet2.port_1, ports_a[3])
          annotation (Line(
            points={{10,-60},{100,-60},{100,-35.3333}},
            color={0,127,255},
            thickness=1));
        connect(senRelPre.port_a, port_a) annotation (Line(points={{-80,-16},{-94,-16},{-94,40},{-100,40}}, color={0,127,
                255}));
        connect(senRelPre.port_b, port_b)
          annotation (Line(points={{-60,-16},{-48,-16},{-48,-40},{-94,-40},{-94,-60},{-100,-60}}, color={0,127,
                255}));
        connect(senRelPre.p_rel, p) annotation (Line(
            points={{-70,-25},{-70,-34},{90,-34},{90,0},{110,0}},
            color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(points={{-90,40},{80,40}}, color={0,127,255}),
              Line(points={{-90,-60},{80,-60}}, color={0,127,255}),
              Line(points={{80,40},{80,-60}}, color={0,127,255}),
              Line(points={{50,40},{50,-60}}, color={0,127,255}),
              Line(points={{20,40},{20,-60}}, color={0,127,255}),
              Text(
                extent={{-148,106},{152,146}},
                textString="%name",
                textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
      end PipeNetwork;
    end Network;
  annotation (Documentation(info="<html>
<p>This package contains component models that are used to construct the chillers with two compressors.</p>
</html>"));
  end WaterSide;
annotation (Documentation(info="<html>
<p>This package contains component models with controls for the large office testcase. </p>
</html>"));
end Component;
