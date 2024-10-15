within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonINFRASTOPBrilliant50256_16_6_12010 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.202;
10,0.202;
20,0.200;
30,0.199;
40,0.197;
50,0.194;
60,0.189;
70,0.168;
80,0.097;
90,0.000],
final SwAbs= [0,0.438, 0.0,0.036;
10,0.438, 0.0,0.036;
20,0.439, 0.0,0.037;
30,0.440, 0.0,0.038;
40,0.441, 0.0,0.039;
50,0.440, 0.0,0.041;
60,0.437, 0.0,0.045;
70,0.428, 0.0,0.048;
80,0.389, 0.0,0.044;
90,0.000, 0.0,0.000],final SwTransDif=0.189,
final SwAbsDif={0.437,0.0,0.045},
final U_value=1.08,
final g_value=0.250) "PilkingtonINFRASTOPBrilliant50256_16_6(U-design =1.08 g-design =0.250)
";
