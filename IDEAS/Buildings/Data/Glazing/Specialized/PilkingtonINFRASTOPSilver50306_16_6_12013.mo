within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonINFRASTOPSilver50306_16_6_12013 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.252;
10,0.252;
20,0.251;
30,0.249;
40,0.249;
50,0.249;
60,0.248;
70,0.230;
80,0.143;
90,0.000],
final SwAbs= [0,0.296, 0.0,0.045;
10,0.297, 0.0,0.045;
20,0.297, 0.0,0.046;
30,0.298, 0.0,0.047;
40,0.299, 0.0,0.049;
50,0.299, 0.0,0.053;
60,0.299, 0.0,0.059;
70,0.298, 0.0,0.066;
80,0.285, 0.0,0.064;
90,0.000, 0.0,0.000],final SwTransDif=0.248,
final SwAbsDif={0.299,0.0,0.059},
final U_value=1.07,
final g_value=0.313) "PilkingtonINFRASTOPSilver50306_16_6(U-design =1.07 g-design =0.313)
";
