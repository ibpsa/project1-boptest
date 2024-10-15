within IDEAS.Buildings.Data.Glazing;
record Ins2Ar = IDEAS.Buildings.Data.Interfaces.OldGlazing (
    final nLay=3,
    final mats={Materials.Glass(d=0.004,epsLw_a=0.04),
                Materials.Argon(d=0.015),
                Materials.Glass(d=0.004)},
    final SwTrans=[0, 0.426;
                  10, 0.428;
                  20, 0.422;
                  30, 0.413;
                  40, 0.402;
                  50, 0.380;
                  60, 0.333;
                  70, 0.244;
                  80, 0.113;
                  90, 0.000],
    final SwAbs=[0, 0.118, 0.0, 0.190;
                10, 0.118, 0.0, 0.192;
                20, 0.120, 0.0, 0.198;
                30, 0.123, 0.0, 0.201;
                40, 0.129, 0.0, 0.200;
                50, 0.135, 0.0, 0.199;
                60, 0.142, 0.0, 0.199;
                70, 0.149, 0.0, 0.185;
                80, 0.149, 0.0, 0.117;
                90, 0.000, 0.0, 0.000],
    final SwTransDif=0.333,
    final SwAbsDif={0.142,0.0,0.199},
    final U_value=1.1,
    final g_value=0.589)
  "Deprecated: Saint Gobain Climaplus Futur AR 1.1 4/15/4 (U = 1.10 W/m2K, g = 0.589)"
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
Double insulated glazing system with argon filling.
This glazing system is based on product data that are at least 10 years old.
The model is deprecated and remains available for backward compatibility reasons.
</p>
</html>"));
