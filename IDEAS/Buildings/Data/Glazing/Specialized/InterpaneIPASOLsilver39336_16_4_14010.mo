within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPASOLsilver39336_16_4_14010 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.294;
10,0.296;
20,0.292;
30,0.286;
40,0.279;
50,0.264;
60,0.232;
70,0.170;
80,0.080;
90,0.000],
final SwAbs= [0,0.359, 0.0,0.022;
10,0.362, 0.0,0.022;
20,0.368, 0.0,0.022;
30,0.371, 0.0,0.023;
40,0.370, 0.0,0.023;
50,0.370, 0.0,0.023;
60,0.375, 0.0,0.023;
70,0.370, 0.0,0.020;
80,0.291, 0.0,0.015;
90,0.002, 0.0,0.000],final SwTransDif=0.232,
final SwAbsDif={0.375,0.0,0.023},
final U_value=1.34,
final g_value=0.274) "InterpaneIPASOLsilver39336_16_4(U-design =1.34 g-design =0.274)
";
