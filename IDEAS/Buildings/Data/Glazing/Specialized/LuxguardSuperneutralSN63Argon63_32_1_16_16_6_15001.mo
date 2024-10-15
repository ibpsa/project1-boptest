within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardSuperneutralSN63Argon63_32_1_16_16_6_15001 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.281;
10,0.282;
20,0.278;
30,0.272;
40,0.264;
50,0.251;
60,0.221;
70,0.166;
80,0.080;
90,0.000],
final SwAbs= [0,0.364, 0.0,0.038;
10,0.367, 0.0,0.038;
20,0.373, 0.0,0.038;
30,0.376, 0.0,0.039;
40,0.374, 0.0,0.040;
50,0.373, 0.0,0.041;
60,0.375, 0.0,0.040;
70,0.365, 0.0,0.036;
80,0.282, 0.0,0.028;
90,0.001, 0.0,0.000],final SwTransDif=0.221,
final SwAbsDif={0.375,0.0,0.040},
final U_value=1.17,
final g_value=0.276) "LuxguardSuperneutralSN63Argon63_32_1_16_16_6(U-design =1.17 g-design =0.276)
";
