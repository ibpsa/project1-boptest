within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonOPTITHERMCoating34_16_4_12001 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.516;
10,0.515;
20,0.513;
30,0.508;
40,0.498;
50,0.479;
60,0.439;
70,0.348;
80,0.170;
90,0.000],
final SwAbs= [0,0.129, 0.0,0.141;
10,0.130, 0.0,0.142;
20,0.132, 0.0,0.142;
30,0.136, 0.0,0.143;
40,0.142, 0.0,0.144;
50,0.148, 0.0,0.142;
60,0.155, 0.0,0.136;
70,0.162, 0.0,0.118;
80,0.163, 0.0,0.080;
90,0.000, 0.0,0.000],final SwTransDif=0.439,
final SwAbsDif={0.155,0.0,0.136},
final U_value=1.34,
final g_value=0.561) "PilkingtonOPTITHERMCoating34_16_4(U-design =1.34 g-design =0.561)
";
