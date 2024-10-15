within IDEAS.Buildings.Data.Glazing;
record Ins2Ar2020 =
                IDEAS.Buildings.Data.Interfaces.Glazing (
    final nLay=3,
    final mats={Materials.Glass(d=0.006),
                Materials.Argon(d=0.016),
                Materials.Glass(d=0.006, epsLw_b=0.022)},
    final SwTrans=[0, 0.417;
                  10, 0.420;
                  20, 0.414;
                  30, 0.406;
                  40, 0.395;
                  50, 0.375;
                  60, 0.330;
                  70, 0.245;
                  80, 0.117;
                  90, 0.000],
    final SwAbs=[0, 0.118, 0.0, 0.113;
                10, 0.118, 0.0, 0.113;
                20, 0.120, 0.0, 0.115;
                30, 0.123, 0.0, 0.118;
                40, 0.129, 0.0, 0.123;
                50, 0.135, 0.0, 0.128;
                60, 0.142, 0.0, 0.133;
                70, 0.149, 0.0, 0.136;
                80, 0.149, 0.0, 0.130;
                90, 0.000, 0.0, 0.000],
    final SwTransDif=0.350,
    final SwAbsDif={0.124,0.0,0.081},
    final U_value=1.028,
    final g_value=0.551)
  "Default double: Saint Gobain Planitherm one AR 6/16/6 (U = 1.0 W/m2K, g = 0.56), good default for Belgium in 2020"
  annotation (Documentation(revisions="<html>
<ul>
<li>
July 20, 2020, by Filip Jorissen:<br/>
Updated the implementation to a Saint Gobain Planitherm glazing system
to be more in line with the commercially available glazing systems.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1114\">
#1114</a>
</li>
<li>
September 2, 2015, by Filip Jorissen:<br/>
Moved epsLw definition to solid layer to be consistent 
with changed implementation of MultiLayerLucent.
</li>
</ul>
</html>", info="<html>
<p>
Simple insulated double glazing system with argon filling, without sun protecting coating. 
</p>
<p>
This glazing system consists of an external pane of 6 mm Saint Gobain Planiclear and
an internal pane Planitherm one of 6 mm, and a 10%/90% air/argon cavity of 16 mm.
Spectral properties were computed using Window 7.7 with IGDB v73.
</p>
</html>"));
