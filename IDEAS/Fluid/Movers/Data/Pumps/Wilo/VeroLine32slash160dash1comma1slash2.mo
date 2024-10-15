within IDEAS.Fluid.Movers.Data.Pumps.Wilo;
record VeroLine32slash160dash1comma1slash2
  "Pump data for a Wilo Veroline IP-E 32/160-1,1/2 pump"
  extends Generic(
    speed_rpm_nominal=2840,
    use_powerCharacteristic=true,
    power(V_flow={0,1,2,3,4,5,6,7,8,9,10,11,12}/3600,
          P={1.1053, 1.1842, 1.2947, 1.4053, 1.4684, 1.5158, 1.5474, 1.5789, 1.5947, 1.6263, 1.6421, 1.6737, 1.6737}*1000),
    pressure(V_flow={0,1,2,3,4,5,6,7,8,9,10,11,12}/3600, dp={26.242,25.879,25.274,24.67,23.823, 22.856, 21.767, 20.679, 19.228, 17.777, 15.963, 14.028, 11.730}*9806.65),
    motorCooledByFluid=true);
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>Data not available at this moment
</p>
<p>See 
<a href=\"modelica://IDEAS.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6\">
IDEAS.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 
</a>
for more information about how the data is derived. 
</p>
</html>",   revisions="<html>
<ul>
<li>March 23, 2018
    by Iago Cupeiro:<br/>
       Initial version
</li>
</ul>
</html>"));
end VeroLine32slash160dash1comma1slash2;
