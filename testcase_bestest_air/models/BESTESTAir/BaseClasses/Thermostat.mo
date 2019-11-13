within BESTESTAir.BaseClasses;
model Thermostat
  "Implements basic control of FCU to maintain zone air temperature"
  parameter Modelica.SIunits.Time MinCycleTime = 2*60 "Minimum cycle time of system";
  parameter Modelica.SIunits.Temperature TSupSetCoo=273.15+14 "Cooling supply air temperature setpoint";
  parameter Modelica.SIunits.Temperature TSupSetHea=273.15+32 "Heating supply air temperature setpoint";
  Modelica.Blocks.Interfaces.RealInput TZon "Measured zone air temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan control signal"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealInput TSetHea
    "Heating temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput TSetCoo
    "Cooling temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.Continuous.LimPID heaPID(controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=5) "Heating control signal"
    annotation (Placement(transformation(extent={{-66,30},{-46,50}})));
  Buildings.Controls.Continuous.LimPID cooPID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    reverseAction=true,
    k=5) "Cooling control signal"
    annotation (Placement(transformation(extent={{-66,70},{-46,90}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Interfaces.RealOutput TSupSet
    "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Logical.Switch TSupSwitch
    "Switch between heating and cooling mode"
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Blocks.Sources.Constant TSupSetCooCon(k=TSupSetCoo)
    "Cooling supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.Constant TSupSetHeaCon(k=TSupSetHea)
    "Heating supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Logical.Switch deaSwitch
    "Switch between deadband and heating or cooling"
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Modelica.Blocks.Logical.Not notCoo
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Blocks.Logical.Not notHea
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Modelica.Blocks.Logical.And andDea
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveFan(description=
        "Fan speed control signal", u(
      min=0,
      max=1,
      unit="1")) "Overwrite for fan speed control signal"
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSupSetCoo(u(
      unit="K",
      min=273.15 + 12,
      max=273.15 + 18), description=
        "Supply air temperature setpoint for cooling")
    "Overwrite for cooling supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSupSetHea(u(
      unit="K",
      min=273.15 + 30,
      max=273.15 + 40), description=
        "Supply air temperature setpoint for heating")
    "Overwrite for heating supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTSetCoo(y(unit="K"), description=
        "Zone air temperature setpoint for cooling")
    "Read zone cooling setpoint"
    annotation (Placement(transformation(extent={{-94,70},{-74,90}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTSetHea(y(unit="K"), description=
        "Zone air temperature setpoint for heating")
                                                    "Read zone cooling heating"
    annotation (Placement(transformation(extent={{-94,30},{-74,50}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThrCoo
    "Check for cooling need"
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThrHea
    "Check for heating need"
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
equation
  connect(TZon, heaPID.u_m)
    annotation (Line(points={{-120,0},{-56,0},{-56,28}}, color={0,0,127}));
  connect(TZon, cooPID.u_m) annotation (Line(points={{-120,0},{-70,0},{-70,60},
          {-56,60},{-56,68}},color={0,0,127}));
  connect(cooPID.y, add.u1) annotation (Line(points={{-45,80},{-40,80},{-40,-14},
          {-22,-14}}, color={0,0,127}));
  connect(heaPID.y, add.u2) annotation (Line(points={{-45,40},{-42,40},{-42,-26},
          {-22,-26}}, color={0,0,127}));
  connect(deaSwitch.y, TSupSet)
    annotation (Line(points={{91,20},{110,20}}, color={0,0,127}));
  connect(notCoo.y, andDea.u1) annotation (Line(points={{51,70},{60,70},{60,60},
          {68,60}}, color={255,0,255}));
  connect(notHea.y, andDea.u2) annotation (Line(points={{51,50},{60,50},{60,52},
          {68,52}}, color={255,0,255}));
  connect(andDea.y, deaSwitch.u2) annotation (Line(points={{91,60},{94,60},{94,40},
          {60,40},{60,20},{68,20}}, color={255,0,255}));
  connect(TZon, deaSwitch.u1) annotation (Line(points={{-120,0},{54,0},{54,28},{
          68,28}}, color={0,0,127}));
  connect(TSupSwitch.y, deaSwitch.u3) annotation (Line(points={{51,20},{58,20},{
          58,12},{68,12}}, color={0,0,127}));
  connect(add.y, oveFan.u)
    annotation (Line(points={{1,-20},{58,-20}}, color={0,0,127}));
  connect(oveFan.y, yFan)
    annotation (Line(points={{81,-20},{110,-20}}, color={0,0,127}));
  connect(TSupSetCooCon.y, oveTSupSetCoo.u)
    annotation (Line(points={{-59,-50},{-42,-50}}, color={0,0,127}));
  connect(oveTSupSetCoo.y, TSupSwitch.u1) annotation (Line(points={{-19,-50},{
          10,-50},{10,28},{28,28}}, color={0,0,127}));
  connect(TSupSetHeaCon.y, oveTSupSetHea.u)
    annotation (Line(points={{-59,-90},{-42,-90}}, color={0,0,127}));
  connect(oveTSupSetHea.y, TSupSwitch.u3) annotation (Line(points={{-19,-90},{
          20,-90},{20,12},{28,12}}, color={0,0,127}));
  connect(TSetCoo, reaTSetCoo.u)
    annotation (Line(points={{-120,80},{-96,80}}, color={0,0,127}));
  connect(reaTSetCoo.y, cooPID.u_s)
    annotation (Line(points={{-73,80},{-68,80}}, color={0,0,127}));
  connect(TSetHea, reaTSetHea.u)
    annotation (Line(points={{-120,40},{-96,40}}, color={0,0,127}));
  connect(reaTSetHea.y, heaPID.u_s)
    annotation (Line(points={{-73,40},{-68,40}}, color={0,0,127}));
  connect(cooPID.y, greThrCoo.u)
    annotation (Line(points={{-45,80},{-32,80}}, color={0,0,127}));
  connect(greThrCoo.y, notCoo.u) annotation (Line(points={{-8,80},{20,80},{20,70},
          {28,70}}, color={255,0,255}));
  connect(greThrCoo.y, TSupSwitch.u2) annotation (Line(points={{-8,80},{20,80},{
          20,20},{28,20}}, color={255,0,255}));
  connect(heaPID.y, greThrHea.u)
    annotation (Line(points={{-45,40},{-32,40}}, color={0,0,127}));
  connect(greThrHea.y, notHea.u) annotation (Line(points={{-8,40},{0,40},{0,50},
          {28,50}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,60},{62,-60}},
          lineColor={0,0,0},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-24,24},{26,-16}},
          lineColor={255,255,255},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="T"),              Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end Thermostat;
