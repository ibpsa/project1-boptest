within IDEAS.Buildings.Data.Glazing.Specialized;
record FLOAT_10_11005 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.01, epsLw_b=0.4)},final SwTrans=[0,0.720;
10,0.719;
20,0.715;
30,0.708;
40,0.696;
50,0.672;
60,0.625;
70,0.525;
80,0.309;
90,0.000],
final SwAbs= [0,0.210;
10,0.211;
20,0.215;
30,0.220;
40,0.228;
50,0.236;
60,0.244;
70,0.245;
80,0.224;
90,0.000],final SwTransDif=0.625,
final SwAbsDif={0.244},
final U_value=5.94,
final g_value=0.689) "FLOAT_10(U-design =5.94 g-design =0.689)
";
