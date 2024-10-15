within IDEAS.Buildings.Data.Glazing.Specialized;
record LowSHGC_Ar_gold1_324_22_3303 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.138;
10,0.139;
20,0.136;
30,0.133;
40,0.129;
50,0.121;
60,0.106;
70,0.077;
80,0.034;
90,0.000],
final SwAbs= [0,0.714, 0.0,0.028;
10,0.720, 0.0,0.028;
20,0.724, 0.0,0.028;
30,0.724, 0.0,0.029;
40,0.717, 0.0,0.029;
50,0.708, 0.0,0.029;
60,0.691, 0.0,0.028;
70,0.638, 0.0,0.025;
80,0.461, 0.0,0.017;
90,0.001, 0.0,0.000],final SwTransDif=0.106,
final SwAbsDif={0.691,0.0,0.028},
final U_value=1.52,
final g_value=0.178) "LowSHGC_Ar_gold1_324_22(U-design =1.52 g-design =0.178)
";
