within IDEAS.Buildings.Data.Glazing.Specialized;
record SaintGobainPLANISOLNeutral66386_16_6_13008 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.325;
10,0.327;
20,0.321;
30,0.314;
40,0.305;
50,0.288;
60,0.252;
70,0.185;
80,0.086;
90,0.000],
final SwAbs= [0,0.326, 0.0,0.058;
10,0.329, 0.0,0.058;
20,0.336, 0.0,0.059;
30,0.340, 0.0,0.059;
40,0.340, 0.0,0.061;
50,0.340, 0.0,0.061;
60,0.348, 0.0,0.060;
70,0.348, 0.0,0.053;
80,0.277, 0.0,0.039;
90,0.001, 0.0,0.000],final SwTransDif=0.252,
final SwAbsDif={0.348,0.0,0.060},
final U_value=1.12,
final g_value=0.321) "SaintGobainPLANISOLNeutral66386_16_6(U-design =1.12 g-design =0.321)
";
