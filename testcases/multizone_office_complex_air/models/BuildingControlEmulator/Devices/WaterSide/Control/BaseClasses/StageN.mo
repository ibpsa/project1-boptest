within BuildingControlEmulator.Devices.WaterSide.Control.BaseClasses;
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
          textString="%name")}),
    Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end StageN;
