within IDEAS.Fluid.HeatPumps;
model HP_AirWater_TSet2
  extends HP_AirWater_TSet(redeclare BaseClasses.HeatSource_HP_AW2 heatSource);
  annotation (Documentation(info="<html>
<p>
This model is the same as 
<a href=\"IDEAS.Fluid.HeatPumps.HP_AirWater_TSet\">
IDEAS.Fluid.HeatPumps.HP_AirWater_TSet</a>, except that it uses 
<a href=\"IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW2\">
IDEAS.Fluid.HeatPumps.BaseClasses.HeatSource_HP_AW2</a></p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>2014 March, Filip Jorissen, Annex60 compatibility</li>
<li>2013 May, Roel De Coninck: propagation of heatSource parameters and better definition of QNom used.  Documentation and example added</li>
<li>2011 Roel De Coninck: first version</li>
</ul>
</html>"));
end HP_AirWater_TSet2;
