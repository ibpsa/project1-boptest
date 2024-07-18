within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover;
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
