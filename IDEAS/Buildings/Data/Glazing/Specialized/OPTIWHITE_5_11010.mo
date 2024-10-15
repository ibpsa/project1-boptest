within IDEAS.Buildings.Data.Glazing.Specialized;
record OPTIWHITE_5_11010 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.005, epsLw_b=0.4)},final SwTrans=[0,0.902;
10,0.902;
20,0.901;
30,0.899;
40,0.891;
50,0.872;
60,0.824;
70,0.706;
80,0.441;
90,0.000],
final SwAbs= [0,0.021;
10,0.021;
20,0.022;
30,0.022;
40,0.023;
50,0.024;
60,0.026;
70,0.027;
80,0.027;
90,0.000],final SwTransDif=0.824,
final SwAbsDif={0.026},
final U_value=5.71,
final g_value=0.831) "OPTIWHITE_5(U-design =5.71 g-design =0.831)
";
