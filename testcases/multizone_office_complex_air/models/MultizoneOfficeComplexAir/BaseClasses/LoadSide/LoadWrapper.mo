within MultizoneOfficeComplexAir.BaseClasses.LoadSide;
model LoadWrapper "Load calculation in EnergyPlus using Spawn"
  MultizoneOfficeComplexAir.BaseClasses.LoadSide.BaseClasses.WholeBuildingEnergyPlus
    whoBui annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput TZonAir[15] "Zone air temperatures (\"Core_bot\",\"Perimeter_bot_ZN_1\",\"Perimeter_bot_ZN_2\",\"Perimeter_bot_ZN_3\",\"Perimeter_bot_ZN_4\", \"Core_mid\",\"Perimeter_mid_ZN_1\",\"Perimeter_mid_ZN_2\",\"Perimeter_mid_ZN_3\",\"Perimeter_mid_ZN_4\", \"Core_top\",\"Perimeter_top_ZN_1\",\"Perimeter_top_ZN_2\",\"Perimeter_top_ZN_3\",
  \"Perimeter_top_ZN_4\")"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput TWetBul "wet bulb temperature"
    annotation (Placement(transformation(extent={{100,80},{120,100}}),
        iconTransformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput TDryBul "Dry bulb temperature"
    annotation (Placement(transformation(extent={{100,50},{120,70}}),
        iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput relHum "relative humidity"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput numOcc[15] "number of occupant"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,10},{120,30}})));

  Modelica.Blocks.Interfaces.RealOutput QLoa[15] "Zone load" annotation (
      Placement(transformation(extent={{100,-30},{120,-10}}),
        iconTransformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Math.Add3 add[15](each k3=-1)
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Modelica.Blocks.Interfaces.RealOutput yHvaOpe "HVAC operation signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-84})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://MultizoneOfficeComplexAir/Resources/idf/wholebuilding96_spawn.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://MultizoneOfficeComplexAir/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://MultizoneOfficeComplexAir/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    computeWetBulbTemperature=true,
    usePrecompiledFMU=false) "Building model"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  Modelica.Icons.SignalBus weaBus
    annotation (Placement(transformation(extent={{-8,92},{8,108}}),
        iconTransformation(extent={{-8,92},{8,108}})));
equation
  connect(whoBui.Outdoor_Humidity, relHum) annotation (Line(points={{-38,0},{40,
          0},{40,-50},{110,-50}}, color={0,0,127}));
  connect(TZonAir[1], whoBui.Temp1_bot);
  connect(TZonAir[2], whoBui.Temp2_bot);
  connect(TZonAir[3], whoBui.Temp3_bot);
  connect(TZonAir[4], whoBui.Temp4_bot);
  connect(TZonAir[5], whoBui.Temp5_bot);
  connect(TZonAir[6], whoBui.Temp1);
  connect(TZonAir[7], whoBui.Temp2);
  connect(TZonAir[8], whoBui.Temp3) annotation (Line(points={{-120,-2.66454e-15},
          {-120,0},{-62,0}}, color={0,0,127}));
  connect(TZonAir[9], whoBui.Temp4);
  connect(TZonAir[10], whoBui.Temp5);
  connect(TZonAir[11], whoBui.Temp1_top);
  connect(TZonAir[12], whoBui.Temp2_top);
  connect(TZonAir[13], whoBui.Temp3_top);
  connect(TZonAir[14], whoBui.Temp4_top);
  connect(TZonAir[15], whoBui.Temp5_top);
  connect(numOcc[1], whoBui.Zone1_bot_People);
  connect(numOcc[2], whoBui.Zone2_bot_People);
  connect(numOcc[3], whoBui.Zone3_bot_People);
  connect(numOcc[4], whoBui.Zone4_bot_People);
  connect(numOcc[5], whoBui.Zone5_bot_People);
  connect(numOcc[6], whoBui.Zone1_People);
  connect(numOcc[7], whoBui.Zone2_People);
  connect(numOcc[8], whoBui.Zone3_People) annotation (Line(points={{110,-1.33227e-15},
          {90,-1.33227e-15},{90,0},{-38,0}}, color={0,0,127}));
  connect(numOcc[9], whoBui.Zone4_People);
  connect(numOcc[10], whoBui.Zone5_People);
  connect(numOcc[11], whoBui.Zone1_top_People);
  connect(numOcc[12], whoBui.Zone2_top_People);
  connect(numOcc[13], whoBui.Zone3_top_People);
  connect(numOcc[14], whoBui.Zone4_top_People);
  connect(numOcc[15], whoBui.Zone5_top_People);

  connect(add[1].u1, whoBui.Zone1_bot_Sensible_COOLING_LOAD) annotation (Line(
        points={{58,-12},{0,-12},{0,0},{-38,0}}, color={0,0,127}));
  connect(add[1].u2, whoBui.Zone1_bot_Latent_COOLING_LOAD) annotation (Line(
        points={{58,-20},{10,-20},{10,0},{-38,0}}, color={0,0,127}));
  connect(add[1].u3, whoBui.Zone1_bot_HEATING_LOAD) annotation (Line(points={{
          58,-28},{20,-28},{20,0},{-38,0}}, color={0,0,127}));
  connect(add[2].u1, whoBui.Zone2_bot_Sensible_COOLING_LOAD);
  connect(add[2].u2, whoBui.Zone2_bot_Latent_COOLING_LOAD);
  connect(add[2].u3, whoBui.Zone2_bot_HEATING_LOAD);
  connect(add[3].u1, whoBui.Zone3_bot_Sensible_COOLING_LOAD);
  connect(add[3].u2, whoBui.Zone3_bot_Latent_COOLING_LOAD);
  connect(add[3].u3, whoBui.Zone3_bot_HEATING_LOAD);
  connect(add[4].u1, whoBui.Zone4_bot_Sensible_COOLING_LOAD);
  connect(add[4].u2, whoBui.Zone4_bot_Latent_COOLING_LOAD);
  connect(add[4].u3, whoBui.Zone4_bot_HEATING_LOAD);
  connect(add[5].u1, whoBui.Zone5_bot_Sensible_COOLING_LOAD);
  connect(add[5].u2, whoBui.Zone5_bot_Latent_COOLING_LOAD);
  connect(add[5].u3, whoBui.Zone5_bot_HEATING_LOAD);

  connect(add[6].u1, whoBui.Zone1_Sensible_COOLING_LOAD);
  connect(add[6].u2, whoBui.Zone1_Latent_COOLING_LOAD);
  connect(add[6].u3, whoBui.Zone1_HEATING_LOAD);
  connect(add[7].u1, whoBui.Zone2_Sensible_COOLING_LOAD);
  connect(add[7].u2, whoBui.Zone2_Latent_COOLING_LOAD);
  connect(add[7].u3, whoBui.Zone2_HEATING_LOAD);
  connect(add[8].u1, whoBui.Zone3_Sensible_COOLING_LOAD);
  connect(add[8].u2, whoBui.Zone3_Latent_COOLING_LOAD);
  connect(add[8].u3, whoBui.Zone3_HEATING_LOAD);
  connect(add[9].u1, whoBui.Zone4_Sensible_COOLING_LOAD);
  connect(add[9].u2, whoBui.Zone4_Latent_COOLING_LOAD);
  connect(add[9].u3, whoBui.Zone4_HEATING_LOAD);
  connect(add[10].u1, whoBui.Zone5_Sensible_COOLING_LOAD);
  connect(add[10].u2, whoBui.Zone5_Latent_COOLING_LOAD);
  connect(add[10].u3, whoBui.Zone5_HEATING_LOAD);

  connect(add[11].u1, whoBui.Zone1_top_Sensible_COOLING_LOAD);
  connect(add[11].u2, whoBui.Zone1_top_Latent_COOLING_LOAD);
  connect(add[11].u3, whoBui.Zone1_top_HEATING_LOAD);
  connect(add[12].u1, whoBui.Zone2_top_Sensible_COOLING_LOAD);
  connect(add[12].u2, whoBui.Zone2_top_Latent_COOLING_LOAD);
  connect(add[12].u3, whoBui.Zone2_top_HEATING_LOAD);
  connect(add[13].u1, whoBui.Zone3_top_Sensible_COOLING_LOAD);
  connect(add[13].u2, whoBui.Zone3_top_Latent_COOLING_LOAD);
  connect(add[13].u3, whoBui.Zone3_top_HEATING_LOAD);
  connect(add[14].u1, whoBui.Zone4_top_Sensible_COOLING_LOAD);
  connect(add[14].u2, whoBui.Zone4_top_Latent_COOLING_LOAD);
  connect(add[14].u3, whoBui.Zone4_top_HEATING_LOAD);
  connect(add[15].u1, whoBui.Zone5_top_Sensible_COOLING_LOAD);
  connect(add[15].u2, whoBui.Zone5_top_Latent_COOLING_LOAD);
  connect(add[15].u3, whoBui.Zone5_top_HEATING_LOAD);

  connect(whoBui.Occ, yHvaOpe) annotation (Line(points={{-38,0},{30,0},{30,-84},
          {110,-84}}, color={0,0,127}));
  connect(TDryBul, whoBui.Outdoor_Temperature) annotation (Line(points={{110,60},
          {50,60},{50,0},{-38,0}}, color={0,0,127}));
  connect(TWetBul, whoBui.Wetbulb) annotation (Line(points={{110,90},{-10,90},{
          -10,0},{-38,0}}, color={0,0,127}));
  connect(add.y, QLoa)
    annotation (Line(points={{81,-20},{110,-20}}, color={0,0,127}));
  connect(weaSta.weaBus, whoBui.weaBus) annotation (Line(
      points={{-39.9,49.9},{-50,49.9},{-50,10}},
      color={255,204,51},
      thickness=0.5));
  connect(building.weaBus, whoBui.weaBus) annotation (Line(
      points={{-60,50},{-50,50},{-50,10}},
      color={255,204,51},
      thickness=0.5));
  connect(whoBui.weaBus, weaBus) annotation (Line(
      points={{-50,10},{-50,100},{0,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-154,166},{146,126}},
        textString="%name",
        textColor={0,0,255}),
        Bitmap(extent={{-94,-86},{94,82}}, fileName="modelica://MultizoneOfficeComplexAir/Resources/figure/spawn_icon.png")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is an EnergyPlus (V9.6) wrapper model that calculates the building&rsquo;s thermal loads with the boundary conditions. The inputs are the zone air temperatures from Modelica that is responsible for the airflow calculation (e.g., building infiltration) and HVAC system and controls.</p>

<h4>Architecture</h4>
<p>
    The layout is representative of the large commercial office building 
    stock and is consistent with the building prototypes. The test case is 
    located in Chicago, IL and based on the DOE Reference Large Office Building
    Model (Constructed In or After 1980). The original model has 12 floors with a basement. For 
    simplicity, the middle 10 floors are treated as identical. The ground floor is 
    assumed to be adiabatic with the basement.
</p>
<p>
    The represented floor has five zones, with four perimeter zones and one core zone. 
    Each perimeter zone has a window-to-wall ratio of about 0.38. The height of each 
    zone is 2.74 m and the areas are as follows:
    <ul>
        <li>
        North and South: 313.42 m<sup>2</sup>
        </li>
        <li>
        East and West: 201.98 m<sup>2</sup>
        </li>
        <li>
        Core: 2532.32 m<sup>2</sup>
        </li>
        </ul>
</p>
<p>
    The geometry of the floor is shown as the following figure:
</p>
<p align=\\\"center\\\">
    <img alt=\\\"Zones.\\\"
    src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/Zones.png\" width=400>
</p>


<h4>Constructions</h4>
<p>
    Opaque constructions: Mass walls; built-up flat roof (insulation above deck); 
    slab-on-grade floor.
</p>
<p>
    Windows: Window-to-wall ratio = 38.0%, equal distribution of windows.
</p>
<p>
    Infiltration: The infiltration fraction of the Energyplus model is 0.25 during occupied hours and 1 during unoccupied hours.
</p>
<h4>Occupancy and internal loads schedules</h4>
<p>
    The design occupancy density is 0.05 people/m<sup>2</sup>. The people internal gain is calucalted 
    based on the activity level of 120 W. The number of occupants 
    present in each zone at any time coincides with the internal gain schedule. 
    The occupied time for the HVAC system is between 6:00 and 22:00  each day. 
    The unoccupied time is outside of this period.
</p>
<p>
  The design internal gains include lighting, plug loads, and people. The lighting load is 
  with a radiant-convective-visible split of 70%-10%-20%. The plug load is with a 
  radiant-convective-latent split of 50%-50%-0%. The people load is with a radiant-convective 
  split of 30%-70%. The occupancy and the internal gains are activated according to the 
  schedule in the figure below.
</p>
<p align=\\\"center\\\">
        <img alt=\\\"Schedules.\\\"
        src=\"images/Schedules.png\" width=400>
</p>

<p>
    The power densities of the internal gains are listed in the following table.
</p>
<table cellspacing=\\\"2\\\" cellpadding=\\\"0\\\" border=\\\"0\\\" summary=\\\"Layers\\\">
    <tr>
    <th>Internal Gains</th>
    <th>Power Density [W/m<sup>2</sup>]</th>
    </tr>
    <tr>
    <td>Lighting</td>
    <td>16.14 </td>
    </tr>
    <tr>
    <td>Plug</td>
    <td>10.76</td>
    </tr>

</table>
<h4>Climate data</h4>
<p>
    The weather data is from TMY3 for Chicago O'Hare International Airport.
</p>

<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.LoadSide.BaseClasses.WholeBuildingEnergyPlus\">MultizoneOfficeComplexAir.BaseClasses.LoadSide.BaseClasses.WholeBuildingEnergyPlus</a> for the EnergyPlus model.</p>

</html>", revisions="<html>
<ul>
<li>August 8, 2024, by Guowen Li, Xing Lu, Yan Chen: </li>
<p>Added weather bus.</p>
<li>August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang, Yan Chen: </li>
<p>First implementation.</p>
</ul>
</html>"));
end LoadWrapper;
