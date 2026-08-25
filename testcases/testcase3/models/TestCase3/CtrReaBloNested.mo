within TestCase3;
model CtrReaBloNested
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCtr "Input for control"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCO2 "Input for CO2"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2RooAir(
    y(unit="ppm"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    description=descriptionCO2,
    zone=zone) "Read the room air CO2 concentration in zone"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  parameter String descriptionCtr="Heater thermal power of north zone"
    "Description of the signal being overwritten";
  parameter String descriptionCO2="Zone air CO2 concentration of north zone"
    "Description of the signal being read";
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature, 
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity, 
    or CO2Concentration";
  Buildings.Utilities.IO.SignalExchange.Overwrite oveActGenDes(u(
      unit="W",
      min=-10000,
      max=10000), description="Overwrite the heating power of zone")
    "Overwrite the heating power of zone"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveAct(u(
      unit="W",
      min=-10000,
      max=10000), description=descriptionCtr)
    "Overwrite the heating power of zone"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
equation
  connect(uCO2, CO2RooAir.u)
    annotation (Line(points={{-120,-40},{-22,-40}}, color={0,0,127}));
  connect(uCtr, oveAct.u)
    annotation (Line(points={{-120,10},{-22,10}}, color={0,0,127}));
  connect(uCtr, oveActGenDes.u) annotation (Line(points={{-120,10},{-40,10},{
          -40,50},{-22,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrReaBloNested;
