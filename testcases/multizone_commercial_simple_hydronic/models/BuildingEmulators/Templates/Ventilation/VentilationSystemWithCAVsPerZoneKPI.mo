within BuildingEmulators.Templates.Ventilation;
model VentilationSystemWithCAVsPerZoneKPI
    extends .BuildingEmulators.Templates.Ventilation.VentilationSystemWithCAVsPerZone;
    
    .IDEAS.Utilities.IO.SignalExchange.Read reaTSupAhuNz(KPIs = IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,description = "North zone AHU air supply temperature") annotation(Placement(transformation(extent = {{-172.0,-90.0},{-192.0,-70.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTRetAhuNz(description = "North zone AHU air return temperature",KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None) annotation(Placement(transformation(extent = {{-174.0,30.0},{-194.0,50.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTExhAhuNz(KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,description = "North zone AHU air exhaust temperature") annotation(Placement(transformation(extent = {{92.0,46.0},{72.0,66.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTInAhuNz(description = "North zone AHU air inlet temperature",KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None) annotation(Placement(transformation(extent = {{172.0,-60.0},{192.0,-40.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTRecAhuNz(KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,description = "North zone AHU air temperature after recovery") annotation(Placement(transformation(extent = {{172.0,-88.0},{192.0,-68.0}},origin = {0.0,0.0},rotation = 0.0)));
    
    .IDEAS.Utilities.IO.SignalExchange.Read reaTSupAhuSz(KPIs = IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,description = "South zone AHU air supply temperature") annotation(Placement(transformation(extent = {{-172.0,-90.0},{-192.0,-70.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTRetAhuSz(description = "South zone AHU air return temperature",KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None) annotation(Placement(transformation(extent = {{-174.0,30.0},{-194.0,50.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTExhAhuSz(KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,description = "South zone AHU air exhaust temperature") annotation(Placement(transformation(extent = {{92.0,46.0},{72.0,66.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTInAhuSz(description = "South zone AHU air inlet temperature",KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None) annotation(Placement(transformation(extent = {{172.0,-60.0},{192.0,-40.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Read reaTRecAhuSz(KPIs = .IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,description = "South zone AHU air temperature after recovery") annotation(Placement(transformation(extent = {{172.0,-88.0},{192.0,-68.0}},origin = {0.0,0.0},rotation = 0.0)));    
    
    .Buildings.Utilities.IO.SignalExchange.Read reaPAhuSupNz(description = "North zone AHU supply fan electric power",KPIs = .Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower) annotation(Placement(transformation(extent = {{-158.0,-50.0},{-178.0,-30.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Utilities.IO.SignalExchange.Read reaPAhuRetNz(KPIs = .Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,description = "North zone AHU return fan electric power") annotation(Placement(transformation(extent = {{-158.0,-8.0},{-178.0,12.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Utilities.IO.SignalExchange.Read reaPAhuSupSz(description = "South zone AHU supply fan electric power",KPIs = .Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower) annotation(Placement(transformation(extent = {{-158.0,-50.0},{-178.0,-30.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Utilities.IO.SignalExchange.Read reaPAhuRetSz(KPIs = .Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,description = "South zone AHU return fan electric power") annotation(Placement(transformation(extent = {{-158.0,-8.0},{-178.0,12.0}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(ahu[1].TSupAhu,reaTSupAhuNz.u) annotation(Line(points = {{-7.400000000000006,-33.3},{-7.400000000000006,-80},{-170,-80}},color = {0,0,127}));
    connect(ahu[1].TRetAhu,reaTRetAhuNz.u) annotation(Line(points = {{-7.400000000000006,39.3},{-7.400000000000006,40},{-172,40}},color = {0,0,127}));
    connect(ahu[1].TExhAhu,reaTExhAhuNz.u) annotation(Line(points = {{114.7,39.3},{114.7,56},{94,56}},color = {0,0,127}));
    connect(reaTInAhuNz.u,ahu[1].TInAhu) annotation(Line(points = {{170,-50},{114.04,-50},{114.04,-33.3}},color = {0,0,127}));
    connect(reaTRecAhuNz.u,ahu[1].TRecAhu) annotation(Line(points = {{170,-78},{162,-78},{162,-54},{82.36,-54},{82.36,-33.3}},color = {0,0,127}));

    connect(ahu[2].TSupAhu,reaTSupAhuSz.u) annotation(Line(points = {{-7.400000000000006,-33.3},{-7.400000000000006,-80},{-170,-80}},color = {0,0,127}));
    connect(ahu[2].TRetAhu,reaTRetAhuSz.u) annotation(Line(points = {{-7.400000000000006,39.3},{-7.400000000000006,40},{-172,40}},color = {0,0,127}));
    connect(ahu[2].TExhAhu,reaTExhAhuSz.u) annotation(Line(points = {{114.7,39.3},{114.7,56},{94,56}},color = {0,0,127}));
    connect(reaTInAhuSz.u,ahu[2].TInAhu) annotation(Line(points = {{170,-50},{114.04,-50},{114.04,-33.3}},color = {0,0,127}));
    connect(reaTRecAhuSz.u,ahu[2].TRecAhu) annotation(Line(points = {{170,-78},{162,-78},{162,-54},{82.36,-54},{82.36,-33.3}},color = {0,0,127}));    

    connect(ahu[1].PSupAhu,reaPAhuSupNz.u) annotation(Line(points = {{-17.30000000000001,20.16},{-72,20.16},{-72,-40},{-156,-40}},color = {0,0,127}));
    connect(ahu[2].PSupAhu,reaPAhuSupSz.u) annotation(Line(points = {{-17.30000000000001,20.16},{-72,20.16},{-72,-40},{-156,-40}},color = {0,0,127}));    
    connect(ahu[1].PRetAhu,reaPAhuRetNz.u) annotation(Line(points = {{-17.30000000000001,20.16},{-72,20.16},{-72,2},{-156,2}},color = {0,0,127}));
    connect(ahu[2].PRetAhu,reaPAhuRetSz.u) annotation(Line(points = {{-17.30000000000001,20.16},{-72,20.16},{-72,2},{-156,2}},color = {0,0,127}));
    
end VentilationSystemWithCAVsPerZoneKPI;
