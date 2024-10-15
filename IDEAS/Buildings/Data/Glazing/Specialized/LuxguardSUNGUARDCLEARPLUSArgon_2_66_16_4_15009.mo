within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardSUNGUARDCLEARPLUSArgon_2_66_16_4_15009 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.214;
10,0.215;
20,0.212;
30,0.208;
40,0.202;
50,0.191;
60,0.168;
70,0.123;
80,0.057;
90,0.000],
final SwAbs= [0,0.570, 0.0,0.020;
10,0.576, 0.0,0.021;
20,0.580, 0.0,0.021;
30,0.581, 0.0,0.021;
40,0.577, 0.0,0.021;
50,0.572, 0.0,0.022;
60,0.565, 0.0,0.021;
70,0.533, 0.0,0.019;
80,0.395, 0.0,0.014;
90,0.001, 0.0,0.000],final SwTransDif=0.168,
final SwAbsDif={0.565,0.0,0.021},
final U_value=2.59,
final g_value=0.248) "LuxguardSUNGUARDCLEARPLUSArgon_2_66_16_4(U-design =2.59 g-design =0.248)
";
