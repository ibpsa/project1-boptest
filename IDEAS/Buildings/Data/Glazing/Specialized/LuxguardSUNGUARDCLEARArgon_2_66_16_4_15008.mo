within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardSUNGUARDCLEARArgon_2_66_16_4_15008 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.357;
10,0.359;
20,0.354;
30,0.347;
40,0.337;
50,0.318;
60,0.278;
70,0.202;
80,0.093;
90,0.000],
final SwAbs= [0,0.485, 0.0,0.034;
10,0.489, 0.0,0.034;
20,0.496, 0.0,0.035;
30,0.500, 0.0,0.035;
40,0.499, 0.0,0.036;
50,0.498, 0.0,0.036;
60,0.503, 0.0,0.035;
70,0.494, 0.0,0.031;
80,0.385, 0.0,0.023;
90,0.001, 0.0,0.000],final SwTransDif=0.278,
final SwAbsDif={0.503,0.0,0.035},
final U_value=2.84,
final g_value=0.365) "LuxguardSUNGUARDCLEARArgon_2_66_16_4(U-design =2.84 g-design =0.365)
";
