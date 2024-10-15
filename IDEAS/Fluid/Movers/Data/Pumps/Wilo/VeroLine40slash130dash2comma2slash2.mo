within IDEAS.Fluid.Movers.Data.Pumps.Wilo;
record VeroLine40slash130dash2comma2slash2
  "Pump data for a Wilo Veroline IP-E 40/130-2,2/2 pump"
  extends Generic(
    speed_rpm_nominal=2890,
    use_powerCharacteristic=true,
    power(V_flow={0.0,0.00277777, 0.00555555, 0.00833333, 0.01111111}, P={861.79,1495.9,2081.3, 2471.5, 2666.7}),
    pressure(V_flow={0.0,0.00277777, 0.00555555, 0.00833333, 0.01111111}, dp={227870.0,227170.0,215220.0,172830.0,100000.0}),
    motorCooledByFluid=true);
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>Data from:
<a href=\"http://productfinder.wilo.com/com/en/Wilo/c0000002a0003a36300010023/c0000002a0003a36d00010023/c0000002200012eb000020023/_000000650002b98f0001003a/product.html\"> 
http://productfinder.wilo.com/com/en/Wilo/c0000002a0003a36300010023/c0000002a0003a36d00010023/c0000002200012eb000020023/_000000650002b98f0001003a/product.html
</a>
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
end VeroLine40slash130dash2comma2slash2;
