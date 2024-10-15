within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPLUS3CKR4_8_4_8_4_14005 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=5,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Krypton(d=0.008, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Krypton(d=0.008, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.329;
10,0.332;
20,0.323;
30,0.312;
40,0.299;
50,0.275;
60,0.225;
70,0.142;
80,0.052;
90,0.000],
final SwAbs= [0,0.256, 0.0,0.041, 0.0,0.069;
10,0.258, 0.0,0.042, 0.0,0.070;
20,0.267, 0.0,0.042, 0.0,0.074;
30,0.273, 0.0,0.042, 0.0,0.076;
40,0.275, 0.0,0.043, 0.0,0.076;
50,0.280, 0.0,0.044, 0.0,0.075;
60,0.298, 0.0,0.043, 0.0,0.076;
70,0.317, 0.0,0.039, 0.0,0.067;
80,0.269, 0.0,0.030, 0.0,0.037;
90,0.002, 0.0,0.000, 0.0,0.000],final SwTransDif=0.225,
final SwAbsDif={0.298,0.0,0.043,0.0,0.076},
final U_value=0.68,
final g_value=0.323) "InterpaneIPLUS3CKR4_8_4_8_4(U-design =0.68 g-design =0.323)
";
