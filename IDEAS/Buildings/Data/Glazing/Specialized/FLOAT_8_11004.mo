within IDEAS.Buildings.Data.Glazing.Specialized;
record FLOAT_8_11004 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.008, epsLw_b=0.4)},final SwTrans=[0,0.750;
10,0.749;
20,0.746;
30,0.739;
40,0.727;
50,0.704;
60,0.657;
70,0.553;
80,0.328;
90,0.000],
final SwAbs= [0,0.180;
10,0.181;
20,0.184;
30,0.189;
40,0.196;
50,0.204;
60,0.211;
70,0.213;
80,0.198;
90,0.000],final SwTransDif=0.657,
final SwAbsDif={0.211},
final U_value=5.96,
final g_value=0.712) "FLOAT_8(U-design =5.96 g-design =0.712)
";
