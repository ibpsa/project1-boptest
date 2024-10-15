within IDEAS.Buildings.Data.Glazing.Specialized;
record FLOAT_4_11001 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.820;
10,0.819;
20,0.817;
30,0.812;
40,0.802;
50,0.780;
60,0.732;
70,0.621;
80,0.375;
90,0.000],
final SwAbs= [0,0.110;
10,0.111;
20,0.113;
30,0.116;
40,0.121;
50,0.126;
60,0.132;
70,0.135;
80,0.130;
90,0.000],final SwTransDif=0.732,
final SwAbsDif={0.132},
final U_value=5.98,
final g_value=0.767) "FLOAT_4(U-design =5.98 g-design =0.767)
";
