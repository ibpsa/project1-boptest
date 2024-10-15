within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPASOLneutral52296_16_4_14008 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.245;
10,0.246;
20,0.243;
30,0.238;
40,0.232;
50,0.220;
60,0.193;
70,0.141;
80,0.066;
90,0.000],
final SwAbs= [0,0.453, 0.0,0.010;
10,0.457, 0.0,0.010;
20,0.462, 0.0,0.010;
30,0.464, 0.0,0.011;
40,0.462, 0.0,0.011;
50,0.459, 0.0,0.011;
60,0.457, 0.0,0.011;
70,0.437, 0.0,0.010;
80,0.332, 0.0,0.007;
90,0.002, 0.0,0.000],final SwTransDif=0.193,
final SwAbsDif={0.457,0.0,0.011},
final U_value=1.18,
final g_value=0.229) "InterpaneIPASOLneutral52296_16_4(U-design =1.18 g-design =0.229)
";
