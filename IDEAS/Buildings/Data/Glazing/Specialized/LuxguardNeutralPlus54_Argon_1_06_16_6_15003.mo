within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardNeutralPlus54_Argon_1_06_16_6_15003 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.256;
10,0.257;
20,0.253;
30,0.248;
40,0.241;
50,0.229;
60,0.202;
70,0.152;
80,0.074;
90,0.000],
final SwAbs= [0,0.333, 0.0,0.034;
10,0.337, 0.0,0.035;
20,0.342, 0.0,0.035;
30,0.344, 0.0,0.035;
40,0.343, 0.0,0.036;
50,0.342, 0.0,0.037;
60,0.343, 0.0,0.036;
70,0.333, 0.0,0.033;
80,0.257, 0.0,0.026;
90,0.001, 0.0,0.000],final SwTransDif=0.202,
final SwAbsDif={0.343,0.0,0.036},
final U_value=1.08,
final g_value=0.251) "LuxguardNeutralPlus54_Argon_1_06_16_6(U-design =1.08 g-design =0.251)
";
