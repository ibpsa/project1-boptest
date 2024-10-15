within IDEAS.Buildings.Data.Glazing.Specialized;
record LowSHGC_Ar_silber1_338_30_3002 = IDEAS.Buildings.Data.Interfaces.Glazing
    (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.226;
10,0.227;
20,0.223;
30,0.218;
40,0.211;
50,0.199;
60,0.173;
70,0.125;
80,0.056;
90,0.000],
final SwAbs= [0,0.520, 0.0,0.045;
10,0.525, 0.0,0.046;
20,0.530, 0.0,0.046;
30,0.532, 0.0,0.047;
40,0.529, 0.0,0.048;
50,0.525, 0.0,0.048;
60,0.521, 0.0,0.046;
70,0.496, 0.0,0.040;
80,0.373, 0.0,0.028;
90,0.001, 0.0,0.000],final SwTransDif=0.173,
final SwAbsDif={0.521,0.0,0.046},
final U_value=1.45,
final g_value=0.246) "LowSHGC_Ar_silber1_338_30(U-design =1.45 g-design =0.246)
";
