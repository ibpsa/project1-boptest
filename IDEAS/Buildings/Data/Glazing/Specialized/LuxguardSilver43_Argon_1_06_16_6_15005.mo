within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardSilver43_Argon_1_06_16_6_15005 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.238;
10,0.239;
20,0.236;
30,0.231;
40,0.224;
50,0.213;
60,0.188;
70,0.140;
80,0.068;
90,0.000],
final SwAbs= [0,0.314, 0.0,0.032;
10,0.317, 0.0,0.032;
20,0.322, 0.0,0.033;
30,0.324, 0.0,0.033;
40,0.323, 0.0,0.034;
50,0.322, 0.0,0.034;
60,0.324, 0.0,0.034;
70,0.315, 0.0,0.031;
80,0.244, 0.0,0.023;
90,0.001, 0.0,0.000],final SwTransDif=0.188,
final SwAbsDif={0.324,0.0,0.034},
final U_value=1.08,
final g_value=0.233) "LuxguardSilver43_Argon_1_06_16_6(U-design =1.08 g-design =0.233)
";
