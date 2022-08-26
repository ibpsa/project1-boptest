within BuildingEmulators;
model BuildingSystem
  "Example of model with ventilation system"
  extends .Modelica.Icons.Example;
  inner .IDEAS.BoundaryConditions.SimInfoManager sim(unify_n50 = true,n50 = 5)
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));

  package Medium = .IDEAS.Media.Air(extraPropertiesNames={"CO2"}) "Air medium";

  .BuildingEmulators.Templates.Structure.TwoZoneKPI structure(T_start = 273.15 + 23)
    annotation (Placement(transformation(extent={{-24.803571428571402,0.5464154411764781},{5.196428571428598,20.546415441176478}},rotation = 0.0,origin = {0.0,0.0})));
  .BuildingEmulators.Templates.Ventilation.VentilationSystemWithCAVsPerZoneKPI ventilation(
    nZones=structure.nZones,
    VZones=structure.VZones,
    m_flow_nominal_air_sup=3*ones(structure.nZones),
    m_flow_nominal_air_ret=2.5*ones(structure.nZones),
    dp_nominal_air_sup(each displayUnit="Pa") = {250,250},
    dp_nominal_air_ret(each displayUnit="Pa") = 180 * ones(structure.nZones))
    annotation (Placement(transformation(extent={{17.375,48.848805147058826},{53.375,66.84880514705883}},rotation = 0.0,origin = {0.0,0.0})));
    .BuildingEmulators.Templates.Occupancy.OccupantNumber occupancy(
        nZones = structure.nZones,
        maxOcc = sum(structure.AZones) / 15) annotation(Placement(transformation(extent = {{11.053571428571416,-34.24402573529413},{-28.946428571428584,-14.244025735294127}},origin = {0.0,0.0},rotation = 0.0)));
    .BuildingEmulators.Templates.Heating.FanCoilUnitsKPI heating_cooling(
        nZones = structure.nZones,
        Q_design = {100000,100000},
        mWatAhuHea_flow_nominal = ventilation.ahu.m_flow_nominal_wat_hea,
        mWatAhuCoo_flow_nominal = ventilation.ahu.m_flow_nominal_wat_coo,
        QHeaAhu_flow_nominal = ventilation.ahu.Q_flow_nominal_hea,
        QCooAhu_flow_nominal = -ventilation.ahu.Q_flow_nominal_coo,
        QHeaEmi_flow_nominal = {30 * 2500, 25 * 2500},
        QCooEmi_flow_nominal = -{40*2500,45*2500}) annotation(Placement(transformation(extent = {{34.0,0.0},{74.0,20.0}},origin = {0.0,0.0},rotation = 0.0)));
    .BuildingEmulators.Components.BmsControl bms annotation(Placement(transformation(extent = {{-58.0,38.0},{-38.0,58.0}},origin = {0.0,0.0},rotation = 0.0)));
        
  inner IDEAS.Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.UnixTimeStampGMT,yearRef = 2021,outputUnixTimeStamp = true,timZon = calTim.timeStampsNewYear[12])
    annotation (Placement(transformation(extent={{18.0,82.0},{38.0,102.0}},rotation = 0.0,origin = {0.0,0.0})));        
        
        
    .IDEAS.Utilities.IO.SignalExchange.WeatherStation weaSta annotation(Placement(transformation(extent = {{-38.0,80.0},{-18.0,100.0}},origin = {0.0,0.0},rotation = 0.0)));
equation
        
  occupancy.nOcc = structure.nOcc;   
  occupancy.nOcc = bms.nOcc; 
  
  sim.Te = bms.Te;
        
  connect(structure.TSensor, ventilation.TSensor) annotation (Line(
      points={{5.796428571428578,4.546415441176478},{13.196428571428584,4.546415441176478},{13.196428571428584,52.44880514705883},{17.015,52.44880514705883}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(structure.port_b, ventilation.port_a) annotation (Line(
        points={{-11.803571428571416,20.546415441176478},{-11.803571428571416,59.64880514705882},{17.375,59.64880514705882}}, color={0,127,255}));
  connect(structure.port_a, ventilation.port_b) annotation (Line(
        points={{-7.803571428571416,20.546415441176478},{-7.803571428571416,56.04880514705882},{17.375,56.04880514705882}}, color={0,127,255}));
    connect(structure.heatPortCon,occupancy.heatPortCon) annotation(Line(points = {{5.196428571428584,12.546415441176478},{19.053571428571445,12.546415441176478},{19.053571428571445,-22.244025735294116},{11.053571428571416,-22.244025735294116}},color = {191,0,0}));
    connect(occupancy.heatPortRad,structure.heatPortRad) annotation(Line(points = {{11.053571428571416,-26.244025735294116},{23.375,-26.244025735294116},{23.375,8.546415441176478},{5.196428571428584,8.546415441176478}},color = {191,0,0}));
        
    
    connect(heating_cooling.TSensor,structure.TSensor);

    connect(bms.prfAhuSup,ventilation.prfAhuSup);
    connect(bms.prfAhuRet,ventilation.prfAhuRet);
    connect(bms.TSupAhuSet,ventilation.TSupAhuSet);
    connect(structure.TSensor,bms.TZon);
    connect(structure.heatPortCon,heating_cooling.heatPortCon) annotation(Line(points = {{5.196428571428584,12.546415441176478},{34,12.546415441176478},{34,12}},color = {191,0,0}));
    connect(heating_cooling.heatPortRad,structure.heatPortRad) annotation(Line(points = {{34,8},{34,8.546415441176478},{5.196428571428584,8.546415441176478}},color = {191,0,0}));
    connect(heating_cooling.portHea_a,ventilation.portHea_b) annotation(Line(points = {{66.4,20},{66.4,39.848805147058826},{44.375,39.848805147058826},{44.375,48.848805147058826}},color = {0,127,255}));
    connect(heating_cooling.portHea_a,ventilation.portHea_b) annotation(Line(points = {{67.775,21.848805147058826},{67.775,39.848805147058826},{44.375,39.848805147058826},{44.375,48.848805147058826}},color = {0,127,255}));
    connect(heating_cooling.portHea_b,ventilation.portHea_a) annotation(Line(points = {{70.4,20},{70.4,37.848805147058826},{41.675,37.848805147058826},{41.675,48.848805147058826}},color = {0,127,255}));
    connect(heating_cooling.portCoo_b,ventilation.portCoo_a) annotation(Line(points = {{62,20},{62,31.848805147058826},{35.375,31.848805147058826},{35.375,48.848805147058826}},color = {0,127,255}));
    connect(heating_cooling.portCoo_a,ventilation.portCoo_b) annotation(Line(points = {{58,20},{58,33.848805147058826},{38.075,33.848805147058826},{38.075,48.848805147058826}},color = {0,127,255}));
    connect(bms.TSetProHea,heating_cooling.TSupProHea);
    connect(bms.TSetProCoo,heating_cooling.TSupProCoo);
    connect(bms.valPosAhuHea,heating_cooling.valPosAhuHea);
    connect(bms.valPosAhuCoo,heating_cooling.valPosAhuCoo);
    connect(bms.prfAhuHea,heating_cooling.prfAhuHea);
    connect(bms.prfAhuCoo,heating_cooling.prfAhuCoo);
    connect(heating_cooling.TSupAhuHea,bms.TSupAhuHea);
    connect(heating_cooling.TSupAhuCoo,bms.TSupAhuCoo);
    connect(heating_cooling.TSupEmiCoo,bms.TSupEmiCoo);
    connect(heating_cooling.TSupEmiHea,bms.TSupEmiHea);
    connect(bms.valPosEmiCoo,heating_cooling.valPosEmiCoo);
    connect(bms.valPosEmiHea,heating_cooling.valPosEmiHea);
    connect(bms.TSet,heating_cooling.TSet);
    connect(bms.TZonSetMin,heating_cooling.TZonSetMin);
    connect(bms.TZonSetMax,heating_cooling.TZonSetMax);
    connect(heating_cooling.prfEmiHea,bms.prfEmiHea);
    connect(bms.prfEmiCoo,heating_cooling.prfEmiCoo);
    connect(heating_cooling.prfProHea,bms.prfProHea);
    connect(bms.prfProCoo,heating_cooling.prfProCoo);
    connect(bms.TSetProHea,heating_cooling.TSupProHea);
    connect(ventilation.oveByPass,bms.oveByPass);
    connect(structure.humAir,heating_cooling.humAir) annotation(Line(points = {{5.796428571428599,3.1464154411764778},{33.599999999999994,3.1464154411764778},{33.599999999999994,2.5999999999999996}},color = {0,0,127}));
    connect(sim.weaDatBus,weaSta.weaBus) annotation(Line(points = {{-60.1,90},{-49,90},{-49,89.9},{-37.9,89.9}},color = {255,204,51}));
    
   annotation (
    Diagram(experiment(StopTime=31536000), coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>
Two-zone commercial building model for BOPTEST.
</p>
</html>",     revisions="<html>
<ul>
<li>
August 4, 2022 by Iago Cupeiro:<br/>
First implementation.
</li>
</ul>
</html>"));
end BuildingSystem;
