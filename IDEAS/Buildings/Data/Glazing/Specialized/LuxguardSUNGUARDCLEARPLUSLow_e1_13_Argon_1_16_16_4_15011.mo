within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardSUNGUARDCLEARPLUSLow_e1_13_Argon_1_16_16_4_15011 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.159;
10,0.160;
20,0.156;
30,0.152;
40,0.147;
50,0.138;
60,0.118;
70,0.083;
80,0.038;
90,0.000],
final SwAbs= [0,0.601, 0.0,0.030;
10,0.606, 0.0,0.030;
20,0.610, 0.0,0.032;
30,0.611, 0.0,0.034;
40,0.607, 0.0,0.034;
50,0.600, 0.0,0.035;
60,0.589, 0.0,0.037;
70,0.548, 0.0,0.037;
80,0.401, 0.0,0.025;
90,0.001, 0.0,0.000],final SwTransDif=0.118,
final SwAbsDif={0.589,0.0,0.037},
final U_value=1.25,
final g_value=0.184) "LuxguardSUNGUARDCLEARPLUSLow_e1_13_Argon_1_16_16_4(U-design =1.25 g-design =0.184)
";
