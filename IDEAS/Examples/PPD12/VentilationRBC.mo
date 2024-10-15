within IDEAS.Examples.PPD12;
model VentilationRBC "Ppd 12 example model using rule based controller"
  extends IDEAS.Examples.PPD12.BaseClasses.VentilationNoControl(
    fanRet(inputType=IDEAS.Fluid.Types.InputType.Constant),
    fanSup(inputType=IDEAS.Fluid.Types.InputType.Constant),
    hallway(hasCavityA=true, hasCavityD=true),
    Diner(hasCavityA=true, hasCavityC=true),
    sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort),
    bathRoom(hasCavityC=true),
    stairWay(hasCavityC=true),
    bedRoom2(hasCavityA=true));

  Modelica.Blocks.Sources.Constant bypContr(k=0)
    "Bypass control: always bypass"
    annotation (Placement(transformation(extent={{240,220},{260,240}})));
  BaseClasses.Thermostat the "Custom thermostat"
    annotation (Placement(transformation(extent={{240,-80},{260,-60}})));
  Modelica.Blocks.Math.BooleanToReal booToRea(realTrue=50000, realFalse=0)
    "Conversion block of control signal to pump pressure set point"
    annotation (Placement(transformation(extent={{280,-80},{300,-60}})));
  Modelica.Blocks.Continuous.Integrator EHea(k=1/3600000) "Heater energy"
    annotation (Placement(transformation(extent={{360,-60},{380,-40}})));
  Modelica.Blocks.Sources.Constant TSup(k=273.15 + 70)
    "Supply water temperature set point"
    annotation (Placement(transformation(extent={{400,-100},{380,-80}})));
  Modelica.SIunits.Energy EGas "Total gas energy use";
initial equation
  EGas=0;
equation
  der(EGas)=QGas/3600000;
  connect(bypContr.y, bypassRet.ctrl) annotation (Line(points={{261,230},{310,230},
          {310,200.8}}, color={0,0,127}));
  connect(bypassSup.ctrl, bypassRet.ctrl) annotation (Line(points={{310,119.2},{
          328,119.2},{328,200.8},{310,200.8}}, color={0,0,127}));
  connect(EHea.u, hea.Q_flow) annotation (Line(points={{358,-50},{349,-50},{349,
          -102}}, color={0,0,127}));
  connect(the.u, living.TSensor) annotation (Line(points={{239.4,-70},{-47,-70},
          {-47,44}},   color={0,0,127}));
  connect(the.y, booToRea.u)
    annotation (Line(points={{260.6,-70},{278,-70}}, color={255,0,255}));
  connect(booToRea.y, pump.dp_in)
    annotation (Line(points={{301,-70},{320,-70},{320,-98}}, color={0,0,127}));
  connect(TSup.y, hea.TSet) annotation (Line(points={{379,-90},{372,-90},{372,
          -102}}, color={0,0,127}));
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
      Tolerance=1e-06,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/PPD12/VentilationRBC.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Example model of a partially renovated terraced house in Belgium.
This model adds the building ventilation system.
</p>
</html>", revisions="<html>
<ul>
<li>
October 26, 2018, by Filip Jorissen:<br/>
Refactored using partials for
<a href=\"https://github.com/open-ideas/IDEAS/issues/942\">#942</a>.
</li>
<li>
January 9, 2017 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end VentilationRBC;
