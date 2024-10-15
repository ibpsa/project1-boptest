within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonOPTITHERMSCoating24_16_4_12004 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.485;
10,0.485;
20,0.483;
30,0.480;
40,0.474;
50,0.462;
60,0.434;
70,0.361;
80,0.189;
90,0.000],
final SwAbs= [0,0.135, 0.0,0.065;
10,0.136, 0.0,0.066;
20,0.136, 0.0,0.067;
30,0.138, 0.0,0.069;
40,0.140, 0.0,0.071;
50,0.142, 0.0,0.075;
60,0.146, 0.0,0.078;
70,0.151, 0.0,0.079;
80,0.152, 0.0,0.066;
90,0.000, 0.0,0.000],final SwTransDif=0.434,
final SwAbsDif={0.146,0.0,0.078},
final U_value=1.11,
final g_value=0.508) "PilkingtonOPTITHERMSCoating24_16_4(U-design =1.11 g-design =0.508)
";
