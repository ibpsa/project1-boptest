within BuildingEmulators.Templates.Structure;
model TwoZoneKPI
    extends .BuildingEmulators.Templates.Structure.TwoZone;
    .IDEAS.Utilities.IO.SignalExchange.Read reaTZonNz(y(unit="K"), KPIs = IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.OperativeZoneTemperature,description = "North zone operative temperature",zone = "nZ") annotation(Placement(transformation(extent = {{-70.69233458018702,32.69233458018702},{-85.30766541981298,47.30766541981298}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaCO2ZonNz(y(unit="ppm"), zone = "nZ",description = "North zone CO2 concentration",KPIs = IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration) annotation(Placement(transformation(extent = {{-70.69233458018702,4.692334580187023},{-85.30766541981298,19.307665419812977}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTZonSz(y(unit="K"), zone = "sZ",description = "South zone operative temperature",KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.OperativeZoneTemperature) annotation(Placement(transformation(extent = {{-70.69233458018702,-53.30766541981298},{-85.30766541981298,-38.69233458018702}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaCO2ZonSz(y(unit="ppm"), KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,description = "South zone CO2 concentration",zone = "sZ") annotation(Placement(transformation(extent = {{-70.69233458018702,-81.30766541981298},{-85.30766541981298,-66.69233458018702}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(nZ.TSensor,reaTZonNz.u) annotation(Line(points = {{11,42},{17,42},{17,20},{-16,20},{-16,40},{-69.23080149622443,40}},color = {0,0,127}));
    connect(reaCO2ZonNz.u,nZ.ppm) annotation(Line(points = {{-69.23080149622443,12},{17,12},{17,40},{11,40}},color = {0,0,127}));
    connect(reaTZonSz.u,sZ.TSensor) annotation(Line(points = {{-69.23080149622443,-46},{17,-46},{17,-28},{11,-28}},color = {0,0,127}));
    connect(reaCO2ZonSz.u,sZ.ppm) annotation(Line(points = {{-69.23080149622443,-74},{17,-74},{17,-30},{11,-30}},color = {0,0,127}));
end TwoZoneKPI;
