within BESTESTAir.BaseClasses;
model Thermostat_OnOff
  "Implements basic on/off control of FCU to maintain zone air temperature"
  parameter Modelica.SIunits.DimensionlessRatio DeadBandHea=2 "Deadband for heating setpoint [degC]";
  parameter Modelica.SIunits.DimensionlessRatio DeadBandCoo=2 "Deadband for cooling setpoint [degC]";
  parameter Modelica.SIunits.Time MinCycleTime = 2*60 "Minimum cycle time of system";
  parameter Modelica.SIunits.Temperature TSupSetHea=273.15+32 "Heating supply air temperature setpoint";
  parameter Modelica.SIunits.Temperature TSupSetCoo=273.15+14 "Cooling supply air temperature setpoint";
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
  Modelica.Blocks.Logical.OnOffController conCoo(bandwidth=DeadBandCoo)
    "On/off controller for cooling"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Logical.OnOffController conHea(bandwidth=DeadBandHea)
    "On/off controller for heating"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Logical.Not cooRevAct "Reverse acting for cooling"
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Math.BooleanToReal fanOn "Turn fan on"
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold holCoo(trueHoldDuration=
        MinCycleTime)
                    "Minimum runtime for cooling"
    annotation (Placement(transformation(extent={{-36,70},{-16,90}})));
  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold holHea(trueHoldDuration=
        MinCycleTime)
                    "Minimum runtime for heating"
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Logical.Or orFan "Turn fan on for cooling or heating"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
equation
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
  connect(TSetHea, reaTSetHea.u)
    annotation (Line(points={{-120,40},{-96,40}}, color={0,0,127}));
  connect(reaTSetCoo.y, conCoo.reference) annotation (Line(points={{-73,80},{-70,
          80},{-70,86},{-62,86}}, color={0,0,127}));
  connect(TZon, conCoo.u) annotation (Line(points={{-120,0},{-70,0},{-70,74},{-62,
          74}}, color={0,0,127}));
  connect(reaTSetHea.y, conHea.reference) annotation (Line(points={{-73,40},{-66,
          40},{-66,46},{-62,46}}, color={0,0,127}));
  connect(conHea.u, conCoo.u) annotation (Line(points={{-62,34},{-70,34},{-70,74},
          {-62,74}}, color={0,0,127}));
  connect(cooRevAct.y, notCoo.u) annotation (Line(points={{11,80},{14,80},{14,70},
          {28,70}}, color={255,0,255}));
  connect(cooRevAct.y, TSupSwitch.u2) annotation (Line(points={{11,80},{14,80},{
          14,36},{20,36},{20,20},{28,20}},
                                        color={255,0,255}));
  connect(conCoo.y, holCoo.u)
    annotation (Line(points={{-39,80},{-38,80}}, color={255,0,255}));
  connect(holCoo.y, cooRevAct.u)
    annotation (Line(points={{-14,80},{-12,80}}, color={255,0,255}));
  connect(conHea.y, holHea.u)
    annotation (Line(points={{-39,40},{-32,40}}, color={255,0,255}));
  connect(holHea.y, notHea.u) annotation (Line(points={{-8,40},{20,40},{20,50},{
          28,50}}, color={255,0,255}));
  connect(oveFan.u, fanOn.y)
    annotation (Line(points={{58,-20},{51,-20}}, color={0,0,127}));
  connect(orFan.y, fanOn.u)
    annotation (Line(points={{1,-20},{28,-20}}, color={255,0,255}));
  connect(holHea.y, orFan.u2) annotation (Line(points={{-8,40},{0,40},{0,26},{-40,
          26},{-40,-28},{-22,-28}}, color={255,0,255}));
  connect(cooRevAct.y, orFan.u1) annotation (Line(points={{11,80},{14,80},{14,36},
          {4,36},{4,22},{-36,22},{-36,-20},{-22,-20}}, color={255,0,255}));
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
end Thermostat_OnOff;
