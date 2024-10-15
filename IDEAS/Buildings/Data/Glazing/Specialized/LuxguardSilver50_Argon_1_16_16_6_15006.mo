within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardSilver50_Argon_1_16_16_6_15006 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.273;
10,0.274;
20,0.270;
30,0.264;
40,0.257;
50,0.244;
60,0.216;
70,0.162;
80,0.078;
90,0.000],
final SwAbs= [0,0.223, 0.0,0.037;
10,0.226, 0.0,0.037;
20,0.231, 0.0,0.037;
30,0.234, 0.0,0.038;
40,0.234, 0.0,0.039;
50,0.235, 0.0,0.039;
60,0.242, 0.0,0.039;
70,0.244, 0.0,0.035;
80,0.197, 0.0,0.027;
90,0.001, 0.0,0.000],final SwTransDif=0.216,
final SwAbsDif={0.242,0.0,0.039},
final U_value=1.14,
final g_value=0.261) "LuxguardSilver50_Argon_1_16_16_6(U-design =1.14 g-design =0.261)
";
