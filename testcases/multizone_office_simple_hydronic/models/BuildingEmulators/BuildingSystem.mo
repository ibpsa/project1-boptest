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

  inner IDEAS.Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.UnixTimeStampGMT,yearRef = 2021,outputUnixTimeStamp = true,timZon = 1609459200.0)
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
    connect(bms.Occ,heating_cooling.Occ) annotation(Line(points = {{-37,53.6},{-32,53.6},{-32,-6},{39.6,-6},{39.6,0}},color = {255,0,255}));

   annotation (
    Diagram(experiment(StopTime=31536000), coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<h3>General</h3>
This is the multi-zone office hydronic simple emulator model
of BOPTEST, emulating a 2-zone building model.
Each zone is equipped with independent air handling units (AHUs) for ventilation
and circuits connected to fan-coil units (also known as ventiloconvectors) as the emission system.
Heat/cold is procuded by means of a gas boiler and a chiller.
</p>
<h3>Building Design and Use</h3>
<h4>Architecture</h4>
<p>
The building test case is modeled as a rectangular building
of 40x25 m and 15 m of height.
The height of each floor is considered to be 3 m,
and at each floor internal floors are added to account for the thermal mass.
Hence, the total floor area to be conditioned is 5000 m<sup>2</sup>.
The building is divided in two zones/spaces of equal floor area,
with their main façades oriented towards north (NZ) and south (SZ) respectively.
Each zone has a window-to-wall ratio of 50%.
</p>
<h4>Constructions</h4>
<p><b>Exterior walls</b> </p>
<p>
The walls are modelled using
IDEAS.Buildings.Components.OuterWall and consist of the following layers:
</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\" summary=\'Layers\'>
<tr>
<td><h4>Name</h4></td>
<td><h4>Thickness [m]</h4></td>
<td><h4>Thermal Conductivity [W/(m·K)]</h4></td>
<td><h4>Specific Heat Capacity [J/(kg·K)]</h4></td>
<td><h4>Density [kg/m<sup>3</sup>]</h4></td>
</tr>
<tr>
<td><p>Layer 1 (external masonry)</p></td>
<td><p>0.08</p></td>
<td><p>0.89</p></td>
<td><p>800</p></td>
<td><p>1920</p></td>
</tr>
<tr>
<td><p>Layer 2 (glasswool)</p></td>
<td><p>0.10</p></td>
<td><p>0.035</p></td>
<td><p>800</p></td>
<td><p>60</p></td>
<tr>
</tr>
<tr>
<td><p>Layer 3 (interior masonry)</p></td>
<td><p>0.14</p></td>
<td><p>0.3</p></td>
<td><p>880</p></td>
<td><p>850</p></td>
</tr>
<tr>
<td><p>Layer 4 (gypsum)</p></td>
<td><p>0.015</p></td>
<td><p>0.38</p></td>
<td><p>840</p></td>
<td><p>1120</p></td>
</tr>
</table>

<p>The average U-value is 0.28 W/(m<sup>2</sup>K)</p>

<p><b>Floor</b> </p>
<p>
The floor is modelled using
IDEAS.Buildings.Components.SlabOnGround
IDEAS.Buildings.Components.SlabOnGround and consists of the following layers:
</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\" summary=\'Layers\'>
<tr>
<td><h4>Name</h4></td>
<td><h4>Thickness [m]</h4></td>
<td><h4>Thermal Conductivity [W/(m·K)]</h4></td>
<td><h4>Specific Heat Capacity [J/(kg·K)]</h4></td>
<td><h4>Density [kg/m<sup>3</sup>]</h4></td>
</tr>
<tr>
<td><p>Layer 1 (concrete)</p></td>
<td><p>0.1</p></td>
<td><p>1.4</p></td>
<td><p>900</p></td>
<td><p>2240</p></td>
</tr>
<tr>
<td><p>Layer 2 (polyurethane foam)</p></td>
<td><p>0.07</p></td>
<td><p>0.025</p></td>
<td><p>1500</p></td>
<td><p>40</p></td>
</tr>
<tr>
<td><p>Layer 3 (screed)</p></td>
<td><p>0.05</p></td>
<td><p>1.3</p></td>
<td><p>1000</p></td>
<td><p>2000</p></td>
</tr>
<tr>
<td><p>Layer 4 (tile)</p></td>
<td><p>0.01</p></td>
<td><p>1.4</p></td>
<td><p>840</p></td>
<td><p>2100</p></td>
</tr>
</table>

<p>The average U-value is 0.32 W/(m<sup>2</sup>K)</p>

<p><b>Roof</b> </p>
<p>
The roof is modelled using
IDEAS.Buildings.Components.OuterWall and consist of the following layers:
</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\" summary=\'Layers\'>
<tr>
<td><h4>Name</h4></td>
<td><h4>Thickness [m]</h4></td>
<td><h4>Thermal Conductivity [W/(m·K)]</h4></td>
<td><h4>Specific Heat Capacity [J/(kg·K)]</h4></td>
<td><h4>Density [kg/m<sup>3</sup>]</h4></td>
</tr>
<tr>
<td><p>Layer 1 (screed)</p></td>
<td><p>0.02</p></td>
<td><p>1.3 </p></td>
<td><p>1000 </p></td>
<td><p>2000 </p></td>
</tr>
<tr>
<td><p>Layer 2 (glasswool)</p></td>
<td><p>0.10</p></td>
<td><p>0.035</p></td>
<td><p>800</p></td>
<td><p>60</p></td>
<tr>
<tr>
<td><p>Layer 3 (plywood)</p></td>
<td><p>0.02</p></td>
<td><p>0.15</p></td>
<td><p>1880</p></td>
<td><p>540</p></td>
</tr>
</table>

<p>The average U-value is 0.32 W/(m<sup>2</sup>K)</p>

<p><b>Internal walls</b> </p>
<p>
The internal walls that separate the zones in the building are modelled using
IDEAS.Buildings.Components.InternalWall and consist of the following layers:
</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\" summary=\'Layers\'>
<tr>
<td><h4>Name</h4></td>
<td><h4>Thickness [m]</h4></td>
<td><h4>Thermal Conductivity [W/(m·K)]</h4></td>
<td><h4>Specific Heat Capacity [J/(kg·K)]</h4></td>
<td><h4>Density [kg/m<sup>3</sup>]</h4></td>
</tr>
<tr>
<td><p>Layer 1 (gypsum)</p></td>
<td><p>0.015</p></td>
<td><p>0.38</p></td>
<td><p>840</p></td>
<td><p>1120</p></td>
</tr>
<tr>
<td><p>Layer 2 (interior masonry)</p></td>
<td><p>0.07</p></td>
<td><p>0.3</p></td>
<td><p>880</p></td>
<td><p>850</p></td>
</tr>
<tr>
<td><p>Layer 3 (gypsum)</p></td>
<td><p>0.015</p></td>
<td><p>0.38</p></td>
<td><p>840</p></td>
<td><p>1120</p></td>
</tr>
</table>

<p>The average U-value is 1.78 W/(m<sup>2</sup>K)</p>

<p><b>Internal floors</b> </p>
<p>
The internal floors that separate each zone floors in the building are modelled to add thermal mass using
IDEAS.Buildings.Components.InternalWall and consist of the following layers:
</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\" summary=\'Layers\'>
<tr>
<td><h4>Name</h4></td>
<td><h4>Thickness [m]</h4></td>
<td><h4>Thermal Conductivity [W/(m·K)]</h4></td>
<td><h4>Specific Heat Capacity [J/(kg·K)]</h4></td>
<td><h4>Density [kg/m<sup>3</sup>]</h4></td>
</tr>
<tr>
<td><p>Layer 1 (tile)</p></td>
<td><p>0.01</p></td>
<td><p>1.4</p></td>
<td><p>840</p></td>
<td><p>2100</p></td>
</tr>
<tr>
<td><p>Layer 2 (concrete)</p></td>
<td><p>0.25</p></td>
<td><p>1.4</p></td>
<td><p>900</p></td>
<td><p>2240</p></td>
</tr>
<tr>
<td><p>Layer 3 (tile)</p></td>
<td><p>0.01</p></td>
<td><p>1.4</p></td>
<td><p>840</p></td>
<td><p>2100</p></td>
</tr>
</table>

<p>The average U-value is 2.26 W/(m<sup>2</sup>K)</p>

<p><b>Windows</b> </p>
<p>
The windows are modelled using IDEAS.Buildings.Components.Window
and the glazing information of IDEAS.Buildings.Data.Glazing.Ins2Ar2020,
with an U-value of 1.028 W/(m<sup>2</sup>K) and a g-value of 0.551.
The window model assumes that the frame occupies 15% of the area
and is made of insulated aluminium, with an U-value of 2.8 W/(m<sup>2</sup>K).
</p>


<h4>Occupancy schedules</h4>
<p>
The design occupancy density is one occupant per 15 m<sup>2</sup>.
The number of occupants present in each zone is equally divided
and takes the following normalized profile for one day.

<p align=\'center\'>
<img alt=\'Normalized occupancy schedule.\'
src='modelica://BuildingEmulators/images/occupancySchedule.png' width=400 />
</p>

The occupied time for the HVAC system is between 7 AM and 7 PM during the weekdays.
The unoccupied time is outside of this period.
During summer months (July and August), the occupancy is reduced by half
since it is assumed people takes holiday and the work load is reduced.
A bank holiday schedule is also implemented according to the Belgian calendar
for the following days:
<ul>
<li>January 1st</li>
<li>April 17th</li>
<li>April 18th</li>
<li>May 1st</li>
<li>May 26th</li>
<li>June 5th</li>
<li>June 6th</li>
<li>July 21st</li>
<li>August 15th</li>
<li>November 1st</li>
<li>November 11th</li>
<li>December 25th</li>
</ul>

</p>
<h4>Internal loads and schedules</h4>
<p>
Internal gains from occupancy are taken as 45 W of latent heat and 73 W of sensible heat for
<a href=\'https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Buildings/Components/OccupancyType/OfficeWork.mo\'>typical office work</a>,
with a convective-radiative split of 40/60% respectively.
</p>
<p>
Internal gains from lighting are taken for <a href='https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Buildings/Components/RoomType/Office.mo'>office lighting requirements</a> of 500 lx (based on standard EN 12464-1)
and <a href='https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Buildings/Components/LightingType/LED.mo'>LEDs</a>
with an efficiency of 150 lm/W and with a convective-radiative split of 65/35% respectively.
</p>

<p>
Internal gains from appliances are assumed to have a convective-radiative split of 70/30% respectively and are distributed as follows:
<ul>
<li>A base load of idle components per zone: a printer, a copier, two projector screens and a coffe machine; totalling 1175 W per zone.</li>
<li>An occupancy dependant load of per zone: a workstation and a monitors per occupant; totalling 155 W extra per occupant.</li>
</ul>
these values are taken from ASHRAE appliances data.
</p>


<h4>Climate data</h4>
<p>
The weather data is from TMY3 for Uccle, Brussels, Belgium, between the years 2007 and 2021.
The weather file is hosted in <a href='https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Resources/weatherdata/BEL_VLG_Uccle.064470_TMYx.2007-2021.mos'>IDEAS</a>.
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
The emission system (ventiloconvectors) nominal powers are determined by using the following rules of thumb for design.
<ul>
<li>North zone:
<ul>
<li>30 W/m<sup>2</sup> for heating</li>
<li>40 W/m<sup>2</sup> for cooling</li>
</ul>
</li>
<li>South zone:
<ul>
<li>25 W/m<sup>2</sup> for heating</li>
<li>45 W/m<sup>2</sup> for cooling</li>
</ul>
</li>
</ul>
As such, the nominal powers of the emission system are 75 and 100 kW for heating and cooling respectively for the north zone
and 62.5 and 112.5 kW for heating and cooling respectively for the south zone.
The mass flow rates of the emission loops are determined using the relation:
</p>
<p align=\'center\'>
Q<sub>design</sub> = m<sub>flow</sub> c<sub>p</sub> ΔT
</p>
<p>
where Q<sub>nominal</sub> is the nominal heat flow, m<sub>flow</sub> is the nominal mass flow rate,
c<sub>p</sub> is the specific heat capacity of the media and ΔT is the nominal temperature difference.
This nominal temperature difference is a design parameter and it is assumed to be 20 K and
5 K for the water stream for heating and cooling respectively,
and 10 K for the air stream (both for the heating and cooling coil) in the ventiloconvector.
The heat exchange coefficients (UA) of the heat exchangers in the ventiloconvectors are computed by the model
from these nominal values using the <a href=https://en.wikipedia.org/wiki/NTU_method>NTU method</a>.
</p>

<p>
The ventilation system is composed by two individual air handling units (AHUs) per zone.
These AHUs are equipped with a double mechanical flux system (i.e., a supply and a return fan),
a heat recovery system and a heating and cooling coils.
No humidifier/dehumidifer system is installed.
No variable air volume (VAV) boxes are equipped in the ventilation ducts.
However, the fans of the AHU can modulate their pressure head to achieve the required ventilation rate.
The nominal supply and return air flow rates are computed based on the volume of the zones to be conditioned,
and they are 3 kg/s and 2.5 kg/s of air respectively.
Based on this nominal air flows, the nominal powers and nominal mass flow rates of the heating and cooling coils
are calculated using the same relations as for the emission system.
The nominal temperature differences in this case are 20 K and
5 K for the water stream for heating and cooling respectively,
and 30 K and 15 K for the air stream for heating and cooling respectively.
As a result, for each individual AHU the nominal heating power is 90 kW
whereas the nominal cooling power is 45 kW.
The heat recovery exchanger is assumed to have a constant effectiveness of 84%.
</p>

<p>
The production system is composed by a gas boiler for heating and a chiller for cooling.
The nominal powers of the production system are determined by the sum of the nominal powers
of each emission and ventilation coil loop, which are 75+62.5+90+90=317.5 kW and 100+112.5+45+45=302.5 kW
for heating and cooling respectively.
The nominal mass flow rates are calculated from the resulting heating and cooling nominal powers.
</p>

<p>
The production system is connected to the emission and ventilation systems through the distribution system shown
in the schematic below.
The production system supplies heat/cold to a supply manifold or collector.
From here, the different circuit loops distribute the water to the different heat exchangers
in the emission system or the ventilation system.
Each circuit loop is equipped with a pump that allows to activate the circuit and a
mixing 3-way valve placed downstream the pump, which allows to regulate the supply temperature in the distribution loop.
</p>

<p>
In addition, each heat exchanger is internally equipped with a 3-way valve that allows to regulate the heating or cooling load.
However, this component should be seen as an internal part of the heat exchanger and not the distribution system.
</p>

<p align=\'center\'>
<img alt=\'Building schematic.\'
src='modelica://BuildingEmulators/images/schematic.svg' width=1200 />
</p>


<h4>Equipment specifications and performance maps</h4>

<p><b>Boiler</b> </p>
<p>
The gas boiler efficiency is dependant on the supply temperature imposed.
The gas boiler efficiency has a linear term with respect to the supply temperature and,
when the condensation temperature occurs (around 45 &#176;C), a sudden increase of
the efficiency occurs which is modeled with a sigmoid function.
The efficiency can thus be expressed as:
</p>
<p>
ε = 2.46575 - 0.005 T<sub>supply</sub> + 0.1/(1+(e<sup>(T<sub>supply</sub> - T<sub>condensation</sub>)</sup>))
</p>
<p>
where T<sub>supply</sub> is in Kelvin and T<sub>condensation</sub> is 273.15+45 K.
In essence, the boiler efficiency is 75% at 70 &#176;C and 105% at 30 &#176;C
The above expression can be visualized as:
</p>

<p align=\'center\'>
<img alt=\'Gas boiler efficiency.\'
src='modelica://BuildingEmulators/images/boiler_efficiency.png' width=500 />
</p>

<p><b>Chiller</b> </p>
<p>
The energy efficiency ratio (EER) of the chiller is dependant on the supply temperature imposed
and the ambient temperature,
and takes the following bi-linear relation:
</p>
<p>
EER = -68.5 + 0.4 T<sub>supply</sub> - 4/30 T<sub>ambient</sub>
</p>
<p>
where T<sub>supply</sub> and T<sub>ambient</sub> are in Kelvin.
In essence, the chiller nominal EER (at 7 &#176;C supply and 35 &#176;C ambient temperature) is 2.5.
</p>

<p><b>Fluid movers</b> </p>
<p>
The supply and return fans of the air handling units have a nominal pressure drop of 250 Pa and 180 Pa respectively, and follow the pressure curve
given by <a href='https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Examples/PPD12/Data/FanCurvePP12.mo'>IDEAS.Examples.PPD12.Data.FanCurvePP12</a>
with adapted motor effiency such that their power at nominal speed is 3.50 and 2.15 kW respectively.
</p>

<p>
The ventiloconvector fans follow the <a href='https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Fluid/Movers/Data/Generic.mo'>generic</a>
curve of the model and have their nominal pressure drop is calibrated such that at nominal mass flow rate their power use is 2.5 kW,
based on data from JAGA manufacturer.
</p>
<p>
The pumps of the distribution and production system follow the <a href='https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Fluid/Movers/Data/Generic.mo'>generic</a>
curve of the model and have the following nominal pressure heads and powers:
<ul>
<li>
Production pumps:
<ul>
<li>Heating: 6 m head and 470 W</li>
<li>Cooling: 6 m head and 1.8 kW</li>
</ul>
</li>
<li>
Distribution pumps:
<ul>
<li>Emission:
<ul>
<li>Heating north zone: 12 m head and 220 W</li>
<li>Cooling north zone: 12 m head and 1.2 kW</li>
<li>Heating south zone: 12 m head and 185 W</li>
<li>Cooling south zone: 12 m head and 1.3 kW</li>
</ul>
</li>
<li>Ventilation:
<ul>
<li>Heating north zone: 9 m head and 200 W</li>
<li>Cooling north zone: 9 m head and 400 W</li>
<li>Heating south zone: 9 m head and 200 W</li>
<li>Cooling south zone: 9 m head and 400 W</li>
</ul>
</li>
</ul>
</li>
</ul>
</p>

<h4>Rule-based or local-loop controllers (if included)</h4>

<p>
The model is equipped with a BMS baseline controller that attempts to keep the
temperature and IEQ requirements, also depicted in the hydraulic schematic.
Internal controls of the emission and ventilation system are not communicated/exported to the BMS,
hence cannot be overridden.
</p>
<p>
A minimum and maximum zone set-points can be defined by the user,
which are 21/25 &#176;C when the building is occupied.
When the building is empty, a night setback of ±5 &#176;C is applied.
These set-points are input to the ventiloconvectors,
whose internal controls (not connected to the BMS) will actuate
on their fans and internal 3-way valves to keep the building within the defined boundaries.
The distribution pumps connected to the emission system are activated following a schedule control:
the heating/cooling pumps are activated every working day from 6AM (to allow pre-conditioning of the space)
and de-activated at 7PM, except from Mondays where the activation time is 4AM to compensate for the weekend.
</p>

<p>
The AHUs are controlled based on the building occupancy.
Whenever the building is occupied, the AHUs supply and extract air at their nominal flow rate.
The baseline controller does not have any feedback from the CO<sub>2</sub> measurements in the zones.
The distribution pumps connected to the ventilation system are activated following the same schedule.
A constant air supply set-point of 21 &#176;C is set by the baseline controller.
The internal controls of the AHUs (not connected to the BMS) manage the
internal 3-way valves in the heating/cooling coils and the recovery by-pass to achieve the desired air supply set-point.
The by-pass control of the AHUs is connected to the BMS,
unlocking the possibility of free cooling during nights.
However, this feature is not implemented in the baseline controller.
</p>

<p>
The mixing 3-way valves in the distribution system modulate to track
a given supply set-point.
For the ventiloconvectors, the set-points follow a heating/cooling curve
based only in the outdoor temperature (no room compensation is included).
<ul>
<li>The heating curve of the ventiloconvector heating coil takes the following points:</li>
	<ul>
	<li>70 &#176;C when the outdoor temperature is -10 &#176;C</li>
	<li>40 &#176;C when the outdoor temperature is 20 &#176;C</li>
	</ul>
<li>The cooling curve of the ventiloconvector cooling coil takes the following points:</li>
	<ul>
	<li>7 &#176;C when the outdoor temperature is 35 &#176;C</li>
	<li>12 &#176;C when the outdoor temperature is 15 &#176;C</li>
	</ul>
</ul>


For the ventilation coils, these set-points are set constant to:
<ul>
<li>50 &#176;C for the heating coil in the AHUs</li>
<li>9 &#176;C for the heating coil in the AHUs</li>
</ul>
The modulation is achieved by means of PI controllers.
All PIs have a constant gain of 0.2 and an integral gain of 30s.
The model allows to override either the set-point to be tracked by the PI
or the valve position directly.
</p>

<p>
The production system ideally tracks a given supply temperature set-point.
The heating production system follows the maximum of the heating distribution set-points.
The cooling production system follows the minimum of the cooling distribution set-points.
The pumps in the production system are activated whenever at least one of the
distribution pumps is activated.
</p>


<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>bms_oveByPassNz_u</code> [1] [min=0.0, max=1.0]: North zone AHU setpoint to override the recovery bypass (for night free cooling purposes)
</li>
<li>
<code>bms_oveByPassSz_u</code> [1] [min=0.0, max=1.0]: South zone AHU setpoint to override the recovery bypass (for night free cooling purposes)
</li>
<li>
<code>bms_ovePrfAhuCooNz_u</code> [1] [min=0.0, max=1.0]: North zone AHU cooling circuit activation setpoint
</li>
<li>
<code>bms_ovePrfAhuCooSz_u</code> [1] [min=0.0, max=1.0]: South zone AHU cooling circuit activation setpoint
</li>
<li>
<code>bms_ovePrfAhuHeaNz_u</code> [1] [min=0.0, max=1.0]: North zone AHU heating circuit activation setpoint
</li>
<li>
<code>bms_ovePrfAhuHeaSz_u</code> [1] [min=0.0, max=1.0]: South zone AHU heating circuit activation setpoint
</li>
<li>
<code>bms_ovePrfAhuRetNz_u</code> [1] [min=0.0, max=1.0]: North zone AHU return fan setpoint
</li>
<li>
<code>bms_ovePrfAhuRetSz_u</code> [1] [min=0.0, max=1.0]: South zone AHU return fan setpoint
</li>
<li>
<code>bms_ovePrfAhuSupNz_u</code> [1] [min=0.0, max=1.0]: North zone AHU supply fan setpoint
</li>
<li>
<code>bms_ovePrfAhuSupSz_u</code> [1] [min=0.0, max=1.0]: South zone AHU supply fan setpoint
</li>
<li>
<code>bms_ovePrfEmiCooNz_u</code> [1] [min=0.0, max=1.0]: North zone emission cooling circuit activation setpoint
</li>
<li>
<code>bms_ovePrfEmiCooSz_u</code> [1] [min=0.0, max=1.0]: South zone emission cooling circuit activation setpoint
</li>
<li>
<code>bms_ovePrfEmiHeaNz_u</code> [1] [min=0.0, max=1.0]: North zone emission heating circuit activation setpoint
</li>
<li>
<code>bms_ovePrfEmiHeaSz_u</code> [1] [min=0.0, max=1.0]: South zone emission heating circuit activation setpoint
</li>
<li>
<code>bms_ovePrfProCoo_u</code> [1] [min=0.0, max=1.0]: Cooling production system pump activation setpoint
</li>
<li>
<code>bms_ovePrfProHea_u</code> [1] [min=0.0, max=1.0]: Heating production system supply temperature setpoint
</li>
<li>
<code>bms_oveTProCoo_u</code> [K] [min=273.15, max=293.15]: Cooling production system supply temperature setpoint
</li>
<li>
<code>bms_oveTProHea_u</code> [K] [min=293.15, max=353.15]: Heating production system supply temperature setpoint
</li>
<li>
<code>bms_oveTSupAhuCooNz_u</code> [K] [min=273.15, max=293.15]: North zone AHU cooling water supply temperature setpoint
</li>
<li>
<code>bms_oveTSupAhuCooSz_u</code> [K] [min=273.15, max=293.15]: South zone AHU cooling water supply temperature setpoint
</li>
<li>
<code>bms_oveTSupAhuHeaNz_u</code> [K] [min=293.15, max=353.15]: North zone AHU heating water supply temperature setpoint
</li>
<li>
<code>bms_oveTSupAhuHeaSz_u</code> [K] [min=293.15, max=353.15]: South zone AHU heating water supply temperature setpoint
</li>
<li>
<code>bms_oveTSupAhuNz_u</code> [K] [min=289.15, max=298.15]: North zone AHU air supply temperature setpoint
</li>
<li>
<code>bms_oveTSupAhuSz_u</code> [K] [min=289.15, max=298.15]: South zone AHU air supply temperature setpoint
</li>
<li>
<code>bms_oveTSupEmiCooNz_u</code> [K] [min=273.15, max=293.15]: North zone cooling emission circuit supply temperature setpoint
</li>
<li>
<code>bms_oveTSupEmiCooSz_u</code> [K] [min=273.15, max=293.15]: South zone cooling emission circuit supply temperature setpoint
</li>
<li>
<code>bms_oveTSupEmiHeaNz_u</code> [K] [min=293.15, max=353.15]: North zone heating emission circuit supply temperature setpoint
</li>
<li>
<code>bms_oveTSupEmiHeaSz_u</code> [K] [min=293.15, max=353.15]: South zone heating emission circuit supply temperature setpoint
</li>
<li>
<code>bms_oveTZonSetMaxNz_u</code> [K] [min=288.15, max=303.15]: North zone maximum (cooling) zone temperature setpoint
</li>
<li>
<code>bms_oveTZonSetMaxSz_u</code> [K] [min=288.15, max=303.15]: South zone maximum (cooling) zone temperature setpoint
</li>
<li>
<code>bms_oveTZonSetMinNz_u</code> [K] [min=288.15, max=303.15]: North zone minimum (heating) zone temperature setpoint
</li>
<li>
<code>bms_oveTZonSetMinSz_u</code> [K] [min=283.15, max=303.15]: South zone minimum (heating) zone temperature setpoint
</li>
<li>
<code>bms_oveValPosAhuCooNz_u</code> [1] [min=0.0, max=1.0]: North zone AHU cooling circuit mixing valve position setpoint
</li>
<li>
<code>bms_oveValPosAhuCooSz_u</code> [1] [min=0.0, max=1.0]: South zone AHU cooling circuit mixing valve position setpoint
</li>
<li>
<code>bms_oveValPosAhuHeaNz_u</code> [1] [min=0.0, max=1.0]: North zone AHU heating circuit mixing valve position setpoint
</li>
<li>
<code>bms_oveValPosAhuHeaSz_u</code> [1] [min=0.0, max=1.0]: South zone AHU heating circuit mixing valve position setpoint
</li>
<li>
<code>bms_oveValPosEmiCooNz_u</code> [1] [min=0.0, max=1.0]: North zone cooling emission circuit mixing valve position setpoint
</li>
<li>
<code>bms_oveValPosEmiCooSz_u</code> [1] [min=0.0, max=1.0]: South zone cooling emission circuit mixing valve position setpoint
</li>
<li>
<code>bms_oveValPosEmiHeaNz_u</code> [1] [min=0.0, max=1.0]: North zone heating emission circuit mixing valve position setpoint
</li>
<li>
<code>bms_oveValPosEmiHeaSz_u</code> [1] [min=0.0, max=1.0]: South zone heating emission circuit supply mixing valve position setpoint
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>heating_cooling_reaPFcuNz_y</code> [W] [min=None, max=None]: Electric power used by the north zone fan coil units
</li>
<li>
<code>heating_cooling_reaPFcuSz_y</code> [W] [min=None, max=None]: Electric power used by the south zone fan coil units
</li>
<li>
<code>heating_cooling_reaPProCoo_y</code> [W] [min=None, max=None]: Electric power used by the cooling production system
</li>
<li>
<code>heating_cooling_reaPProHea_y</code> [W] [min=None, max=None]: Gas power used by the heating production system
</li>
<li>
<code>heating_cooling_reaPPumAhuCooNz_y</code> [W] [min=None, max=None]: Electric power used by the north zone cooling AHU water system pump
</li>
<li>
<code>heating_cooling_reaPPumAhuCooSz_y</code> [W] [min=None, max=None]: Electric power used by the south zone cooling AHU water system pump
</li>
<li>
<code>heating_cooling_reaPPumAhuHeaNz_y</code> [W] [min=None, max=None]: Electric power used by the north zone heating AHU water system pump
</li>
<li>
<code>heating_cooling_reaPPumAhuHeaSz_y</code> [W] [min=None, max=None]: Electric power used by the south zone heating AHU water system pump
</li>
<li>
<code>heating_cooling_reaPPumEmiCooNz_y</code> [W] [min=None, max=None]: Electric power used by the north zone cooling emission system pump
</li>
<li>
<code>heating_cooling_reaPPumEmiCooSz_y</code> [W] [min=None, max=None]: Electric power used by the south zone cooling emission system pump
</li>
<li>
<code>heating_cooling_reaPPumEmiHeaNz_y</code> [W] [min=None, max=None]: Electric power used by the north zone heating emission system pump
</li>
<li>
<code>heating_cooling_reaPPumEmiHeaSz_y</code> [W] [min=None, max=None]: Electric power used by the south zone heating emission system pump
</li>
<li>
<code>heating_cooling_reaPPumProCoo_y</code> [W] [min=None, max=None]: Electric power used by the cooling production system pump
</li>
<li>
<code>heating_cooling_reaPPumProHea_y</code> [W] [min=None, max=None]: Electric power used by the heating production system pump
</li>
<li>
<code>heating_cooling_reaTRetAhuCooNz_y</code> [K] [min=None, max=None]: North zone cooling AHU water system return temperature
</li>
<li>
<code>heating_cooling_reaTRetAhuCooSz_y</code> [K] [min=None, max=None]: South zone cooling AHU water system return temperature
</li>
<li>
<code>heating_cooling_reaTRetAhuHeaNz_y</code> [K] [min=None, max=None]: North zone heating AHU water system return temperature
</li>
<li>
<code>heating_cooling_reaTRetAhuHeaSz_y</code> [K] [min=None, max=None]: South zone heating AHU water system return temperature
</li>
<li>
<code>heating_cooling_reaTRetEmiCooNz_y</code> [K] [min=None, max=None]: North zone cooling emission system return temperature
</li>
<li>
<code>heating_cooling_reaTRetEmiCooSz_y</code> [K] [min=None, max=None]: South zone cooling emission system return temperature
</li>
<li>
<code>heating_cooling_reaTRetEmiHeaNz_y</code> [K] [min=None, max=None]: North zone heating emission system return temperature
</li>
<li>
<code>heating_cooling_reaTRetEmiHeaSz_y</code> [K] [min=None, max=None]: South zone heating emission system return temperature
</li>
<li>
<code>heating_cooling_reaTRetProCoo_y</code> [K] [min=None, max=None]: Cooling production system return temperature
</li>
<li>
<code>heating_cooling_reaTRetProHea_y</code> [K] [min=None, max=None]: Heating production system return temperature
</li>
<li>
<code>heating_cooling_reaTSupAhuCooNz_y</code> [K] [min=None, max=None]: North zone cooling AHU water system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupAhuCooSz_y</code> [K] [min=None, max=None]: South zone cooling AHU water system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupAhuHeaNz_y</code> [K] [min=None, max=None]: North zone heating AHU water system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupAhuHeaSz_y</code> [K] [min=None, max=None]: South zone heating AHU water system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupEmiCooNz_y</code> [K] [min=None, max=None]: North zone cooling emission system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupEmiCooSz_y</code> [K] [min=None, max=None]: South zone cooling emission system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupEmiHeaNz_y</code> [K] [min=None, max=None]: North zone heating emission system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupEmiHeaSz_y</code> [K] [min=None, max=None]: South zone heating emission system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupProCoo_y</code> [K] [min=None, max=None]: Cooling production system supply temperature
</li>
<li>
<code>heating_cooling_reaTSupProHea_y</code> [K] [min=None, max=None]: Heating production system supply temperature
</li>
<li>
<code>structure_reaCO2ZonNz_y</code> [ppm] [min=None, max=None]: North zone CO2 concentration
</li>
<li>
<code>structure_reaCO2ZonSz_y</code> [ppm] [min=None, max=None]: South zone CO2 concentration
</li>
<li>
<code>structure_reaTZonNz_y</code> [K] [min=None, max=None]: North zone operative temperature
</li>
<li>
<code>structure_reaTZonSz_y</code> [K] [min=None, max=None]: South zone operative temperature
</li>
<li>
<code>structure_reaTZonPercHighNz_y</code> [K] [min=None, max=None]: North zone upper percentile temperature
</li>
<li>
<code>structure_reaTZonPercHighSz_y</code> [K] [min=None, max=None]: South zone upper percentile temperature
</li>
<li>
<code>structure_reaTZonPercLowNz_y</code> [K] [min=None, max=None]: North zone lower percentile temperature
</li>
<li>
<code>structure_reaTZonPercLowSz_y</code> [K] [min=None, max=None]: South zone lower percentile temperature
</li>
<li>
<code>ventilation_reaPAhuRetNz_y</code> [W] [min=None, max=None]: North zone AHU return fan electric power
</li>
<li>
<code>ventilation_reaPAhuRetSz_y</code> [W] [min=None, max=None]: South zone AHU return fan electric power
</li>
<li>
<code>ventilation_reaPAhuSupNz_y</code> [W] [min=None, max=None]: North zone AHU supply fan electric power
</li>
<li>
<code>ventilation_reaPAhuSupSz_y</code> [W] [min=None, max=None]: South zone AHU supply fan electric power
</li>
<li>
<code>ventilation_reaTExhAhuNz_y</code> [K] [min=None, max=None]: North zone AHU air exhaust temperature
</li>
<li>
<code>ventilation_reaTExhAhuSz_y</code> [K] [min=None, max=None]: South zone AHU air exhaust temperature
</li>
<li>
<code>ventilation_reaTInAhuNz_y</code> [K] [min=None, max=None]: North zone AHU air inlet temperature
</li>
<li>
<code>ventilation_reaTInAhuSz_y</code> [K] [min=None, max=None]: South zone AHU air inlet temperature
</li>
<li>
<code>ventilation_reaTRecAhuNz_y</code> [K] [min=None, max=None]: North zone AHU air temperature after recovery
</li>
<li>
<code>ventilation_reaTRecAhuSz_y</code> [K] [min=None, max=None]: South zone AHU air temperature after recovery
</li>
<li>
<code>ventilation_reaTRetAhuNz_y</code> [K] [min=None, max=None]: North zone AHU air return temperature
</li>
<li>
<code>ventilation_reaTRetAhuSz_y</code> [K] [min=None, max=None]: South zone AHU air return temperature
</li>
<li>
<code>ventilation_reaTSupAhuNz_y</code> [K] [min=None, max=None]: North zone AHU air supply temperature
</li>
<li>
<code>ventilation_reaTSupAhuSz_y</code> [K] [min=None, max=None]: South zone AHU air supply temperature
</li>
<li>
<code>weaSta_reaWeaCeiHei_y</code> [m] [min=None, max=None]: Cloud cover ceiling height measurement
</li>
<li>
<code>weaSta_reaWeaCloTim_y</code> [s] [min=None, max=None]: Day number with units of seconds
</li>
<li>
<code>weaSta_reaWeaHDifHor_y</code> [W/m2] [min=None, max=None]: Horizontal diffuse solar radiation measurement
</li>
<li>
<code>weaSta_reaWeaHDirNor_y</code> [W/m2] [min=None, max=None]: Direct normal radiation measurement
</li>
<li>
<code>weaSta_reaWeaHGloHor_y</code> [W/m2] [min=None, max=None]: Global horizontal solar irradiation measurement
</li>
<li>
<code>weaSta_reaWeaHHorIR_y</code> [W/m2] [min=None, max=None]: Horizontal infrared irradiation measurement
</li>
<li>
<code>weaSta_reaWeaLat_y</code> [rad] [min=None, max=None]: Latitude of the location
</li>
<li>
<code>weaSta_reaWeaLon_y</code> [rad] [min=None, max=None]: Longitude of the location
</li>
<li>
<code>weaSta_reaWeaNOpa_y</code> [1] [min=None, max=None]: Opaque sky cover measurement
</li>
<li>
<code>weaSta_reaWeaNTot_y</code> [1] [min=None, max=None]: Sky cover measurement
</li>
<li>
<code>weaSta_reaWeaPAtm_y</code> [Pa] [min=None, max=None]: Atmospheric pressure measurement
</li>
<li>
<code>weaSta_reaWeaRelHum_y</code> [1] [min=None, max=None]: Outside relative humidity measurement
</li>
<li>
<code>weaSta_reaWeaSolAlt_y</code> [rad] [min=None, max=None]: Solar altitude angle measurement
</li>
<li>
<code>weaSta_reaWeaSolDec_y</code> [rad] [min=None, max=None]: Solar declination angle measurement
</li>
<li>
<code>weaSta_reaWeaSolHouAng_y</code> [rad] [min=None, max=None]: Solar hour angle measurement
</li>
<li>
<code>weaSta_reaWeaSolTim_y</code> [s] [min=None, max=None]: Solar time
</li>
<li>
<code>weaSta_reaWeaSolZen_y</code> [rad] [min=None, max=None]: Solar zenith angle measurement
</li>
<li>
<code>weaSta_reaWeaTBlaSky_y</code> [K] [min=None, max=None]: Black-body sky temperature measurement
</li>
<li>
<code>weaSta_reaWeaTDewPoi_y</code> [K] [min=None, max=None]: Dew point temperature measurement
</li>
<li>
<code>weaSta_reaWeaTDryBul_y</code> [K] [min=None, max=None]: Outside drybulb temperature measurement
</li>
<li>
<code>weaSta_reaWeaTWetBul_y</code> [K] [min=None, max=None]: Wet bulb temperature measurement
</li>
<li>
<code>weaSta_reaWeaWinDir_y</code> [rad] [min=None, max=None]: Wind direction measurement
</li>
<li>
<code>weaSta_reaWeaWinSpe_y</code> [m/s] [min=None, max=None]: Wind speed measurement
</li>
</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
Lighting heat gain is included in the zone model whenever there are occupants in the building and it is not controllable.
</p>
<h4>Shading</h4>
<p>
There is no shading on this building.
</p>
<h4>Onsite Generation and Storage</h4>
<p>
There is no onsite generation or storage on this building site.
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
A moist air model is used. Relative humidity is tracked based on latent
heat gain from occupants, outside air relative humidity, and cooling
coil models in the fan coil units and the AHU that includes condensation.
Since the AHU does not include a humidifier/dehumidifer system, this parameter
is not subjected to control.
</p>
<h4>Pressure-flow models</h4>
<p>
The duct airflows and pipe waterflows are modeled using a pressure-flow network.
Air exchange between zones is not modeled.
</p>
<h4>Infiltration models</h4>
<p>
Airflow due to infiltration is calculated using the
<a href=\'https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Buildings/Components/InterzonalAirFlow/n50FixedPressure.mo\'><code>IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure</code></a> model
and a n50 value of 5.
</p>
<h4>CO<sub>2</sub> models</h4>
<p>
CO<sub>2</sub> generation in the zones is calculated using the
<a href=\'https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Buildings/Components/InternalGains/Occupants.mo\'><code>IDEAS.Buildings.Components.Occupants</code></a> and
<a href=\'https://github.com/open-ideas/IDEAS/blob/master/IDEAS/Buildings/Components/OccupancyType/OfficeWork.mo\'><code>IDEAS.Buildings.Components.OccupancyType.OfficeWork</code></a>
models.
Outside air CO<sub>2</sub> concentration is 400 ppm.
</p>

<h3>Scenario Information</h3>
<h4>Time Periods</h4>
<p>
The <b>Peak Heat Day</b> (specifier for <code>/scenario</code> API is <code>'peak_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with the
maximum 15-minute system heating load in the year.
</ul>
<ul>
Start Time: Day 346.
</ul>
<ul>
End Time: Day 360.
</ul>
</p>
<p>
The <b>Typical Heat Day</b> (specifier for <code>/scenario</code> API is <code>'typical_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with day with
the maximum 15-minute system heating load that is closest from below to the
median of all 15-minute maximum heating loads of all days in the year.
</ul>
<ul>
Start Time: Day 136.
</ul>
<ul>
End Time: Day 150.
</ul>
</p>
<p>
The <b>Peak Cool Day</b> (specifier for <code>/scenario</code> API is <code>'peak_cool_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with the
maximum 15-minute system cooling load in the year considering only daytime hours
(peaks due to morning start up, before 10 am, not included since many days have similar peaks
due to start up).
</ul>
<ul>
Start Time: Day 213.
</ul>
<ul>
End Time: Day 227.
</ul>
</p>
<p>
The <b>Typical Cool Day</b> (specifier for <code>/scenario</code> API is <code>'typical_cool_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with
the maximum 15-minute system cooling load that is closest from below to the
median of all 15-minute maximum cooling loads of all days in the year
(peaks due to morning start up, before 10 am, not included since many days have similar peaks
due to start up).
</ul>
<ul>
Start Time: Day 88.
</ul>
<ul>
End Time: Day 102.
</ul>
</p>
<p>
The <b>Mix Day</b> (specifier for <code>/scenario</code> API is <code>'mix_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with the maximimum
sum of daily heating and cooling loads minus the difference between
daily heating and cooling loads. This is a day with both significant heating
and cooling loads.
</ul>
<ul>
Start Time: Day 286.
</ul>
<ul>
End Time: Day 300.
</ul>
</p>
<h4>Energy Pricing</h4>
<p>
The gas price is considered constant at a value of 0.0464 EUR/kWh,
corresponding to the average prices for Belgian buildings with an
energy use between 20 and 500 MWh/year for the year 2015.
(Eurostat. Gas prices for industrial consumers - bi-annual data (from
2007 onwards). Tech. rep., 2016. and Eurostat. Electricity prices components for industrial consumers -
annual data (from 2007 onwards). Tech. rep., 2017.)
</p>
<p>
The <b>Constant Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'constant'</code>) profile is:
<ul>
The electricity price is 0.1466 EUR/kWh,
corresponding to the average prices for Belgian buildings with an
energy use between 20 and 500 MWh/year for the year 2015.
(Eurostat. Gas prices for industrial consumers - bi-annual data (from
2007 onwards). Tech. rep., 2016. and Eurostat. Electricity prices components for industrial consumers -
annual data (from 2007 onwards). Tech. rep., 2017.)
</ul>
</p>
<p>
The <b>Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'dynamic'</code>) profile is:
<ul>
The dynamic electricity price scenario is prorrated using the constant electricity
price scenario. The resulting dynamic electricity prices are of 0.1542 EUR/kWh
during on-peak periods and of 0.1378 EUR/kWh during off-peak periods.
The on-peak daily period takes place between 7:00 a.m. and 10:00 p.m.
The off-peak daily period takes place between 10:00 p.m. and 7:00 a.m.
</ul>
</p>
<p>
The <b>Highly Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'highly_dynamic'</code>) profile is:
<ul>
The highly dynamic electricity price scenario is based on the the Belgian day-ahead
energy prices as determined by the BELPEX wholescale electricity market in the year 2019,
and prorrated using the constant electricity price scenario.
Obtained from: <a href='https://my.elexys.be/MarketInformation/SpotBelpex.aspx'>
https://my.elexys.be/MarketInformation/SpotBelpex.aspx</a>.
</ul>
</p>
<h4>Emission Factors</h4>

<p>
It is used a constant emission factor for gas of 0.22 kgCO2/kWh as reported by
the Centre for Environmental Economics and Environmental Management
(CEEM - Centre for Environmental Economics and Environmental
Management. Universiteit Gent. https://ceem.ugent.be/en/index.htm.).
</p>
<p>
It is used a hourly variable emission factor for electricity, extracted from
<a href='https://app.electricitymaps.com/map'>
Electricity Maps</a>
for the year 2019.
</p>

</html>',     revisions='<html>
<ul>
<li>
August 4, 2022 by Iago Cupeiro:<br/>
First implementation.
</li>
</ul>
</html>"));
end BuildingSystem;
