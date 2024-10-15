within IDEAS.Fluid.Movers.Data.Pumps.Wilo;
record VeroLine40slash120dash1comma5slash2
  "Pump data for a Wilo Veroline IP-E 40/120-1,5/2 pump"
  extends Generic(
    speed_rpm_nominal=2890,
    use_powerCharacteristic=true,
    power(V_flow={0,5,10,15,20,25,30,35}/3600,
          P={0.69495, 0.92202, 1.1766, 1.4312, 1.6651, 1.8028, 1.8853, 1.9404}*1000),
    pressure(V_flow={0,5,10,15,20,25,30,35}/3600,
             dp={18.396, 18.140, 18.000, 17.879, 16.698, 14.765, 11.973, 8.8054}*9806.65),
    motorCooledByFluid=true);
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>Data from:
<a href=\"http://productfinder.wilo.com/com/en/Wilo/c0000002a0003a36300010023/c0000002a0003a36d00010023/c0000002200012eb000020023/_000000650002b9810001003a/product.html\"> 
http://productfinder.wilo.com/com/en/Wilo/c0000002a0003a36300010023/c0000002a0003a36d00010023/c0000002200012eb000020023/_000000650002b9810001003a/product.html
</a>
</p>
<p>See 
<a href=\"modelica://IDEAS.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6\">
IDEAS.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 
</a>for more information about how the data is derived. 
</p>
</html>",   revisions="<html>
<ul>
<li>March 23, 2018
    by Iago Cupeiro:<br/>
       Initial version
</li>
</ul>
</html>"));
end VeroLine40slash120dash1comma5slash2;
