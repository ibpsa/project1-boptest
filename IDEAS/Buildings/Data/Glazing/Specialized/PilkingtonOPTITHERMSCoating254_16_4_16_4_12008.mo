within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonOPTITHERMSCoating254_16_4_16_4_12008 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=5,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.358;
10,0.358;
20,0.354;
30,0.350;
40,0.344;
50,0.330;
60,0.296;
70,0.221;
80,0.095;
90,0.000],
final SwAbs= [0,0.146, 0.0,0.078, 0.0,0.056;
10,0.146, 0.0,0.079, 0.0,0.057;
20,0.147, 0.0,0.080, 0.0,0.058;
30,0.148, 0.0,0.083, 0.0,0.058;
40,0.150, 0.0,0.086, 0.0,0.058;
50,0.153, 0.0,0.091, 0.0,0.056;
60,0.158, 0.0,0.097, 0.0,0.055;
70,0.164, 0.0,0.103, 0.0,0.049;
80,0.162, 0.0,0.093, 0.0,0.026;
90,0.000, 0.0,0.000, 0.0,0.000],final SwTransDif=0.296,
final SwAbsDif={0.158,0.0,0.097,0.0,0.055},
final U_value=0.78,
final g_value=0.398) "PilkingtonOPTITHERMSCoating254_16_4_16_4(U-design =0.78 g-design =0.398)
";
