within IDEAS.Buildings.Data.Glazing;
record Ins2ArGray = IDEAS.Buildings.Data.Interfaces.OldGlazing (
    final nLay=3,
    final mats={Materials.Glass(d=0.006, epsLw_a=0.10),
                Materials.Argon(d=0.016),
                Materials.Glass(d=0.006, epsLw_b=0.10)},
    final SwTrans=[0, 0.316;
                   10, 0.318;
                   20, 0.313;
                   30, 0.306;
                   40, 0.296;
                   50, 0.279;
                   60, 0.243;
                   70, 0.176;
                   80, 0.079;
                   90, 0.000],
    final SwAbs=[0, 0.448, 0.0, 0.064;
                 10, 0.453, 0.0, 0.064;
                 20, 0.460, 0.0, 0.065;
                 30, 0.463, 0.0, 0.065;
                 40, 0.461, 0.0, 0.067;
                 50, 0.461, 0.0, 0.067;
                 60, 0.466, 0.0, 0.065;
                 70, 0.456, 0.0, 0.056;
                 80, 0.355, 0.0, 0.040;
                 90, 0.000, 0.0, 0.000],
    final SwTransDif=0.243,
    final SwAbsDif={0.466,0.0,0.065},
    final U_value=1.3,
    final g_value=0.397)
    "Deprecated: Low SHGC AR 1.3 6/16/6 (U = 1.3 W/m2K, g = 0.397)"
  annotation (Documentation(revisions="<html>
<ul>
<li>
October 28, 2020, by Filip Jorissen:<br/>
Extending OldGlazing.
</li>
<li>
July 20, 2020, by Filip Jorissen:<br/>
Deprecated this glazing type since it is based on
product data of 10 years old.
</li>
<li>
September 2, 2015, by Filip Jorissen:<br/>
Moved epsLw definition to solid layer to be consistent 
with changed implementation of MultiLayerLucent.
</li>
</ul>
</html>", info="<html>
<p>
Double insulated glazing system with Argon filling and low g value.
This glazing system is based on product data that are at least 10 years old.
The model is deprecated and remains available for backward compatibility reasons.
</p>
</html>"));
