within IDEAS.Fluid.Movers.Data.Pumps.Wilo;
record Stratos65slash1to12_CAN_PN6slash10
  "Pump data for a Wilo Stratos 65/1-12 CAN PN 6/10 pump"
  extends Generic(
    speed_rpm_nominal=3300,
    use_powerCharacteristic=true,
    power(V_flow={0.0,0.00111111, 0.00222222, 0.00333333, 0.00444444, 0.00555555, 0.00666666, 0.00777777, 0.00888888, 0.01, 0.01111111}, P={615.76, 698.18, 756.36, 785.45, 806.0, 806.0, 806.0, 806.0, 806.0, 806.0, 806.0}),
    pressure(V_flow={0.0,0.00111111, 0.00222222, 0.00333333, 0.00444444, 0.00555555, 0.00666666, 0.00777777, 0.00888888, 0.01, 0.01111111}, dp={107873, 103950, 102190, 96930, 89912, 82456, 73684, 64035, 54386, 44298, 32456}),
    motorCooledByFluid=true);
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
  <p>Data from:
  <a href=\"http://productfinder.wilo.com/ie/en/c0000001b0000accb00010023/_000000610001fe090001003a/product.html\">
  http://productfinder.wilo.com/ie/en/c0000001b0000accb00010023/_000000610001fe090001003a/product.html
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
end Stratos65slash1to12_CAN_PN6slash10;
