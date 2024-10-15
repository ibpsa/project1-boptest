within IDEAS.Buildings.Data.Glazing.Specialized;
record SaintGobainPLANISOLNeutral50366_16_6_13011 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.298;
10,0.299;
20,0.294;
30,0.288;
40,0.279;
50,0.263;
60,0.229;
70,0.166;
80,0.075;
90,0.000],
final SwAbs= [0,0.400, 0.0,0.053;
10,0.404, 0.0,0.053;
20,0.410, 0.0,0.054;
30,0.413, 0.0,0.054;
40,0.412, 0.0,0.056;
50,0.412, 0.0,0.056;
60,0.417, 0.0,0.054;
70,0.409, 0.0,0.048;
80,0.320, 0.0,0.034;
90,0.001, 0.0,0.000],final SwTransDif=0.229,
final SwAbsDif={0.417,0.0,0.054},
final U_value=1.26,
final g_value=0.299) "SaintGobainPLANISOLNeutral50366_16_6(U-design =1.26 g-design =0.299)
";
