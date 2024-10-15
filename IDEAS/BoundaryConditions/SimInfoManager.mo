within IDEAS.BoundaryConditions;
model SimInfoManager
  "Simulation information manager for handling time and climate data required in each for simulation."
  extends BoundaryConditions.Interfaces.PartialSimInfoManager(
    Te = TDryBul.y,TeAv = Te,
    Tground=TdesGround,
    relHum = phiEnv.y,
    TDewPoi = TDewPoiData.y,
    Tsky = TBlaSkyData.y,
    Va = winSpeData.y,
    Vdir = winDirData.y);

protected
  Modelica.Blocks.Routing.RealPassThrough HDirNorData;
  Modelica.Blocks.Routing.RealPassThrough HGloHorData;
  Modelica.Blocks.Routing.RealPassThrough HDiffHorData;
  Modelica.Blocks.Routing.RealPassThrough TDryBulData;
  Modelica.Blocks.Routing.RealPassThrough relHumData;
  Modelica.Blocks.Routing.RealPassThrough TDewPoiData;
  Modelica.Blocks.Routing.RealPassThrough nOpaData;
  Modelica.Blocks.Routing.RealPassThrough winSpeData;
  Modelica.Blocks.Routing.RealPassThrough winDirData;
  Modelica.Blocks.Routing.RealPassThrough TBlaSkyData;
equation


  connect(HDirNorData.u, weaDatBus.HDirNor);
  connect(HGloHorData.u, weaDatBus.HGloHor);
  connect(HDiffHorData.u, weaDatBus.HDifHor);
  connect(TDryBulData.u, weaDatBus.TDryBul);
  connect(relHumData.u, weaDatBus.relHum);
  connect(TDewPoiData.u, weaDatBus.TDewPoi);
  connect(nOpaData.u, weaDatBus.nOpa);
  connect(winSpeData.u, weaDatBus.winSpe);
  connect(winDirData.u, weaDatBus.winDir);
  connect(TBlaSkyData.u, weaDatBus.TBlaSky);
  annotation (
    defaultComponentName="sim",
    defaultComponentPrefixes="inner",
    missingInnerMessage=
        "Your model is using an outer \"sim\" component. An inner \"sim\" component is not defined. For simulation drag IDEAS.BoundaryConditions.SimInfoManager into your model.",
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={
        Bitmap(extent={{22,-8},{20,-8}}, fileName="")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,160}})),
    Documentation(info="<html>
<p>
The SimInfoManager manages all simulation information. 
It loads TMY3 weather data files and applies transformations 
for computing the solar irradiance on the zone surfaces. 
</p>
<h4>Typical use and important parameters</h4>
<ul>
<li>
Parameters <code>filNam</code> and <code>filDir</code> can be used to set the path to the TMY3 weather file.
This file should include the latitude, longitude and time zone corresponding to the weather file.
See the included weather files for the correct format.
</li>
</ul>
<h4>Options</h4>
<ul>
<li>
IDEAS contains an efficient implementation for computing the solar 
incidence angles on surfaces that are part of large building models.
When a model has many parallel surfaces the default implementation computes
the solar irradiance separately for each of these surfaces, 
while the result for all of them should be the same.
The SimInfoManager computes five default orientations (azimuth angels): 
south, west, east, north and horizontal.
Whenever a surface needs the solar incidence angels for one of these orientations
these precomputed values will be used.
The default orientations can be changed using parameters 
<code>incAndAziInBus</code>.
<code>incAndAziInBus</code> determines for which inclination and azimuth the solar radiation is pre-computed.
</li>
<li>Conservation of energy within the building can be checked by setting <code>computeConservationOfEnergy=true</code>.
Conservation of energy is checked by computing the internal energy for 
all components that are within \"the system\" and by adding to this the 
integral of all heat flows entering/leaving the system.
There are two options for choosing the extent of the system based 
on parameter <code>openSystemConservationOfEnergy</code>. 
Either conservation of energy for a closed system is computed, 
or it is computed for an open system. <br/>
When choosing the closed system the conservation of energy 
check should always work when using IDEAS as intended. 
In this case conservation of energy is only checked for all components in the <code>Buildings</code> package. 
I.e. all heat flows at embedded ports <code>port_emb</code> of walls, 
fluid ports of the zones, <code>zone.gainCon</code> and <code>zone.gainRad</code> are 
considered to be a heat gain to the system and every other component 
is considered to be outside of the system for which conservation of energy is checked. <br/>
When computing an open system by setting <code>openSystemConservationOfEnergy=true</code> 
these heat flow rates are not taken into account because they are assumed 
to flow between components that are both within the bounds of the system.
The user then needs to choose how large the system is and he should make sure that
all heat flow rates entering the system are added to <code>sim.Qgai.Q_flow</code> and 
that all internal energy of the system is added to <code>sim.E.E</code>.
</li>
<li>
The default latitude and longitude, which are read by the TMY3 reader, can be overwritten. 
This should only be done if a custom weather data reader instead 
of the TMY3 weather data reader is used.
</li>
</ul>
<h4>TMY3 weather data files</h4>
IDEAS uses TMY3 input files. 
The default weather file 'Brussels.mos' contains weather information from IWEC for the Brussels region.
For detailed documentation see 
<a href=\"modelica://IDEAS.BoundaryConditions.WeatherData.ReaderTMY3\">IDEAS.BoundaryConditions.WeatherData.ReaderTMY3</a>.
<h4>Interzonal airflow</h4>
<p>
IDEAS supports several levels of detail for simulating interzonal airflow and air infiltration,
which can be selected by setting the value of the parameter <code>interzonalAirFlowType</code>. 
By <b>default</b>, <code>interzonalAirFlowType = None</code> and a fixed n50 value is assumed for each zone. 
The corresponding <b>fixed</b> mass flow rate is pushed 
into (with ambient properties) and extracted from each zone model.
In practice, air infiltration however depends on the wind pressure 
and occurs only for zones that have an exterior/outer wall
or windows. 
</p>
<p>
The other <code>interzonalAirFlowType</code> options model this effect in more detail.
By default, the <code>OuterWall</code> and <code>Window</code> leakage coefficients are computed
using the zone n50 values. The volume and n50 value of each zone are used to compute the total
nominal air infiltration at 50 Pa pressure difference. The total exterior wall and window surface
area are used to compute an average air leakage coefficient 
(<code>q50</code> value) such that this total air infiltration
is obtained at 50 Pa pressure difference. 
Using these coefficients and the static wind pressures, 
a flow network is configured that computes the mass flow rates through
each wall and window.
When a custom q50 value for a wall or window is known, it can be 
assigned by the user using the parameters <code>use_custom_q50</code> and <code>custom_q50</code>.
The algorithm considers these q50 values as known and recomputes all remaining q50 values
such that the n50 value is reached.
In a similar way, the total n50 value for one zone can be forced by using
the zone parameters <code>use_custom_n50<code> and <code>n50</code>.
In this case, only the remaining zones contribute to the total building
air leakage, which is subsequently attributed to the surfaces of only those zones.
When <code>use_custom_q50=false</code>, <code>n50</code> is ignored and 
<code>sim.n50</code> is used instead for this computation.
I.e., the whole building is assumed to have the n50 value <code>sim.n50</code> 
except for zones where <code>use_custom_q50=true</code>.
</p>
<p>
In case <code>interzonalAirFlowType=OnePort</code> then one port is 
used to model the air exchange through each surface
and through cavities in internal walls (open doors).
When <code>interzonalAirFlowType=TwoPorts</code> two ports are used, 
which increases the level of detail at the cost of having to solve
a more complex flow network.
The second port e.g. allows more detailed modelling of bidirectional 
flow through cavities (e.g. open doors) using two flow paths instead of only
modelling the total flow through a single flow path.
The two-port option is still under development.
</p>
<p>
When setting <code>unify_n50=true</code> in the <code>SimInfoManager</code> 
while <code>interzonalAirFlowType=None</code>, the n50 values are automatically
redistributed across the zones but instead of using pressure-driven flow, a fixed
infiltration flow rate is assumed. While this implementation is more detailed
and comes at no added computational cost, it is disabled by default 
for backward compatibility reasons.
</p>
</html>", revisions="<html>
<ul>
<li>
April 16, 2021 by Filip Jorissen:<br/>
Changed the default weather file to Brussels.mos
and revised the documentation accordingly.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1209\">
#1209</a> for more details.
</li>
<li>
June 30, 2020 by Filip Jorissen:<br/>
Overridable assignments of variables of PartialSimInfoManager.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1148\">
#1148</a>
</li>
<li>
November 28, 2019 by Ian Beausoleil-Morrison:<br/>
Make wind direction available on WeaBus.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
January 21, 2019 by Filip Jorissen:<br/>
Improved documentation by adding weather data reader
reference and more TMY3 file examples.
This is for
<a href=\"https://github.com/open-ideas/IDEAS/issues/956\">#956</a>.
</li>
<li>
June 7, 2018 by Filip Jorissen:<br/>
Overwriting TSky, Va and Fc from the extends clause
such that they can be overwriten again in BESTEST SimInfoManager.
This is for
<a href=\"https://github.com/open-ideas/IDEAS/issues/838\">#838</a>.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
Added documentation
</li>
</ul>
</html>"));
end SimInfoManager;
