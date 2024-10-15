within IDEAS.Experimental.Electric.Photovoltaics.Components;
model PvVoltageCtrlGeneral "Basic controller, with fixed shut down time"

  parameter Real VMax=248;
  parameter Real timeOff=300;
  parameter Integer numPha=1
    "1 or 3, just indicates if it's a single or 3 phase PV system";

  Boolean switch(start=true, fixed=true) "if true, system is producing";

  Modelica.Blocks.Interfaces.RealInput PInit
    annotation (Placement(transformation(extent={{-120,20},{-80,60}}),
        iconTransformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput QInit
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}}),
        iconTransformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealOutput PFinal
    annotation (Placement(transformation(extent={{90,30},{110,50}}),
        iconTransformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput QFinal
    annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
        iconTransformation(extent={{90,-70},{110,-50}})));

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pin[
    numPha] annotation (Placement(transformation(extent={{50,-110},{70,-90}})));

protected
  Real VGrid;
  discrete Real restartTime(start=-1, fixed=true)
    "system is off until time>restartTime";

equation
  VGrid = max(Modelica.ComplexMath.'abs'(pin.v));
  when {VGrid > VMax,time > pre(restartTime)} then
    if VGrid > VMax then
      switch = false;
      restartTime = time + timeOff;
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
  for i in 1:numPha loop
    pin[i].i = 0 + 0*Modelica.ComplexMath.j;
  end for;

  annotation (Diagram(graphics), Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-40,40},{-100,40}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{-40,-60},{-100,-60}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{100,40},{40,40}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{100,-60},{40,-60}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{-40,-60},{40,-40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-40,40},{40,60}},
          color={0,0,0},
          smooth=Smooth.None),
        Ellipse(
          extent={{-44,44},{-36,36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-44,-56},{-36,-64}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{36,44},{44,36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{36,-56},{44,-64}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-6,-52},{-6,100}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{6,-48},{6,100}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-20,100},{20,100}},
          color={95,95,95},
          smooth=Smooth.None)}));
end PvVoltageCtrlGeneral;
