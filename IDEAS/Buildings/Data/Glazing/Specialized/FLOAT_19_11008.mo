within IDEAS.Buildings.Data.Glazing.Specialized;
record FLOAT_19_11008 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.019, epsLw_b=0.4)},final SwTrans=[0,0.600;
10,0.598;
20,0.594;
30,0.585;
40,0.571;
50,0.547;
60,0.504;
70,0.418;
80,0.241;
90,0.000],
final SwAbs= [0,0.330;
10,0.332;
20,0.336;
30,0.344;
40,0.353;
50,0.363;
60,0.370;
70,0.363;
80,0.315;
90,0.000],final SwTransDif=0.504,
final SwAbsDif={0.370},
final U_value=5.77,
final g_value=0.597) "FLOAT_19(U-design =5.77 g-design =0.597)
";
