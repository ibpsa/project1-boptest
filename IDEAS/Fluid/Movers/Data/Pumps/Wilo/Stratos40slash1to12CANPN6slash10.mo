within IDEAS.Fluid.Movers.Data.Pumps.Wilo;
record Stratos40slash1to12CANPN6slash10
  "Pump data for a Wilo Stratos 40/1-12 CAN PN 6/10 pump"
  extends Generic(
    speed_rpm_nominal=4600,
    use_powerCharacteristic=true,
    power(V_flow={0,4,8,12,16,20}/3600,
        P={322.48, 412.40, 452.71, 493.02, 524.03, 542.64}),
    pressure(V_flow={0,4,8,12,16,20}/3600,
        dp={13, 12.741, 11.153, 9.2835, 7.1028, 4.7040}*9806.65));
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
  <p>Data from:
  <a href=\"http://productfinder.wilo.com/com/en/c0000001b0000accb00010023/_00000018000029380002003a/product.html\">
  http://productfinder.wilo.com/com/en/c0000001b0000accb00010023/_00000018000029380002003a/product.html
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
end Stratos40slash1to12CANPN6slash10;
