within TestCase3;
model TheZon "Thermal zone model with HVAC"
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature, 
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity, 
    or CO2Concentration";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput QZon "Heat rate to zone"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C=1e6)
    "Thermal capacitance of zone"
    annotation (Placement(transformation(extent={{10,-20},{30,-40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res(R=0.01)
    "Thermal resistance of zone to outside"
    annotation (Placement(transformation(extent={{-22,-30},{-2,-10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZon
    "Room air temperature sensor"
    annotation (Placement(transformation(extent={{42,-30},{62,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaNor
    "Set the heating power to the north zone"
    annotation (Placement(transformation(extent={{-42,10},{-22,30}})));
  Modelica.Blocks.Sources.Sine souTOut(
    f=1/(3600*24),
    offset=273.15 + 20,
    amplitude=10) "Artificial outside air temperature"
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Math.Gain eff(k=1/0.99) "Heater efficiency"
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Math.Abs abs
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut
    "Set the outside air temperature"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Blocks.Interfaces.RealOutput TZon(unit="K") "Zone air temperature"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
        iconTransformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput PHeaCoo(unit="W")
    "Read the heater power consumed in the zone" annotation (Placement(
        transformation(extent={{100,40},{120,60}}), iconTransformation(extent={{100,50},
            {120,70}})));
  Modelica.Blocks.Sources.Sine conCO2Nor(
    amplitude=250,
    f=1/(3600*24),
    offset=750) "Concetration of CO2 in north zone"
    annotation (Placement(transformation(extent={{28,10},{48,30}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Zon "Zone CO2 concentration"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

  Buildings.Utilities.IO.SignalExchange.Read CO2RooAir(
    y(unit="ppm"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    description="Air CO2 concentration of zone " + zone,
    zone=zone) "Read the room air CO2 concentration in zone"
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
equation
  connect(res.port_b, cap.port)
    annotation (Line(points={{-2,-20},{20,-20}}, color={191,0,0}));
  connect(cap.port, senTZon.port)
    annotation (Line(points={{20,-20},{42,-20}}, color={191,0,0}));
  connect(preTOut.port, res.port_a)
    annotation (Line(points={{-40,-20},{-22,-20}}, color={191,0,0}));
  connect(preHeaNor.port, cap.port)
    annotation (Line(points={{-22,20},{20,20},{20,-20}}, color={191,0,0}));
  connect(eff.y, abs.u)
    annotation (Line(points={{-19,60},{-2,60}}, color={0,0,127}));
  connect(souTOut.y, preTOut.T)
    annotation (Line(points={{-79,-20},{-62,-20}}, color={0,0,127}));
  connect(abs.y, PHeaCoo) annotation (Line(points={{21,60},{66,60},{66,50},{110,
          50}}, color={0,0,127}));
  connect(preHeaNor.Q_flow, QZon)
    annotation (Line(points={{-42,20},{-120,20}}, color={0,0,127}));
  connect(eff.u, QZon) annotation (Line(points={{-42,60},{-80,60},{-80,20},{-120,
          20}}, color={0,0,127}));
  connect(PHeaCoo, PHeaCoo)
    annotation (Line(points={{110,50},{110,50}}, color={0,0,127}));
  connect(senTZon.T, TZon) annotation (Line(points={{63,-20},{80,-20},{80,-60},{
          110,-60}}, color={0,0,127}));
  connect(conCO2Nor.y, CO2RooAir.u)
    annotation (Line(points={{49,20},{58,20}}, color={0,0,127}));
  connect(CO2RooAir.y, CO2Zon) annotation (Line(points={{81,20},{96,20},{96,0},{
          110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-164,142},{136,102}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This model represents one thermal zone using a heat capacitor
(<code>C=1e6</code> J/K) connected to an outdoor-temperature
source through a thermal resistor (<code>R=0.01</code> K/W).
The outdoor temperature is a sine wave with a 24-hour period,
a 20 degree C offset, and a 10 degree C amplitude. The input
<code>QZon</code> prescribes heat flow into the zone.
</p>
<p>
The zone CO2 sensor feeds one
<a href=\\\"modelica://Buildings.Utilities.IO.SignalExchange.Read\\\">
Buildings.Utilities.IO.SignalExchange.Read</a> block,
<code>CO2RooAir</code>. It reports the zone air temperature through
<code>TZon</code> in K, with KPI type
<code>AirZoneTemperature</code>. Its <code>zone</code> parameter
and description use this model's <code>zone</code> parameter.
</p>
<p>
The separate output <code>PHeaCoo</code> reports
the HVAC power consumption in W. The output
<code>CO2Zon</code> is supplied by an independent sine source
with a 24-hour period, an offset of 750, and an amplitude of 250.
Neither of these outputs passes through a signal-exchange block
inside this model.
</p>
<p>
When instantiated as <code>Zon[4]</code> in
<a href=\\\"modelica://TestCase3.TwoZones\\\">TestCase3.TwoZones</a>,
each zone contains its own temperature read block, for example
<code>Zon[1].TRooAir</code>.
</p>
</html>", revisions="<html>
<li>
October 6th, 2026, by Ettore Zanetti:<br/>
Update test case to demonstrate array use
This is for <a href=https://github.com/ibpsa/project1-boptest/issues/190>
BOPTEST issue #190</a>.
</li>
</html>"));
end TheZon;
