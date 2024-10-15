within IDEAS.Buildings.Components.OccupancyType.BaseClasses;
partial record PartialOccupancyType
  "Record for defining the type (i.e. properties) of the occupants, used in InternalGains and Comfort models"
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Power QlatPp(min=0)
    "Latent heat production per person";
  parameter Modelica.SIunits.Power QsenPp(min=0)
    "Sensible heat production per person";
  parameter Real radFra(min=0,max=1) = 0.6
    "Radiant fraction of sensible heat exchange, default based on Ashrae fundamentals chap 18.4 for low air velocity, used for computing radiative and convective sensible heat flow rate fractions";
  parameter Real ICl(min=0) = 0.7
    "Fixed value for clothing insulation in units of clo (summer=0.5; winter=0.9), used to compute thermal comfort";
  annotation (Documentation(revisions="<html>
<ul>
<li>
October 15, 2019 by Iago Cupeiro:<br/>
Corrected typo in description.
</li>
<li>
January 26, 2018 by Filip Jorissen:<br/>
Revised default values. 
Record is now partial.
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
This record may be used to describe the thermally relevant characteristics of the occupants. 
Following tables may be used as a guide to choose the numeric values.
Some tables and part of this documentation was copied from Buildings.Utilities.Comfort.Fanger.
</p>

<h4>Latent/sensible heat load fraction</h4>
<p>
Human heat production is dissipated through a latent (sweat secretion) and 
sensible heat load, respectively QlatPp and QsenPp in this record.
The table below provides some typical values (W per person) from ASHRAE (2009) page 18.4.
The table also provides typical values for radFra for low and high air velocities.
</p>
<table summary=\"summary\" border=\"1\">
<tr><th>Activity</th><th>QsenPp</th><th>QlatPp</th><th>radFra low</th><th>radFra high</th></tr>
<tr><td>Seated at theatre</td><td>66</td><td>31</td><td>0.6</td><td>0.27</td></tr>
<tr><td>Seated, very light work</td><td>72</td><td>45</td><td>0.6</td><td>0.27</td></tr>
<tr><td>Moderately active office work</td><td>73</td><td>59</td><td>0.58</td><td>0.38</td></tr>
<tr><td>Standing, light work, walking</td><td>73</td><td>59</td><td>0.58</td><td>0.38</td></tr>
<tr><td>Walking, standing</td><td>73</td><td>73</td><td>0.58</td><td>0.38</td></tr>
<tr><td>Light bench work (factory)</td><td>81</td><td>140</td><td>0.49</td><td>0.35</td></tr>
</table>
<br/>

<h4>Insulation for clothing ensembles</h4>
<p>
Clothing (parameter ICl) is defined in terms of clo units.  Clo is a unit used to express the thermal insulation provided by garments and clothing ensembles,
where <i>1</i> clo = <i>0.155</i> (m^2*K/W) (ASHRAE 55-92).
</p>
<p>
The following table is obtained from ASHRAE page 8.8
</p>
<table summary=\"summary\" border=\"1\">
<tr><th>Clothing ensemble</th><th>clo</th></tr>
<tr><td>ASHRAE Standard 55 Winter</td><td>0.90</td></tr>
<tr><td>ASHRAE Standard 55 Summer</td><td>0.50</td></tr>
<tr><td>Walking shorts, short-sleeve shirt</td><td>  0.36</td></tr>
<tr><td>Trousers, long-sleeve shirt</td><td> 0.61</td></tr>
<tr><td>Trousers, long-sleeve shirt, suit jacket</td><td> 0.96</td></tr>
<tr><td>Trousers, long-sleeve shirt, suit jacket, T-shirt</td><td> 1.14</td></tr>
<tr><td>Trousers, long-sleeve shirt, long-sleeve sweater, T-shirt</td><td> 1.01</td></tr>
<tr><td>Same as above + suit jacket, long underwear bottoms</td><td> 1.30</td></tr>
<tr><td>Sweat pants, sweat shirt</td><td> 0.74</td></tr>
<tr><td>Knee-length skirt, short-sleeve shirt, panty hose, sandals</td><td> 0.54</td></tr>
<tr><td>Knee-length skirt, long-sleeve shirt, full slip, panty hose</td><td> 0.67</td></tr>
<tr><td>Knee-length skirt, long-sleeve shirt, half slip, panty hose, long sleeve sweater</td><td> 1.10</td></tr>
<tr><td>Long-sleeve coveralls, T-shirt</td><td>   0.72</td></tr>
<tr><td>Insulated coveralls, long-sleeve, thermal underwear, long underwear bottoms</td><td> 1.37</td></tr>
</table>
<br/>

<h4> Metabolic rates</h4>
<p>
One met is defined as <i>58.2</i> Watts per square meter which is equal to the energy produced
per unit surface area of a seated person at rest.</p>
<p>The following table is obtained from ASHRAE (1997) page 8.6.</p>
<table summary=\"summary\" border=\"1\">
<tr><th>Activity</th><th>W/m2 body surface area</th></tr>
<tr><td>ASHRAE Standard 55</td><td>58.2</td></tr>
<tr><td> reclining  </td><td>45</td></tr>
<tr><td> seated and quiet </td><td>60</td></tr>
<tr><td> sedentary activity (reading, writing) </td><td>60</td></tr>
<tr><td> standing, relaxed </td><td>70</td></tr>
<tr><td> office (filling while standing)</td><td>80</td></tr>
<tr><td> office (walking)</td><td>100</td></tr>
<tr><td>Sleeping</td><td>         40     </td></tr>
<tr><td>Seated quiet</td><td>   60 </td></tr>
<tr><td>Standing Relaxed</td><td>  70  </td></tr>
<tr><td>Walking 3.2 - 6.4km/h</td><td> 115-220   </td></tr>
<tr><td>Reading</td><td> 55</td></tr>
<tr><td>Writing</td><td> 60</td></tr>
<tr><td>Typing</td><td> 65</td></tr>
<tr><td>Lifting/packing</td><td>  120</td></tr>
<tr><td>Driving Car</td><td> 60-115</td></tr>
<tr><td>Driving Heavy vehicle</td><td> 185</td></tr>
<tr><td>Cooking</td><td> 95-115</td></tr>
<tr><td>Housecleaning</td><td> 115-200</td></tr>
<tr><td>Machine work</td><td> 105-235</td></tr>
<tr><td>Pick and shovel work</td><td> 235-280</td></tr>
<tr><td>Dancing-Social</td><td> 140-225</td></tr>
<tr><td>Calisthenics</td><td>  175-235</td></tr>
<tr><td>Basketball</td><td>  290-440</td></tr>
<tr><td>Wrestling</td><td>  410-505</td></tr>
</table>
<br/>
<h4>References</h4>

<ul><li>
ASHRAE Handbook, Fundamentals (SI Edition).
 American Society of Heating, Refrigerating and Air-Conditioning Engineers,
Chapter 8, Thermal Comfort; pages 8.1-8.26; Atlanta, USA, 1997.
</li>
<li>
ASHRAE Handbook, Fundamentals.
 American Society of Heating, Refrigerating and Air-Conditioning Engineers,
Chapter 18, Internal Heat Gains; pages 18.4; Atlanta, USA, 2009.
</li>
<li>
International Standards Organization (ISO).
Moderate Thermal Environments: Determination of the PMV and PPD Indices
and Specification of the Conditions for Thermal Comfort (ISO 7730).
Geneva, Switzerland: ISO. 1994.
</li>
<li>
Charles, K.E. Fanger Thermal Comfort and Draught Models. Institute for Research in Construction
National Research Council of Canada, Ottawa, K1A 0R6, Canada.
IRC Research Report RR-162. October 2003.
<a href=\"http://irc.nrc-cnrc.gc.ca/ircpubs\">http://irc.nrc-cnrc.gc.ca/ircpubs</a>.
</li>
<li>
Data, References and Links at: Thermal Comfort; Dr. Sam C M Hui
Department of Mechanical Engineering
The University of Hong Kong MEBS6006 Environmental Services I;
<a href=\"http://me.hku.hk/msc-courses/MEBS6006/index.html\">
http://me.hku.hk/msc-courses/MEBS6006/index.html</a>
</li>
</ul>

</html>"));
end PartialOccupancyType;
