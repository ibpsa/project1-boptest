within IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials;
record Glazing = IDEAS.Buildings.Data.Interfaces.PartialGlazing (
    final nLay=3,
    final mats={IDEAS.Buildings.Data.Materials.Glass(
                                d=0.004,
                                epsLw_b=0.837),
                IDEAS.Buildings.Data.Materials.Argon(
                                d=0.016),
                IDEAS.Buildings.Data.Materials.Glass(
                                d=0.004,
                                epsLw_b=0.04,
                                epsLw_a=0.837)},
    final SwTrans=[0, 0.543;
                  10, 0.546;
                  20, 0.538;
                  30, 0.528;
                  40, 0.514;
                  50, 0.486;
                  60, 0.426;
                  70, 0.310;
                  80, 0.145;
                  90, 0.000],
    final SwAbs=[0, 0.107, 0.0, 0.085;
                10, 0.108, 0.0, 0.087;
                20, 0.109, 0.0, 0.094;
                30, 0.112, 0.0, 0.1;
                40, 0.116, 0.0, 0.102;
                50, 0.121, 0.0, 0.106;
                60, 0.126, 0.0, 0.119;
                70, 0.130, 0.0, 0.127;
                80, 0.124, 0.0, 0.091;
                90, 0.000, 0.0, 0.000],
    final SwTransDif=0.427,
    final SwAbsDif={0.118,0.0,0.104},
    final U_value=1.1,
    final g_value=0.525)
  "Glass properties as specified by EN410 spectrum (U = 1.1 W/m2K, g = 0.525)"
  annotation (Documentation(revisions="<html>
<ul>
<li>
October 28, 2020, by Filip Jorissen:<br/>
Extending <code>PartialGlazing</code>, which does not show in Window dropdown.
</li>
<li>
September 2, 2015, by Filip Jorissen:<br/>
Moved epsLw definition to solid layer to be consistent 
with changed implementation of MultiLayerLucent.
</li>
</ul>
</html>"));
