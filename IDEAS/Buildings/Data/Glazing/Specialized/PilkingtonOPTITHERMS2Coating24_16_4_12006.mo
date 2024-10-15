within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonOPTITHERMS2Coating24_16_4_12006 =
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
final SwAbs= [0,0.196, 0.0,0.052;
10,0.197, 0.0,0.052;
20,0.197, 0.0,0.053;
30,0.198, 0.0,0.055;
40,0.200, 0.0,0.057;
50,0.202, 0.0,0.061;
60,0.204, 0.0,0.065;
70,0.208, 0.0,0.069;
80,0.203, 0.0,0.062;
90,0.000, 0.0,0.000],final SwTransDif=0.362,
final SwAbsDif={0.204,0.0,0.065},
final U_value=1.02,
final g_value=0.427) "PilkingtonOPTITHERMS2Coating24_16_4(U-design =1.02 g-design =0.427)
";
