within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPASOLsilver53396_16_4_14011 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.354;
10,0.357;
20,0.351;
30,0.345;
40,0.336;
50,0.318;
60,0.280;
70,0.207;
80,0.099;
90,0.000],
final SwAbs= [0,0.301, 0.0,0.024;
10,0.304, 0.0,0.024;
20,0.311, 0.0,0.024;
30,0.315, 0.0,0.024;
40,0.315, 0.0,0.025;
50,0.317, 0.0,0.025;
60,0.326, 0.0,0.025;
70,0.330, 0.0,0.022;
80,0.267, 0.0,0.017;
90,0.002, 0.0,0.000],final SwTransDif=0.280,
final SwAbsDif={0.326,0.0,0.025},
final U_value=1.32,
final g_value=0.321) "InterpaneIPASOLsilver53396_16_4(U-design =1.32 g-design =0.321)
";
