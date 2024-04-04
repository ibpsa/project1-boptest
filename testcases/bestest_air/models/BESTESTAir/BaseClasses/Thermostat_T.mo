within BESTESTAir.BaseClasses;
model Thermostat_T
  "Implements basic control of FCU to maintain zone air temperature with temperature as output"
  parameter Modelica.SIunits.Time occSta = 8*3600 "Occupancy start time" annotation (Dialog(group="Schedule"));
  parameter Modelica.SIunits.Time occEnd = 18*3600 "Occupancy end time" annotation (Dialog(group="Schedule"));
  parameter Modelica.SIunits.DimensionlessRatio minSpe = 0.2 "Minimum fan speed" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetCooUno = 273.15+30 "Unoccupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetCooOcc = 273.15+24 "Occupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaUno = 273.15+15 "Unoccupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaOcc = 273.15+21 "Occupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.DimensionlessRatio kp = 0.1 "Controller P gain" annotation (Dialog(group="Gains"));
  parameter Modelica.SIunits.Time ki = 120 "Controller I gain" annotation (Dialog(group="Gains"));
  Modelica.Blocks.Interfaces.RealInput TZon "Measured zone air temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.Continuous.LimPID heaPI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=kp,
    Ti=ki) "Heating control signal"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Buildings.Controls.Continuous.LimPID cooPI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=ki,
    k=kp,
    reverseActing=false,
    reset=Buildings.Types.Reset.Disabled) "Cooling control signal"
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(
      unit="K",
      min=273.15 + 23,
      max=273.15 + 30), description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetCoo(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,TSetCooUno; occSta,TSetCooOcc; occEnd,TSetCooUno; 24*3600,
        TSetCooUno]) "Cooling temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea(description="Zone temperature setpoint for heating",
      u(
      max=273.15 + 23,
      unit="K",
      min=273.15 + 15)) "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,TSetHeaUno; occSta,TSetHeaOcc; occEnd,TSetHeaUno; 24*3600,
        TSetHeaUno])
                 "Heating temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  ControlToTemperature cooTem(
    THig=TSetCooOcc,
    TLow=285.15,
    reverseAction=true) "Convert to cooling temperature signal"
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  ControlToTemperature heaTem(
    THig=313.15,
    TLow=TSetHeaOcc,
    reverseAction=false) "Convert to heating temperature signal"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Interfaces.RealOutput TSup "Supply temperature setpoint"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Logical.Switch swi "Cooling and heating switch"
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  Modelica.Blocks.Math.Feedback errCoo
    "Control error on room temperature for cooling"
    annotation (Placement(transformation(extent={{-58,-30},{-38,-10}})));
  Modelica.Blocks.Logical.Hysteresis hysCoo(uLow=-1, uHigh=0)
    "Hysteresis for cooling signal"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Nonlinear.Limiter fanLim(uMax=1, uMin=0)
    "Limit fan signal to between 0 and 1"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
equation
  connect(TZon, heaPI.u_m)
    annotation (Line(points={{-120,0},{0,0},{0,28}},     color={0,0,127}));
  connect(TZon, cooPI.u_m) annotation (Line(points={{-120,0},{-16,0},{-16,60},{0,
          60},{0,68}},   color={0,0,127}));
  connect(cooPI.y, add.u1) annotation (Line(points={{11,80},{30,80},{30,6},{38,
          6}}, color={0,0,127}));
  connect(heaPI.y, add.u2) annotation (Line(points={{11,40},{20,40},{20,-6},{38,
          -6}},     color={0,0,127}));
  connect(TSetHea.y[1], oveTSetHea.u)
    annotation (Line(points={{-79,40},{-72,40}}, color={0,0,127}));
  connect(TSetCoo.y[1], oveTSetCoo.u)
    annotation (Line(points={{-79,80},{-72,80}}, color={0,0,127}));
  connect(cooPI.y, cooTem.u) annotation (Line(points={{11,80},{20,80},{20,90},{
          38,90}}, color={0,0,127}));
  connect(heaPI.y, heaTem.u) annotation (Line(points={{11,40},{20,40},{20,30},{
          38,30}}, color={0,0,127}));
  connect(swi.y, TSup)
    annotation (Line(points={{91,60},{110,60}}, color={0,0,127}));
  connect(cooTem.T, swi.u1)
    annotation (Line(points={{61,90},{68,90},{68,68}}, color={0,0,127}));
  connect(heaTem.T, swi.u3)
    annotation (Line(points={{61,30},{68,30},{68,52}}, color={0,0,127}));
  connect(errCoo.y, hysCoo.u)
    annotation (Line(points={{-39,-20},{-22,-20}}, color={0,0,127}));
  connect(hysCoo.y, swi.u2) annotation (Line(points={{1,-20},{64,-20},{64,60},{
          68,60}}, color={255,0,255}));
  connect(TZon, errCoo.u1) annotation (Line(points={{-120,0},{-80,0},{-80,-20},
          {-56,-20}}, color={0,0,127}));
  connect(TSetCoo.y[1], errCoo.u2) annotation (Line(points={{-79,80},{-76,80},{
          -76,-40},{-48,-40},{-48,-28}}, color={0,0,127}));
  connect(add.y, fanLim.u)
    annotation (Line(points={{61,0},{68,0}}, color={0,0,127}));
  connect(fanLim.y, yFan)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(oveTSetHea.y, heaPI.u_s)
    annotation (Line(points={{-49,40},{-12,40}}, color={0,0,127}));
  connect(oveTSetCoo.y, cooPI.u_s)
    annotation (Line(points={{-49,80},{-12,80}}, color={0,0,127}));
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
end Thermostat_T;
