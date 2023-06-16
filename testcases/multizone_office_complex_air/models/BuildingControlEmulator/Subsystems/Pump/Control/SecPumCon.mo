within BuildingControlEmulator.Subsystems.Pump.Control;
model SecPumCon
  parameter Modelica.Units.SI.Pressure dPSetPoi "Pressure difference setpoint";
  parameter Real tWai = 300 "Waiting time";

    parameter Integer n=3
    "the number of pumps";
  Devices.WaterSide.Control.PumpStageN     pumpStage(
    tWai=tWai,
    thehol_up=0.9,
    n=n,
    thehol_down=0.6)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.BooleanInput On "On signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Status[n] "Speeds of pumps"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput dP "Measured pressure drop"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Math.Product product[n]
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Interfaces.RealOutput y[n] "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Routing.Replicator replicator(nout=n)
    annotation (Placement(transformation(extent={{56,-40},{76,-20}})));
  Devices.Control.conPI conPI(k=0.001, Ti=60)
    annotation (Placement(transformation(extent={{16,-20},{36,0}})));
  Modelica.Blocks.Sources.RealExpression SetPoi(y=dPSetPoi)
    annotation (Placement(transformation(extent={{-52,-46},{-32,-26}})));
equation
  connect(pumpStage.On, On) annotation (Line(
      points={{-52,8},{-66,8},{-80,8},{-80,80},{-120,80}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(pumpStage.Status, Status) annotation (Line(
      points={{-52,-8},{-80,-8},{-80,-80},{-120,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(product.y, y) annotation (Line(
      points={{41,50},{60,50},{80,50},{80,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumpStage.y, product.u1) annotation (Line(
      points={{-29,0},{0,0},{0,56},{18,56}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(replicator.y, product.u2) annotation (Line(
      points={{77,-30},{90,-30},{90,-12},{58,-12},{58,24},{8,24},{8,44},{18,44}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(conPI.On, On) annotation (Line(
      points={{14,-4},{-20,-4},{-20,80},{-120,80}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(conPI.y, replicator.u) annotation (Line(
      points={{37,-10},{46,-10},{46,-30},{54,-30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(SetPoi.y, conPI.SetPoi) annotation (Line(
      points={{-31,-36},{0,-36},{0,-10},{14,-10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conPI.Mea, dP) annotation (Line(
      points={{14,-16},{-28,-16},{-28,-20},{-90,-20},{-90,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end SecPumCon;
