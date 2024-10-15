within IDEAS.Fluid.HeatPumps;
model HP_WaterWater_TSet
  "A water (or brine) to water heat pump with temperature setpoint"
  extends IDEAS.Fluid.HeatPumps.BaseClasses.PartialHeatPump(final use_TSet = true);

  Modelica.Blocks.Sources.RealExpression TSetLimit(y=TSet - vol2.heatPort.T)
    annotation (Placement(transformation(extent={{-34,-10},{8,10}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Condensor temperature setpoint"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,108}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={-50,100})));

  Modelica.Blocks.Logical.Hysteresis hysteresisTSetLimit(uLow=uLow, uHigh=uHigh)
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  parameter Real uLow=-2.5
    "Lower bound of the hysteresis in the tempeature controller";
  parameter Real uHigh=2.5
    "Upper bound of the hysteresis in the tempeature controller";
equation
  connect(on_TSetControl_internal, hysteresisTSetLimit.y);

  connect(TSetLimit.y, hysteresisTSetLimit.u) annotation (Line(
      points={{10.1,0},{20,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135})}),
    Documentation(info="<html>
<p>This model implements a heat pump as described in<a href=\"modelica://IDEAS.Fluid.HeatPumps.BaseClasses.PartialHeatPump\"> IDEAS.Fluid.HeatPumps.BaseClasses.PartialHeatPump</a>. The heat pump is switched on or off based on a temperature set point.</p>
</html>", revisions="<html>
<ul>
<li>November 2014 by Filip Jorissen:<br/> 
Added documentation
</li>
</ul>
</html>"));
end HP_WaterWater_TSet;
