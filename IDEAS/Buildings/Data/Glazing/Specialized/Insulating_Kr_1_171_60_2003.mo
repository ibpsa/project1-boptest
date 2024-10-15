within IDEAS.Buildings.Data.Glazing.Specialized;
record Insulating_Kr_1_171_60_2003 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Krypton(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.426;
10,0.428;
20,0.422;
30,0.413;
40,0.402;
50,0.380;
60,0.333;
70,0.244;
80,0.113;
90,0.000],
final SwAbs= [0,0.118, 0.0,0.190;
10,0.118, 0.0,0.192;
20,0.120, 0.0,0.198;
30,0.123, 0.0,0.201;
40,0.129, 0.0,0.200;
50,0.135, 0.0,0.199;
60,0.142, 0.0,0.199;
70,0.149, 0.0,0.185;
80,0.149, 0.0,0.117;
90,0.000, 0.0,0.000],final SwTransDif=0.333,
final SwAbsDif={0.142,0.0,0.199},
final U_value=1.19,
final g_value=0.514) "Insulating_Kr_1_171_60(U-design =1.19 g-design =0.514)
";
