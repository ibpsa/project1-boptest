within IDEAS.Controls.ControlHeating;
model RunningMeanTemperatureEN15251
  "Calculate the running mean temperature of 7 days, acccording to norm EN15251"

   discrete Modelica.Blocks.Interfaces.RealOutput TRm(unit="K",displayUnit = "degC")
    "Running mean average temperature"
     annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Modelica.Blocks.Sources.RealExpression TAmb(y=sim.Te)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  outer BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

protected
  parameter Modelica.SIunits.Time t_start(fixed=false) "Start time of the model";
  parameter Real coeTRm[7] = {1, 0.8, 0.6, 0.5, 0.4, 0.3, 0.2}./3.8
    "weighTAmb.yg coefficient for the running average";
  discrete Real[7] TAveDay(each unit="K",each displayUnit = "degC")
    "Vector with the average day temperatures of the previous nTermRm days";
  Real intTAmb "integral of TAmb.y";


initial equation
  intTAmb=0;
  t_start = time;
  TAveDay=ones(7).*sim.Te;
  TRm=sim.Te;
equation
  der(intTAmb) =  TAmb.y;
algorithm
  when sample(t_start+24*3600,24*3600) then
    // Update of TAveDay
    for i in 2:7 loop
      TAveDay[i] := pre(TAveDay[i-1]);
    end for;
    TAveDay[1] := intTAmb / 24/3600;
    TRm :=TAveDay*coeTRm;
  end when;

equation
    // reinitialisation of the intTAmb
  when sample(t_start+24*3600,24*3600) then
    reinit(intTAmb,0);
  end when;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=864000),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{100,100},{-100,-100}},
          lineColor={100,100,100},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Line(
          points={{0,100},{98,0},{0,-100}},
          color={100,100,100},
          smooth=Smooth.None),
        Text(
          extent={{-100,140},{100,100}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-48,32},{58,-26}},
          lineColor={0,0,255},
          textString="EN15251")}),
Documentation(revisions="<html>
<ul>
<li>
April 17, 2018, by Damien Picard:<br/>
Add t_start in sample to compute correctly for non zero initial time.<br/>
Use sim.Te as initialization instead of an arbitrary value of 283.15K.
</li>
<li>
January 19, 2015, by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end RunningMeanTemperatureEN15251;
