within MultiZoneOfficeSimpleAir.BaseClasses;
model VAVReheatBox
  extends Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox(
                                                                break connect(
      vav.y, yVAV),
                    break connect(yHea, val.y),
    break connect(senTem.T, TSup),
    break connect(senVolFlo.V_flow, VSup_flow));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  Buildings.Utilities.IO.SignalExchange.Overwrite yDam(description="Damper position setpoint for zone "
         + zone, u(
      unit="1",
      min=0,
      max=1)) "Damper position setpoint"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yReaHea(description="Reheat control signal for zone "
         + zone, u(
      unit="1",
      min=0,
      max=1)) "Reheat control signal"
    annotation (Placement(transformation(extent={{-84,30},{-64,50}})));
  Buildings.Utilities.IO.SignalExchange.Read TSup1(
    description="Discharge air temperature to zone measurement for zone " +
        zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{42,30},{62,50}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow(
    description="Discharge air flowrate to zone measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{34,70},{54,90}})));
equation
  connect(yVAV, yDam.u)
    annotation (Line(points={{-120,80},{-62,80}}, color={0,0,127}));
  connect(yDam.y, vav.y) annotation (Line(points={{-39,80},{-24,80},{-24,10},{-12,
          10}}, color={0,0,127}));
  connect(yHea, yReaHea.u)
    annotation (Line(points={{-120,40},{-86,40}}, color={0,0,127}));
  connect(yReaHea.y, val.y)
    annotation (Line(points={{-63,40},{-60,40},{-60,12}}, color={0,0,127}));
  connect(senVolFlo.V_flow, V_flow.u)
    annotation (Line(points={{11,80},{32,80}}, color={0,0,127}));
  connect(V_flow.y, VSup_flow)
    annotation (Line(points={{55,80},{110,80}}, color={0,0,127}));
  connect(senTem.T, TSup1.u)
    annotation (Line(points={{11,40},{40,40}}, color={0,0,127}));
  connect(TSup1.y, TSup)
    annotation (Line(points={{63,40},{110,40}}, color={0,0,127}));
end VAVReheatBox;
