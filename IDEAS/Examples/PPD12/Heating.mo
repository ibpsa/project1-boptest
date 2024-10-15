within IDEAS.Examples.PPD12;
model Heating "Ppd 12 example model"
  extends IDEAS.Examples.PPD12.BaseClasses.HeatingNoControl;
  BaseClasses.Thermostat the "Custom thermostat"
    annotation (Placement(transformation(extent={{240,-80},{260,-60}})));
  Modelica.Blocks.Math.BooleanToReal booToRea(                realFalse=0, realTrue=
       100000)
    "Conversion block of control signal to pump pressure set point"
    annotation (Placement(transformation(extent={{280,-80},{300,-60}})));
  Modelica.Blocks.Continuous.Integrator EHea(k=1/3600000) "Heat energy meter"
    annotation (Placement(transformation(extent={{380,-62},{400,-42}})));
  Modelica.Blocks.Sources.Constant Thea(k=273.15 + 70)
    "Supply water temperature set point"
    annotation (Placement(transformation(extent={{400,-104},{380,-84}})));
  Modelica.Blocks.Continuous.Integrator EGas(k=1/3600000) "Gas energy meter"
    annotation (Placement(transformation(extent={{380,-20},{400,0}})));
  Modelica.Blocks.Sources.RealExpression reaExpQGas(y=QGas)
    "Real expression for gas power use"
    annotation (Placement(transformation(extent={{340,-20},{360,0}})));
equation

  connect(the.u, living.TSensor) annotation (Line(points={{239.4,-70},{-47,-70},
          {-47,44}},   color={0,0,127}));
  connect(Thea.y, hea.TSet) annotation (Line(points={{379,-94},{372,-94},{372,
          -102}}, color={0,0,127}));
  connect(the.y, booToRea.u)
    annotation (Line(points={{260.6,-70},{278,-70}}, color={255,0,255}));
  connect(booToRea.y, pump.dp_in)
    annotation (Line(points={{301,-70},{320,-70},{320,-98}}, color={0,0,127}));
  connect(EHea.u, hea.Q_flow) annotation (Line(points={{378,-52},{342,-52},{342,
          -102},{349,-102}}, color={0,0,127}));
  connect(reaExpQGas.y, EGas.u)
    annotation (Line(points={{361,-10},{378,-10}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -200},{400,240}},
        initialScale=0.1), graphics={
        Line(points={{-72,-100},{-100,-100},{-100,100},{-68,100},{-68,-10},{0,-10},
              {0,100},{-68,100}}, color={28,108,200}),
        Line(points={{-72,-98}}, color={28,108,200}),
        Line(points={{-72,-100},{-72,-50},{0,-50},{0,-8}}, color={28,108,200}),
        Line(points={{-60,-10},{-100,-10}}, color={28,108,200}),
        Line(points={{-72,-100},{0,-100},{0,-50}}, color={28,108,200}),
        Line(points={{60,100},{160,100},{160,46},{60,46},{60,100}}, color={28,108,
              200}),
        Line(
          points={{92,100},{92,46}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(points={{60,46},{160,46},{160,-8},{60,-8},{60,46}}, color={28,108,200}),
        Line(points={{92,46},{92,-8}}, color={28,108,200}),
        Line(points={{220,100},{320,100},{320,46},{220,46},{220,100}},
                                                                    color={28,108,
              200}),
        Line(points={{220,46},{320,46},{320,-8},{220,-8},{220,46}}, color={28,108,
              200}),
        Line(
          points={{-68,46},{0,46}},
          color={28,108,200},
          pattern=LinePattern.Dash)}),
                                Icon(coordinateSystem(
        preserveAspectRatio=false,
        initialScale=0.1)),
    experiment(
      StopTime=500000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_fixedstepsize=10,
      __Dymola_Algorithm="Euler"),
    __Dymola_Commands,
    Documentation(info="<html>
<p>
Example model of a partially renovated terraced house in Belgium.
This model adds the building heating system.
</p>
</html>", revisions="<html>
<ul>
<li>
October 26, 2018, by Filip Jorissen:<br/>
Refactored using partials for
<a href=\"https://github.com/open-ideas/IDEAS/issues/942\">#942</a>.
</li>
<li>
May 21, 2018, by Filip Jorissen:<br/>
Using model for air flow through vertical cavity.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/822\">#822</a>.
</li>
<li>
January 9, 2017 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end Heating;
