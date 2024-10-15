within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonOPTITHERMCoating24_16_4_12002 =
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
final SwAbs= [0,0.177, 0.0,0.069;
10,0.178, 0.0,0.070;
20,0.179, 0.0,0.071;
30,0.182, 0.0,0.073;
40,0.185, 0.0,0.075;
50,0.189, 0.0,0.078;
60,0.194, 0.0,0.079;
70,0.200, 0.0,0.076;
80,0.196, 0.0,0.059;
90,0.000, 0.0,0.000],final SwTransDif=0.439,
final SwAbsDif={0.194,0.0,0.079},
final U_value=1.31,
final g_value=0.516) "PilkingtonOPTITHERMCoating24_16_4(U-design =1.31 g-design =0.516)
";
