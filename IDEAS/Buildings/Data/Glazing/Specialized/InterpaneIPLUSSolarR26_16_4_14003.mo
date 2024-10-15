within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPLUSSolarR26_16_4_14003 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.330;
10,0.331;
20,0.327;
30,0.320;
40,0.312;
50,0.295;
60,0.258;
70,0.188;
80,0.088;
90,0.000],
final SwAbs= [0,0.413, 0.0,0.022;
10,0.417, 0.0,0.022;
20,0.424, 0.0,0.022;
30,0.427, 0.0,0.022;
40,0.426, 0.0,0.023;
50,0.426, 0.0,0.023;
60,0.432, 0.0,0.022;
70,0.425, 0.0,0.020;
80,0.333, 0.0,0.015;
90,0.002, 0.0,0.000],final SwTransDif=0.258,
final SwAbsDif={0.432,0.0,0.022},
final U_value=1.28,
final g_value=0.304) "InterpaneIPLUSSolarR26_16_4(U-design =1.28 g-design =0.304)
";
