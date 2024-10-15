within IDEAS.Buildings.Data.Glazing.Specialized;
record SaintGobainPLANISOLNeutral62426_16_6_13010 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.355;
10,0.357;
20,0.351;
30,0.344;
40,0.333;
50,0.314;
60,0.274;
70,0.200;
80,0.091;
90,0.000],
final SwAbs= [0,0.298, 0.0,0.063;
10,0.301, 0.0,0.064;
20,0.308, 0.0,0.064;
30,0.313, 0.0,0.065;
40,0.313, 0.0,0.066;
50,0.316, 0.0,0.067;
60,0.327, 0.0,0.065;
70,0.333, 0.0,0.057;
80,0.272, 0.0,0.041;
90,0.001, 0.0,0.000],final SwTransDif=0.274,
final SwAbsDif={0.327,0.0,0.065},
final U_value=1.12,
final g_value=0.346) "SaintGobainPLANISOLNeutral62426_16_6(U-design =1.12 g-design =0.346)
";
