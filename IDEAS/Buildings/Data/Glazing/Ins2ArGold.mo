within IDEAS.Buildings.Data.Glazing;
record Ins2ArGold = IDEAS.Buildings.Data.Interfaces.OldGlazing (
    final nLay=3,
    final mats={Materials.Glass(d=0.006, epsLw_a=0.1),
                Materials.Argon(d=0.016),
                Materials.Glass(d=0.006, epsLw_b=0.1)},
    final SwTrans=[0, 0.138;
                   10, 0.139;
                   20, 0.136;
                   30, 0.133;
                   40, 0.129;
                   50, 0.121;
                   60, 0.106;
                   70, 0.077;
                   80, 0.034;
                   90, 0.000],
    final SwAbs= [0, 0.714, 0.0, 0.028;
                 10, 0.720, 0.0, 0.028;
                 20, 0.724, 0.0, 0.028;
                 30, 0.724, 0.0, 0.029;
                 40, 0.717, 0.0, 0.029;
                 50, 0.708, 0.0, 0.029;
                 60, 0.691, 0.0, 0.028;
                 70, 0.638, 0.0, 0.025;
                 80, 0.461, 0.0, 0.017;
                 90, 0.000, 0.0, 0.000],
    final SwTransDif=0.106,
    final SwAbsDif={0.691,0.0,0.028},
    final U_value=1.3,
    final g_value=0.212)
    "Deprecated: Low SHGC AR 1.3 6/16/6 (U = 1.3 W/m2K, g = 0.212)"
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
