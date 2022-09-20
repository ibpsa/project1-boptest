within TwoZoneApartmentHydronic.Components;
model Thermostat_T
  "Implements basic control of FCU to maintain zone air temperature with temperature as output"
  parameter Modelica.SIunits.Time occSta = 8*3600 "Occupancy start time" annotation (Dialog(group="Schedule"));
  parameter Modelica.SIunits.Time occEnd = 18*3600 "Occupancy end time" annotation (Dialog(group="Schedule"));
  parameter Modelica.SIunits.Temperature TSetHeaUno = 273.15+15 "Unoccupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaOcc = 273.15+21 "Occupied heating setpoint Monday to Friday" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaWee = 273.15+16 "Heating setpoint Saturday and Sunday" annotation (Dialog(group="Setpoints"));
  parameter Real bandwidth=2 "Bandwidth around reference signal";
  Modelica.Blocks.Interfaces.RealInput TZon "Measured zone air temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.CombiTimeTable TSetHea(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,TSetHeaUno; occSta,TSetHeaOcc; occEnd,TSetHeaUno; 86400,TSetHeaUno;
        occSta + 86400,TSetHeaOcc; occEnd + 86400,TSetHeaUno; 86400*2,
        TSetHeaUno; occSta + 86400*2,TSetHeaOcc; occEnd + 86400*2,TSetHeaUno;
        86400*3,TSetHeaUno; occSta + 86400*3,TSetHeaOcc; occEnd + 86400*3,
        TSetHeaUno; 86400*4,TSetHeaUno; occSta + 86400*4,TSetHeaOcc; occEnd +
        86400*4,TSetHeaUno; 86400*5,TSetHeaUno; occSta + 86400*5,TSetHeaWee;
        occEnd + 86400*5,TSetHeaWee; 86400*6,TSetHeaWee; occSta + 86400*6,
        TSetHeaWee; occEnd + 86400*6,TSetHeaWee; 86400*7,TSetHeaWee])
                 "Heating temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Interfaces.RealOutput ValCon "Zone valve control"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput TSetZ "Supply temperature setpoint"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Logical.OnOffController onOffCon(bandwidth=bandwidth)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-12,50},{8,70}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       TSetHeaUno)
    annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
  Modelica.Blocks.Interfaces.RealOutput Occ
    "If value is one thermal zone is occupied else it is empty"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTsetZon(u(
      unit="K",
      min=273.15,
      max=273.15 + 45), description="Setpoint temperature for thermal zone")
    "Overwrite Setpoint temperature for thermal zone"
    annotation (Placement(transformation(extent={{-66,-70},{-46,-50}})));
equation
  connect(TZon, onOffCon.u) annotation (Line(points={{-120,0},{-66,0},{-66,54},{
          -62,54}},  color={0,0,127}));
  connect(onOffCon.y, booleanToReal.u)
    annotation (Line(points={{-39,60},{-14,60}}, color={255,0,255}));
  connect(booleanToReal.y, ValCon)
    annotation (Line(points={{9,60},{110,60}}, color={0,0,127}));
  connect(greaterEqualThreshold.y, booleanToReal1.u)
    annotation (Line(points={{7,0},{38,0}}, color={255,0,255}));
  connect(booleanToReal1.y, Occ)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(TSetHea.y[1], oveTsetZon.u)
    annotation (Line(points={{-79,-60},{-68,-60}}, color={0,0,127}));
  connect(oveTsetZon.y, TSetZ)
    annotation (Line(points={{-45,-60},{110,-60}}, color={0,0,127}));
  connect(oveTsetZon.y, greaterEqualThreshold.u) annotation (Line(points={{-45,
          -60},{-34,-60},{-34,0},{-16,0}}, color={0,0,127}));
  connect(onOffCon.reference, greaterEqualThreshold.u) annotation (Line(points=
          {{-62,66},{-76,66},{-76,-20},{-34,-20},{-34,0},{-16,0}}, color={0,0,
          127}));
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
            false)),
    Documentation(revisions="<html>
<ul>
<li>
August 5, 2022, by Ettore Zanetti:<br/>
Revision after comments
</li>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>"));
end Thermostat_T;
