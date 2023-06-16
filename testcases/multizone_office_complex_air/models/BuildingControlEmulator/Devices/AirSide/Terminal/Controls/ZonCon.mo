within BuildingControlEmulator.Devices.AirSide.Terminal.Controls;
model ZonCon
  parameter Real MinFlowRateSetPoi "Minimum flow rate ratio";
  parameter Real HeatingFlowRateSetPoi "constant flow rate ratio during heating mode";
  Buildings.Controls.Continuous.LimPID cooCon(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=60,
    yMin=MinFlowRateSetPoi,
    reverseActing=false)
           annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Buildings.Controls.Continuous.LimPID heaCon(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=60,
    k=0.01,
    reverseActing=true)
           annotation (Placement(transformation(extent={{42,-70},{62,-50}})));
  Modelica.Blocks.Interfaces.RealInput T
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput TCooSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput THeaSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput yAirFlowSetPoi
    "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yValPos
    "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Logical.Switch swi
    "Switch between external signal and direct feedthrough signal"
    annotation (Placement(transformation(extent={{48,10},{68,30}})));
  Modelica.Blocks.Sources.Constant const(k=HeatingFlowRateSetPoi)
    annotation (Placement(transformation(extent={{-2,-30},{18,-10}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0, uHigh=0.5)
    annotation (Placement(transformation(extent={{-26,10},{-6,30}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-56,10},{-36,30}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTCooSet
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTHeaSet
    annotation (Placement(transformation(extent={{-96,-64},{-88,-56}})));
  Buildings.Utilities.IO.SignalExchange.Read TZon
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Buildings.Utilities.IO.SignalExchange.Read TCooSet
    annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
  Buildings.Utilities.IO.SignalExchange.Read THeaSet
    annotation (Placement(transformation(extent={{-80,-64},{-72,-56}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveAirFlowSetPoi
    annotation (Placement(transformation(extent={{68,54},{82,68}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveyValPos
    annotation (Placement(transformation(extent={{72,-66},{86,-52}})));
equation
  connect(cooCon.y, swi.u1) annotation (Line(points={{11,60},{34,60},{34,28},{46,
          28}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const.y, swi.u3) annotation (Line(
      points={{19,-20},{34,-20},{34,12},{46,12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(add.y, hysteresis.u) annotation (Line(
      points={{-35,20},{-28,20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(hysteresis.y, swi.u2) annotation (Line(
      points={{-5,20},{46,20}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(oveTCooSet.u, TCooSetPoi) annotation (Line(
      points={{-82,60},{-120,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(THeaSetPoi, oveTHeaSet.u)
    annotation (Line(points={{-120,-60},{-96.8,-60}}, color={0,0,127}));
  connect(heaCon.u_s, add.u2) annotation (Line(
      points={{40,-60},{-62,-60},{-62,14},{-58,14}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(T, TZon.u) annotation (Line(
      points={{-120,0},{-94,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TZon.y, heaCon.u_m) annotation (Line(
      points={{-71,0},{-40,0},{-40,-80},{52,-80},{52,-72}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(add.u1, heaCon.u_m) annotation (Line(
      points={{-58,26},{-64,26},{-64,0},{-40,0},{-40,-80},{52,-80},{52,-72}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooCon.u_m, heaCon.u_m) annotation (Line(
      points={{0,48},{-2,48},{-2,0},{-40,0},{-40,-80},{52,-80},{52,-72}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooCon.u_s, TCooSet.y) annotation (Line(
      points={{-12,60},{-25,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TCooSet.u, oveTCooSet.y) annotation (Line(
      points={{-48,60},{-59,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveTHeaSet.y, THeaSet.u)
    annotation (Line(points={{-87.6,-60},{-80.8,-60}}, color={0,0,127}));
  connect(THeaSet.y, add.u2) annotation (Line(
      points={{-71.6,-60},{-62,-60},{-62,14},{-58,14}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveAirFlowSetPoi.y, yAirFlowSetPoi) annotation (Line(points={{84.8,60},
          {110,60}},                 color={0,0,127}));
  connect(heaCon.y, oveyValPos.u) annotation (Line(points={{63,-60},{70,-60},{
          70,-59},{70.6,-59}}, color={0,0,127}));
  connect(oveyValPos.y, yValPos) annotation (Line(points={{86.7,-59},{94,-59},{
          94,-60},{110,-60}}, color={0,0,127}));
  connect(swi.y, oveAirFlowSetPoi.u) annotation (Line(points={{69,20},{86,20},{
          86,46},{48,46},{48,60},{66.4,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end ZonCon;
