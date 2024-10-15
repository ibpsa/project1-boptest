within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardSUNGUARDCLEARLow_e1_13_Argon_1_16_16_4_15010 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.259;
10,0.262;
20,0.255;
30,0.248;
40,0.239;
50,0.225;
60,0.192;
70,0.134;
80,0.061;
90,0.000],
final SwAbs= [0,0.527, 0.0,0.048;
10,0.531, 0.0,0.049;
20,0.538, 0.0,0.053;
30,0.541, 0.0,0.055;
40,0.540, 0.0,0.055;
50,0.537, 0.0,0.056;
60,0.537, 0.0,0.060;
70,0.517, 0.0,0.060;
80,0.394, 0.0,0.041;
90,0.001, 0.0,0.000],final SwTransDif=0.192,
final SwAbsDif={0.537,0.0,0.060},
final U_value=1.19,
final g_value=0.273) "LuxguardSUNGUARDCLEARLow_e1_13_Argon_1_16_16_4(U-design =1.19 g-design =0.273)
";
