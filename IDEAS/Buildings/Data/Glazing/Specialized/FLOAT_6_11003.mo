within IDEAS.Buildings.Data.Glazing.Specialized;
record FLOAT_6_11003 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.790;
10,0.789;
20,0.786;
30,0.781;
40,0.770;
50,0.747;
60,0.699;
70,0.591;
80,0.355;
90,0.000],
final SwAbs= [0,0.140;
10,0.141;
20,0.143;
30,0.148;
40,0.153;
50,0.160;
60,0.166;
70,0.169;
80,0.160;
90,0.000],final SwTransDif=0.699,
final SwAbsDif={0.166},
final U_value=5.96,
final g_value=0.743) "FLOAT_6(U-design =5.96 g-design =0.743)
";
