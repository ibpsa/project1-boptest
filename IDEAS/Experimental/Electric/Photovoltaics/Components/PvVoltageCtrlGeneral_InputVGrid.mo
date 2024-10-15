within IDEAS.Experimental.Electric.Photovoltaics.Components;
model PvVoltageCtrlGeneral_InputVGrid
  "Basic controller, with fixed shut down time, with RealInput for grid voltage"

  //extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Real VMax=253;
  parameter Real timeOff=300;
  parameter Integer numPha=1
    "1 or 3, just indicates if it's a single or 3 phase PV system";

  Boolean switch(start=true, fixed=true) "if true, system is producing";

  Modelica.Blocks.Interfaces.RealInput PInit annotation (Placement(
        transformation(extent={{-128,30},{-88,70}}), iconTransformation(extent=
            {{-108,50},{-88,70}})));
  Modelica.Blocks.Interfaces.RealInput QInit annotation (Placement(
        transformation(extent={{-128,-10},{-88,30}}), iconTransformation(extent=
           {{-108,10},{-88,30}})));
  Modelica.Blocks.Interfaces.RealOutput PFinal
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Modelica.Blocks.Interfaces.RealOutput QFinal
    annotation (Placement(transformation(extent={{96,10},{116,30}})));

  discrete Real restartTime(start=-1, fixed=true)
    "system is off until time>restartTime";

public
  Modelica.Blocks.Interfaces.RealInput VGrid annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-104}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100})));
equation

  when {VGrid > VMax,time > pre(restartTime)} then
    if VGrid > VMax and time > pre(restartTime) then
      // some voltage limit was crossed while system was on.  Switch off and set restarttime
      switch = false;
      restartTime = time + timeOff;
    elseif VGrid > VMax and time < pre(restartTime) then
      // some voltage limit was crossed during an offtime: keep off but don't change the restarTime
      switch = false;
      restartTime = pre(restartTime);
    else
      switch = true;
      restartTime = -1;
    end if;
  end when;

  if pre(switch) then
    PFinal = PInit;
  else
    PFinal = 0;
  end if;

  QFinal = QInit;

  annotation (Diagram(graphics), Icon(graphics={Ellipse(extent={{-60,10},{-40,-10}},
          lineColor={0,0,127}),Ellipse(extent={{40,10},{60,-10}}, lineColor={0,
          0,127}),Line(
          points={{-100,0},{-60,0}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{60,0},{100,0}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{-40,0},{36,20}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{-20,-80},{20,-80}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{0,-80},{0,10}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{-100,80},{-100,-80}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{100,80},{100,-80}},
          color={0,0,127},
          smooth=Smooth.None)}));
end PvVoltageCtrlGeneral_InputVGrid;
