within IDEAS.Examples.PPD12.Data;
record TripleGlazing =
    IDEAS.Buildings.Data.Interfaces.PartialGlazing (
final nLay=5,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_a=0.037),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.037)},
 final SwTrans=
[0,0.367;
10,0.371;
20,0.360;
30,0.348;
40,0.333;
50,0.305;
60,0.248;
70,0.155;
80,0.055;
90,0.000],
final SwAbs= [0,0.161, 0.0,0.072, 0.0,0.051;
10,0.163, 0.0,0.073, 0.0,0.052;
20,0.172, 0.0,0.073, 0.0,0.057;
30,0.179, 0.0,0.074, 0.0,0.060;
40,0.183, 0.0,0.075, 0.0,0.060;
50,0.190, 0.0,0.076, 0.0,0.061;
60,0.213, 0.0,0.074, 0.0,0.064;
70,0.244, 0.0,0.066, 0.0,0.060;
80,0.222, 0.0,0.049, 0.0,0.033;
90,0.001, 0.0,0.000, 0.0,0.000],
final SwTransDif=0.283,
final SwAbsDif={0.193,0.0,0.071,0.0,0.058},
final U_value=0.61,
final g_value=0.53) "Triple glazing for ppd12" annotation (Documentation(
      revisions="<html>
<ul>
<li>
October 28, 2020, by Filip Jorissen:<br/>
Extending <code>PartialGlazing</code>, which does not show in Window dropdown.
</li>
</ul>
</html>"));
