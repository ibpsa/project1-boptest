within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPASOLblue40236_16_4_14009 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.190;
10,0.191;
20,0.188;
30,0.185;
40,0.180;
50,0.171;
60,0.151;
70,0.112;
80,0.054;
90,0.000],
final SwAbs= [0,0.512, 0.0,0.008;
10,0.517, 0.0,0.008;
20,0.521, 0.0,0.008;
30,0.522, 0.0,0.008;
40,0.518, 0.0,0.009;
50,0.513, 0.0,0.009;
60,0.505, 0.0,0.009;
70,0.474, 0.0,0.008;
80,0.350, 0.0,0.006;
90,0.002, 0.0,0.000],final SwTransDif=0.151,
final SwAbsDif={0.505,0.0,0.009},
final U_value=1.22,
final g_value=0.188) "InterpaneIPASOLblue40236_16_4(U-design =1.22 g-design =0.188)
";
