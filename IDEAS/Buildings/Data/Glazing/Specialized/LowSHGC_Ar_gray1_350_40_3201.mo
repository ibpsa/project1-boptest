within IDEAS.Buildings.Data.Glazing.Specialized;
record LowSHGC_Ar_gray1_350_40_3201 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.316;
10,0.318;
20,0.313;
30,0.306;
40,0.296;
50,0.279;
60,0.243;
70,0.176;
80,0.079;
90,0.000],
final SwAbs= [0,0.448, 0.0,0.064;
10,0.453, 0.0,0.064;
20,0.460, 0.0,0.065;
30,0.463, 0.0,0.065;
40,0.462, 0.0,0.067;
50,0.461, 0.0,0.067;
60,0.466, 0.0,0.065;
70,0.456, 0.0,0.056;
80,0.355, 0.0,0.040;
90,0.001, 0.0,0.000],final SwTransDif=0.243,
final SwAbsDif={0.466,0.0,0.065},
final U_value=1.38,
final g_value=0.325) "LowSHGC_Ar_gray1_350_40(U-design =1.38 g-design =0.325)
";
