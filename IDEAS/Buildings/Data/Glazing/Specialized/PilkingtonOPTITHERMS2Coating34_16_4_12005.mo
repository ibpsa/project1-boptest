within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonOPTITHERMS2Coating34_16_4_12005 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.387;
10,0.386;
20,0.385;
30,0.383;
40,0.380;
50,0.375;
60,0.362;
70,0.316;
80,0.178;
90,0.000],
final SwAbs= [0,0.142, 0.0,0.160;
10,0.143, 0.0,0.160;
20,0.146, 0.0,0.160;
30,0.150, 0.0,0.160;
40,0.155, 0.0,0.159;
50,0.161, 0.0,0.156;
60,0.166, 0.0,0.147;
70,0.167, 0.0,0.125;
80,0.160, 0.0,0.081;
90,0.000, 0.0,0.000],final SwTransDif=0.362,
final SwAbsDif={0.166,0.0,0.147},
final U_value=1.06,
final g_value=0.497) "PilkingtonOPTITHERMS2Coating34_16_4(U-design =1.06 g-design =0.497)
";
