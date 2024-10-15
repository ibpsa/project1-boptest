within IDEAS.Fluid.Movers.Data.Pumps.Wilo;
record Stratos80slash1to12_CAN_PN6
  "Pump data for a Wilo Stratos 80/1-12 CAN PN 6 pump"
  extends Generic(
    speed_rpm_nominal=3300,
    use_powerCharacteristic=true,
    power(V_flow={0.0,0.00277777, 0.00555555, 0.00833333, 0.01111111, 0.01388888, 0.01666666}, P={870.97, 1096.8, 1419.4, 1548.4, 1548.4, 1548.4, 1548.4}),
    pressure(V_flow={0.0,0.00277777, 0.00555555, 0.00833333, 0.01111111, 0.01388888, 0.01666666}, dp={125760, 124360, 123940, 112800, 92160, 67680, 36480}));
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
  <p>Data from:
  <a href=\"http://productfinder.wilo.com/es/en/c0000001b0000accb00010023/_0000004b00027bcc0001003a/product.html\">
  http://productfinder.wilo.com/es/en/c0000001b0000accb00010023/_0000004b00027bcc0001003a/product.html
  </a>
  </p>
  <p>See
  <a href=\"modelica://IDEAS.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6\">
  IDEAS.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6
  </a>
  for more information about how the data is derived.
  </p>
  </html>", revisions="<html>
<ul>
<li>March 23, 2018
    by Iago Cupeiro:<br/>
       Initial version
</li>
</ul>
</html>"));
end Stratos80slash1to12_CAN_PN6;
