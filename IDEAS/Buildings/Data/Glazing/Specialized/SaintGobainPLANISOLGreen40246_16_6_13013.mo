within IDEAS.Buildings.Data.Glazing.Specialized;
record SaintGobainPLANISOLGreen40246_16_6_13013 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.193;
10,0.194;
20,0.191;
30,0.187;
40,0.181;
50,0.170;
60,0.148;
70,0.108;
80,0.049;
90,0.000],
final SwAbs= [0,0.669, 0.0,0.034;
10,0.675, 0.0,0.035;
20,0.679, 0.0,0.035;
30,0.680, 0.0,0.035;
40,0.675, 0.0,0.036;
50,0.667, 0.0,0.036;
60,0.656, 0.0,0.035;
70,0.613, 0.0,0.031;
80,0.450, 0.0,0.022;
90,0.001, 0.0,0.000],final SwTransDif=0.148,
final SwAbsDif={0.656,0.0,0.035},
final U_value=1.39,
final g_value=0.221) "SaintGobainPLANISOLGreen40246_16_6(U-design =1.39 g-design =0.221)
";
