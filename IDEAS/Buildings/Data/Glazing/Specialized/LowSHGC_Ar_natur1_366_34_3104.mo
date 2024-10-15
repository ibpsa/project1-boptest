within IDEAS.Buildings.Data.Glazing.Specialized;
record LowSHGC_Ar_natur1_366_34_3104 = IDEAS.Buildings.Data.Interfaces.Glazing
    (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.260;
10,0.261;
20,0.257;
30,0.251;
40,0.243;
50,0.229;
60,0.200;
70,0.145;
80,0.066;
90,0.000],
final SwAbs= [0,0.470, 0.0,0.052;
10,0.474, 0.0,0.053;
20,0.480, 0.0,0.053;
30,0.482, 0.0,0.054;
40,0.480, 0.0,0.055;
50,0.477, 0.0,0.055;
60,0.477, 0.0,0.053;
70,0.460, 0.0,0.047;
80,0.351, 0.0,0.033;
90,0.001, 0.0,0.000],final SwTransDif=0.200,
final SwAbsDif={0.477,0.0,0.053},
final U_value=1.43,
final g_value=0.275) "LowSHGC_Ar_natur1_366_34(U-design =1.43 g-design =0.275)
";
