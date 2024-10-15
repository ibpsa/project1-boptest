within IDEAS.Buildings.Data.Glazing.Specialized;
record FLOAT_12_11006 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.012, epsLw_b=0.4)},final SwTrans=[0,0.690;
10,0.689;
20,0.685;
30,0.677;
40,0.664;
50,0.640;
60,0.594;
70,0.497;
80,0.291;
90,0.000],
final SwAbs= [0,0.240;
10,0.241;
20,0.245;
30,0.251;
40,0.260;
50,0.269;
60,0.276;
70,0.276;
80,0.248;
90,0.000],final SwTransDif=0.594,
final SwAbsDif={0.276},
final U_value=5.91,
final g_value=0.666) "FLOAT_12(U-design =5.91 g-design =0.666)
";
