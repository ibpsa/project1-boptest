within IDEAS.Media.Specialized;
package DryAir "Package with dry air model that decouples pressure and temperature, for linearisation"
  extends IDEAS.Media.Specialized.BaseClasses.PartialSimpleMedium(
     mediumName="Air",
     cp_const=1005,
     cv_const=1005,
     d_const=1.2,
     eta_const=1.82e-5,
     lambda_const=0.026,
     a_const=331,
     T_min=240,
     T_max=400,
     T0=reference_T,
     MM_const=0.0289651159,
     reference_X={1},
     reference_T=273.15,
     reference_p=101325,
     AbsolutePressure(start=p_default),
     Temperature(start=T_default),
     extraPropertiesNames=fill("CO2",if useCO2 then 1 else 0));
  constant Boolean useCO2 = false;

  extends Modelica.Icons.Package;

  annotation(preferredView="info", Documentation(info="<html>
<p>
Simple air medium without moisture that does not cause linear algebraic loops in JModelica.
This medium is also used for the linearisation, since it does not contain moisture.
</p>
</html>", revisions="<html>
<ul>
<li>
May 23, 2018, by Filip Jorissen:<br/>
First implementation based on IBPSA library models.
</li>
</ul>
</html>"),
    Icon(graphics={
        Ellipse(
          extent={{-78,78},{-34,34}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-18,86},{26,42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{48,58},{92,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-22,32},{22,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{36,-32},{80,-76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-36,-30},{8,-74}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-90,-6},{-46,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120})}));
end DryAir;
