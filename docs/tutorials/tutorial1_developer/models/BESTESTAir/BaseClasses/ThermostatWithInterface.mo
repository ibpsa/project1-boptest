within BESTESTAir.BaseClasses;
model ThermostatWithInterface
  "Implements basic control of FCU to maintain zone air temperature"
  parameter Modelica.SIunits.Temperature TSupSetCoo=273.15+13 "Cooling supply air temperature setpoint";
  parameter Modelica.SIunits.Temperature TSupSetHea=273.15+35 "Heating supply air temperature setpoint";
  Modelica.Blocks.Interfaces.RealInput TZon "Measured zone air temperature"
    annotation (Placement(transformation(extent={{-160,-20},{-120,20}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan control signal"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealInput TSetHea
    "Heating temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-160,20},{-120,60}})));
  Modelica.Blocks.Interfaces.RealInput TSetCoo
    "Cooling temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-160,60},{-120,100}})));
  Buildings.Controls.Continuous.LimPID heaPID(controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=5) "Heating control signal"
    annotation (Placement(transformation(extent={{-72,30},{-52,50}})));
  Buildings.Controls.Continuous.LimPID cooPID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    reverseAction=true,
    k=5) "Cooling control signal"
    annotation (Placement(transformation(extent={{-72,70},{-52,90}})));
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
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Logical.Switch deaSwitch
    "Switch between deadband and heating or cooling"
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Modelica.Blocks.Logical.Not notCoo
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Blocks.Logical.Not notHea
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Modelica.Blocks.Logical.And andDea
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveFan(description=
        "Fan speed control signal", u(
      min=0,
      max=1,
      unit="1")) "Overwrite fan speed control signal"
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveTSupCoo(description="Supply air temperature setpoint for cooling
", u( min=273.15 + 12,
      max=273.15 + 18,
      unit="K")) "Overwrite supply air temperature setpoint for cooling"
    annotation (Placement(transformation(extent={{-32,-60},{-12,-40}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveTSupHea(description="Supply air temperature setpoint for heating
", u( min=273.15 + 30,
      max=273.15 + 40,
      unit="K")) "Overwrite supply air temperature setpoint for heating"
    annotation (Placement(transformation(extent={{-32,-100},{-12,-80}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveTSetCoo(description="Zone temperature setpoint for cooling
", u( min=273.15 + 23,
      max=273.15 + 30,
      unit="K")) "Overwrite zone temperature setpoint for cooling"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveTSetHea(description="Zone temperature setpoint for heating
", u( min=273.15 + 15,
      max=273.15 + 23,
      unit="K")) "Overwrite zone temperature setpoint for heating"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));

equation
  connect(TZon, heaPID.u_m)
    annotation (Line(points={{-140,0},{-62,0},{-62,28}}, color={0,0,127}));
  connect(TZon, cooPID.u_m) annotation (Line(points={{-140,0},{-86,0},{-86,60},
          {-62,60},{-62,68}},color={0,0,127}));
  connect(cooPID.y, add.u1) annotation (Line(points={{-51,80},{-40,80},{-40,-14},
          {-22,-14}}, color={0,0,127}));
  connect(heaPID.y, add.u2) annotation (Line(points={{-51,40},{-50,40},{-50,-26},
          {-22,-26}}, color={0,0,127}));
  connect(cooPID.y, greaterThreshold.u)
    annotation (Line(points={{-51,80},{-32,80}}, color={0,0,127}));
  connect(heaPID.y, greaterThreshold1.u)
    annotation (Line(points={{-51,40},{-32,40}}, color={0,0,127}));
  connect(greaterThreshold.y, TSupSwitch.u2) annotation (Line(points={{-9,80},{20,
          80},{20,20},{28,20}}, color={255,0,255}));
  connect(deaSwitch.y, TSupSet)
    annotation (Line(points={{91,20},{110,20}}, color={0,0,127}));
  connect(notCoo.y, andDea.u1) annotation (Line(points={{51,70},{60,70},{60,60},
          {68,60}}, color={255,0,255}));
  connect(notHea.y, andDea.u2) annotation (Line(points={{51,50},{60,50},{60,52},
          {68,52}}, color={255,0,255}));
  connect(andDea.y, deaSwitch.u2) annotation (Line(points={{91,60},{94,60},{94,40},
          {60,40},{60,20},{68,20}}, color={255,0,255}));
  connect(greaterThreshold1.y, notHea.u) annotation (Line(points={{-9,40},{0,40},
          {0,50},{28,50}}, color={255,0,255}));
  connect(greaterThreshold.y, notCoo.u) annotation (Line(points={{-9,80},{20,80},
          {20,70},{28,70}}, color={255,0,255}));
  connect(TZon, deaSwitch.u1) annotation (Line(points={{-140,0},{54,0},{54,28},
          {68,28}},color={0,0,127}));
  connect(TSupSwitch.y, deaSwitch.u3) annotation (Line(points={{51,20},{58,20},{
          58,12},{68,12}}, color={0,0,127}));
  connect(add.y, oveFan.u)
    annotation (Line(points={{1,-20},{48,-20}}, color={0,0,127}));
  connect(oveFan.y, yFan)
    annotation (Line(points={{71,-20},{110,-20}}, color={0,0,127}));
  connect(TSupSetCooCon.y, oveTSupCoo.u)
    annotation (Line(points={{-59,-50},{-34,-50}}, color={0,0,127}));
  connect(oveTSupCoo.y, TSupSwitch.u1) annotation (Line(points={{-11,-50},{10,
          -50},{10,28},{28,28}}, color={0,0,127}));
  connect(TSupSetHeaCon.y, oveTSupHea.u)
    annotation (Line(points={{-59,-90},{-34,-90}}, color={0,0,127}));
  connect(oveTSupHea.y, TSupSwitch.u3) annotation (Line(points={{-11,-90},{20,
          -90},{20,12},{28,12}}, color={0,0,127}));
  connect(TSetCoo, oveTSetCoo.u)
    annotation (Line(points={{-140,80},{-112,80}}, color={0,0,127}));
  connect(TSetHea, oveTSetHea.u)
    annotation (Line(points={{-140,40},{-112,40}}, color={0,0,127}));
  connect(oveTSetCoo.y, cooPID.u_s)
    annotation (Line(points={{-89,80},{-74,80}}, color={0,0,127}));
  connect(oveTSetHea.y, heaPID.u_s)
    annotation (Line(points={{-89,40},{-74,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}),                                  graphics={
                                Rectangle(
        extent={{-120,-100},{100,100}},
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
            false, extent={{-120,-100},{100,100}})));
end ThermostatWithInterface;
