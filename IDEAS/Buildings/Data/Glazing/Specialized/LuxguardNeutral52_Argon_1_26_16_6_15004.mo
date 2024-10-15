within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardNeutral52_Argon_1_26_16_6_15004 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.323;
10,0.325;
20,0.320;
30,0.313;
40,0.303;
50,0.286;
60,0.249;
70,0.180;
80,0.081;
90,0.000],
final SwAbs= [0,0.473, 0.0,0.043;
10,0.478, 0.0,0.044;
20,0.484, 0.0,0.044;
30,0.487, 0.0,0.045;
40,0.486, 0.0,0.046;
50,0.485, 0.0,0.046;
60,0.489, 0.0,0.045;
70,0.478, 0.0,0.039;
80,0.372, 0.0,0.028;
90,0.001, 0.0,0.000],final SwTransDif=0.249,
final SwAbsDif={0.489,0.0,0.045},
final U_value=1.40,
final g_value=0.318) "LuxguardNeutral52_Argon_1_26_16_6(U-design =1.40 g-design =0.318)
";
