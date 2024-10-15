within IDEAS.Buildings.Data.Glazing.Specialized;
record FLOAT_15_11007 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.015, epsLw_b=0.4)},final SwTrans=[0,0.650;
10,0.649;
20,0.644;
30,0.636;
40,0.622;
50,0.599;
60,0.554;
70,0.461;
80,0.268;
90,0.000],
final SwAbs= [0,0.280;
10,0.281;
20,0.286;
30,0.293;
40,0.302;
50,0.311;
60,0.318;
70,0.316;
80,0.279;
90,0.000],final SwTransDif=0.554,
final SwAbsDif={0.318},
final U_value=5.85,
final g_value=0.635) "FLOAT_15(U-design =5.85 g-design =0.635)
";
