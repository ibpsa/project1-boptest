within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide;
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
