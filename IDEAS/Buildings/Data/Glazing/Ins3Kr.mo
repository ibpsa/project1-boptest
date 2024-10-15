within IDEAS.Buildings.Data.Glazing;
record Ins3Kr = IDEAS.Buildings.Data.Interfaces.OldGlazing (
    final nLay=5,
    final mats={Materials.Glass(d=0.004, epsLw_a=0.04),
                Materials.Krypton(d=0.008),
                Materials.Glass(d=0.004, epsLw_a=0.04),
                Materials.Krypton(d=0.008),
                Materials.Glass(d=0.004)},
    final SwTrans=[0, 0.268;
                   10, 0.270;
                   20, 0.263;
                   30, 0.253;
                   40, 0.243;
                   50, 0.223;
                   60, 0.183;
                   70, 0.116;
                   80, 0.042;
                   90, 0.000],
    final SwAbs=[0, 0.327, 0.0, 0.066, 0.0, 0.108;
                 10, 0.330, 0.0, 0.066, 0.0, 0.110;
                 20, 0.339, 0.0, 0.067, 0.0, 0.112;
                 30, 0.345, 0.0, 0.068, 0.0, 0.113;
                 40, 0.347, 0.0, 0.070, 0.0, 0.110;
                 50, 0.351, 0.0, 0.071, 0.0, 0.107;
                 60, 0.367, 0.0, 0.070, 0.0, 0.101;
                 70, 0.380, 0.0, 0.064, 0.0, 0.082;
                 80, 0.313, 0.0, 0.051, 0.0, 0.041;
                 90, 0.000, 0.0, 0.000, 0.0, 0.000],
    final SwTransDif=0.183,
    final SwAbsDif={0.367,0.0,0.070,0.0,0.101},
    final U_value=0.7,
    final g_value=0.407)
  "Deprecated: Saint Gobain Climaplus  Futur KR 4/8/4/8/4 (U = 0.7 W/m2K, g = 0.407)"
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
Triple insulated glazing system with krypton filling.
This glazing system is based on product data that are at least 10 years old.
The model is deprecated and remains available for backward compatibility reasons.
</p>
</html>"));
