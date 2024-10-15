within IDEAS.Buildings.Data.Glazing.Specialized;
record SaintGobainPLANISOLBlue53396_16_6_13009 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.322;
10,0.323;
20,0.318;
30,0.311;
40,0.301;
50,0.284;
60,0.247;
70,0.179;
80,0.081;
90,0.000],
final SwAbs= [0,0.380, 0.0,0.057;
10,0.384, 0.0,0.058;
20,0.390, 0.0,0.058;
30,0.394, 0.0,0.059;
40,0.393, 0.0,0.060;
50,0.394, 0.0,0.061;
60,0.401, 0.0,0.059;
70,0.398, 0.0,0.051;
80,0.315, 0.0,0.037;
90,0.001, 0.0,0.000],final SwTransDif=0.247,
final SwAbsDif={0.401,0.0,0.059},
final U_value=1.17,
final g_value=0.319) "SaintGobainPLANISOLBlue53396_16_6(U-design =1.17 g-design =0.319)
";
