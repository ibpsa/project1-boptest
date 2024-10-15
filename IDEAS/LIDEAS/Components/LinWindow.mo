within IDEAS.LIDEAS.Components;
model LinWindow "Extension of the window model to allow linearization"
  extends IDEAS.Buildings.Components.Window(
    redeclare IDEAS.LIDEAS.Components.BaseClasses.LinWindowResponse solWin(
      linearise=sim.linearise,
      createOutputs=sim.createOutputs));
  parameter Integer indexWindow = 1 "Index of this window"
    annotation(Dialog(group="Linearisation"),Evaluate=true);
protected
  IDEAS.Buildings.Components.Interfaces.WindowBus winBusOut if sim.createOutputs "Window bus to connecto to sim.winBusOut";
  outer input IDEAS.Buildings.Components.Interfaces.WindowBus[sim.nWindow]
    winBusIn if sim.linearise annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=90,
        origin={80,-50})));
equation
  connect(solWin.AbsQFlowInput, winBusIn[indexWindow].AbsQFlow) annotation (Line(
      points={{10.4,-41},{34.2,-41},{34.2,-49.9},{80.1,-49.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solWin.iSolDirInput, winBusIn[indexWindow].iSolDir) annotation (Line(
      points={{10.4,-45},{32.2,-45},{32.2,-49.9},{80.1,-49.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solWin.iSolDifInput, winBusIn[indexWindow].iSolDif) annotation (Line(
      points={{10.4,-49},{30.2,-49},{30.2,-49.9},{80.1,-49.9}},
      color={0,0,127},
      smooth=Smooth.None));
  if sim.createOutputs then
    connect(sim.winBusOut[indexWindow], winBusOut);
    connect(solWin.AbsQFlowOutput, winBusOut.AbsQFlow);
    connect(solWin.iSolDirOutput, winBusOut.iSolDir);
    connect(solWin.iSolDifOutput, winBusOut.iSolDif);
  end if;
  annotation (Documentation(info="<html>
<p> This model extends the <code>IDEAS.Building.Components.Window</code> model
and it adds two propsBusses. The propsBusses are used to transform the heat flows
through the windows due to solar radiation into inputs (for linearization purposes)
and into outputs (to pre-compute the inputs of the linearized model).
</p>
</html>", revisions="<html>
<ul>
<li>
August 21, 2018 by Damien Picard: <br/> 
Added documentation.
</li>
</ul>
</html>"));
end LinWindow;
