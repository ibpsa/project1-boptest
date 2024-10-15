within IDEAS.Buildings.Data.Interfaces;
record Glazing
  "Template record for glazing, based on  Window software by LBNL"
  extends IDEAS.Buildings.Data.Interfaces.PartialGlazing;

  annotation (Documentation(info="<html>
  <p>
  The <code>Glazing.mo</code> partial describes the material data 
  required for glazing construction modelling.
  </p>
  <p>
  The correct parameter values for your type of glazing can be 
  generated using the 
  <a href=\"http://windows.lbl.gov/software/window/window.html\">Window software from LBNL</a>. 
  In the software open the \"glazing system\" library. 
  On this page choose the number of layers (typical two or three) and 
  fill in the glazing types. Make sure to \"flip\" the glass sheet 
  when necessary so that the coating is on the correct side of the glass. 
  Press calc to calculate the parameters.
  </p>
  <p>
  The resulting parameters can be filled in as follows. 
  </p>
  <p>
  In result tab \"Center of Glass Results\" copy <code>Ufactor</code>
  to <code>U_value</code>. In result tab \"Angular data\" open 
  \"Angular data\". Fill in the values of <code>Tsol</code> 
  (0-90 degrees) in <code>SwTrans</code>. The last value (Hemis) is filled 
  in under <code>SwTransDif</code>. Fill in the values under <code>Abs1</code>, 
  <code>Abs2</code>, <code>Abs3</code> in into <code>SwAbs</code> and 
  <code>SwAbsDif</code> in a similar fashion. Parameter <code>g_value</code> 
  does not need to be filled in. 
  </p>
  <p>
Furthermore, it is important that the <code>epsLw_b</code>
or <code>epsLw_a</code> fields of the glazing layers are adjusted
to reflect the effect of the glazing coating, assuming it exists.
This makes the difference of a U value of about 3 W/mK or 1 W/mK for double glazing!
See <a href=\"modelica://IDEAS.Buildings.Data.Glazing.Ins2Ar\">IDEAS.Buildings.Data.Glazing.Ins2Ar</a>
for an example with double glazing that has 1 glazed sheet with a coating on the inside.
</p>
<p> When no coatings are detected, ie. when the emissivities are default, an error is thrown to inform 
the user that he/she is probably unintentionally simulating low performance glazing. The error can be 
disabled with the parameter <code>checkLowPerformanceGlazing</code>.
</p> 
<h4>Validation</h4>
<p>
To verify the U-value of your glazing system implementation,
see <a href=\"modelica://IDEAS.Buildings.Components.Validations.WindowEN673\">
IDEAS.Buildings.Components.Validations.WindowEN673</a>
</p>
</html>", revisions="<html>
<ul>
<li>
September 9, 2019, by Kristoff Six:<br/>
Updated with <code>errorLowPerformance</code> for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/1038\">#1038</a>.
</li>
<li>
November 27, 2018, by Filip Jorissen:<br/>
Revised documentation for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/959\">#959</a>.
</li>
</ul>
</html>"));
end Glazing;
