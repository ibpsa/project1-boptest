within IDEAS.Fluid.Movers.Data.Pumps.Wilo;
record Stratos30slash1to12
  "Pump data for a Wilo Stratos 30/1-12 pump"
  extends Generic(
    speed_rpm_nominal=4800,
    use_powerCharacteristic=true,
    power(V_flow={0,0.00055555,0.00111111,
          0.00166666,0.00222222, 0.00277777,
          0.00333333}, P={152.21, 212.39, 258.41,
          260.18,292.04, 300.88, 300.88}),
    pressure(V_flow={0,0.00055555,0.00111111,
          0.00166666,0.00222222, 0.00277777,
          0.00333333},dp={125000, 120000,
          113230, 89733, 70148, 49496,
          21721}));
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>Data from: 
<a href=\"http://productfinder.wilo.com/be/en/c0000001b0000accb00010023/_00000018000029430002003a/product.html\">
http://productfinder.wilo.com/be/en/c0000001b0000accb00010023/_00000018000029430002003a/product.html
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
end Stratos30slash1to12;
