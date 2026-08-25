within TestCase3;
model CtrReaBlo
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCtr[2] "Input for control"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCO2[2] "Input for CO2"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveAct[2](u(
      each unit="W",
      min={-10000,-5000},
      max={10000,5000}), description=descriptionCtr)
    "Overwrite the heating power of zone"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2RooAir[2](
    y(each unit="ppm"),
    each KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    description=descriptionCO2,
    zone=zone) "Read the room air CO2 concentration in zone"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  parameter String descriptionCtr[2]={"Heater thermal power of zone","Heater thermal power of zone"}
    "Description of the signal being overwritten";
  parameter String descriptionCO2[2]={"Zone air CO2 concentration","Zone air CO2 concentration"}
    "Description of the signal being read";
  parameter String zone[2]={"1","2"} "Zone designation, required if KPIs is AirZoneTemperature, 
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity, 
    or CO2Concentration";
  CtrReaBloNested ctrReaBloNested[2](
    descriptionCtr=descriptionCtr,
    descriptionCO2=descriptionCO2,
    zone=zone)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(uCtr, oveAct.u) annotation (Line(points={{-120,10},{-32,10},{-32,70},{
          -22,70}}, color={0,0,127}));
  connect(uCO2, CO2RooAir.u)
    annotation (Line(points={{-120,-40},{-30,-40},{-30,30},{-22,30}},
                                                    color={0,0,127}));
  connect(uCtr, ctrReaBloNested.uCtr) annotation (Line(points={{-120,10},{-32,10},
          {-32,-66},{-22,-66}}, color={0,0,127}));
  connect(uCO2, ctrReaBloNested.uCO2) annotation (Line(points={{-120,-40},{-40,-40},
          {-40,-74},{-22,-74}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrReaBlo;
